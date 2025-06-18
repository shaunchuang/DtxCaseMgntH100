package demo.freemarker.handler.restfulapi.scale;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.scale.ScaleAPI;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.core.SecurityUtils;
import demo.freemarker.core.StringUtils;
import demo.freemarker.dto.ScalesInfo;
import demo.freemarker.dto.SearchInfo;
import demo.freemarker.model.User;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;
import demo.freemarker.model.scale.Scale;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;
import org.json.JSONObject;

public class ScaleRESTfulAPI extends RESTfulAPI {

    public ScaleRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/Scale/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "Get Scale Info")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                ScaleAPI.getInstance().getName(),
                ScaleAPI.getInstance().getVersion(),
                ScaleAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(Scale.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "取得所有 Scale 資料")
    private String list(HttpExchange exchange) throws IOException {
        List<Scale> scales = new ArrayList<>();
        try {
            scales = ScaleAPI.getInstance().listScales();

        } catch (Exception ex) {
            ex.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(scales);
    }

    @RESTfulAPIDefine(url = "qryScalesList", methods = "post", description = "取得所有 Scale 資料")
    private String qryScalesList(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        User currentUser = SecurityUtils.getCurrentUser(exchange);
        Locale locale = SecurityUtils.getLocale(exchange);
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
        List<Scale> scales = new ArrayList<>();
        Date evalDate = new Date();
        JSONObject requestJson = new JSONObject(requestBody);
        try {
            SearchInfo searchInfo = GsonUtil.fromJson(requestBody, SearchInfo.class);
            if (StringUtils.isEmpty(searchInfo.getParam())) {
                if (searchInfo.getPatientId() == null) {
                    scales = ScaleAPI.getInstance().listSortByCat(false);
                } else {
                    List<Long> scaleIds = ScaleAPI.getInstance().listTodateAddScaleId(searchInfo.getPatientId(), evalDate);
                    scales = ScaleAPI.getInstance().listScalesByIdsAndDate(scaleIds, false);
                }
            } else {
                String paramStr = convertValue(searchInfo.getParam());
                scales = ScaleAPI.getInstance().listScalesByParam(paramStr);
            }
            int totalSize = scales.size();
            if (scales.size() > 0) {
                int pageSize = Integer.parseInt(searchInfo.getLimit());
                int pageIndex = searchInfo.getPage_num();
                int startIndex = (pageIndex - 1) * pageSize;
                int lastIndex = pageIndex * pageSize;
                if (lastIndex > totalSize) {
                    lastIndex = totalSize;
                }
                scales = scales.subList(startIndex, lastIndex);
            } else {
                scales = new ArrayList<>();
            }

            List<ScalesInfo> scalesInfos = scales.stream().map(scalesItem -> new ScalesInfo(scalesItem, locale)).collect(Collectors.toList());

            responseJson.put("success", Boolean.TRUE);
            responseJson.put("data", scalesInfos);
            responseJson.put("num", totalSize);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        } catch (Exception ex) {
            ex.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
    }

    public String convertValue(String value) {
        String returnValue = "";
        if (!StringUtils.isEmpty(value)) {
            Boolean isMessyCode = java.nio.charset.Charset.forName("GBK").newEncoder().canEncode(value);
            if (!isMessyCode) {
                try {
                    value = new String(value.getBytes("ISO8859_1"), "UTF-8");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            returnValue = value;
        }
        return returnValue;
    }
}
