package demo.freemarker.model.chat;

import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 聊天訊息已讀狀態
 *
 * @author system
 */
@Entity
@Table(name = "chat_message_read")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ChatMessageRead.findAll", query = "SELECT c FROM ChatMessageRead c ORDER BY c.readAt DESC"),
    @NamedQuery(name = "ChatMessageRead.findByMessageId", query = "SELECT c FROM ChatMessageRead c WHERE c.messageId = :messageId ORDER BY c.readAt ASC"),
    @NamedQuery(name = "ChatMessageRead.findByUserId", query = "SELECT c FROM ChatMessageRead c WHERE c.userId = :userId ORDER BY c.readAt DESC"),
    @NamedQuery(name = "ChatMessageRead.findByMessageAndUser", query = "SELECT c FROM ChatMessageRead c WHERE c.messageId = :messageId AND c.userId = :userId"),
    @NamedQuery(name = "ChatMessageRead.findUnreadByUser", query = "SELECT c FROM ChatMessageRead c WHERE c.userId = :userId AND c.isRead = false ORDER BY c.id ASC"),
    @NamedQuery(name = "ChatMessageRead.findReadByUser", query = "SELECT c FROM ChatMessageRead c WHERE c.userId = :userId AND c.isRead = true ORDER BY c.readAt DESC")
})
public class ChatMessageRead implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "message_id", nullable = false)
    private Long messageId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "is_read", nullable = false)
    private Boolean isRead = false;

    @Column(name = "read_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date readAt;

    public ChatMessageRead() {
    }

    public ChatMessageRead(Long messageId, Long userId) {
        this.messageId = messageId;
        this.userId = userId;
        this.isRead = false;
    }

    public ChatMessageRead(Long messageId, Long userId, Boolean isRead) {
        this.messageId = messageId;
        this.userId = userId;
        this.isRead = isRead;
        if (isRead) {
            this.readAt = new Date();
        }
    }

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getMessageId() {
        return messageId;
    }

    public void setMessageId(Long messageId) {
        this.messageId = messageId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Boolean getIsRead() {
        return isRead;
    }

    public void setIsRead(Boolean isRead) {
        this.isRead = isRead;
        if (isRead && this.readAt == null) {
            this.readAt = new Date();
        }
    }

    public Date getReadAt() {
        return readAt;
    }

    public void setReadAt(Date readAt) {
        this.readAt = readAt;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof ChatMessageRead)) {
            return false;
        }
        ChatMessageRead other = (ChatMessageRead) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ChatMessageRead[ id=" + id + ", messageId=" + messageId + ", userId=" + userId + ", isRead=" + isRead + " ]";
    }
}
