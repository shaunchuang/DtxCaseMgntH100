package demo.freemarker.dao.chat;

import demo.freemarker.model.chat.ChatMessage;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * 聊天訊息 DAO
 *
 * @author system
 */
public class ChatMessageDAO extends IntIdBaseDAO {

    final static ChatMessageDAO instance = new ChatMessageDAO("DTXCASEMGNT_PU");

    public final static ChatMessageDAO getInstance() {
        return instance;
    }

    private ChatMessageDAO(String puName) {
        super(puName, ChatMessage.class);
    }

    @Override
    public String getTableName() {
        return "chat_message";
    }

    /**
     * 根據聊天室ID查詢訊息
     * @param roomId 聊天室ID
     * @return 訊息清單
     */
    public List<ChatMessage> findByRoomId(Long roomId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatMessage.findByRoomId");
            q.setParameter("roomId", roomId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 根據聊天室ID查詢最近的訊息（分頁）
     * @param roomId 聊天室ID
     * @param limit 限制數量
     * @return 訊息清單
     */
    public List<ChatMessage> findRecentByRoomId(Long roomId, int limit) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatMessage.findRecentByRoomId");
            q.setParameter("roomId", roomId);
            q.setMaxResults(limit);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 根據發送者ID查詢訊息
     * @param senderId 發送者ID
     * @return 訊息清單
     */
    public List<ChatMessage> findBySenderId(Long senderId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatMessage.findBySenderId");
            q.setParameter("senderId", senderId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 根據聊天室ID和發送者ID查詢訊息
     * @param roomId 聊天室ID
     * @param senderId 發送者ID
     * @return 訊息清單
     */
    public List<ChatMessage> findByRoomIdAndSender(Long roomId, Long senderId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatMessage.findByRoomIdAndSender");
            q.setParameter("roomId", roomId);
            q.setParameter("senderId", senderId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 查詢所有有效的訊息
     * @return 訊息清單
     */
    public List<ChatMessage> findAll() {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatMessage.findAll");
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 軟刪除訊息
     * @param id 訊息ID
     */
    public void softDelete(Long id) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            ChatMessage message = em.find(ChatMessage.class, id);
            if (message != null) {
                message.setDeletedAt(new java.util.Date());
                em.merge(message);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to soft delete message: " + ex.getMessage());
        } finally {
            em.close();
        }
    }

    /**
     * 恢復已刪除的訊息
     * @param id 訊息ID
     */
    public void restore(Long id) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            ChatMessage message = em.find(ChatMessage.class, id);
            if (message != null) {
                message.setDeletedAt(null);
                em.merge(message);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to restore message: " + ex.getMessage());
        } finally {
            em.close();
        }
    }

    /**
     * 更新訊息內容
     * @param id 訊息ID
     * @param content 新內容
     */
    public void updateContent(Long id, String content) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            ChatMessage message = em.find(ChatMessage.class, id);
            if (message != null) {
                message.setContent(content);
                message.setUpdatedAt(new java.util.Date());
                em.merge(message);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to update message content: " + ex.getMessage());
        } finally {
            em.close();
        }
    }

    /**
     * 保存訊息
     * @param message 訊息實體
     * @return 保存的訊息
     */
    public ChatMessage save(ChatMessage message) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(message);
            em.getTransaction().commit();
            return message;
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to save message: " + ex.getMessage());
        } finally {
            em.close();
        }
    }

    /**
     * 查詢某個訊息之前的訊息
     * @param roomId 聊天室ID
     * @param beforeMessageId 基準訊息ID
     * @param limit 限制數量
     * @return 訊息清單
     */
    public List<ChatMessage> findMessagesBefore(Long roomId, Long beforeMessageId, int limit) {
        EntityManager em = getEntityManager();
        try {
            // 取得基準訊息的建立時間
            ChatMessage baseMessage = em.find(ChatMessage.class, beforeMessageId);
            if (baseMessage == null) {
                return new ArrayList<>();
            }
            
            Query q = em.createQuery(
                "SELECT m FROM ChatMessage m WHERE m.roomId = :roomId AND m.createdAt < :baseTime AND m.deletedAt IS NULL ORDER BY m.createdAt DESC"
            );
            q.setParameter("roomId", roomId);
            q.setParameter("baseTime", baseMessage.getCreatedAt());
            q.setMaxResults(limit);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
