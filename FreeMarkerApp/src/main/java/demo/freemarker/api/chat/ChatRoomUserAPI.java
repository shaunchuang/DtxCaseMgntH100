package demo.freemarker.api.chat;

import demo.freemarker.dao.chat.ChatRoomUserDAO;
import demo.freemarker.model.chat.ChatRoomUser;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * 聊天室成員 API
 *
 * @author system
 */
public class ChatRoomUserAPI implements API {

    private final static ChatRoomUserAPI INSTANCE = new ChatRoomUserAPI();

    public static ChatRoomUserAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "ChatRoomUserAPI";
    }

    @Override
    public String getVersion() {
        return "20250626.01";
    }

    @Override
    public String getDescription() {
        return "聊天室成員管理 API";
    }

    /**
     * 獲取所有聊天室成員
     * @return 聊天室成員清單
     */
    public List<ChatRoomUser> listChatRoomUsers() {
        try {
            List<ChatRoomUser> output = new ArrayList<>();
            List<IntIdDataEntity> list = ChatRoomUserDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((ChatRoomUser) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to list chat room users: " + ex.getMessage());
        }
    }

    /**
     * 獲取聊天室成員詳情
     * @param id 聊天室成員ID
     * @return 聊天室成員實體
     */
    public ChatRoomUser getChatRoomUser(Long id) {
        try {
            return (ChatRoomUser) ChatRoomUserDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get chat room user: " + ex.getMessage());
        }
    }

    /**
     * 創建聊天室成員
     * @param roomUser 聊天室成員實體
     * @return 創建的聊天室成員
     */
    public ChatRoomUser createChatRoomUser(ChatRoomUser roomUser) {
        try {
            ChatRoomUserDAO.getInstance().create(roomUser);
            return roomUser;
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create chat room user: " + ex.getMessage());
        }
    }

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

    /**
     * 根據聊天室ID獲取成員清單
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
     * 根據使用者ID獲取參與的聊天室
     * @param userId 使用者ID
     * @return 聊天室成員清單
     */
    public List<ChatRoomUser> getUserRooms(Long userId) {
        try {
            return ChatRoomUserDAO.getInstance().findByUserId(userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get user rooms: " + ex.getMessage());
        }
    }

    /**
     * 獲取特定聊天室和使用者的關係
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 聊天室成員實體，如果不存在則返回null
     */
    public ChatRoomUser getRoomUserRelation(Long roomId, Long userId) {
        try {
            return ChatRoomUserDAO.getInstance().findByRoomAndUser(roomId, userId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get room user relation: " + ex.getMessage());
        }
    }
}
