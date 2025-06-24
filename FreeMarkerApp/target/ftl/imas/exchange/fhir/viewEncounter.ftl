<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<#if isNewForm?? >
					<div class="item-name">掛號建檔</div>
					<#else>
					<div class="item-name">掛號總覽</div>
					</#if>
				</div>
				<#if !isNewForm?? >
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.back"/></span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/caseView">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "casemgnt.menu.view"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/observation">
						<i class="fa fa-id-card fa-lg"></i>
						<span>生理量測</span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/imageStudy">
						<i class="fa fa-id-card fa-lg"></i>
						<span>檢測影像</span>
					</div>		
				</div>
           		</#if>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<form class="form" id="encounterForm" action="${base}/division/api/fhir/encounter/save" method="POST">
					<@spring.bind "encounterView" />
					<#-- Default -->
					<input type="hidden" name="metaView.profiles[0]" value="https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Encounter-twcore"> <#--Meta-->
					<#if !isNewForm?? >
					<input type="hidden" name="id" value="${encounterView.id}">
					</#if>
					<table class="default-table">
						<#if !isNewForm?? >				
						<tr>
							<td>識別碼(ID)：</td>
							<td>
								<@spring.formInput path="encounterView.id" attributes='class="form-control" disabled="disabled"' />
							</td>
						</tr>
						</#if>
						<tr>
							<td>身份證字號：</td>
							<td>
								<@spring.formInput path="encounterView.identity" attributes='class="form-control upper"' />
							</td>
							<td>狀態：</td>
							<td>
								<select id="gender" name="gender" class="form-control">
									<option value="">請選擇</option>
									<option value="PLANNED" <#if encounterView.status?? && encounterView.status == 'PLANNED'>selected=true</#if>>已計畫</option>
									<option value="FINISHED" <#if encounterView.status?? && encounterView.status == 'FINISHED'>selected=true</#if>>已完成</option>
									<option value="CANCELLED" <#if encounterView.status?? && encounterView.status == 'CANCELLED'>selected=true</#if>>已取消</option>
									<option value="UNKNOWN" <#if encounterView.status?? && encounterView.status == 'UNKNOWN'>selected=true</#if>>未知</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>ClassCode：</td>
							<td>
								<@spring.formInput path="encounterView.classCode" attributes='class="form-control" ' />
							</td>
							<td>TypeCode：</td>
							<td>
								<@spring.formInput path="encounterView.typeCode" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td>ServiceCode：</td>
							<td>
								<@spring.formInput path="encounterView.serviceCode" attributes='class="form-control" ' />
							</td>
							<td>ServiceDisplay：</td>
							<td>
								<@spring.formInput path="encounterView.serviceDisplay" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td>ServiceText：</td>
							<td>
								<@spring.formInput path="encounterView.serviceText" attributes='class="form-control" ' />
							</td>
							<td>Patient ID：</td>
							<td><@spring.formInput path="encounterView.subject" attributes='class="form-control" ' /></td>
						</tr>
						<tr>
						    <td>參與者：</td>
							<td>
							    <@spring.formInput path="encounterView.encounterParticipantViews[0].reference" attributes='class="form-control" ' />
							</td>						
						</tr>
						<tr>
							<td>開始時間：</td>
							<td>
							    <@spring.formInput path="encounterView.periodStart" attributes='class="form-control" ' />						
							</td>
							<td>結束時間：</td>
							<td>
							    <@spring.formInput path="encounterView.periodEnd" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td>ReasonCode：</td>
							<td>
							    <@spring.formInput path="encounterView.reasonCode" attributes='class="form-control" ' />
							</td>
							<td>ReasonDisplay：</td>
							<td>
							    <@spring.formInput path="encounterView.reasonDisplay" attributes='class="form-control" ' />
							</td>
						</tr>
					    <tr>
							<td>DischargeCode：</td>
							<td>
							    <@spring.formInput path="encounterView.dischargeCode" attributes='class="form-control" ' />
							</td>
							<td>Location：</td>
							<td>
							    <@spring.formInput path="encounterView.location" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="footer-btn-list">
									<button onclick="submitForm(event, this)"><i class="fa fa-save"></i> 儲存</button>
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
	startDatePicker('#birthday');
	//
	$("#twzipcode, #twzipcode2").twzipcode({
    	zipcodeIntoDistrict: false,
    	readonly: true
    });


    //setValue();
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
			swal("創建成功", "病患資訊如下：\n" + result.msg, "success");	
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