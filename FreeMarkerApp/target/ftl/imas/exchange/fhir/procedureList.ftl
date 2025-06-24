<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "exchange.fhir.label.title"/></div>
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
							<option value="identifier" ><@spring.message "exchange.fhir.option.idno"/></option>
							<option value="name" ><@spring.message "exchange.fhir.option.name"/></option>
							<option value="orgnization" ><@spring.message "exchange.fhir.option.orgnization"/></option>
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
								<button onclick="addView()"><i class="fa fa-plus"></i> <@spring.message "exchange.fhir.button.addcase"/></button>					
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="15%"><@spring.message "exchange.fhir.column.id"/></th>					      	
						      	<th width="10%"><@spring.message "exchange.fhir.column.name"/></th>    
						        <th width="20%"><@spring.message "exchange.fhir.column.idno"/></th>
						        <th width="10%"><@spring.message "exchange.fhir.column.gender"/></th>
						        <th width="20%"><@spring.message "exchange.fhir.column.birth"/></th>
						        <th width="25%"><@spring.message "exchange.fhir.column.funcItem"/></th>
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
var gCurPage = 1;
var gSerach = false;

var columnObj = [
    { data: "id" },
    { data: "family",
    	render: function ( data, type, row, meta ) {
    		return row.family + row.given;
    	}
    },
    { data: "identifier" },
    { data: "gender",
    	render: function ( data, type, row, meta ) {
    		var gender = "<@spring.message "exchange.fhir.label.unknown"/>";
    		if(row.gender != "") gender = row.gender == 'male' ? '<@spring.message "exchange.fhir.label.male"/>' : '<@spring.message "exchange.fhir.label.female"/>';

    		return gender;
    	}
    },
    { data: "birthdate" },
    { data: null,
    	render: function ( data, type, row, meta ) {
    		var viewRef = row.charNo === "" ? row.idNo : row.charNo;
    		return '<button onclick="viewCase(\'' + row.id + '\')"><i class="fa fa-edit"></i> <@spring.message "exchange.fhir.button.edit"/></button> <button onclick="viewCaseHistory(\'' + row.id + '\')"><i class="fa fa-history"></i> <@spring.message "exchange.fhir.button.track"/></button>';
    	}
    }
];

$(document).ready(function(){
	showPatientList();
});
/*
$(".displaynum, .sortBy, .order").on("change", function(){
    cleanDataTables();
	var limit = $(".displaynum").val();
	gCurPage = 1;

	if($(this).attr("class") == "displaynum"){
		$(".displaynum").val($(this).val());
	}
	
	if ( gSerach ) {
	    var totalStr = "page_num=" + gCurPage + "&limit=" + limit + "&status=" + $(".status").val() + "&source=" + $(".source").val() + "&from=" +
	    			   $(".from").val() + "&ptNo=" + $(".keyNo").val() + "&date=" +
	    			   $(".datepick").val() + "&bodyPart=" + $(".bodyPart").val() +
	    			   "&sortBy=" + $(".sortBy").val() + "&order=" + $(".order").val();
	    generateCustomPager('.main-table', "${base}/division/api/qryPatientList?" + totalStr, "zhTW");
	}
	else{
	    generateCustomPager('.main-table', "${base}/division/api/qryPatientList?page_num=" + gCurPage + "&limit=" + $(".displaynum").val() + "&sortBy=" + $(".sortBy").val() + "&order=" + $(".order").val(), "zhTW"); 	
	}
});
*/

$(".itemId").on("change", function(){	
	$(".criteria").val("");
	
	var limit = $('.displaynum').val();
	var criteria = "";
	gSerach = false;
	gCurPage = 1;
	var totalStr = "page_num=1&limit=" + limit + "&itemId=" + $(".itemId").val() + "&criteria=" + criteria;
	//
	createAjaxTable('.main-table', $(".displaynum").val(), "${base}/division/api/qryPatientList?" + totalStr, columnObj, "zhTW");
	
});

//搜尋符合特定條件之個案
$(".criteria").on("input", function() { 
    var limit = $('.displaynum').val();
	var criteria = $(this).val();
	var totalStr = "page_num=1&limit=" + limit + "&itemId=" + $(".itemId").val() + "&criteria=" + criteria;
	gCurPage = 1;
	gSerach = true;

	createAjaxTable('.main-table', $(".displaynum").val(), "${base}/division/api/qryPatientList?" + totalStr, columnObj, page_info);
});

function search(){
	var queryData = "";
	var limit = $('.displaynum').val();
	var paramTxt = $(".paramTxt").val();
	gSerach = true;
	gCurPage = 1;
	queryData = {"page_num": gCurPage, "limit": limit};
	newAjaxSearchTable('.main-table', $(".displaynum").val(), "${base}/division/api/fhir/patient/list", queryData, columnObj, page_info);
}

function click_page(page) {
    cleanDataTables();
	gCurPage = page;
	var limit = $('.displaynum').val();
	var queryData = "";
	if ( gSerach ) {
		queryData = {"page_num": page, "limit": limit};
		newAjaxSearchTable('.main-table', $(".displaynum").val(), "${base}/division/api/fhir/patient/list", queryData, columnObj, page_info);
	}
	else{
		queryData = {"page_num": page, "limit": limit};
        newAjaxSearchTable('.main-table', $(".displaynum").val(), "${base}/division/api/fhir/patient/list", queryData, columnObj, page_info);
	}
}

//顯示所有個案列表
function showPatientList(){
	var queryData = {"page_num": 1, "limit": $(".displaynum").val()};
	newAjaxSearchTable('.main-table', $(".displaynum").val(), "${base}/division/api/fhir/patient/list", queryData, columnObj, page_info);
}

//前往個案總覽頁面
function viewCase(targetFormId){
	window.location = "${base}/${__lang}/division/web/patient/" + targetFormId + "/caseView";
}

function addView(){
	window.location = "${base}/${__lang}/division/web/exchange/fhir/patient/create";
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