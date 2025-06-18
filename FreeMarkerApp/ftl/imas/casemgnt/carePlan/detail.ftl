<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "casemgnt.label.caseView.title"/></div>
					<span class="patient-hint">${patientName!""}</span>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="home">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.back"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/caseView">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "casemgnt.menu.view"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/hcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.hcRecord"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/ltcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.ltcRecord"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/inspection">
						<i class="fa fa-stethoscope fa-lg"></i>
						<span><@spring.message "casemgnt.menu.inspection"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/careCourse">
						<i class="fa fa-clock-rotate-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careCourse"/></span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/patient/${formId!""}/carePlan">
						<i class="fa fa-clipboard-list fa-lg"></i>
						<span><@spring.message "casemgnt.menu.carePlan"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/careTeam">
						<i class="fa fa-people-group fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careTeam"/></span>
					</div>
				</div>           
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<table class="default-table">
					<tr>
						<td><@spring.message "careplan.detail.label.recordDate"/></td>
						<td>
							<span>${recordDate!""}</span>
						</td>
					</tr>
					<tr>
						<td><@spring.message "careplan.detail.label.vitalSigns"/></td>
						<td>
							<div class="physicalData row">
								<div class="col-xs-3">
									<@spring.message "careplan.detail.label.bodyTemp"/><input type="text" class="physiForm form-control" data-item="945" <#if temp?has_content>value="${temp!""}" disabled</#if> /> <@spring.message "careplan.detail.label.tempUnit"/>
								</div>
								<div class="col-xs-3">
									<@spring.message "careplan.detail.label.heartRate"/><input type="text" class="physiForm form-control" data-item="944" <#if bpm?has_content>value="${bpm!""}" disabled</#if> /> <@spring.message "careplan.detail.label.rateUnit"/>
								</div>
								<div class="col-xs-4">
									<@spring.message "careplan.detail.label.bloodPressure"/><input type="text" class="physiForm form-control" data-item="946" <#if sbp?has_content>value="${sbp!""}" disabled</#if> /> / <input type="text" class="physiForm form-control" data-item="947" <#if dbp?has_content>value="${dbp!""}" disabled</#if> /> <@spring.message "careplan.detail.label.pressureUnit"/>
								</div>
							</div>
						</td>						
					</tr>
					<tr>
						<td><@spring.message "careplan.detail.label.question"/></td>
						<td>
							<input type="text" class="planForm form-control" placeholder="<@spring.message "careplan.detail.placeholder.question"/>" data-item="11" />
						</td>
					</tr>
					<tr>
						<td><@spring.message "careplan.detail.label.content"/></td>
						<td>
							<textarea rows="4" class="planForm form-control" placeholder="<@spring.message "careplan.detail.placeholder.content"/>" data-item="12" ></textarea>
						</td>
					</tr>					
					<tr>
						<td colspan="2">
							<div class="footer-btn-list">
								<#if isNewForm >
								<button class="func-btn" onclick="createPlanInfo()"><i class="fa fa-save"></i> <@spring.message "careplan.detail.button.save"/></button>
								<#else>
								<button class="func-btn" onclick="delPlanInfo()"><i class="fa fa-trash-can"></i> <@spring.message "careplan.detail.button.delete"/></button>
								<button class="func-btn" onclick="savePlanInfo()"><i class="fa fa-save"></i> <@spring.message "careplan.detail.button.save"/></button>
								</#if>
								<button class="goback func-btn"><i class="fa fa-circle-xmark"></i> <@spring.message "careplan.detail.button.cancel"/></button>
							</div>	
						</td>
					</tr>					
				</table>
			</div>
		</div>	
	</div>
</body>

<script>

$(document).ready(function(){
	<#if !isNewForm>
	readPlanInfo();
	</#if>

});

