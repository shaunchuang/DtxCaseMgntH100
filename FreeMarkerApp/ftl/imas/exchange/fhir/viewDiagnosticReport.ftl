<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<#if isNewForm?? >
					<div class="item-name">新增診斷報告(Diagnostic Report)</div>
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
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/observation">
						<i class="fa fa-stethoscope fa-lg"></i>
						<span>生理量測</span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/imagingstudy">
						<i class="fa fa-image fa-lg"></i>
						<span>檢測影像</span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/diagnosticreport">
						<i class="fa fa-file-pdf fa-lg"></i>
						<span>診斷報告</span>
					</div>		
				</div>
				</#if>	
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
			    <form class="form" id="diagnosticReportForm" action="${base}/division/api/fhir/diagnosticreport/save" method="POST">
				    <@spring.bind "diagnosticReportView"/>
				    <#-- Default -->
				    <input type="hidden" name="metaView.profiles[0]" value="https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/DiagnosticReport-twcore">
				    <#if !isNewForm?? >
					<input type="hidden" name="id" value="${diagnosticReportView.id!""}">
					<#else>
					<input type="hidden" name="id" id="id" value="">
					</#if>
				<table class="default-table">
				    <#if !isNewForm?? >			
					<tr>
						<td>診斷報告編號(ID)：</td>
						<td colspan="3">
						    <@spring.formInput path="diagnosticReportView.id" attributes='class="form-control" disabled="disabled"'/>
						</td>
					</tr>
					</#if>
					<tr>
						<td>狀態：</td>
						<td>
						    <select id="status" name="status" class="form-control" />
						    <option value="">請選擇</option>
						    <option value="REGISTERED"<#if diagnosticReportView.status?? && diagnosticReportView.status == 'REGISTERED'>selected=true</#if> >已註冊</option>
						    <option value="FINAL"<#if diagnosticReportView.status?? && diagnosticReportView.status == 'FINAL'>selected=true</#if> >已完成</option>
						    <option value="CANCELLED"<#if diagnosticReportView.status?? && diagnosticReportView.status == 'CANCELLED'>selected=true</#if> >已取消</option>
						    <option value="UNKNOWN"<#if diagnosticReportView.status?? && diagnosticReportView.status == 'CANCELLED'>selected=true</#if> >未知</option>
						</td>
						<td>Category：</td>
						<td>
							<span>Code：</span>
						    <@spring.formInput path="diagnosticReportView.categoryCode" attributes='class="form-control"' />
							<span>Display：</span>
						    <@spring.formInput path="diagnosticReportView.categoryDisplay" attributes='class="form-control"' />
						    <span>註釋：</span>
						    <@spring.formInput path="diagnosticReportView.categoryText" attributes='class="form-control"' />
						</td>
					</tr>
					<tr>
						<td>Report：</td>
						<td>
						    <span>Code：</span>
						    <@spring.formInput path="diagnosticReportView.diagnosticReportCode" attributes='class="form-control"' />
						    <span>Display：</span>
						    <@spring.formInput path="diagnosticReportView.diagnosticReportDisplay" attributes='class="form-control"' />
						    <span>註釋：</span>
						    <@spring.formInput path="diagnosticReportView.diagnosticReportText" attributes='class="form-control"' />
						</td>
						<td>Date：</td>
						<td>
						    <span>Effective Date：</span>
			                <#if diagnosticReportView.effectiveDateTime?? >
							<@spring.formDateStrInput diagnosticReportView?if_exists.effectiveDateTime "effectiveDateTime" 'class="form-control" data-date-end-date="0d" placeholder="填寫有效日期"' "text" "yyyy-MM-dd" />
							<#else>
							<@spring.formDateStrInput "" "effectiveDateTime" 'class="form-control" data-date-end-date="0d" placeholder="填寫有效日期"' "text" "yyyy-MM-dd" />
							</#if>
							<span>Issued Date：</span>
							<#if diagnosticReportView.issued?? >
							<@spring.formDateStrInput diagnosticReportView?if_exists.issued "issued" 'class="form-control" data-date-end-date="0d" placeholder="填寫檢測日期"' "text" "yyyy-MM-dd" />
							<#else>
							<@spring.formDateStrInput "" "effectiveDateTime" 'class="form-control" data-date-end-date="0d" placeholder="填寫檢測日期"' "text" "yyyy-MM-dd" />
							</#if>
							<!--<span>Effective Date：</span>
						    <@spring.formInput path="diagnosticReportView.effectiveDateTime"  attributes='type="date" class="form-control"' />
							<span>Issued Date：</span>
						    <@spring.formInput path="diagnosticReportView.issued"  attributes='type="date" class="form-control"' />-->
						</td>
					</tr>
					<tr>
						<td>掛號 ID：</td>
						<td>
						    <#if isNewForm??>
                            <input type="text" name="encounter" class="form-control" value="Encounter/${encounterId!""}">
                            <#else>
                            <#assign ref = diagnosticReportView.encounter?if_exists.reference!"">
                            <input type="text" name="encounter" class="form-control" value="${ref!""}" placeholder="掛號參照,如：Encounter/5">
                            </#if>	
						</td>
						<td>病患 ID：</td>
						<td>
                            <#if isNewForm?? >
							<input type="text" name="subject" class="form-control" value="Patient/${patientId!""}" placeholder="病患參照(subject),如：Patient/5">
							<#else>
							<#assign ref = diagnosticReportView.subject?if_exists.reference!"">
							<input type="text" name="subject" class="form-control" value="${ref!""}" placeholder="病患參照(subject),如：Patient/5">
							</#if>
                        </td>
					</tr>
					<tr>
						<td>診斷者 ID：</td>
                        <td>
						    <#if isNewForm??>
                            <input type="text" name="performers[0]" class="form-control" value="Practitioner/${practitionerId!""}">
                            <#else>
                            <#assign ref = diagnosticReportView.performers[0]?if_exists.reference!"">
                            <input type="text" name="performers[0]" class="form-control" value="${ref!""}" placeholder="診斷者參照,如：Practitioner/5">
                            </#if>	
						</td>
						<td>檢測項 ID：</td>
						<td>
						    <#if isNewForm??>
                            <input type="text" name="result[0]" class="form-control" value="Observation/${observationId!""}">
                            <#else>
                            <#assign ref = diagnosticReportView.result[0]?if_exists.reference!"">
                            <input type="text" name="diagnosticReportView.result[0]" class="form-control" value="${ref!""}" placeholder="檢查項參照,如：Observation/5"/>
                            </#if>	
						</td>
					</tr>
					<tr>
						<td>影像報告 ID：</td>
						<td>
			                <#if isNewForm??>
                            <input type="text" name="imagingStudy[0]" class="form-control" value="ImagingStudy/${imagingStudyId!""}">
                            <#else>
                            <#assign ref = diagnosticReportView.imagingStudy[0]?if_exists.reference!"">
						    <input type="text" name="diagnosticReportView.imagingStudy[0]" class="form-control"  value="${ref!""}" placeholder="影像報告參照,如：ImagingStudy/5"/>
                            </#if>						
						</td>
					    <td>診斷結論：</td>
					    <td>
						    <@spring.formInput path="diagnosticReportView.conclusion" attributes='class="form-control"' />
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
			</div>
		</div>	
	</div>
</body>

<script>

$(document).ready(function(){


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
			//swal("創建成功", "診斷報告資訊如下：\n" + result.msg, "success");
			swal({
			  	title: "創建成功",
			  	text: "診斷報告資訊如下：\n" + result.msg,
			  	type: "success",
			  	showConfirmButton: true
			},function(confirm){
				if(confirm) window.location.href = "${base}/${__lang}/division/web/exchange/fhir/patient/${patientId!""}/diagnosticreport";
			});	
		<#else>
			swal({
			  	title: "更新成功",
			  	text: "診斷報告資訊如下：\n" + result.msg,
			  	type: "success",
			  	showConfirmButton: true
			},function(confirm){
				if(confirm) window.location.href = "${base}/${__lang}/division/web/exchange/fhir/patient/${patientId!""}/diagnosticreport";
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
	
</script>

<style>
.lower{
	text-transform: lowercase;
}

.upper{
	text-transform: uppercase;
}

.hidden{
    display: none;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />