<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<#if isNewForm?? >
					<div class="item-name">地點建檔</div>
					</#if>
				</div>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<table class="default-table">				
					<tr>
						<td>流水編號(ID)：</td>
						<td colspan="3">
							<input type="text" id="serialNo" class="form-control" placeholder="由系統自動產生" disabled=disabled />
						</td>
					</tr>
					<tr>
						<td>地點名稱：</td>
						<td colspan="3">
							<input type="text" id="name" class="form-control" />
						</td>
					</tr>
					<tr>
						<td>地點地址：</td>
						<td>
							<div id="twzipcode" class="zipcode form-inline"></div>
							<input type="text" id="address" class="form-control" placeholder="輸入地址" />
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="footer-btn-list">
								<#if isNewForm?? >
								<button onclick="createLcInfo()"><i class="fa fa-save"></i> 新增</button>
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


    setValue();
});

function createLcInfo(){

    var name = $("#name").val();
	var postalCode = $("#twzipcode").find(".postCode").val();
	var city = $("#twzipcode").find("select[name='county']").val();
	var district = $("#twzipcode").find("select[name='district']").val();
	var text = $("#address").val();
    
	var postData = "";
	var caseData = {"name":name, "postalCode": postalCode, "city": city, "district": district, "text": text};
    postData = caseData;
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, '${base}/division/api/fhir/location/create');
	
	if(result.success){
		swal("創建成功", "地點資訊如下：\n" + result.msg, "success");
	}else{
		swal("創建失敗", result.msg, "error");
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