package demo.freemarker.dao;

import demo.freemarker.model.DiseaseCategory;
import itri.sstc.framework.core.database.IntIdBaseDAO;

public class DiseaseCategoryDAO extends IntIdBaseDAO {
    final static DiseaseCategoryDAO instance = new DiseaseCategoryDAO("DTXCASEMGNT_PU");

    public final static DiseaseCategoryDAO getInstance() {
        return instance;
    }

    private DiseaseCategoryDAO(String puName) {
        super(puName, DiseaseCategory.class);
    }

    @Override
    public String getTableName() {
        return "DiseaseCategory";
    }

}
