package demo.freemarker.dao.chat;

import demo.freemarker.model.chat.ChatMessageRead;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * 聊天訊息已讀狀態 DAO
 *
 * @author system
 */
public class ChatMessageReadDAO extends IntIdBaseDAO {

    final static ChatMessageReadDAO instance = new ChatMessageReadDAO("DTXCASEMGNT_PU");

    public final static ChatMessageReadDAO getInstance() {
        return instance;
    }

    private ChatMessageReadDAO(String puName) {
        super(puName, ChatMessageRead.class);
    }

    @Override
    public String getTableName() {
        return "chat_message_read";
    }

    /**
     * 根據訊息ID查詢已讀狀態
     * @param messageId 訊息ID
     * @return 已讀狀態清單
     */
    public List<ChatMessageRead> findByMessageId(Long messageId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatMessageRead.findByMessageId");
            q.setParameter("messageId", messageId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 根據使用者ID查詢已讀狀態
     * @param userId 使用者ID
     * @return 已讀狀態清單
     */
    public List<ChatMessageRead> findByUserId(Long userId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatMessageRead.findByUserId");
            q.setParameter("userId", userId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 查詢特定訊息和使用者的已讀狀態
     * @param messageId 訊息ID
     * @param userId 使用者ID
     * @return 已讀狀態實體，如果不存在則返回null
     */
    public ChatMessageRead findByMessageAndUser(Long messageId, Long userId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatMessageRead.findByMessageAndUser");
            q.setParameter("messageId", messageId);
            q.setParameter("userId", userId);
            List<ChatMessageRead> results = q.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * 查詢使用者的未讀訊息
     * @param userId 使用者ID
     * @return 未讀訊息清單
     */
    public List<ChatMessageRead> findUnreadByUser(Long userId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatMessageRead.findUnreadByUser");
            q.setParameter("userId", userId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 查詢使用者的已讀訊息
     * @param userId 使用者ID
     * @return 已讀訊息清單
     */
    public List<ChatMessageRead> findReadByUser(Long userId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ChatMessageRead.findReadByUser");
            q.setParameter("userId", userId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * 標記訊息為已讀
     * @param messageId 訊息ID
     * @param userId 使用者ID
     * @return 成功則返回true
     */
    public boolean markAsRead(Long messageId, Long userId) {
        ChatMessageRead existing = findByMessageAndUser(messageId, userId);
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            if (existing != null) {
                // 更新現有記錄
                existing.setIsRead(true);
                em.merge(existing);
            } else {
                // 創建新記錄
                ChatMessageRead readStatus = new ChatMessageRead(messageId, userId, true);
                em.persist(readStatus);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to mark message as read: " + ex.getMessage());
        } finally {
            em.close();
        }
    }

    /**
     * 標記訊息為未讀
     * @param messageId 訊息ID
     * @param userId 使用者ID
     * @return 成功則返回true
     */
    public boolean markAsUnread(Long messageId, Long userId) {
        ChatMessageRead existing = findByMessageAndUser(messageId, userId);
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            if (existing != null) {
                existing.setIsRead(false);
                existing.setReadAt(null);
                em.merge(existing);
            } else {
                // 創建新記錄
                ChatMessageRead readStatus = new ChatMessageRead(messageId, userId, false);
                em.persist(readStatus);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw new RuntimeException("Failed to mark message as unread: " + ex.getMessage());
        } finally {
            em.close();
        }
    }

    /**
     * 檢查訊息是否已被使用者讀取
     * @param messageId 訊息ID
     * @param userId 使用者ID
     * @return 已讀則返回true
     */
    public boolean isMessageRead(Long messageId, Long userId) {
        ChatMessageRead readStatus = findByMessageAndUser(messageId, userId);
        return readStatus != null && readStatus.getIsRead();
    }

    /**
     * 獲取使用者的未讀訊息數量
     * @param userId 使用者ID
     * @return 未讀訊息數量
     */
    public long getUnreadCount(Long userId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createQuery("SELECT COUNT(c) FROM ChatMessageRead c WHERE c.userId = :userId AND c.isRead = false");
            q.setParameter("userId", userId);
            return (Long) q.getSingleResult();
        } catch (Exception ex) {
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * 獲取使用者在特定聊天室的未讀訊息數量
     * @param roomId 聊天室ID
     * @param userId 使用者ID
     * @return 未讀訊息數量
     */
    public int getUnreadCountByRoom(Long roomId, Long userId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createQuery(
                "SELECT COUNT(c) FROM ChatMessageRead c " +
                "JOIN ChatMessage m ON c.messageId = m.id " +
                "WHERE c.userId = :userId AND c.isRead = false AND m.roomId = :roomId"
            );
            q.setParameter("userId", userId);
            q.setParameter("roomId", roomId);
            Long result = (Long) q.getSingleResult();
            return result.intValue();
        } catch (Exception ex) {
            return 0;
        } finally {
            em.close();
        }
    }
}
