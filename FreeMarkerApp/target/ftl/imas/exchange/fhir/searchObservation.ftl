<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name">ImagingStudy搜尋</div>
				</div>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<table class="default-table">					
					<tr class="hb-color highlight">
						<td>搜尋條件：</td>
						<td colspan="3">
							<div class="input-group search-group">																		
								<span class="input-group-addon">Observation.identifier</span>
								<input type="text" class="form-control s-id" aria-describedby="basic-addon1">
								<span class="input-group-addon btn" onclick="search()">
									<i class="fa fa-search"></i>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>歷史紀錄清單：</td>
						<td colspan="3">
							<select id="version" class="form-control">
								<option value="">請選擇歷史紀錄編號</option>
							</select>							
						</td>
					</tr>
					<tr>
						<td>流水編號(ID)：</td>
						<td colspan="3">
							<input type="text" id="serialNo" class="form-control" placeholder="由系統自動產生" disabled=disabled />
						</td>
					</tr>
					<tr>
						<td>身份證字號：</td>
						<td>
							<input type="text" id="idno" class="form-control upper" disabled=disabled />
						</td>
						<td>性別：</td>
						<td>
							<select id="gender" class="form-control" disabled=disabled>
								<option value="">請選擇</option>
								<option value="male">男性</option>
								<option value="female">女性</option>
								<option value="other">其他</option>
								<option value="unknown">未知</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>姓名：</td>
						<td>
							<input type="text" id="family" class="form-control half" placeholder="姓(Last Name)"  />
							<input type="text" id="given" class="form-control half" placeholder="名(First Name)"  />
						</td>
						<td>生日：</td>
						<td>
							<input type="text" id="birthdate" class="form-control" data-date-end-date="0d"  />
						</td>
					</tr>
					<tr>
						<td>個案聯絡手機：</td>
						<td>
							<input type="text" id="phone" class="form-control" />
						</td>
						<td>個案Email：</td>
						<td>
							<input type="text" id="email" class="form-control" />
						</td>
					</tr>
					<tr>
						<td>個案Line連結：</td>
						<td colspan="3">
							<input type="text" id="url" class="form-control" />
						</td>
					</tr>
					<tr>
						<td>個案聯絡地址：</td>
						<td>
							<div id="twzipcode" class="zipcode form-inline"></div>
							<input type="text" id="address" class="form-control" placeholder="輸入地址" />
						</td>
						<td>為使用中個案：</td>
						<td>
							<select id="active" class="form-control">
								<option value="true" selected>是</option>
								<option value="false">否</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="h-color">緊急聯絡人：</td>
						<td>
							<input type="text" id="contact-family" class="form-control half" placeholder="姓(Last Name)" />
							<input type="text" id="contact-given" class="form-control half" placeholder="名(First Name)" />
						</td>
						<td class="h-color">緊急聯絡人關係：</td>
						<td>
							<select id="contact-relationship" class="form-control">
								<option value="">請選擇</option>
								<option value="夫妻">夫妻</option>
								<option value="父子">父子</option>
								<option value="父女">父女</option>
								<option value="母子">母子</option>
								<option value="母女">母女</option>
								<option value="兄弟">兄弟</option>
								<option value="兄妹">兄妹</option>
								<option value="姊弟">姊弟</option>
								<option value="姊妹">姊妹</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="h-color">緊急聯絡人地址：</td>
						<td colspan="3">
							<div id="twzipcode2" class="zipcode form-inline"></div>
							<input type="text" id="contact-address" class="form-control address" placeholder="輸入地址" />
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="footer-btn-list">
								<button onclick="delPtInfo()"><i class="fa fa-trash"></i> 刪除</button>
								<button onclick="updatePtInfo()"><i class="fa fa-save"></i> 更新</button>
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
});

//變更搜尋參數條件
$(".param").on("change", function(){	
	$(".paramTxt").val("");
});

//搜尋
/*function search(){
	var postData = "";
	var param = $(".param").val();
	var postData = postObj(param);
	if(postData != ""){
    	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, '${base}/division/api/fhir/patient/search');
		if(result.exist){
			setValue(result);
			
			//$(".param").val("").trigger('change');
			
			appendOption(result.versionNum);
			swal("搜尋成功", result.msg, "success");
			
		}else{
			swal("搜尋失敗", result.msg, "error");
		}
	}else{
		swal("搜尋失敗", "請確認有無選擇搜尋參數或輸入搜尋內容\n確認完畢後重新搜尋!", "error");
	}
}*/

//多重條件搜尋
function search(){
	var postData = "";
	var id = $(".s-id").val();
	var identifier = $(".s-identifier").val();
	var name = $(".s-name").val();
	var orgnization = $(".s-orgnization").val();
	var postData = {"id": id, "identifier": identifier, "name": name, "orgnization": orgnization};
	if(postData != ""){
    	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, '${base}/division/api/fhir/patient/search');
		if(result.exist){
			setValue(result);
			
			//$(".param").val("").trigger('change');
			
			appendOption(result.versionNum);
			swal("搜尋成功", result.msg, "success");
			
		}else{
			swal("搜尋失敗", result.msg, "error");
		}
	}else{
		swal("搜尋失敗", "請確認有無選擇搜尋參數或輸入搜尋內容\n確認完畢後重新搜尋!", "error");
	}
}

//編輯舊有病患資訊
function updatePtInfo(){
	var id = $("#serialNo").val();

	//個案本身資訊
	var idno = $("#idno").val();
	var gender = $("#gender").val();	
	var family = $("#family").val();
	var given = $("#given").val();
	var birthdate = $("#birthdate").val();
	var phone = $("#phone").val();
	var email = $("#email").val();
	var url = $("#url").val();
	var postCode = $("#twzipcode").find(".postCode").val();
	var county = $("#twzipcode").find("select[name='county']").val();
	var district = $("#twzipcode").find("select[name='district']").val();
	var address = $("#address").val();
	var active = $("#active").val();
	var activeStatus = active === "true" ? true : false;
	
	//聯絡人資訊
	var contactFamily = $("#contact-family").val();
	var contactGiven = $("#contact-given").val();
	var contactRelationship = $("#contact-relationship").val();
	var contactRelatedText = $("#contact-relationship").find(":selected").text();
	var contactPostCode = $("#twzipcode2").find(".postCode").val();
	var contactCounty = $("#twzipcode2").find("select[name='county']").val();
	var contactDistrict = $("#twzipcode2").find("select[name='district']").val();
	var contactAddress = $("#contact-address").val();
	
	var postData = "";
	var idData = {"id": id};
	var caseData = {"identifier":idno, "family": family, "given": given, "gender": gender, "birthdate": birthdate, "active": activeStatus};
	var caseTelData = {"phone": phone, "email": email, "url": url};
	var caseAddrData = {"postalCode": postCode, "district": county, "city": district, "line": address};
	var contactData = {"contactNameOfFamily": contactFamily, "contactNameOfGiven": contactGiven, "relationship": contactRelationship, "relationshipText": contactRelatedText};
	var contactAddrData = {"contactPostalCode": contactPostCode, "contactDistrict": contactCounty, "contactCity": contactDistrict, "contactLine": contactAddress};
	
	if(contactFamily == "" || contactGiven == ""){
		postData = {...idData, ...caseData};
	}else{
		postData = {...idData, ...caseTelData, ...caseAddrData, ...contactData, ...contactAddrData};
	}

	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, '${base}/division/api/fhir/patient/update');
	
	if(result.success){
		swal("更新成功", "病患資訊如下：\n" + result.msg, "success");
	}else{
		swal("更新失敗", result.msg, "error");
	}

}

//刪除病患
function delPtInfo(){
	var id = $("#serialNo").val();
	var postData = {"id": id};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, '${base}/division/api/fhir/patient/delete');
	if(result.success){
		swal("刪除成功", result.msg, "success");
	}else{
		swal("刪除失敗", result.msg, "error");
	}
}

function postObj(param){
	var data = "";
	var paramTxt = $(".paramTxt").val();
	
	if(paramTxt != ""){
		switch(param){
			case 'id':
				data = {"id": paramTxt};
				break;
			case 'identifier':
				data = {"identifier": paramTxt};
				break;
			case 'name':
				data = {"name": paramTxt};
				break;
			case 'orgnization':
				data = {"orgnization": paramTxt};
				break;
		}
	}
	
	return data;
}

function appendOption(versionNum){
	$('#version option[value!=""]').remove();
	
	for(var i=1; i<=versionNum; i++){
		var html = "<option value='" + i + "'>版次 " + i + "</option>";
		$("#version").append(html);
	}
	$("#version").val(versionNum);
	
	$("#version").change(function(){
		var id = $("#serialNo").val();
		var version = $(this).val();
		var postData = {"id": id, "version": version};
		var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, '${base}/division/api/fhir/patient/history');
		if(result.success){
			setValue(result);
			swal("調閱成功", result.msg, "success");
		}else{
			swal("調閱失敗", result.msg, "error");
		}
	});
}

function setValue(result){
	var activeStatus = result.info.active === true ? "true" : "false";
	$("#serialNo").val(result.info.id);
	$("#idno").val(result.info.identifier);
	$("#gender").val(result.info.gender);	
	$("#family").val(result.info.family);
	$("#given").val(result.info.given);
	$("#birthdate").val(result.info.birthdate);
	$("#phone").val(result.info.phone);
	$("#email").val(result.info.email);
	$("#url").val(result.info.url);
	$("#twzipcode").find("select[name='county']").val(result.info.district).trigger('change');
	$("#twzipcode").find("select[name='district']").val(result.info.city).trigger('change');
	$("#address").val(result.info.line);
	//緊急聯絡人
	$("#contact-family").val(result.info.contactNameOfFamily);
	$("#contact-given").val(result.info.contactNameOfGiven);
	$("#contact-relationship").val(result.info.relationshipText).trigger('change');
	$("#twzipcode2").find("select[name='county']").val(result.info.contactDistrict).trigger('change');
	$("#twzipcode2").find("select[name='district']").val(result.info.contactCity).trigger('change');
	$("#contact-address").val(result.info.contactLine);
	
	$("#active").val(activeStatus);
}
	
</script>

<style>
.lower{
	text-transform: lowercase;
}

.upper{
	text-transform: uppercase;
}

.hb-color td .input-group{
	margin-bottom: 0px !important;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />