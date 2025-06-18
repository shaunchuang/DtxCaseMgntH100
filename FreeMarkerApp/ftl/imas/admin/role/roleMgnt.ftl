<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "admin.menu.userRoleMgnt"/></div>
					<!--<span class="patient-hint"></span>-->
				</div>
				<div class="col-md-6 panel-heading">
	                <ul class="nav nav-tabs pull-right">
	                    <li>
	                    	<a class="nav-tab" href="${base}/${__lang}/division/web/admin/userRoleMgnt/role" role="button" aria-expanded="true" ><@spring.message "admin.menu.roleMgnt"/></a>
                    	</li>
	                    <li>
	                    	<a class="nav-tab" href="${base}/${__lang}/division/web/admin/userRoleMgnt/user" role="button" aria-expanded="false" ><@spring.message "admin.menu.userMgnt"/></a>
                    	</li>
	                </ul>
	            </div>          
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	<div class="input-group search-group">																		
						<span class="input-group-addon"><@spring.message "admin.label.search"/></span>						
						<input type="search" class="form-control param" aria-describedby="basic-addon1" placeholder="<@spring.message "role.list.placeholder.search"/>">	

					</div>
					<div class="table-blk">
						<div class="table-header">
							<div class="pull-left" >
		                    	<span>
								    <@spring.message "page.label.showpages"/>
								    <select class="displaynum" aria-describedby="basic-addon1" >
									    <option value="10"> 10 </option>
									    <option value="20"> 20 </option>
									    <option value="50"> 50 </option>
									</select>
									<@spring.message "page.label.records"/>,
								</span>
							    <span>
								    <@spring.message "page.label.recordFrom"/> <span class="startRecordNum"></span> ~ <span class="endRecordNum"></span> <@spring.message "page.label.record"/>, <@spring.message "page.label.total"/> <span class="total_record"></span> <@spring.message "page.label.records"/>
								</span>
		                    </div>
							<div class="order-temp form-inline pull-right">
								<#if currentUser.id == 2>
								<button class="func-btn" onclick="addNewRole()"><i class="fa fa-plus"></i> <@spring.message "admin.button.add"/></button>
								</#if>
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table role-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="10%"><@spring.message "role.list.column.id"/></th>
						      	<th width="25%"><@spring.message "role.list.column.name"/></th>
						      	<th width="25%"><@spring.message "role.list.column.nickname"/></th>					      	
						      	<th width="15%"><@spring.message "role.list.column.enabled"/></th>
						        <th width="25%"><@spring.message "role.list.column.funcItem"/></th>
						      </tr>
						    </thead>
							<tbody class="list_cnt">
	
					      	</tbody>
						</table>
	                    <div class="table-footer text-center">                    	
							<div class="dataTables_paginate paging_simple_numbers" >
							    <ul id="pagination" class="pagination">
								    <li class="paginate_button previous disabled" aria-controls="DataTables_Table_0" id="DataTables_Table_0_previous"><a href="#"><</a></li>
									<li class="paginate_button active" aria-controls="DataTables_Table_0"><a href="#">1</a></li>
									<li class="paginate_button next" aria-controls="DataTables_Table_0" id="DataTables_Table_0_next"><a href="#">></a></li>
								</ul>
							</div>
	                    </div>
					</div>
	            </div>
            </div>
		</div>
	</div>
</body>

<script>
var cUserId = ${currentUser.id!""};
var gCurPage = 1;
var sortClass = "";
var sortOrder = "";
var limit = $('.displaynum').val();
var gSerach = false;
var api = "${base}/division/api/qryRoleList";

var columnObj = [
    { data: "id", className: "id"},
    { data: "roleName", className: "name" },
    { data: "alias", className: "alias" },
    { data: "enabled",
    	render: function ( data, type, row, meta ) {
    		var isEnabled = row.enabled == 'Y' ? '<@spring.message "admin.label.yes"/>' : '<@spring.message "admin.label.no"/>';	
    		return isEnabled;
    	}
    },
    { data: null,
    	render: function ( data, type, row, meta ) {
    		if(row.enableEdit){
    			return '<button class="func-btn mg-right-5" onclick="viewRoleDetail(\'' + row.id + '\')"><i class="fa fa-edit"></i> <@spring.message "admin.button.edit"/></button>';       		
    		}else{
    			return '<@spring.message "admin.label.no.permission"/>';
    		}
    	}
    }
];

/*定義排序*/
var columnDefs = [
	{targets: [3,4], orderable: false}
];

$(document).ready(function(){
	showRoleList();
});

$(".nav-tab").click(function(){
	$(".func.collapse.in").collapse("hide");
});

//顯示所有角色之列表
function showRoleList(){
	var queryData = {"param": $(".param").val(), "page_num": 1, "limit": limit};
	initAjaxDataSortTable('.role-table', limit, api, queryData, columnObj, columnDefs, page_info);
}

//前往新增角色頁面
function addNewRole(){
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/role/new";
}

//前往角色編輯頁面
function viewRoleDetail(targetId){
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/role/detail/" + targetId;
}

</script>	

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />