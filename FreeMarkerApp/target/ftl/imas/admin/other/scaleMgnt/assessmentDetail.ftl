<#include "/imas/widget/leftnav.ftl" />

<!-- 新增 CRUD 列表區 -->
<div id="assessmentCrud">
  <div class="toolbar">
    <button id="newAssessmentBtn" class="btn btn-success">新增評估量表</button>
  </div>
  <table id="assessmentTable" class="table table-bordered">
    <thead>
      <tr><th>評估表名稱</th><th>操作</th></tr>
    </thead>
    <tbody></tbody>
  </table>
</div>

<div class="assessment-form">
  <h3><@spring.message "assessment.detail.title"/>評估量表填寫</h3>
  <form id="assessmentDetailForm" class="form-horizontal">
    <div class="form-group">
      <label class="col-sm-2 control-label"><@spring.message "assessment.label.assessment"/>評估表</label>
      <div class="col-sm-6">
        <select id="assessmentSelect" class="form-control">
          <option value=""><@spring.message "common.select.placeholder"/>請選擇評估表</option>
        </select>
      </div>
    </div>

    <div class="form-group" id="sectionGroup" style="display:none;">
      <label class="col-sm-2 control-label"><@spring.message "assessment.label.section"/>區段</label>
      <div class="col-sm-6">
        <select id="sectionSelect" class="form-control">
          <option value=""><@spring.message "common.select.placeholder"/>請選擇區段</option>
        </select>
      </div>
    </div>

    <div class="form-group" id="questionGroup" style="display:none;">
      <label class="col-sm-2 control-label"><@spring.message "assessment.label.question"/>題目</label>
      <div class="col-sm-6">
        <select id="questionSelect" class="form-control">
          <option value=""><@spring.message "common.select.placeholder"/>請選擇題目</option>
        </select>
      </div>
    </div>

    <div class="form-group" id="subcategoryGroup" style="display:none;">
      <label class="col-sm-2 control-label"><@spring.message "assessment.label.subcategory"/>子分類</label>
      <div class="col-sm-6">
        <select id="subcategorySelect" class="form-control">
          <option value=""><@spring.message "common.select.placeholder"/>請選擇子分類</option>
        </select>
      </div>
    </div>

    <div class="form-group" id="optionGroup" style="display:none;">
      <label class="col-sm-2 control-label"><@spring.message "assessment.label.option"/>選項</label>
      <div class="col-sm-6">
        <div id="optionContainer"></div>
      </div>
    </div>

    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-6">
        <button type="submit" class="btn btn-primary"><@spring.message "common.button.save"/>儲存</button>
      </div>
    </div>
  </form>
</div>

