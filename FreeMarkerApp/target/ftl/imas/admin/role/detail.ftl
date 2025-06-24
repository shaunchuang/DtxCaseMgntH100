<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "admin.menu.roleMgnt"/></div>
				</div>
				<div class="col-md-6 sub-func">
					<button class="func-btn mg-left-5" onclick="goPrevPage()"><i class="fa fa-circle-arrow-left"></i> <@spring.message "role.detail.button.back"/></button>
				</div>          
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<#assign isNew = isNewForm>
				<#if isNew>
				<form class="form" id="roleForm" action="${base}/admin/role/doCreateRole" method="POST">
				<#else>
				<form class="form" id="roleForm" action="${base}/admin/role/doEditRole" method="POST">
				</#if>
					<@spring.bind "role" />
					<#if !isNew>
					<@spring.formHiddenInput path="role.id" />
					<@spring.formHiddenInput path="role.createTime" />
					</#if>
					<table class="default-table">
						<#if !isNew>
						<tr>
							<td><@spring.message "role.detail.label.id"/></td>
							<td>
								<@spring.formInput path="role.id" attributes='class="form-control" disabled="disabled"' />
							</td>
						</tr>
						</#if>
						<tr>
							<td><@spring.message "role.detail.label.name"/></td>
							<td>
								<@spring.formInput path="role.name" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "role.detail.label.nickname"/></td>
							<td>
								<@spring.formInput path="role.alias" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "role.detail.label.status"/></td>
							<td class="td-flex">
								<@spring.formCheckbox path="role.enabled" attributes='checked="checked"' /> <span><@spring.message "role.detail.label.enabled"/></span>
							</td>
						</tr>
						<tr>
							<td><@spring.message "role.detail.label.backend.permission"/></td>
							<td class="td-flex">
								<#if usingbackend?exists && usingbackend=='on'>
								<input type=checkbox id="usingbackend" name="usingbackend" checked> <span><@spring.message "role.detail.label.permission"/></span>
								<#else>
								<input type=checkbox id="usingbackend" name="usingbackend"> <span><@spring.message "role.detail.label.permission"/></span>
								</#if>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="footer-btn-list">
									<#if !isNew>
									<button class="func-btn" onclick="delRole()"><i class="fa fa-trash-can"></i> <@spring.message "admin.button.delete"/></button>
									</#if>
									<#if isNew>
									<button type="submit" class="func-btn"><i class="fa fa-save"></i> <@spring.message "admin.button.add"/></button>
									<#else>
									<button type="submit" class="func-btn"><i class="fa fa-save"></i> <@spring.message "admin.button.save"/></button>
									</#if>
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
	mlog.form.validate({
		selector : "#roleForm",
		errorLabelContainer : "#error",
		wrapper: 'li',
		onfocusout : false,
		onkeyup : false,
		onclick : false,
		success : function(){
			mlog.utils.scrollTop();
		}
	});
});

function goPrevPage(){
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/role";
}

$(".goback").click(function(e){
	e.preventDefault();
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/role";
});
</script>

<style>
input[type="checkbox"], input[type="radio"]{
	zoom: 1.4;
}

input[type="checkbox"], input[type="checkbox"] + span,
input[type="radio"], input[type="radio"] + span{
	margin: 0;
	align-items: center;
}

input[type="checkbox"] + span, input[type="radio"] + span{
	padding-left: 10px;
}

.td-flex{
	display: flex;
}

</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />