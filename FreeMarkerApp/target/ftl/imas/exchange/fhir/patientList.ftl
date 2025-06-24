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
						<span class="input-group-addon">病患ID</span>
						<input type="search" class="form-control id" aria-describedby="basic-addon1" placeholder="病患ID">
						<span class="input-group-addon">身份證字號</span>
						<input type="search" class="form-control idno" aria-describedby="basic-addon1" placeholder="身份證字號">	
						<span class="input-group-addon">姓名</span>
						<input type="search" class="form-control name" aria-describedby="basic-addon1" placeholder="病患姓名">
						<span class="input-group-addon">性別</span>
						<select class="form-control gender">
							<option value="" >請選擇</option>
							<option value="MALE" >男性</option>
							<option value="FEMALE" >女性</option>
							<option value="OTHER" >其他</option>
							<option value="UNKNOWN" >未知</option>
						</select>
						<span class="input-group-addon">生日</span>
						<input type="search" class="form-control birthDate" aria-describedby="basic-addon1" placeholder="生日">
						<span class="input-group-addon">組織機構</span>
						<input type="search" class="form-control orgnization" aria-describedby="basic-addon1" placeholder="組織機構">
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
								<button class="func-btn mg-left-5" onclick="searchView()"><i class="fa fa-search"></i> 個案搜尋</button>
								<button class="func-btn mg-left-5" onclick="addView()"><i class="fa fa-plus"></i> <@spring.message "exchange.fhir.button.addcase"/></button>					
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="10%"><@spring.message "exchange.fhir.column.id"/></th>					      	
						      	<th width="17%"><@spring.message "exchange.fhir.column.name"/></th>
						        <th width="12%"><@spring.message "exchange.fhir.column.idno"/></th>
						        <th width="7%"><@spring.message "exchange.fhir.column.gender"/></th>
						        <th width="11%"><@spring.message "exchange.fhir.column.birth"/></th>
						        <th width="11%">聯絡手機</th>
						        <th width="20%">使用信箱</th>
						        <th width="12%"><@spring.message "exchange.fhir.column.funcItem"/></th>
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
var api = "${base}/division/api/fhir/patient/list";
var base = "${base}";
var lang_ref = "${__lang}";
var field = "${__field}";

var columnObj = [
    { data: "id" },
	{ data: "humanNameView",
		render: function ( data, type, row, meta ) {
			var name = "---";
			if (row.humanNameView && row.humanNameView.enNameFamily) name = row.humanNameView.enNameFamily;
			if (row.humanNameView && row.humanNameView.enNameGiven) name += row.humanNameView.enNameGiven;
    		return name;
    	}
	},
    { data: "idno",
		render: function ( data, type, row, meta ) {
			var idno = "---";
			if (row.idno) idno = row.idno;
    		return idno;
    	}
	},
    { data: "gender",
    	render: function ( data, type, row, meta ) {
    		var gender = "<@spring.message "exchange.fhir.label.unknown"/>";
    		if(row.gender != "") gender = row.gender == 'MALE' ? '<@spring.message "exchange.fhir.label.male"/>' : '<@spring.message "exchange.fhir.label.female"/>';

    		return gender;
    	}
    },
    { data: "birthday",
		render: function ( data, type, row, meta ) {
			var birth = "---";
			if (row.birthday){
				var dateTime = new Date(row.birthday);
			 	birth = dateTime.toISOString().split('T')[0];
    		}
    		return birth;
    	}
	},
	{ data: "telecomView",
		render: function ( data, type, row, meta ) {
			var tele = "---";
			if (row.telecomView && row.telecomView.mobileViews) tele = row.telecomView.mobileViews[0].value;
    		return tele;
    	}
	},
	{ data: "telecomView",
		render: function ( data, type, row, meta ) {
			var tele = "---";
			if (row.telecomView && row.telecomView.emailViews) tele = row.telecomView.emailViews[0].value;
    		return tele;
    	}
	},
    { data: null,
    	render: function ( data, type, row, meta ) {
    		return '<button class="func-btn mg-right-5" onclick="viewCaseHistory(\'' + row.id + '\')"><i class="fa fa-history"></i> <@spring.message "exchange.fhir.button.track"/></button>';
    	}
    }
];

/*定義排序*/
var columnDefs = [
	{targets: [7], orderable: false}
];

$(document).ready(function(){
	startDatePicker('.birthDate');

	showPatientList();
});

//顯示所有個案列表
function showPatientList(){
	var queryData = {"page_num": 1, "limit": $(".displaynum").val()};
	initFhirPtSortTable('.main-table', limit, api, queryData, columnObj, columnDefs, page_info);
}

//前往個案總覽頁面
function viewCase(targetFormId){
	window.location = "${base}/${__lang}/division/web/exchange/fhir/patient/" + targetFormId + "/caseView";
}

function addView(){
	window.location = "${base}/${__lang}/division/web/exchange/fhir/patient/create";
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

.status-n, .status-t, .status-c{
	font-weight: 600;
	padding: 0.5rem;
	color: #fff;
	border-radius : 5px;
	text-shadow: #737373 0.05em 0.05em 0.05em;
}

.status-n{
	background: #3fc0d9;
}

.status-t{
	background: #29d677;
}

.status-c{
	background: #ff99a8;
}
</style>	

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />