<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<#if isNewForm?? >
					<div class="item-name">新增生理量測資訊(Observation)</div>
					<#else>
					<div class="item-name">FHIR個案總覽</div>
					<span class="patient-hint">${patientName!""}</span>
					</#if>
				</div>
				<#if !isNewForm?? >
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.back"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/caseView">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "casemgnt.menu.view"/></span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/observation">
						<i class="fa fa-stethoscope fa-lg"></i>
						<span>生理量測</span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/imagingstudy">
						<i class="fa fa-image fa-lg"></i>
						<span>檢測影像</span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/diagnosticreport">
						<i class="fa fa-file-pdf fa-lg"></i>
						<span>診斷報告</span>
					</div>		
				</div>
           		</#if>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<form class="form" id="observationForm" action="${base}/division/api/fhir/observation/save" method="POST">
					<@spring.bind "observationView" />
					<#-- Default -->
					<table class="default-table">
						<tr>
							<td>Profile 選擇：</td>
							<td colspan="3">
								<@spring.selectWidget "metaView.profiles[0]" observationView.metaView!"" observationView.getObservationMetaMap() "" />
								<!--<select name="metaView.profiles[0]" class="form-control">
									<option value="https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Observation-laboratoryResult-twcore">https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Observation-laboratoryResult-twcore</option>
									<option value="https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Observation-bloodPressure-twcore">https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Observation-bloodPressure-twcore</option>
								</select>-->
							</td>
						</tr>
						<#if !isNewForm?? >
						<tr>
							<td>流水編號(ID)：</td>
							<td colspan="3">
								<@spring.formInput path="observationView.id" attributes='class="form-control" disabled="disabled"' />
							</td>
						</tr>
						</#if>
						<tr>
							<td class="h-color">個案參照：</td>
							<td>
								<#if isNewForm?? >
								<input type="text" name="subject" class="form-control" value="Patient/${patientId!""}" placeholder="病患參照(subject),如：Patient/5">
								<#else>
								<#assign ref = observationView.subject.reference>
								<input type="text" name="subject" class="form-control" value="${ref!""}" placeholder="病患參照(subject),如：Patient/5">
								</#if>
							</td>
							<td>目前狀態：</td>
							<td>
								<@spring.enumWidget "status" observationView.status!"" observationView.getObservationStatusMap() />
							</td>
						</tr>
						<tr>
							<td>分類Code：</td>
							<td>
								<@spring.selectWidget "categoryCode" observationView.categoryCode!"" observationView.getObservationCategoryMap() "" />
							</td>				
							<td>分類Display：</td>
							<td>
								<@spring.selectWidget "categoryDisplay" observationView.categoryDisplay!"" observationView.getObservationDisplayMap() "" />
							</td>
						</tr>
						<tr>
							<td>量測代碼</td>
							<td>
								<select id="examItemCode" name="examItemCode" class="form-control examItemCode">
									<option value="">請選擇</option>
						            <#list observationItem as obItem >
					                <option value="${obItem.code!""}" data-sys="${obItem.getCodeSystem()!""}" data-display="${obItem.display!""}" <#if observationView.examItemCode?? && observationView.examItemCode == obItem.code>selected=true</#if> >${obItem.getName()!""} (${obItem.code!""})</option>
						            </#list>
						        </select>				
							</td>
			                <td>量測日期：</td>
						    <td>
						    	<#if observationView.effectiveDateTime?? >
								<@spring.formDateStrInput observationView?if_exists.effectiveDateTime "effectiveDateTime" 'class="form-control effectiveDateTime" data-date-end-date="0d" placeholder="填寫檢測日期"' "text" "yyyy-MM-dd" />
								<#else>
								<@spring.formDateStrInput "" "effectiveDateTime" 'class="form-control" data-date-end-date="0d" placeholder="填寫檢測日期"' "text" "yyyy-MM-dd" />
								</#if>
						    </td>
						</tr>
						<tr>
							<td>系統(System)</td>
							<td>
								<@spring.formInput path="observationView.examItemSystem" attributes='class="form-control system" placeholder="填寫System" value="https://loinc.org"' />				
							</td>
			                <td>數據項目：</td>
						    <td>
						        <@spring.formInput path="observationView.examItemText" attributes='class="form-control itemText" placeholder="填寫量測名稱" ' />
						        <@spring.formInput path="observationView.examItemDisplay" attributes='class="form-control itemDisplay hidden" placeholder="填寫量測名稱" ' />
						    </td>
						</tr>
						<tr>
							<td colspan="4" class="h-color">檢驗結果一：</td>
						</tr>
						<tr>
							<td>檢驗項目Code：</td>
							<td>
								<select id="observationComponentViews[0].code" name="observationComponentViews[0].code" class="form-control code">
									<option value="">請選擇(非血壓勿填)</option>
						            <#list observationItem as obItem >
					                <option value="${obItem.code!""}" data-unit="${obItem.unit!""}" data-unitCode="${obItem.unitCode!""}" data-display="${obItem.display!""}" <#if observationView.observationComponentViews?? && observationView.observationComponentViews[0].code?? && observationView.observationComponentViews[0].code == obItem.code>selected=true</#if> >${obItem.getName()!""} (${obItem.code!""})</option>
						            </#list>
						        </select>
							</td>
							<td>檢驗項目Display：</td>
							<td>
								<@spring.formInput path="observationView.observationComponentViews[0].codeDisplay" attributes='class="form-control codeDisplay" placeholder="檢驗項目Display(非血壓勿填)" ' />
							</td>
						</tr>
						<tr>
							<td>數值：</td>
							<td>
								<@spring.formInput path="observationView.observationComponentViews[0].quantityValue" attributes='class="form-control" placeholder="填寫量測數值" ' />
							</td>
							<td>單位：</td>
							<td>
								<@spring.selectWidget "observationComponentViews[0].quantityUnit" observationView.observationComponentViews[0].quantityUnit!"" observationView.getObservationUnitMap() "quantityUnit" />
								<@spring.formInput path="observationView.observationComponentViews[0].quantityCode" attributes='class="form-control hidden" placeholder="填寫量測單位" ' />
							</td>
						</tr>
						<tr>
							<td colspan="4" class="h-color">檢驗結果二：</td>
						</tr>
						<tr>
							<td>檢驗項目Code：</td>
							<td>
								<select id="observationComponentViews[1].code" name="observationComponentViews[1].code" class="form-control code">
									<option value="">請選擇(非血壓勿填)</option>
						            <#list observationItem as obItem >
					                <option value="${obItem.code!""}" data-unit="${obItem.unit!""}" data-unitCode="${obItem.unitCode!""}" data-display="${obItem.display!""}" <#if observationView.observationComponentViews[1]?? && observationView.observationComponentViews[1].code?? && observationView.observationComponentViews[1].code == obItem.code>selected=true</#if> >${obItem.getName()!""} (${obItem.code!""})</option>
						            </#list>
						        </select>
							</td>
							<td>檢驗項目Display：</td>
							<td>
								<@spring.formInput path="observationView.observationComponentViews[1].codeDisplay" attributes='class="form-control codeDisplay" placeholder="檢驗項目Display(非血壓勿填)" ' />
							</td>
						</tr>
						<tr>
							<td>數值：</td>
							<td>
								<@spring.formInput path="observationView.observationComponentViews[1].quantityValue" attributes='class="form-control" placeholder="填寫量測數值" ' />
							</td>
							<td>單位：</td>
							<td>
								<@spring.selectWidget "observationComponentViews[1].quantityUnit" observationView.observationComponentViews[1].quantityUnit!"" observationView.getObservationUnitMap() "quantityUnit" />
								<@spring.formInput path="observationView.observationComponentViews[1].quantityCode" attributes='class="form-control hidden" placeholder="填寫量測單位" ' />
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="footer-btn-list">
									<button class="func-btn" onclick="submitForm(event, this)"><i class="fa fa-save"></i> 儲存</button>
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

	startDatePicker('#effectiveDateTime');
	//
	$("#twzipcode, #twzipcode2").twzipcode({
    	zipcodeIntoDistrict: false,
    	readonly: true
    });
	
	$(".examItemCode").change(function(){
		var selectedOpt = $(this).find("option:selected");
		$(".system").val(selectedOpt.data("sys"));
		$(".itemText, .itemDisplay").val(selectedOpt.data("display"));
	});
	
	$(".code").change(function(){
		var selectedOpt = $(this).find("option:selected");
		console.log(selectedOpt.data("display"));
		$(this).closest("tr").find(".codeDisplay").val(selectedOpt.data("display"));
	});
	
	$(".quantityUnit").change(function(){
		var selectedOpt = $(this).find("option:selected");
		$(this).next("input[type='text']").val(selectedOpt.text());
	});
});


