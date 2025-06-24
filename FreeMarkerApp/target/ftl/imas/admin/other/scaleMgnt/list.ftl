<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "admin.menu.otherMgnt"/></div>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="/ftl/imas/admin/other/phraseMgnt">
						<i class="fa fa-quote-left fa-lg"></i>
						<span><@spring.message "admin.menu.phraseMgnt"/></span>
					</div>
					<div class="module-blk active" data-src="/ftl/imas/admin/other/scaleMgnt">
						<i class="fa fa-table-list fa-lg"></i>
						<span><@spring.message "admin.menu.scaleMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/deviceMgnt">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "admin.menu.deviceMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/lessonMgnt">
						<i class="fa fa-upload fa-lg"></i>
						<span><@spring.message "admin.menu.lessonMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/profitMgnt">
						<i class="fa fa-coins fa-lg"></i>
						<span><@spring.message "admin.menu.profitMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/medicalMgnt">
						<i class="fa fa-pills fa-lg"></i>
						<span><@spring.message "admin.menu.medicalMgnt"/></span>
					</div>										
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	<div class="input-group search-group">																		
						<span class="input-group-addon"><@spring.message "admin.label.search"/></span>						
						<input type="search" class="form-control param" aria-describedby="basic-addon1" placeholder="<@spring.message "phrase.list.placeholder.search"/>">	

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
								<button class="func-btn" onclick="addScale()"><i class="fa fa-plus"></i> <@spring.message "admin.button.add"/></button>
							</div>
							<div class="clearfix"></div>
						</div>	
						<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
							<thead>
						      <tr class="tablesorter-headerRow">
						      	<th width="5%">編號</th>
						      	<th width="20%">量表名稱</th>
						      	<th width="15%">量表類型</th>
						      	<th width="15%">評估者</th>
						      	<th width="35%">量表描述</th>
						      	<th width="10%">量表版本</th>
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
var api = "/Assessment/api/list";

var columnObj = [
    { data: "id", className: "id"},
    { data: "name", className: "name" },
    { data: "type", className: "type"},
	{ data: "evaluator" },
    { data: "desc" },
    { data: "version" }
];

/*定義排序*/
var columnDefs = [
	{targets: [0,1,2,3,4], orderable: false}
];

$(document).ready(function(){
	limit = $(this).val();
	showScalesList();
});

function showScalesList() {
    $.ajax({
        url: api,
        type: "GET", // 確保後端支援 GET
        success: function (res) {
			console.log('res: ', res);
            $('.total_record').html(res.data.length);
            $('.pagination').html('');
            renderDataTable(res.data);
        },
        error: function (err) {
            console.error("資料載入失敗", err);
        }
    });
}

function renderDataTable(data) {
    $('.main-table').DataTable({
        data: data,
        columns: columnObj,
        columnDefs: columnDefs,
        paging: true,
        pageLength: parseInt(limit),
        searching: true,
        ordering: true,
        destroy: true,
        language: page_info
    });
}




	//var queryData = {"userId": cUserId, "param": $(".param").val(), "page_num": 1, "limit": limit};
	//initAjaxDataSortWithoutBtnTable('.main-table', limit, api, queryData, columnObj, columnDefs, page_info);

//前往量表編輯頁面
function viewDetail(dataObj){	
	window.location = "/ftl/imas/division/web/admin/other/scaleMgnt/detail/" + dataObj.id;
}

//前往新增量表頁面
function addScale(){
	window.location = "/ftl/imas/admin/other/scaleMgnt/new";
}
	
</script>
<#--<#include "/skins/imas/casemgnt/socket.ftl" />-->
<#include "/imas/widget/widget.ftl" />