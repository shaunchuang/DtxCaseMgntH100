package demo.freemarker.handler.restfulapi;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.WgAvailableSlotsAPI;
import demo.freemarker.api.WgTaskAPI;
import demo.freemarker.model.WgAvailableSlots;
import demo.freemarker.model.WgTask;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.json.JSONObject;

public class WgTaskRESTfulAPI extends RESTfulAPI {
    public WgTaskRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/WgTask/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                WgTaskAPI.getInstance().getName(),
                WgTaskAPI.getInstance().getVersion(),
                WgTaskAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(WgTask.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有任務")
    private String list(HttpExchange exchange) throws IOException {
        List<WgTask> tasks = WgTaskAPI.getInstance().listWgTask();
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(tasks);
    }

    @RESTfulAPIDefine(url = "checkin", methods = "post", description = "更新報到時間")
    private String checkin(HttpExchange exchange) throws IOException {
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        JSONObject responseBody = new JSONObject();
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject jsonRequest = new JSONObject(requestBody);
            if (!jsonRequest.has("slotId")) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, -1);
                return null;
            }
    
            Date checkinOnlyTime = sdf.parse(sdf.format(new Date()));
            Long slotId = jsonRequest.getLong("slotId");
    
            WgTask wgTask = WgTaskAPI.getInstance().getWgTask(slotId);
            wgTask.setCheckinTime(checkinOnlyTime);
            WgTaskAPI.getInstance().updateWgTask(wgTask);
    
            responseBody.put("success", Boolean.TRUE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseBody.toString();
        } catch (Exception e) {
            e.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, -1);
            return null;
        }
    }

    @RESTfulAPIDefine(url = "createNewAppo", methods = "post", description = "建立預約")
    private String createNewAppo(HttpExchange exchange) throws IOException {
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        JSONObject responseBody = new JSONObject();
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject jsonRequest = new JSONObject(requestBody);

            //{"userId": doctorId, "slotId": slotId, "cat": 2, "caseno": "${formId!""}"};
            Long availableSlotId = jsonRequest.getLong("slotId");
            Long caseNo = jsonRequest.getLong("caseno");
            Long cat = jsonRequest.getLong("cat");
            Long creatorId = jsonRequest.getLong("userId");

            WgTask wgTask = new WgTask(new Date(), new Date(), creatorId, creatorId, false, cat.intValue(), caseNo, null, null, availableSlotId, null);
            WgTaskAPI.getInstance().createWgTask(wgTask);

            WgAvailableSlots slot = WgAvailableSlotsAPI.getInstance().getWgAvailableSlot(availableSlotId);
            slot.setIsBooked(true);
            WgAvailableSlotsAPI.getInstance().updateWgAvailableSlot(slot);
            // === 建議在 Slot 物件裡就改用 LocalDate / LocalTime ===
            LocalDate  date = slot.getSlotDate()        // 若型別仍是 java.util.Date
                                .toInstant()
                                .atZone(ZoneId.systemDefault())
                                .toLocalDate();

            LocalTime  time = slot.getSlotBeginTime()   // 同上
                                .toInstant()
                                .atZone(ZoneId.systemDefault())
                                .toLocalTime();

            // 1) 日期  2) 星期  3) 時間
            DateTimeFormatter df  = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            DateTimeFormatter tf  = DateTimeFormatter.ofPattern("HH:mm");

            // 取得中文星期 (例：星期三)
            String zhWeek = date.getDayOfWeek()
                                .getDisplayName(TextStyle.FULL, Locale.TAIWAN);
            // 組字串
            String slotTime = String.format("%s - %s - %s",
                                            df.format(date),
                                            zhWeek,
                                            tf.format(time));
            // 塞進回應
            responseBody.put("slotTime", slotTime);
            responseBody.put("success", Boolean.TRUE);
            responseBody.put("slotTime", slotTime);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseBody.toString();
        } catch (Exception e) {
            e.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, -1);
            return null;
        }
    }
}