<script>
  var $ = jQuery.noConflict();
  $(function(){
    var editId = null; // 當前編輯的評估表 ID

    // 載入評估表清單
    function loadList(){
      var res = wg.evalForm.getJson({}, "/Assessment/api/list");
      if(res.success){
        var $tb = $('#assessmentTable tbody').empty();
        $.each(res.result||res, function(i,a){
          var $tr = $('<tr>').append(
            $('<td>').text(a.assessmentName),
            $('<td>').append(
              $('<button>').addClass('edit-btn btn btn-sm btn-primary').text('編輯').data('id', a.id),
              ' ',
              $('<button>').addClass('del-btn btn btn-sm btn-danger').text('刪除').data('id', a.id)
            )
          );
          $tb.append($tr);
        });
      }
    }

    // 載入評估表下拉選單
    function loadAssessments(){
      var res = wg.evalForm.getJson({}, "/Assessment/api/list");
      if(res.success){
        var $sel = $('#assessmentSelect').empty().append('<option value="">請選擇評估表</option>');
        $.each(res.result||res, function(i,a){
          $sel.append($('<option>').val(a.id).text(a.assessmentName));
        });
      }
    }

    loadList();
    loadAssessments();

    // 新增按鈕
    $('#newAssessmentBtn').click(function(){
      editId = null;
      $('#assessmentDetailForm')[0].reset();
      resetGroups(['section','question','subcategory','option']);
    });

    // 編輯
    $('#assessmentTable').on('click', '.edit-btn', function(){
      editId = $(this).data('id');
      var res = wg.evalForm.getJson({}, '/Assessment/api/get?id='+editId);
      if(res.success){
        var a = res.result;
        $('#assessmentSelect').val(a.id).trigger('change');
        // TODO: 根據返回的 sectionId, questionId, subCategoryId, optionIds 依序設定
      }
    });

    // 刪除
    $('#assessmentTable').on('click', '.del-btn', function(){
      var id = $(this).data('id');
      if(confirm('確定要刪除評估表？')){
        var res = wg.evalForm.getJson({}, '/Assessment/api/delete/'+id);
        if(res.success){ loadList(); }
      }
    });

    // 表單送出：Create/Update
    $('#assessmentDetailForm').submit(function(e){
      e.preventDefault();
      var data = collectFormData();
      var url = editId?('/Assessment/api/update/'+editId):'/Assessment/api/save';
      var res = wg.evalForm.getJson(JSON.stringify({assessment:data}), url);
      if(res.success){ loadList(); $('#newAssessmentBtn').click(); }
    });

    // TODO: 定義 collectFormData() 函式，將各級選擇值與勾選選項封裝成 JSON

    // 評估表變動事件
    $('#assessmentSelect').change(function(){
      var aid = $(this).val();
      resetGroups(['section','question','subcategory','option']);
      if(aid){
        // 載入區段
        var r2 = wg.evalForm.getJson(JSON.stringify({assessmentId:aid}), "/Section/api/findByAssessmentId");
        if(r2.success){
          $('#sectionSelect').empty().append('<option value="">請選擇區段</option>');
          $.each(r2, function(i,s){
            $('#sectionSelect').append($('<option>').val(s.id).text(s.sectionName));
          });
          $('#sectionGroup').show();
        } else {
          loadQuestions({assessmentId:aid});
        }
      }
    });

    // 區段變動
    $('#sectionSelect').change(function(){
      var sid = $(this).val();
      resetGroups(['question','subcategory','option']);
      if(sid){ loadQuestions({sectionId:sid}); }
    });

    // 題目載入
    function loadQuestions(params){
      var r3 = wg.evalForm.getJson(JSON.stringify(params), "/Question/api/findByCriteria");
      if(r3.success){
        $('#questionSelect').empty().append('<option value="">請選題目</option>');
        $.each(r3, function(i,q){
          $('#questionSelect').append($('<option>').val(q.id).text(q.questionText));
        });
        $('#questionGroup').show();
      }
    }

    // 題目變動
    $('#questionSelect').change(function(){
      var qid = $(this).val();
      resetGroups(['subcategory','option']);
      if(qid){
        var r4 = wg.evalForm.getJson(JSON.stringify({questionId:qid}), "/SubCategory/api/findByQuestionId");
        if(r4.success && r4.length){
          $('#subcategorySelect').empty().append('<option value="">請選子分類</option>');
          $.each(r4, function(i,sc){
            $('#subcategorySelect').append($('<option>').val(sc.id).text(sc.subCategoryName));
          });
          $('#subcategoryGroup').show();
        } else {
          loadOptions({questionId:qid});
        }
      }
    });

    // 子分類變動
    $('#subcategorySelect').change(function(){
      var scid = $(this).val();
      resetGroups(['option']);
      if(scid){ loadOptions({subCategoryId:scid}); }
    });

    // 載入選項
    function loadOptions(params){
      var r5 = wg.evalForm.getJson(JSON.stringify(params), "/Option/api/findByCriteria");
      if(r5.success){
        $('#optionContainer').empty();
        $.each(r5, function(i,opt){
          var chk = $('<label class="checkbox-inline">')
                    .append($('<input>').attr('type','checkbox').val(opt.id))
                    .append(opt.optionText);
          $('#optionContainer').append(chk);
        });
        $('#optionGroup').show();
      }
    }

    function resetGroups(groups){
      $.each(groups, function(_, g){
        $('#' + g + 'Group').hide();
      });
    }

  });
</script>
