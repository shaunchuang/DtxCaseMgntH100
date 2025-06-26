package demo.freemarker.handler.restfulapi.chat;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.chat.ChatAPI;
import demo.freemarker.core.SecurityUtils;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.model.User;
import demo.freemarker.model.chat.ChatRoom;
import demo.freemarker.model.chat.ChatMessage;
import demo.freemarker.model.chat.ChatRoomUser;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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
            String roomType = requestJson.optString("roomType", "GROUP"); // GROUP or PRIVATE
            String description = requestJson.optString("description", "");
            
            // 使用 ChatAPI 建立聊天室
            ChatRoom chatRoom = ChatAPI.getInstance().createChatRoom(
                roomName, roomType, description, currentUser.getId());

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
            JSONObject requestJson = new JSONObject(requestBody);

            Long roomId = requestJson.getLong("roomId");
            String content = requestJson.getString("content");
            String messageType = requestJson.optString("messageType", "TEXT");
            
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
}
