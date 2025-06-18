package demo.freemarker.handler.restfulapi;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.WgIcdCodeAPI;
import demo.freemarker.model.WgIcdCode;
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
 * @author zhush
 */
public class WgIcdCodeRESTfulAPI extends RESTfulAPI {
    public WgIcdCodeRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/WgIcdCode/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                WgIcdCodeAPI.getInstance().getName(),
                WgIcdCodeAPI.getInstance().getVersion(),
                WgIcdCodeAPI.getInstance().getDescription());
        //
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(WgIcdCode.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有ICD碼")
    private String list(HttpExchange exchange) throws IOException {
        List<WgIcdCode> icdCodes = WgIcdCodeAPI.getInstance().listWgIcdCode();

        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(icdCodes);
    }
    
    @RESTfulAPIDefine(url = "search", methods = "post", description = "根據ICD碼搜尋")
    private String searchByCode(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
        String code = new JSONObject(requestBody).getString("code");

        List<WgIcdCode> icdCodes = WgIcdCodeAPI.getInstance().searchByPureCode(code);
        List<ICDCodeInfo> icdCodeInfos = new ArrayList<>();
        if(icdCodes != null && icdCodes.size() > 0) {
            for(WgIcdCode icdCode : icdCodes){
                ICDCodeInfo icdCodeInfo = new ICDCodeInfo(icdCode.getId().toString(), icdCode.getCode() + " " + icdCode.getName());
                icdCodeInfos.add(icdCodeInfo);
            }
            responseJson.put("icdCodes", icdCodeInfos);
        } else {
            responseJson.put("message", "No ICD codes found.");
            responseJson.put("success", true);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        }
        
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    	//ICD-10診斷碼資訊
	public static class ICDCodeInfo{
		public String id;
		public String text = "";
		
		public ICDCodeInfo(String id, String text){
			this.id = id;
			this.text = text;
		}

		public String getId() {
			return id;
		}

		public String getText() {
			return text;
		}		
		
	}
}
