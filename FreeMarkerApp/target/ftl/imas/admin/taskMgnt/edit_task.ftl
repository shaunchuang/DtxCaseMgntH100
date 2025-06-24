<#import "/META-INF/spring.ftl" as spring />
<#import "/META-INF/mspring.ftl" as mspring />
 
<div id="myModuleContent">
	<#if mode?? && mode=="新增">
	<form class="form" id="taskForm" action="${base}/employee/task/doCreateTask" method="POST">
	<#elseif mode?? && mode=="編輯">
	<form class="form" id="taskForm" action="${base}/employee/task/doEditTask" method="POST">
	</#if>
		<@spring.bind "wgTask" />
		<#if mode?? && mode=="編輯">
		<@spring.formHiddenInput path="wgTask.id" />
		<@spring.formHiddenInput path="wgTask.createTime" />
		</#if>
		<table class="default-table">
			<tr>
				<td><@spring.message "task.label.cat"/></td>
				<td>
					<select id="cat" name="cat" class="form-control">
						<option value=""><@spring.message "task.option.select.hint"/></option>
						<#if mode?? && mode=="新增">
                        <#list catList as cat>                              	
                        <option value="${cat_index+1}">${cat}</option>
                        </#list>
						<#else>
						<#list catList as cat>
						<#if cat_index+1 == wgTask.cat>
						<option value="${cat_index+1}" selected=selected>${cat}</option>
						<#else>
						<option value="${cat_index+1}">${cat}</option>
						</#if>
						</#list>
						</#if>
					</select>
				</td>
			</tr>
			<tr>
				<td><@spring.message "task.label.case"/></td>
				<td>
					<select id="caseNo" name="caseNo" >
                        <option value=""><@spring.message "task.option.case.hint"/></option>
                        <#if mode?? && mode=="新增">
                        <#list caseList as case>                              	
                        <option value="${case.caseNo!""}">[${case.idNo!""}] ${case.name!""}</option>
                        </#list>
						<#else>
						<#list caseList as case>
						<#assign caseItem = case.caseNo>					
						<option value="${case.caseNo!""}" <#if caseItem == wgTask.caseNo>selected=selected</#if>>[${case.idNo!""}] ${case.name!""}</option>
						</#list>
						</#if>
                    </select>
				</td>
			</tr>
			<tr>
				<td><@spring.message "task.label.interval"/></td>
				<td>
					<@spring.formInput path="wgTask.beginDate" attributes='class="form-control half" ' /> ~ <@spring.formInput path="wgTask.endDate" attributes='class="form-control half" ' />
				</td>
			</tr>
			<#if mode?? && mode=="新增">
			<tr>
				<td><@spring.message "task.label.period"/></td>
				<td>
					<div class="form-check">
					  	<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" data-type="week" >
					  	<label class="form-check-label" for="flexRadioDefault1"><@spring.message "task.label.week"/></label>
					</div>
					<div class="form-check">
					  	<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" data-type="tweek" >
					  	<label class="form-check-label" for="flexRadioDefault2"><@spring.message "task.label.biweekly"/></label>
					</div>
					<div class="form-check">
					  	<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault3" data-type="month" >
					  	<label class="form-check-label" for="flexRadioDefault3"><@spring.message "task.label.month"/></label>
					</div>
					<div class="waring-hint">※ <@spring.message "task.label.warning.hint"/></div>
					<input type="hidden" name="taskType" class="hidden-type" />
				</td>
			</tr>
			</#if>
			<tr>
				<td><@spring.message "task.label.executeTime"/></td>
				<td>
					<input type="text" id="beginTime" name="beginTime" class="form-control half beginTime" <#if mode?? && mode=="編輯">value="${wgTask.beginTime}"</#if>> ~ <input type="text" id="endTime" name="endTime" class="form-control half endTime" <#if mode?? && mode=="編輯">value="${wgTask.endTime}"</#if>>
				</td>
			</tr>
			<tr>
				<td><@spring.message "task.label.executor"/></td>
				<td>
					<#if mode = "新增">
					<select id="collaborateId_select" multiple="multiple" class="form-control" >
					<#list executors as executor>
						<option value="${executor.id}" >[${executor.userNo}] ${executor.name} ${executor.role}</option>
					</#list>
					</select>
					<#else>
					<select id="collaborateId_select" multiple="multiple" class="form-control" >					
					<#list executors as executor>
						<#assign found = false>
						<#if selectdExecutors?has_content>
							<#if selectdExecutors?contains(",")>
								<#assign ids = selectdExecutors?split(",")>
								<#list ids as id>
									<#if ids?has_content && id?number == executor.id >
									<option value="${executor.id}" selected >[${executor.userNo}] ${executor.name} ${executor.role}</option>
									<#assign found = true>
									</#if>
								</#list>
								<#if found = false>
								<option value="${executor.id}" >[${executor.userNo}] ${executor.name} ${executor.role}</option>
								</#if>
							<#else>
								<#if selectdExecutors?number == executor.id >
									<option value="${executor.id}" selected >[${executor.userNo}] ${executor.name} ${executor.role}</option>
								<#else>
									<option value="${executor.id}" >[${executor.userNo}] ${executor.name} ${executor.role}</option>
								</#if>
							</#if>
						<#else>
						<option value="${executor.id}" >[${executor.userNo}] ${executor.name} ${executor.role}</option>
						</#if>
					</#list>
					</select>
					</#if>
					<input type="hidden" id="collaborateIds" name="collaborateIds" class="form-control" <#if mode?? && mode=="編輯">value="${wgTask.collaborateIds!""}"</#if> />
				</td>
			</tr>
			<tr>
				<td><@spring.message "task.label.note"/></td>
				<td>
					<@spring.formTextarea path="wgTask.note" attributes='class="form-control" row="4" ' />
				</td>
			</tr>
		</table>
	</form>
</div>

<script>

$(function(){
	mlog.form.validate({
		selector : "#listForm",
		onfocusout : false,
		onkeyup : false,
		onclick : false,
		success : function(){
			mlog.utils.scrollTop();
		}
	});

});

</script>
<style>

textarea.form-control {
	resize: none;
}

</style>
</div>