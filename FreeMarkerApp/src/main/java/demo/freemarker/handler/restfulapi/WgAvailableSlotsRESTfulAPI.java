package demo.freemarker.handler.restfulapi;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.WgAvailableSlotsAPI;
import demo.freemarker.model.WgAvailableSlots;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONObject;

public class WgAvailableSlotsRESTfulAPI extends RESTfulAPI {

    public WgAvailableSlotsRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/WgAvailableSlots/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                WgAvailableSlotsAPI.getInstance().getName(),
                WgAvailableSlotsAPI.getInstance().getVersion(),
                WgAvailableSlotsAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(WgAvailableSlots.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有可用時段")
    private String list(HttpExchange exchange) throws IOException {
        List<WgAvailableSlots> slots = WgAvailableSlotsAPI.getInstance().listWgAvailableSlots();
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(slots);
    }

    @RESTfulAPIDefine(url = "qry", methods = "post", description = "查詢可用時段")
    private String qryAvailableSlots(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);

        JSONObject json = new JSONObject(requestBody);
        String date = json.getString("beginDate");
        Long doctorId = json.getLong("doctor");

        LocalDate startDate = LocalDate.parse(date);
        LocalDate endDate = startDate.plusDays(6);
        Date startUtilDate = java.sql.Date.valueOf(startDate);
        Date endUtilDate = java.sql.Date.valueOf(endDate);


        List<WgAvailableSlots> slotList = WgAvailableSlotsAPI.getInstance().findAvailableSlotsByDoctorAndDateRange(doctorId, startUtilDate, endUtilDate);
        
        // 格式化時間，只顯示時分
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        
        List<List<Map<String, Object>>> groupedSlots = this.groupSlotsByDateRange(slotList, startDate, endDate, timeFormatter);

        responseJson.put("success", true);
        responseJson.put("slots", groupedSlots);

        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    public List<List<Map<String, Object>>> groupSlotsByDateRange(List<WgAvailableSlots> slots, LocalDate startDate, LocalDate endDate, DateTimeFormatter timeFormatter) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        Map<String, List<Map<String, Object>>> dateSlotMap = new LinkedHashMap<>();

        // 初始化每一天為空列表
        for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
            String key = date.format(formatter);
            dateSlotMap.put(key, new ArrayList<>());
        }

        for (WgAvailableSlots slot : slots) {
            LocalDate slotDate = slot.getSlotDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            String key = slotDate.format(formatter);

            if (dateSlotMap.containsKey(key)) {
                Map<String, Object> slotMap = new HashMap<>();
                slotMap.put("id", slot.getId());
                // 使用 LocalTime 並格式化為 HH:mm
                LocalTime lt = slot.getSlotBeginTime().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
                slotMap.put("time", lt.format(timeFormatter));
                dateSlotMap.get(key).add(slotMap);
            }
        }

        for (List<Map<String, Object>> times : dateSlotMap.values()) {
            times.sort(Comparator.comparing(m -> (String) m.get("time")));
        }

        return new ArrayList<>(dateSlotMap.values());
    }

}