function submitForm(e, obj){
	e.preventDefault();
	
	// 找到最近的表單元素
	var form = $(obj).closest('form');
	
	// 創建空的 postData 對象
	var postData = {};
	
	// 遍歷表單中的每個輸入字段
	$(form).find("input").each(function(){
		var inputName = $(this).attr("name");
    	var inputValue = $(this).val();
    	if(inputValue != "") postData[inputName] = inputValue;
	});
	
	// 遍歷表單中的每個輸入字段
	$(form).find("select").each(function(){
		var selectName = $(this).attr("name");
    	var selectValue = $(this).val();
    	if(selectValue != "") postData[selectName] = selectValue;
	});
	
	console.log(postData);
	
	// 取得targetURL
	var targetURL = $(form).attr('action');
	
	var result = wg.evalForm.getJson(postData, targetURL);
	if(result.success){
		<#if isNewForm?? >
			//customSwal("創建成功", "生理量測資訊如下：\n" + result.msg, "success", 600);
			//swal("創建成功", "生理量測資訊如下：\n" + result.msg, "success");	
			swal({
			  	title: "創建成功",
			  	text: "生理量測資訊如下：\n" + result.msg,
			  	type: "success",
			  	showConfirmButton: true
			},function(confirm){
				if(confirm) window.location.href = "${base}/${__lang}/division/web/exchange/fhir/patient/${patientId!""}/observation";
			});
		<#else>
			swal({
			  	title: "更新成功",
			  	text: "生理量測資訊如下：\n" + result.msg,
			  	type: "success",
			  	showConfirmButton: true
			},function(confirm){
				if(confirm) window.location.href = "${base}/${__lang}/division/web/exchange/fhir/patient/${patientId!""}/observation";
			});
		</#if>
	}else{
		<#if isNewForm?? >
			swal("創建失敗！", result.msg, "error");
		<#else>
			swal("更新失敗！", result.msg, "error");
		</#if>
	}
}



function postPatientList() {
    var baseUrl = "${base}/division/api/fhir/patient/list";
    var queryParam = 'data=' + encodeURIComponent('{"page_num":1,"limit":"100"}');
    var fullUrl = baseUrl + '?' + queryParam;

    $.ajax({
        url: fullUrl,
        method: 'POST',
        success: function(response) {

            createPatientDropdown(JSON.parse(response).data);
            
        },
        error: function(error) {
            console.error('Error:', error);
        }
    });
}

function createPatientDropdown(data) {
    var $selectElement = $('#patientList');

    $.each(data, function(index, item) {
        var option = $('<option>', {
            value: item.id,
            text: 'ID：' + item.id + ' 姓名：' + item.family+item.given
        });
        $selectElement.append(option);
    });
}


function createObInfo(){
	var status = $("#status").val();
	var patientId = $("#patientList").val();	
	
    var observationSubject = $("#observationSubject").val();
    var selectedData = medicalDataMap[observationSubject];
    
    var value = $("#value").val();
    var dateTime = $("#dateTime").val();
    
var postData = {
  "status": status,
//  "metaView": { "profile": "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Observation-laboratoryResult-twcore" },
//  "subject": { "reference": "Patient/" + patientId },
  "effectiveDateTime": dateTime,
  "examItemSystem": "http://loinc.org",
  "examItemCode": selectedData.code,
  "examItemDisplay": selectedData.display,
  "categoryCode": selectedData.category,
  "categoryDisplay": selectedData.categoryDisplay,
  "examItemText": selectedData.display,  
  "observationComponentViews": [
    {
      "code": selectedData.code,
      "codeDisplay": selectedData.display,
      "quantityUnit": selectedData.unit,
      "quantityCode": selectedData.unitCode,
      "quantityValue": value
    }
  ]
};
	
	
	var result = wg.evalForm.getJson({"data": JSON.stringify(postData)}, '${base}/division/api/fhir/observation/create');
	
	if(result.success){
		swal("創建成功", "量測資訊如下：\n" + result.msg, "success");
	}else{
		swal("創建失敗", result.msg, "error");
	}

}
function changeUnit(){
    $('#observationSubject').change(function() {
    var selectedItem = $(this).val();
    var result = getUnitForItem(selectedItem);
    var unit = result.unit;
    var isBloodPressure = result.isBloodPressure;

    $('#unitDisplay').text(unit);

    if (isBloodPressure) {
        $('#systolicPressureRow').show();
        $('#distolicPressureRow').show();
        $('#systolicUnitDisplay').text(unit);
        $('#distolicUnitDisplay').text(unit);
        $('#valueRow').hide();
    } else {
        $('#systolicPressureRow').hide();
        $('#distolicPressureRow').hide();
        $('#valueRow').show();
    }
    });
}

function getUnitForItem(item) {
    var data = medicalDataMap[item];
    if (data) {
        return {
            unit: data.unit,
            isBloodPressure:  (data.code === '35094-2')
        };
    } else {
        return {unit: '單位', isBloodPressure: false};
    }
}

function setValue(){
	<#if fhirInfo??>
	var activeStatus = ${fhirInfo.active?string('true', 'false')};
	$("#serialNo").val("${fhirInfo.id!""}");
	$("#idno").val("${fhirInfo.identifier!""}");
	$("#gender").val("${fhirInfo.gender!""}");	
	$("#family").val("${fhirInfo.family!""}");
	$("#given").val("${fhirInfo.given!""}");
	$("#birthdate").val("${fhirInfo.birthdate!""}");
	$("#phone").val("${fhirInfo.phone!""}");
	$("#email").val("${fhirInfo.email!""}");
	$("#url").val("${fhirInfo.url!""}");
	$("#twzipcode").find("select[name='county']").val("${fhirInfo.district!""}").trigger('change');
	$("#twzipcode").find("select[name='district']").val("${fhirInfo.city!""}").trigger('change');
	$("#address").val("${fhirInfo.line!""}");
	//緊急聯絡人
	$("#contact-family").val("${fhirInfo.contactNameOfFamily!""}");
	$("#contact-given").val("${fhirInfo.contactNameOfGiven!""}");
	$("#contact-relationship").val("${fhirInfo.relationshipText!""}").trigger('change');
	$("#twzipcode2").find("select[name='county']").val("${fhirInfo.contactDistrict!""}").trigger('change');
	$("#twzipcode2").find("select[name='district']").val("${fhirInfo.contactCity!""}").trigger('change');
	$("#contact-address").val("${fhirInfo.contactLine!""}");
	
	$("#active").val(activeStatus);
	</#if>
}

const medicalDataMap = {
  bodyHeight: {
    chineseName: "身高",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "3137-7",
    display: "Body height Measured",
    unit: "cm",
    unitCode: "cm"
  },
  bodyWeight: {
    chineseName: "體重",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "29463-7",
    display: "Body Weight",
    unit: "kg",
    unitCode: "kg"
  },
  bodyTemp: {
    chineseName: "體溫",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "8310-5",
    display: "Body Temperature",
    unit: "°C",
    unitCode: "Cel"
  },
  bodyFat: {
    chineseName: "體脂",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "41982-0",
    display: "Percentage of body fat Measured",
    unit: "%",
    unitCode: "%"
  },
  gripStrength: {
    chineseName: "右手握力",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "83174-3",
    display: "Grip strength Hand - right Dynamometer",
    unit: "kg",
    unitCode: "kg"
  },
  heartRate: {
    chineseName: "心跳",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "8867-4",
    display: "Heart Rate",
    unit: "beats/min",
    unitCode: "{beats}/min"
  },
  pulseRate: {
    chineseName: "脈率",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "8889-8",
    display: "Heart rate by Pulse oximeter",
    unit: "beats/min",
    unitCode: "{beats}/min"
  },
  respRate: {
    chineseName: "呼吸率",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "9279-1",
    display: "Respiratory Rate",
    unit: "breaths/min",
    unitCode: "{breaths}/min"
  },
  spO2: {
    chineseName: "血氧濃度",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "59408-5",
    display: "Oxygen saturation in Arterial blood by Pulse oximetry",
    unit: "%",
    unitCode: "%"
  },
  glucose: {
    chineseName: "血糖",
    category: "laboratory",
    categoryDisplay: "Laboratory Data",
    code: "2339-0",
    display: "Glucose [Mass/volume] in Blood",
    unit: "mg/dL",
    unitCode: "mg/dL"
  },
  glucosePC: {
    chineseName: "飯後血糖",
    category: "laboratory",
    categoryDisplay: "Laboratory Data",
    code: "87422-2",
    display: "Glucose [Mass/volume] in Blood --post meal",
    unit: "mg/dL",
    unitCode: "mg/dL"
  },
  glucoseAC: {
    chineseName: "飯前血糖",
    category: "laboratory",
    categoryDisplay: "Laboratory Data",
    code: "88365-2",
    display: "Glucose [Mass/volume] in Blood --pre-meal",
    unit: "mg/dL",
    unitCode: "mg/dL"
  },
  bloodPressure: {
    chineseName: "血壓",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "35094-2",
    display: "Blood Pressure Panel",
    unit: "mmHg",
    unitCode: "mm[Hg]"
  },
  systolicPressure: {
    chineseName: "收縮壓",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "8480-6",
    display: "Systolic Blood Pressure",
    unit: "mmHg",
    unitCode: "mm[Hg]"
  },
  diastolicPressure: {
    chineseName: "舒張壓",
    category: "vital-signs",
    categoryDisplay: "Vital Signs",
    code: "8462-4",
    display: "Distolic Blood Pressure",
    unit: "mmHg",
    unitCode: "mm[Hg]"
  },
  crt: {
    chineseName: "微血管回填充時間",
    category: "exam",
    categoryDisplay: "Exam",
    code: "44963-7",
    display: "Capillary refill [Time] of Nail bed",
    unit: "s",
    unitCode: "s"
  }
};

</script>

<style>
.lower{
	text-transform: lowercase;
}

.upper{
	text-transform: uppercase;
}

.lead{
	font-size: 18px !important;
	word-break: break-all; 
}

</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />