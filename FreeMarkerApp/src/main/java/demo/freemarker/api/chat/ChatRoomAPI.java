package demo.freemarker.api.chat;

import demo.freemarker.dao.chat.ChatRoomDAO;
import demo.freemarker.model.chat.ChatRoom;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * 聊天室 API
 *
 * @author system
 */
public class ChatRoomAPI implements API {

    private final static ChatRoomAPI INSTANCE = new ChatRoomAPI();

    public static ChatRoomAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "ChatRoomAPI";
    }

    @Override
    public String getVersion() {
        return "20250626.01";
    }

    @Override
    public String getDescription() {
        return "聊天室管理 API";
    }

    /**
     * 獲取所有聊天室
     * @return 聊天室清單
     */
    public List<ChatRoom> listChatRooms() {
        try {
            List<ChatRoom> output = new ArrayList<>();
            List<IntIdDataEntity> list = ChatRoomDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((ChatRoom) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to list chat rooms: " + ex.getMessage());
        }
    }

    /**
     * 獲取聊天室詳情
     * @param id 聊天室ID
     * @return 聊天室實體
     */
    public ChatRoom getChatRoom(Long id) {
        try {
            return (ChatRoom) ChatRoomDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get chat room: " + ex.getMessage());
        }
    }

    /**
     * 創建聊天室
     * @param chatRoom 聊天室實體
     * @return 創建的聊天室
     */
    public ChatRoom createChatRoom(ChatRoom chatRoom) {
        try {
            ChatRoomDAO.getInstance().create(chatRoom);
            return chatRoom;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat room: " + ex.getMessage());
        }
    }

    /**
     * 創建聊天室
     * @param name 聊天室名稱
     * @return 創建的聊天室
     */
    public ChatRoom createChatRoom(String name) {
        try {
            ChatRoom chatRoom = new ChatRoom(name);
            ChatRoomDAO.getInstance().create(chatRoom);
            return chatRoom;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat room: " + ex.getMessage());
        }
    }

    /**
     * 創建聊天室
     * @param name 聊天室名稱
     * @param photoUrl 聊天室圖片URL
     * @return 創建的聊天室
     */
    public ChatRoom createChatRoom(String name, String photoUrl) {
        try {
            ChatRoom chatRoom = new ChatRoom(name, photoUrl);
            ChatRoomDAO.getInstance().create(chatRoom);
            return chatRoom;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat room: " + ex.getMessage());
        }
    }

    /**
     * 創建聊天室
     * @param name 聊天室名稱
     * @param creatorId 創建者ID
     * @return 創建的聊天室
     */
    public ChatRoom createChatRoom(String name, Long creatorId) {
        try {
            ChatRoom chatRoom = new ChatRoom(name, creatorId);
            ChatRoomDAO.getInstance().create(chatRoom);
            return chatRoom;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat room: " + ex.getMessage());
        }
    }

    /**
     * 創建聊天室
     * @param name 聊天室名稱
     * @param photoUrl 聊天室圖片URL
     * @param creatorId 創建者ID
     * @return 創建的聊天室
     */
    public ChatRoom createChatRoom(String name, String photoUrl, Long creatorId) {
        try {
            ChatRoom chatRoom = new ChatRoom(name, photoUrl, creatorId);
            ChatRoomDAO.getInstance().create(chatRoom);
            return chatRoom;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat room: " + ex.getMessage());
        }
    }

    /**
     * 更新聊天室
     * @param chatRoom 聊天室實體
     */
    public void updateChatRoom(ChatRoom chatRoom) {
        try {
            chatRoom.setUpdatedAt(new java.util.Date());
            ChatRoomDAO.getInstance().edit(chatRoom);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to update chat room: " + ex.getMessage());
        }
    }

    /**
     * 刪除聊天室（軟刪除）
     * @param id 聊天室ID
     */
    public void deleteChatRoom(Long id) {
        try {
            ChatRoomDAO.getInstance().softDelete(id);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to delete chat room: " + ex.getMessage());
        }
    }

    /**
     * 恢復已刪除的聊天室
     * @param id 聊天室ID
     */
    public void restoreChatRoom(Long id) {
        try {
            ChatRoomDAO.getInstance().restore(id);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to restore chat room: " + ex.getMessage());
        }
    }

    /**
     * 根據名稱搜尋聊天室
     * @param name 聊天室名稱（模糊搜尋）
     * @return 聊天室清單
     */
    public List<ChatRoom> searchChatRoomsByName(String name) {
        try {
            return ChatRoomDAO.getInstance().findByName(name);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to search chat rooms by name: " + ex.getMessage());
        }
    }

    /**
     * 根據使用者ID獲取聊天室
     * @param userId 使用者ID
     * @return 聊天室清單
     */
    public List<ChatRoom> getChatRoomsByUserId(Long userId) {
        try {
            return ChatRoomDAO.getInstance().findByUserId(userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get chat rooms by user ID: " + ex.getMessage());
        }
    }

    /**
     * 根據創建者ID獲取聊天室
     * @param creatorId 創建者ID
     * @return 聊天室清單
     */
    public List<ChatRoom> getChatRoomsByCreatorId(Long creatorId) {
        try {
            return ChatRoomDAO.getInstance().findByCreatorId(creatorId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get chat rooms by creator ID: " + ex.getMessage());
        }
    }
}
