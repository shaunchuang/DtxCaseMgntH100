<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "exchange.hcrecord.label.title"/></div>
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	<div class="input-group search-group">																		
						<span class="input-group-addon"><@spring.message "exchange.hcrecord.label.year"/></span>						
						<select class="form-control qry-year" aria-describedby="basic-addon1">	
							<option value=""><@spring.message "exchange.hcrecord.option.year.hint"/></option>
							<#assign year = currentYear?number>
							<#assign yearMin = (year - 10)>
							<#list yearMin..year as index>
							<option value="${index}" <#if index == currentYear?number>selected</#if>>${index}</option>
							</#list>
						</select>
						<span class="input-group-addon btn" onclick="search()">
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
								<select class="form-control year" aria-describedby="basic-addon1">	
									<option value=""><@spring.message "exchange.hcrecord.option.year.hint"/></option>
									<#assign year = currentYear?number>
									<#assign yearMin = (year - 10)>
									<#list yearMin..year as index>
									<option value="${index}" <#if index == currentYear?number>selected</#if>>${index} <@spring.message "exchange.hcrecord.option.year"/></option>
									</#list>
								</select>
								<select class="form-control month" aria-describedby="basic-addon1">	
									<option value=""><@spring.message "exchange.hcrecord.option.month.hint"/></option>
									<#assign monthMin = 1>
									<#assign monthMax = 12>
									<#list monthMin..monthMax as index>									
									<option value="<#if index<10 >0</#if>${index}" <#if "0" + index == currentMonth || index == currentMonth?number>selected</#if>><#if index<10 >0</#if>${index} <@spring.message "exchange.hcrecord.option.month"/></option>					
									</#list>
								</select>
								<button class="func-btn" onclick="exportXmlFile()"><i class="fa fa-download"></i> <@spring.message "exchange.hcrecord.button.export"/></button>
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="20%"><@spring.message "exchange.hcrecord.column.generateDate"/></th>
						      	<th width="30%"><@spring.message "exchange.hcrecord.column.fileName"/></th>
						      	<th width="15%"><@spring.message "exchange.hcrecord.column.executor"/></th>
						      	<th width="35%"><@spring.message "exchange.hcrecord.column.funcItem"/></th>
						      </tr>
						    </thead>
							<tbody id="list_cnt">
								<tr>
									<td>2023-04-02 16:15</td>
									<td>LTC202304021615/TOTFA.zip</td>
									<td>王護理師</td>
									<td>
										<button class="func-btn mg-right-5" onclick="viewHcRecordList()"><i class="fa fa-notes-medical"></i> 檢視</button> <button class="func-btn mg-right-5" onclick="reloadFile()"><i class="fa fa-file-export"></i> 重新產生</button>
									</td>
								</tr>
								<tr>
									<td>2023-03-08 13:33</td>
									<td>LTC202303081333/TOTFA.zip</td>
									<td>王護理師</td>
									<td>
										<button class="func-btn mg-right-5" onclick="viewHcRecordList()"><i class="fa fa-notes-medical"></i> 檢視</button> <button class="func-btn mg-right-5" onclick="reloadFile()"><i class="fa fa-file-export"></i> 重新產生</button>
									</td>
								</tr>
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
var app = "${formId!""}";
var gCurPage = 1;
var sortClass = "";
var sortOrder = "";
var limit = $('.displaynum').val();
var gSerach = false;
var api = "${base}/division/api/qryHcRecordList";

var columnObj = [
    { data: "createDate"},
    { data: "fileName"},
    { data: "executor"},
    { data: null,
    	render: function ( data, type, row, meta ) {
    		return '<button class="func-btn mg-right-5" onclick="viewHcRecordList(\'" + row.keyno + '\',\" + row.keyno + "\')"><i class="fa fa-notes-medical"></i> 檢視</button> <button class="func-btn mg-right-5" onclick="reloadFile(\'" + row.keyno + '\',\" + row.keyno + "\')"><i class="fa fa-file-export"></i> 重新產生</button>';
    		//return '<button onclick="viewResourceDetail(\'' + row.id + '\')"><i class="fa fa-edit"></i> 編輯</button>';
    	}
    }
];

$(document).ready(function(){
	//showMonthLtcRecordList();
	
});

//顯示每月長照資訊管理之列表
function showMonthLtcRecordList(){
	var year = $(".year").val();
	var month = $(".month").val();
	var limit = $(".displaynum").val();
	var queryData = {"year": year, "month": month};
	newAjaxSearchTable('.main-table', limit, "${base}/division/api/qryMonthLtcRecordList?page_num=1&limit=10", queryData, columnObj, page_info);
}

//匯出每月健保申報檔
function exportXmlFile(){
	var year = $(".year").val();
	var month = $(".month").val();
	
	window.open("${base}/division/api/downloadMonthXmlFileZip?year=" + year + "&month=" + month);
}
	
</script>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />