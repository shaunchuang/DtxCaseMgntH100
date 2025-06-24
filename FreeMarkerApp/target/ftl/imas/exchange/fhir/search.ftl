<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name">FHIR個案歷程記錄查詢</div>
				</div>				
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<form class="form" id="pateintForm" action="${base}/division/api/fhir/patient/save" method="POST">
					<@spring.bind "patientView" />
					<#-- Default -->
					<input type="hidden" name="metaView.profiles[0]" value="https://hapi.fhir.tw/fhir/StructureDefinition/MITW-T1-SC3-PatientContact"> <#--Meta-->
					<input type="hidden" name="nationalityCode2" value="TW"> <#--國籍2碼-->
					<input type="hidden" name="nationalityCode3" value="TWN"> <#--國籍3碼-->
					<input type="hidden" name="addressViews[0].country" value="TW"> <#--聯絡地址國籍2碼-->
					<input type="hidden" name="icemanViews[0].iceAddressView.country" value="TW"> <#--緊急聯絡人地址國籍2碼-->
					<input type="hidden" name="active" value="true"> <#--啟用-->
					<input type="hidden" name="language" value="zh-TW"> <#--語系-->
					<#if patientView.id?? >
					<input type="hidden" name="id" value="${patientView.id}">
					<#else>
					<input type="hidden" name="id" >
					</#if>
					<table class="default-table">
						<#if versionId?? >
						<tr>
							<td>歷史版本號：</td>
							<td colspan="3">
								<select class="form-control" onchange="changeVersion(this)">
									<#list versionId..1 as vid>
									<option value="${vid}" <#if vid==currentVersionId>selected</#if> >版本號-${vid}</option>
									</#list>
								</select>
							</td>
						</tr>
						</#if>
						<#if !isNewForm?? >				
						<tr>
							<td>識別碼(ID)：</td>
							<td>
								<@spring.formInput path="patientView.id" attributes='class="form-control" disabled="disabled"' />
							</td>
							<td>為使用中個案：</td>
							<td>
								<select id="active" name="active" class="form-control">
									<option value="true" <#if patientView.active == true>selected=true</#if>>是</option>
									<option value="false" <#if patientView.active == false>selected=true</#if>>否</option>
								</select>
							</td>
						</tr>
						</#if>
						<tr>
							<td>身份證字號：</td>
							<td>
								<@spring.formInput path="patientView.idno" attributes='class="form-control upper" ' />
							</td>
							<td>性別：</td>
							<td>
								<select id="gender" name="gender" class="form-control">
									<option value="">請選擇</option>
									<option value="MALE" <#if patientView.gender?? && patientView.gender == 'MALE'>selected=true</#if>>男性</option>
									<option value="FEMALE" <#if patientView.gender?? && patientView.gender == 'FEMALE'>selected=true</#if>>女性</option>
									<option value="OTHER" <#if patientView.gender?? && patientView.gender == 'OTHER'>selected=true</#if>>其他</option>
									<option value="UNKNOWN" <#if patientView.gender?? && patientView.gender == 'UNKNOWN'>selected=true</#if>>未知</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>姓名：</td>
							<td>
								<@spring.formInput path="patientView.humanNameView.enNameFamily" attributes='class="form-control half" placeholder="姓(Last Name)" ' />
								<@spring.formInput path="patientView.humanNameView.enNameGiven" attributes='class="form-control half" placeholder="名(First Name)" ' />
							</td>
							<td>生日：</td>
							<td>
								<#if patientView.birthday?? >
								<@spring.formDateStrInput patientView?if_exists.birthday "birthday" 'class="form-control birth" data-date-end-date="0d"' "text" "yyyy-MM-dd" />
								<#else>
								<@spring.formDateStrInput "" "birthday" 'class="form-control birth" data-date-end-date="0d"' "text" "yyyy-MM-dd" />
								</#if>
								<input type="hidden" name="age" class="calAge" value="<#if patientView.age?? >${patientView.age!""}</#if>">
							</td>
						</tr>
						<tr>
							<td>個案聯絡手機：</td>
							<td>
								<@spring.formInput path="patientView.telecomView.mobileViews[0].value" attributes='class="form-control" ' />
							</td>
							<td>個案Email：</td>
							<td>
								<@spring.formInput path="patientView.telecomView.emailViews[0].value" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td>個案Line連結：</td>
							<td colspan="3">
								<@spring.formInput path="patientView.telecomView.websiteViews[0].value" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td>個案聯絡地址：</td>
							<td colspan="3">
								<div id="twzipcode" class="zipcode form-inline">
								  	<div data-role="zipcode" data-name="addressViews[0].postalCode" data-value="<#if patientView.addressViews?? >${patientView.addressViews[0].postalCode!""}</#if>" ></div>
								  	<div data-role="county" data-name="addressViews[0].city" data-value="<#if patientView.addressViews?? >${patientView.addressViews[0].city!""}</#if>" ></div>
								  	<div data-role="district" data-name="addressViews[0].district" data-value="<#if patientView.addressViews?? >${patientView.addressViews[0].district!""}</#if>" ></div>
								</div>
								<div class="td-container">
									<@spring.formInput path="patientView.addressViews[0].twVillage" attributes='class="form-control" placeholder="村(里)" ' />
									<@spring.formInput path="patientView.addressViews[0].twNeighborhood" attributes='class="form-control" placeholder="鄰" ' />
									<@spring.formInput path="patientView.addressViews[0].line" attributes='class="form-control" placeholder="路/街" ' />
									<@spring.formInput path="patientView.addressViews[0].twSection" attributes='class="form-control" placeholder="段" ' />
									<@spring.formInput path="patientView.addressViews[0].twLane" attributes='class="form-control" placeholder="巷/衖" ' />
									<@spring.formInput path="patientView.addressViews[0].twAlley" attributes='class="form-control" placeholder="弄" ' />
									<@spring.formInput path="patientView.addressViews[0].twNumber" attributes='class="form-control" placeholder="號" ' />
									<@spring.formInput path="patientView.addressViews[0].twFloor" attributes='class="form-control" placeholder="樓" ' />
									<@spring.formInput path="patientView.addressViews[0].twRoom" attributes='class="form-control" placeholder="室" ' />
								</div>
								<!--<input type="text" id="address" class="form-control" placeholder="輸入地址" />-->
							</td>						
						</tr>
						<tr>
							<td class="h-color">緊急聯絡人：</td>
							<td>								
								<@spring.formInput path="patientView.icemanViews[0].iceHumanNameView.enNameFamily" attributes='class="form-control half" placeholder="姓(Last Name)" ' />
								<@spring.formInput path="patientView.icemanViews[0].iceHumanNameView.enNameGiven" attributes='class="form-control half" placeholder="名(First Name)" ' />
							</td>
							<td class="h-color">緊急聯絡人關係：</td>
							<td>
								<#if patientView.icemanViews[0].relationshipCode?has_content>
								<#assign relationshipCode = patientView.icemanViews[0].relationshipCode>
								</#if>
								<select id="icemanViews[0].relationshipCode" name="icemanViews[0].relationshipCode" class="form-control">
									<option value="">請選擇</option>
									<option value="GRFTH" <#if relationshipCode?? && relationshipCode == 'GRFTH'>selected=true</#if>>外公</option>
									<option value="GRMTH" <#if relationshipCode?? && relationshipCode == 'GRMTH'>selected=true</#if>>外婆</option>
									<option value="INLAW" <#if relationshipCode?? && relationshipCode == 'INLAW'>selected=true</#if>>夫妻</option>
									<option value="FTH" <#if relationshipCode?? && relationshipCode == 'FTH'>selected=true</#if>>父親</option>
									<option value="MTH" <#if relationshipCode?? && relationshipCode == 'MTH'>selected=true</#if>>母親</option>
									<option value="UNCLE" <#if relationshipCode?? && relationshipCode == 'UNCLE'>selected=true</#if>>叔叔</option>
									<option value="AUNT" <#if  relationshipCode?? && relationshipCode == 'AUNT'>selected=true</#if>>阿姨</option>
									<option value="COUSN" <#if  relationshipCode?? && relationshipCode == 'COUSN'>selected=true</#if>>兄弟姊妹</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="h-color">緊急聯絡人地址：</td>
							<td colspan="3">
								<div id="twzipcode2" class="zipcode form-inline">
								  	<div data-role="zipcode" data-name="icemanViews[0].iceAddressView.postalCode" data-value="<#if patientView.icemanViews[0].iceAddressView?? >${patientView.icemanViews[0].iceAddressView.postalCode!""}</#if>" ></div>
								  	<div data-role="county" data-name="icemanViews[0].iceAddressView.city" data-value="<#if patientView.icemanViews[0].iceAddressView?? >${patientView.icemanViews[0].iceAddressView.city!""}</#if>" ></div>
								  	<div data-role="district" data-name="icemanViews[0].iceAddressView.district" data-value="<#if patientView.icemanViews[0].iceAddressView?? >${patientView.icemanViews[0].iceAddressView.district!""}</#if>" ></div>
								</div>
								<div class="td-container">
									<@spring.formInput path="patientView.icemanViews[0].iceAddressView.twVillage" attributes='class="form-control" placeholder="村(里)" ' />
									<@spring.formInput path="patientView.icemanViews[0].iceAddressView.twNeighborhood" attributes='class="form-control" placeholder="鄰" ' />
									<@spring.formInput path="patientView.icemanViews[0].iceAddressView.line" attributes='class="form-control" placeholder="路/街" ' />
									<@spring.formInput path="patientView.icemanViews[0].iceAddressView.twSection" attributes='class="form-control" placeholder="段" ' />
									<@spring.formInput path="patientView.icemanViews[0].iceAddressView.twLane" attributes='class="form-control" placeholder="巷/衖" ' />
									<@spring.formInput path="patientView.icemanViews[0].iceAddressView.twAlley" attributes='class="form-control" placeholder="弄" ' />
									<@spring.formInput path="patientView.icemanViews[0].iceAddressView.twNumber" attributes='class="form-control" placeholder="號" ' />
									<@spring.formInput path="patientView.icemanViews[0].iceAddressView.twFloor" attributes='class="form-control" placeholder="樓" ' />
									<@spring.formInput path="patientView.icemanViews[0].iceAddressView.twRoom" attributes='class="form-control" placeholder="室" ' />
								</div>
							</td>
						</tr>
						<tr>
							<td>組織ID</td>
							<td colspan="4">
							    <#if isNewForm??>
							    <input type="text" name="managingOrganization" class="form-control" value="Organization/${organizationId!""}">
								<#else>
								<#assign ref = patientView.managingOrganization?if_exists.reference!"">
								<input type="text" name="managingOrganization" class="form-control" value="${ref!""}" placeholder="組織參照,如:Organization/6">
							    </#if>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="footer-btn-list">
									<button onclick="submitForm(event, this)"><i class="fa fa-save"></i> 儲存</button>
								</div>	
							</td>
						</tr>
						<!--<tr>
						    <td>組織ID</td>
						    <td>						    
						    <#if isNewForm??>
                            <input type="text" name="managingOrganization" class="form-control" value="Organization/${organizationId!""}">
                            <#else>
                            <#assign ref = patientView.managingOrganization!"">
                            <input type="text" name="encounter" class="form-control" value="${ref!""}" placeholder="掛號參照,如：Organization/5">
                            </#if>	
                            </td>
						</tr>-->					
					</table>
				</form>
			</div>
		</div>	
	</div>
</body>

<script>

$(document).ready(function(){
	startDatePicker('#birthday');
	//
	$("#twzipcode, #twzipcode2").twzipcode({
    	zipcodeIntoDistrict: false,
    	readonly: true
    });

//	<#if !patientView.id?? >
//	var uuid = generateUUID();
//	$("input[name='id']").val(uuid);
//	</#if>
    //setValue();
});

function generateUUID() {
    return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, c =>
        (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
    );
}

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
    	postData[inputName] = inputValue;
	});
	
	// 遍歷表單中的每個輸入字段
	$(form).find("select").each(function(){
		var selectName = $(this).attr("name");
    	var selectValue = $(this).val();
    	postData[selectName] = selectValue;
	});
	
	console.log(postData);
	
	// 取得targetURL
	var targetURL = $(form).attr('action');
	
	var result = wg.evalForm.getJson(postData, targetURL);
	if(result.success){
		<#if isNewForm?? >
			//swal("創建成功", "病患資訊如下：\n" + result.msg, "success");
			swal({
			  	title: "創建成功",
			  	text: "病患資訊如下：\n" + result.msg,
			  	type: "success",
			  	showConfirmButton: true
			},function(confirm){
				if(confirm) window.location.href = "${base}/${__lang}/division/web/exchange/fhir";
			});	
		<#else>
			swal("更新成功", "病患資訊如下：\n" + result.msg, "success");
		</#if>
	}else{
		<#if isNewForm?? >
			swal("創建失敗！", result.msg, "error");
		<#else>
			swal("更新失敗！", result.msg, "error");
		</#if>
	}
}

function changeVersion(obj){
	var version = $(obj).val();
	window.location = "${base}/${__lang}/division/web/exchange/fhir/patient/${patientId!""}/caseView/v" + version;
}
	
</script>

<style>
.lower{
	text-transform: lowercase;
}

.upper{
	text-transform: uppercase;
}

.td-container {
    display: flex;
    flex-wrap: wrap;
}

.td-container input{
    flex: 1;
}

.td-container input:not(:last-child) {
    margin-right: 5px; /* 可以根据需要调整间距 */
}

.form-inline div{
	display: inline;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />