package demo.freemarker.api.scale;

import demo.freemarker.api.assessment.AssessmentAPI;
import demo.freemarker.api.assessment.AssessmentResultAPI;
import java.util.ArrayList;

import demo.freemarker.dao.scale.ScaleDAO;
import demo.freemarker.dto.AssessmentFinalResult;
import demo.freemarker.dto.QuestionEvaluationType;
import demo.freemarker.dto.QuestionItem;
import demo.freemarker.dto.QuestionOpt;
import demo.freemarker.dto.ScaleForm;
import demo.freemarker.dto.Section;
import demo.freemarker.model.assessment.Assessment;
import demo.freemarker.model.scale.Scale;
import demo.freemarker.model.scale.ScaleItem;
import demo.freemarker.model.scale.ScaleItemOption;
import demo.freemarker.model.scale.ScaleLevel;
import demo.freemarker.model.scale.ScaleSection;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.Date;
import java.util.List;

public class ScaleAPI implements API {

    private final static ScaleAPI INSTANCE = new ScaleAPI();

    public final static ScaleAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "ScaleAPI";
    }

    @Override
    public String getVersion() {
        return "20250423.1";
    }

    @Override
    public String getDescription() {
        return "量表 API";
    }

    public List<Scale> listScales() {
        List<Scale> list = new ArrayList<>();
        try {
            List<IntIdDataEntity> entities = ScaleDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : entities) {
                list.add((Scale) entity);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }

    @APIDefine(description = "根據ID取得量表")
    public Scale getScale(Long id) {
        try {
            return (Scale) ScaleDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "新增量表")
    public void createScale(Scale scale) {
        try {
            ScaleDAO.getInstance().create(scale);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "更新量表")
    public void updateScale(Scale scale) {
        try {
            ScaleDAO.getInstance().edit(scale);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "刪除量表")
    public void deleteScale(Long id) {
        try {
            ScaleDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據名稱取得量表")
    public List<Scale> listScalesByParam(String param) {
        try {
            return ScaleDAO.getInstance().findByParam(param);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }

    @APIDefine(description = "根據類別取得量表")
    public List<Scale> listScalesByCat(String category) {
        try {
            return ScaleDAO.getInstance().findByCategory(category);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }

    public ScaleForm findScaleFormById(Long id) {
        List<ScaleLevel> levels = new ArrayList<ScaleLevel>();
        List<ScaleItem> scalesItems = new ArrayList<ScaleItem>();
        List<ScaleItemOption> scalesItemOptions = new ArrayList<ScaleItemOption>();
        List<Section> scalesSections = new ArrayList<Section>();
        List<QuestionEvaluationType> types = new ArrayList<QuestionEvaluationType>();
        List<QuestionItem> items = new ArrayList<QuestionItem>();
        List<QuestionOpt> opts = null;

        Scale scale = this.getScale(id);
        if (scale != null) {
            ScaleForm scalesForm = new ScaleForm();
            scalesForm.setId(scale.getId());
            scalesForm.setName(scale.getName());
            scalesForm.setType(scale.getType());
            scalesForm.setEvaluator(scale.getEvaluator());
            scalesForm.setDesc(scale.getDescription());
            scalesForm.setVersion(scale.getVersion());
            scalesForm.setCreateTime(scale.getCreateTime());

            //非多項驗測量表適用
            List<ScaleSection> sections = ScaleSectionAPI.getInstance().listScaleSectionByScaleId(scale.getId());
            if (sections.size() > 0) {

                for (ScaleSection section : sections) {
                    Section scaleSection = new Section();
                    scaleSection.setId(section.getId());
                    scaleSection.setSectionNo(section.getSectionNo());
                    scaleSection.setTitle(section.getName());
                    scaleSection.setNote(section.getNote());
                    List<String> evaluationTypes = ScaleItemAPI.getInstance().listEvaluationType(scale.getId(), section.getId());
                    scaleSection.setEvaluationTypes(evaluationTypes);

                    scalesItems = ScaleItemAPI.getInstance().listScaleItemByScaleIdAndSectionId(scale.getId(), section.getId());

                    if (scalesItems.size() > 0) {
                        items = new ArrayList<QuestionItem>();

                        for (ScaleItem scalesItem : scalesItems) {
                            QuestionItem item = new QuestionItem();
                            item.setId(scalesItem.getId());
                            Long parentItemNo = ScaleItemAPI.getInstance().findParentItemNo(scalesItem.getId());
                            item.setParentItemNo(parentItemNo);
                            item.setItemNo(scalesItem.getItemNo());
                            item.setQuestion(scalesItem.getQuestion());
                            item.setItemType(scalesItem.getItemType());
                            item.setScoreMin(scalesItem.getScoreMin());
                            item.setScoreMax(scalesItem.getScoreMax());
                            item.setLabelLeft(scalesItem.getLabelLeft());
                            item.setLabelRight(scalesItem.getLabelRight());
                            item.setHorizontalView(scalesItem.getHorizontalView());
                            item.setNote(scalesItem.getNote());
                            item.setHasParentQues(ScaleItemAPI.getInstance().hasParentItem(scalesItem.getId()));

                            List<ScaleItem> childItems = ScaleItemAPI.getInstance().listChildScaleItem(scalesItem.getId());

                            if (childItems.size() > 0) {
                                types = new ArrayList<QuestionEvaluationType>();

                                for (ScaleItem childItem : childItems) {
                                    QuestionEvaluationType questionEvaluationType = new QuestionEvaluationType();
                                    scalesItemOptions = ScaleItemOptionAPI.getInstance().listScalesItemOptionByScaleItemId(childItem.getId());

                                    if (scalesItemOptions.size() > 0) {
                                        opts = new ArrayList<QuestionOpt>();

                                        for (ScaleItemOption scalesItemOption : scalesItemOptions) {
                                            QuestionOpt opt = new QuestionOpt();
                                            opt.setId(scalesItemOption.getId());
                                            opt.setOptionNo(scalesItemOption.getOptionNo());
                                            opt.setOptionText(scalesItemOption.getOptionText());
                                            opt.setScore(scalesItemOption.getScore());
                                            opts.add(opt);
                                        }
                                        questionEvaluationType.setIsSingleChoice(childItem.getIsSingleChoice());
                                        questionEvaluationType.setEvaluationType(childItem.getEvaluationType());
                                        questionEvaluationType.setOpts(opts);
                                    }

                                    //item.itemNo = childItem.getItemNo();
                                    types.add(questionEvaluationType);
                                }
                                item.setQuestionEvaluationTypes(types);
                            } else {
                                scalesItemOptions = ScaleItemOptionAPI.getInstance().listScalesItemOptionByScaleItemId(scalesItem.getId());
                                if (scalesItemOptions.size() > 0) {
                                    opts = new ArrayList<QuestionOpt>();

                                    for (ScaleItemOption scalesItemOption : scalesItemOptions) {
                                        QuestionOpt opt = new QuestionOpt();
                                        opt.setId(scalesItemOption.getId());
                                        opt.setOptionNo(scalesItemOption.getOptionNo());
                                        opt.setOptionText(scalesItemOption.getOptionText());
                                        opt.setScore(scalesItemOption.getScore());
                                        opts.add(opt);
                                    }
                                    item.setOpts(opts);
                                }
                            }

                            items.add(item);
                        }
                        scaleSection.setItems(items);
                    }
                    scalesSections.add(scaleSection);
                }
                scalesForm.setSections(scalesSections);
            } else {
                scalesItems = ScaleItemAPI.getInstance().listScaleItemByScaleId(scale.getId());
                if (scalesItems.size() > 0) {
                    items = new ArrayList<QuestionItem>();

                    for (ScaleItem scalesItem : scalesItems) {
                        QuestionItem item = new QuestionItem();
                        item.setId(scalesItem.getId());
                        Long parentItemNo = ScaleItemAPI.getInstance().findParentItemNo(scalesItem.getId());
                        item.setParentItemNo(parentItemNo);
                        item.setItemNo(scalesItem.getItemNo());
                        item.setQuestion(scalesItem.getQuestion());
                        item.setItemType(scalesItem.getItemType());
                        item.setScoreMin(scalesItem.getScoreMin());
                        item.setScoreMax(scalesItem.getScoreMax());
                        item.setLabelLeft(scalesItem.getLabelLeft());
                        item.setLabelRight(scalesItem.getLabelRight());
                        item.setHorizontalView(scalesItem.getHorizontalView());
                        item.setNote(scalesItem.getNote());
                        item.setHasParentQues(ScaleItemAPI.getInstance().hasParentItem(scalesItem.getId()));

                        List<ScaleItem> childItems = ScaleItemAPI.getInstance().listChildScaleItem(scalesItem.getId());

                        if (childItems.size() > 0) {
                            types = new ArrayList<QuestionEvaluationType>();

                            for (ScaleItem childItem : childItems) {
                                QuestionEvaluationType questionEvaluationType = new QuestionEvaluationType();
                                scalesItemOptions = ScaleItemOptionAPI.getInstance().listScalesItemOptionByScaleItemId(childItem.getId());

                                if (scalesItemOptions.size() > 0) {
                                    opts = new ArrayList<QuestionOpt>();

                                    for (ScaleItemOption scalesItemOption : scalesItemOptions) {
                                        QuestionOpt opt = new QuestionOpt();
                                        opt.setId(scalesItemOption.getId());
                                        opt.setOptionNo(scalesItemOption.getOptionNo());
                                        opt.setOptionText(scalesItemOption.getOptionText());
                                        opt.setScore(scalesItemOption.getScore());
                                        opts.add(opt);
                                    }
                                    questionEvaluationType.setIsSingleChoice(childItem.getIsSingleChoice());
                                    questionEvaluationType.setEvaluationType(childItem.getEvaluationType());
                                    questionEvaluationType.setOpts(opts);
                                }

                                //item.itemNo = childItem.getItemNo();
                                types.add(questionEvaluationType);
                            }
                            item.setQuestionEvaluationTypes(types);
                        } else {
                            scalesItemOptions = ScaleItemOptionAPI.getInstance().listScalesItemOptionByScaleItemId(scalesItem.getId());
                            if (scalesItemOptions.size() > 0) {
                                opts = new ArrayList<QuestionOpt>();

                                for (ScaleItemOption scalesItemOption : scalesItemOptions) {
                                    QuestionOpt opt = new QuestionOpt();
                                    opt.setId(scalesItemOption.getId());
                                    opt.setOptionNo(scalesItemOption.getOptionNo());
                                    opt.setOptionText(scalesItemOption.getOptionText());
                                    opt.setScore(scalesItemOption.getScore());
                                    opts.add(opt);
                                }
                                item.setOpts(opts);
                            }
                        }

                        items.add(item);
                    }
                    scalesForm.setItems(items);
                }
            }
            List<ScaleLevel> scalesLevels = ScaleLevelAPI.getInstance().listByScaleId(scale.getId());
            if (scalesLevels.size() > 0) {
                for (ScaleLevel scalesLevel : scalesLevels) {
                    ScaleLevel levelItem = new ScaleLevel();
                    levelItem.setId(scalesLevel.getId());
                    levelItem.setLowScore(scalesLevel.getLowScore());
                    levelItem.setHighScore(scalesLevel.getHighScore());
                    levelItem.setLevel(scalesLevel.getLevel());
                    levels.add(levelItem);
                }
                scalesForm.setLevels(levels);
            }

            return scalesForm;
        }
        return null;
    }

    /* 自定義 ScalesForm 物件取得 */
    public ScaleForm findScaleFormByAssessmentId(Long assessmentId) {
        List<ScaleLevel> levels = new ArrayList<ScaleLevel>();
        List<ScaleItem> scalesItems = new ArrayList<ScaleItem>();
        List<ScaleItemOption> scalesItemOptions = new ArrayList<ScaleItemOption>();
        List<Section> scalesSections = new ArrayList<Section>();
        List<QuestionEvaluationType> types = new ArrayList<QuestionEvaluationType>();
        List<QuestionItem> items = new ArrayList<QuestionItem>();
        List<QuestionOpt> opts = null;

        Assessment assessment = AssessmentAPI.getInstance().getAssessment(assessmentId);

        if (assessment != null) {

            Scale scale = this.getScale(assessment.getScaleId());
            if (scale != null) {
                ScaleForm scalesForm = new ScaleForm();
                scalesForm.setId(scale.getId());
                scalesForm.setName(scale.getName());
                scalesForm.setType(scale.getType());
                scalesForm.setEvaluator(scale.getEvaluator());
                scalesForm.setDesc(scale.getDescription());
                scalesForm.setVersion(scale.getVersion());
                scalesForm.setCreateTime(scale.getCreateTime());
                List<ScaleSection> sections = ScaleSectionAPI.getInstance().listScaleSectionByScaleId(scale.getId());
                if (sections.size() > 0) {

                    for (ScaleSection section : sections) {
                        Section scaleSection = new Section();
                        scaleSection.setId(section.getId());
                        scaleSection.setSectionNo(section.getSectionNo());
                        scaleSection.setTitle(section.getName());
                        scaleSection.setNote(section.getNote());
                        List<String> evaluationTypes = ScaleItemAPI.getInstance().listEvaluationType(scale.getId(), section.getId());
                        scaleSection.setEvaluationTypes(evaluationTypes);
                        scalesItems = ScaleItemAPI.getInstance().listScaleItemByScaleIdAndSectionId(scale.getId(), section.getId());
                        if (scalesItems.size() > 0) {
                            items = new ArrayList<QuestionItem>();

                            for (ScaleItem scalesItem : scalesItems) {
                                QuestionItem item = new QuestionItem();
                                item.setId(scalesItem.getId());
                                Long parentItemNo = ScaleItemAPI.getInstance().findParentItemNo(scalesItem.getId());
                                item.setParentItemNo(parentItemNo);
                                item.setItemNo(scalesItem.getItemNo());
                                item.setQuestion(scalesItem.getQuestion());
                                item.setItemType(scalesItem.getItemType());
                                item.setScoreMin(scalesItem.getScoreMin());
                                item.setScoreMax(scalesItem.getScoreMax());
                                item.setLabelLeft(scalesItem.getLabelLeft());
                                item.setLabelRight(scalesItem.getLabelRight());
                                item.setHorizontalView(scalesItem.getHorizontalView());
                                item.setNote(scalesItem.getNote());
                                item.setHasParentQues(ScaleItemAPI.getInstance().hasParentItem(scalesItem.getId()));

                                List<ScaleItem> childItems = ScaleItemAPI.getInstance().listChildScaleItem(scalesItem.getId());

                                if (childItems.size() > 0) {
                                    types = new ArrayList<QuestionEvaluationType>();

                                    for (ScaleItem childItem : childItems) {
                                        QuestionEvaluationType questionEvaluationType = new QuestionEvaluationType();
                                        scalesItemOptions = ScaleItemOptionAPI.getInstance().listScalesItemOptionByScaleItemId(childItem.getId());

                                        if (scalesItemOptions.size() > 0) {
                                            opts = new ArrayList<QuestionOpt>();

                                            for (ScaleItemOption scalesItemOption : scalesItemOptions) {
                                                QuestionOpt opt = new QuestionOpt();
                                                opt.setId(scalesItemOption.getId());
                                                opt.setOptionNo(scalesItemOption.getOptionNo());
                                                opt.setOptionText(scalesItemOption.getOptionText());
                                                opt.setScore(scalesItemOption.getScore());
                                                Boolean checked = AssessmentResultAPI.getInstance().checkAssessmentResultExist(assessment.getId(), scalesItem.getId(), scalesItemOption.getId());
                                                opt.setChecked(checked);
                                                opts.add(opt);
                                            }
                                            questionEvaluationType.setIsSingleChoice(childItem.getIsSingleChoice());
                                            questionEvaluationType.setEvaluationType(childItem.getEvaluationType());
                                            questionEvaluationType.setOpts(opts);
                                        }

                                        //item.itemNo = childItem.getItemNo();
                                        types.add(questionEvaluationType);
                                    }
                                    item.setQuestionEvaluationTypes(types);
                                } else {
                                    scalesItemOptions = ScaleItemOptionAPI.getInstance().listScalesItemOptionByScaleItemId(scalesItem.getId());
                                    if (scalesItemOptions.size() > 0) {
                                        opts = new ArrayList<QuestionOpt>();

                                        for (ScaleItemOption scalesItemOption : scalesItemOptions) {
                                            QuestionOpt opt = new QuestionOpt();
                                            opt.setId(scalesItemOption.getId());
                                            opt.setOptionNo(scalesItemOption.getOptionNo());
                                            opt.setOptionText(scalesItemOption.getOptionText());
                                            opt.setScore(scalesItemOption.getScore());
                                            Boolean checked = AssessmentResultAPI.getInstance().checkAssessmentResultExist(assessment.getId(), scalesItem.getId(), scalesItemOption.getId());
                                            opt.setChecked(checked);
                                            opts.add(opt);
                                        }
                                        item.setOpts(opts);
                                    }
                                }
                                int itemScore = AssessmentResultAPI.getInstance().findScoreByAssIdItemIdOpId(assessment.getId(), scalesItem.getId(), null);
                                item.setScore(itemScore);

                                items.add(item);
                            }
                            scaleSection.setItems(items);
                        }
                        scalesSections.add(scaleSection);
                    }
                    scalesForm.setSections(scalesSections);
                } else {
                    scalesItems = ScaleItemAPI.getInstance().listScaleItemByScaleId(scale.getId());
                    if (scalesItems.size() > 0) {
                        items = new ArrayList<QuestionItem>();

                        for (ScaleItem scalesItem : scalesItems) {
                            QuestionItem item = new QuestionItem();
                            item.setId(scalesItem.getId());
                            Long parentItemNo = ScaleItemAPI.getInstance().findParentItemNo(scalesItem.getId());
                            item.setParentItemNo(parentItemNo);
                            item.setItemNo(scalesItem.getItemNo());
                            item.setQuestion(scalesItem.getQuestion());
                            item.setItemType(scalesItem.getItemType());
                            item.setScoreMin(scalesItem.getScoreMin());
                            item.setScoreMax(scalesItem.getScoreMax());
                            item.setLabelLeft(scalesItem.getLabelLeft());
                            item.setLabelRight(scalesItem.getLabelRight());
                            item.setHorizontalView(scalesItem.getHorizontalView());
                            item.setNote(scalesItem.getNote());
                            item.setHasParentQues(ScaleItemAPI.getInstance().hasParentItem(scalesItem.getId()));

                            List<ScaleItem> childItems = ScaleItemAPI.getInstance().listChildScaleItem(scalesItem.getId());

                            if (childItems.size() > 0) {
                                types = new ArrayList<QuestionEvaluationType>();

                                for (ScaleItem childItem : childItems) {
                                    QuestionEvaluationType questionEvaluationType = new QuestionEvaluationType();
                                    scalesItemOptions = ScaleItemOptionAPI.getInstance().listScalesItemOptionByScaleItemId(childItem.getId());

                                    if (scalesItemOptions.size() > 0) {
                                        opts = new ArrayList<QuestionOpt>();

                                        for (ScaleItemOption scalesItemOption : scalesItemOptions) {
                                            QuestionOpt opt = new QuestionOpt();
                                            opt.setId(scalesItemOption.getId());
                                            opt.setOptionNo(scalesItemOption.getOptionNo());
                                            opt.setOptionText(scalesItemOption.getOptionText());
                                            opt.setScore(scalesItemOption.getScore());
                                            Boolean checked = AssessmentResultAPI.getInstance().checkAssessmentResultExist(assessment.getId(), scalesItem.getId(), scalesItemOption.getId());
                                            opt.setChecked(checked);
                                            opts.add(opt);
                                        }
                                        questionEvaluationType.setIsSingleChoice(childItem.getIsSingleChoice());
                                        questionEvaluationType.setEvaluationType(childItem.getEvaluationType());
                                        questionEvaluationType.setOpts(opts);
                                    }

                                    //item.itemNo = childItem.getItemNo();
                                    types.add(questionEvaluationType);
                                }
                                item.setQuestionEvaluationTypes(types);
                            } else {
                                scalesItemOptions = ScaleItemOptionAPI.getInstance().listScalesItemOptionByScaleItemId(item.getId());
                                if (scalesItemOptions.size() > 0) {
                                    opts = new ArrayList<QuestionOpt>();

                                    for (ScaleItemOption scalesItemOption : scalesItemOptions) {
                                        QuestionOpt opt = new QuestionOpt();
                                        opt.setId(scalesItemOption.getId());
                                        opt.setOptionNo(scalesItemOption.getOptionNo());
                                        opt.setOptionText(scalesItemOption.getOptionText());
                                        opt.setScore(scalesItemOption.getScore());
                                        Boolean checked = AssessmentResultAPI.getInstance().checkAssessmentResultExist(assessment.getId(), scalesItem.getId(), scalesItemOption.getId());
                                        opt.setChecked(checked);
                                        opts.add(opt);
                                    }
                                    item.setOpts(opts);
                                }
                            }

                            int itemScore = AssessmentResultAPI.getInstance().findScoreByAssIdItemIdOpId(assessment.getId(), scalesItem.getId(), null);
                            item.setScore(itemScore);
                            items.add(item);
                        }
                        scalesForm.setItems(items);
                    }
                }

                if (assessment.getScaleLevevlId() != null) {
                    ScaleLevel level = ScaleLevelAPI.getInstance().getScaleLevel(assessment.getScaleLevevlId());
                    if (level != null) {
                        AssessmentFinalResult result = new AssessmentFinalResult();
                        result.setTotalScore(assessment.getTotalScore());
                        result.setLevel(level.getLevel());
                        result.setColor(level.getColor());
                        result.setBgColor(level.getBgColor());
                        scalesForm.setResult(result);
                    }
                }

                return scalesForm;
            }
        }
        return null;
    }

    public List<Scale> listTodateAddScale(Long patientId, Date evalDate) {
        try {
            return ScaleDAO.getInstance().listTodateAddScale(patientId, evalDate);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<Long> listTodateAddScaleId(Long patientId, Date evalDate) {
        try {
            List<Scale> scales = ScaleDAO.getInstance().listTodateAddScale(patientId, evalDate);
            List<Long> scaleIds = new ArrayList<Long>();
                for (Scale scale : scales) {
                    scaleIds.add(scale.getId());
                }
            return scaleIds;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<Scale> listScalesByIdsAndDate(List<Long> scaleIds, boolean added) {
        try {
            if(scaleIds.size() > 0 ){
                if(added) {
                    return ScaleDAO.getInstance().listByIds(scaleIds);
                } else {
                    return ScaleDAO.getInstance().listNotInIds(scaleIds);
                }
            } else {
                return ScaleDAO.getInstance().listWithoutDeleteMark();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    public List<Scale> listSortByCat(boolean deleteMark) {
        try {
            return ScaleDAO.getInstance().listSortByCat(deleteMark);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }
}
