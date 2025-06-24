<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name">DiagnosticReport搜尋</div>
				</div>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<table class="default-table hb-color highlight">					
					<tr>
						<td>搜尋條件：</td>
						<td>
							<div class="input-group search-group">																		
								<span class="input-group-addon">DiagnosticReport ID</span>
								<input type="text" class="form-control s-id" aria-describedby="basic-addon1">
								<span class="input-group-addon">DiagnosticReport Status</span>
								<input type="text" class="form-control s-status" aria-describedby="basic-addon1">
								<span class="input-group-addon">DiagnosticReport Patient ID</span>
								<input type="text" class="form-control s-patientId" aria-describedby="basic-addon1">
							</div>
						</td>
						</tr>
						<tr>
						<td colspan="3">
						    <div class="input-group search-group">
								<span class="input-group-addon">DiagnosticReport Category</span>
								<input type="text" class="form-control s-category" aria-describedby="basic-addon1">
								<span class="input-group-addon">DiagnosticReport Code</span>
							    <input type="text" class="form-control s-code" aria-describedby="basic-addon1">
								<span class="input-group-addon">DiagnosticReport Date</span>
							    <input type="text" class="form-control s-date" aria-describedby="basic-addon1">
								<span class="input-group-addon btn" onclick="search()">
									<i class="fa fa-search"></i>
								</span>
							 </div>
						</td>
					</tr>
				</table>
				<div class="main-content">
				  <div class="col-md-12 pd-h-5 justify-content-between">
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

$(document).ready(function(){

});

//變更搜尋參數條件
$(".param").on("change", function(){	
	$(".paramTxt").val("");
});


//多重條件搜尋
function search(){
	var postData = "";
	var id = $(".s-id").val();
	var identifier = $(".s-identifier").val();
	var name = $(".s-name").val();
	var orgnization = $(".s-orgnization").val();
	var postData = {"id": id, "identifier": identifier, "name": name, "orgnization": orgnization};
	if(postData != ""){
    	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, '${base}/division/api/fhir/diagnostic/search');
		if(result.exist){
			setValue(result);
			
			//$(".param").val("").trigger('change');
			
			appendOption(result.versionNum);
			swal("搜尋成功", result.msg, "success");
			
		}else{
			swal("搜尋失敗", result.msg, "error");
		}
	}else{
		swal("搜尋失敗", "請確認有無選擇搜尋參數或輸入搜尋內容\n確認完畢後重新搜尋!", "error");
	}
}
	
</script>

<style>
.lower{
	text-transform: lowercase;
}

.upper{
	text-transform: uppercase;
}

.hb-color td .input-group{
	margin-bottom: 0px !important;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />