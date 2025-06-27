package demo.freemarker.handler.restfulapi.chat;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.chat.ChatAPI;
import demo.freemarker.core.SecurityUtils;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.model.User;
import demo.freemarker.model.chat.ChatRoom;
import demo.freemarker.model.chat.ChatMessage;
import demo.freemarker.model.chat.ChatRoomUser;
import demo.freemarker.api.UserAPI;
import demo.freemarker.api.PatientAPI;
import demo.freemarker.api.RoleAPI;
import demo.freemarker.api.healthinsurance.HealthInsuranceRecordAPI;
import demo.freemarker.dao.chat.ChatRoomDAO;
import demo.freemarker.dao.chat.ChatRoomUserDAO;
import demo.freemarker.model.Patient;
import demo.freemarker.model.Role;
import demo.freemarker.model.healthinsurance.HealthInsuranceRecord;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.api.RESTfulAPI.RESTfulAPIDefine;
import itri.sstc.framework.core.database.EntityUtility;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 * 聊天系統RESTful API
 * 提供聊天室建立、訊息發送、已讀狀態等功能
 * 
 * @author system
 */
public class ChatRESTfulAPI extends RESTfulAPI {

    private static final Logger LOGGER = Logger.getLogger(ChatRESTfulAPI.class.getName());

    public ChatRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/Chat/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                ChatAPI.getInstance().getName(),
                ChatAPI.getInstance().getVersion(),
                ChatAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(ChatRoom.class);
    }

    /**
     * 建立聊天室
     */
    @RESTfulAPIDefine(url = "createChatRoom", methods = "post", description = "建立聊天室")
    private String createChatRoom(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);

            String roomName = requestJson.getString("roomName");
            
            // 使用 ChatAPI 建立聊天室
            ChatRoom chatRoom = ChatAPI.getInstance().createChatRoom(roomName);
            
            // 將創建者加入聊天室
            ChatAPI.getInstance().addUserToChatRoom(chatRoom.getId(), currentUser.getId());

            responseJson.put("success", true);
            responseJson.put("chatRoom", GsonUtil.toJsonObject(chatRoom));
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "建立聊天室失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 加入聊天室
     */
    @RESTfulAPIDefine(url = "joinChatRoom", methods = "post", description = "加入聊天室")
    private String joinChatRoom(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);

            Long roomId = requestJson.getLong("roomId");
            
            // 使用 ChatAPI 加入聊天室
            boolean success = ChatAPI.getInstance().addUserToChatRoom(roomId, currentUser.getId());

            responseJson.put("success", success);
            if (success) {
                responseJson.put("message", "成功加入聊天室");
            } else {
                responseJson.put("message", "加入聊天室失敗");
            }
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "加入聊天室失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 發送訊息
     */
    @RESTfulAPIDefine(url = "sendMessage", methods = "post", description = "發送訊息")
    private String sendMessage(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            
            // 解析請求參數 - 支援兩種格式：直接JSON或data字段包裝
            JSONObject requestData;
            try {
                JSONObject fullRequest = new JSONObject(requestBody);
                if (fullRequest.has("data")) {
                    // 如果有data字段，解析其中的JSON字符串
                    String dataStr = fullRequest.getString("data");
                    requestData = new JSONObject(dataStr);
                } else {
                    // 直接使用根層級的JSON
                    requestData = fullRequest;
                }
            } catch (Exception e) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                responseJson.put("success", false);
                responseJson.put("message", "請求格式錯誤");
                return responseJson.toString();
            }

            // 支援兩種參數格式
            Long roomId;
            String content;
            String messageType = "TEXT";
            
            if (requestData.has("chatGroupId")) {
                // trainingQuestion.ftl 格式
                roomId = requestData.getLong("chatGroupId");
                content = requestData.getString("message");
            } else {
                // 標準格式
                roomId = requestData.getLong("roomId");
                content = requestData.getString("content");
                messageType = requestData.optString("messageType", "TEXT");
            }
            
            // 使用 ChatAPI 發送訊息
            ChatMessage message = ChatAPI.getInstance().sendMessage(
                roomId, currentUser.getId(), content, messageType);

            responseJson.put("success", true);
            responseJson.put("message", GsonUtil.toJsonObject(message));
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "發送訊息失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 載入聊天室列表
     */
    @RESTfulAPIDefine(url = "loadChatRooms", methods = "post", description = "載入聊天室列表")
    private String loadChatRooms(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            // 使用 ChatAPI 取得使用者的聊天室列表
            List<ChatRoom> chatRooms = ChatAPI.getInstance().getUserChatRooms(currentUser.getId());

            JSONArray roomsArray = new JSONArray();
            for (ChatRoom room : chatRooms) {
                roomsArray.put(GsonUtil.toJsonObject(room));
            }

            responseJson.put("success", true);
            responseJson.put("chatRooms", roomsArray);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "載入聊天室列表失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 載入聊天訊息
     */
    @RESTfulAPIDefine(url = "loadMessages", methods = "post", description = "載入聊天訊息")
    private String loadMessages(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);

            Long roomId = requestJson.getLong("roomId");
            int limit = requestJson.optInt("limit", 50);
            Long beforeMessageId = requestJson.optLong("beforeMessageId", 0);
            
            // 使用 ChatAPI 載入訊息
            List<ChatMessage> messages;
            if (beforeMessageId > 0) {
                messages = ChatAPI.getInstance().getMessagesBefore(roomId, beforeMessageId, limit);
            } else {
                messages = ChatAPI.getInstance().getRecentRoomMessages(roomId, currentUser.getId(), limit);
            }

            JSONArray messagesArray = new JSONArray();
            for (ChatMessage message : messages) {
                messagesArray.put(GsonUtil.toJsonObject(message));
            }

            responseJson.put("success", true);
            responseJson.put("messages", messagesArray);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "載入聊天訊息失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 標記訊息為已讀
     */
    @RESTfulAPIDefine(url = "markAsRead", methods = "post", description = "標記訊息為已讀")
    private String markAsRead(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);

            Long messageId = requestJson.getLong("messageId");
            
            // 使用 ChatAPI 標記為已讀
            boolean success = ChatAPI.getInstance().markMessageAsRead(messageId, currentUser.getId());

            responseJson.put("success", success);
            if (success) {
                responseJson.put("message", "訊息已標記為已讀");
            } else {
                responseJson.put("message", "標記失敗");
            }
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "標記訊息為已讀失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 載入或建立聊天室（主要用於個案與治療師的私聊）
     */
    @RESTfulAPIDefine(url = "loadChatRoom", methods = "post", description = "載入或建立聊天室")
    private String loadChatRoom(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                LOGGER.log(Level.WARNING, "未授權的聊天室存取請求");
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            LOGGER.log(Level.INFO, "loadChatRoom請求內容: " + requestBody);
            
            // 解析請求參數 - 直接解析JSON
            JSONObject requestData;
            try {
                requestData = new JSONObject(requestBody);
            } catch (Exception e) {
                LOGGER.log(Level.WARNING, "請求格式錯誤: " + requestBody, e);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                responseJson.put("success", false);
                responseJson.put("message", "請求格式錯誤");
                return responseJson.toString();
            }

            Long currentUserId = requestData.getLong("currentUserId");
            Long careUserId = requestData.getLong("careUserId");
            
            // 建立或取得私人聊天室
            ChatRoom chatRoom = ChatAPI.getInstance().getOrCreatePrivateChat(currentUserId, careUserId);
            
            // 載入聊天室訊息
            List<ChatMessage> messages = ChatAPI.getInstance().getRoomMessages(chatRoom.getId(), currentUserId);

            // 組裝回應
            responseJson.put("success", true);
            responseJson.put("ChatGroupId", chatRoom.getId());
            responseJson.put("roomName", chatRoom.getName());
            responseJson.put("roomType", "PRIVATE");
            
            JSONArray messagesArray = new JSONArray();
            for (ChatMessage message : messages) {
                JSONObject messageObj = new JSONObject();
                messageObj.put("id", message.getId());
                messageObj.put("userId", message.getSenderId());
                messageObj.put("content", message.getContent());
                messageObj.put("createTime", message.getCreatedAt().getTime());
                messageObj.put("messageType", "TEXT");
                messagesArray.put(messageObj);
            }
            responseJson.put("ChatMessages", messagesArray);
            
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "載入聊天室失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 建立私人聊天室
     */
    @RESTfulAPIDefine(url = "createPrivateChat", methods = "post", description = "建立私人聊天室")
    private String createPrivateChat(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);

            Long targetUserId = requestJson.getLong("targetUserId");
            
            // 使用 ChatAPI 建立私人聊天室
            ChatRoom chatRoom = ChatAPI.getInstance().createPrivateChat(
                currentUser.getId(), targetUserId);

            responseJson.put("success", true);
            responseJson.put("chatRoom", GsonUtil.toJsonObject(chatRoom));
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "建立私人聊天室失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 取得未讀訊息數量
     */
    @RESTfulAPIDefine(url = "getUnreadCount", methods = "post", description = "取得未讀訊息數量")
    private String getUnreadCount(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);

            Long roomId = requestJson.optLong("roomId", 0);
            
            // 使用 ChatAPI 取得未讀數量
            int unreadCount;
            if (roomId > 0) {
                unreadCount = ChatAPI.getInstance().getUnreadMessageCount(roomId, currentUser.getId());
            } else {
                unreadCount = ChatAPI.getInstance().getTotalUnreadCount(currentUser.getId());
            }

            responseJson.put("success", true);
            responseJson.put("unreadCount", unreadCount);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "取得未讀訊息數量失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 取得聊天室成員列表
     */
    @RESTfulAPIDefine(url = "getRoomMembers", methods = "post", description = "取得聊天室成員列表")
    private String getRoomMembers(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);

            Long roomId = requestJson.getLong("roomId");
            
            // 使用 ChatAPI 取得成員列表
            List<ChatRoomUser> members = ChatAPI.getInstance().getChatRoomMembers(roomId);

            JSONArray membersArray = new JSONArray();
            for (ChatRoomUser member : members) {
                membersArray.put(GsonUtil.toJsonObject(member));
            }

            responseJson.put("success", true);
            responseJson.put("members", membersArray);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "取得聊天室成員列表失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 離開聊天室
     */
    @RESTfulAPIDefine(url = "leaveChatRoom", methods = "post", description = "離開聊天室")
    private String leaveChatRoom(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);

            Long roomId = requestJson.getLong("roomId");
            
            // 使用 ChatAPI 離開聊天室
            boolean success = ChatAPI.getInstance().removeUserFromChatRoom(roomId, currentUser.getId());

            responseJson.put("success", success);
            if (success) {
                responseJson.put("message", "成功離開聊天室");
            } else {
                responseJson.put("message", "離開聊天室失敗");
            }
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "離開聊天室失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 獲取聊天室詳細資訊（包含最後訊息和未讀數量）
     */
    @RESTfulAPIDefine(url = "getChatRoomDetails", methods = "post", description = "獲取聊天室詳細資訊")
    private String getChatRoomDetails(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);

            Long roomId = requestJson.getLong("roomId");
            
            // 獲取聊天室基本資訊
            List<ChatRoom> userRooms = ChatAPI.getInstance().getUserChatRooms(currentUser.getId());
            ChatRoom chatRoom = userRooms.stream()
                .filter(room -> room.getId().equals(roomId))
                .findFirst()
                .orElse(null);
            if (chatRoom == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
                responseJson.put("success", false);
                responseJson.put("message", "聊天室不存在");
                return responseJson.toString();
            }

            // 獲取最後一則訊息
            List<ChatMessage> recentMessages = ChatAPI.getInstance().getRecentRoomMessages(roomId, currentUser.getId(), 1);
            String lastMessage = "";
            Long lastMessageTime = null;
            if (!recentMessages.isEmpty()) {
                ChatMessage lastMsg = recentMessages.get(0);
                lastMessage = lastMsg.getContent();
                lastMessageTime = lastMsg.getCreatedAt().getTime();
            }

            // 獲取未讀數量
            int unreadCount = ChatAPI.getInstance().getUnreadMessageCount(roomId, currentUser.getId());

            // 構建回應
            JSONObject roomDetails = new JSONObject();
            roomDetails.put("id", chatRoom.getId());
            roomDetails.put("name", chatRoom.getName());
            roomDetails.put("roomType", chatRoom.getRoomType());
            roomDetails.put("description", chatRoom.getDescription());
            roomDetails.put("lastMessage", lastMessage);
            roomDetails.put("lastMessageTime", lastMessageTime);
            roomDetails.put("unreadCount", unreadCount);

            responseJson.put("success", true);
            responseJson.put("chatRoom", roomDetails);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "獲取聊天室詳細資訊失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    /**
     * 獲取當前用戶資訊
     */
    @RESTfulAPIDefine(url = "getCurrentUser", methods = "get", description = "獲取當前用戶資訊") 
    private String getCurrentUser(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            if (currentUser == null) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
                responseJson.put("success", false);
                responseJson.put("message", "未授權");
                return responseJson.toString();
            }

            JSONObject userInfo = new JSONObject();
            userInfo.put("id", currentUser.getId());
            userInfo.put("name", currentUser.getUsername());
            userInfo.put("email", currentUser.getEmail());
            
            responseJson.put("success", true);
            responseJson.put("user", userInfo);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "獲取當前用戶資訊失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    // ==================== 自動群組建立功能 ====================

    @RESTfulAPIDefine(url = "createDoctorPatientGroup", methods = "post", description = "為醫師建立基於診斷過的病患的聊天群組")
    private String createDoctorPatientGroup(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);
            
            Long doctorId = requestJson.getLong("doctorId");
            
            // 驗證醫師存在性
            User doctor = UserAPI.getInstance().getUser(doctorId);
            if (doctor == null) {
                responseJson.put("success", false);
                responseJson.put("message", "醫師不存在");
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                return responseJson.toString();
            }

            // 檢查是否為醫師角色
            List<Role> roles = RoleAPI.getInstance().listRolesByUserId(doctorId);
            boolean isDoctor = roles.stream().anyMatch(role -> "DOCTOR".equals(role.getAlias()));
            if (!isDoctor) {
                responseJson.put("success", false);
                responseJson.put("message", "使用者不是醫師角色");
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                return responseJson.toString();
            }

            // 獲取醫師診斷過的所有病患
            List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().getDoctorVisitsByPatient(null);
            List<Patient> diagnosedPatients = records.stream()
                .filter(record -> doctorId.equals(record.getCreator()))
                .map(record -> {
                    try {
                        return PatientAPI.getInstance().getPatient(record.getPatientId());
                    } catch (Exception e) {
                        return null;
                    }
                })
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());

            if (diagnosedPatients.isEmpty()) {
                responseJson.put("success", false);
                responseJson.put("message", "該醫師尚未診斷過任何病患");
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                return responseJson.toString();
            }

            // 檢查是否已存在該醫師的自動群組
            String groupName = "醫師群組 - " + doctor.getUsername();
            ChatRoom existingRoom = findExistingAutoGroup(doctorId, "DOCTOR_PATIENTS");
            
            ChatRoom chatRoom;
            if (existingRoom != null) {
                // 更新現有群組成員
                updateGroupMembers(existingRoom, doctorId, diagnosedPatients);
                chatRoom = existingRoom;
                responseJson.put("message", "成功更新醫師病患群組");
            } else {
                // 創建新聊天群組
                chatRoom = new ChatRoom(
                    groupName,
                    "AUTO_GROUP",
                    "醫師 " + doctor.getUsername() + " 與其診斷過的病患的自動聊天群組",
                    doctorId
                );
                ChatRoomDAO.getInstance().save(chatRoom);

                // 添加醫師和病患到群組
                addMembersToGroup(chatRoom.getId(), doctorId, diagnosedPatients);
                responseJson.put("message", "成功建立醫師病患群組");
            }

            responseJson.put("success", true);
            responseJson.put("roomId", chatRoom.getId());
            responseJson.put("roomName", chatRoom.getName());
            responseJson.put("memberCount", diagnosedPatients.size() + 1);
            
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "建立醫師病患群組失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    @RESTfulAPIDefine(url = "createTherapistPatientGroup", methods = "post", description = "為治療師建立基於治療過的病患的聊天群組")
    private String createTherapistPatientGroup(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);
            
            Long therapistId = requestJson.getLong("therapistId");
            
            // 驗證治療師存在性
            User therapist = UserAPI.getInstance().getUser(therapistId);
            if (therapist == null) {
                responseJson.put("success", false);
                responseJson.put("message", "治療師不存在");
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                return responseJson.toString();
            }

            // 檢查是否為治療師角色
            List<Role> roles = RoleAPI.getInstance().listRolesByUserId(therapistId);
            boolean isTherapist = roles.stream().anyMatch(role -> 
                Arrays.asList("DTX_PSY", "DTX_ST", "DTX_OT", "DTX_PI").contains(role.getAlias()));
            if (!isTherapist) {
                responseJson.put("success", false);
                responseJson.put("message", "使用者不是治療師角色");
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                return responseJson.toString();
            }

            // 獲取治療師治療過的所有病患
            List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().getTherapistVisitsByPatient(null);
            List<Patient> treatedPatients = records.stream()
                .filter(record -> therapistId.equals(record.getCreator()))
                .map(record -> {
                    try {
                        return PatientAPI.getInstance().getPatient(record.getPatientId());
                    } catch (Exception e) {
                        return null;
                    }
                })
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());

            if (treatedPatients.isEmpty()) {
                responseJson.put("success", false);
                responseJson.put("message", "該治療師尚未治療過任何病患");
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                return responseJson.toString();
            }

            // 獲取治療類型
            String therapyType = getTherapyType(roles);
            String groupName = therapyType + "治療師群組 - " + therapist.getUsername();
            
            // 檢查是否已存在該治療師的自動群組
            ChatRoom existingRoom = findExistingAutoGroup(therapistId, "THERAPIST_PATIENTS");
            
            ChatRoom chatRoom;
            if (existingRoom != null) {
                // 更新現有群組成員
                updateGroupMembers(existingRoom, therapistId, treatedPatients);
                chatRoom = existingRoom;
                responseJson.put("message", "成功更新治療師病患群組");
            } else {
                // 創建新聊天群組
                chatRoom = new ChatRoom(
                    groupName,
                    "AUTO_GROUP",
                    therapyType + "治療師 " + therapist.getUsername() + " 與其治療過的病患的自動聊天群組",
                    therapistId
                );
                ChatRoomDAO.getInstance().save(chatRoom);

                // 添加治療師和病患到群組
                addMembersToGroup(chatRoom.getId(), therapistId, treatedPatients);
                responseJson.put("message", "成功建立治療師病患群組");
            }

            responseJson.put("success", true);
            responseJson.put("roomId", chatRoom.getId());
            responseJson.put("roomName", chatRoom.getName());
            responseJson.put("memberCount", treatedPatients.size() + 1);
            
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "建立治療師病患群組失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    @RESTfulAPIDefine(url = "createPatientCareTeamGroup", methods = "post", description = "為病患建立多專業團隊聊天群組")
    private String createPatientCareTeamGroup(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);
            
            Long patientId = requestJson.getLong("patientId");
            
            // 驗證病患存在性
            Patient patient = PatientAPI.getInstance().getPatient(patientId);
            if (patient == null) {
                responseJson.put("success", false);
                responseJson.put("message", "病患不存在");
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                return responseJson.toString();
            }

            // 獲取該病患的所有醫療團隊成員（醫師和治療師）
            List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().getRecordsByPatientId(patientId);
            List<User> careTeam = records.stream()
                .map(record -> {
                    try {
                        return UserAPI.getInstance().getUser(record.getCreator());
                    } catch (Exception e) {
                        return null;
                    }
                })
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());

            if (careTeam.isEmpty()) {
                responseJson.put("success", false);
                responseJson.put("message", "該病患尚未有醫療團隊成員");
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                return responseJson.toString();
            }

            // 檢查是否已存在該病患的團隊群組
            String groupName = "病患團隊 - " + patient.getName();
            ChatRoom existingRoom = findExistingPatientGroup(patientId, "PATIENT_CARE_TEAM");
            
            ChatRoom chatRoom;
            if (existingRoom != null) {
                // 更新現有群組成員
                updateCareTeamMembers(existingRoom, patientId, careTeam);
                chatRoom = existingRoom;
                responseJson.put("message", "成功更新病患照護團隊群組");
            } else {
                // 創建新聊天群組
                chatRoom = new ChatRoom(
                    groupName,
                    "AUTO_GROUP",
                    "病患 " + patient.getName() + " 的醫療團隊聊天群組",
                    null // 沒有特定創建者
                );
                ChatRoomDAO.getInstance().save(chatRoom);

                // 添加病患和醫療團隊到群組
                List<Long> memberIds = new ArrayList<>();
                if (patient.getUserId() != null) {
                    memberIds.add(patient.getUserId());
                }
                memberIds.addAll(careTeam.stream().map(User::getId).collect(Collectors.toList()));
                
                for (Long memberId : memberIds) {
                    ChatRoomUserDAO.getInstance().addRoomUser(chatRoom.getId(), memberId);
                }
                responseJson.put("message", "成功建立病患照護團隊群組");
            }

            responseJson.put("success", true);
            responseJson.put("roomId", chatRoom.getId());
            responseJson.put("roomName", chatRoom.getName());
            responseJson.put("memberCount", careTeam.size() + (patient.getUserId() != null ? 1 : 0));
            
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "建立病患照護團隊群組失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    @RESTfulAPIDefine(url = "getUserAutoGroups", methods = "post", description = "取得使用者的自動聊天群組列表")
    private String getUserAutoGroups(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);
            
            Long userId = requestJson.getLong("userId");
            
            // 獲取使用者的自動群組
            List<ChatRoom> userRooms = ChatRoomDAO.getInstance().findByUserId(userId);
            List<ChatRoom> autoGroups = userRooms.stream()
                .filter(room -> "AUTO_GROUP".equals(room.getRoomType()))
                .collect(Collectors.toList());

            JSONArray roomsArray = new JSONArray();
            for (ChatRoom room : autoGroups) {
                JSONObject roomJson = new JSONObject();
                roomJson.put("id", room.getId());
                roomJson.put("name", room.getName());
                roomJson.put("description", room.getDescription());
                roomJson.put("roomType", room.getRoomType());
                roomJson.put("creatorId", room.getCreatorId());
                
                // 獲取成員數量
                List<ChatRoomUser> members = ChatRoomUserDAO.getInstance().findByRoomId(room.getId());
                roomJson.put("memberCount", members.size());
                
                roomsArray.put(roomJson);
            }

            responseJson.put("success", true);
            responseJson.put("autoGroups", roomsArray);
            
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "取得使用者自動群組失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    @RESTfulAPIDefine(url = "refreshAutoGroups", methods = "post", description = "刷新所有自動群組（定期維護用）")
    private String refreshAutoGroups(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        
        try {
            // 獲取所有自動群組
            List<ChatRoom> autoGroups = ChatRoomDAO.getInstance().findAll().stream()
                .filter(room -> "AUTO_GROUP".equals(room.getRoomType()))
                .collect(Collectors.toList());
            
            int refreshedCount = 0;
            for (ChatRoom room : autoGroups) {
                try {
                    if (room.getDescription() != null && room.getDescription().contains("DOCTOR_PATIENTS") && room.getCreatorId() != null) {
                        // 刷新醫師群組
                        List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().getDoctorVisitsByPatient(null);
                        List<Patient> patients = records.stream()
                            .filter(record -> room.getCreatorId().equals(record.getCreator()))
                            .map(record -> {
                                try {
                                    return PatientAPI.getInstance().getPatient(record.getPatientId());
                                } catch (Exception e) {
                                    return null;
                                }
                            })
                            .filter(Objects::nonNull)
                            .distinct()
                            .collect(Collectors.toList());
                        updateGroupMembers(room, room.getCreatorId(), patients);
                        refreshedCount++;
                    } else if (room.getDescription() != null && room.getDescription().contains("THERAPIST_PATIENTS") && room.getCreatorId() != null) {
                        // 刷新治療師群組
                        List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().getTherapistVisitsByPatient(null);
                        List<Patient> patients = records.stream()
                            .filter(record -> room.getCreatorId().equals(record.getCreator()))
                            .map(record -> {
                                try {
                                    return PatientAPI.getInstance().getPatient(record.getPatientId());
                                } catch (Exception e) {
                                    return null;
                                }
                            })
                            .filter(Objects::nonNull)
                            .distinct()
                            .collect(Collectors.toList());
                        updateGroupMembers(room, room.getCreatorId(), patients);
                        refreshedCount++;
                    } else if (room.getDescription() != null && room.getDescription().contains("PATIENT_CARE_TEAM")) {
                        // 刷新病患照護團隊群組
                        List<ChatRoomUser> members = ChatRoomUserDAO.getInstance().findByRoomId(room.getId());
                        for (ChatRoomUser member : members) {
                            try {
                                Patient patient = PatientAPI.getInstance().getPatientByUserId(member.getUserId());
                                if (patient != null) {
                                    List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().getRecordsByPatientId(patient.getId());
                                    List<User> careTeam = records.stream()
                                        .map(record -> {
                                            try {
                                                return UserAPI.getInstance().getUser(record.getCreator());
                                            } catch (Exception e) {
                                                return null;
                                            }
                                        })
                                        .filter(Objects::nonNull)
                                        .distinct()
                                        .collect(Collectors.toList());
                                    updateCareTeamMembers(room, patient.getId(), careTeam);
                                    refreshedCount++;
                                    break; // 只需要找到一個病患即可
                                }
                            } catch (Exception e) {
                                // 忽略錯誤，繼續處理下一個成員
                            }
                        }
                    }
                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "刷新群組失敗: " + room.getName(), e);
                }
            }

            responseJson.put("success", true);
            responseJson.put("message", "成功刷新 " + refreshedCount + " 個自動群組");
            responseJson.put("totalGroups", autoGroups.size());
            responseJson.put("refreshedGroups", refreshedCount);
            
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "刷新自動群組失敗", e);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            responseJson.put("success", false);
            responseJson.put("message", "伺服器內部錯誤: " + e.getMessage());
            return responseJson.toString();
        }
    }

    // ==================== 輔助方法 ====================

    /**
     * 查找已存在的自動群組
     */
    private ChatRoom findExistingAutoGroup(Long creatorId, String roomType) {
        try {
            List<ChatRoom> rooms = ChatRoomDAO.getInstance().findByUserId(creatorId);
            return rooms.stream()
                .filter(room -> "AUTO_GROUP".equals(room.getRoomType()) && 
                               room.getDescription() != null &&
                               room.getDescription().contains(roomType) &&
                               creatorId.equals(room.getCreatorId()))
                .findFirst()
                .orElse(null);
        } catch (Exception ex) {
            return null;
        }
    }

    /**
     * 查找已存在的病患群組
     */
    private ChatRoom findExistingPatientGroup(Long patientId, String roomType) {
        try {
            List<ChatRoom> rooms = ChatRoomDAO.getInstance().findByUserId(patientId);
            return rooms.stream()
                .filter(room -> "AUTO_GROUP".equals(room.getRoomType()) && 
                               room.getDescription() != null &&
                               room.getDescription().contains(roomType))
                .findFirst()
                .orElse(null);
        } catch (Exception ex) {
            return null;
        }
    }

    /**
     * 添加成員到群組
     */
    private void addMembersToGroup(Long roomId, Long creatorId, List<Patient> patients) {
        try {
            // 添加創建者
            ChatRoomUserDAO.getInstance().addRoomUser(roomId, creatorId);
            
            // 添加病患
            for (Patient patient : patients) {
                if (patient.getUserId() != null) {
                    ChatRoomUserDAO.getInstance().addRoomUser(roomId, patient.getUserId());
                }
            }
        } catch (Exception ex) {
            throw new RuntimeException("添加群組成員失敗: " + ex.getMessage());
        }
    }

    /**
     * 更新群組成員
     */
    private void updateGroupMembers(ChatRoom room, Long creatorId, List<Patient> patients) {
        try {
            // 獲取當前群組成員
            List<ChatRoomUser> currentMembers = ChatRoomUserDAO.getInstance().findByRoomId(room.getId());
            Set<Long> currentUserIds = currentMembers.stream()
                .map(ChatRoomUser::getUserId)
                .collect(Collectors.toSet());
            
            // 應該要有的成員ID
            Set<Long> shouldHaveUserIds = new HashSet<>();
            shouldHaveUserIds.add(creatorId);
            patients.stream()
                .filter(patient -> patient.getUserId() != null)
                .forEach(patient -> shouldHaveUserIds.add(patient.getUserId()));
            
            // 添加新成員
            for (Long userId : shouldHaveUserIds) {
                if (!currentUserIds.contains(userId)) {
                    ChatRoomUserDAO.getInstance().addRoomUser(room.getId(), userId);
                }
            }
            
            // 移除不再相關的成員
            for (Long userId : currentUserIds) {
                if (!shouldHaveUserIds.contains(userId)) {
                    ChatRoomUserDAO.getInstance().removeRoomUser(room.getId(), userId);
                }
            }
        } catch (Exception ex) {
            throw new RuntimeException("更新群組成員失敗: " + ex.getMessage());
        }
    }

    /**
     * 更新照護團隊成員
     */
    private void updateCareTeamMembers(ChatRoom room, Long patientId, List<User> careTeam) {
        try {
            // 獲取當前群組成員
            List<ChatRoomUser> currentMembers = ChatRoomUserDAO.getInstance().findByRoomId(room.getId());
            Set<Long> currentUserIds = currentMembers.stream()
                .map(ChatRoomUser::getUserId)
                .collect(Collectors.toSet());
            
            // 應該要有的成員ID
            Set<Long> shouldHaveUserIds = new HashSet<>();
            Patient patient = PatientAPI.getInstance().getPatient(patientId);
            if (patient != null && patient.getUserId() != null) {
                shouldHaveUserIds.add(patient.getUserId());
            }
            shouldHaveUserIds.addAll(careTeam.stream().map(User::getId).collect(Collectors.toList()));
            
            // 添加新成員
            for (Long userId : shouldHaveUserIds) {
                if (!currentUserIds.contains(userId)) {
                    ChatRoomUserDAO.getInstance().addRoomUser(room.getId(), userId);
                }
            }
            
            // 移除不再相關的成員
            for (Long userId : currentUserIds) {
                if (!shouldHaveUserIds.contains(userId)) {
                    ChatRoomUserDAO.getInstance().removeRoomUser(room.getId(), userId);
                }
            }
        } catch (Exception ex) {
            throw new RuntimeException("更新照護團隊成員失敗: " + ex.getMessage());
        }
    }

    /**
     * 獲取治療類型
     */
    private String getTherapyType(List<Role> roles) {
        for (Role role : roles) {
            switch (role.getAlias()) {
                case "DTX_PSY":
                    return "心理";
                case "DTX_ST":
                    return "語言";
                case "DTX_OT":
                    return "職能";
                case "DTX_PI":
                    return "物理";
            }
        }
        return "治療";
    }
}
