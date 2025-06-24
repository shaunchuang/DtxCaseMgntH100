<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "admin.menu.otherMgnt"/></div>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="/ftl/imas/admin/other/phraseMgnt">
						<i class="fa fa-quote-left fa-lg"></i>
						<span><@spring.message "admin.menu.phraseMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/scaleMgnt">
						<i class="fa fa-table-list fa-lg"></i>
						<span><@spring.message "admin.menu.scaleMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/deviceMgnt">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "admin.menu.deviceMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/lessonMgnt">
						<i class="fa fa-upload fa-lg"></i>
						<span><@spring.message "admin.menu.lessonMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/profitMgnt">
						<i class="fa fa-coins fa-lg"></i>
						<span><@spring.message "admin.menu.profitMgnt"/></span>
					</div>
					<div class="module-blk active" data-src="/ftl/imas/admin/other/medicalMgnt">
						<i class="fa fa-pills fa-lg"></i>
						<span><@spring.message "admin.menu.medicalMgnt"/></span>
					</div>										
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	<div class="input-group search-group">																		
						<span class="input-group-addon"><@spring.message "admin.label.search"/></span>						
						<input type="search" class="form-control param" aria-describedby="basic-addon1" placeholder="<@spring.message "medical.list.placeholder.search"/>">	

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
								<button class="func-btn" onclick="addView()"><i class="fa fa-plus"></i> <@spring.message "admin.button.add"/></button>
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="5%"><@spring.message "medical.list.column.id"/></th>
						      	<th width="12%"><@spring.message "medical.list.column.quickcode"/></th>
						      	<th width="15%"><@spring.message "medical.list.column.nhicode"/></th>
						      	<th width="35%"><@spring.message "medical.list.column.resource"/></th>
						      	<th width="21%"><@spring.message "medical.list.column.createTime"/></th>
						      	<th width="12%"><@spring.message "medical.list.column.funcItem"/></th>
						      </tr>
						    </thead>
							<tbody id="list_cnt">
	
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
var api = "${base}/division/api/qryMedicalResourceList";

var columnObj = [
    { data: "idx", className: "idx"},
    { data: "quickNo", className: "quickNo" },
    { data: "nhiNo", className: "nhiNo" },
    { data: "name", className: "name" },            
    { data: "createTime", className: "createTime" },
    { data: null,
    	render: function ( data, type, row, meta ) {
    		return '<button class="func-btn mg-right-5" onclick="viewResourceDetail(\'' + row.id + '\')"><i class="fa fa-edit"></i> <@spring.message "admin.button.edit"/></button>';
    	}
    }
];

/*定義排序*/
var columnDefs = [
	{targets: [5], orderable: false}
];

$(document).ready(function(){
	showMedicalList();
	
});

//顯示耗材管理之列表
function showMedicalList(){
	var queryData = {"userId": ${currentUser.id!""}, "param": $(".param").val(), "page_num": 1, "limit": limit};
	initAjaxDataSortTable('.main-table', limit, api, queryData, columnObj, columnDefs, page_info);
}

//前往耗材編輯頁面
function viewResourceDetail(targetId){
	window.location = "${base}/${__lang}/division/web/admin/other/medicalMgnt/detail/" + targetId;
}

//前往新增耗材頁面
function addView(){
	window.location = "${base}/${__lang}/division/web/admin/other/medicalMgnt/new";
}
	
</script>

<#--<#include "/skins/imas/casemgnt/socket.ftl" />-->
<#include "/imas/widget/widget.ftl" />