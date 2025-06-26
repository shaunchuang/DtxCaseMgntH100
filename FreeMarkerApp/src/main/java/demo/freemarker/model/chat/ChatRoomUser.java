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
 * 聊天室成員
 *
 * @author system
 */
@Entity
@Table(name = "chat_room_user")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ChatRoomUser.findAll", query = "SELECT c FROM ChatRoomUser c ORDER BY c.joinedAt DESC"),
    @NamedQuery(name = "ChatRoomUser.findByRoomId", query = "SELECT c FROM ChatRoomUser c WHERE c.roomId = :roomId ORDER BY c.joinedAt ASC"),
    @NamedQuery(name = "ChatRoomUser.findByUserId", query = "SELECT c FROM ChatRoomUser c WHERE c.userId = :userId ORDER BY c.joinedAt DESC"),
    @NamedQuery(name = "ChatRoomUser.findByRoomAndUser", query = "SELECT c FROM ChatRoomUser c WHERE c.roomId = :roomId AND c.userId = :userId"),
    @NamedQuery(name = "ChatRoomUser.deleteByRoomAndUser", query = "DELETE FROM ChatRoomUser c WHERE c.roomId = :roomId AND c.userId = :userId")
})
public class ChatRoomUser implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "room_id", nullable = false)
    private Long roomId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "joined_at", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date joinedAt;

    public ChatRoomUser() {
    }

    public ChatRoomUser(Long roomId, Long userId) {
        this.roomId = roomId;
        this.userId = userId;
        this.joinedAt = new Date();
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

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Date getJoinedAt() {
        return joinedAt;
    }

    public void setJoinedAt(Date joinedAt) {
        this.joinedAt = joinedAt;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof ChatRoomUser)) {
            return false;
        }
        ChatRoomUser other = (ChatRoomUser) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ChatRoomUser[ id=" + id + ", roomId=" + roomId + ", userId=" + userId + " ]";
    }
}
