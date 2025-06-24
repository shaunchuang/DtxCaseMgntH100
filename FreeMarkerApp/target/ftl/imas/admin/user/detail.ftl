<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<#assign isNew = isNewForm>
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><#if isNew><@spring.message "user.detail.label.add.title"/><#else><@spring.message "user.detail.label.edit.title"/></#if></div>
				</div>
				<div class="col-md-6 sub-func">
					<button class="func-btn mg-left-5" onclick="goPrevPage()"><i class="fa fa-circle-arrow-left"></i> <@spring.message "user.detail.button.back"/></button>
				</div>          
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">				
				<#if isNew>
				<form class="form" id="userForm" action="${base}/admin/user/doCreateUser" method="POST">
				<#else>
				<form class="form" id="userForm" action="${base}/admin/user/doEditUser" method="POST">
				</#if>
					<@spring.bind "user" />
					<#if !isNew>
					<@spring.formHiddenInput path="user.id" />
					<@spring.formHiddenInput path="user.employeeno" />
					<@spring.formHiddenInput path="user.createTime" /> 	
					<@spring.formHiddenInput path="user.userData.id" />
					<@spring.formHiddenInput path="user.userData.creator" />
					<@spring.formHiddenInput path="user.password" />
					<input type="hidden" id="old_email" name="old_email" value="${user.email!""}" >
					</#if>
					<table class="default-table">
						<#if !isNew>
						<tr>
							<td><@spring.message "user.detail.label.id"/></td>
							<td>
								<@spring.formInput path="user.id" attributes='class="form-control" disabled="disabled"' />
							</td>
							<td rowspan="3">
								<div class="img-container">
                            		<div class="upload-icon">
                            			<i class="fa fa-camera"></i>
                            		</div>
                            		<#if !roleName?exists || roleName == "SYSTEM" || roleName == "ADMIN">
                            		<div class="role-img role-unknown" /></div>
                            		<#else>
                            		<#if roleName == "IMAS_DOCTOR" || roleName == "IMAS_SPECIALIST">
                            		<div class="role-img role-doctor" /></div>
                            		<#elseif roleName == "IMAS_NURSE">
                            		<div class="role-img role-nurse" /></div>
                            		<#elseif roleName == "IMAS_CASEMGR">
                            		<div class="role-img role-manager" /></div>
                            		</#if>
                            		</#if>
                            	</div>
							</td>
						</tr>
						</#if>
						<tr>
							<td><@spring.message "user.detail.label.name"/></td>
							<td>
								<@spring.formInput path="user.name" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.gender"/></td>
							<td>
								<@spring.formSingleSelect path="user.userData.sex" options=userdataSex attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.institute"/></td>
							<td colspan="2">
								<@spring.formInput path="user.userData.institution" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.division"/></td>
							<td colspan="2">
								<select id="divisionNo" name="userData.divisionNo">
                                    <option value=""><@spring.message "user.detail.option.division.hint"/></option>
                                    <#if isNew>
                                    <#list userdataDivisionNo?keys as key>                              	
                                    <option value="${key}">${key} - ${userdataDivisionNo[key]}</option>
                                    </#list>
									<#else>
									<#list userdataDivisionNo?keys as key>
									<#if divisionNo?has_content && key == divisionNo>
									<option value="${key}" selected=selected>${key} - ${userdataDivisionNo[key]}</option>
									<#else>
									<option value="${key}">${key} - ${userdataDivisionNo[key]}</option>
									</#if>
									</#list>
									</#if>
                                </select>			
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.idno"/></td>
							<td colspan="2">
								<@spring.formInput path="user.idno" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.medicalPersonnelNo"/></td>
							<td colspan="2">
								<@spring.formInput path="user.userData.medicalPersonnelNo" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.phone"/></td>
							<td colspan="2">
								<@spring.formInput path="user.userData.telCell" 
								attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.email"/></td>
							<td colspan="2">
								<#if isNew>
								<@spring.formInput path="user.email" attributes='class="lower form-control" ' />
								<#else>
								<@spring.formInput path="user.email" attributes='class="lower form-control" ' />
								</#if>
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.userRoles"/></td>
							<td colspan="2">
								<#if isNew>
								<select id="roles_select" multiple="multiple" class="form-input">
									<#list roles as role>
										<#if role.selected?exists && role.selected>
											<option data-alias="${role.alias}" value="${role.id}" selected="selected">${role.name}</option>
										<#else>
											<option data-alias="${role.alias}" value="${role.id}" >${role.name}</option>
										</#if>
									</#list>
								</select>
								<#else>
								<select id="roles_select" multiple="multiple" class="form-input">
									<#list roles as role>
										<#assign has_selected = "" />
										<#list userRoles as selected_role>
											<#if role.id == selected_role.id >
												<#assign has_selected = 'selected="selected"' />
											</#if>
										</#list>
										<option data-alias="${role.alias}" value="${role.id}" ${has_selected}>${role.name}</option>
									</#list>
								</select>
								</#if>
								<input type="hidden" id="selectRoles" name="selectRoles" />
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.account"/></td>
							<td colspan="2">
								<#if isNew>
								<@spring.formInput path="user.employeeno" attributes='class="upper form-control" ' />
								<#else>
								<@spring.formInput path="user.employeeno" attributes='class="upper form-control" disabled="disabled"' />
								</#if>
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.new.password"/></td>
							<td colspan="2">
								<#if isNew>
								<@spring.formPasswordInput path="user.password" attributes='class="form-control" ' />
								<#else>
								<input type="password" class="form-control" name="newPassword" id="newPassword" placeholder="<@spring.message "user.detail.placeholder.password"/>"  />
								</#if>
							</td>
						</tr>
						<tr>
							<td><@spring.message "user.detail.label.confirm.password"/></td>
							<td colspan="2">
								<#if isNew>
								<input type="password" class="form-control" name="rePassword" id="rePassword" />
								<#else>
								<input type="password" class="form-control" name="rePassword" id="rePassword" placeholder="<@spring.message "user.detail.placeholder.password"/>" />
								</#if>
							</td>
						</tr>
						<#if isNew>
						<tr>
							<td colspan="3">
								<div class="warning-info"><@spring.message "user.detail.label.warningInfo"/></div>
							</td>
						</tr>
						</#if>						
						<tr>
							<td colspan="3">
								<div class="footer-btn-list">
									<#assign isNew = isNewForm>
									<#if !isNew>
									<button class="delUser func-btn" ><i class="fa fa-trash-can"></i> <@spring.message "admin.button.delete"/></button>
									</#if>
									<button class="submitData func-btn" ><i class="fa fa-save"></i> <@spring.message "admin.button.save"/></button>
									<button class="goback func-btn"><i class="fa fa-circle-xmark"></i> <@spring.message "admin.button.cancel"/></button>
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
	//初始化選中
	<#assign selectedRoles = "" />
	<#list userRoles as role>
		setSelected(${role.id});
		<#assign selectedRoles = selectedRoles + role.id + "," />
	</#list>
	//初始化選中hidden
	$("#selectRoles").val("${selectedRoles}");
	
	$("#roles_select").multiselect({
        placeholder: '<@spring.message "user.detail.placeholder.userRoles"/>',
		onOptionClick: function(element, option){
			var values = $("#selectRoles").val();
			var maxSelect = 2;
			var thisOpt = $(option);
			
			if($(element).val() != null){
				if( $(element).val().length > maxSelect ) {
		            if( thisOpt.is(':checked') ) {
		                var thisVals = $(element).val();
		
		                thisVals.splice(
		                    thisVals.indexOf( thisOpt.val() ), 1
		                );
		
		                $(element).val( thisVals );
		
		                thisOpt.prop( 'checked', false ).closest('li').toggleClass('selected');
		            }
		        }
		        else if( $(element).val().length == maxSelect ) {
		            $(element).next('.ms-options-wrap').find('li:not(.selected)').addClass('disabled')
		                .find('input[type="checkbox"]').attr( 'disabled', 'disabled' );
		        }
		        else {
		            $(element).next('.ms-options-wrap').find('li.disabled').removeClass('disabled')
		                .find('input[type="checkbox"]').removeAttr( 'disabled' );
		        }
			}
			
			if(thisOpt.prop('checked')){
				values += thisOpt.val() + ',';
			}
			else{
				values = values.replace(thisOpt.val() + ',', '');
			}
			$("#selectRoles").val(values);
		}
	});
   	
   	$("#divisionNo").selectize({
    	sortField: 'text'
    });

});

