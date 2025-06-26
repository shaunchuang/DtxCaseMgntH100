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
 * 聊天訊息
 *
 * @author system
 */
@Entity
@Table(name = "chat_message")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ChatMessage.findAll", query = "SELECT c FROM ChatMessage c WHERE c.deletedAt IS NULL ORDER BY c.createdAt ASC"),
    @NamedQuery(name = "ChatMessage.findByRoomId", query = "SELECT c FROM ChatMessage c WHERE c.roomId = :roomId AND c.deletedAt IS NULL ORDER BY c.createdAt ASC"),
    @NamedQuery(name = "ChatMessage.findBySenderId", query = "SELECT c FROM ChatMessage c WHERE c.senderId = :senderId AND c.deletedAt IS NULL ORDER BY c.createdAt DESC"),
    @NamedQuery(name = "ChatMessage.findByRoomIdAndSender", query = "SELECT c FROM ChatMessage c WHERE c.roomId = :roomId AND c.senderId = :senderId AND c.deletedAt IS NULL ORDER BY c.createdAt ASC"),
    @NamedQuery(name = "ChatMessage.findRecentByRoomId", query = "SELECT c FROM ChatMessage c WHERE c.roomId = :roomId AND c.deletedAt IS NULL ORDER BY c.createdAt DESC")
})
public class ChatMessage implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "room_id", nullable = false)
    private Long roomId;

    @Column(name = "sender_id", nullable = false)
    private Long senderId;

    @Column(name = "content", columnDefinition = "LONGTEXT")
    private String content;

    @Column(name = "file_url", length = 255)
    private String fileUrl;

    @Column(name = "created_at", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "updated_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;

    @Column(name = "deleted_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date deletedAt;

    public ChatMessage() {
    }

    public ChatMessage(Long roomId, Long senderId, String content) {
        this.roomId = roomId;
        this.senderId = senderId;
        this.content = content;
        this.createdAt = new Date();
    }

    public ChatMessage(Long roomId, Long senderId, String content, String fileUrl) {
        this.roomId = roomId;
        this.senderId = senderId;
        this.content = content;
        this.fileUrl = fileUrl;
        this.createdAt = new Date();
    }

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getRoomId() {
        return roomId;
    }

    public void setRoomId(Long roomId) {
        this.roomId = roomId;
    }

    public Long getSenderId() {
        return senderId;
    }

    public void setSenderId(Long senderId) {
        this.senderId = senderId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Date getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(Date deletedAt) {
        this.deletedAt = deletedAt;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof ChatMessage)) {
            return false;
        }
        ChatMessage other = (ChatMessage) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ChatMessage[ id=" + id + ", roomId=" + roomId + ", senderId=" + senderId + " ]";
    }
}
