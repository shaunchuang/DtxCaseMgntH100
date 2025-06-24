<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name">FHIR個案總覽</div>
					<span class="patient-hint">${patientName!""}</span>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.back"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/caseView">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "casemgnt.menu.view"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/observation">
						<i class="fa fa-stethoscope fa-lg"></i>
						<span>生理量測</span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/imagingstudy">
						<i class="fa fa-image fa-lg"></i>
						<span>檢測影像</span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/diagnosticreport">
						<i class="fa fa-file-pdf fa-lg"></i>
						<span>診斷報告</span>
					</div>		
				</div>           
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	<div class="input-group search-group">																		
						<span class="input-group-addon">流水號(ID)</span>
						<input type="search" class="form-control id" aria-describedby="basic-addon1" placeholder="流水號">	
						<span class="input-group-addon">診斷類別</span>
						<input type="search" class="form-control category" aria-describedby="basic-addon1" placeholder="診斷類別">	
						<span class="input-group-addon">診斷碼</span>
						<input type="search" class="form-control code" aria-describedby="basic-addon1" placeholder="診斷碼">	
						<span class="input-group-addon">狀態</span>
						<input type="search" class="form-control status" aria-describedby="basic-addon1" placeholder="狀態">	
						<span class="input-group-addon">Patient ID</span>
						<input type="search" class="form-control patientId" aria-describedby="basic-addon1" placeholder="Patient ID">	
						<span class="input-group-addon">從時間</span>
						<input type="search" class="form-control startDate" aria-describedby="basic-addon1" placeholder="從時間">	
						<span class="input-group-addon">到時間</span>
						<input type="search" class="form-control endDate" aria-describedby="basic-addon1" placeholder="到時間">	
						<span class="input-group-addon btn search-btn" >
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
								<button class="func-btn mg-left-5" onclick="searchView()"><i class="fa fa-search"></i> 診斷報告搜尋</button>
								<button class="func-btn mg-left-5" onclick="addView()"><i class="fa fa-plus"></i> 新增診斷報告</button>					
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="10%">流水號</th>
						      	<th width="15%">個案參照</th>
						      	<th width="15%">報告類別碼</th>	
						      	<th width="20%">檢測項代碼</th>	
						      	<th width="15%">診斷日期</th>			      	
						      	<th width="25%">狀態</th>
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
var api = "${base}/division/api/fhir/diagnosticreport/list";
var base = "${base}";
var lang_ref = "${__lang}";
var field = "${__field}";
var ptId = "${patientId!""}";

var columnObj = [
    { data: "id" },
    { data: "patientId",
        render: function(data, type, row, meta){
        var patientId = "---";
        if(row.subject?.reference?.myStringValue) {
            patientId = row.subject.reference.myStringValue;
            }
        return patientId;
        }
    },
    { data: "categoryCode",
    	render: function ( data, type, row, meta ) {
    		var categoryCode = "---";
    		if(row.categoryCode) categoryCode = row.categoryCode;
    		return categoryCode;
    	}
    },
    { data: "drCode",
		render: function ( data, type, row, meta ) {
			var drCode = "---";
			if (row.diagnosticReportCode){
				drCode = row.diagnosticReportCode;
    		}
    		return drCode;
    	}
	},
	{ data: "dateTime",
		render: function ( data, type, row, meta ) {
			var dateTime = "---";
			if (row.effectiveDateTime) dateTime = row.effectiveDateTime;
			let dateString = dateTime.split(" ")[0];
    		return dateString;
    	}
	},	
	{ data: "status",
		render: function ( data, type, row, meta ) {
			var cnt = "---";
			if (row.status) cnt = "<span class='status-btn final'>" + row.status + "</span>";
    		return cnt;
    	}
	}	
];

/*定義排序*/
var columnDefs = [
	{targets: [], orderable: false}
];

$(document).ready(function(){
	showDiagnosticReportList();
});

//顯示所有個案列表
function showDiagnosticReportList(){
	var queryData = {"patientId": "${patientId!""}","page_num": 1, "limit": $(".displaynum").val()};
	initFhirDiagReportSortTable('.main-table', limit, api, queryData, columnObj, columnDefs, page_info);
}

function addView(){
	window.location = "${base}/${__lang}/division/web/exchange/fhir/patient/${patientId!""}/diagnosticreport/create";
}

function searchView(){
	window.location = "${base}/${__lang}/division/web/exchange/fhir/patient/search";
}

</script>

<style>
tbody tr:hover{
	background: #d9d9d9 !important;
	cursor: pointer;
}

.blink{
  	animation-duration: 1.2s;
  	animation-name: blink;
  	animation-iteration-count: infinite;
}

.alertCnt{
	/*color: #d1a215;
	font-weight: 600;*/
}

@keyframes blink {
    0%  { color: #d1a215;}
    25%  { color: #e8b417;}
    50% { color: #eabb2e; }
    75% { color: #ebbd34; }
    100% { color: #edc345; }
}

.status-btn{
	border-radius: 3px;
	padding: 4px 8px;
	background: #e6e6e6;
	color: #000;
	font-weight: 600;
	display: inline-block;
	cursor: pointer;
}

.status-btn.final{
	color: #004d00;
	background: #ccffcc;
}
</style>	

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />