<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "casemgnt.label.caseView.title"/></div>
					<span class="patient-hint">${patientName!""}</span>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="home">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.back"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/caseView">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "casemgnt.menu.view"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/inspection">
						<i class="fa fa-stethoscope fa-lg"></i>
						<span><@spring.message "casemgnt.menu.cure.history"/></span>
					</div>
					<div class="module-blk" data-src="">
						<i class="fa fa-chart-simple fa-lg"></i>
						<span><@spring.message "casemgnt.menu.state"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/hcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.hcRecord"/></span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/patient/${formId!""}/ltcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.ltcRecord"/></span>
					</div>
					<div class="module-blk" data-src="">
						<i class="fa fa-file-waveform fa-lg"></i>
						<span><@spring.message "casemgnt.menu.evaluation"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/careCourse">
						<i class="fa fa-clock-rotate-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careCourse"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/carePlan">
						<i class="fa fa-clipboard-list fa-lg"></i>
						<span><@spring.message "casemgnt.menu.carePlan"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/careTeam">
						<i class="fa fa-people-group fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careTeam"/></span>
					</div>
				</div>           
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	<div class="input-group search-group">																		
						<span class="input-group-addon"><@spring.message "casemgnt.label.search"/></span>						
						<input type="text" class="form-control param" aria-describedby="basic-addon1" placeholder="<@spring.message "ltcrecord.list.placeholder.search"/>">	
						<span class="input-group-addon"><@spring.message "ltcrecord.list.label.dateRange"/></span>
						<input type="text" class="form-control startDatePicker" aria-describedby="basic-addon1" placeholder="<@spring.message "ltcrecord.list.placeholder.startDate"/>">
						<span class="input-group-addon">~</span>
						<input type="text" class="form-control endDatePicker" aria-describedby="basic-addon1" placeholder="<@spring.message "ltcrecord.list.placeholder.endDate"/>">
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
								<button class="func-btn" onclick="addView()"><i class="fa fa-plus"></i> <@spring.message "casemgnt.button.add"/></button>
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="10%"><@spring.message "ltcrecord.list.column.category"/></th>
						      	<th width="25%"><@spring.message "ltcrecord.list.column.visitItem"/></th>
						      	<th width="15%"><@spring.message "ltcrecord.list.column.visitDate"/></th>					      	
						      	<th width="15%"><@spring.message "ltcrecord.list.column.period"/></th>
						      	<th width="20%"><@spring.message "ltcrecord.list.column.executor"/></th>
						        <th width="15%"><@spring.message "ltcrecord.list.column.funcItem"/></th>
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
var app = "${formId!""}";
var gCurPage = 1;
var sortClass = "";
var sortOrder = "";
var limit = $('.displaynum').val();
var gSerach = false;
var api = "${base}/division/api/qryLtcRecordList";

var columnObj = [
    { data: "cat", className: "cat",
    	render: function ( data, type, row, meta ) {
    		var catName = row.cat == 1 ? "<@spring.message "ltcrecord.list.label.subsidy"/>" : "<@spring.message "ltcrecord.list.label.selfPay"/>";
    		return catName;
    	}
	},
    { data: "item", className: "item" },
    { data: "visitDate", className: "visitDate" },
    { data: "timeRange", className: "timeRange" },
    { data: "executors" },
    { data: null,
    	render: function ( data, type, row, meta ) {
    		return '<button class="func-btn mg-right-5" onclick="viewLtcRecord(\'' + row.keyno + '\')"><i class="fa fa-edit"></i> <@spring.message "ltcrecord.list.button.edit"/></button>';
    	}
    }
];

/*定義排序*/
var columnDefs = [
	{targets: [4,5], orderable: false}
];

$(document).ready(function(){

	startDatePicker('.startDatePicker, .endDatePicker');
	showLtcRecordList();
});

//顯示隸屬於特定個案之長照紀錄列表
function showLtcRecordList(){
	var param = $(".param").val();
	var startDate = $(".startDatePicker").val();
	var endDate = $(".endDatePicker").val();
	var queryData = {"userId": cUserId, "app": app, "param": param, "startDate": startDate, "endDate": endDate, "page_num": 1, "limit": limit};
	initAjaxSearchTable('.main-table', limit, api, queryData, columnObj, columnDefs, page_info);
}

//新增個案長照紀錄
function addView(){
	window.location = "${base}/${__lang}/division/web/patient/${formId!""}/ltcRecord/new";
}

//前往編輯個案長照紀錄
function viewLtcRecord(targetId){
	window.location = "${base}/${__lang}/division/web/patient/${formId!""}/ltcRecord/detail/" + targetId;
}
</script>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />