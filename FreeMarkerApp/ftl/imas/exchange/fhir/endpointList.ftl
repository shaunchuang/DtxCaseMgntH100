<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name">Endpoint列表</div>
					<span class="patient-hint"></span>
				</div>           
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	<div class="input-group search-group">																		
						<span class="input-group-addon"><@spring.message "exchange.fhir.label.searchby"/></span>
						<select class="form-control param" aria-describedby="basic-addon1" >
							<option value="" ><@spring.message "exchange.fhir.option.param.hint"/></option>
							<option value="id" ><@spring.message "exchange.fhir.option.id"/></option>
							<option value="endpointUrl" >網址</option>
						</select>
						<span class="input-group-addon divide"></span>
						<input type="search" class="form-control paramTxt" aria-describedby="basic-addon1" placeholder="<@spring.message "exchange.fhir.placeholder.keyword"/>">	
		
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
								<!--<button onclick="searchView()"><i class="fa fa-search"></i> 個案搜尋</button>-->
								<button onclick="addView()"><i class="fa fa-plus"></i>新增Endpoint</button>					
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="15%">Endpoint流水號</th>
						      	<th width="15">狀態</th>
						      	<th width="15">連線類型</th>
						      	<th width="15%">Endpoint網址</th>   
						        <th width="40%"><@spring.message "exchange.fhir.column.funcItem"/></th>
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
var api = "${base}/division/api/fhir/endpoint/list";
var base = "${base}";
var lang_ref = "${__lang}";
var field = "${__field}";

var columnObj = [
    { data: "id" },
    { data: "status",
        render: function( data, type, row, meta){
            var status = "---";
            if (row.status) status = row.status;
            return status;
        }
    },
    { data: "connectionType",
        render: function( data, type, row, meta){
            var connectionType = "---";
            if (row.connectionTypeCode) connectionType = row.connectionTypeCode;
            return connectionType;
        }
    },
    { data: "endpointUrl",
        render: function( data, type, row, meta){
            var endpointUrl = "---";
            if (row.address) endpointUrl = row.address;
            return endpointUrl;
        }
    },
    { data: null,
        render: function( data, type, row, meta){
            return '<button onclick="viewCaseHistory(\'' + row.id + '\')"><i class="fa fa-history"></i> <@spring.message "exchange.fhir.button.track"/></button>';
        }
    }
];

/*定義排序*/
var columnDefs = [
	{targets: [4], orderable: false}
];

$(document).ready(function(){
	showEndpointList();
});


//顯示所有Endpoint列表
function showEndpointList(){
	var queryData = {"page_num": 1, "limit": $(".displaynum").val()};
	initFhirPtSortTable('.main-table', limit, api, queryData, columnObj, columnDefs, page_info);
}

//前往個案總覽頁面
function viewCase(targetFormId){
	window.location = "${base}/${__lang}/division/web/patient/" + targetFormId + "/caseView";
}

function addView(){
	window.location = "${base}/${__lang}/division/web/exchange/fhir/endpoint/create";
}

function searchView(){
	window.location = "${base}/${__lang}/division/web/exchange/fhir/patient/search";
}

</script>

<style>
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
</style>	

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />