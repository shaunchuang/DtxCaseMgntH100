<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "exchange.ltcrecord.label.title"/></div>
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	<div class="input-group search-group">																		
						<span class="input-group-addon"><@spring.message "exchange.ltcrecord.label.countBy"/></span>						
						<select class="form-control year" aria-describedby="basic-addon1">	
							<option value=""><@spring.message "exchange.ltcrecord.option.year.hint"/></option>
							<#assign year = currentYear?number>
							<#assign yearMin = (year - 10)>
							<#list yearMin..year as index>
							<option value="${index}" <#if index == currentYear?number>selected</#if>>${index}</option>
							</#list>
						</select>
						<span class="input-group-addon">-</span>
						<select class="form-control month" aria-describedby="basic-addon1">	
							<option value=""><@spring.message "exchange.ltcrecord.option.month.hint"/></option>
							<#assign monthMin = 1>
							<#assign monthMax = 12>
							<#list monthMin..monthMax as index>									
							<option value="<#if index<10 >0</#if>${index}" <#if "0" + index == currentMonth || index == currentMonth?number>selected</#if>><#if index<10 >0</#if>${index}</option>					
							</#list>
						</select>
						<span class="input-group-addon btn search" >
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
								<button class="func-btn" onclick="exportDeclarationFile()"><i class="fa fa-download"></i> <@spring.message "exchange.ltcrecord.button.export"/></button>
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="10%"><@spring.message "exchange.ltcrecord.column.idno"/></th>
						      	<th width="10%"><@spring.message "exchange.ltcrecord.column.name"/></th>
						      	<th width="10%"><@spring.message "exchange.ltcrecord.column.serviceDate"/></th>
						      	<th width="10%"><@spring.message "exchange.ltcrecord.column.serviceCode"/></th>
						      	<th width="13%"><@spring.message "exchange.ltcrecord.column.serviceItem"/></th>
						      	<th width="11%"><@spring.message "exchange.ltcrecord.column.serviceCat"/></th>
						      	<th width="5%"><@spring.message "exchange.ltcrecord.column.quantity"/></th>
						      	<th width="9%"><@spring.message "exchange.ltcrecord.column.unitPrice"/></th>
						      	<th width="12%"><@spring.message "exchange.ltcrecord.column.staff"/></th>
						      	<th width="10%"><@spring.message "exchange.ltcrecord.column.period"/></th>
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
var api = "${base}/division/api/qryMonthLtcRecordList";

var columnObj = [
    { data: "idNo", className: "idNo"},
    { data: "name", className: "name"},
    { data: "visitDate", className: "visitDate"},
    { data: "code", className: "code"},
    { data: "codeName", className: "codeName" },
    { data: "cat", className: "cat" },
    { data: "serviceNum" },
    { data: "unitPrice" },            
    { data: "executors" },
    { data: "timeRange" }
];

/*定義排序*/
var columnDefs = [
	{targets: [6,7,8,9], orderable: false}
];

$(document).ready(function(){
	showMonthLtcRecordList();
	
});

//顯示每月長照資訊管理之列表
function showMonthLtcRecordList(){
	var year = $(".year").val();
	var month = $(".month").val();
	var queryData = {"userId": ${currentUser.id!""}, "year": year, "month": month, "page_num": 1, "limit": limit};
	newAjaxSearchTable('.main-table', limit, api, queryData, columnObj, columnDefs, page_info);
}

//匯出申報檔
function exportDeclarationFile(){
	var year = $(".year").val();
	var month = $(".month").val();
	
	window.open("${base}/division/api/downloadMonthLtcRecordInfo?year=" + year + "&month=" + month);
}
	
</script>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />