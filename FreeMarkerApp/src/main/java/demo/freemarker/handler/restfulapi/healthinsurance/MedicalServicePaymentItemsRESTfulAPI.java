package demo.freemarker.handler.restfulapi.healthinsurance;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.healthinsurance.MedicalServicePaymentItemsAPI;
import demo.freemarker.model.healthinsurance.MedicalServicePaymentItems;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

/**
 *
 * @author user
 */
public class MedicalServicePaymentItemsRESTfulAPI extends RESTfulAPI {
    public MedicalServicePaymentItemsRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/MedicalServicePaymentItems/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                MedicalServicePaymentItemsAPI.getInstance().getName(),
                MedicalServicePaymentItemsAPI.getInstance().getVersion(),
                MedicalServicePaymentItemsAPI.getInstance().getDescription());
        //
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(MedicalServicePaymentItems.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有醫療服務支付項目")
    private String list(HttpExchange exchange) throws IOException {
        List<MedicalServicePaymentItems> items = MedicalServicePaymentItemsAPI.getInstance().listMedicalServicePaymentItems();

        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(items);
    }
    
    @RESTfulAPIDefine(url = "search", methods = "post", description = "根據代碼搜尋醫療服務支付項目")
    private String searchByCode(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
        String code = new JSONObject(requestBody).getString("code");
        
        List<MedicalServicePaymentItems> items = MedicalServicePaymentItemsAPI.getInstance().searchByCode(code);
        List<PaymentItemInfo> itemInfos = new ArrayList<>();
        
        if(items.size() > 0) {
            for(MedicalServicePaymentItems item : items) {
                PaymentItemInfo itemInfo = new PaymentItemInfo(item.getId().toString(), item.getCode() + " " + item.getZhItem());
                itemInfos.add(itemInfo);
            }
            responseJson.put("paymentItems", itemInfos);
        } else {
            responseJson.put("message", "No payment items found.");
            responseJson.put("success", true);
        }
        
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }
    
    @RESTfulAPIDefine(url = "searchByItem", methods = "post", description = "根據名稱搜尋醫療服務支付項目")
    private String searchByItem(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
        String item = new JSONObject(requestBody).getString("item");
        
        List<MedicalServicePaymentItems> items = MedicalServicePaymentItemsAPI.getInstance().searchByItem(item);
        List<PaymentItemInfo> itemInfos = new ArrayList<>();
        
        if(items.size() > 0) {
            for(MedicalServicePaymentItems paymentItem : items) {
                PaymentItemInfo itemInfo = new PaymentItemInfo(paymentItem.getId().toString(), paymentItem.getCode() + " " + paymentItem.getZhItem());
                itemInfos.add(itemInfo);
            }
            responseJson.put("paymentItems", itemInfos);
        } else {
            responseJson.put("message", "No payment items found.");
            responseJson.put("success", true);
        }
        
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    @RESTfulAPIDefine(url = "searchByCodeAndItem", methods = "post", description = "根據代碼和名稱搜尋醫療服務支付項目")
    private String searchByCodeAndItem(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
        String code = new JSONObject(requestBody).getString("code");
        List<MedicalServicePaymentItems> items = MedicalServicePaymentItemsAPI.getInstance().searchByCodeAndItem(code, code);
        List<PaymentItemInfo> itemInfos = new ArrayList<>();
        if(items.size() > 0) {
            for(MedicalServicePaymentItems paymentItem : items) {
                String id = paymentItem.getCode();
                String text = "[" + paymentItem.getCode() + "] " + paymentItem.getZhItem();
                Integer points = paymentItem.getPoints();
                PaymentItemInfo itemInfo = new PaymentItemInfo(id, text, 1, points);
                itemInfos.add(itemInfo);
            }
            responseJson.put("paymentItems", itemInfos);
        } else {
            responseJson.put("message", "No payment items found.");
            responseJson.put("success", true);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        }
        
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }
    
    //醫療服務支付項目資訊
    public static class PaymentItemInfo{
        public String id;
        public String text = "";
        public Integer amount = 1;
        public Integer points = 0;
        
        public PaymentItemInfo(String id, String text){
            this.id = id;
            this.text = text;
        }

        public PaymentItemInfo(String id, String text, Integer amount, Integer points){
            this.id = id;
            this.text = text;
            this.amount = amount;
            this.points = points;
        }

        public String getId() {
            return id;
        }

        public String getText() {
            return text;
        }
        
        public Integer getAmount() {
			return amount;
		}
		
		public Integer getPoints() {
			return points;
		}

        public void setId(String id) {
            this.id = id;
        }

        public void setText(String text) {
            this.text = text;
        }
        
        public void setAmount(Integer amount) {
            this.amount = amount;
        }
        
        public void setPoints(Integer points) {
            this.points = points;
            
        }
    }
}