//讀取今日個案生命量測資料(額溫、心跳、血壓)
function saveTodayPhysiInfo(){
	var itemNumArr = getItemNumArray("default-table", "physiForm");
	var itemArray = getItemValue("physiForm", itemNumArr);
	<#if physiFormId?has_content >
	var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": "${physiFormId!""}", "items": itemArray};	
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/editUserForm?");
	<#else>
	var postData = {"creatorId":${currentUser.id!""}, "formName": "生理量測V2", "evalDate": getEvalDate(), "app": "${formId!""}", "items": itemArray};	
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createUserForm?");
	</#if>
	var saved = result.success == true ? true : false;
	
	return saved;
}

function readPlanInfo(){
	var itemArr = [];
	$(".default-table").find(".planForm").each(function(){
		itemArr.push($(this).attr("data-item"));
	});
	var planData = {"userFormKeyNo": "${recordId!""}", "itemIds": itemArr};	
	var data = wg.evalForm.getJson({"data":JSON.stringify(planData)}, "${base}/division/api/qryAns");
	setFormValue("planForm", data.result);
}

//新增照護計畫資訊
function createPlanInfo(){
	var itemNumArr = getItemNumArray("default-table", "planForm");
	var itemArray = getItemValue("planForm", itemNumArr);
	var postData = {"creatorId":${currentUser.id!""}, "formName": "照護計畫V2", "evalDate": getEvalDate(), "app": "${formId!""}", "items": itemArray};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createUserForm?");
	console.log("先搜尋: " + result.success);
	if(result.success){
		var physiFormSaved = saveTodayPhysiInfo();
		console.log("接收到: " + physiFormSaved);
		if(physiFormSaved){
			successToDirect("<@spring.message "careplan.detail.save.success.title"/>", "<@spring.message "careplan.detail.save.success.addText"/>", "success", 1500, "${base}/${__lang}/division/web/patient/${formId!""}/carePlan");
		}else{
			swal("<@spring.message "careplan.detail.save.fail.title"/>", "<@spring.message "careplan.detail.save.fail.text"/>", "error");
		}
	}
	else{
		swal("<@spring.message "careplan.detail.save.fail.title"/>", "<@spring.message "careplan.detail.save.fail.text"/>", "error");
	}
}

//儲存照護計畫資訊
function savePlanInfo(){
	var itemNumArr = getItemNumArray("default-table", "planForm");
	var itemArray = getItemValue("planForm", itemNumArr);
	var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": "${recordId!""}", "items": itemArray};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/editUserForm?");
	if(result.success){		
		var physiFormSaved = saveTodayPhysiInfo();
		if(physiFormSaved){			
			swal("<@spring.message "careplan.detail.save.success.title"/>", "<@spring.message "careplan.detail.save.success.editText"/>", "success");
		}else{
			swal("<@spring.message "careplan.detail.save.fail.title"/>", "<@spring.message "careplan.detail.save.fail.text"/>", "error");
		}
	}
	else{
		swal("<@spring.message "careplan.detail.save.fail.title"/>", "<@spring.message "careplan.detail.save.fail.text"/>", "error");
	}
}

//刪除照護計畫資訊
function delPlanInfo(){
	confirmCheck("<@spring.message "careplan.detail.delete.confirm.title"/>", "<@spring.message "careplan.detail.delete.confirm.text"/>", "warning", "btn-danger", "<@spring.message "hcrecord.detail.button.confirm"/>", "<@spring.message "careplan.detail.button.cancel"/>", function(confirmed){
		if(confirmed){			
			var postData = {"userFormKeyNo": "${recordId!""}"};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/removeUserForm?");
		    if(result.success){
		    	successToDirect("<@spring.message "careplan.detail.delete.success.title"/>", "<@spring.message "careplan.detail.delete.success.text"/>", "success", 1500, "${base}/${__lang}/division/web/patient/${formId!""}/carePlan");
			}else{
				swal("<@spring.message "careplan.detail.delete.fail.title"/>", "<@spring.message "careplan.detail.delete.fail.text"/>", "error");
			}
		}
	});
}

$(".goback").click(function(e){
	e.preventDefault();
	window.location = "${base}/${__lang}/division/web/patient/${formId!""}/carePlan";
});		
</script>

<style>
.physicalData div input[type="text"]{
	width: 80px;
	display: inline;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />