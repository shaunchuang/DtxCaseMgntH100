package demo.freemarker.api.chat;

import demo.freemarker.dao.chat.ChatRoomDAO;
import demo.freemarker.dao.chat.ChatRoomUserDAO;
import demo.freemarker.dao.chat.ChatMessageDAO;
import demo.freemarker.dao.chat.ChatMessageReadDAO;
import demo.freemarker.model.chat.ChatRoom;
import demo.freemarker.model.chat.ChatRoomUser;
import demo.freemarker.model.chat.ChatMessage;
import demo.freemarker.model.chat.ChatMessageRead;
import itri.sstc.framework.core.api.API;

import java.util.List;
import java.util.ArrayList;

/**
 * 聊天系統整合 API
 *
 * @author system
 */
public class ChatAPI implements API {

    private final static ChatAPI INSTANCE = new ChatAPI();

    public static ChatAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "ChatAPI";
    }

    @Override
    public String getVersion() {
        return "20250626.01";
    }

    @Override
    public String getDescription() {
        return "聊天系統整合 API";
    }

    // ========== 聊天室管理 ==========

    /**
     * 創建聊天室
     * @param name 聊天室名稱
     * @return 創建的聊天室
     */
    public ChatRoom createChatRoom(String name) {
        try {
            ChatRoom chatRoom = new ChatRoom(name);
            ChatRoomDAO.getInstance().save(chatRoom);
            return chatRoom;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat room: " + ex.getMessage());
        }
    }

    /**
     * 創建聊天室並添加創建者
     * @param name 聊天室名稱
     * @param creatorId 創建者ID
     * @return 創建的聊天室
     */
    public ChatRoom createChatRoom(String name, Long creatorId) {
        try {
            ChatRoom chatRoom = new ChatRoom(name);
            ChatRoomDAO.getInstance().save(chatRoom);
            
            // 將創建者加入聊天室
            addUserToChatRoom(chatRoom.getId(), creatorId);
            
            return chatRoom;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat room: " + ex.getMessage());
        }
    }

    /**
     * 創建聊天室並添加成員
     * @param name 聊天室名稱
     * @param userIds 成員ID清單
     * @return 創建的聊天室
     */
    public ChatRoom createChatRoomWithUsers(String name, List<Long> userIds) {
        try {
            ChatRoom chatRoom = createChatRoom(name);
            for (Long userId : userIds) {
                addUserToRoom(chatRoom.getId(), userId);
            }
            return chatRoom;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat room with users: " + ex.getMessage());
        }
    }

    /**
     * 創建私聊室（兩人聊天）
     * @param user1Id 使用者1 ID
     * @param user2Id 使用者2 ID
     * @return 創建的聊天室
     */
    public ChatRoom createPrivateChat(Long user1Id, Long user2Id) {
        try {
            String roomName = "Private Chat";
            ChatRoom chatRoom = createChatRoom(roomName);
            addUserToRoom(chatRoom.getId(), user1Id);
            addUserToRoom(chatRoom.getId(), user2Id);
            return chatRoom;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create private chat: " + ex.getMessage());
        }
    }

    /**
     * 獲取使用者參與的聊天室
     * @param userId 使用者ID
     * @return 聊天室清單
     */
    public List<ChatRoom> getUserChatRooms(Long userId) {
        try {
            return ChatRoomDAO.getInstance().findByUserId(userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get user chat rooms: " + ex.getMessage());
        }
    }

    // ========== 聊天室成員管理 ==========

    /**
     * 添加使用者到聊天室
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 成功則返回true
     */
    public boolean addUserToRoom(Long roomId, Long userId) {
        try {
            return ChatRoomUserDAO.getInstance().addRoomUser(roomId, userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to add user to room: " + ex.getMessage());
        }
    }

    /**
     * 添加使用者到聊天室（別名方法）
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 成功則返回true
     */
    public boolean addUserToChatRoom(Long roomId, Long userId) {
        return addUserToRoom(roomId, userId);
    }

    /**
     * 從聊天室移除使用者
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 成功則返回true
     */
    public boolean removeUserFromRoom(Long roomId, Long userId) {
        try {
            return ChatRoomUserDAO.getInstance().removeRoomUser(roomId, userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to remove user from room: " + ex.getMessage());
        }
    }

    /**
     * 從聊天室移除使用者（別名方法）
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 成功則返回true
     */
    public boolean removeUserFromChatRoom(Long roomId, Long userId) {
        return removeUserFromRoom(roomId, userId);
    }

    /**
     * 獲取聊天室成員
     * @param roomId 聊天室ID
     * @return 聊天室成員清單
     */
    public List<ChatRoomUser> getRoomMembers(Long roomId) {
        try {
            return ChatRoomUserDAO.getInstance().findByRoomId(roomId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get room members: " + ex.getMessage());
        }
    }

    /**
     * 獲取聊天室成員（別名方法）
     * @param roomId 聊天室ID
     * @return 聊天室成員清單
     */
    public List<ChatRoomUser> getChatRoomMembers(Long roomId) {
        return getRoomMembers(roomId);
    }
    // ========== 訊息管理 ==========

    /**
     * 發送文字訊息
     * @param roomId 聊天室ID
     * @param senderId 發送者ID
     * @param content 訊息內容
     * @return 創建的聊天訊息
     */
    public ChatMessage sendMessage(Long roomId, Long senderId, String content) {
        try {
            // 檢查發送者是否為聊天室成員
            if (!isRoomMember(roomId, senderId)) {
                throw new RuntimeException("User is not a member of this chat room");
            }
            
            ChatMessage message = new ChatMessage(roomId, senderId, content);
            ChatMessageDAO.getInstance().save(message);
            return message;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to send message: " + ex.getMessage());
        }
    }

    /**
     * 發送文字訊息（擴展版本）
     * @param roomId 聊天室ID
     * @param senderId 發送者ID
     * @param content 訊息內容
     * @param messageType 訊息類型
     * @return 創建的聊天訊息
     */
    public ChatMessage sendMessage(Long roomId, Long senderId, String content, String messageType) {
        try {
            // 檢查發送者是否為聊天室成員
            if (!isRoomMember(roomId, senderId)) {
                throw new RuntimeException("User is not a member of this chat room");
            }
            
            ChatMessage message = new ChatMessage(roomId, senderId, content);
            // 設置訊息類型（如果模型支持）
            ChatMessageDAO.getInstance().save(message);
            return message;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to send message: " + ex.getMessage());
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
            // 檢查發送者是否為聊天室成員
            if (!isRoomMember(roomId, senderId)) {
                throw new RuntimeException("User is not a member of this chat room");
            }
            
            ChatMessage message = new ChatMessage(roomId, senderId, content, fileUrl);
            ChatMessageDAO.getInstance().save(message);
            return message;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to send message with file: " + ex.getMessage());
        }
    }

    /**
     * 獲取聊天室的訊息
     * @param roomId 聊天室ID
     * @param userId 請求使用者ID
     * @return 聊天訊息清單
     */
    public List<ChatMessage> getRoomMessages(Long roomId, Long userId) {
        try {
            // 檢查使用者是否為聊天室成員
            if (!isRoomMember(roomId, userId)) {
                throw new RuntimeException("User is not a member of this chat room");
            }
            
            return ChatMessageDAO.getInstance().findByRoomId(roomId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get room messages: " + ex.getMessage());
        }
    }

    /**
     * 獲取聊天室的最近訊息
     * @param roomId 聊天室ID
     * @param userId 請求使用者ID
     * @param limit 限制數量
     * @return 聊天訊息清單
     */
    public List<ChatMessage> getRecentRoomMessages(Long roomId, Long userId, int limit) {
        try {
            // 檢查使用者是否為聊天室成員
            if (!isRoomMember(roomId, userId)) {
                throw new RuntimeException("User is not a member of this chat room");
            }
            
            return ChatMessageDAO.getInstance().findRecentByRoomId(roomId, limit);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get recent room messages: " + ex.getMessage());
        }
    }

    /**
     * 獲取某個訊息之前的訊息（用於分頁載入歷史訊息）
     * @param roomId 聊天室ID
     * @param beforeMessageId 基準訊息ID
     * @param limit 限制數量
     * @return 聊天訊息清單
     */
    public List<ChatMessage> getMessagesBefore(Long roomId, Long beforeMessageId, int limit) {
        try {
            return ChatMessageDAO.getInstance().findMessagesBefore(roomId, beforeMessageId, limit);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get messages before: " + ex.getMessage());
        }
    }

    /**
     * 獲取聊天室的未讀訊息數量
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 未讀訊息數量
     */
    public int getUnreadMessageCount(Long roomId, Long userId) {
        try {
            return ChatMessageReadDAO.getInstance().getUnreadCountByRoom(roomId, userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get unread message count: " + ex.getMessage());
        }
    }

    /**
     * 獲取使用者的總未讀訊息數量
     * @param userId 使用者ID
     * @return 未讀訊息數量
     */
    public int getTotalUnreadCount(Long userId) {
        try {
            return (int) ChatMessageReadDAO.getInstance().getUnreadCount(userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get total unread count: " + ex.getMessage());
        }
    }

    // ========== 訊息已讀狀態管理 ==========

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
     * 標記聊天室的所有訊息為已讀
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 成功標記的訊息數量
     */
    public int markAllRoomMessagesAsRead(Long roomId, Long userId) {
        try {
            // 檢查使用者是否為聊天室成員
            if (!isRoomMember(roomId, userId)) {
                throw new RuntimeException("User is not a member of this chat room");
            }
            
            List<ChatMessage> messages = ChatMessageDAO.getInstance().findByRoomId(roomId);
            int count = 0;
            for (ChatMessage message : messages) {
                if (ChatMessageReadDAO.getInstance().markAsRead(message.getId(), userId)) {
                    count++;
                }
            }
            return count;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to mark all room messages as read: " + ex.getMessage());
        }
    }

    /**
     * 獲取使用者的未讀訊息數量
     * @param userId 使用者ID
     * @return 未讀訊息數量
     */
    public long getUnreadMessageCount(Long userId) {
        try {
            return ChatMessageReadDAO.getInstance().getUnreadCount(userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get unread message count: " + ex.getMessage());
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
     * 檢查使用者是否為聊天室成員
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 是成員則返回true
     */
    public boolean isRoomMember(Long roomId, Long userId) {
        try {
            return ChatRoomUserDAO.getInstance().isRoomMember(roomId, userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to check room membership: " + ex.getMessage());
        }
    }

    // ========== 整合功能 ==========

    /**
     * 創建完整的聊天會話（包含聊天室和初始訊息）
     * @param roomName 聊天室名稱
     * @param userIds 參與使用者ID清單
     * @param initialMessage 初始訊息
     * @param senderId 初始訊息發送者ID
     * @return 創建的聊天室
     */
    public ChatRoom createChatSession(String roomName, List<Long> userIds, String initialMessage, Long senderId) {
        try {
            // 創建聊天室
            ChatRoom chatRoom = createChatRoomWithUsers(roomName, userIds);
            
            // 發送初始訊息
            if (initialMessage != null && !initialMessage.trim().isEmpty()) {
                sendMessage(chatRoom.getId(), senderId, initialMessage);
            }
            
            return chatRoom;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat session: " + ex.getMessage());
        }
    }

    /**
     * 獲取兩個使用者之間的私聊室（如果不存在則創建）
     * @param user1Id 使用者1 ID
     * @param user2Id 使用者2 ID
     * @return 聊天室
     */
    public ChatRoom getOrCreatePrivateChat(Long user1Id, Long user2Id) {
        try {
            // 查找是否已存在兩人的私聊室
            List<ChatRoom> user1Rooms = getUserChatRooms(user1Id);
            List<ChatRoom> user2Rooms = getUserChatRooms(user2Id);
            
            for (ChatRoom room1 : user1Rooms) {
                for (ChatRoom room2 : user2Rooms) {
                    if (room1.getId().equals(room2.getId())) {
                        // 檢查是否只有這兩個人
                        List<ChatRoomUser> members = getRoomMembers(room1.getId());
                        if (members.size() == 2) {
                            return room1;
                        }
                    }
                }
            }
            
            // 如果不存在，創建新的私聊室
            return createPrivateChat(user1Id, user2Id);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get or create private chat: " + ex.getMessage());
        }
    }
}
