package demo.freemarker.api.chat;

import demo.freemarker.dao.chat.ChatMessageDAO;
import demo.freemarker.model.chat.ChatMessage;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * 聊天訊息 API
 *
 * @author system
 */
public class ChatMessageAPI implements API {

    private final static ChatMessageAPI INSTANCE = new ChatMessageAPI();

    public static ChatMessageAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "ChatMessageAPI";
    }

    @Override
    public String getVersion() {
        return "20250626.01";
    }

    @Override
    public String getDescription() {
        return "聊天訊息管理 API";
    }

    /**
     * 獲取所有聊天訊息
     * @return 聊天訊息清單
     */
    public List<ChatMessage> listChatMessages() {
        try {
            List<ChatMessage> output = new ArrayList<>();
            List<IntIdDataEntity> list = ChatMessageDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((ChatMessage) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to list chat messages: " + ex.getMessage());
        }
    }

    /**
     * 獲取聊天訊息詳情
     * @param id 聊天訊息ID
     * @return 聊天訊息實體
     */
    public ChatMessage getChatMessage(Long id) {
        try {
            return (ChatMessage) ChatMessageDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get chat message: " + ex.getMessage());
        }
    }

    /**
     * 創建聊天訊息
     * @param message 聊天訊息實體
     * @return 創建的聊天訊息
     */
    public ChatMessage createChatMessage(ChatMessage message) {
        try {
            ChatMessageDAO.getInstance().create(message);
            return message;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat message: " + ex.getMessage());
        }
    }

    /**
     * 發送文字訊息
     * @param roomId 聊天室ID
     * @param senderId 發送者ID
     * @param content 訊息內容
     * @return 創建的聊天訊息
     */
    public ChatMessage sendTextMessage(Long roomId, Long senderId, String content) {
        try {
            ChatMessage message = new ChatMessage(roomId, senderId, content);
            ChatMessageDAO.getInstance().create(message);
            return message;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to send text message: " + ex.getMessage());
        }
    }

    /**
     * 發送包含檔案的訊息
     * @param roomId 聊天室ID
     * @param senderId 發送者ID
     * @param content 訊息內容
     * @param fileUrl 檔案URL
     * @return 創建的聊天訊息
     */
    public ChatMessage sendMessageWithFile(Long roomId, Long senderId, String content, String fileUrl) {
        try {
            ChatMessage message = new ChatMessage(roomId, senderId, content, fileUrl);
            ChatMessageDAO.getInstance().create(message);
            return message;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to send message with file: " + ex.getMessage());
        }
    }

    /**
     * 更新聊天訊息
     * @param message 聊天訊息實體
     */
    public void updateChatMessage(ChatMessage message) {
        try {
            message.setUpdatedAt(new java.util.Date());
            ChatMessageDAO.getInstance().edit(message);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to update chat message: " + ex.getMessage());
        }
    }

    /**
     * 更新訊息內容
     * @param id 訊息ID
     * @param content 新內容
     */
    public void updateMessageContent(Long id, String content) {
        try {
            ChatMessageDAO.getInstance().updateContent(id, content);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to update message content: " + ex.getMessage());
        }
    }

    /**
     * 刪除聊天訊息（軟刪除）
     * @param id 聊天訊息ID
     */
    public void deleteChatMessage(Long id) {
        try {
            ChatMessageDAO.getInstance().softDelete(id);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to delete chat message: " + ex.getMessage());
        }
    }

    /**
     * 恢復已刪除的聊天訊息
     * @param id 聊天訊息ID
     */
    public void restoreChatMessage(Long id) {
        try {
            ChatMessageDAO.getInstance().restore(id);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to restore chat message: " + ex.getMessage());
        }
    }

    /**
     * 根據聊天室ID獲取訊息
     * @param roomId 聊天室ID
     * @return 聊天訊息清單
     */
    public List<ChatMessage> getMessagesByRoomId(Long roomId) {
        try {
            return ChatMessageDAO.getInstance().findByRoomId(roomId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get messages by room ID: " + ex.getMessage());
        }
    }

    /**
     * 根據聊天室ID獲取最近的訊息
     * @param roomId 聊天室ID
     * @param limit 限制數量
     * @return 聊天訊息清單
     */
    public List<ChatMessage> getRecentMessagesByRoomId(Long roomId, int limit) {
        try {
            return ChatMessageDAO.getInstance().findRecentByRoomId(roomId, limit);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get recent messages by room ID: " + ex.getMessage());
        }
    }

    /**
     * 根據發送者ID獲取訊息
     * @param senderId 發送者ID
     * @return 聊天訊息清單
     */
    public List<ChatMessage> getMessagesBySenderId(Long senderId) {
        try {
            return ChatMessageDAO.getInstance().findBySenderId(senderId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get messages by sender ID: " + ex.getMessage());
        }
    }

    /**
     * 根據聊天室ID和發送者ID獲取訊息
     * @param roomId 聊天室ID
     * @param senderId 發送者ID
     * @return 聊天訊息清單
     */
    public List<ChatMessage> getMessagesByRoomAndSender(Long roomId, Long senderId) {
        try {
            return ChatMessageDAO.getInstance().findByRoomIdAndSender(roomId, senderId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get messages by room and sender: " + ex.getMessage());
        }
    }
}
