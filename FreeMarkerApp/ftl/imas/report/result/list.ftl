<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "result.list.label.title"/></div>
				</div>				           
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	<div class="input-group search-group">																		
						<span class="input-group-addon"><@spring.message "result.list.label.ptno"/></span>						
						<input type="search" class="form-control ptNo" aria-describedby="basic-addon1" >
						<span class="input-group-addon"><@spring.message "result.list.label.idno"/></span>						
						<input type="search" class="form-control idNo" aria-describedby="basic-addon1" >
						<span class="input-group-addon"><@spring.message "result.list.label.name"/></span>						
						<input type="search" class="form-control ptName" aria-describedby="basic-addon1" >	
						<span class="input-group-addon"><@spring.message "result.list.label.dateRange"/></span>
						<input type="search" class="form-control startDatePicker" aria-describedby="basic-addon1" placeholder="<@spring.message "result.list.placeholder.startDate"/>">
						<span class="input-group-addon">~</span>
						<input type="search" class="form-control endDatePicker" aria-describedby="basic-addon1" placeholder="<@spring.message "result.list.placeholder.endDate"/>">
						<span class="input-group-addon btn search">
							<i class="fa fa-search"></i>
						</span>
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
								
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						        <th width="15%"><@spring.message "result.list.column.ptno"/></th>
						      	<th width="30%"><@spring.message "result.list.column.idno"/></th>
						      	<th width="20%"><@spring.message "result.list.column.name"/></th>					      	
						      	<th width="20%"><@spring.message "result.list.column.evalDate"/></th>
						        <th width="15%"><@spring.message "result.list.column.funcItem"/></th>
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
var api = "${base}/division/api/qryCaseResultList";

var columnObj = [
	<#if demo == "false">
    { data: "ptNo", className: "ptNo"},
    { data: "idNo", className: "idNo"},
    { data: "ptName", className: "ptName"},
    <#else>
    { data: "ptNo", className: "ptNo",
    	render: function ( data, type, row, meta ) {
    		return replaceTxt(row.ptNo);
    	}
    },
    { data: "idNo", className: "idNo",
    	render: function ( data, type, row, meta ) {
    		return replaceTxt(row.idNo);
    	}
    },
    { data: "ptName", className: "ptName",
    	render: function ( data, type, row, meta ) {
    		return replaceTxt(row.ptName);
    	}
    },
    </#if>
    { data: "evalDate", className: "evalDate"},
    { data: null,
    	render: function ( data, type, row, meta ) {
    		return '<button class="func-btn mg-right-5" onclick="exportReport(\'' + row.keyno + '\',\'' + row.evalDate + '\')"><i class="fa fa-print"></i> <@spring.message "result.list.button.print"/></button>';
    	}
    }
];

/*定義排序*/
var columnDefs = [
	{targets: [4], orderable: false}
];

$(document).ready(function(){

	startDatePicker('.startDatePicker, .endDatePicker');
	showResultList();
});

//顯示檢測報告列表
function showResultList(){
	var ptNo = $(".ptNo").val();
	var idNo = $(".idNo").val();
	var ptName = $(".ptName").val();
	var startDate = $(".startDatePicker").val();
	var endDate = $(".endDatePicker").val();
	var queryData = {"userId": ${currentUser.id!""}, "ptNo": ptNo, "idNo": idNo, "ptName": ptName, "startDate": startDate, "endDate": endDate, "page_num": 1, "limit": limit};
	initAjaxMultiDataSortTable('.main-table', limit, api, queryData, columnObj, columnDefs, page_info);
}

//顯示個案特定看診日之檢測報告
function exportReport(targetId, evalDate){
	window.open("${base}/${__lang}/division/web/report/result/print/" + targetId + "/evalDate/" + evalDate);
}
</script>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />