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
 * 聊天室
 *
 * @author system
 */
@Entity
@Table(name = "chat_room")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ChatRoom.findAll", query = "SELECT c FROM ChatRoom c WHERE c.deletedAt IS NULL ORDER BY c.createdAt DESC"),
    @NamedQuery(name = "ChatRoom.findByName", query = "SELECT c FROM ChatRoom c WHERE c.name LIKE :name AND c.deletedAt IS NULL"),
    @NamedQuery(name = "ChatRoom.findByUser", query = "SELECT DISTINCT cr FROM ChatRoom cr JOIN ChatRoomUser cru ON cr.id = cru.roomId WHERE cru.userId = :userId AND cr.deletedAt IS NULL ORDER BY cr.updatedAt DESC"),
})
public class ChatRoom implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false, length = 255)
    private String name;

    @Column(name = "photo_url", length = 255)
    private String photoUrl;

    @Column(name = "created_at", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "updated_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;

    @Column(name = "deleted_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date deletedAt;

    public ChatRoom() {
    }

    public ChatRoom(String name) {
        this.name = name;
        this.createdAt = new Date();
    }

    public ChatRoom(String name, Long creatorId) {
        this.name = name;
        this.createdAt = new Date();
    }

    public ChatRoom(String name, String photoUrl) {
        this.name = name;
        this.photoUrl = photoUrl;
        this.createdAt = new Date();
    }

    public ChatRoom(String name, String photoUrl, Long creatorId) {
        this.name = name;
        this.photoUrl = photoUrl;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
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
        if (!(object instanceof ChatRoom)) {
            return false;
        }
        ChatRoom other = (ChatRoom) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

}
