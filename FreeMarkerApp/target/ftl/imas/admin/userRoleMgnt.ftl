<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<i class="fa fa-caret-right fa-lg"></i>
					<div class="item-name">角色帳戶管理</div>
					<span class="patient-hint"></span>
				</div>
				<div class="col-md-6 panel-heading">
	                <ul class="nav nav-tabs pull-right">
	                    <li>
	                    	<a class="nav-tab" href="#tabInfo_1" data-toggle="collapse" role="button" <#if !tabNum?exists || tabNum == 1>aria-expanded="true"<#else>aria-expanded="false"</#if> aria-controls="#tabInfo_1" >角色管理</a>
                    	</li>
	                    <li>
	                    	<a class="nav-tab" href="#tabInfo_2" data-toggle="collapse" role="button" <#if tabNum?exists && tabNum == 2>aria-expanded="true"<#else>aria-expanded="false"</#if> aria-controls="#tabInfo_2" >帳戶管理</a>
                    	</li>
	                </ul>
	            </div>          
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="func collapse<#if !tabNum?exists || tabNum == 1> in</#if>" id="tabInfo_1">
					<div class="col-md-12 pd-h-5 justify-content-between">
		            	<div class="input-group search-group">																		
							<span class="input-group-addon">關鍵字搜尋</span>						
							<input type="text" class="form-control" aria-describedby="basic-addon1" placeholder="輸入角色名稱、代碼等全部/部分字串搜尋相關角色">	
			
							<span class="input-group-addon btn" onclick="search()">
								<i class="fa fa-search"></i>
							</span>
						</div>
						<div class="table-blk">
							<div class="table-header">
								<div class="pull-left" >
			                    	<span>
									    每頁顯示
									    <select class="displaynum" aria-describedby="basic-addon1" >
										    <option value="10"> 10 </option>
										    <option value="20"> 20 </option>
										    <option value="50"> 50 </option>
										</select>
										筆,
									</span>
								    <span>
									    第 <span class="startRecordNum"></span> 筆 - 第 <span class="endRecordNum"></span> 筆, 總共 <span class="total_record"></span> 筆
									</span>
			                    </div>
								<div class="order-temp form-inline pull-right">
									<button onclick="addNewRole()"><i class="fa fa-plus"></i> 新增</button>
								</div>
								<div class="clearfix"></div>
							</div>	
							<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table role-table">
								<thead>
							      <tr class="tablesorter-headerRow">
							      	<th width="10%">編號</th>
							      	<th width="25%">角色名稱</th>
							      	<th width="25%">角色別名</th>					      	
							      	<th width="15%">是否可用後台</th>
							        <th width="25%">功能項</th>
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
	            <div class="func collapse<#if tabNum?exists && tabNum == 2> in</#if>" id="tabInfo_2">
					<div class="col-md-12 pd-h-5 justify-content-between">
		            	<div class="input-group search-group">																		
							<span class="input-group-addon">關鍵字搜尋</span>						
							<input type="text" class="form-control" aria-describedby="basic-addon1" placeholder="輸入姓名、科別、機構、角色等全部/部分字串搜尋相關成員">	
			
							<span class="input-group-addon btn" onclick="search()">
								<i class="fa fa-search"></i>
							</span>
						</div>
						<div class="table-blk">
							<div class="table-header">
								<div class="pull-left" >
			                    	<span>
									    每頁顯示
									    <select class="displaynum" aria-describedby="basic-addon1" >
										    <option value="10"> 10 </option>
										    <option value="20"> 20 </option>
										    <option value="50"> 50 </option>
										</select>
										筆,
									</span>
								    <span>
									    第 <span class="startRecordNum"></span> 筆 - 第 <span class="endRecordNum"></span> 筆, 總共 <span class="total_record"></span> 筆
									</span>
			                    </div>
								<div class="order-temp form-inline pull-right">
									<button onclick="addNewUser()"><i class="fa fa-plus"></i> 新增</button>
								</div>
								<div class="clearfix"></div>
							</div>	
							<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table user-table">
								<thead>
							      <tr class="tablesorter-headerRow">
							      	<th width="10%">工號(帳號)</th>
							      	<th width="15%">姓名</th>
							      	<th width="20%">角色類別</th>					      	
							      	<th width="20%">所屬機構</th>
							      	<th width="20%">負責科別</th>
							        <th width="15%">功能項</th>
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
	</div>
</body>

<script>

$(document).ready(function(){
	showRoleList();
	showUserList();
});

$(".nav-tab").click(function(){
	$(".func.collapse.in").collapse("hide");
});

//顯示所有角色之列表
function showRoleList(){
	var columnObj = [
        { data: "id"},
        { data: "roleName" },
        { data: "alias" },
        { data: "enabled",
        	render: function ( data, type, row, meta ) {
        		var isEnabled = row.enabled == 'Y' ? '是' : '否';	
        		return isEnabled;
        	}
        },
        { data: null,
        	render: function ( data, type, row, meta ) {
        		return '<button onclick="viewRoleDetail(\'' + row.id + '\')"><i class="fa fa-edit"></i> 編輯</button>';       		
        	}
        }
    ];
	createAjaxTable('.role-table', $(".displaynum").val(), "${base}/division/api/qryRoleList", columnObj, "zhTW");
}

//顯示所有使用者之列表
function showUserList(){
	var columnObj = [
        { data: "employeeNo" },
        { data: "name" },
        { data: "role" },
        { data: "institution" },
        { data: "divisionName" },
        { data: null,
        	render: function ( data, type, row, meta ) {
        		return '<button onclick="viewUserDetail(\'' + row.id + '\')"><i class="fa fa-edit"></i> 編輯</button>';       		
        	}
        }
    ];
	createAjaxTable('.user-table', $(".displaynum").val(), "${base}/division/api/qryUserList", columnObj, "zhTW");
}

//前往新增角色頁面
function addNewRole(){
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/role/new";
}

//前往新增使用者頁面
function addNewUser(){
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/user/new";
}

//前往角色編輯頁面
function viewRoleDetail(targetId){
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/role/detail/" + targetId;
}

//前往使用者編輯頁面
function viewUserDetail(targetId){
	window.location = "${base}/${__lang}/division/web/admin/userRoleMgnt/user/detail/" + targetId;
}
</script>	

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />