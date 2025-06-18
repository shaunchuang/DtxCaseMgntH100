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
								<div id="item-container" class="default-blk blk-container overflowY">
									<span class="choose-hint">請先選擇量表類型</span>
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

<script>

$(document).ready(function(){
	<#if scalesForm.items?? && scalesForm.items?size != 0 > 
	$(".sub-title span").toggleClass("hidden");
	wg.template.updateNewPageContent('item-container', 'item-content', {"id": ${scalesForm.id!""}}, '${base}/${__lang}/division/web/admin/other/scaleMgnt/template/${scalesForm.type!""}');
	wg.template.updateNewPageContent('level-container', 'level-content', {"id": ${scalesForm.id!""}}, '${base}/${__lang}/division/web/admin/other/scaleMgnt/template/level');
	</#if>
});

$(".formType").on( 'change', function () {
	var selectedOpt = $(this).val();
	$(".sub-title span").addClass("hidden");
	if(selectedOpt == ""){
		$(".blk-container").html("<span class='choose-hint'>請先選擇量表類型</span>");
	}else{
		$(".sub-title span").toggleClass("hidden");
		wg.template.updateNewPageContent('item-container', 'item-content', {}, '/ftl/imas/admin/other/scaleMgnt/template/' + selectedOpt);
		wg.template.updateNewPageContent('level-container', 'level-content', {}, '/ftl/imas/admin/other/scaleMgnt/template/level');
	}
});

$(".del-btn").click(function(e){
	e.preventDefault();
	confirmCheck("<@spring.message "phrase.detail.confirm.title"/>", "<@spring.message "phrase.detail.confirm.text"/>", "warning", "btn-info", "確認", "取消", function(confirmed){
		if(confirmed){
			var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/employee/PhraseMng/doDeletePhrase?id=");
			if(result.success){
				swal({
				  	title: "<@spring.message "phrase.detail.delete.success.title"/>",
				  	text: "<@spring.message "phrase.detail.delete.success.text"/>",
				  	type: "success",
				  	timer: 1500,
				  	showConfirmButton: false
				},function(){
				    window.location.href = "${base}/${__lang}/division/web/admin/other/phraseMgnt";
				});
			}
		}
	});	
});


$('.addques').on( 'click', function () {
	var container = $("#item-container");
	var selectedType = $(".formType").val();
	var quesNo = container.find(".ques-blk").length + 1;

	var addCnt = getQuesTypeForm(selectedType, quesNo);
	var newcnt = $(addCnt).attr("data-ques", quesNo);
	newcnt.find(".h-color").html("題目" + quesNo);
	container.append(newcnt);
	container.scrollTop(container[0].scrollHeight);
	
	enableCleanBtn();
	enableAddOptBtn(newcnt, quesNo-1);
});

$('.addlevel').on( 'click', function () {
	var container = $("#level-container");
	var levelNo = container.find(".opt-container").length + 1;
	var newcnt = '<div class="opt-container">' +
				 '		<input type="text" class="form-control w-50" value="' + levelNo + '" readonly />									' +
			  	 '		<input type="text" class="form-control w-100" name="levels[' + (levelNo-1) + '].lowScore" placeholder="最低分" />		' +
			  	 '		<input type="text" class="form-control w-100" name="levels[' + (levelNo-1) + '].highScore" placeholder="最高分" />	' +
			  	 '		<input type="text" class="form-control" name="levels[' + (levelNo-1) + '].level" placeholder="請輸入對應等級說明" />		' +
			  	 '</div>																													' ;	
	
	container.find(".options").append(newcnt);
	container.scrollTop(container[0].scrollHeight);

});

function enableAddOptBtn(newcnt, quesNo){
	$(newcnt).find(".addopt").on( 'click', function () {
		var optNo = $(newcnt).find(".options > .opt-container").length;
		var cnt = '<div class="opt-container">																																			' +
				  '		<input type="text" class="form-control w-50" name="items[' + quesNo + '].opts[' + optNo + '].optionNo" value="' + (optNo+1) + '" readonly />					' +
				  '		<input type="text" class="form-control" name="items[' + quesNo + '].opts[' + optNo + '].optionText" placeholder="請輸入選項文字" />									' +
				  '		<input type="number" class="form-control w-150" name="items[' + quesNo + '].opts[' + optNo + '].score" placeholder="請輸入對應分數" value="0" min="0" max="20" />	' +
				  '</div>																																								' ;	
		$(newcnt).find(".options").append(cnt);
	});
}

function enableCleanBtn(){
	$('.cleanBlkBtn').click(function(){
		var container = $("#item-container");		
		$(this).parent("div").remove();
		container.find(".ques-blk").each(function(index, element){
			var num = parseInt(index) + 1
			$(element).attr("data-ques", num);
			$(element).find(".h-color").html("題目" + num);
		});
		
	});
}

function getQuesTypeForm(type, quesNo){
	switch(type){
		case "binary":
			return '<div class="row ques-blk" data-ques="' + quesNo + '">																									' +
				   '	<span class="cleanBlkBtn"><i class="fa fa-circle-xmark"></i></span>																					' +
				   '	<div class="col-md-12">																																' +
				   '		<div class="mg-b-10">																															' +
				   '			<input type="hidden" name="items[' + (quesNo-1) + '].itemNo" value="' + quesNo + '" />														' +
		           '			<label class="form-label h-color">問題' + quesNo + '</label>																					' +
		           '			<div class="ques-container">																												' +
		           '				<input type="text" class="form-control w-200" name="items[' + (quesNo-1) + '].itemType" placeholder="問題類型(非必要)" />					' +
		           '				<input type="text" class="form-control" name="items[' + (quesNo-1) + '].question" placeholder="請輸入問題內容" />							' +
	           	   '			</div>																																		' +
	           	   '		</div>																																			' +
				   '	</div>																																				' +
			       '	<div class="col-md-6">																																' +
				   '		<div class="mg-b-10">																															' +
				   '			<label class="form-label">選項1</label>																										' +
				   '			<input type="text" class="form-control" name="items[' + (quesNo-1) + '].opts[0].optionText" placeholder="輸入選項1文字" />						' +
				   '		</div>																																			' +
				   '		<div class="mg-b-10">																															' +
				   '			<label class="form-label">對應分數</label>																										' +
				   '			<input type="number" class="form-control" name="items[' + (quesNo-1) + '].opts[0].score" placeholder="輸入對應分數" value="0" min="0" max="20">	' +
				   '		</div>																																			' +
			       '	</div>																																				' +
			       '	<div class="col-md-6">																																' +
				   '		<div class="mg-b-10">																															' +
				   '			<label class="form-label">選項2</label>																										' +
				   '			<input type="text" class="form-control" name="items[' + (quesNo-1) + '].opts[1].optionText" placeholder="輸入選項2文字">						' +
				   '		</div>																																			' +
				   '		<div class="mg-b-10">																															' +
				   '			<label class="form-label">對應分數</label>																										' +
				   '			<input type="number" class="form-control" name="items[' + (quesNo-1) + '].opts[1].score" placeholder="輸入對應分數" value="0" min="0" max="20"> ' +
				   '		</div>																																			' +
			       '	</div>																																				' +
		    	   '</div>																																					' ;
			break;
		case "multiple_choice":
			return '<div class="row ques-blk" data-ques="' + quesNo + '">																					' +
				   '	<span class="cleanBlkBtn"><i class="fa fa-circle-xmark"></i></span>																	' +
				   '	<div class="col-md-12">																												' +
				   '		<div class="mg-b-10">																											' +
		           '			<input type="hidden" name="items[' + (quesNo-1) + '].itemNo" value="' + quesNo + '" />										' +
		           '			<label class="form-label h-color"></label>																					' +
		           '			<div class="ques-container">																								' +
		           '				<input type="text" class="form-control w-200" name="items[' + (quesNo-1) + '].itemType" placeholder="問題類型(非必要)" />	' +
		           '				<input type="text" class="form-control" name="items[' + (quesNo-1) + '].question" placeholder="請輸入問題內容" />			' +
	           	   '			</div>																														' +
		           '		</div>																															' +
				   '	</div>																																' +
				   '	<div class="col-md-12">																												' +
				   '		<div class="mg-b-10">																											' +
				   '			<div class="opt-t">																											' +
			       '				<label class="form-label">請列舉選項</label>																				' +
			       '				<span class="addopt"><i class="fa fa-circle-plus"></i> 新增選項</span>														' +
		           '			</div>																														' +
			       '			<div class="options"></div>																									' +
			       '		</div>																															' +
		           '	</div>																																' +
				   '</div>																																	' ;
			break;
		case "scale":
			return '<div class="row ques-blk" data-ques="' + quesNo + '">																								' +
				   '	<span class="cleanBlkBtn"><i class="fa fa-circle-xmark"></i></span>																				' +
				   '	<div class="col-md-12">																															' +
				   '		<div class="mg-b-10">																														' +
		           '			<input type="hidden" name="items[' + (quesNo-1) + '].itemNo" value="' + quesNo + '" />													' +
		           '			<label class="form-label h-color"></label>																								' +
		           '			<div class="ques-container">																											' +
		           '				<input type="text" class="form-control w-200" name="items[' + (quesNo-1) + '].itemType" placeholder="問題類型(非必要)" />				' +
		           '				<input type="text" class="form-control" name="items[' + (quesNo-1) + '].question" placeholder="請輸入問題內容" />						' +
	           	   '			</div>																																	' +
		           '		</div>																																		' +
				   '	</div>																																			' +
			       '	<div class="col-md-6">																															' +
			       '		<div class="mg-b-10">																														' +
			       '			<label class="form-label">最低分數</label>																									' +
			       '			<input type="number" class="form-control" name="items[' + (quesNo-1) + '].scoreMin" placeholder="輸入最低分數" value="0" min="0" max="20">	' +
			       '		</div>																																		' +
			       '		<div class="mg-b-10">																														' +
			       '			<label class="form-label">左側標籤文字(含意)</label>																							' +
			       '			<input type="text" class="form-control" name="items[' + (quesNo-1) + '].labelLeft" placeholder="輸入左側標籤文字">							' +
			       '		</div>																																		' +
			       '	</div>																																			' +
			       '	<div class="col-md-6">																															' +
			       '		<div class="mg-b-10">																														' +
			       '			<label class="form-label">最高分數</label>																									' +
			       '			<input type="number" class="form-control" name="items[' + (quesNo-1) + '].scoreMax" placeholder="輸入最高分數" value="0" min="0" max="20">	' +
			       '		</div>																																		' +
			       '		<div class="mg-b-10">																														' +
			       '			<label class="form-label">右側標籤文字(含意)</label>																							' +
			       '			<input type="text" class="form-control" name="items[' + (quesNo-1) + '].labelRight" placeholder="輸入右側標籤文字">							' +
			       '		</div>																																		' +
			       '	</div>																																			' +
				   '</div>																																				' ;
			break;
	}
}
	
</script>

<style>
span{
	cursor: pointer;
}

.sub-title span, .opt-t span{
	float: right;
	color: #595959;
}

.default-blk{
	width: 60rem;
	height: 30rem;
	/*background: #f2f2f2;*/
}

.choose-hint{
	display: flex;
	justify-content: center;
	color: #666666;
	line-height: 30rem;
}

.choose-hint:before{
	font-family: 'FontAwesome';
	margin-right: 10px;
	content: "\f25a";
}

.cleanBlkBtn{
	position: absolute;
	font-size: 20px;
	top: 5px;
	right: 5px;
	color: #ff4d4d;
	z-index: 1;
}

.opt-container, .ques-container {
    display: flex;
    gap: 0.5rem; /* 控制輸入框之間的間距 */   
}

.opt-container{
	margin-bottom: 5px;
}

.mg-r-45{
	margin-right: 45rem;
}
</style>

<#--<#include "/skins/imas/casemgnt/socket.ftl" />-->
<#include "/imas/widget/widget.ftl" />