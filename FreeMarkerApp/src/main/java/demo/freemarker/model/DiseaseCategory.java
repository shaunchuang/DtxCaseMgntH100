package demo.freemarker.model;

import demo.freemarker.core.MessageSource;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import java.util.Locale;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "\"disease_category\"")
public class DiseaseCategory implements IntIdDataEntity, Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"name\"", nullable = false, length = 100)
    private String name;

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
    
    public String getLocaleName(Locale locale){
        return MessageSource.getMessage(this.name, locale);
    }

}
