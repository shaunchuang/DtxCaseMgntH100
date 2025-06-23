<#import "/util/spring.ftl" as spring />
  
<div id="report-content">
	<#if message?exists>
		<#if message == "emptyMessage">
		<div class="info-message">
			<span>如需填寫/檢視個案就診紀錄，請點選左側紀錄</span>
		</div>
		</#if>
	<#else>
	<table class="default-table">
		<tr>
			<td class="sub-title" style="width: 23%">
				<@spring.message "hcrecord.detail.label.evalDate"/>						
			</td>
			<td><#if hcInfo??>${hcInfo.evalDate!""}</#if></td>
		</tr>
		<tr>
			<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.subjective"/></td>
		</tr>
		<tr>
			<td colspan="2" class="txt-cnt"><#if hcInfo.subjective?has_content>${hcInfo.subjective}<#else>無</#if></td>
		</tr>
		<tr>
			<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.objective"/></td>
		</tr>
		<tr>
			<td colspan="2" class="txt-cnt"><#if hcInfo.objective?has_content>${hcInfo.objective}<#else>無</#if></td>
		</tr>
		<tr>
			<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.diagnosis"/></td>
		</tr>
		<tr>
			<td><@spring.message "hcrecord.detail.label.maincode"/></td>
			<td>
				<#if hcInfo??>${hcInfo.mainIcdCode.viewTxt!""}</#if>
			</td>
		</tr>
		<#if hcInfo.subIcdCode1?? && hcInfo.subIcdCode1.viewTxt?has_content>
		<tr>
			<td><@spring.message "hcrecord.detail.label.subcode1"/></td>
			<td>				
				<#if hcInfo?? && hcInfo.subIcdCode1??>${hcInfo.subIcdCode1.viewTxt!""}</#if>
			</td>
		</tr>
		</#if>
		<#if hcInfo.subIcdCode2?? && hcInfo.subIcdCode2.viewTxt?has_content>
		<tr>
			<td><@spring.message "hcrecord.detail.label.subcode2"/></td>
			<td>
				<#if hcInfo?? && hcInfo.subIcdCode2??>${hcInfo.subIcdCode2.viewTxt!""}</#if>
			</td>
		</tr>
		</#if>
		<#if hcInfo.subIcdCode3?? && hcInfo.subIcdCode3.viewTxt?has_content>
		<tr>
			<td><@spring.message "hcrecord.detail.label.subcode3"/></td>
			<td>
				<#if hcInfo?? && hcInfo.subIcdCode3??>${hcInfo.subIcdCode3.viewTxt!""}</#if>
			</td>
		</tr>
		</#if>
		<#if hcInfo.subIcdCode4?? && hcInfo.subIcdCode4.viewTxt?has_content>
		<tr>
			<td><@spring.message "hcrecord.detail.label.subcode4"/></td>
			<td>
				<#if hcInfo?? && hcInfo.subIcdCode4??>${hcInfo.subIcdCode4.viewTxt!""}</#if>
			</td>
		</tr>
		</#if>
		<#if hcInfo.subIcdCode5?? && hcInfo.subIcdCode5.viewTxt?has_content>
		<tr>
			<td><@spring.message "hcrecord.detail.label.subcode5"/></td>
			<td>
				<#if hcInfo?? && hcInfo.subIcdCode5??>${hcInfo.subIcdCode5.viewTxt!""}</#if>
			</td>
		</tr>
		</#if>
		<!-- 治療師不需提供處置資訊 -->
		<!--<tr>
			<td class="sub-title"><@spring.message "hcrecord.detail.label.plan"/></td>
			<td><#if hcInfo??>處置資訊放置區</#if></td>
		</tr>
		<tr>
			<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.plan"/></td>			
		</tr>
		<tr>
			<td colspan="2">
				<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
					<thead>
				      <tr class="tablesorter-headerRow">
				      	<th width="40%"><@spring.message "hcrecord.detail.column.code"/></th>
				      	<th width="10%"><@spring.message "hcrecord.detail.column.period"/></th>
				      	<th width="10%"><@spring.message "hcrecord.detail.column.points"/></th>					      	
				      	<th width="20%"><@spring.message "hcrecord.detail.column.executor"/></th>    
				        <th width="10%"><@spring.message "hcrecord.detail.column.startDate"/></th>
				        <th width="10%"><@spring.message "hcrecord.detail.column.endDate"/></th>
				      </tr>					      
				    </thead>
					<tbody id="list_cnt">
						<#if hcInfo?? && hcInfo.paymentItems?has_content>									
						<#assign itemList = hcInfo.paymentItems>
						<#list itemList as info>
						<tr class="clone-row">
					      	<td>${info.paymentItemCode.codeTxt!""}</td>
					      	<td>${info.amount!""}</td>
					      	<td>${info.points!""}</td>
					      	<td>${info.executor.codeTxt!""}</td>
					      	<td>${info.beginTime!""}</td>
					      	<td>${info.endTime!""}</td>								      	
				      	</tr>
					    </#list>
					    </#if>  
			      	</tbody>
				</table>				
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<table class="table table-striped table-bordered bootstrap-datatable table-customed sub-table">
					<thead>
				      <tr class="tablesorter-headerRow">
				      	<th width="55%"><@spring.message "hcrecord.detail.column.copaymentCode"/></th>
				      	<th width="15%"><@spring.message "hcrecord.detail.column.totalPoints"/></th>
				      	<th width="15%"><@spring.message "hcrecord.detail.column.partPoints"/></th>					      	
				      	<th width="15%"><@spring.message "hcrecord.detail.column.serialNo"/></th>
				      </tr>							      
				    </thead>
					<tbody id="list_cnt">
						<#if hcInfo??>												      	
				      	<tr>
				      		<td>${hcInfo.coPaymentCode.codeTxt!""}</td>
					      	<td>${hcInfo.total_points!""}</td>
					      	<td>${hcInfo.part_points!""}</td>
					      	<td>${hcInfo.serial_no!""}</td>
				      	</tr>
				      	</#if>				      	
			      	</tbody>
				</table>
			</td>
		</tr>-->								
	</table>
	</#if>
<script>
			<#if testScale?? >
		var testScale = ${testScale!""};
		console.log("testScale: ",  testScale);
		</#if>

		<#if testHcInfo?? >
		var testHcInfo = ${testHcInfo!""};
		console.log("testHcInfo: ",  testHcInfo);
		</#if>
</script>
	<style>
	.evaluation-result{
		width: 100%;
		display: flex;
		justify-items: center;
		align-items: center;
		margin-bottom: 5px;
	}
	
	.evaluation-result span{
		margin-left: 10px;
	}
	
	.default-table tr td{
		font-size: 1.4rem !important;
		padding: 5px 10px !important;
	}
	</style>
</div>
