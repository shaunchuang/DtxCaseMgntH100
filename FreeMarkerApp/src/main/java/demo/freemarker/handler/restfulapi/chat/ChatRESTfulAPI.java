package demo.freemarker.handler.restfulapi.chat;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.chat.ChatAPI;
import demo.freemarker.core.SecurityUtils;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.model.User;
import demo.freemarker.model.chat.ChatRoom;
import demo.freemarker.model.chat.ChatMessage;
import demo.freemarker.model.chat.ChatRoomUser;
import demo.freemarker.api.PatientAPI;
import demo.freemarker.dao.chat.ChatRoomUserDAO;
import demo.freemarker.model.Patient;
import demo.freemarker.model.Role;
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
                JSONObject roomObj = GsonUtil.toJsonObject(room);
                // 標記是否為創建者
                roomObj.put("isCreator", currentUser.getId().equals(room.getCreatorId()));
                roomsArray.put(roomObj);
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
            roomDetails.put("creatorId", chatRoom.getCreatorId());
            roomDetails.put("isCreator", currentUser.getId().equals(chatRoom.getCreatorId()));
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


   // ==================== 輔助方法 ====================

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
