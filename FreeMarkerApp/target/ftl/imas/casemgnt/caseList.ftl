<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "caseList.label.title"/></div>
					<!--<span class="patient-hint"></span>-->
				</div>           
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
					<div class="input-group search-group">																		
						<span class="input-group-addon">病歷號</span>
						<input type="search" class="form-control charno" aria-describedby="basic-addon1">
						<span class="input-group-addon">身份證</span>
						<input type="search" class="form-control idno" aria-describedby="basic-addon1">
						<span class="input-group-addon">姓名</span>
						<input type="search" class="form-control name" aria-describedby="basic-addon1">
						<span class="input-group-addon">負責人員</span>
						<select class="form-control carer" aria-describedby="basic-addon1" >
							<option value=""> 請選擇 </option>
						</select>
						<span class="input-group-addon">狀態</span>
						<select class="form-control status" aria-describedby="basic-addon1" >
							<option value=""> 請選擇 </option>
							<option value="N30"> 新個案 </option>
							<option value="N"> 治療中 </option>						    
						    <option value="Y"> 已結案 </option>
						</select>
						<input type="button" class="form-control clear-btn" value="清除" />
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
							<div class="order-temp pull-right">

							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="2%">細</th>
						      	<th width="11%"><@spring.message "caseList.column.ptno"/></th>					      	
						      	<th width="8%"><@spring.message "caseList.column.name"/></th>    
						        <th width="11%"><@spring.message "caseList.column.idno"/></th>
						        <th width="5%"><@spring.message "caseList.column.gender"/></th>
						        <th width="5%"><@spring.message "caseList.column.age"/></th>
						        <th width="20%">主要診斷</th>						        
						        <th width="13%">最新就診日期</th>
						        <th width="15%">負責人員</th>
						        <th width="10%">治療狀態</th>
						        <!--<th width="5%"><@spring.message "caseList.column.funcItem"/></th>-->
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
//var api = "${base}/division/api/qryPatientList";
var api = "/Patient/api/qryPatientList";
var base = "${base}";

/*定義欄位*/
var columnObj = [
    {
        className:      'details-control',
        orderable:      false,
        defaultContent: '',
        data:           "keyno",
            render: function ( data, type, row, meta ) {
          	  	return "<span class='hidden'>" + row.keyno + "</span>";
            }                
    },
    { data: "charno", className: "charno" },
    { data: "name", className: "name" },            
    { data: "idno", className: "idno" },
    { data: "gender",
    	render: function ( data, type, row, meta ) {
    		var gender = "<@spring.message "caseList.label.unknown"/>";
    		if(row.gender != "") gender = row.gender == 'M' ? '<@spring.message "caseList.label.male"/>' : '<@spring.message "caseList.label.female"/>';

    		return gender;
    	}
    },
    { data: "age" },
    { data: "diagnosis" },   
    { data: "newVisitDate", className: "newVisitDate" },
    { data: "carer" },
    { data: "status",
	    render: function ( data, type, row, meta ) {
    		return '<span class="status-t">治療中</span>';
    	} 
	}
    /*,
    { data: null,
    	render: function ( data, type, row, meta ) {
    		var viewRef = row.charNo === "" ? row.idNo : row.charNo;
    		//return '<button onclick="viewCase(\'' + row.keyNo + '\')"><i class="fa fa-edit"></i> <@spring.message "caseList.button.edit"/></button>';
    		//return "<span class='func-icon' onclick='imgZipExport(\"" + row.keyNo + "\")'><i class='fa fa-file-zipper fa-lg' title='<@spring.message "caseList.button.imgExport"/>'></i></span> ";
    		//return '<button class="func-btn mg-right-5" onclick="imgZipExport(\'' + row.keyNo + '\')"><i class="fa fa-file-zipper"></i> <@spring.message "caseList.button.imgExport"/></button>';   		
    		return '';
    	}
    }*/
];

/*定義排序*/
var columnDefs = [
	{targets: [0,1,6,7,8,9], orderable: false}
];

$(document).ready(function(){
	showPatientList();
});

//顯示所有個案列表
function showPatientList(){
	var queryData = {"userId": cUserId, "page_num": 1, "limit": limit};
	
	initPtSortTableV2('.main-table', limit, api, queryData, columnObj, columnDefs, page_info);
	
}

//前往個案總覽頁面
function viewCase(targetFormId){
	window.location = "/ftl/imas/patient/caseForm/overview?patientId=" + targetFormId;
}

//圖檔匯出功能
function imgZipExport(formId){
	window.open("${base}/division/api/downloadImageZip?formKeyNo=" + formId + "&zipName=IMGEXPORT");
}

</script>

<style>

tr.sub:hover{
	cursor: default !important;
	background: #ffe6b3 !important;
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

.status-n, .status-t, .status-c{
	font-weight: 600;
	padding: 0.5rem;
	color: #fff;
	border-radius : 5px;
	text-shadow: #737373 0.05em 0.05em 0.05em;
}

.status-n{
	background: #26a6c0;
}

.status-t{
	background: #29d677;
}

.status-c{
	background: #ff99a8;
}

td.details-control:before,
tr.shown td.details-control:before{
	font-family: 'FontAwesome';
	font-size: 20px !important;
	cursor: pointer;
}

td.details-control:before {
	/*background: url('${base}/images/woundInfo/details_open.png') no-repeat center center;*/	
	content:"\f055";	
	color: #31b131;
}

tr.shown td.details-control:before {
	/*background: url('${base}/images/woundInfo/details_close.png') no-repeat center center;*/
	content:"\f056";
	color: #d33333;
}

.detail, td:has(table){
	width: 100%;
	background: #fdf6c0;
}

.detail tr td:nth-child(odd){
	/*width: 1%;*/
	font-weight: 600;
	color: #2c68a0;
	/*white-space: nowrap;*/
}

.detail tr td{
	padding: 5px;
	text-align: left;
}

</style>	


<#include "/imas/widget/widget.ftl" />