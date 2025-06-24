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
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/inspection">
						<i class="fa fa-stethoscope fa-lg"></i>
						<span><@spring.message "casemgnt.menu.cure.history"/></span>
					</div>
					<div class="module-blk" data-src="">
						<i class="fa fa-chart-simple fa-lg"></i>
						<span><@spring.message "casemgnt.menu.state"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/hcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.hcRecord"/></span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/patient/${formId!""}/ltcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.ltcRecord"/></span>
					</div>
					<div class="module-blk" data-src="">
						<i class="fa fa-file-waveform fa-lg"></i>
						<span><@spring.message "casemgnt.menu.evaluation"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/careCourse">
						<i class="fa fa-clock-rotate-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careCourse"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/carePlan">
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
						<td ><@spring.message "ltcrecord.detail.label.visitDate"/></td>
						<td class="adjust-w">
							<#if isNewForm>
							<input type="text" class="ltcForm form-control visitDate" />
							<#else>
							<input type="text" class="ltcForm form-control" value="${visitDate!""}" readOnly=true />
							</#if>
						</td>
						<td><@spring.message "ltcrecord.detail.label.category"/></td>
						<td>
							<select class="ltcForm form-control" data-item="13">
								<option value=""><@spring.message "ltcrecord.detail.option.select.hint"/></option>
								<option value="1"><@spring.message "ltcrecord.detail.option.subsidy"/></option>
								<option value="2"><@spring.message "ltcrecord.detail.option.selfPay"/></option>
							</select>
							<label class="inline"><input type="checkbox" class="ltcForm" data-item="14" /> <span><@spring.message "ltcrecord.detail.label.failVisit"/></span></label>
						</td>
					</tr>
					<tr>
						<td><@spring.message "ltcrecord.detail.label.visitItem"/></td>
						<td>
							<select class="ltcForm form-control visitNo" data-item="15">

							</select>
							<label class="nextline"><input type="checkbox" class="ltcForm" data-item="16" /> <span><@spring.message "ltcrecord.detail.label.notApply"/></span></label>
						</td>
						<td><@spring.message "ltcrecord.detail.label.visitTimes"/></td>
						<td>
							<input type="number" class="ltcForm form-control" data-item="17" />
						</td>
					</tr>
					<tr>
						<td><@spring.message "ltcrecord.detail.label.executor"/></td>
						<td colspan="3">
							<#if isNewForm>
							<select id="careGiver_select" multiple="multiple" class="form-input" >
							<#list executors as executor>
								<option value="${executor.id}" >[${executor.userNo}] ${executor.name} ${executor.role}</option>
							</#list>
							</select>
							<#else>
							<select id="careGiver_select" multiple="multiple" class="ltcForm form-input" >
							<#list executors as executor>
								<option value="${executor.id}" >[${executor.userNo}] ${executor.name} ${executor.role}</option>
							</#list>
							</select>
							</#if>
							<input type="hidden" id="selectCareGivers" name="selectCareGivers" class="ltcForm" data-item="18" validate='{required:true, messages:{required:"<@spring.message "ltcrecord.detail.option.executor"/>"}}' />
						</td>
					</tr>
					<tr>
						<td><@spring.message "ltcrecord.detail.label.startDate"/></td>
						<td>
							<input type="text" class="ltcForm form-control beginTime" data-item="19" />
						</td>
						<td><@spring.message "ltcrecord.detail.label.endDate"/></td>
						<td>
							<input type="text" class="ltcForm form-control endTime" data-item="20" />
						</td>
					</tr>
					<tr>
						<td><@spring.message "ltcrecord.detail.label.achievement"/></td>
						<td colspan="3">
							<input type="text" class="ltcForm form-control" data-item="21" />
						</td>
					</tr>
					<tr>
						<td><@spring.message "ltcrecord.detail.label.record"/></td>
						<td colspan="3">
							<textarea rows="2" class="ltcForm form-control" placeholder="<@spring.message "ltcrecord.detail.placeholder.record"/>" data-item="22" ></textarea>
						</td>
					</tr>
					<tr>
						<td><@spring.message "ltcrecord.detail.label.target"/></td>
						<td colspan="3">
							<textarea rows="2" class="ltcForm form-control" placeholder="<@spring.message "ltcrecord.detail.placeholder.target"/>" data-item="23" ></textarea>
						</td>
					</tr>
					<tr>
						<td><@spring.message "ltcrecord.detail.label.object"/></td>
						<td colspan="3">
							<textarea rows="2" class="ltcForm form-control" placeholder="<@spring.message "ltcrecord.detail.placeholder.object"/>" data-item="24" ></textarea>
						</td>
					</tr>
					<tr>
						<td><@spring.message "ltcrecord.detail.label.serviceContent"/></td>
						<td colspan="3">
							<textarea rows="3" class="ltcForm form-control" placeholder="<@spring.message "ltcrecord.detail.placeholder.serviceContent"/>" data-item="25" ></textarea>
						</td>
					</tr>
					<tr>
						<td><@spring.message "ltcrecord.detail.label.abstract"/></td>
						<td colspan="3">
							<textarea rows="3" class="ltcForm form-control" placeholder="<@spring.message "ltcrecord.detail.placeholder.abstract"/>" data-item="26" ></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="footer-btn-list">
								<button class="func-btn" onclick="delLtcInfo()"><i class="fa fa-trash-can"></i> <@spring.message "ltcrecord.detail.button.delete"/></button>
								<#if isNewForm>
								<button class="func-btn" onclick="createLtcInfo()"><i class="fa fa-save"></i> <@spring.message "ltcrecord.detail.button.save"/></button>
								<#else>
								<button class="func-btn" onclick="saveLtcInfo()"><i class="fa fa-save"></i> <@spring.message "ltcrecord.detail.button.save"/></button>
								</#if>
								<button class="goback func-btn"><i class="fa fa-circle-xmark"></i> <@spring.message "ltcrecord.detail.button.cancel"/></button>
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
	setSelectedOption("#careGiver_select", "${selectdExecutors!""}");
	//
	startDatePicker('.visitDate');
    //
    selectAdapter(".visitNo", 1, "<@spring.message "ltcrecord.detail.option.visitCode"/>", "${base}/division/api/qryVisitCatItems" , "${__lang}");
    
    
    //
    multiSelectAdapter("#careGiver_select", "#selectCareGivers", '<@spring.message "ltcrecord.detail.option.executor"/>');
	//
	timeAdapter(".beginTime, .endTime", "beginTime", "endTime");
	//
	<#if !isNewForm>
	setCodeOption("${itemName!""}");
	</#if>
	//
	readLtcInfo();
});

//設定照顧組合碼
function setCodeOption(itemStr){
	var itemCnt = itemStr.split(",");
	$('.visitNo').append('<option value="' + itemCnt[0] + '">' + itemCnt[1] + '</option>').trigger('change');
}

//讀取長照紀錄資料
function readLtcInfo(){
	var itemArr = [];
	$(".default-table").find(".ltcForm").each(function(){
		itemArr.push($(this).attr("data-item"));
	});
	var ltcData = {"userFormKeyNo": "${ltcFormId!""}", "itemIds": itemArr};	
	var data = wg.evalForm.getJson({"data":JSON.stringify(ltcData)}, "${base}/division/api/qryAns");
	setFormValue("ltcForm", data.result);

}

//新增長照紀錄資料
function createLtcInfo(){
	var visitDate = $(".visitDate").val();
	var itemNumArr = getItemNumArray("default-table", "ltcForm");
	var itemArray = getItemValue("ltcForm", itemNumArr);
	var postData = {"creatorId":${currentUser.id!""}, "formName": "長照紀錄V2", "evalDate": formatDate(visitDate), "app": "${formId!""}", "items": itemArray};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createUserForm?");
	
	if(result.success){
		swal({
		  	title: "<@spring.message "ltcrecord.detail.save.success.title"/>",
		  	text: "<@spring.message "ltcrecord.detail.save.success.addText"/>",
		  	type: "success",
		  	timer: 1500,
		  	showConfirmButton: false
		},function(){
		    window.location.href = "${base}/${__lang}/division/web/patient/${formId!""}/ltcRecord";
		});
	}
	else{
		swal("<@spring.message "ltcrecord.detail.save.fail.title"/>", "<@spring.message "ltcrecord.detail.save.fail.text"/>", "error");
	}
}

//儲存長照紀錄資料
function saveLtcInfo(){
	var itemNumArr = getItemNumArray("default-table", "ltcForm");
	var itemArray = getItemValue("ltcForm", itemNumArr);
	var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": "${ltcFormId!""}", "items": itemArray};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/editUserForm?");
	if(result.success){			
		swal("<@spring.message "ltcrecord.detail.save.success.title"/>", "<@spring.message "ltcrecord.detail.save.success.editText"/>", "success");
	}
	else{
		swal("<@spring.message "ltcrecord.detail.save.fail.title"/>", "<@spring.message "ltcrecord.detail.save.fail.text"/>", "error");
	}
}

$(".goback").click(function(e){
	e.preventDefault();
	window.location = "${base}/${__lang}/division/web/patient/${formId!""}/ltcRecord";
});	
</script>

<style>
.ms-options-wrap button span{
	font-size: 16px;
}

.half{
	width: 200px !important;
	display: inline-block !important;
}

.adjust-w{
	width: 350px;
}

label.inline, label.nextline{
	margin-top: 5px;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />