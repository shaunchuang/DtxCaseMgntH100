package demo.freemarker.model;

import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "\"drug_use_status_category\"")
@XmlRootElement
public class DrugUseStatusCategory implements IntIdDataEntity, Serializable  {
    
    private static final long serialVersionUID = 182284197653309L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "\"name\"", nullable = false, length = 100)
    private String name;

    public DrugUseStatusCategory() { }
    
    public DrugUseStatusCategory(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
