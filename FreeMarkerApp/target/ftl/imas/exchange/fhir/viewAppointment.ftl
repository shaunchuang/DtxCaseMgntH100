<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<#if isNewForm?? >
					<div class="item-name">Appointment建立</div>
					</#if>
				</div>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<table class="default-table">				
					<tr>
						<td>流水編號(ID)：</td>
						<td>
							<input type="text" id="serialNo" class="form-control" placeholder="由系統自動產生" disabled=disabled />
						</td>
						<td>預約類型：</td>
						<td>
						    <select id="appointmentType" class="from-control"/>
						        <option value="">請選擇</option>
						        <option value="CHECKUP">檢查</option>
						        <option value="WALKIN">未預約</option>
						</td>
					</tr>
					<tr>
						<td>預約名稱：</td>
						<td>
							<input type="text" id="description" class="form-control" />
						</td>
						<td>預約狀態：</td>
						<td>
							<select id="status" class="form-control">
								<option value="">請選擇</option>
								<option value="booked">已預定</option>
								<option value="fulfilled">完成</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>開始時間：</td>
						<td>
							<input type="datetime-local" id="startTime" class="form-control" />

						</td>
						<td>結束時間：</td>
						<td>
							<input type="datetime-local" id="endTime" class="form-control" />
						</td>
					</tr>
					<tr>
						<!--<td>病人ID：</td>
						<td>
							<input type="text" id="patientId" class="form-control" />
						</td>-->
						<td>位置ID：</td>
						<td>
							<select id="locationId" class="form-control">
							    <option value="">請選擇</option>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="footer-btn-list">
								<#if isNewForm?? >
								<button onclick="createApInfo()"><i class="fa fa-save"></i> 新增</button>
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
	startDatePicker('#birthdate');
	//
	$("#twzipcode, #twzipcode2").twzipcode({
    	zipcodeIntoDistrict: false,
    	readonly: true
    });

    postLocationList();
    setValue();
});

function createApInfo(){
	//個案本身資訊
	var description = $("#description").val();
    var status = $("#status").val();
    var appointmentType = $("#appointmentType").val();
    var startTime = $("#startTime").val();
    var endTime = $("#endTime").val();
    //var patientId = $("#patientId").val();
    var locationId = $("#locationId").val();
	
	var postData = "";
	var appointmentData = {"description": description, "status": status,"appointmentType": appointmentType, "startTime": startTime, "endTime": endTime, "locationId": locationId}
	postData = appointmentData;

	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, '${base}/division/api/fhir/appointment/create');
	
	if(result.success){
		swal("創建成功", "資訊如下：\n" + result.msg, "success");
	}else{
		swal("創建失敗", result.msg, "error");
	}

}

function postLocationList() {
    var baseUrl = "${base}/division/api/fhir/location/list";
    var queryParam = 'data=' + encodeURIComponent('{"page_num":1,"limit":"100"}');
    var fullUrl = baseUrl + '?' + queryParam;

    $.ajax({
        url: fullUrl,
        method: 'POST',
        success: function(response) {

            createLocationDropdown(JSON.parse(response).data);
            
        },
        error: function(error) {
            console.error('Error:', error);
        }
    });
}

function createLocationDropdown(data) {
    var $selectElement = $('#locationId');

    $.each(data, function(index, item) {
        var option = $('<option>', {
            value: item.id,
            text: 'ID：' + item.id + ' 地點：' + item.name
        });
        $selectElement.append(option);
    });
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
	
</script>

<style>
.lower{
	text-transform: lowercase;
}

.upper{
	text-transform: uppercase;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />