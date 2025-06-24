<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<#if isNewForm?? >
					<div class="item-name">個案建檔</div>
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
						<td>身份證字號：</td>
						<td>
							<input type="text" id="idno" class="form-control upper" />
						</td>
						<td>性別：</td>
						<td>
							<select id="gender" class="form-control">
								<option value="">請選擇</option>
								<option value="MALE">男性</option>
								<option value="FEMALE">女性</option>
								<option value="OTHER">其他</option>
								<option value="UNKNOWN">未知</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>姓名：</td>
						<td>
							<input type="text" id="family" class="form-control half" placeholder="姓(Last Name)" />
							<input type="text" id="given" class="form-control half" placeholder="名(First Name)" />
						</td>
						<td>生日：</td>
						<td>
							<input type="text" id="birthdate" class="form-control" data-date-end-date="0d" />
						</td>
					</tr>
					<tr>
						<td>個案聯絡手機：</td>
						<td>
							<input type="text" id="phone" class="form-control" />
						</td>
						<td>年齡：</td>
						<td>
                            <input type="text" id="age" class="form-control" disabled=disabled >
                        </td>
					</tr>
					<tr>
						<td>個案Email：</td>
						<td>
							<input type="text" id="email" class="form-control" />
						</td>
						<td>個案Line連結：</td>
						<td>
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
								<option value="true" >是</option>
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
								<#if isNewForm?? >
								<button class="func-btn" onclick="createPtInfo()"><i class="fa fa-save"></i> 新增</button>
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

    showAge();
    setValue();
});

function createPtInfo(){
	//個案本身資訊
	var idno = $("#idno").val();
	var gender = $("#gender").val();	
	var family = $("#family").val();
	var given = $("#given").val();
	var birthdate = $("#birthdate").val();
	var age = $('#age').val();
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
	var caseData = {"identifier":idno, "enNameFamily": family, "given": given, "gender": gender, "birthdate": birthdate,"age": age, "active": activeStatus};
	var caseTelData = {"phone": phone, "email": email, "url": url};
	var caseAddrData = {"postalCode": postCode, "district": county, "city": district, "line": address};
	var contactData = {"contactNameOfFamily": contactFamily, "contactNameOfGiven": contactGiven, "relationship": contactRelationship, "relationshipText": contactRelatedText};
	var contactAddrData = {"contactPostalCode": contactPostCode, "contactDistrict": contactCounty, "contactCity": contactDistrict, "contactLine": contactAddress};
	
var postData2 = {
    "idno": idno,
//    "metaView": { "profile": "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Patient-twcore" },
    "age": age,
    "gender": gender,
    "birthday": birthdate,
    "active": activeStatus,
    "humanNameView": {
        "enNameFamily": family,
        "enNameGiven": given
    },
//    "imageUrls": [
//        "https://2.bp.blogspot.com/-v3yEwItkXKQ/VaMN_1Nx6TI/AAAAAAAAvhM/zDXN_eZw_UE/s800/youngwoman_42.png"
//    ],
    "telecomView": {
        "mobileViews": [
            { "value": phone }
        ],
        "websiteViews": [
            { "value": url}
        ],
        "emailViews": [
            { "value": email }
        ]
    },
    "addressViews": [
        {
            "state": "TW",
            "country": "台灣",
            "city": county,
            "district": district,
            "postalCode": postCode,
            "line": address
        }
    ],
    "icemanViews": [
        {
        "iceHumanNameView": {
            "enNameFamily": contactFamily,
            "enNameGiven": contactGiven
        },
        "iceAddressView": {
            "state": "TW",
            "country": "台灣",
            "city": contactCounty,
            "postalCode": contactPostCode,
            "district": contactDistrict,
            "line": contactAddress
        },
        "relationshipCode": contactRelatedText
        }
    ]
}

	
	
	if(contactFamily == "" || contactGiven == ""){
		postData = caseData;
	}else{
		postData = {...caseData, ...caseTelData, ...caseAddrData, ...contactData, ...contactAddrData};
	}

	var result = wg.evalForm.getJson({"data":JSON.stringify(postData2)}, '${base}/division/api/fhir/patient/create');
	
	if(result.success){
		swal("創建成功", "病患資訊如下：\n" + result.msg, "success");
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

function showAge(){
    $('#birthdate').on('change', function() {
        const birthdate = new Date($(this).val());
        const today = new Date();
        let age = today.getFullYear() - birthdate.getFullYear();
        const monthDifference = today.getMonth() - birthdate.getMonth();

        if (monthDifference < 0 || (monthDifference === 0 && today.getDate() < birthdate.getDate())) {
            age--;
        }

        $('#age').val(age);
    });
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