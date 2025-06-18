package demo.freemarker.api;

import demo.freemarker.dao.SpeechDevIssueCategoryDAO;
import demo.freemarker.model.SpeechDevIssueCategory;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * 語言發展問題分類 API
 */
public class SpeechDevIssueCategoryAPI implements API {

    private final static SpeechDevIssueCategoryAPI INSTANCE = new SpeechDevIssueCategoryAPI();

    public final static SpeechDevIssueCategoryAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "SpeechDevIssueCategoryAPI";
    }

    @Override
    public String getVersion() {
        return "20250617.01";
    }

    @Override
    public String getDescription() {
        return "語言發展問題分類 API";
    }

    public List<SpeechDevIssueCategory> listAll() {
        try {
            List<SpeechDevIssueCategory> output = new ArrayList<>();
            List<IntIdDataEntity> list = SpeechDevIssueCategoryDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((SpeechDevIssueCategory) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<SpeechDevIssueCategory> listLocale(Locale locale) {
        try {
            List<IntIdDataEntity> rawList = SpeechDevIssueCategoryDAO
                .getInstance()
                .findEntities();

            List<SpeechDevIssueCategory> output = new ArrayList<>(rawList.size());
            for (IntIdDataEntity entity : rawList) {
                SpeechDevIssueCategory sdc = (SpeechDevIssueCategory) entity;
                String localized = sdc.getLocaleName(locale);
                sdc.setName(localized);
                output.add(sdc);
            }

            return output;
        } catch (Exception ex) {
            throw new RuntimeException(
                "取得多語系語言發展問題類別失敗: " + ex.getMessage(), ex
            );
        }
    }

    public SpeechDevIssueCategory getById(long id) {
        try {
            return (SpeechDevIssueCategory) SpeechDevIssueCategoryDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void create(SpeechDevIssueCategory entity) {
        try {
            SpeechDevIssueCategoryDAO.getInstance().create(entity);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void update(SpeechDevIssueCategory entity) {
        try {
            SpeechDevIssueCategoryDAO.getInstance().edit(entity);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void delete(long id) {
        try {
            SpeechDevIssueCategoryDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<SpeechDevIssueCategory> listByName(String name) {
        return SpeechDevIssueCategoryDAO.getInstance().findByName(name);
    }
}
