package demo.freemarker.api.chat;

import demo.freemarker.dao.chat.ChatMessageReadDAO;
import demo.freemarker.model.chat.ChatMessageRead;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * 聊天訊息已讀狀態 API
 *
 * @author system
 */
public class ChatMessageReadAPI implements API {

    private final static ChatMessageReadAPI INSTANCE = new ChatMessageReadAPI();

    public static ChatMessageReadAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "ChatMessageReadAPI";
    }

    @Override
    public String getVersion() {
        return "20250626.01";
    }

    @Override
    public String getDescription() {
        return "聊天訊息已讀狀態管理 API";
    }

    /**
     * 獲取所有聊天訊息已讀狀態
     * @return 聊天訊息已讀狀態清單
     */
    public List<ChatMessageRead> listChatMessageReads() {
        try {
            List<ChatMessageRead> output = new ArrayList<>();
            List<IntIdDataEntity> list = ChatMessageReadDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((ChatMessageRead) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to list chat message reads: " + ex.getMessage());
        }
    }

    /**
     * 獲取聊天訊息已讀狀態詳情
     * @param id 聊天訊息已讀狀態ID
     * @return 聊天訊息已讀狀態實體
     */
    public ChatMessageRead getChatMessageRead(Long id) {
        try {
            return (ChatMessageRead) ChatMessageReadDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get chat message read: " + ex.getMessage());
        }
    }

    /**
     * 創建聊天訊息已讀狀態
     * @param messageRead 聊天訊息已讀狀態實體
     * @return 創建的聊天訊息已讀狀態
     */
    public ChatMessageRead createChatMessageRead(ChatMessageRead messageRead) {
        try {
            ChatMessageReadDAO.getInstance().create(messageRead);
            return messageRead;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat message read: " + ex.getMessage());
        }
    }

    /**
     * 標記訊息為已讀
     * @param messageId 訊息ID
     * @param userId 使用者ID
     * @return 成功則返回true
     */
    public boolean markMessageAsRead(Long messageId, Long userId) {
        try {
            return ChatMessageReadDAO.getInstance().markAsRead(messageId, userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to mark message as read: " + ex.getMessage());
        }
    }

    /**
     * 標記訊息為未讀
     * @param messageId 訊息ID
     * @param userId 使用者ID
     * @return 成功則返回true
     */
    public boolean markMessageAsUnread(Long messageId, Long userId) {
        try {
            return ChatMessageReadDAO.getInstance().markAsUnread(messageId, userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to mark message as unread: " + ex.getMessage());
        }
    }

    /**
     * 檢查訊息是否已被使用者讀取
     * @param messageId 訊息ID
     * @param userId 使用者ID
     * @return 已讀則返回true
     */
    public boolean isMessageRead(Long messageId, Long userId) {
        try {
            return ChatMessageReadDAO.getInstance().isMessageRead(messageId, userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to check if message is read: " + ex.getMessage());
        }
    }

    /**
     * 獲取使用者的未讀訊息數量
     * @param userId 使用者ID
     * @return 未讀訊息數量
     */
    public long getUnreadCount(Long userId) {
        try {
            return ChatMessageReadDAO.getInstance().getUnreadCount(userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get unread count: " + ex.getMessage());
        }
    }

    /**
     * 根據訊息ID獲取已讀狀態
     * @param messageId 訊息ID
     * @return 已讀狀態清單
     */
    public List<ChatMessageRead> getReadStatusByMessageId(Long messageId) {
        try {
            return ChatMessageReadDAO.getInstance().findByMessageId(messageId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get read status by message ID: " + ex.getMessage());
        }
    }

    /**
     * 根據使用者ID獲取已讀狀態
     * @param userId 使用者ID
     * @return 已讀狀態清單
     */
    public List<ChatMessageRead> getReadStatusByUserId(Long userId) {
        try {
            return ChatMessageReadDAO.getInstance().findByUserId(userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get read status by user ID: " + ex.getMessage());
        }
    }

    /**
     * 獲取使用者的未讀訊息
     * @param userId 使用者ID
     * @return 未讀訊息清單
     */
    public List<ChatMessageRead> getUnreadMessages(Long userId) {
        try {
            return ChatMessageReadDAO.getInstance().findUnreadByUser(userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get unread messages: " + ex.getMessage());
        }
    }

    /**
     * 獲取使用者的已讀訊息
     * @param userId 使用者ID
     * @return 已讀訊息清單
     */
    public List<ChatMessageRead> getReadMessages(Long userId) {
        try {
            return ChatMessageReadDAO.getInstance().findReadByUser(userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get read messages: " + ex.getMessage());
        }
    }

    /**
     * 獲取特定訊息和使用者的已讀狀態
     * @param messageId 訊息ID
     * @param userId 使用者ID
     * @return 已讀狀態實體，如果不存在則返回null
     */
    public ChatMessageRead getReadStatus(Long messageId, Long userId) {
        try {
            return ChatMessageReadDAO.getInstance().findByMessageAndUser(messageId, userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get read status: " + ex.getMessage());
        }
    }
}
