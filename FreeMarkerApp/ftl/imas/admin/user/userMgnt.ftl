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
	                    	<a class="nav-tab" href="${base}/${__lang}/division/web/admin/userRoleMgnt/role" role="button" aria-expanded="false" ><@spring.message "admin.menu.roleMgnt"/></a>
                    	</li>
	                    <li>
	                    	<a class="nav-tab" href="${base}/${__lang}/division/web/admin/userRoleMgnt/user" role="button" aria-expanded="true" ><@spring.message "admin.menu.userMgnt"/></a>
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
						<input type="search" class="form-control param" aria-describedby="basic-addon1" placeholder="<@spring.message "user.list.placeholder.search"/>">	
		
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
								<button class="func-btn" onclick="addNewUser()"><i class="fa fa-plus"></i> <@spring.message "admin.button.add"/></button>
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table user-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="15%"><@spring.message "user.list.column.employeeno"/></th>
						      	<th width="12%"><@spring.message "user.list.column.name"/></th>
						      	<th width="15%"><@spring.message "user.list.column.category"/></th>					      	
						      	<th width="20%"><@spring.message "user.list.column.institute"/></th>
						      	<th width="18%"><@spring.message "user.list.column.division"/></th>
						        <th width="20%"><@spring.message "user.list.column.funcItem"/></th>
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
var api = "${base}/division/api/qryUserList";

var columnObj = [
    { data: "employeeNo", className: "employeeno" },
    { data: "name", className: "name" },
    { data: "role", className: "role" },
    { data: "institution", className: "institution" },
    { data: "divisionName", className: "divisionName" },
    { data: null,
    	render: function ( data, type, row, meta ) {
    		if(row.enableEdit){
    			var btnCnt = row.showEnabledBtn == true ? ' <button class="func-btn mg-right-5" onclick="enabledUser(\'' + row.id + '\')"><i class="fa fa-user-check"></i> <@spring.message "admin.button.enable"/></button>' : '';
    			return '<button class="func-btn mg-right-5" onclick="viewUserDetail(\'' + row.id + '\')"><i class="fa fa-edit"></i> <@spring.message "admin.button.edit"/></button>' + btnCnt;       		
    		}else{
    			return '<@spring.message "admin.label.no.permission"/>';
    		}
    	}
    }
];

/*定義排序*/
var columnDefs = [
	{targets: [5], orderable: false}
];

$(document).ready(function(){
	showUserList();
});

$(".nav-tab").click(function(){
	$(".func.collapse.in").collapse("hide");
});

//顯示所有使用者之列表
function showUserList(){
	var queryData = {"param": $(".param").val(), "page_num": 1, "limit": limit};
	initAjaxDataSortTable('.user-table', limit, api, queryData, columnObj, columnDefs, page_info);
}

//前往新增使用者頁面
function addNewUser(){
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/user/new";
}

//前往使用者編輯頁面
function viewUserDetail(targetId){
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/user/detail/" + targetId;
}

//啟用使用者
function enabledUser(userId){
	confirmCheck("啟用確認", "您確認要啟用此使用者權限嗎?", "warning", "btn-info", "確認", "取消", function(confirmed){
		if(confirmed){
			var enabledUserInfo = {"userId": userId, "enableAccount": true};
			var result = wg.evalForm.getJson({"data":JSON.stringify(enabledUserInfo)}, "${base}/division/api/userEnabled");
			if(result.success){
				swal('啟用成功', '已成功啟用使用者權限!', 'success');
			}else{
				swal('啟用失敗', '無法啟用使用者權限!', 'error');
			}
		}
	});
	 
}
</script>	

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />