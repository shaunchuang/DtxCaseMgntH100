<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<#if isNewForm?? >
					<div class="item-name"><@spring.message "casemgnt.label.createCase.title"/></div>
					<#else>
					<div class="item-name"><@spring.message "casemgnt.label.caseView.title"/></div>
					<span class="patient-hint">${patientName!""}</span>
					</#if>
				</div>
				<#if !isNewForm?? >
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="home">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.back"/></span>
					</div>
					<div class="module-blk " data-src="${__lang}/division/web/patient/${formId!""}/diagnosis">
						<i class="fa fa-person-dots-from-line fa-lg"></i>
						<span><@spring.message "casemgnt.menu.diagnosis"/></span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/patient/${formId!""}/caseView">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "casemgnt.menu.view"/></span>
					</div>
					<div class="module-blk" data-src="">
						<i class="fa fa-file-waveform fa-lg"></i>
						<span><@spring.message "casemgnt.menu.evaluation"/></span>
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
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/ltcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.ltcRecord"/></span>
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
           		</#if>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<table class="default-table">
					<tr>
						<td colspan="4" class="sub-title">個案資訊</td>
					</tr>
					<tr>
						<td style="width: 15%"><@spring.message "view.label.ptno"/></td>
						<td style="width: 35%">
							<input type="text" class="upper basicForm form-control" data-item="1" />
						</td>
						<td style="width: 15%"><@spring.message "view.label.email"/></td>
						<td style="width: 35%">
							<input type="text" class="basicForm form-control" data-item="8" />
						</td>												
					</tr>
					<tr>
						<td><@spring.message "view.label.name"/></td>
						<td>
							<input type="text" class="basicForm form-control evalId" data-item="3" />
						</td>
						<td rowspan="2"><@spring.message "view.label.address"/></td>
						<td rowspan="2">
							<#if __lang == "zh_TW" >
							<div id="twzipcode" class="zipcode form-inline"></div>
							<#else>
							<div class="form-inline">
								<input type="text" name="country" placeholder="<@spring.message "view.placeholder.country"/>" class="basicForm form-control half" data-item="9">
								<input type="text" name="city" placeholder="<@spring.message "view.placeholder.capital"/>" class="basicForm form-control half" data-item="10">
							</div>
							</#if>
							<input type="text" class="basicForm form-control address" data-item="11" />
						</td>
					</tr>
					<tr>						
						<td><@spring.message "view.label.gender"/></td>
						<td>
							<select class="basicForm form-control" data-item="4">
								<option value=""><@spring.message "view.option.select.hint"/></option>
								<option value="M"><@spring.message "view.option.male"/></option>
								<option value="F"><@spring.message "view.option.female"/></option>
							</select>
						</td>					
					</tr>
					<tr>
						<td><@spring.message "view.label.idno"/></td>
						<td>
							<input type="text" class="upper basicForm form-control cardId" data-item="2" />
						</td>
						<td><@spring.message "view.label.emergencyContact"/></td>
						<td>
							<input type="text" class="basicForm form-control" data-item="12" />
						</td>
					</tr>
					<tr>
						<td><@spring.message "view.label.birth"/></td>
						<td>
							<input type="hidden" class="basicForm form-control birth" data-item="5" />
						</td>
						<td><@spring.message "view.label.emergencyContactRelationship"/></td>
						<td>
							<select class="basicForm form-control" data-item="13">
								<option value=""><@spring.message "view.option.select.hint"/></option>
								<option value="GRFTH" ><@spring.message "view.option.grfth"/></option>
								<option value="GRMTH" ><@spring.message "view.option.grmth"/></option>
								<option value="INLAW" ><@spring.message "view.option.inlaw"/></option>
								<option value="FTH" ><@spring.message "view.option.fth"/></option>
								<option value="MTH" ><@spring.message "view.option.mth"/></option>
								<option value="UNCLE" ><@spring.message "view.option.uncle"/></option>
								<option value="AUNT" ><@spring.message "view.option.aunt"/></option>
								<option value="COUSN" ><@spring.message "view.option.cousn"/></option>
							</select>
						</td>						
					</tr>
					<tr>
						<td><@spring.message "view.label.age"/></td>
						<td>
							<input type="text" class="basicForm form-control calAge" data-item="6" />
						</td>
						<td><@spring.message "view.label.emergencyContactPhone"/></td>
						<td colspan="3">
							<input type="text" class="basicForm form-control" data-item="14" />
						</td>						
					</tr>
					<tr>
						<td><@spring.message "view.label.phone"/></td>
						<td>
							<input type="text" class="basicForm form-control" data-item="7" />
						</td>
						<td></td>										
					</tr>
					<tr>
						<td colspan="4" class="sub-title">細部病史資訊</td>
					</tr>
					<tr>
						<td>主要適應症(擇一)</td>
						<td colspan="3">
							<div class="symdrome-options single-option">
								<input type="hidden" class="basicForm form-control" data-item="37" />
								<#list indications as idication>
								<div class="option" data-id="${idication.id}" >${idication.name}</div>
								</#list>
							</div>
						</td>										
					</tr>
					<tr>
						<td><@spring.message "view.label.medicalHistory"/></td>
						<td>
							<div class="history-options multi-option">
								<#list personalDiseaseHistoryItems as pdhItems>
								<#if pdhItems_index + 1 != personalDiseaseHistoryItems?size>
								<div class="option" data-item="${pdhItems.id}" >${pdhItems.name}</div>
								<#else>
								<div class="option editable-option" data-item="${pdhItems.id}" contenteditable="true" >${pdhItems.name}</div>
								</#if>
								</#list>
							</div>
						</td>
						<td><@spring.message "view.label.allergyHistory"/></td>
						<td>
							<div class="allergy-history-options multi-option">
								<#list drugAllergyHistoryItems as dahItems>
								<#if dahItems_index + 1 != drugAllergyHistoryItems?size>
								<div class="option" data-item="${dahItems.id}" >${dahItems.name}</div>
								<#else>
								<div class="option editable-option" data-item="${dahItems.id}" contenteditable="true" >${dahItems.name}</div>
								</#if>
								</#list>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="footer-btn-list">
								<#if isNewForm?? >
								<button class="func-btn" onclick="createPtInfo()"><i class="fa fa-save"></i> <@spring.message "view.button.save"/></button>
								<#else>
								<button class="func-btn" onclick="savePtInfo()"><i class="fa fa-save"></i> <@spring.message "view.button.save"/></button>
								</#if>
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
	$(".birth").dropdownDatepicker({
		minYear: 1903,
		maxYear: ${maxYear!""}
	});
	//
	$(".birth").on("change", function () {
		if($(this).val() != ""){
			var birth = $(this).val();
			var birthGrp = birth.split("-");
			$(".year").val(birthGrp[0]);
			$(".month").val(birthGrp[1]);
			$(".day").val(birthGrp[2]);
			
			//countAge(birth);
		}
	});
	//
	<#if __lang == "zh_TW" >
	$("#twzipcode").twzipcode({
    	zipcodeIntoDistrict: true
    });
    </#if>
    //
    readPtInfo();
    //
 	initEditable(".editable-option");
	//	
});

/*相關病史及適應症選擇點選變色*/
$(".option").click(function() {
    var $parent = $(this).parent("div");

    if ($parent.hasClass("single-option")) {
        // 單選處理
        $parent.find(".option").removeClass("selected");
        $(this).addClass("selected");
        $parent.find("input[type='hidden']").val($(this).attr("data-id"));
    }else{
        // 多選處理
        $(this).toggleClass("selected");
    }
});

//讀取過去疾病史內容(以tag方式呈現)
function initJs(){
	var json = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getMedicalHistoryList");
	if(json.success){
		$(".basicForm[data-item='245']").tagsinput({   	
	    	typeahead: {
			    source: json.data,
			    afterSelect: function(val) { this.$element.val(""); },
			    freeInput: true
		  	},
		  	cancelConfirmKeysOnEmpty: false,
		  	trimValue: true
	    });
	}
}

//讀取病患資料
function readPtInfo(){
	var itemArr = [];
	$(".default-table").find(".basicForm, .option").each(function(){
		if($(this).attr("data-item") != undefined){
			itemArr.push($(this).attr("data-item"));
		}
	});
	var basicData = {"userFormKeyNo": "${formId!""}", "itemIds": itemArr};	
	var data = wg.evalForm.getJson({"data":JSON.stringify(basicData)}, "${base}/division/api/qryAns");
	setFormValue("basicForm, .option", data.result);
}

//儲存病患資料
function savePtInfo(){
	var pid = $(".cardId").val();
	var pidStatus = checkPid(pid);

	if(pid !="" && pidStatus != ""){
		swal("<@spring.message "view.save.fail.title"/>", pidStatus + " <@spring.message "view.save.fail.text.retry"/>", "error");
		return;
	}
	
	var itemNumArr = getItemNumArray("default-table", "basicForm, multi-option .option");
	var itemArray = getItemValue("basicForm, multi-option .option", itemNumArr);
	var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": "${formId!""}", "items": itemArray};

	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/editUserForm?");
	if(result.success){			
		swal("<@spring.message "view.save.success.title"/>", "<@spring.message "view.save.success.text"/>", "success");
	}
	else{
		swal("<@spring.message "view.save.fail.title"/>", "<@spring.message "view.save.fail.text"/>", "error");
	}
}

//新增個案資料
function createPtInfo(){
	var pid = $(".cardId").val();
	var pidStatus = checkPid(pid);
	
	if(pid !="" && pidStatus != ""){
		swal("<@spring.message "view.save.fail.title"/>", pidStatus + " <@spring.message "view.save.fail.text.retry"/>", "error");
		return;
	}
		
	var itemNumArr = getItemNumArray("default-table", "basicForm, multi-option .option");
	var itemArray = getItemValue("basicForm, multi-option .option", itemNumArr);
	var postData = {"creatorId":${currentUser.id!""}, "formName": "基本資料V2", "evalDate": getEvalDate(), "app": "", "items": itemArray};

	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createUserForm?");
	
	if(result.success){
		successToDirect("<@spring.message "view.save.success.title"/>", "<@spring.message "view.save.success.text.redirect"/>", "success", 1500, "${base}/home");
	}
	else{
		swal("<@spring.message "view.save.fail.title"/>", "<@spring.message "view.save.fail.text"/> <@spring.message "view.save.fail.text.retry"/>", "error");
	}
}
	
</script>

<style>
.lower{
	text-transform: lowercase;
}

.upper{
	text-transform: uppercase;
}

.adjust-loc{
	display: inline-block;
	vertical-align: middle;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />