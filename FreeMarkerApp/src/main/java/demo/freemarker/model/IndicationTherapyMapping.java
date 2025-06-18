/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 適應症與治療類別對應表
 * 
 * @author zhush
 */
@Entity
@Table(name = "indication_therapy_mapping")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "IndicationTherapyMapping.findByIndicationId", 
                query = "SELECT c FROM IndicationTherapyMapping c WHERE c.indicationId = :indicationId"),
    @NamedQuery(name = "IndicationTherapyMapping.findByTherapyType", 
                query = "SELECT c FROM IndicationTherapyMapping c WHERE c.therapyType = :therapyType"),
    @NamedQuery(name = "IndicationTherapyMapping.findByIndicationAndTherapy", 
                query = "SELECT c FROM IndicationTherapyMapping c WHERE c.indicationId = :indicationId AND c.therapyType = :therapyType")
})
public class IndicationTherapyMapping implements Serializable {
    
    private static final long serialVersionUID = 1822831976401L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "indication_id", nullable = false)
    private Long indicationId;        // 適應症ID (對應DiseaseCategory的id)
    
    @Column(name = "\"therapy_type\"", nullable = false, length = 10)
    private String therapyType;      // 治療類別 (OT, ST, PT, CP, PS)
    
    @ManyToOne
    @JoinColumn(name = "indication_id", insertable = false, updatable = false)
    private DiseaseCategory diseaseCategory;
    
    public IndicationTherapyMapping() {
    }
    
    public IndicationTherapyMapping(Long indicationId, String therapyType) {
        this.indicationId = indicationId;
        this.therapyType = therapyType;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIndicationId() {
        return indicationId;
    }

    public void setIndicationId(Long indicationId) {
        this.indicationId = indicationId;
    }

    public String getTherapyType() {
        return therapyType;
    }

    public void setTherapyType(String therapyType) {
        this.therapyType = therapyType;
    }

    public DiseaseCategory getDiseaseCategory() {
        return diseaseCategory;
    }

    public void setDiseaseCategory(DiseaseCategory diseaseCategory) {
        this.diseaseCategory = diseaseCategory;
    }
    
    @Override
    public String toString() {
        return "IndicationTherapyMapping{" +
                "id=" + id +
                ", indicationId=" + indicationId +
                ", therapyType='" + therapyType + '\'' +
                '}';
    }
}
