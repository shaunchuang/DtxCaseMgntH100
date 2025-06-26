package demo.freemarker.dao.chat;

import demo.freemarker.model.chat.ChatRoomUser;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * 聊天室成員 DAO
 *
 * @author system
 */
public class ChatRoomUserDAO extends IntIdBaseDAO {

    final static ChatRoomUserDAO instance = new ChatRoomUserDAO("DTXCASEMGNT_PU");

    public final static ChatRoomUserDAO getInstance() {
        return instance;
    }

    private ChatRoomUserDAO(String puName) {
        super(puName, ChatRoomUser.class);
    }

    @Override
    public String getTableName() {
        return "chat_room_user";
    }

    /**
     * 根據聊天室ID查詢成員
     * @param roomId 聊天室ID
     * @return 成員清單
     */
    public List<ChatRoomUser> findByRoomId(Long roomId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatRoomUser.findByRoomId");
            q.setParameter("roomId", roomId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 根據使用者ID查詢所參與的聊天室
     * @param userId 使用者ID
     * @return 聊天室成員清單
     */
    public List<ChatRoomUser> findByUserId(Long userId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatRoomUser.findByUserId");
            q.setParameter("userId", userId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 查詢特定聊天室和使用者的關係
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 聊天室成員實體，如果不存在則返回null
     */
    public ChatRoomUser findByRoomAndUser(Long roomId, Long userId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatRoomUser.findByRoomAndUser");
            q.setParameter("roomId", roomId);
            q.setParameter("userId", userId);
            List<ChatRoomUser> results = q.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * 新增聊天室成員
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 成功則返回true
     */
    public boolean addRoomUser(Long roomId, Long userId) {
        // 檢查是否已存在
        if (findByRoomAndUser(roomId, userId) != null) {
            return false; // 已經是成員
        }
        
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            ChatRoomUser roomUser = new ChatRoomUser(roomId, userId);
            em.persist(roomUser);
            em.getTransaction().commit();
            return true;
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to add room user: " + ex.getMessage());
        } finally {
            em.close();
        }
    }

    /**
     * 移除聊天室成員
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 成功則返回true
     */
    public boolean removeRoomUser(Long roomId, Long userId) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Query q = em.createNamedQuery("ChatRoomUser.deleteByRoomAndUser");
            q.setParameter("roomId", roomId);
            q.setParameter("userId", userId);
            int deletedCount = q.executeUpdate();
            em.getTransaction().commit();
            return deletedCount > 0;
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to remove room user: " + ex.getMessage());
        } finally {
            em.close();
        }
    }

    /**
     * 檢查使用者是否為聊天室成員
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 是成員則返回true
     */
    public boolean isRoomMember(Long roomId, Long userId) {
        return findByRoomAndUser(roomId, userId) != null;
    }
}
