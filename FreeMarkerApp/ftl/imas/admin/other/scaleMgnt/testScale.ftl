<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "admin.menu.otherMgnt"/></div>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="/ftl/imas/admin/other/phraseMgnt">
						<i class="fa fa-quote-left fa-lg"></i>
						<span><@spring.message "admin.menu.phraseMgnt"/></span>
					</div>
					<div class="module-blk active" data-src="/ftl/imas/admin/other/scaleMgnt">
						<i class="fa fa-table-list fa-lg"></i>
						<span><@spring.message "admin.menu.scaleMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/deviceMgnt">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "admin.menu.deviceMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/lessonMgnt">
						<i class="fa fa-upload fa-lg"></i>
						<span><@spring.message "admin.menu.lessonMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/profitMgnt">
						<i class="fa fa-coins fa-lg"></i>
						<span><@spring.message "admin.menu.profitMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/medicalMgnt">
						<i class="fa fa-pills fa-lg"></i>
						<span><@spring.message "admin.menu.medicalMgnt"/></span>
					</div>										
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<#assign isNew = isNewForm>
				<form class="form" id="scaleForm" action="${base}/employee/ScalesMng/${isNew?string('doCreateScale', 'doEditScale')}" method="POST">
					<#if !isNew && scalesForm??>
						<input type="hidden" name="id" value="${scalesForm.id!''}">
						<input type="hidden" name="createTime" value="${scalesForm.createTime!''}">
					</#if>
					<table class="default-table">
						<tr>
							<td colspan="2" class="sub-title">評估量表資訊</td>
							<td class="sub-title">
								評分等級設定
								<span class="addlevel hidden"><i class="fa fa-circle-plus"></i> 新增等級說明</span>
							</td>
						</tr>
						<tr>
							<td style="width: 10%">量表名稱：</td>
							<td>
								<input type="text" name="name" class="form-control" />
							</td>
							<td rowspan="5">
								<div id="level-container" class="default-blk blk-container overflowY">
									<span class="choose-hint">請先選擇量表類型</span>
								</div>
							</td>
						</tr>
						<tr>
							<td>量表類型：</td>
							<td>
								<select name="type" class="form-control formType">
									<option value="">請選擇</option>
									<#if scalesForm??>
										<#list scalesForm.getTypeItemMap()?keys as key>
											<option value="${key}" <#if scalesForm.type?? && scalesForm.type == key>selected</#if>>${scalesForm.getTypeItemMap()[key]}</option>
										</#list>
									</#if>
								</select>
							</td>
						</tr>
						<tr>
							<td>評估人員：</td>
							<td>
								<select name="evaluator" class="form-control">
									<option value="">請選擇</option>
									<#if scalesForm??>
										<#list scalesForm.getEvaluatorTypeMap()?keys as key>
											<option value="${key}" <#if scalesForm.evaluator?? && scalesForm.evaluator == key>selected</#if>>${scalesForm.getEvaluatorTypeMap()[key]}</option>
										</#list>
									</#if>
								</select>
							</td>
						</tr>
						<tr>
							<td>量表版本：</td>
							<td>
								<input type="text" name="version" class="form-control" />
							</td>
						</tr>
						<tr>
							<td>量表描述：</td>
							<td>
								<textarea name="desc" class="form-control"></textarea>
							</td>
						</tr>
						<tr>								
							<td colspan="3" class="sub-title">
								題目設定
								<span class="addques mg-r-45 hidden"><i class="fa fa-circle-plus"></i> 新增題目</span>
							</td>
						</tr>
						<tr>
							<td colspan="3">
                                <!-- 動態多層級 CRUD 樹狀結構 -->
                                <div id="tree-container" class="default-blk blk-container overflowY">
                                    <!-- 需後端提供: GET /api/scales/list -->
                                    <button class="btn btn-info btn-sm add-scale">新增 Scale</button>
                                    <ul class="tree root"></ul>
                                </div>							
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<div class="footer-btn-list">
									<button type="submit" class="func-btn"><i class="fa fa-save"></i> <@spring.message isNew?string("admin.button.add", "admin.button.save")/></button>
									<button class="goback func-btn"><i class="fa fa-circle-xmark"></i> <@spring.message "admin.button.cancel"/></button>
								</div>	
							</td>
						</tr>					
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
<#noparse>
<script>
$(function () {
  // 請後端實作以下 REST API 端點:
  // GET  /api/scales                -> 回傳所有 Scale 列表
  // POST /api/scales                -> 新增 Scale, payload { name }
  // PUT  /api/scales/{id}           -> 修改 Scale 名稱, payload { name }
  // DELETE /api/scales/{id}         -> 刪除 Scale
  // GET  /api/scales/{id}/sections  -> 根據 scaleId 回傳該 Scale 底下所有 Section
  // POST /api/sections             -> 新增 Section, payload { name, scaleId }
  // PUT  /api/sections/{id}         -> 修改 Section, payload { name }
  // DELETE /api/sections/{id}       -> 刪除 Section
  // GET  /api/scales/{id}/questions?sectionId= -> 回傳該 Scale (或指定 sectionId) 底下所有 Question
  // POST /api/questions            -> 新增 Question, payload { text, type, scaleId, sectionId }
  // PUT  /api/questions/{id}        -> 修改 Question, payload { text }
  // DELETE /api/questions/{id}      -> 刪除 Question
  // GET  /api/questions/{id}/subcats -> 回傳該 Question 底下 SubCategory
  // POST /api/subcats               -> 新增 SubCategory, payload { name, questionId }
  // PUT  /api/subcats/{id}           -> 修改 SubCategory, payload { name }
  // DELETE /api/subcats/{id}         -> 刪除 SubCategory
  // GET  /api/questions/{id}/options -> 回傳該 Question 下（或其 SubCategory）所有 Option
  // POST /api/options               -> 新增 Option, payload { optionText, score, questionId, subcategoryId }
  // PUT  /api/options/{id}           -> 修改 Option, payload { optionText }
  // DELETE /api/options/{id}         -> 刪除 Option

  loadScales();

  function loadScales() {
    $.getJSON("/api/scales", function (scales) {
      const root = $(".tree.root").empty();
      scales.forEach(s => renderScale(root, s));
    });
  }

  function renderScale($parent, s) {
    const tpl = `<li class="scale" data-id="${s.id}">` +
                `<span class="title">${s.name}</span>` +
                `<button class="add-section">+Section</button>` +
                `<button class="add-question">+Question</button>` +
                `<button class="edit">✎</button>` +
                `<button class="del">🗑</button>` +
                `<ul></ul></li>`;
    const $li = $(tpl).appendTo($parent);
    // 加載 Sections
    $.getJSON(`/api/scales/${s.id}/sections`, secs =>
      secs.forEach(sec => renderSection($li.children("ul"), sec)));
    // 加載無 Section 的 Questions
    $.getJSON(`/api/scales/${s.id}/questions?sectionId=`, qs =>
      qs.forEach(q => renderQuestion($li.children("ul"), q)));
  }

  function renderSection($p, sec) {
    const tpl = `<li class="section" data-id="${sec.id}">` +
                `<span class="title">${sec.name}</span>` +
                `<button class="add-question">+Question</button>` +
                `<button class="edit">✎</button>` +
                `<button class="del">🗑</button>` +
                `<ul></ul></li>`;
    const $li = $(tpl).appendTo($p);
    $.getJSON(`/api/scales/${sec.scaleId}/questions?sectionId=${sec.id}`,
      qs => qs.forEach(q => renderQuestion($li.children("ul"), q)));
  }

  function renderQuestion($p, q) {
    const tpl = `<li class="question" data-id="${q.id}">` +
                `<span class="title">${q.text}</span>` +
                `<button class="add-subcat">+SubCat</button>` +
                `<button class="add-option">+Option</button>` +
                `<button class="edit">✎</button>` +
                `<button class="del">🗑</button>` +
                `<ul></ul></li>`;
    const $li = $(tpl).appendTo($p);
    $.getJSON(`/api/questions/${q.id}/subcats`,
      scs => scs.forEach(sc => renderSubCat($li.children("ul"), sc)));
    $.getJSON(`/api/questions/${q.id}/options`,
      opts => opts.filter(o => !o.subcategoryId)
                  .forEach(o => renderOption($li.children("ul"), o)));
  }

  function renderSubCat($p, sc) {
    const tpl = `<li class="subcategory" data-id="${sc.id}">` +
                `<span class="title">${sc.name}</span>` +
                `<button class="add-option">+Option</button>` +
                `<button class="edit">✎</button>` +
                `<button class="del">🗑</button>` +
                `<ul></ul></li>`;
    const $li = $(tpl).appendTo($p);
    $.getJSON(`/api/questions/${sc.questionId}/options`,
      opts => opts.filter(o => o.subcategoryId===sc.id)
                  .forEach(o => renderOption($li.children("ul"), o)));
  }

  function renderOption($p, o) {
    const tpl = `<li class="option" data-id="${o.id}">` +
                `<span class="title">${o.optionText} (${o.score})</span>` +
                `<button class="edit">✎</button>` +
                `<button class="del">🗑</button>` +
                `</li>`;
    $(tpl).appendTo($p);
  }

  // 新增、編輯、刪除 事件處理
  $(document).on("click",".add-scale",function(){
    swal({title:"新增 Scale 名稱",content:{element:"input"},button:"確認"})
      .then(n=>{ if(!n) return;
        $.post("/api/scales",JSON.stringify({name:n}),loadScales);
      });
  });

  $(document).on("click",".add-section",function(){
    const scaleId=$(this).closest(".scale").data("id");
    swal({title:"Section 名稱",content:{element:"input"},button:"確認"})
      .then(n=>{if(!n)return;
        $.post("/api/sections",JSON.stringify({name:n,scaleId}),loadScales);
      });
  });

  $(document).on("click",".add-question",function(){
    const $par = $(this).closest("li");
    const scaleId = $par.closest(".scale").data("id");
    const sectionId = $par.hasClass("section") ? $par.data("id") : "";
    swal({title:"Question 文字",content:{element:"input"},button:"確認"})
      .then(t=>{if(!t)return;
        $.post("/api/questions",
               JSON.stringify({text:t,type:"text",scaleId,sectionId}),
               loadScales);
      });
  });

  $(document).on("click",".add-subcat",function(){
    const qid=$(this).closest(".question").data("id");
    swal({title:"SubCategory 名稱",content:{element:"input"},button:"確認"})
      .then(n=>{if(!n)return;
        $.post("/api/subcats",JSON.stringify({name:n,questionId:qid}),loadScales);
      });
  });

  $(document).on("click",".add-option",function(){
    const $q = $(this).closest(".question");
    const qid = $q.data("id");
    const scid = $(this).closest(".subcategory").data("id")||null;
    swal({title:"Option 文字,分數",content:{element:"input",attributes:{placeholder:"文字,分數"}},button:"確認"})
      .then(str=>{
        if(!str) return;
        const arr=str.split(",");
        $.post("/api/options",
               JSON.stringify({optionText:arr[0],score:+arr[1]||0,questionId:qid,subcategoryId:scid}),
               loadScales);
      });
  });

  $(document).on("click",".edit",function(){
    const $li=$(this).closest("li");
    const id=$li.data("id");
    const type=$li.attr("class").split(" ")[0];
    const old=$li.children(".title").text();
    swal({title:`修改 ${type}`,content:{element:"input",attributes:{value:old}},button:"更新"})
      .then(txt=>{
        if(!txt) return;
        const body=(type==="option")?{optionText:txt}:{name:txt,text:txt};
        $.ajax({url:`/api/${type}s/${id}`,type:"PUT",contentType:"application/json",data:JSON.stringify(body)})
          .done(loadScales);
      });
  });

  $(document).on("click",".del",function(){
    const id=$(this).closest("li").data("id");
    const type=$(this).closest("li").attr("class").split(" ")[0];
    swal({title:"確定刪除？",icon:"warning",buttons:true})
      .then(ok=>{if(!ok)return;
        $.ajax({url:`/api/${type}s/${id}`,type:"DELETE"}).done(loadScales);
      });
  });

});
</script>
</#noparse>