//設置選中
function setSelected(value){
	$("#roles_select option").each(function(){
		if($(this).attr("value") == value){
			$(this).attr("selected", "selected");
			return;
		}
	});
}

//儲存使用者資訊
$(".submitData").click(function(e){
	e.preventDefault();
	
	if (validateForm("userForm", "td.star", "input:not([type='checkbox'])")) {
        this.closest("form").submit(); // 可以在這裡提交表單
    }

});

function goPrevPage(){
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/user";
}

$(".goback").click(function(e){
	e.preventDefault();
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/user";
});
	
</script>

<style>
.lower{
	text-transform: lowercase;
}

.upper{
	text-transform: uppercase;
}

.ms-options-wrap button span{
	font-size: 16px;
}

/* role img */

.img-container{
	position: relative;
	display: inline-block;
	line-height: 25px;
}

.upload-icon{
	position: absolute;
    bottom: 0px;
    right: 0px;
    background-color: #ffffff;
    color: #595959;
    border: 0.2px solid #b3b3b3;
    padding: 2px;
    -webkit-border-radius: 30px;
    -moz-border-radius: 30px;
    border-radius: 30px;
    width: 30px;
    height: 30px;
    text-align: center;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 1px 1px 1px #a6a6a6;
}

.upload-icon i{
	margin-top: 4px;
}

.img-container, .role-unknown, .role-doctor, .role-nurse, .role-manager {
	width: 100px;
	height: 100px;
	margin: 10px;	
	background-size: cover !important;
}

.role-unknown, .role-doctor, .role-nurse, .role-manager {
	border: 1px solid #a6a6a6;
	border-radius : 50%;
	background : #d5edf3;
	margin: 5px;
}

.role-unknown{
	background: url('${base}/images/imas/role/unknown.png') no-repeat center center;
}

.role-doctor{
	background: url('${base}/images/imas/role/doctor.png') no-repeat center center;
}

.role-nurse{
	background: url('${base}/images/imas/role/nurse.png') no-repeat center center;
}

.role-manager{
	background: url('${base}/images/imas/role/manager.png') no-repeat center center;
}

/* role img */

</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />