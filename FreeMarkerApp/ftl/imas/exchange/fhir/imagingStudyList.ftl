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
					<div class="module-blk active" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/imagingstudy">
						<i class="fa fa-image fa-lg"></i>
						<span>檢測影像</span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/diagnosticreport">
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
								<!--<button onclick="searchView()"><i class="fa fa-search"></i> 個案搜尋</button>-->
								<button class="func-btn" onclick="addView()"><i class="fa fa-plus"></i> 新增ImagingStudy</button>					
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="8%">流水號</th>
						      	<!--<th width="">ImagingStudyStatus</th>-->					      	
						        <th width="25%">醫學影像ID</th><!--醫療影像ID-->
						      	<th width="10%">個案參照</th>
						      	<!--<th width="">ImagingStudy</th>開單資訊-->    
						        <th width="17%">檢驗單號</th><!--遠距檢驗單號-->
						        <!--<th width="">numberOfInstance</th>檢驗數量-->
						        <!--<th witdh="">imagestudy.series</th>檢驗序列識別內容-->
						        <th width="10%">獲取方式</th>
						        <th width="10%">檢測部位</th>
						        <th width="20%">SOP類別</th>
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
var api = "${base}/division/api/fhir/imagingstudy/list";
var base = "${base}";
var lang_ref = "${__lang}";
var field = "${__field}";
var ptId = "${patientId!""}";

var columnObj = [
    { data: "id"},
    { data: "studyId",
        render: function ( data, type, row, meta ) {
            var studyId = "---";
            if(row.SIUID_Value) studyId = row.SIUID_Value;
            return studyId;
        }
    },
    { data: "patientId",
        render: function(data, type, row, meta){
        var patientId = "---";
        if(row.subject?.reference?.myStringValue) {
            patientId = row.subject.reference.myStringValue;
            }
        return patientId;
        }
    },
    { data: "accessionNo",
        render: function(data, type, row, meta){
        var accessionNo = "---";
        if(row.ACSN_Value) accessionNo = row.ACSN_Value;
        return accessionNo;
        }
    },
    { data: "modality",
        render: function(data, type, row, meta){
        var modality = "---";
        if(row.imagingStudySeriesComponentViews[0]?.modalityCode){
            modality = row.imagingStudySeriesComponentViews[0].modalityCode;
            }
        return modality;
        }
    },
    { data: "bodySite",
        render: function( data, type, row, meta){
        var bodySite = "---";
        if(row.imagingStudySeriesComponentViews[0]?.bodySiteCode){
            bodySite = row.imagingStudySeriesComponentViews[0].bodySiteCode;
            }
        return bodySite
        }
    },
    { data: "sopClass",
        render: function( data, type, row, meta){
        var sopClass = "---";
        if(row.imagingStudySeriesComponentViews[0]?.imagingStudySeriesInstanceComponentViews[0]?.sopClassCode){
            sopClass = row.imagingStudySeriesComponentViews[0].imagingStudySeriesInstanceComponentViews[0].sopClassCode;
            }
        return sopClass;
        }
    }
];

/*定義排序*/
var columnDefs = [
	{targets: [], orderable: false}
];

$(document).ready(function(){
	showImagingStudyList();
});

//顯示所有ImagingStudy列表
function showImagingStudyList(){
    
	var queryData = {"patientId": ${patientId!""}, "page_num": 1, "limit": $(".displaynum").val()};
	initFhirImagingStudySortTable('.main-table', limit, api, queryData, columnObj, columnDefs, page_info);
}

function addView(){
	window.location = "${base}/${__lang}/division/web/exchange/fhir/patient/${patientId!""}/imagingstudy/create";
}

function searchView(){
	window.location = "${base}/${__lang}/division/web/exchange/fhir/imagingstudy/search";
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

td{
	word-break: break-all;
}
</style>	

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />