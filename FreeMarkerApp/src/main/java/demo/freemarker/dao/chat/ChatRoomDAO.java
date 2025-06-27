package demo.freemarker.dao.chat;

import demo.freemarker.model.chat.ChatRoom;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * 聊天室 DAO
 *
 * @author system
 */
public class ChatRoomDAO extends IntIdBaseDAO {

    final static ChatRoomDAO instance = new ChatRoomDAO("DTXCASEMGNT_PU");

    public final static ChatRoomDAO getInstance() {
        return instance;
    }

    private ChatRoomDAO(String puName) {
        super(puName, ChatRoom.class);
    }

    @Override
    public String getTableName() {
        return "chat_room";
    }

    /**
     * 根據名稱模糊查詢聊天室
     * @param name 聊天室名稱
     * @return 聊天室清單
     */
    public List<ChatRoom> findByName(String name) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatRoom.findByName");
            q.setParameter("name", "%" + name + "%");
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 根據使用者ID查詢聊天室
     * @param userId 使用者ID
     * @return 聊天室清單
     */
    public List<ChatRoom> findByUserId(Long userId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatRoom.findByUser");
            q.setParameter("userId", userId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 根據創建者ID查詢聊天室
     * @param creatorId 創建者ID
     * @return 聊天室清單
     */
    public List<ChatRoom> findByCreatorId(Long creatorId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatRoom.findByCreator");
            q.setParameter("creatorId", creatorId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 查詢所有有效的聊天室
     * @return 聊天室清單
     */
    public List<ChatRoom> findAll() {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatRoom.findAll");
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 軟刪除聊天室
     * @param id 聊天室ID
     */
    public void softDelete(Long id) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            ChatRoom chatRoom = em.find(ChatRoom.class, id);
            if (chatRoom != null) {
                chatRoom.setDeletedAt(new java.util.Date());
                em.merge(chatRoom);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to soft delete chat room: " + ex.getMessage());
        } finally {
            em.close();
        }
    }

    /**
     * 保存聊天室
     * @param chatRoom 聊天室實體
     * @return 保存的聊天室
     */
    public ChatRoom save(ChatRoom chatRoom) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(chatRoom);
            em.getTransaction().commit();
            return chatRoom;
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to save chat room: " + ex.getMessage());
        } finally {
            em.close();
        }
    }

    /**
     * 恢復已刪除的聊天室
     * @param id 聊天室ID
     */
    public void restore(Long id) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            ChatRoom chatRoom = em.find(ChatRoom.class, id);
            if (chatRoom != null) {
                chatRoom.setDeletedAt(null);
                em.merge(chatRoom);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to restore chat room: " + ex.getMessage());
        } finally {
            em.close();
        }
    }
}
