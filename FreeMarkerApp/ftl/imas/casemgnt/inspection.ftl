<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "casemgnt.label.caseView.title"/></div>
					<span class="patient-hint">${patientName!""}</span>
				</div>
				<div class="col-md-6 sub-func">
					<div class="inner-addon right-addon">
					    <span><i class="glyphicon glyphicon-search" ></i></span>
					    <input type="search" id="search" class="upper form-control" placeholder="<@spring.message "inspect.placeholder.query"/>" />
					</div>
					<a class="case-info-btn" onclick="addHcRecord()"><@spring.message "inspect.button.add.hcrecord"/></a>
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
					<div class="module-blk active" data-src="${__lang}/division/web/patient/${formId!""}/inspection">
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
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/ltcRecord">
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
				<div class="inner_content_info_agileits" >
					<div class="container-fluid pd-0">
						<div class="left-block col-md-3 col-xs-12 pd-0">
							<div class="info-card">
								<table class="case-table">
									<tbody>
										<tr>
											<td rowspan="2" class="case-img gender-${gender!""}"></td>
											<td class="main-intro">${main_intro!""}</td>
										</tr>
										<tr>						
											<td class="sub-intro">${sub_intro!""}</td>
										</tr>
										<tr>
											<td colspan="2">
												<a class="case-info-btn" onclick="showPhysicalChart()"><@spring.message "inspect.button.physiological.info"/></a>
												<a class="case-info-btn" onclick="imgZipExport()"><@spring.message "inspect.button.img.export"/></a>
												<a class="case-info-btn" onclick="enterChatGroup()"><@spring.message "inspect.button.chat"/></a>
											</td>                                      
										</tr>								
									</tbody>
								</table>
							</div>
							<div class="item-list-card">
								<div class="hint"><@spring.message "inspect.label.query.item"/></div>
								<div class="criteria">
									<a class="btn" data-item="1"><@spring.message "inspect.label.ophthalmoscope"/></a>
									<a class="btn" data-item="2"><@spring.message "inspect.label.wound"/></a>									
									<a class="btn" data-item="3"><@spring.message "inspect.label.ultrasound"/></a>
									<a class="btn" data-item="4"><@spring.message "inspect.label.ecg"/></a>
									<a class="btn" data-item="5"><@spring.message "inspect.label.spirometer"/></a>
									<a class="btn" data-item="6"><@spring.message "inspect.label.otoscope"/></a>
									<a class="btn" data-item="7"><@spring.message "inspect.label.hearingDetector"/></a>
									<a class="btn" data-item="8"><@spring.message "inspect.label.abi"/></a>
									<a class="btn" data-item="9"><@spring.message "inspect.label.dermatoscope"/></a>
								</div>
								<div class="item-funclist show-toggle text-right">									
									<!--<a class="btn copy-record" title="<@spring.message "inspect.button.copy"/>">
										<i class="fa fa-copy" ></i> <@spring.message "inspect.button.copy"/>
									</a>-->
									<a class="func-btn mg-left-5 add-func" title="<@spring.message "inspect.button.add"/>">
										<i class="fa fa-plus-square" ></i> <@spring.message "inspect.button.add"/>
									</a>
									<a class="func-btn mg-left-5 edit-func" title="<@spring.message "inspect.button.edit"/>">
										<i class="fa fa-edit" ></i> <@spring.message "inspect.button.edit"/>
									</a>
									<a class="func-btn mg-left-5 del-func" title="<@spring.message "inspect.button.delete"/>">
										<i class="fa fa-copy" ></i> <@spring.message "inspect.button.delete"/>
									</a>
								</div>								
								<div class="item-list-blk">
									<div class="title">
										<@spring.message "inspect.label.testItems"/> <span class="pull-right" title="<@spring.message "inspect.button.reload"/>"><i class="fa fa-refresh fa-lg" ></i></span>
									</div>
									<div class="item-list hidden"></div>
									<div class="no-item">
										<@spring.message "inspect.label.no.record"/><br/><@spring.message "inspect.label.add.record"/>
									</div>
								</div>
							</div>
						</div>
						<div class="right-block col-md-9 col-xs-12 pd-l-10">
							<div class="no-cnt">
								<@spring.message "inspect.label.select.item.hint"/>
							</div>
							<div class="exist-cnt hidden">
								
	            			</div>    
						</div>
					</div>	
				</div>
			</div>
		</div>	
	</div>
</body>

<#include "/skins/imas/casemgnt/modal.ftl" />

<link href="${base}/style/imas/inspection.css" rel="stylesheet" type="text/css">
<script>

var cUserId = ${currentUser.id!""};
var base = "${base}";
var field = "${__field}";
var openImgItem = false;

$(document).ready(function(){
	wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getPhysiData?userFormKeyno=${formId!""}");
		
	showItemList();
	//	
	
	$(document).on('show.bs.modal', '.modal', function (event) {
		var idx = $('.modal:visible').length;
		var zIndex = 2001 + (10 * idx);     	
		$(this).css('z-index', zIndex);
		setTimeout(function() {
			$('.modal-backdrop').not(".modal-stack").css('z-index', zIndex - 1).addClass('modal-stack');
		}, 0);
	});
	$(document).on('hidden.bs.modal', '.modal', function (event) {
		var idx = $('.modal:visible').length;
		if(idx > 0){
			$('body').addClass("modal-open");
		}
	});
	//
});

//新增健保紀錄
function addHcRecord(){
	window.location = "${base}/${__lang}/division/web/patient/${formId!""}/hcRecord/new";
}

//搜尋個案資料
function searchCase(){
	var charno = $("#search").val();
	var queryData = {"charno":charno, name:"", idno:""};
	var result = wg.evalForm.getJson({"data":JSON.stringify(queryData)}, "${base}/division/api/qryUser");
	if(result.success && result.ids.length > 0){
		window.location = "${base}/${__lang}/division/web/patient/" + result.ids[0] + "/inspection" ;
	}
	else{
		confirmCheck("<@spring.message "inspect.label.case.query.fail.title"/>", "<@spring.message "inspect.label.case.query.fail.text"/>", "warning", "btn-info", "<@spring.message "inspect.button.confirm"/>", "<@spring.message "inspect.button.cancel"/>", function(confirmed){
			if(confirmed){
				var itemId = 240;
				if(checkID(charno)){itemId = 241};
				queryData = {"creatorId":${currentUser.id!""}, "formName": "基本資料V2", "evalDate": getEditTime(), "app": "", "items": [{"itemId": itemId, "ans": charno}]};		
				result = wg.evalForm.getJson({"data":JSON.stringify(queryData)}, "${base}/division/api/createUserForm?");				
			    if(result.success){
					window.location = "${base}/${__lang}/division/web/patient/" + result.id + "/inspection" ;
			    }
			}
		});
	}
}

$("#search").keydown(function(e){	
	if(e.keyCode == 13){
		e.preventDefault();
		
		if($(this).val() != ""){  	
		  	searchCase();
		}
		else{
			swal("<@spring.message "inspect.label.query.fail.title"/>", "<@spring.message "inspect.label.query.fail.text"/>", "error");
		}
	}		
});

//篩選要檢視的檢測項(如:僅看傷口圖、超音波圖)
$(".criteria > a").click(function(){
	var selectItemList = [];
	$(this).toggleClass("unselect");
	showItemList();	
});

//重整檢測項清單
$(".item-list-blk > .title > span").click(function(){
	showItemList();
});

//調整檢測項顯示部位內容於modal2
$(".main-item").change(function() {
	var itemNum = $(this).val();
   	$(".itemForm.bodypart").val("").trigger('change');
   	$(".itemForm.bodypart optgroup:not([data-item='0'])").hide();
   	$(".itemForm.bodypart optgroup[data-item='" + itemNum + "']").show();
});

//常見部位選擇_其他_時顯示空格自行輸入部位
$(".bodypart").change(function() {
   	if ($(this).val() == "<@spring.message "inspect.option.other"/>") {	
   		$(this).closest("tr").next("tr").removeClass("hidden");
   	}
   	else{
   		$(".other-bodypart").val("<@spring.message "inspect.option.other"/>").trigger("keyup").val("");
   	  	$(this).closest("tr").next("tr").addClass("hidden");
   	}
});

//新增檢測項目/患部紀錄
$(".add-func").on("click", function () {
	var todate = getTodate();
	$(".eval-date").val(todate);
	startDatePicker('.eval-date');
	$("#myModal").modal('show');  
});

//編輯檢測項目/患部紀錄
$(".edit-func").on("click", function () {
	var target = $(".item-list").find(".active");
	if(target.length > 0){
		var keyno = target.attr("data-keyno");
		var itemNumArr = getItemNumArray("default-table", "editItemForm");
		var postData = {"userFormKeyNo": keyno, "itemIds": itemNumArr};	
    	var data = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryAns");
	    if(data.success){
	    	$("#myModal2").find("button:first-child").attr("onClick", "saveItemRecord(\'" + keyno + "\')");
		    setFormValue("editItemForm", data.result);
	    	$("#myModal2").modal('show');
	    }		
	}
	else{
		swal("<@spring.message "inspect.editable.fail.title"/>", "<@spring.message "inspect.editable.fail.text"/>", "error");
	}   
});

//刪除檢測項目/患部紀錄
$(".del-func").on("click", function () {
	var target = $(".item-list").find(".active");
	if(target.length > 0){
		confirmCheck("<@spring.message "inspect.delete.confirm.title"/>", "<@spring.message "inspect.delete.confirm.text"/>", "warning", "btn-danger", "<@spring.message "inspect.button.confirm"/>", "<@spring.message "inspect.button.cancel"/>", function(confirmed){
			if(confirmed){
				var keyno = target.attr("data-keyno");
				var postData = {"userFormKeyNo": keyno};
				var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/removeUserForm?");
			    if(result.success){
					swal("<@spring.message "inspect.delete.success.title"/>", "<@spring.message "inspect.delete.success.text"/>", "success");
					target.trigger('click');
					showItemList();
			    }
			    else{
			    	swal("<@spring.message "inspect.delete.fail.title"/>", "<@spring.message "inspect.delete.fail.text"/>", "error");
			    }
			}
		});		
	}
	else{
		swal("<@spring.message "inspect.editable.fail.title"/>", "<@spring.message "inspect.editable.fail.text"/>", "error");
	}   
});

//清除訊息表格內容
$(".clean").click(function() {  
	var formNum = $(this).attr("data-form");
    $('.reg:eq(' + formNum + ')').trigger('reset');
    if(formNum == 0 || formNum == 1){
    	$(".main-item").val("").trigger('change');
	}
	else if(formNum == 2){
		$('.renew').click();
		startTooltip();
		//$(this).parents(".modal-content").find("select").val("").trigger('change');
		//$(".image-pickerWound, .thumbnails").empty();
	}
	else{
		$(".copy-date").val("");
		$(".selectAll").prop('checked', false);
		
	}
});

//點選任一檢測項紀錄
$(".item-list").on("click", ".item", function(e){
	var deviceNo = $(this).attr('data-item');
	var app = $(this).attr("data-keyno");
	var bodypart = $(this).attr("data-bodypart");
	var fullItemName = $(this).html();
    //  
    //
    var loadLeng = $('script[src="${base}/script/imas/lg-zoom.min.js"]').length;
	if(loadLeng <= 0){
    	$import("${base}/script/imas/lg-zoom.min.js");
	}
    //
	if($(this).hasClass('active')){
		$(this).removeClass('active');
		$(".right-block").find(".exist-cnt").html("").addClass("hidden").parent().find(".no-cnt").removeClass("hidden");				
	}
	else{
		//標記記錄變色
	    $(".item-list").find(".active").removeClass("active");
	    $(this).addClass('active');	    
		
	    //取得看診紀錄資料
		var postData = {"keyno": app, "deviceNo": deviceNo, "bodypart": bodypart};
		var data = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/getItemRecordList");  
	    //
	    if(data.totalSize == 0){    	
	    	$(".right-block").find(".exist-cnt").addClass("hidden").parent().find(".no-cnt").removeClass("hidden");
	    }
	    else{
	    	var collapseTemplate = "";
	    	var dateTemplate = createDateBtn(data.totalSize, data.records);
	        var topViewTemplate = createTopTemplate();
	        var midViewTemplate = createMidTemplate(deviceNo);
	        var btmViewTemplate = createBtmTemplate(deviceNo, data.newRecordNo);
	        
	        for(var i=0; i<data.totalSize; i++){
	        	collapseTemplate += createCollapseContent(deviceNo, data.records[i], i, data.totalSize-1);
	        }
	        
	        $(".right-block").find(".exist-cnt").html("").append(topViewTemplate + dateTemplate + midViewTemplate + btmViewTemplate +　collapseTemplate);
	    	
	    	$(".top-content").find(".item-name").html(fullItemName).attr('data-keyno', app);
	    	//
	    	activMultiFunc();
	    	//
	    	//$(".info-btn.customed").last().toggleClass("active");
			//$(".collapse-content").last().toggleClass("active");
			$(".info-btn.customed[data-formno='" + data.latestFormNo + "']").click();
			//
			var itemNumArr = getItemNumArray("collapse-content.active", "evalInput");
			var recordno = $(".collapse-content.active").attr('data-recordno');
			var postData = {"userFormKeyNo": recordno, "itemIds": itemNumArr};
			var postRecords = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryAns");
			setEvalFormValue("collapse-content", "evalInput" , postRecords.result);					  
			
		    createNewChart(deviceNo, app);
		    
		    $(".switchBtn").click(function(){
				var chartItem = $(this).attr("data-chart");
				var newChartItem = chartItem == 0 ? 1 : 0;

				this.value = chartItem == 0 ? "<@spring.message "inspect.button.switch.wound.prop"/>" : "<@spring.message "inspect.button.switch.wound.size"/>";
				
				if(newChart != null){
					var app = $(".data-save").val();
					if(newChart){
						newChart.clear();
						newChart.destroy();
					}
					
					$(".chart-container").find("canvas").remove();
					$(".chart-container").append("<canvas id='resultChart' width='800' height='400' ></canvas>");
					$(this).attr("data-chart", newChartItem);
					getWoundLineChart(app, "<@spring.message "chart.label.wound"/>", chartItem);
				}
				
			});
			
			//傷口表單專用
			if(deviceNo == 2){
				//潛行深洞與處置方式紀錄
				var subRecords = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getSubWoundRecordsByDate?app=" + recordno); 		
				//	    	
		    	getHoleList(subRecords.holeList);
			    getHandleList(subRecords.handleList);
		    }
			
	    	//顯示內容
	    	$(".right-block").find(".no-cnt").addClass("hidden").parent().find(".exist-cnt").removeClass("hidden");    		    		    		    	
	    	
	    }

    }
});

//顯示所有檢測項清單
function showItemList(){
	$(".item-list").html("");
	var selectedItemArr = [];
	var existKeyno = "";
	
	$(".criteria > a").each(function(){
		if(!$(this).hasClass("unselect")){
			selectedItemArr.push($(this).data("item"));
		}
	});
	
	var postData = {"keyno": "${formId!""}", "itemNumList": selectedItemArr};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/getDeviceWithBodypart");
	var data = result.data;

	if(data.length > 0){
		$(".no-item").addClass("hidden");
		$(".item-list").removeClass("hidden");
		
		if($(".top-content").length > 0){
			existKeyno = $(".top-content").find(".item-name").attr("data-keyno");
		}
				
		for(var i=0; i<data.length; i++){
			var activTag = data[i].keyno == existKeyno ? 'active' : "";
			$(".item-list").append(
				"<div class='item " + activTag + "' data-keyno='" + data[i].keyno + "' data-parentkeyno='" + data[i].parentKeyno + "' data-device='" + data[i].device + "' data-item='" + data[i].deviceNo + "' data-bodypart='" + data[i].bodypart + "'>" + data[i].fullItemName + "</div>"
			);
		}
		
		initMenu();
	}
	else{
		$(".no-item").removeClass("hidden");
		$(".item-list").addClass("hidden");
	}
}

//建立右側上版面內容(檢測紀錄)
function createTopTemplate(){

	return '<div class="top-content">																			' +
		   '	<div class="item-name"></div>																	' +
		   '		<div class="right-func pull-right">															' +		   
		   '			<a class="btn" onclick="exportImg()">													' +
		   '				<i class="fa fa-tags"></i> <@spring.message "inspect.button.orderChart.export"/>	' +
		   '			</a>																					' +
   		   '			<a class="btn" onclick="loadReport()">													' +
		   '				<i class="fa fa-file-export"></i> <@spring.message "inspect.button.report.export"/>	' +
		   '			</a>																					' +
		   '			<a class="btn" onclick="upload()">														' +
		   '				<i class="fa fa-file-arrow-up"></i> <@spring.message "inspect.button.file.upload"/>	' +
		   '			</a>																					' +
		   '            <input type="file" multiple="multiple" class="uploadFile" />							' +
		   '		</div>																						' +
		   '</div>																								' ;
}

function createDateBtn(totalSize, result){
	var size = parseInt(totalSize) - 1;
	var template = "";
	//for(var i= totalSize-1; i>=0; i--){
	for(var i= 0; i<totalSize; i++){
		template += "<a class='info-btn date-btn customed' data-formNo='" + result[i].id + "'>" + result[i].evalDate + "</a>"
	}
	return "<div class='date-list'>" + template + "</div><ul id='img-list' class='hidden'></ul>";
}

//建立右側中版面內容(檢測紀錄)
function createMidTemplate(deviceNo){
	var btnList = '';
	var hideInput = '<input type="text" class="hidden data-save" />';
	var itemNo = parseInt(deviceNo);
	if(itemNo == 2){
		btnList = '<input type="button" class="switchBtn" data-chart="1" value="<@spring.message "inspect.button.switch.wound.prop"/>">';
	}

	return '<div class="chart-container">' + hideInput + btnList +
		   '	<canvas id="resultChart" width="800" height="400"></canvas>	' +
		   '</div>																' ;
}

//建立右側下導覽列版面內容(檢測紀錄)
function createBtmTemplate(deviceNo, newRecordNo){
	var tabContent = "";
	var itemNo = parseInt(deviceNo);
	
	switch(itemNo){
		//眼底圖
		case 1:
			tabContent = '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_1" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="#tabInfo' + newRecordNo + '_1" ><@spring.message "inspect.menu.eyes.data"/></a> 	' +
						 '</li>																																																					' +
						 '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_2" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo' + newRecordNo + '_2" ><@spring.message "inspect.menu.record"/></a>		' +
						 '</li>																																																					' +
						 '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_3" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_3" ><@spring.message "inspect.menu.plans"/></a>		' +
						 '</li>																																																					' ;			
			break;
		//傷口圖
		case 2:
			tabContent = '<li>																																																						' +
						 '	<a class="tab-func collapsed" href="#tabInfo' + newRecordNo + '_1" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo' + newRecordNo + '_1" ><@spring.message "inspect.menu.wound.record"/></a> 	' +
						 '</li>																																																						' +
						 '<li>																																																						' +
						 '	<a class="tab-func collapsed" href="#tabInfo' + newRecordNo + '_2" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo' + newRecordNo + '_2" ><@spring.message "inspect.menu.education.info"/></a>	' +
						 '</li>																																																						' +
						 '<li>																																																						' +
						 '	<a class="tab-func collapsed" href="#tabInfo' + newRecordNo + '_3" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_3" ><@spring.message "inspect.menu.plans"/></a>			' +
						 '</li>																																																						' ;
			break;
		//超音波圖
		case 3:
			tabContent = '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_1" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="#tabInfo' + newRecordNo + '_1" ><@spring.message "inspect.menu.data"/></a> 		' +
						 '</li>																																																					' +
						 '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_2" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo' + newRecordNo + '_2" ><@spring.message "inspect.menu.liver"/></a> 		' +
						 '</li>																																																					' +
						 '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_3" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_3" ><@spring.message "inspect.menu.guts"/></a> 		' +
						 '</li>																																																					' +
						 '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_4" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_4" ><@spring.message "inspect.menu.kidney"/></a> 	' +
						 '</li>																																																					' +
						 '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_5" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_5" ><@spring.message "inspect.menu.pancreas"/></a> 	' +
						 '</li>																																																					' +
						 '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_6" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_6" ><@spring.message "inspect.menu.otherPart"/></a> 	' +
						 '</li>																																																					' +
						 '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_7" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_7" ><@spring.message "inspect.menu.plans"/></a>		' +
						 '</li>																																																					' ;
			break;
		//心電圖
		case 4:
			tabContent = '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_1" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="#tabInfo' + newRecordNo + '_1" ><@spring.message "inspect.menu.ecg.data"/></a>	' +
						 '</li>																																																					' +
						 '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_2" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo' + newRecordNo + '_2" ><@spring.message "inspect.menu.record"/></a>		' +
						 '</li>																																																					' +
						 '<li>																																																					' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_3" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_3" ><@spring.message "inspect.menu.plans"/></a>		' +
						 '</li>																																																					' ;
			break;
		//肺量圖
		case 5:
			tabContent = '<li>																																																						' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_1" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="#tabInfo' + newRecordNo + '_1" ><@spring.message "inspect.menu.spirometer.data"/></a>	' +
						 '</li>																																																						' +
						 '<li>																																																						' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_2" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo' + newRecordNo + '_2" ><@spring.message "inspect.menu.record"/></a>			' +
						 '</li>																																																						' +
						 '<li>																																																						' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_3" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_3" ><@spring.message "inspect.menu.plans"/></a>			' +
						 '</li>																																																						' ;
			break;
		//耳鏡圖
		case 6:
			tabContent = '<li>																																																				' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_1" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="#tabInfo' + newRecordNo + '_1" ><@spring.message "inspect.menu.record"/></a> 	' +
						 '</li>																																																				' +
						 '<li>																																																				' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_2" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo' + newRecordNo + '_2" ><@spring.message "inspect.menu.plans"/></a>	' +
						 '</li>																																																				' ;
			break;
		//聽力檢測圖
		case 7:
			tabContent = '<li>																																																							' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_1" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="#tabInfo' + newRecordNo + '_1" ><@spring.message "inspect.menu.hearingDetector.data"/></a>' +
						 '</li>																																																							' +
						 '<li>																																																							' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_2" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo' + newRecordNo + '_2" ><@spring.message "inspect.menu.record"/></a>				' +
						 '</li>																																																							' +
						 '<li>																																																							' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_3" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_3" ><@spring.message "inspect.menu.plans"/></a>				' +
						 '</li>																																																							' ;
			break;
		//ABI檢測圖
		case 8:
			tabContent = '<li>																																																						' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_1" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="#tabInfo' + newRecordNo + '_1" >檢測數據</a>												' +
						 '</li>																																																						' +
						 '<li>																																																						' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_2" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo' + newRecordNo + '_2" ><@spring.message "inspect.menu.record"/></a>			' +
						 '</li>																																																						' +
						 '<li>																																																						' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_3" data-toggle="collapse" role="button" aria-expanded="flase" aria-controls="#tabInfo' + newRecordNo + '_3" ><@spring.message "inspect.menu.plans"/></a>			' +
						 '</li>																																																						' ;
			break;
		//皮膚鏡圖
		case 9:
			tabContent = '<li>																																																				' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_1" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="#tabInfo' + newRecordNo + '_1" ><@spring.message "inspect.menu.record"/></a> 	' +
						 '</li>																																																				' +
						 '<li>																																																				' +
						 '	<a class="tab-func" href="#tabInfo' + newRecordNo + '_2" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo' + newRecordNo + '_2" ><@spring.message "inspect.menu.plans"/></a>	' +
						 '</li>																																																				' ;
			break;
	}	

	return '<div class="col-md-12 btm-content-header pd-h-0 equal">	' +
		   '	<div class="col-md-7 panel-heading pd-h-0">			' +
		   '		<ul class="nav nav-tabs">						' + tabContent +
		   '		</ul>											' +
		   '	</div>												' +
		   '	<div class="col-md-5 update-text pd-h-0"></div>		' +
		   '</div>													' +
		   '<div class="clearfix"></div>							' ;
		   	
}

//建立右側下表單顯示內容(檢測紀錄)
function createCollapseContent(deviceNo, record, idx, totalSize){
	var collapseContent = "";
	var itemNo = parseInt(deviceNo);
	var toggleIn = idx == totalSize ? "" : "";
	
	switch(itemNo){
		//眼底圖
		case 1:
			collapseContent = eyeContent(itemNo, record, toggleIn);
			break;
		//傷口圖
		case 2:
			collapseContent = woundContent(itemNo, record, toggleIn);
			break;
		//超音波圖
		case 3:
			collapseContent = ultraSoundContent(itemNo, record, toggleIn);
			break;
		//心電圖
		case 4:
			collapseContent = ecgContent(itemNo, record, toggleIn);
			break;
		//肺量圖
		case 5:
			collapseContent = lfmContent(itemNo, record, toggleIn);
			break;
		//耳鏡圖
		case 6:
			collapseContent = otoContent(itemNo, record, toggleIn);
			break;
		//聽力檢測圖
		case 7:
			collapseContent = audioMetersContent(itemNo, record, toggleIn);
			break;
		//ABI圖
		case 8:
			collapseContent = abiContent(itemNo, record, toggleIn);
			break;
		//皮膚圖
		case 9:
			collapseContent = dermatoContent(itemNo, record, toggleIn);
			break;
	}	

	return collapseContent;
		   	
}

//眼底圖表單樣板
function eyeContent(itemNo, record, toggleIn){
	return  '<div class="collapse-content" data-recordNo="' + record.id + '" data-evalDate="' + record.evalDate + '">                                                                       						' +
			'	<div class="func collapse ' + toggleIn + '" id="tabInfo' + record.id + '_1">																														' +			
			'		<div class="boxes">																																												' +
			'			<div class="analy-infos">																																									' +		
			'				<div id="eye-info-od" class="eye-info">																																					' +
			'					<table class="analy-table">																																							' +	
			'						<tr>																																											' +
			'							<td class="loc" rowspan="9"><@spring.message "inspect.label.right.eye"/></td>																								' +
			'							<td class="title" colspan="2"><@spring.message "result.print.label.ophthalmoscope.referral"/></td>																			' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td><@spring.message "result.print.label.ophthalmoscope.severity"/></td>																									' +
			'							<td><input type="text" class="evalInput" data-item="698" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td class="title" colspan="2"><@spring.message "result.print.label.ophthalmoscope.proabilityOfDignosis"/></td>																' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td>Proliferative</td>																																						' +
			'							<td><input type="text" class="evalInput" data-item="699" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td>Severe</td>																																								' +
			'							<td><input type="text" class="evalInput" data-item="700" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td>Moderate</td>																																							' +
			'							<td><input type="text" class="evalInput" data-item="701" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td>Mild</td>																																								' +
			'							<td><input type="text" class="evalInput" data-item="702" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td>Normal</td>																																								' +
			'							<td><input type="text" class="evalInput" data-item="703" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'					</table>																																											' +		
			'				</div>                                                                                                                                                          						' +
			'				<div id="eye-info-os" class="eye-info">																																					' +
			'					<table class="analy-table">																																							' +	
			'						<tr>																																											' +
			'							<td class="loc" rowspan="9"><@spring.message "inspect.label.left.eye"/></td>																								' +
			'							<td class="title" colspan="2"><@spring.message "result.print.label.ophthalmoscope.referral"/></td>																			' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td><@spring.message "result.print.label.ophthalmoscope.severity"/></td>																									' +
			'							<td><input type="text" class="evalInput" data-item="704" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td class="title" colspan="2"><@spring.message "result.print.label.ophthalmoscope.proabilityOfDignosis"/></td>																' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td><@spring.message "result.print.label.ophthalmoscope.proliferative"/></td>																								' +
			'							<td><input type="text" class="evalInput" data-item="705" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td><@spring.message "result.print.label.ophthalmoscope.severe"/></td>																										' +
			'							<td><input type="text" class="evalInput" data-item="706" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td><@spring.message "result.print.label.ophthalmoscope.moderate"/></td>																									' +
			'							<td><input type="text" class="evalInput" data-item="707" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td><@spring.message "result.print.label.ophthalmoscope.mild"/></td>																										' +
			'							<td><input type="text" class="evalInput" data-item="708" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'						<tr>																																											' +
			'							<td><@spring.message "result.print.label.ophthalmoscope.normal"/></td>																										' +
			'							<td><input type="text" class="evalInput" data-item="709" /> <@spring.message "result.print.label.percent.unit"/></td>														' +
			'						</tr>																																											' +
			'					</table>																																											' +
			'				</div>																																													' +
			'			</div>                                                                                                                                                              						' +			
			'	  	</div>																																															' +
			'	</div>																																																' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_2">																																			' +			
			'		<div class="ecg-info">																																											' +		
			'			<table class="exam-table">																																									' +	
			'				<tr class="single-chk">																																									' +
			'					<td class="title"><@spring.message "inspect.label.result"/></td>																													' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="720" /> <span><@spring.message "inspect.label.normal"/></span></label></td>											' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="721" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>										' +
			'				</tr>																																													' +
			'				<tr>																																													' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																												' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" placeholder="<@spring.message "inspect.placeholder.abnormal.desc"/>" data-item="722"></textarea></td>							' +
			'				</tr>																																													' +			
			'			</table>																																													' +	
			'		</div>                                                                                                                                                              							' +			
			'	</div>																																																' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_3">																																			' +			
			'		<div class="hm-infos">                                                                                                                         	 												' +
			'			<div class="hm-info" >                                                                                                                                    									' +			
			'				<label><input type="checkbox" class="evalInput" data-item="733" /> <span><@spring.message "inspect.label.monthly.followup.appointment"/></span></label>                               	' +
            '               <label><input type="checkbox" class="evalInput" data-item="734" /> <span><@spring.message "inspect.label.six.months.followup.appointment"/></span></label>                             	' +
            '               <label><input type="checkbox" class="evalInput" data-item="735" /> <span><@spring.message "inspect.label.three.months.followup.appointment"/></span></label>                           	' +
            '               <label><input type="checkbox" class="evalInput" data-item="736" /> <span><@spring.message "inspect.label.urgent.appointment"/></span></label>                                   		' +
            '               <label><input type="checkbox" class="evalInput" data-item="737" /> <span><@spring.message "inspect.label.other"/></span><input type="text" class="evalInput" data-item="738" /></label> ' +
			'			</div>                                                                                                                                                              						' +
			'		</div>                                                                                                                                                                  						' +			
			'	</div>																																																' +
			'</div>																																																	' ;
}

//傷口圖表單樣板
function woundContent(itemNo, record, toggleIn){
	var method = methodTemp();
	var other = otherTemp();
	var size = sizeTemp();
	var times = timesTemp();
	
	return  '<div class="collapse-content" data-recordNo="' + record.id + '" data-evalDate="' + record.evalDate + '">                                                                   													' +			
			'	<div class="func collapse ' + toggleIn + '" id="tabInfo' + record.id + '_1">																																				' +			
			'		<table class="eval-table">                                                                                                                                          													' +
			'			<tr>                                                                                                                                                    															' +
			'				<td rowspan="1"><@spring.message "inspect.label.fever"/></td>                                                                                                       											' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="555" /> <span><@spring.message "inspect.label.yes"/></span></label></td>                                                 						' +
			'				<td colspan="4"><label><input type="checkbox" class="evalInput" data-item="556" /> <span><@spring.message "inspect.label.no"/></span></label></td>                                     							' +
			'			</tr>                                                                                                                                                   															' +
			'			<tr>                                                                                                                                                            													' +
			'				<td rowspan="1"><@spring.message "inspect.label.first.happend"/></td>                                                                                                             								' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="570" /> <span><@spring.message "inspect.label.yes"/></span></label></td>                                                         				' +
			'				<td colspan="4"><label><input type="checkbox" class="evalInput" data-item="571" /> <span><@spring.message "inspect.label.no"/></span></label></td>                                             					' +
			'			</tr>                                                                                                                                                           													' +
			'			<tr>                                                                                                                                                            													' +
			'				<td rowspan="1"><@spring.message "inspect.label.over.six.weeks"/></td>                                                                                                             								' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="568" /> <span><@spring.message "inspect.label.yes"/></span></label></td>                                                         				' +
			'				<td colspan="4"><label><input type="checkbox" class="evalInput" data-item="569" /> <span><@spring.message "inspect.label.no"/></span></label></td>                                             					' +
			'			</tr>                                                                                                                                                           													' +
			'			<tr>                                                                                                                                                            													' +
			'				<td rowspan="1"><@spring.message "inspect.label.wound.size"/></td>                                                                                                             									' +
			'				<td><@spring.message "result.print.label.wound.height"/> <input type="text" class="evalInput" data-item="250" /> <@spring.message "inspect.label.centimeter"/></td>                                             ' +
			'				<td><@spring.message "result.print.label.wound.width"/> <input type="text" class="evalInput" data-item="251" /> <@spring.message "inspect.label.centimeter"/></td>                                              ' +
			'				<td><@spring.message "result.print.label.wound.depth"/> <input type="text" class="evalInput" data-item="252" /> <@spring.message "inspect.label.centimeter"/></td>                                              ' +
			'				<td colspan="2"><@spring.message "result.print.label.wound.area"/> <input type="text" class="evalInput" data-item="315" /> <@spring.message "inspect.label.square.centimeter"/></td>                            ' +
			'			</tr>                                                                                                                                                           													' +
			'			<tr style="height:50px">                                                                                                                                        													' +
			'				<td rowspan="1"><@spring.message "inspect.label.wound.prop"/></td>                                                                                                                         						' +
			'				<td><@spring.message "result.print.label.wound.epithelium"/> <input type="text" class="evalInput" data-item="445" /> <@spring.message "result.print.label.percent.unit"/></td>                                  ' +
			'				<td><@spring.message "result.print.label.wound.granular"/> <input type="text" class="evalInput" data-item="446" /> <@spring.message "result.print.label.percent.unit"/></td>                                   	' +
			'				<td><@spring.message "result.print.label.wound.slough"/> <input type="text" class="evalInput" data-item="447" /> <@spring.message "result.print.label.percent.unit"/></td>                                      ' +
			'				<td colspan="2"><@spring.message "result.print.label.wound.eschar"/> <input type="text" class="evalInput" data-item="448" /> <@spring.message "result.print.label.percent.unit"/></td>                          ' +
			'			</tr>                                                                                                                                                           													' +
			'			<tr class="single-chk">                                                                                                                                         													' +
			'				<td rowspan="2"><@spring.message "inspect.label.acute.wound.cat"/></td>                                                                                                                      					' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="352" /> <span><@spring.message "inspect.label.surgical.wound"/></span></label></td>                                                     			' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="353" /> <span><@spring.message "inspect.label.traumatic.wound"/></span></label></td>                                                      		' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="354" /> <span><@spring.message "inspect.label.laceration"/></span></label></td>                                                       			' +
			'				<td colspan="2"><label><input type="checkbox" class="evalInput" data-item="355" /> <span><@spring.message "inspect.label.burns"/></span></label></td>                                           				' +
			'			</tr>                                                                                                                                                           													' +
			'			<tr class="single-chk">                                                                                                                                      														' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="356" /> <span><@spring.message "inspect.label.moisture.associated.skin.damage"/></span></label></td>                                     		' +
			'				<td colspan="4"><label><input type="checkbox" class="evalInput" data-item="357" /> <span><@spring.message "inspect.label.other"/>　</span> <input type="text" class="evalInput" data-item="358" /></label></td>	' +
			'			</tr>                                                                                                                                                          	 													' +
			'			<tr class="single-chk">                                                                                                                                        														' +
			'				<td rowspan="2"><@spring.message "inspect.label.chronic.wound.cat"/></td>                                                                                                                      					' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="359" /> <span><@spring.message "inspect.label.pressure.injury"/></span></label></td>                                                    			' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="360" /> <span><@spring.message "inspect.label.diabetic.foot"/></span></label></td>                                                    			' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="361" /> <span><@spring.message "inspect.label.arterial.ulcers"/></span></label></td>                                                    			' +
			'				<td colspan="2"><label><input type="checkbox" class="evalInput" data-item="362" /> <span><@spring.message "inspect.label.venous.ulcers"/></span></label></td>                                        			' +
			'			</tr>                                                                                                                                                           													' +
			'			<tr class="single-chk">                                                                                                                                        														' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="670" /> <span><@spring.message "inspect.label.mfws"/></span></label></td>                                     									' +
			'				<td colspan="4"><label><input type="checkbox" class="evalInput" data-item="363" /> <span><@spring.message "inspect.label.other"/>　</span> <input type="text" class="evalInput" data-item="364" /></label></td>	' +
			'			</tr>                                                                                                                                                           													' +
			'			<tr class="stage-single-chk">                                                                                                                                   													' +
			'				<td rowspan="2"><@spring.message "inspect.label.staging"/></td>                                                                                                                                  				' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="258" /> <span><@spring.message "inspect.label.superficial.skin.loss"/></span></label></td>                                                   	' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="259" /> <span><@spring.message "inspect.label.partial.thickness.skin.loss"/></span></label></td>                                               	' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="260" /> <span><@spring.message "inspect.label.full.thickness.skin.loss"/></span></label></td>                                                   	' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="253" /> <span><@spring.message "inspect.label.stage1"/></span></label></td>                                                    					' +
			'				<td colspan="2"><label><input type="checkbox" class="evalInput" data-item="254" /> <span><@spring.message "inspect.label.stage2"/></span></label></td>                                       					' +			
			'			</tr>                                                                                                                                                           													' +
			'			<tr class="stage-single-chk">                                                                                                                                   													' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="255" /> <span><@spring.message "inspect.label.stage3"/></span></label></td>                                                    					' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="256" /> <span><@spring.message "inspect.label.stage4"/></span></label></td>                                                   					' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="257" /> <span><@spring.message "inspect.label.none.staging"/></span></label></td>                                                   				' +
			'				<td colspan="4"><label><input type="checkbox" class="evalInput" data-item="671" /> <span><@spring.message "inspect.label.deep.tissue.perssure.injury"/></span></label></td>                                    	' +			
			'			</tr>                                                                                                                                                           													' +
			'			<tr>                                                                                                                                                            													' +
			'				<td rowspan="1"><@spring.message "inspect.label.smell"/></td>                                                                                                                                					' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="557" /> <span><@spring.message "inspect.label.exist"/></span></label></td>                                                   					' +
			'				<td colspan="4"><label><input type="checkbox" class="evalInput" data-item="558" /> <span><@spring.message "inspect.label.none"/></span></label></td>                                             				' +		
			'			</tr>                                                                                                                                                           													' +
			'			<tr>                                                                                                                                                            													' +
			'				<td rowspan="1"><@spring.message "inspect.label.undermining"/></td>                                                                                                                               				' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="672" /> <span><@spring.message "inspect.label.exist"/></span></label></td>                                                   					' +
			'				<td colspan="4"><label><input type="checkbox" class="evalInput" data-item="673" /> <span><@spring.message "inspect.label.none"/></span></label></td>                                             				' +		
			'			</tr>                                                                                                                                                           													' +
			'			<tr>                                                                                                                                                            													' +
			'				<td rowspan="1"><@spring.message "inspect.label.wound.involute"/></td>                                                                                                                                 			' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="676" /> <span><@spring.message "inspect.label.exist"/></span></label></td>                                                   					' +
			'				<td colspan="4"><label><input type="checkbox" class="evalInput" data-item="677" /> <span><@spring.message "inspect.label.none"/></span></label></td>                                             				' +		
			'			</tr>                                                                                                                                                           													' +			
			'			<tr>                                                                                                                                                            													' +
			'				<td rowspan="1"><@spring.message "inspect.label.exudate.amount"/></td>                                                                                                                                  		' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="261" /> <span><@spring.message "inspect.label.five.percents"/></span></label></td>                                                        		' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="262" /> <span><@spring.message "inspect.label.twenty.five.percents"/></span></label></td>                                                       	' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="263" /> <span><@spring.message "inspect.label.fifty.percents"/></span></label></td>                                                       		' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="264" /> <span><@spring.message "inspect.label.seventy.five.percents"/></span></label></td>                                                      	' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="265" /> <span><@spring.message "inspect.label.hundred.percents"/></span></label></td>                                                       		' +
			'			</tr>                                                                                                                                                           													' +
			'			<tr class="multi-chk">                                                                                                                                          													' +
			'				<td rowspan="1"><@spring.message "inspect.label.surrounding.skin"/></td>                                                                                                                                  		' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="678" /> <span><@spring.message "inspect.label.normal"/></span></label></td>                                                        				' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="679" /> <span><@spring.message "inspect.label.infiltration"/></span></label></td>                                                       			' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="680" /> <span><@spring.message "inspect.label.dry"/></span></label></td>                                                       					' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="681" /> <span><@spring.message "inspect.label.calluses"/></span></label></td>                                                        			' +
			'				<td><label><input type="checkbox" class="evalInput" data-item="682" /> <span><@spring.message "inspect.label.eczema"/></span></label></td>                                            							' +
			'			</tr>                                                                                                                                                           													' +
			'			<tr>                                                                                                                                                    															' +
			'				<td rowspan="1"><@spring.message "inspect.label.pain"/></td>                                                                                                                        							' +
			'				<td colspan="5"><input type="text" class="evalInput" placeholder="0~10" data-item="688" /> <@spring.message "inspect.label.scores"/></td>                                              							' +		
			'			</tr>                                                                                                                                                   															' +
			//'			<tr class="multi-chk">                                                                                                                                          													' +
			//'				<td rowspan="1"><@spring.message "inspect.label.exudate.color"/></td>                                                                                                                                			' +
			//'				<td><label><input type="checkbox" class="evalInput" data-item="266" /> <span><@spring.message "inspect.label.pink"/></span></label></td>                                                       					' +
			//'				<td><label><input type="checkbox" class="evalInput" data-item="267" /> <span><@spring.message "inspect.label.red"/></span></label></td>                                                        					' +
			//'				<td><label><input type="checkbox" class="evalInput" data-item="268" /> <span><@spring.message "inspect.label.yellow"/></span></label></td>                                                        				' +
			//'				<td><label><input type="checkbox" class="evalInput" data-item="269" /> <span><@spring.message "inspect.label.green"/></span></label></td>                                                        				' +
			//'				<td><label><input type="checkbox" class="evalInput" data-item="270" /> <span><@spring.message "inspect.label.black"/></span></label></td>                                                        				' +
			//'			</tr>                                                                                                                                                           													' +			
			'		</table>                                                                                                                                                            													' +
			'		<table class="table table-striped table-bordered bootstrap-datatable hole-table">                                       																								' +
			'			<thead>                                                                                                                                                     														' +
			'				<tr class="tablesorter-headerRow">                                                                                                                      														' +
			'					<th width="20%"><@spring.message "inspect.column.healing.status"/></th>                                                                                                                                     ' +
			'					<th width="32%"><@spring.message "inspect.column.direction"/></th>                                                                                                                                        	' +
			'					<th width="25%"><@spring.message "inspect.column.depth"/></th>                                                                                                                                        		' +
			'					<th width="23%"><@spring.message "inspect.column.funcItem"/></th>                                                                                                                                       	' +
			'				</tr>                                                                                                                                                   														' +
			'				<tr class="hole-fixed-column">                                                                                                                      															' +
			'					<th><select data-item="298"><option value=""><@spring.message "inspect.select.hint"/></option><option value="N"><@spring.message "inspect.option.non.healing"/></option><option value="Y"><@spring.message "inspect.option.healing"/></option></select></th>	' +
			"					<th><input type='text' data-item='299' /> <@spring.message "inspect.label.clock"/></th>                                                                                                																			" +
			'					<th><input type="text" data-item="300" /> <@spring.message "inspect.label.centimeter"/></th>                                                                                                  																	' +
			'					<th><div class="create-group">                                                                                                           																														' +
			'						<input type="button" value="<@spring.message "inspect.button.create"/>" onclick="addRecord(this,3,298,300,\'潛行深洞V2\')" /> <input type="button" value="<@spring.message "inspect.button.cancel"/>" onclick="cleanData(this)"/>								' +
			'					</div></th>																																																														' +
			'				</tr>                                                                                                                                                   																											' +
			'			</thead>                                                                                                                                                    																											' +
			'			<tbody class="hole_content">                                                                                                                  																															' +
			'			</tbody>                                                                                                                                                    																											' +
			'		</table>                                                                                                                                                        																											' +			
			'	</div>																																																																			' +			
			'	<div class="func collapse" id="tabInfo' + record.id + '_2">																										 																												' +			
			'		<div class="ed-tabs col-md-12 col-xs-12 pd-h-5">																																																							' +
			'			<a class="btn ed-tab" data-toggle="collapse" href="#edtab' + record.id + '_0" role="button" aria-expanded="false" aria-controls="edtab' + record.id + '_0"><@spring.message "inspect.menu.wound.cleaning"/></a>									' +
			'			<a class="btn ed-tab" data-toggle="collapse" href="#edtab' + record.id + '_1" role="button" aria-expanded="false" aria-controls="edtab' + record.id + '_1"><@spring.message "inspect.menu.wound.debridement"/></a>								' +
			'			<a class="btn ed-tab" data-toggle="collapse" href="#edtab' + record.id + '_2" role="button" aria-expanded="false" aria-controls="edtab' + record.id + '_2"><@spring.message "inspect.menu.inflection.prevention"/></a>							' +
			'			<a class="btn ed-tab" data-toggle="collapse" href="#edtab' + record.id + '_3" role="button" aria-expanded="false" aria-controls="edtab' + record.id + '_3"><@spring.message "inspect.menu.skin.protection"/></a>								' +
			'			<a class="btn ed-tab" data-toggle="collapse" href="#edtab' + record.id + '_4" role="button" aria-expanded="false" aria-controls="edtab' + record.id + '_4"><@spring.message "inspect.menu.skin.care"/></a>										' +
			'			<a class="btn ed-tab" data-toggle="collapse" href="#edtab' + record.id + '_5" role="button" aria-expanded="false" aria-controls="edtab' + record.id + '_5"><@spring.message "inspect.menu.decompress"/></a>										' +
			'			<a class="btn ed-tab" data-toggle="collapse" href="#edtab' + record.id + '_6" role="button" aria-expanded="false" aria-controls="edtab' + record.id + '_6"><@spring.message "inspect.menu.dressing.change"/></a>								' +
			'			<a class="btn ed-tab" data-toggle="collapse" href="#edtab' + record.id + '_7" role="button" aria-expanded="false" aria-controls="edtab' + record.id + '_7"><@spring.message "inspection.menu.daily.concern"/></a>								' +
			'			<a class="btn ed-tab" data-toggle="collapse" href="#edtab' + record.id + '_8" role="button" aria-expanded="false" aria-controls="edtab' + record.id + '_8"><@spring.message "inspect.menu.referral"/></a>										' +
			'			<a class="btn ed-tab" data-toggle="collapse" href="#edtab' + record.id + '_9" role="button" aria-expanded="false" aria-controls="edtab' + record.id + '_8"><@spring.message "inspect.menu.other"/></a>											' +			
			'		</div>																																																												' +		
			'		<div class="clearfix"></div>																																																						' +
			'		<div class="ed-info collapse" id="edtab' + record.id + '_0">																																														' +
			'			<label><input type="checkbox" class="evalInput" data-item="449" /> <span><@spring.message "inspect.label.cleaning.item1"/></span></label>                                                   													' +
            '           <label><input type="checkbox" class="evalInput" data-item="450" /> <span><@spring.message "inspect.label.cleaning.item2"/></span></label>                                         																' +
            '           <label><input type="checkbox" class="evalInput" data-item="451" /> <span><@spring.message "inspect.label.cleaning.item3"/></span></label>                                                 														' +
            '           <label><input type="checkbox" class="evalInput" data-item="452" /> <span><@spring.message "inspect.label.cleaning.item4"/></span></label>                                   																	' +
			'			<label><input type="checkbox" class="evalInput" data-item="1239" /> <span><@spring.message "inspect.label.cleaning.item5"/></span></label>                                                   													' +
            '           <label><input type="checkbox" class="evalInput" data-item="1240" /> <span><@spring.message "inspect.label.cleaning.item6"/></span></label>                                         																' +
            '           <label><input type="checkbox" class="evalInput" data-item="1241" /> <span><@spring.message "inspect.label.cleaning.item7"/></span></label>																										' +
            '           <label><input type="checkbox" class="evalInput" data-item="1242" /> <span><@spring.message "inspect.label.cleaning.item8"/></span> <input type="text" class="evalInput" data-item="1243" /></label>												' +
			'		</div>																																																												' +
			'		<div class="ed-info collapse" id="edtab' + record.id + '_1">																																														' +			
			'           <label><input type="checkbox" class="evalInput" data-item="1244" /> <span><@spring.message "inspect.label.debridement.item1"/></span></label>                                                													' +
            '           <label><input type="checkbox" class="evalInput" data-item="1245" /> <span><@spring.message "inspect.label.debridement.item2"/></span></label>                                          															' +
            '           <label><input type="checkbox" class="evalInput" data-item="1246" /> <span><@spring.message "inspect.label.debridement.item3"/></span></label>                                                          											' +
            '           <label><input type="checkbox" class="evalInput" data-item="1247" /> <span><@spring.message "inspect.label.debridement.item4"/></span></label>                                                													' +
            '           <label><input type="checkbox" class="evalInput" data-item="1248" /> <span><@spring.message "inspect.label.debridement.item5"/></span></label>                                          															' +
            '           <label><input type="checkbox" class="evalInput" data-item="1249" /> <span><@spring.message "inspect.label.debridement.item6"/></span></label>                                                       											' +
			'		</div>																																																												' +
			'		<div class="ed-info collapse" id="edtab' + record.id + '_2">																																														' +
			'           <label><input type="checkbox" class="evalInput" data-item="1250" /> <span><@spring.message "inspect.label.prevention.item1"/></span></label>                                     																' +
            '           <label><input type="checkbox" class="evalInput" data-item="1251" /> <span><@spring.message "inspect.label.prevention.item2"/></span></label>                                               														' +
            '           <label><input type="checkbox" class="evalInput" data-item="1252" /> <span><@spring.message "inspect.label.prevention.item3"/></span></label>                                                													' +
			'           <label><input type="checkbox" class="evalInput" data-item="1253" /> <span><@spring.message "inspect.label.prevention.item4"/></span></label>                                            														' +
			'		</div>																																																												' +
			'		<div class="ed-info collapse" id="edtab' + record.id + '_3">																																														' +
			'           <label><input type="checkbox" class="evalInput" data-item="453" /> <span><@spring.message "inspect.label.protection.item1"/></span></label>                                                														' +
            '           <label><input type="checkbox" class="evalInput" data-item="454" /> <span><@spring.message "inspect.label.protection.item2"/></span></label>                                          															' +
            '           <label><input type="checkbox" class="evalInput" data-item="455" /> <span><@spring.message "inspect.label.protection.item3"/></span></label>                                                          											' +
			'           <label><input type="checkbox" class="evalInput" data-item="456" /> <span><@spring.message "inspect.label.protection.item4"/></span></label>                                     																' +
            '           <label><input type="checkbox" class="evalInput" data-item="457" /> <span><@spring.message "inspect.label.protection.item5"/></span></label>                                               														' +
            '           <label><input type="checkbox" class="evalInput" data-item="458" /> <span><@spring.message "inspect.label.protection.item6"/></span></label>                                                     												' +
			'           <label><input type="checkbox" class="evalInput" data-item="459" /> <span><@spring.message "inspect.label.protection.item7"/></span></label>                                            															' +
			'           <label><input type="checkbox" class="evalInput" data-item="460" /> <span><@spring.message "inspect.label.protection.item8"/></span></label>                                           															' +
			'		</div>																																																												' +
			'		<div class="ed-info collapse" id="edtab' + record.id + '_4">																																														' +
			'           <label><input type="checkbox" class="evalInput" data-item="461" /> <span><@spring.message "inspect.label.care.item1"/></span></label>                                                   														' +
			'           <label><input type="checkbox" class="evalInput" data-item="462" /> <span><@spring.message "inspect.label.care.item2"/></span></label>                                  																			' +
			'           <label><input type="checkbox" class="evalInput" data-item="463" /> <span><@spring.message "inspect.label.care.item3"/></span></label>                                                        													' +
			'           <label><input type="checkbox" class="evalInput" data-item="464" /> <span><@spring.message "inspect.label.care.item4"/></span></label>                                              																' +
			'           <label><input type="checkbox" class="evalInput" data-item="465" /> <span><@spring.message "inspect.label.care.item5"/></span></label>                                         																	' +
			'           <label><input type="checkbox" class="evalInput" data-item="1254" /> <span><@spring.message "inspect.label.care.item6"/></span></label>                                              															' +
			'           <label><input type="checkbox" class="evalInput" data-item="466" /> <span><@spring.message "inspect.label.care.item7"/></span></label>                                                   														' +
			'		</div>																																																												' +
			'		<div class="ed-info collapse" id="edtab' + record.id + '_5">																																														' +
			'           <label><input type="checkbox" class="evalInput" data-item="467" /> <span><@spring.message "inspect.label.decompress.item1"/></span></label>                                                														' +
			'           <label><input type="checkbox" class="evalInput" data-item="468" /> <span><@spring.message "inspect.label.decompress.item2"/></span></label>                                    																	' +
			'           <label><input type="checkbox" class="evalInput" data-item="469" /> <span><@spring.message "inspect.label.decompress.item3"/></span></label>                                                 													' +
			'           <label><input type="checkbox" class="evalInput" data-item="470" /> <span><@spring.message "inspect.label.decompress.item4"/></span></label>                             																		' +
			'           <label><input type="checkbox" class="evalInput" data-item="471" /> <span><@spring.message "inspect.label.decompress.item5"/></span></label>                                                    													' +
			'           <label><input type="checkbox" class="evalInput" data-item="472" /> <span><@spring.message "inspect.label.decompress.item6"/></span></label>                                               														' +
			'           <label><input type="checkbox" class="evalInput" data-item="473" /> <span><@spring.message "inspect.label.decompress.item7"/></span></label>                                          															' +
			'           <label><input type="checkbox" class="evalInput" data-item="474" /> <span><@spring.message "inspect.label.decompress.item8"/></span></label>                                               														' +
			'           <label><input type="checkbox" class="evalInput" data-item="475" /> <span><@spring.message "inspect.label.decompress.item9"/></span></label>                                         															' +
			'		</div>																																																												' +
			'		<div class="ed-info collapse" id="edtab' + record.id + '_6">																																														' +
			'           <label><input type="checkbox" class="evalInput" data-item="476" /> <span><@spring.message "inspect.label.dressing.item1"/></span></label>                                                      													' +
			'           <label><input type="checkbox" class="evalInput" data-item="477" /> <span><@spring.message "inspect.label.dressing.item2"/></span></label>                                      																	' +
			'           <label><input type="checkbox" class="evalInput" data-item="478" /> <span><@spring.message "inspect.label.dressing.item3"/></span></label>                                                    													' +
			'           <label><input type="checkbox" class="evalInput" data-item="479" /> <span><@spring.message "inspect.label.dressing.item4"/></span></label>                              																			' +
			'           <label><input type="checkbox" class="evalInput" data-item="480" /> <span><@spring.message "inspect.label.dressing.item5"/></span></label>                                                         												' +
			'		</div>																																																												' +
			'		<div class="ed-info collapse" id="edtab' + record.id + '_7">																																														' +
			'           <label><input type="checkbox" class="evalInput" data-item="481" /> <span><@spring.message "inspect.label.daily.item1"/></span></label>                                                              											' +
			'           <label><input type="checkbox" class="evalInput" data-item="482" /> <span><@spring.message "inspect.label.daily.item2"/></span></label>                                                              											' +
			'           <label><input type="checkbox" class="evalInput" data-item="483" /> <span><@spring.message "inspect.label.daily.item3"/></span></label>                                                              											' +
			'           <label><input type="checkbox" class="evalInput" data-item="484" /> <span><@spring.message "inspect.label.daily.item4"/></span></label>                                                       													' +
			'           <label><input type="checkbox" class="evalInput" data-item="485" /> <span><@spring.message "inspect.label.daily.item5"/></span></label>                                                      													' +
			'           <label><input type="checkbox" class="evalInput" data-item="486" /> <span><@spring.message "inspect.label.daily.item6"/></span></label>                                                         													' +
			'           <label><input type="checkbox" class="evalInput" data-item="487" /> <span><@spring.message "inspect.label.daily.item7"/></span></label>                                              															' +
			'           <label><input type="checkbox" class="evalInput" data-item="488" /> <span><@spring.message "inspect.label.daily.item8"/></span></label>                                       																	' +
			'           <label><input type="checkbox" class="evalInput" data-item="489" /> <span><@spring.message "inspect.label.daily.item9"/></span></label>                                                    														' +
			'		</div>																																																												' +
			'		<div class="ed-info collapse" id="edtab' + record.id + '_8">																																														' +
			'           <label><input type="checkbox" class="evalInput" data-item="490" /> <span><@spring.message "inspect.label.referral.item1"/></span></label>                                                           											' +
			'           <label><input type="checkbox" class="evalInput" data-item="491" /> <span><@spring.message "inspect.label.referral.item2"/></span></label>                                                       												' +
			'           <label><input type="checkbox" class="evalInput" data-item="492" /> <span><@spring.message "inspect.label.referral.item3"/></span></label>                                                          												' +
			'           <label><input type="checkbox" class="evalInput" data-item="493" /> <span><@spring.message "inspect.label.referral.item4"/></span></label>                                                          												' +
			'           <label><input type="checkbox" class="evalInput" data-item="494" /> <span><@spring.message "inspect.label.referral.item5"/></span><input type="text" class="evalInput" data-item="495" /></label>    											' +
			'		</div>																																																												' +
			'		<div class="ed-info collapse" id="edtab' + record.id + '_9">																																														' +
			'           <label><input type="checkbox" class="evalInput" data-item="496" /> <span><@spring.message "inspect.label.other"/></span><input type="text" class="evalInput" data-item="497" /></label>             											' +
			'		</div>																																																												' +
			'	</div>																																																													' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_3">																																																' +			
			'		<table class="table table-striped table-bordered bootstrap-datatable handle-table">                                       																															' +
			'			<thead>                                                                                                                                                     																					' +
			'				<tr class="tablesorter-headerRow">                                                                                                                      																					' +
			'					<th><@spring.message "inspect.column.dressing.method"/></th>                                                                                                                                      										' +
			'					<th width="15%"><@spring.message "inspect.column.dressing.other"/></th>                                                                                                                     											' +
			'					<th><@spring.message "inspect.column.size"/></th>                                                                                                                                        												' +
			'					<th width="7%"><@spring.message "inspect.column.quantity"/></th>                                                                                                                             											' +
			'					<th width="12%"><@spring.message "inspect.column.frequency"/></th>                                                                                                                            											' +
			'					<th width="24%"><@spring.message "inspect.column.funcItem"/></th>                                                                                                                           											' +
			'				</tr>                                                                                                                                                   																					' +
			'				<tr>                                                                                                                      																													' +
			'					<th>' + method + '</th>																																																					' +
			'					<th>' + other + '</th>																																																					' +			
			'					<th>' + size + '</th>																																																					' +
			'					<th><input type="text" data-item="501" /></th>                                                                                                  																						' +
			'					<th>' + times + '</th>																																																					' +
			'					<th><div class="create-group">                                                                                                           																								' +
			'						<input type="button" value="<@spring.message "inspect.button.create"/>" onclick="addRecord(this,2,498,502,\'處置方式V2\')" /> <input type="button" value="<@spring.message "inspect.button.bringin"/>" onclick="setHandleInfo(this)"/>	' +
			'						<input type="button" value="<@spring.message "inspect.button.clean"/>" onclick="cleanData(this)" />																																	' +
			'					</div></th>																																																								' +
			'				</tr>                                                                                                                                                   																					' +
			'			</thead>                                                                                                                                                    																					' +
			'			<tbody class="handle_content">                                                                                                                																									' +
			'			</tbody>                                                                                                                                                    																					' +
			'		</table>                                                                                                                                                       	 																					' +			
			'	</div>																																																													' +
			'</div>																																																														' ;
}

//超音波圖表單樣板
function ultraSoundContent(itemNo, record, toggleIn){
	return  '<div class="collapse-content" data-recordNo="' + record.id + '" data-evalDate="' + record.evalDate + '">                                                               									' +	
			'	<div class="func collapse ' + toggleIn + '" id="tabInfo' + record.id + '_1">																															' +			
			'		<div class="injured-info">                                                                                                                  														' +
			'			<table class="eval-table">                                                                                                                                  									' +
			' 				<tr>                                                                                                                                    													' +
			'					<td><@spring.message "result.print.label.ultrasound.probetype"/> </td>																													' +
			'					<td><input type="text" class="evalInput" data-item="749" /></td>																														' +
			'					<td><@spring.message "result.print.label.ultrasound.tgc3"/> </td>																														' +
			'					<td><input type="text" class="evalInput" data-item="750" /></td> 																														' +
			'					<td><@spring.message "result.print.label.ultrasound.tgc2"/> </td>																														' +
			'					<td><input type="text" class="evalInput" data-item="751" /></td>																														' +
			'					<td><@spring.message "result.print.label.ultrasound.tgc1"/> </td>																														' +
			'					<td><input type="text" class="evalInput" data-item="752" /></td> 																														' +
			'				</tr>                                                                                                                                                   									' +
			' 				<tr>                                                                                                                                    													' +
			'					<td><@spring.message "result.print.label.ultrasound.mode"/> </td>                                                                                                                       ' +
			'					<td><input type="text" class="evalInput" data-item="753" /></td>																														' +
			'					<td><@spring.message "result.print.label.ultrasound.pwr"/> </td> 																														' +
			'					<td><input type="text" class="evalInput" data-item="754" /></td> 																														' +
			'					<td><@spring.message "result.print.label.ultrasound.contrast"/> </td>																													' +
			'					<td><input type="text" class="evalInput" data-item="755" /></td>																														' +
			'					<td><@spring.message "result.print.label.ultrasound.depth"/> </td> 																														' +
			'					<td><input type="text" class="evalInput" data-item="756" /></td> 																														' +
			'				</tr>                                                                                                                                                   									' +
			' 				<tr>                                                                                                                                    													' +
			'					<td><@spring.message "result.print.label.ultrasound.dr"/> </td>                                                                                                                        	' +
			'					<td><input type="text" class="evalInput" data-item="757" /></td>																														' +
			'					<td><@spring.message "result.print.label.ultrasound.focus"/> </td> 																														' +
			'					<td><input type="text" class="evalInput" data-item="758" /></td> 																														' +
			'					<td><@spring.message "result.print.label.ultrasound.other"/> </td>																														' +
			'					<td colspan="3"><input type="text" class="evalInput" data-item="759" /></td>																											' +			
			'				</tr>                                                                                                                                                   									' +							
			'			</table>                                                                                                                                                    									' +
			'		</div>                                                                                                                                                          									' +		    			
			'	</div>																																																	' +			
			'	<div class="func collapse" id="tabInfo' + record.id + '_2">																																				' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="exam-table">																																										' +	
			'				<tr class="single-chk">																																										' +
			'					<td class="title"><@spring.message "inspect.label.liver.result"/></td>																													' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="770" /> <span><@spring.message "inspect.label.normal"/></span></label></td>												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="771" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																													' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="772" ></textarea></td>																									' +
			'				</tr>																																														' +			
			'			</table>																																														' +	
			'		</div>                                                                                                                                                          									' +			
			'	</div>																																																	' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_3">																																				' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="exam-table">																																										' +	
			'				<tr class="single-chk">																																										' +
			'					<td class="title"><@spring.message "inspect.label.guts.result"/></td>																													' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="783" /> <span><@spring.message "inspect.label.normal"/></span></label></td>												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="784" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																													' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="785" ></textarea></td>																									' +
			'				</tr>																																														' +			
			'			</table>																																														' +	
			'		</div>                                                                                                                                                          									' +			
			'	</div>																																																	' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_4">																																				' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="exam-table">																																										' +	
			'				<tr class="single-chk">																																										' +
			'					<td class="title"><@spring.message "inspect.label.kidney.result"/></td>																													' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="796" /> <span><@spring.message "inspect.label.normal"/></span></label></td>												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="797" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																													' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="798" ></textarea></td>																									' +
			'				</tr>																																														' +			
			'			</table>																																														' +	
			'		</div>                                                                                                                                                          									' +			
			'	</div>																																																	' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_5">																																				' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="exam-table">																																										' +	
			'				<tr class="single-chk">																																										' +
			'					<td class="title"><@spring.message "inspect.label.pancreas.result"/></td>																												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="809" /> <span><@spring.message "inspect.label.normal"/></span></label></td>												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="810" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																													' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="811" ></textarea></td>																									' +
			'				</tr>																																														' +			
			'			</table>																																														' +	
			'		</div>                                                                                                                                                          									' +			
			'	</div>																																																	' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_6">																																				' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="exam-table">																																										' +	
			'				<tr class="single-chk">																																										' +
			'					<td class="title"><@spring.message "inspect.label.other.result"/></td>																													' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="822" /> <span><@spring.message "inspect.label.normal"/></span></label></td>												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="823" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																													' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="824" ></textarea></td>																									' +
			'				</tr>																																														' +			
			'			</table>																																														' +
			'		</div>                                                                                                                                                          									' +
			'	</div>																																																	' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_7">																																				' +			
			'		<div class="hm-infos">                                                                                                                      														' +
			'			<div class="hm-info" >                                                                                                                                    										' +			
			'				<label><input type="checkbox" class="evalInput" data-item="835" /> <span><@spring.message "inspect.label.monthly.followup.appointment"/></span></label>                                     ' +
            '               <label><input type="checkbox" class="evalInput" data-item="836" /> <span><@spring.message "inspect.label.six.months.followup.appointment"/></span></label>                                  ' +
            '               <label><input type="checkbox" class="evalInput" data-item="837" /> <span><@spring.message "inspect.label.three.months.followup.appointment"/></span></label>                               	' +
            '               <label><input type="checkbox" class="evalInput" data-item="838" /> <span><@spring.message "inspect.label.urgent.appointment"/></span></label>                                   			' +
            '               <label><input type="checkbox" class="evalInput" data-item="839" /> <span><@spring.message "inspect.label.other"/></span><input type="text" class="evalInput" data-item="840" /></label>		' +
			'			</div>                                                                                                                                                      									' +
			'		</div>                                                                                                                                                          									' +			
			'	</div>																																																	' +
			'</div>																																																		' ;
}

//心電圖表單樣板
function ecgContent(itemNo, record, toggleIn){
	return  '<div class="collapse-content" data-recordNo="' + record.id + '" data-evalDate="' + record.evalDate + '">                                                               									' +
			'	<div class="func collapse ' + toggleIn + '" id="tabInfo' + record.id + '_1">																															' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="analy-table">																																										' +	
			'				<tr>																																														' +
			'					<td class="title"><@spring.message "result.print.column.item"/></td>																													' +
			'					<td class="title"><@spring.message "result.print.column.code"/></td>																													' +
			'					<td class="title"><@spring.message "result.print.column.value"/></td>																													' +
			'					<td class="title"><@spring.message "result.print.column.item"/></td>																													' +
			'					<td class="title"><@spring.message "result.print.column.code"/></td>																													' +
			'					<td class="title"><@spring.message "result.print.column.value"/></td>																													' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td><@spring.message "result.print.label.ecg.heartrate"/></td>																															' +
			'					<td><@spring.message "result.print.label.ecg.heartrate.code"/></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="851" /></td>																														' +			
			'					<td><@spring.message "result.print.label.ecg.meanqtc"/></td>																															' +
			'					<td><@spring.message "result.print.label.ecg.meanqtc.code"/></td>																														' +
			'					<td colspan="4"><input type="text" class="evalInput" data-item="855" /></td>																											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td><@spring.message "result.print.label.ecg.meanprint"/></td>																															' +
			'					<td><@spring.message "result.print.label.ecg.meanprint.code"/></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="852" /></td>																														' +
			'					<td><@spring.message "result.print.label.ecg.pfrontaxis"/></td>																															' +
			'					<td><@spring.message "result.print.label.ecg.pfrontaxis.code"/></td>																													' +
			'					<td colspan="4"><input type="text" class="evalInput" data-item="856" /></td>																											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td><@spring.message "result.print.label.ecg.meanqrsdur"/></td>																															' +
			'					<td><@spring.message "result.print.label.ecg.meanqrsdur.code"/></td>																													' +
			'					<td><input type="text" class="evalInput" data-item="853" /></td>																														' +
			'					<td><@spring.message "result.print.label.ecg.tfrontaxis"/></td>																															' +
			'					<td><@spring.message "result.print.label.ecg.tfrontaxis.code"/></td>																													' +
			'					<td><input type="text" class="evalInput" data-item="857" /></td>																														' +
			'				</tr>																																														' +			
			'				<tr>																																														' +
			'					<td><@spring.message "result.print.label.ecg.meanqtint"/></td>																															' +
			'					<td><@spring.message "result.print.label.ecg.meanqtint.code"/></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="854" /></td>																														' +
			'				</tr>																																														' +
			'			</table>																																														' +	
			'		</div>                                                                                                                                                          									' +			
			'	</div>																																																	' +												
			'	<div class="func collapse" id="tabInfo' + record.id + '_2">																																				' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="exam-table">																																										' +	
			'				<tr class="single-chk">																																										' +
			'					<td class="title"><@spring.message "inspect.label.result"/></td>																														' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="868" /> <span><@spring.message "inspect.label.normal"/></span></label></td>												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="869" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																													' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="870" ></textarea></td>																									' +
			'				</tr>																																														' +			
			'			</table>																																														' +	
			'		</div>                                                                                                                                                         										' +			
			'	</div>																																																	' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_3">																																				' +		
			'		<div class="hm-infos">                                                                                                                         														' +
			'			<div class="hm-info" >                                                                                                                                    										' +			
			'				<label><input type="checkbox" class="evalInput" data-item="881" /> <span><@spring.message "inspect.label.monthly.followup.appointment"/></span></label>                                     ' +
            '               <label><input type="checkbox" class="evalInput" data-item="882" /> <span><@spring.message "inspect.label.six.months.followup.appointment"/></span></label>                                  ' +
            '               <label><input type="checkbox" class="evalInput" data-item="883" /> <span><@spring.message "inspect.label.three.months.followup.appointment"/></span></label>                                ' +
            '               <label><input type="checkbox" class="evalInput" data-item="884" /> <span><@spring.message "inspect.label.urgent.appointment"/></span></label>                                   			' +
            '               <label><input type="checkbox" class="evalInput" data-item="885" /> <span><@spring.message "inspect.label.other"/></span><input type="text" class="evalInput" data-item="886" /></label>     ' +
			'			</div>                                                                                                                                                     										' +
			'		</div>                                                                                                                                                         										' +			
			'	</div>																																																	' +
			'</div>																																																		' ;
}

//肺量圖表單樣板
function lfmContent(itemNo, record, toggleIn){
	return  '<div class="collapse-content" data-recordNo="' + record.id + '" data-evalDate="' + record.evalDate + '">                                                               ' +
			'	<div class="func collapse ' + toggleIn + '" id="tabInfo' + record.id + '_1">																						' +			
			'		<div class="ecg-info">																																			' +		
			'			<table class="analy-table detail">																															' +	
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "result.print.column.param"/></td>																				' +
			'					<td class="title"></td>																																' +
			'					<td class="title"><@spring.message "result.print.column.lln"/></td>																					' +
			'					<td class="title"><@spring.message "result.print.column.pred"/></td>																				' +
			'					<td class="title"><@spring.message "result.print.column.best"/></td>																				' +
			'					<td class="title"><@spring.message "result.print.column.pred.unit"/></td>																			' +
			'					<td class="title"><@spring.message "result.print.column.zscore"/></td>																				' +
			'					<td class="title"><@spring.message "result.print.column.pre1"/></td>																				' +
			'					<td class="title"><@spring.message "result.print.column.pre2"/></td>																				' +
			'					<td class="title"><@spring.message "result.print.column.pre3"/></td>																				' +
			'					<td class="title"><@spring.message "result.print.column.post"/></td>																				' +
			'					<td class="title"><@spring.message "result.print.column.pred.unit"/></td>																			' +
			'					<td class="title"><@spring.message "result.print.column.chg"/></td>																					' +
			'				</tr>																																					' +
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.fvc"/></td>																		' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.unit.l"/></td>																	' +
			'					<td><input type="text" class="btm-line evalInput" data-item="958" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="959" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="960" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="961" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="962" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="963" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="964" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="965" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="966" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="967" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="968" /></td>																			' +			
			'				</tr>																																					' +
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.fev1"/></td>																		' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.unit.l"/></td>																	' +
			'					<td><input type="text" class="btm-line evalInput" data-item="969" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="970" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="971" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="972" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="973" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="974" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="975" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="976" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="977" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="978" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="979" /></td>																			' +			
			'				</tr>																																					' +
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.fev1.fvc"/></td>																	' +
			'					<td class="title"><@spring.message "result.print.column.percent"/></td>																				' +
			'					<td><input type="text" class="btm-line evalInput" data-item="980" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="981" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="982" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="983" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="984" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="985" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="986" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="987" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="988" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="989" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="990" /></td>																			' +
			'				</tr>																																					' +
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.pef"/></td>																		' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.unit.ls"/></td>																	' +
			'					<td><input type="text" class="btm-line evalInput" data-item="991" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="992" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="993" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="994" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="995" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="996" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="997" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="998" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="999" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1000" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1001" /></td>																			' +
			'				</tr>																																					' +			
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.ela"/></td>																		' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.unit.yrs"/></td>																	' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1002" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1003" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1004" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1005" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1006" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1007" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1008" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1009" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1010" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1011" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1012" /></td>																			' +
			'				</tr>																																					' +
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.fef2575"/></td>																	' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.unit.ls"/></td>																	' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1013" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1014" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1015" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1016" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1017" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1018" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1019" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1020" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1021" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1022" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1023" /></td>																			' +			
			'				</tr>																																					' +
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.fet"/></td>																		' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.unit.s"/></td>																	' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1024" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1025" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1026" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1027" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1028" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1029" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1030" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1031" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1032" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1033" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1034" /></td>																			' +			
			'				</tr>																																					' +
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.fivc"/></td>																		' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.unit.l"/></td>																	' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1035" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1036" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1037" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1038" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1039" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1040" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1041" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1042" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1043" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1044" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1045" /></td>																			' +			
			'				</tr>																																					' +
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "result.print.label.spirometer.fev1.vc"/></td>																	' +
			'					<td class="title"><@spring.message "result.print.column.percent"/></td>																				' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1046" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1047" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1048" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1049" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1050" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1051" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1052" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1053" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1054" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1055" /></td>																			' +
			'					<td><input type="text" class="btm-line evalInput" data-item="1056" /></td>																			' +			
			'				</tr>																																					' +
			'			</table>																																					' +	
			'		</div>                                                                                                                                                          ' +			
			'	</div>																																								' +												
			'	<div class="func collapse" id="tabInfo' + record.id + '_2">																											' +			
			'		<div class="ecg-info">																																			' +		
			'			<table class="exam-table">																																	' +	
			'				<tr class="single-chk">																																	' +
			'					<td class="title"><@spring.message "inspect.label.result"/></td>																					' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="915" /> <span><@spring.message "inspect.label.normal"/></span></label></td>			' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="916" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>		' +
			'				</tr>																																					' +
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																				' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="917" ></textarea></td>																' +
			'				</tr>																																					' +			
			'			</table>																																					' +	
			'		</div>                                                                                                                                                          ' +			
			'	</div>																																								' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_3">																											' +					
			'		<div class="hm-infos">                                                                                                                         					' +
			'			<div class="hm-info" >                                                                                                                                    	' +			
			'				<label><input type="checkbox" class="evalInput" data-item="928" /> <span><@spring.message "inspect.label.monthly.followup.appointment"/></span></label>                                  	' +
            '               <label><input type="checkbox" class="evalInput" data-item="929" /> <span><@spring.message "inspect.label.six.months.followup.appointment"/></span></label>                                  ' +
            '               <label><input type="checkbox" class="evalInput" data-item="930" /> <span><@spring.message "inspect.label.three.months.followup.appointment"/></span></label>                            	' +
            '               <label><input type="checkbox" class="evalInput" data-item="931" /> <span><@spring.message "inspect.label.urgent.appointment"/></span></label>                                   			' +
            '               <label><input type="checkbox" class="evalInput" data-item="932" /> <span><@spring.message "inspect.label.other"/></span><input type="text" class="evalInput" data-item="933" /></label>  	' +
			'			</div>                                                                                                                                                      ' +
			'		</div>                                                                                                                                                          ' +			
			'	</div>																																								' +
			'</div>																																									' ;
}

//耳鏡圖表單樣板
function otoContent(itemNo, record, toggleIn){
	return  '<div class="collapse-content" data-recordNo="' + record.id + '" data-evalDate="' + record.evalDate + '">                                                               									' +
			'	<div class="func collapse ' + toggleIn + '" id="tabInfo' + record.id + '_1">																															' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="exam-table">																																										' +	
			'				<tr class="status-chk">																																										' +
			'					<td class="title"><@spring.message "inspect.label.result.left.ear"/></td>																												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="1128" /> <span><@spring.message "inspect.label.normal"/></span></label></td>												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="1129" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>											' +
			'				</tr>																																														' +
			'				<tr class="status-chk">																																										' +
			'					<td class="title"><@spring.message "inspect.label.result.right.ear"/></td>																												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="1131" /> <span><@spring.message "inspect.label.normal"/></span></label></td>												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="1132" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																													' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="1130"></textarea></td>																									' +
			'				</tr>																																														' +			
			'			</table>																																														' +	
			'		</div>                                                                                                                                                          									' +
			'	</div>																																																	' +			
			'	<div class="func collapse" id="tabInfo' + record.id + '_2">																																				' +						
			'		<div class="hm-infos">                                                                                                                      														' +
			'			<div class="hm-info" >                                                                                                                                    										' +			
			'				<label><input type="checkbox" class="evalInput" data-item="1141" /> <span><@spring.message "inspect.label.monthly.followup.appointment"/></span></label>                                    ' +
            '               <label><input type="checkbox" class="evalInput" data-item="1142" /> <span><@spring.message "inspect.label.six.months.followup.appointment"/></span></label>                                 ' +
            '               <label><input type="checkbox" class="evalInput" data-item="1143" /> <span><@spring.message "inspect.label.three.months.followup.appointment"/></span></label>                               ' +
            '               <label><input type="checkbox" class="evalInput" data-item="1144" /> <span><@spring.message "inspect.label.urgent.appointment"/></span></label>                                   			' +
            '               <label><input type="checkbox" class="evalInput" data-item="1145" /> <span><@spring.message "inspect.label.other"/></span><input type="text" class="evalInput" data-item="1146" /></label>   ' +
			'			</div>                                                                                                                                                      									' +
			'		</div>                                                                                                                                                          									' +
			'	</div>																																																	' +			
			'</div>																																																		' ;
}

//聽力檢測圖表單樣板
function audioMetersContent(itemNo, record, toggleIn){
	return  '<div class="collapse-content" data-recordNo="' + record.id + '" data-evalDate="' + record.evalDate + '">                                                               ' +
			'	<div class="func collapse ' + toggleIn + '" id="tabInfo' + record.id + '_1">																						' +			
			'		<div class="boxes">																																				' +
			'			<div class="analy-infos">																																	' +		
			'				<div id="audio-meters-info-right" class="audio-meters-info">																							' +
			'					<table class="analy-table audio-meters">																											' +
			'						<tr>																																			' +
			'							<td class="direction" colspan="3"><@spring.message "inspect.label.right.ear"/></td>															' +
			'						</tr>																																			' +	
			'						<tr>																																			' +
			'							<td class="title"><@spring.message "result.print.label.hearingDetector.frequency"/></td>													' +
			'							<td class="title"><@spring.message "result.print.label.hearingDetector.hearing.level"/></td>												' +
			'							<td class="title"><@spring.message "result.print.label.hearingDetector.status"/></td>														' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.125"/></td>																		' +
			'							<td><input type="text" class="evalInput" data-item="1067" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1157" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.250"/></td>																		' +
			'							<td><input type="text" class="evalInput" data-item="1068" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1158" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.500"/></td>																		' +
			'							<td><input type="text" class="evalInput" data-item="1069" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1159" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.750"/></td>																		' +
			'							<td><input type="text" class="evalInput" data-item="1070" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1160" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.1000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1071" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1161" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.1500"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1072" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1162" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.2000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1073" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1163" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.3000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1074" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1164" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.4000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1075" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1165" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.6000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1076" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1166" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.8000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1077" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1167" /></td>																			' +
			'						</tr>																																			' +
			'					</table>																																			' +		
			'				</div>                                                                                                                                                  ' +
			'				<div id="audio-meters-info-left" class="audio-meters-info">																								' +
			'					<table class="analy-table audio-meters">																											' +	
			'						<tr>																																			' +
			'							<td class="direction" colspan="3"><@spring.message "inspect.label.left.ear"/></td>															' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td class="title"><@spring.message "result.print.label.hearingDetector.frequency"/></td>													' +
			'							<td class="title"><@spring.message "result.print.label.hearingDetector.hearing.level"/></td>												' +
			'							<td class="title"><@spring.message "result.print.label.hearingDetector.status"/></td>														' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.125"/></td>																		' +
			'							<td><input type="text" class="evalInput" data-item="1078" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1168" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.250"/></td>																		' +
			'							<td><input type="text" class="evalInput" data-item="1079" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1169" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.500"/></td>																		' +
			'							<td><input type="text" class="evalInput" data-item="1080" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1170" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.750"/></td>																		' +
			'							<td><input type="text" class="evalInput" data-item="1081" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1171" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.1000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1082" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1172" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.1500"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1083" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1173" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.2000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1084" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1174" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.3000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1085" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1175" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.4000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1086" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1176" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.6000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1087" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1177" /></td>																			' +
			'						</tr>																																			' +
			'						<tr>																																			' +
			'							<td><@spring.message "result.print.label.hearingDetector.hz.8000"/></td>																	' +
			'							<td><input type="text" class="evalInput" data-item="1088" /> <@spring.message "result.print.label.hz.unit"/></td>							' +
			'							<td><input type="text" class="evalInput" data-item="1178" /></td>																			' +
			'						</tr>																																			' +
			'					</table>																																			' +
			'				</div>																																					' +
			'			</div>                                                                                                                                                      ' +
			'		</div>                                                                                                                                                          ' +			
			'	</div>																																								' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_2">																											' +			
			'		<div class="ecg-info">																																			' +		
			'			<table class="exam-table">																																	' +	
			'				<tr class="single-chk">																																	' +
			'					<td class="title"><@spring.message "inspect.label.result"/></td>																					' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="1099" /> <span><@spring.message "inspect.label.normal"/></span></label></td>			' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="1100" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>		' +
			'				</tr>																																					' +
			'				<tr>																																					' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																				' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="1101"></textarea></td>																' +
			'				</tr>																																					' +			
			'			</table>																																					' +	
			'		</div>                                                                                                                                                          ' +			
			'	</div>																																								' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_3">																											' +			
			'		<div class="hm-infos">                                                                                                                      					' +
			'			<div class="hm-info" >                                                                                                                                    	' +			
			'				<label><input type="checkbox" class="evalInput" data-item="1113" /> <span><@spring.message "inspect.label.monthly.followup.appointment"/></span></label>                                   	' +
            '               <label><input type="checkbox" class="evalInput" data-item="1114" /> <span><@spring.message "inspect.label.six.months.followup.appointment"/></span></label>                                	' +
            '               <label><input type="checkbox" class="evalInput" data-item="1115" /> <span><@spring.message "inspect.label.three.months.followup.appointment"/></span></label>                               ' +
            '               <label><input type="checkbox" class="evalInput" data-item="1116" /> <span><@spring.message "inspect.label.urgent.appointment"/></span></label>                                   			' +
            '               <label><input type="checkbox" class="evalInput" data-item="1117" /> <span><@spring.message "inspect.label.other"/></span><input type="text" class="evalInput" data-item="1118" /></label>  	' +
			'			</div>                                                                                                                                                      ' +
			'		</div>                                                                                                                                                          ' +			
			'	</div>																																								' +
			'</div>																																									' ;
}

//ABI圖表單樣板
function abiContent(itemNo, record, toggleIn){
	return  '<div class="collapse-content" data-recordNo="' + record.id + '" data-evalDate="' + record.evalDate + '">                                                               									' +
			'	<div class="func collapse ' + toggleIn + '" id="tabInfo' + record.id + '_1">																															' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="analy-table">																																										' +	
			'				<tr>																																														' +
			'					<td colspan="6" class="title">數據結果</td>																																				' +	
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td>#</td>																																												' +
			'					<td>Sys</td>																																											' +
			'					<td>Dia</td>																																											' +			
			'					<td>MAP</td>																																											' +
			'					<td>PP.</td>																																											' +
			'					<td>Pluse</td>																																											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td>RB</td>																																												' +
			'					<td><input type="text" class="evalInput" data-item="1300" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1301" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1302" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1303" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1304" /></td>																														' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td>LB</td>																																												' +
			'					<td><input type="text" class="evalInput" data-item="1305" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1306" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1307" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1308" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1309" /></td>																														' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td>RA</td>																																												' +
			'					<td><input type="text" class="evalInput" data-item="1310" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1311" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1312" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1313" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1314" /></td>																														' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td>LA</td>																																												' +
			'					<td><input type="text" class="evalInput" data-item="1315" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1316" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1317" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1318" /></td>																														' +
			'					<td><input type="text" class="evalInput" data-item="1319" /></td>																														' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td colspan="6" class="title">最終計算結果</td>																																				' +	
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td>R_ABI</td>																																											' +
			'					<td colspan="2"><input type="text" class="evalInput" data-item="1320" /></td>																											' +
			'					<td>L_ABI</td>																																											' +
			'					<td colspan="2"><input type="text" class="evalInput" data-item="1321" /></td>																											' +
			'				</tr>																																														' +
			'			</table>																																														' +	
			'		</div>                                                                                                                                                          									' +			
			'	</div>																																																	' +												
			'	<div class="func collapse" id="tabInfo' + record.id + '_2">																																				' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="exam-table">																																										' +	
			'				<tr class="single-chk">																																										' +
			'					<td class="title"><@spring.message "inspect.label.result"/></td>																														' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="1330" /> <span><@spring.message "inspect.label.normal"/></span></label></td>												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="1331" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																													' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="1332" ></textarea></td>																									' +
			'				</tr>																																														' +			
			'			</table>																																														' +	
			'		</div>                                                                                                                                                         										' +			
			'	</div>																																																	' +
			'	<div class="func collapse" id="tabInfo' + record.id + '_3">																																				' +		
			'		<div class="hm-infos">                                                                                                                         														' +
			'			<div class="hm-info" >                                                                                                                                    										' +			
			'				<label><input type="checkbox" class="evalInput" data-item="1340" /> <span><@spring.message "inspect.label.monthly.followup.appointment"/></span></label>                                    ' +
            '               <label><input type="checkbox" class="evalInput" data-item="1341" /> <span><@spring.message "inspect.label.six.months.followup.appointment"/></span></label>                                 ' +
            '               <label><input type="checkbox" class="evalInput" data-item="1342" /> <span><@spring.message "inspect.label.three.months.followup.appointment"/></span></label>                               ' +
            '               <label><input type="checkbox" class="evalInput" data-item="1343" /> <span><@spring.message "inspect.label.urgent.appointment"/></span></label>                                   			' +
            '               <label><input type="checkbox" class="evalInput" data-item="1344" /> <span><@spring.message "inspect.label.other"/></span><input type="text" class="evalInput" data-item="1345" /></label>   ' +
			'			</div>                                                                                                                                                     										' +
			'		</div>                                                                                                                                                         										' +			
			'	</div>																																																	' +
			'</div>																																																		' ;
}

//皮膚鏡圖表單樣板
function dermatoContent(itemNo, record, toggleIn){
	return  '<div class="collapse-content" data-recordNo="' + record.id + '" data-evalDate="' + record.evalDate + '">                                                               									' +
			'	<div class="func collapse ' + toggleIn + '" id="tabInfo' + record.id + '_1">																															' +			
			'		<div class="ecg-info">																																												' +		
			'			<table class="exam-table">																																										' +	
			'				<tr class="single-chk">																																										' +
			'					<td class="title"><@spring.message "inspect.label.result"/></td>																														' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="1350" /> <span><@spring.message "inspect.label.normal"/></span></label></td>												' +
			'					<td><label><input type="checkbox" class="evalInput" data-item="1351" /> <span><@spring.message "inspect.label.abnormal"/></span></label></td>											' +
			'				</tr>																																														' +
			'				<tr>																																														' +
			'					<td class="title"><@spring.message "inspect.label.abnormal.desc"/></td>																													' +
			'					<td colspan="2"><textarea rows="6" class="evalInput" data-item="1352"></textarea></td>																									' +
			'				</tr>																																														' +			
			'			</table>																																														' +	
			'		</div>                                                                                                                                                          									' +
			'	</div>																																																	' +			
			'	<div class="func collapse" id="tabInfo' + record.id + '_2">																																				' +						
			'		<div class="hm-infos">                                                                                                                      														' +
			'			<div class="hm-info" >                                                                                                                                    										' +			
			'				<label><input type="checkbox" class="evalInput" data-item="1360" /> <span><@spring.message "inspect.label.monthly.followup.appointment"/></span></label>                                    ' +
            '               <label><input type="checkbox" class="evalInput" data-item="1361" /> <span><@spring.message "inspect.label.six.months.followup.appointment"/></span></label>                                 ' +
            '               <label><input type="checkbox" class="evalInput" data-item="1362" /> <span><@spring.message "inspect.label.three.months.followup.appointment"/></span></label>                               ' +
            '               <label><input type="checkbox" class="evalInput" data-item="1363" /> <span><@spring.message "inspect.label.urgent.appointment"/></span></label>                                   			' +
            '               <label><input type="checkbox" class="evalInput" data-item="1364" /> <span><@spring.message "inspect.label.other"/></span><input type="text" class="evalInput" data-item="1365" /></label>   ' +
			'			</div>                                                                                                                                                      									' +
			'		</div>                                                                                                                                                          									' +
			'	</div>																																																	' +			
			'</div>																																																		' ;
}

//回傳敷藥方式選項樣板(處置方式)
function methodTemp(){
    return '<select class="menu" data-item="498">																																   		   	' +
		   '	<option value=""><@spring.message "inspect.select.dressing"/></option><optgroup label="A-">																					' +
		   '	<option value="Acticoat">Acticoat</option><option value="Allevyn Adhesive">Allevyn Adhesive</option>																	   	' +
		   '	<option value="Aquacel Ag">Aquacel Ag</option><option value="Aquacel Extra">Aquacel Extra</option><option value="Aquacel Extra Ag+">Aquacel Extra Ag+</option>			   	' +
		   '	<option value="Aquacel Foam">Aquacel Foam</option><option value="Aquacel Ag Foam">Aquacel Ag Foam</option></optgroup>													   	' +
		   '	<optgroup label="B-"><option value="Biatain Ag">Biatain Ag</option><option value="Biatain silicone">Biatain silicone</option>											   	' +
		   '	<option value="Biatain silicone Lite">Biatain silicone Lite</option><option value="Biatain Ibu">Biatain Ibu</option>													   	' +
		   '	<option value="Biatain Foam">Biatain Foam</option><option value="Biatain Foam Adhesive">Biatain Foam Adhesive</option>													   	' +
		   '	<option value="Biatain Alginate">Biatain Alginate</option><option value="Biatain Alginate Ag">Biatain Alginate Ag</option></optgroup>									   	' +
		   '	<optgroup label="C-"><option value="Comfeel">Comfeel</option></optgroup><optgroup label="D-"><option value="Duoderm 薄">Duoderm 薄</option>								   	' +
		   '	<option value="Duoderm 厚">Duoderm 厚</option><option value="Duoderm gel">Duoderm gel</option></optgroup>																	   	' +
		   '	<optgroup label="F-"><option value="Foam Lite">Foam Lite</option></optgroup>																							   	' +
		   '	<optgroup label="K-"><option value="Kaltostat">Kaltostat</option></optgroup><optgroup label="M-"><option value="Mepilex">Mepilex</option>								   	' +
		   '	<option value="Mepilex Ag">Mepilex Ag</option><option value="Mepilex Border">Mepilex Border</option><option value="Mepilex Lite">Mepilex Lite</option>					   	' +
		   '	<option value="Melgisorb Ag">Melgisorb Ag</option><option value="Mepitel">Mepitel</option></optgroup><optgroup label="N-">												   	' +
		   '	<option value="NPWT- KCI">NPWT- KCI</option><option value="NPWT- Genadyne">NPWT- Genadyne</option><option value="NPWT- Wall suction">NPWT- Wall suction</option></optgroup>	' +
		   '	<optgroup label="P-"><option value="Prisma">Prisma</option><option value="Prontosan">Prontosan</option></optgroup>											   			   	' +
		   '	<optgroup label="3-"><option value="3M無痛保護膜">3M無痛保護膜</option><option value="3M高效保膚劑">3M高效保膚劑</option>																' +
		   '	<optgroup label="<@spring.message "inspect.optgroup.other"/>"><option value="<@spring.message "inspect.option.other"/>"><@spring.message "inspect.option.other"/></option>	' +
		   '</select>																																									   	' +
		   '<input type="text" class="other-content hidden">																															   	' ;
}

//回傳其他敷藥方式選項樣板(處置方式)
function otherTemp(){
	return '<select class="menu" data-item="499">																								 																		' +
		   '	<option value=""><@spring.message "inspect.select.other"/></option><option value="BI ointment">BI ointment</option><option value="Compression">Compression</option>										' +
		   '	<option value="Fusidic Acid">Fusidic Acid</option><option value="Iodosorb">Iodosorb</option><option value="N/S wet">N/S wet</option>																	' +
		   '	<option value="Sulfasil">Sulfasil</option><option value="Tetracycline">Tetracycline</option><option value="<@spring.message "inspect.option.other"/>"><@spring.message "inspect.option.other"/></option>' +
		   '</select>                                                                                                																									' +
		   '<input type="text" class="other-content hidden">																																							' ;
}

//回傳敷藥尺寸選項樣板(處置方式)
function sizeTemp(){
	return '<select class="menu" data-item="500">																																										' +
		   '	<option value=""><@spring.message "inspect.select.size"/></option><option value="2*45">2*45</option><option value="3*44">3*44</option><option value="5*12.5">5*12.5</option> 							' +
		   '	<option value="5.5*12">5.5*12</option><option value="7.5*7.5">7.5*7.5</option><option value="7.5*12">7.5*12</option>					  																' +
		   '	<option value="10*10">10*10</option><option value="10*18">10*18</option><option value="10*20">10*20</option>																							' +
		   '	<option value="12.5*12.5">12.5*12.5</option><option value="15*15">15*15</option><option value="17.5*17.5">17.5*17.5</option>																			' +
		   '	<option value="18*18">18*18</option><option value="20*20">20*20</option><option value="20g">20g</option><option value="50g">50g</option>																' +
		   '	<option value="負壓泡棉敷料(大K)">負壓泡棉敷料(大K)</option><option value="負壓泡棉敷料(中G)">負壓泡棉敷料(中G)</option>																									' +
		   '	<option value="負壓泡棉敷料(小K)">負壓泡棉敷料(小K)</option><option value="滲液收集罐">滲液收集罐</option><option value="<@spring.message "inspect.option.other"/>"><@spring.message "inspect.option.other"/></option>	' +
		   '</select>                                                                                                  																									' +
		   '<input type="text" class="other-content hidden">																																							' ;
}

//回傳敷藥頻率選項樣板(處置方式)
function timesTemp(){
	return '<select class="menu" data-item="502">																																			' +
		   '	<option value=""><@spring.message "inspect.select.frequency"/></option><option value="QD">QD</option><option value="BID">BID</option><option value="Q8H">Q8H</option>		' +
		   '	<option value="Q12H">Q12H</option><option value="QOD">QOD</option><option value="Q2D~D3D">Q2D~D3D</option><option value="BIW">BIW</option>									' +
		   '	<option value="QW">QW</option><option value="PRN">PRN</option><option value="<@spring.message "inspect.option.other"/>"><@spring.message "inspect.option.other"/></option>	' +			
		   '</select>                                                                                                 																		' +
		   '<input type="text" class="other-content hidden">																																' ;
}

//將生成樣板內的所有元素進行動作執行
function activMultiFunc(){
		
	$(".btm-content-header").find(".tab-func").click(function () {
		$(".collapse-content").find(".func.collapse.in").collapse("hide");
	});
	//
	$(".func").on('shown.bs.collapse', function (e) {		
		if($(this).parent("div").hasClass('active')){
		   	var itemNumArr = getItemNumArray("collapse-content.active > .collapse.in", "evalInput");
			var recordno = $(".collapse-content.active").attr('data-recordno');
			
	    	if(itemNumArr.length > 0){	    	
				var postData = {"userFormKeyNo": recordno, "itemIds": itemNumArr};
				var postRecords = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryAns?location=${__field}");
	
				setEvalFormValue("collapse-content", "evalInput" , postRecords.result);
				
				var recordTime = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/qryLatestRecordTime?keyno=" + recordno); 
		    	setUpdateInfo(recordTime.modifier);
		    }
		}
	});
	//
	$(".ed-tab").click(function () {
		$(".collapse-content").find(".ed-info.collapse.in").collapse("hide");
	});

	$(".collapse-content").each(function(){

		//傷口專用tab
		$(this).find(".ed-tab:nth-child(1)").click();
		//
		$(this).find('table input[type="checkbox"]').change(function() {
			var checkedValue = $(this).prop('checked');
			
			//若非多選情況下
			if(!$(this).closest('tr').hasClass("multi-chk")){
				//若沒有標示single-chk情況下
				if(!$(this).closest('tr').hasClass("single-chk")){			
				    $(this).closest('tr').find('input[type="checkbox"]').each(function(){
				       	$(this).prop('checked',false);
				    });
				    $(this).prop("checked",checkedValue);
			    }
			    else{		    	
			    	$(this).closest('table').find("tr").each(function(){
			    		if($(this).hasClass('single-chk')){
			    			$(this).find('input[type="checkbox"]').each(function(){
						       $(this).prop('checked',false);
						       $(this).closest('td').find("input[type='text']").val("");
						    });					    
			    		}
			    	});
			    	$(this).prop("checked",checkedValue);
			    }   
			}			
		});
		//
		//表單欄位值keyin直接儲存(20220103更新)
		$(this).find(".evalInput:text, textarea.evalInput, select.evalInput").focusout(function(){
			var itemTarget = $(".item-list.active");
			var recordTarget = $(".collapse-content.active");
			var itemNo = $(this).data("item");			
			var keyNo = recordTarget.attr('data-recordno');

			var itemArray = saveEvalFormValue("evalInput", keyNo, itemNo);
			var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": keyNo, "items": itemArray};
	
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/editUserForm?");
			if(result.success){
				var recordTime = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/qryLatestRecordTime?keyno=" + keyNo);
				$(".update-text").html(recordTime.modifier);
				
				refreshChart();
			}
			else{
				swal("<@spring.message "inspect.save.fail.title"/>", "<@spring.message "inspect.save.fail.text"/>", "error");
			}
		});
		//
		//表單欄位值keyin直接儲存(20220103更新)
		$(this).find(".evalInput:checkbox, label > span").mouseup(function(){
			var item = $(this).data('item') == undefined ? $(this).prev("input[type='checkbox']").data('item') : $(this).data('item');
			
			setTimeout(function(){			
				var recordTarget = $(".collapse-content.active");
				var keyNo = recordTarget.attr('data-recordno');				
				var itemArray = saveEvalFormValue("evalInput", keyNo, item);
			
				var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": keyNo, "items": itemArray};

				var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/editUserForm?");
				if(result.success){
					var recordTime = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/qryLatestRecordTime?keyno=" + keyNo);
					$(".update-text").html(recordTime.modifier);				
				}
				else{
					swal("<@spring.message "inspect.save.fail.title"/>", "<@spring.message "inspect.save.fail.text"/>", "error");
				}
			},50);
		});
		
		//其他傷口處置方式
		$(this).find(".other-content").keyup(function(){
			var length = $(this).prev("select").has("optgroup").length;
			if(length > 0){
				$(this).prev("select").find("optgroup[label='<@spring.message "inspect.optgroup.other"/>'] > option:eq(0)").val($(this).val());
			}else{
				$(this).prev("select").find("option:last-child").val($(this).val());
			}
		});
		//
		$(this).find(".menu").change(function(){
			var obj = $(this).next("input[type='text']");
			if($(this).val() == "<@spring.message "inspect.option.other"/>"){
				obj.removeClass("hidden");
			}
			else{
				obj.val("<@spring.message "inspect.option.other"/>").trigger("keyup").val("").addClass("hidden");
			}
		});
	    //
	    $(this).find(".report-status").click(function() {
	    	var recordTarget = $(".collapse-content.active");
			var keyNo = recordTarget.attr('data-recordno');
			var infoData = {"userFormKeyNo": keyNo, "itemIds": getItemsArray(555,571)};	
			var infoRecord = wg.evalForm.getJson({"data":JSON.stringify(infoData)}, "${base}/division/api/qryAns");
			setStatusInfo("status-info-table", "evalInput" , infoRecord.result);
			$("#myModal14").modal('show');
		});
	});
	//
	$(".date-btn").click(function () {
		var formNo = $(this).data("formno");
		var deviceNo = $(".item.active").data("item");		
		//
		$(".btm-content-header").find(".tab-func").each(function(idx){
			$(this).attr("href", "#tabInfo" + formNo + "_" + (idx+1));
			$(this).attr("aria-controls", "#tabInfo" + formNo + "_" + (idx+1));
		});
		//
		$(".btm-content-header").find(".tab-func").first().trigger('click');
		
		$(".collapse-content.active, .date-btn.active").toggleClass("active");
		$(this).toggleClass("active");
		//
		$(".collapse-content").each(function(){
			var recordNo = $(this).data("recordno");
			if(recordNo == formNo){
				$(this).toggleClass("active");
				/*var postData = {"userFormKeyNo": formNo, "itemIds": getItemNumArray("collapse-content.active", "evalInput")};
				var postRecords = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryAns");
				setEvalFormValue("collapse-content", "evalInput" , postRecords.result);
				
				var recordTime = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/qryLatestRecordTime?keyno=" + formNo); 
		    	setUpdateInfo(recordTime.modifier);
		    	
		    	if(deviceNo == 2){
					//潛行深洞與處置方式紀錄
					var subRecords = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getSubWoundRecordsByDate?app=" + formNo); 		
					//	    	
			    	getHoleList(subRecords.holeList);
				    getHandleList(subRecords.handleList);
			    }*/
			}
		});
	});
    //
    $(".uploadFile").change(function() {
		var recordTarget = $(".date-btn.active");
		var keyno = recordTarget.attr('data-formno');
		var date = recordTarget.html();
        var fileLeng = $(".uploadFile").get(0).files.length;
        if(fileLeng >0){
        	confirmCheck("<@spring.message "inspect.upload.confirm.title"/>", "<@spring.message "inspect.upload.confirm.text1"/>(" + date + ")\n<@spring.message "inspect.upload.confirm.text2"/>", "warning", "btn-info", "<@spring.message "inspect.button.confirm"/>", "<@spring.message "inspect.button.cancel"/>", function(confirmed){
				if(confirmed){
					uploadImage(keyno);
				}
				else{
					$(this).val("");
				}
			});
        }
    });
    //
    $.contextMenu({
    	selector: '.date-btn', 
        callback: function(key, opt) {
        	var targetLink = $(this);
        	if(key == "edit") editRecordDate(targetLink, opt);
        	if(key == "delete") deleteEvalRecord(targetLink, opt);
        },
        items: {
            "edit": {
            	name: "<@spring.message "inspect.right.menu.editDate"/>", icon: "edit"
	        },
            "delete": {
            	name: "<@spring.message "inspect.right.menu.delRecord"/>", icon: "delete"
            },
            "sep1": "---------",
            "quit": {name: "<@spring.message "inspect.right.menu.leave"/>", icon: function(){
                return 'context-menu-icon context-menu-icon-quit';
            }}
        }
    });
}

function initMenu(){
	$.contextMenu({
    	selector: '.item', 
        callback: function(key, opt) {
        	var targetLink = $(this);
        	if(key == "delete") deleteTestItem(targetLink, opt);
        	if(key == "add") addEvalRecord(targetLink, opt);
        },
        items: {
            "delete": {
            	name: "<@spring.message "inspect.right.menu.delItem"/>", icon: "delete"
            },
            "add":{
            	name: "<@spring.message "inspect.right.menu.addRecord"/>", icon: "add"
            },
            "sep1": "---------",
            "quit": {name: "<@spring.message "inspect.right.menu.leave"/>", icon: function(){
                return 'context-menu-icon context-menu-icon-quit';
            }}
        }
    });
}

function editRecordDate(link, menuOpt) {

	var keyno = link.data("formno");
  	var linkText = link.text();

  	swal({
  		title: "<@spring.message "inspect.right.menu.editDate"/>",
  		text: "<@spring.message "inspect.evaldate.edit.title"/>:",
  		type:"input",
  		inputValue: linkText,
  		showCancelButton: true,
	  	confirmButtonClass: "btn-info",
	  	confirmButtonText: "<@spring.message "inspect.button.confirm"/>",
	  	cancelButtonText: "<@spring.message "inspect.button.cancel"/>",
	  	closeOnConfirm: false
  	}, function(ans){
  		if(ans){
  			var postData = {"keyno": keyno, "evalDate": formatDate(ans)};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/resetEvalDate?location=${__field}");
			if(result.success){
				link.text(ans);
				refreshChart();
				menuOpt.$menu.trigger('contextmenu:hide');
				swal("<@spring.message "inspect.edit.success.title"/>", "<@spring.message "inspect.evaldate.edit.success.text"/> " + ans , "success");
			}			
  		}
  	});
  	
  	startDatePicker(".sweet-alert > .form-group > .form-control");

}

function addEvalRecord(link, menuOpt) {
	var app = link.data("keyno");
	var bodypart = link.data("bodypart");
	
  	swal({
  		title: "<@spring.message "inspect.right.menu.addRecord"/>",
  		text: "<@spring.message "inspect.item.selected.text"/>：" + bodypart + ",<@spring.message "inspect.add.evaldate.text"/>:",
  		type:"input",
  		inputValue: getTodate(),
  		showCancelButton: true,
	  	confirmButtonClass: "btn-info",
	  	confirmButtonText: "<@spring.message "inspect.button.confirm"/>",
	  	cancelButtonText: "<@spring.message "inspect.button.cancel"/>",
	  	closeOnConfirm: false
  	}, function(ans){
  		if(ans){
  			var postData = {"creatorId":${currentUser.id!""}, "formName": "檢測紀錄V2", "evalDate": formatDate(ans), "app": app, "items": []};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createUserForm?");
  			if(result.success){
				menuOpt.$menu.trigger('contextmenu:hide');
				swal("<@spring.message "inspect.add.success.title"/>", "<@spring.message "inspect.evaldate.selected.text"/>(" + ans + ")\n<@spring.message "inspect.addby.success.text"/> " + bodypart , "success");
			}			
  		}
  	});
  	
  	startDatePicker(".sweet-alert > .form-group > .form-control");

}

function deleteEvalRecord(link, menuOpt){
	var keyno = link.data("formno");
	confirmCheck("<@spring.message "inspect.delete.confirm.title"/>", "<@spring.message "inspect.record.delete.confirm.text"/>", "warning", "btn-danger", "<@spring.message "inspect.button.delete"/>", "<@spring.message "inspect.button.cancel"/>", function(confirmed){
		if(confirmed){			
			var postData = {"recordno": keyno, "useMark": false};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/delRecord?location=${__field}");
			if(result.success){
				menuOpt.$menu.trigger('contextmenu:hide');
				link.remove();
				if($(".date-list").find(".date-btn").length > 0){					
					var lastBtn = $(".date-list").find(".date-btn:last-child");
					if(!lastBtn.hasClass('active')) lastBtn.trigger('click');
				}else{
					$(".right-block").find(".exist-cnt").addClass("hidden").parent().find(".no-cnt").removeClass("hidden");
				}
				swal("<@spring.message "inspect.delete.success.title"/>", "<@spring.message "inspect.delete.success.text"/>", "success");				
			}
		}
	});
}

function deleteTestItem(link, menuOpt){
	var keyno = link.data("keyno");
	confirmCheck("<@spring.message "inspect.delete.confirm.title"/>", "<@spring.message "inspect.delete.confirm.text"/>", "warning", "btn-danger", "<@spring.message "inspect.button.delete"/>", "<@spring.message "inspect.button.cancel"/>", function(confirmed){
		if(confirmed){
			var postData = {"bodypartno": keyno, "useMark": false};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/delRecord?location=${__field}");
			if(result.success){
				menuOpt.$menu.trigger('contextmenu:hide');
				link.remove();
				$(".right-block").find(".exist-cnt").html("").addClass("hidden").parent().find(".no-cnt").removeClass("hidden");
				swal("<@spring.message "inspect.delete.success.title"/>", "<@spring.message "inspect.delete.success.text"/>", "success");
			}
		}
	});
}

//新增檢測項目與患部紀錄
function addItemRecord(){
	var itemNumArr;
	var itemArray;
	var postData;
	var deviceNo = $(".itemForm[data-item='697']").val();
	var bodyPart =  $(".itemForm[data-item='247']").val();
	
	var selectedDate = $(".eval-date").val();
	var evalDate = selectedDate;
	//
	if(deviceNo != "" && bodyPart!= "" && evalDate != ""){
		var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/checkItemAdded?app=${formId!""}&item=" + deviceNo + "&bodyPart=" + bodyPart + "&evalDate=" + evalDate + "&location=${__field}");
		if(result.success){
			if(result.exist){
				swal("<@spring.message "inspect.record.exist.title"/>", "<@spring.message "inspect.record.exist.text"/>", "warning");
			}
			else{
				if(result.error){
					swal("<@spring.message "inspect.add.fail.title"/>", "<@spring.message "inspect.add.fail.text"/>", "error");
				}
				else{
					swal("<@spring.message "inspect.add.success.title"/>", "<@spring.message "inspect.add.success.text"/>", "success");
					$("#myModal").modal('hide');
					showItemList();
				}
			}
		}
		else{
			itemNumArr = getItemNumArray("default-table", "itemForm");
			itemArray = getItemValue("itemForm", itemNumArr);
			postData = {"creatorId":${currentUser.id!""}, "formName": "檢測項目V2", "evalDate": formatDate(evalDate), "app": "${formId}", "items": itemArray};
			result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createUserForm?");
			if(result.success){
				swal("<@spring.message "inspect.add.success.title"/>", "<@spring.message "inspect.add.success.text"/>", "success");
				$("#myModal").modal('hide');
				showItemList();
			}
			else{
				swal("<@spring.message "inspect.add.fail.title"/>", "<@spring.message "inspect.add.fail.text"/>", "error");
			}
		}
	}
	else{
		swal("<@spring.message "inspect.add.fail.title"/>", "<@spring.message "inspect.add.fail.text.null"/>", "error");
	}	
}

//編輯儲存檢測項目與患部紀錄
function saveItemRecord(keyno){
	var deviceNo = $(".editItemForm[data-item='697']").val();
	var bodyPart = $(".editItemForm[data-item='247']").val();
	//
	if(deviceNo != "" && bodyPart!= ""){
		var itemNumArr = getItemNumArray("default-table", "editItemForm");
		var itemArray = getItemValue("editItemForm", itemNumArr);
		var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": keyno, "items": itemArray};
		var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/editUserForm?");
		if(result.success){			
			swal("<@spring.message "inspect.edit.success.title"/>", "<@spring.message "inspect.edit.success.text"/>", "success");
			$("#myModal2").modal('hide');
			showItemList();
		}
	}
	else{
		swal("<@spring.message "inspect.edit.fail.title"/>", "<@spring.message "inspect.edit.fail.text"/>", "error");
	}	
}

//清除設定資料
function cleanData(obj){
	var target = $(obj).closest("tr");
	if(target.hasClass('hole-fixed-column')){
		target.find("select, input[type='text']").val("");
	}
	else{
		target.find('select').val("").trigger('change');
		target.find("input[type='text']:not(.other-content)").val("");
	}
}

//編輯潛行深洞
function editHole(obj){
	var tds = $(obj).closest("tr").children();	
   	$.each(tds, function(i,content){
   		var target = $(content).find("span");
   		var data = target.text();
   		switch(i){
   			case 0:
   				var status = data === "<@spring.message "inspect.option.non.healing"/>" ? "N" : "Y";
	   			target.hide().after('<select data-item="298"><option value="N"><@spring.message "inspect.option.non.healing"/></option><option value="Y"><@spring.message "inspect.option.healing"/></option></select>');
	   			$(content).find("select:eq(0)").val(status);
	   			break;
   			case 1:
   				target.hide().after('<input type="text" data-item="299" value="' + data + '" />');
   				break;
			case 2:
				target.hide().after('<input type="text" data-item="300" value="' + data + '" />');
				break;
   		}		
   	});
   	$(obj).addClass("hidden").nextAll().slice(0, 2).removeClass("hidden");
}

//編輯處置方式
function editHandleInfo(obj){
	var tds = $(obj).closest("tr").children();	
   	$.each(tds, function(i,content){
   		var target = $(content).find("span");
   		var data = target.text();
   		switch(i){
   			case 0:
   				var method = methodTemp();
	   			target.hide().after(method);
	   			fillHandleInfo(content , data);	   			
	   			break;
   			case 1:
   				var other = otherTemp();
				target.hide().after(other);
				fillHandleInfo(content , data);
				break;
			case 2:
				var size = sizeTemp();
				target.hide().after(size);
				$(content).find("select:eq(0)").val(data);
				break;
			case 3:
				target.hide().after('<input type="text" data-item="501" value="' + data + '" />');
				break;
			case 4:
				var times = timesTemp();
				target.hide().after(times);
				fillHandleInfo(content , data);
				break;
   		}
   			
   	});
   	//
   	$(obj).closest("tr").find(".menu").change(function(){
		var obj = $(this).next("input[type='text']");
		if($(this).val() == "<@spring.message "inspect.option.other"/>"){
			obj.removeClass("hidden");
		}
		else{
			obj.val("<@spring.message "inspect.option.other"/>").trigger("keyup").val("").addClass("hidden");
		}
	});
	//
   	$(obj).closest("tr").find(".other-content").keyup(function(){
		var length = $(this).prev("select").has("optgroup").length;
		if(length > 0){
			$(this).prev("select").find("optgroup[label='<@spring.message "inspect.optgroup.other"/>'] > option:eq(0)").val($(this).val());
		}else{
			$(this).prev("select").find("option:last-child").val($(this).val());
		}
	});
   	$(obj).addClass("hidden").nextAll().slice(0, 2).removeClass("hidden");
}

//針對現有處置紀錄判斷是否填值為其他，若是則進行變動
function fillHandleInfo(obj, data){
	var target = $(obj).find("select:eq(0)");
	if($(obj).find("select:eq(0) option[value='" + data + "']").length == 0){
		target.val("<@spring.message "inspect.option.other"/>");
		target.next("input[type='text']").val(data).removeClass("hidden");
	}
	else{
		target.val(data);
	}
}

//取消編輯潛行深洞/傷口處置紀錄
function cancelEdit(obj){
	var tds = $(obj).closest("tr").children();	
   	$.each(tds, function(i,content){
   		$(content).find("span").show();
   		$(content).find("input[type='text'], select").remove();		
   	});
   	$(obj).addClass("hidden").prev().addClass("hidden").prev().removeClass("hidden");
}

//刪除潛行深洞或醫囑處置
function delRecord(obj, formName){
	var evalForm = formName == "潛行深洞V2" ? 8 : 10;
	var alertText = formName == "潛行深洞V2" ? "<@spring.message "inspect.undermining.delete.confirm.text"/>\n<@spring.message "inspect.delete.confirm.text"/>" : "<@spring.message "inspect.plan.delete.confirm.text"/>\n<@spring.message "inspect.delete.confirm.text"/>";
	
	confirmCheck("<@spring.message "inspect.delete.confirm.title"/>", alertText, "warning", "btn-danger", "<@spring.message "inspect.button.delete"/>", "<@spring.message "inspect.button.cancel"/>", function(confirmed){
		if(confirmed){
			var recordTarget = $(".collapse-content.active");
			var app = recordTarget.attr('data-recordno');
			var keyNo = $(obj).attr("data-id");
			var postData = {"userFormKeyNo": keyNo};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/removeUserForm?");
		    if(result.success){
		    	var subRecords = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getSubWoundRecordsByDate?app=" + app);
				if(formName == "潛行深洞V2"){
					getHoleList(subRecords.holeList);
				}
				else{
					getHandleList(subRecords.handleList);
				}
				swal("<@spring.message "inspect.delete.success.title"/>", "<@spring.message "inspect.delete.success.text"/>", "success");
		    }
		}
	});
	
}

//新增潛行深洞或醫囑處置
function addRecord(obj, fillNum, start, end, formName){
	var evalForm = formName == "潛行深洞V2" ? 8 : 10;
	var recordTarget = $(".collapse-content.active");
	var app = recordTarget.attr('data-recordno');
	var evalDate = recordTarget.attr('data-evaldate');	
	var itemArray = createFormValue(obj, start, end);
	if(itemArray.length >= fillNum){	
		var postData = {"creatorId":${currentUser.id!""}, "formName": formName, "evalDate": formatDate(evalDate), "app": app, "items": itemArray};
		var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createUserForm?");
		if(result.success){
			$("thead").find("input[type='text']").val("");
			var subRecords = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getSubWoundRecordsByDate?app=" + app);
			if(formName == "潛行深洞V2"){
				getHoleList(subRecords.holeList);
			}
			else{
				getHandleList(subRecords.handleList);
			}
			cleanData(obj);
		}
	}
	else{
		swal("<@spring.message "inspect.add.fail.title"/>","<@spring.message "inspect.add.fail.text.incomplete"/>","error");
	}
}

//儲存潛行深洞與處置方式
function saveRecord(obj, fillNum, start, end, formName){
	var evalForm = formName == "潛行深洞V2" ? 8 : 10;
	var recordTarget = $(".collapse-content.active");
	var app = recordTarget.attr('data-recordno');
	var keyNo = $(obj).attr("data-id");
	var itemArray = getFormValue(obj, "e", start, end);
	if(itemArray.length >= fillNum){	
		var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": keyNo, "items": itemArray};
		var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/editUserForm?");	
		if(result.success){
			var subRecords = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getSubWoundRecordsByDate?app=" + app);
			if(formName == "潛行深洞V2"){
				getHoleList(subRecords.holeList);
			}
			else{
				getHandleList(subRecords.handleList);
			}
		}
	}
	else{
		swal("<@spring.message "inspect.data.incomplete.title"/>","<@spring.message "inspect.data.incomplete.text"/>","warning");
	}
}

//取得傷口表單內的潛行深洞資訊
function getHoleList(result){
	var columnObj = [
		{ data: "closeCase",
			render: function ( data, type, row, meta ) {
				return row.closeCase === "Y" ? "<span><@spring.message "inspect.option.healing"/></span>" : "<span><@spring.message "inspect.option.non.healing"/></span>";
			} 
		},
        { data: "direction",
        	render: function ( data, type, row, meta ) {
				return "<span>" + row.direction + "</span>" + " <@spring.message "inspect.label.clock"/>";
			}      	
        },
        { data: "depth",
        	render: function ( data, type, row, meta ) {
				return "<span>" + row.depth + "</span>" + " <@spring.message "inspect.label.centimeter"/>";
			}       	
        },
        { data: "keyno",
        	render: function ( data, type, row, meta ) {
        		return "<div class='edit-group'><input type='button' value='<@spring.message "inspect.button.edit"/>' onclick='editHole(this)' /> <input type='button' class='hidden' value='<@spring.message "inspect.button.finish"/>' data-id='" + row.keyno + "' onclick='saveRecord(this,3,298,300,\"潛行深洞V2\")' /> <input type='button' class='hidden' value='<@spring.message "inspect.button.cancel"/>' onclick='cancelEdit(this)' /> <input type='button' value='<@spring.message "inspect.button.delete"/>' data-id='" + row.keyno + "' onclick='delRecord(this,\"潛行深洞V2\")' /></div>";
        	}
        }
	];
	createDataTable('.collapse-content.active table.hole-table', 10, result, columnObj, page_info);
}

//取得傷口表單內的處置資訊
function getHandleList(result){
	var columnObj = [
		{ data: "method",
        	render: function ( data, type, row, meta ) {
				return "<span>" + row.method + "</span>";
			}      	
        },
        { data: "otherMethod",
        	render: function ( data, type, row, meta ) {
				return "<span>" + row.otherMethod + "</span>";
			}      	
        },
        { data: "size",
        	render: function ( data, type, row, meta ) {
				return "<span>" + row.size + "</span>";
			}      	
        },
        { data: "quantity",
        	render: function ( data, type, row, meta ) {
				return "<span>" + row.quantity + "</span>";
			}      	
        },
        { data: "frequency",
        	render: function ( data, type, row, meta ) {
				return "<span>" + row.frequency + "</span>";
			}      	
        },
        { data: "keyno",
        	render: function ( data, type, row, meta ) {
        		return "<div class='edit-group'><input type='button' value='<@spring.message "inspect.button.edit"/>' onclick='editHandleInfo(this)' /> <input type='button' class='hidden' value='<@spring.message "inspect.button.finish"/>' data-id='" + row.keyno + "' onclick='saveRecord(this,2,498,502,\"處置方式V2\")' /> <input type='button' class='hidden' value='<@spring.message "inspect.button.cancel"/>' onclick='cancelEdit(this)' /> <input type='button' value='<@spring.message "inspect.button.delete"/>' data-id='" + row.keyno + "' onclick='delRecord(this,\"處置方式V2\")' /></div>";
        	}
        }
	];
	createDataTable('.collapse-content.active table.handle-table', 10, result, columnObj, page_info);
}

//設置紀錄最新編輯時間
function setUpdateInfo(info){
	
	var recordTarget = $(".collapse-content.active");

	$(".update-text").html(info).click(function(){
		var keyNo = recordTarget.data("recordno");		
		var apiUrl = "${base}/division/api/queryLog?keyNo=" + keyNo;
		window.open(apiUrl, "_bank", config='top=0,left=0,height=2500,width=5000,location=no,menubar=no');
	});
	
}

//選擇本地(local端)上傳圖檔連結
function upload(){
	$(".uploadFile").click();
}


//圖檔匯出功能
function imgZipExport(){
	window.open("${base}/division/api/downloadImageZip?formKeyNo=${formId!""}&zipName=IMGEXPORT&location=${__field}");
}

//預覽下載檢測報告內容(僅可指定其中一天)
function loadReport(){
	var bodyPartTarget = $(".item-list").find(".active");
	var formTarget = $(".date-btn.active");
	var bodyPartNo = bodyPartTarget.data("keyno");
	var deviceNo = bodyPartTarget.data("item");
	var formNo = formTarget.data("formno");
	var date = formTarget.html();		
	
	if("${patientNo}" != ""){
		var entry = getEntry(deviceNo);
		var reportUrl = "${base}/${__lang}/division/web/report/result/print/${formId!""}/evalDate/" + date;
		//var reportUrl = "${base}/division/api/" + entry + "?patientNo=${patientNo}&bodyPartNo=" + bodyPartNo + "&formNo=" + formNo + "&showDate=" + date;
		window.open(reportUrl, "_bank", config='top=0,left=0,height=2500,width=5000,location=no,menubar=no');
	}
	else{
		swal("<@spring.message "inspect.report.export.fail.title"/>", "<@spring.message "inspect.report.export.fail.text"/>", "error");
	}
}

//取得報告輸出API名稱
function getEntry(deviceNo){
	var entry = "";
	deviceNo = parseInt(deviceNo);
	switch(deviceNo){
		case 1:
			entry = 'printFundusReport';
			break;
		case 2:
			entry = 'printReport';
			break;
		case 3:
			entry = 'printEchoReport';
			break;
		case 4:
			entry = 'printEKGReport';
			break;
		case 5:
			entry = 'printFVCReport';
			break;
		case 6:
			entry = 'printOtoscopeReport';
			break;
		case 7:
			entry = 'printAudiometersReport';
			break;
	}
	return entry;
}

function showPhysicalChart(){
	$(".chart-tab").click(function () {
		$(".cnt-template").find(".func.collapse.in").collapse("hide");
	});
	//	
	$('#myModal18').modal('show');
	//
	cleanDataTables();
	//
	var physicalMeasureInfo = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getPhysiDataList?userFormKeyno=${formId!""}");
	getPhysicalChart(physicalMeasureInfo.data, '');

}

//取得個案所有生理量測歷程圖
function getPhysicalChart(dataArr, showDate){
	var evalDate = [];
	var arrMix = [];
	var arrPressure = [];
	var arrTemp = [];
	var arrBpm = [];
	var arrDbp = [];
	var arrSbp = [];
	
	for(var i=dataArr.length-1; i>=0; i--){
		evalDate.push(dataArr[i].evalDate);
		arrTemp.push(dataArr[i].temp);
		arrBpm.push(dataArr[i].bpm);
		arrSbp.push(dataArr[i].sbp);
		arrDbp.push(dataArr[i].dbp);		
	}
	/*
	for(var i=0; i<dataArr.length; i++){
		evalDate.push(dataArr[i].evalDate);
		arrTemp.push(dataArr[i].temp);
		arrBpm.push(dataArr[i].bpm);
		arrDbp.push(dataArr[i].dbp);
		arrSbp.push(dataArr[i].sbp);
	}*/
	
	arrMix.push(arrTemp);
	arrMix.push(arrBpm);
	arrMix.push(arrDbp);
	arrMix.push(arrSbp);
	
	arrPressure.push(arrDbp);
	arrPressure.push(arrSbp);
	//
	renderMixChart('mixChart', showDate, evalDate, arrMix);
	//renderTempChart("tempChart", showDate, evalDate, arrTemp, zh_chart.physicalIdx);
	//renderBpmChart("bpmChart", showDate, evalDate, arrBpm, zh_chart.physicalIdx);
	//renderPressureChart("pressureChart", showDate, evalDate, arrPressure, zh_chart.physicalIdx);
	getPhysicalDataList(dataArr);
	
	setTimeout(function(){
		$(".show-hint").addClass('hidden');
		$(".cnt-template").removeClass('hidden');
	},2000);
	
}

//產生綜合歷程圖
function renderMixChart(className, showDate, evalDate, arrData){
	$("." + className).remove();
	$(".mixChart-blk").prepend("<canvas width='700' height='280' class='mixChart'></canvas>");
	var unit = "<@spring.message "inspect.label.physiological.measurement.trends"/>";
	var evalDateLeng = evalDate.length - 1;
	
	var config = {
		type: 'line',
		data: {
			labels: evalDate,
			datasets: [{
				yAxisID: "y",
				label: "<@spring.message "inspect.label.chart.temperature"/>",
				backgroundColor: colors.blue.stroke,
				borderColor: colors.blue.stroke,
				data: arrData[0],
				fill: false,
      			datalabels: {
        			align: '400',
        			anchor: 'end',
        			offset: 10
      			}
			},{
				yAxisID: "y2",
				label: "<@spring.message "inspect.label.chart.bpm"/>",
				backgroundColor: colors.red.stroke,
				borderColor: colors.red.stroke,
				data: arrData[1],
				fill: false,
      			datalabels: {
        			align: '400',
        			anchor: 'end',
        			offset: 8
      			}
			},{
				yAxisID: "y1",
				label: "<@spring.message "inspect.label.chart.dbp"/>",
				backgroundColor: colors.green.stroke,
				borderColor: colors.green.stroke,
				data: arrData[2],
				fill: false,
      			datalabels: {
        			align: '360',
        			anchor: 'start',
        			offset: 8
      			}
			},{
				yAxisID: "y1",
				label: "<@spring.message "inspect.label.chart.sbp"/>",
				backgroundColor: colors.orange.stroke,
				borderColor: colors.orange.stroke,
				data: arrData[3],
				fill: false,
      			datalabels: {
        			align: '360',
        			anchor: 'start',
        			offset: 8
      			}
			}]
		},
		options: {
			clip: false,
			plugins:{
				responsive: true,
				legend: {
					position: 'top'
				},
				autocolors: false,				
				tooltip: {
		            callbacks: {
		                label: function(context) {
		                    var label = context.dataset.label || '';
	
		                    if (label) {
		                        label += ': ';
		                    }
		                    
		                    if (context.parsed.y !== null) {
		                    	label += context.parsed.y + " <@spring.message "exam.status.label.celsius.unit"/>";
	                    	}
		                    return label;
		                },
		                title: function (item) {
							return "<@spring.message "inspect.label.evalDate"/>" + item[0].label
						}
		            }
		        },
		        datalabels: {
		        	backgroundColor: function(context) {
			          	return context.dataset.backgroundColor;
			        },
		          	borderRadius: 3,
			        color: 'white',
			        font: {
			          	weight: 'bold'
			        },
			        formatter: function(value, context) {
			        	var formatValue = "";
			        	if(context.datasetIndex != 0){
			        		formatValue = Math.round(value);
			        	}
						else{
							formatValue = value;
						}
					  	return formatValue;
					},
			        padding: 4
		        }
			},
			scales: {
				x: {
					gridLines: {display: true}
				},
				y: {
					gridLines: {display: true},
					ticks: {
						stepSize: 1,
						padding: 10
					},
					min: 35,
					max: 42
				},
				y1: {
					gridLines: {display: true},
					ticks: {
						stepSize: 20,
						padding: 10
					},
					min: 40,
					max: 180
				},
				y2: {
					gridLines: {display: true},
					ticks: {
						stepSize: 10,
						padding: 10
					},
					min: 30,
					max: 100
				}
			}		
		},
		plugins: [ChartDataLabels,{
		    afterDraw(chart, args, options){      
		      	var {ctx, chartArea: {top, left}, scales:{x,y} } = chart;
				ctx.save();
				ctx.font = '12px Arial';
				ctx.fillStyle = '#000';
				/*ctx.fillText('R.', 5, top-15);
				ctx.fillText('P.', 37, top-15);
				ctx.fillText('T.', 67, top-15);*/
				ctx.fillText('R.', 12, top-15);
				ctx.fillText('P.', 58, top-15);
				ctx.fillText('T.', 102, top-15);
				ctx.restore();  
		    }
	  	},{
		    beforeInit: function(chart, options) {
		      	var originalFit = chart.legend.fit;
			    chart.legend.fit = function fit() {		      
			      	originalFit.bind(chart.legend)();
			      	this.height += 10;
			    }
		    }
	  	}]
	};
	
	return new Chart(document.getElementsByClassName(className)[0], config);
}

//取得所有生理量測列表
function getPhysicalDataList(objData){
	var mixColumnObj = [
		{ data: "evalDate" },
		{ data: "temp",
        	render: function ( data, type, row, meta ) {
        		var sign = "";
        		if(row.temp != "--"){
        			var status = row.temp >= 35.5 && row.temp <= 37.5 ? "fa-check-circle" : "fa-exclamation-circle blink";
        			var txt = row.temp >= 35.5 && row.temp <= 37.5 ? "<@spring.message "inspect.label.temperature.normal"/>" : "<@spring.message "inspect.label.temperature.abnormal"/>";
        			sign = "<span class='alertCnt'><i class='fa " + status + " fa-lg' ></i></span>";
        		}
        		return row.temp + sign;
        	}
        },
        { data: "bpm",
        	render: function ( data, type, row, meta ) {
        		var sign = "";
        		if(row.bpm != "--"){
        			var status = row.bpm >= 60 && row.bpm <= 100 ? "fa-check-circle" : "fa-exclamation-circle blink";
        			var txt = row.bpm >= 60 && row.bpm <= 100 ? "<@spring.message "inspect.label.heartrate.normal"/>" : "<@spring.message "inspect.label.heartrate.abnormal"/>";
        			sign = "<span class='alertCnt'><i class='fa " + status + " fa-lg' ></i></span>";
        		}
        		return row.bpm + sign;
        	}
        },
        { data: "sbp",
        	render: function ( data, type, row, meta ) {
        		var sign = "";
        		if(row.sbp != "--"){
        			var status = row.sbp >= 80 && row.sbp <= 140 ? "fa-check-circle" : "fa-exclamation-circle blink";
        			sign = "<span class='alertCnt'><i class='fa " + status + " fa-lg' ></i></span>";
        		}
        		return row.sbp + sign;
        	}
        },
        { data: "dbp",
        	render: function ( data, type, row, meta ) {
        		var sign = "";
        		if(row.dbp != "--"){
        			var status = row.dbp >= 60 && row.dbp <= 80 ? "fa-check-circle" : "fa-exclamation-circle blink";
        			sign = "<span class='alertCnt'><i class='fa " + status + " fa-lg' ></i></span>";
        		}
        		return row.dbp + sign;
        	}
        }
	];

	var tempColumnObj = [
		{ data: "evalDate" },
        { data: "temp" },
        { data: null,
        	render: function ( data, type, row, meta ) {
        		var sign = "";
        		if(row.temp != "--"){
        			var status = row.temp >= 35.5 && row.temp <= 37.5 ? "fa-check-circle" : "fa-exclamation-circle blink";
        			var txt = row.temp >= 35.5 && row.temp <= 37.5 ? "<@spring.message "inspect.label.temperature.normal"/>" : "<@spring.message "inspect.label.temperature.abnormal"/>";
        			sign = "<span class='alertCnt'><i class='fa " + status + " fa-lg' ></i> " + txt + "</span>";
        		}
        		return sign;
        	}
        }
	];
	
	var bpmColumnObj = [
        { data: "evalDate" },
        { data: "bpm" },
        { data: null,
        	render: function ( data, type, row, meta ) {
        		var sign = "";
        		if(row.bpm != "--"){
        			var status = row.bpm >= 60 && row.bpm <= 100 ? "fa-check-circle" : "fa-exclamation-circle blink";
        			var txt = row.bpm >= 60 && row.bpm <= 100 ? "<@spring.message "inspect.label.heartrate.normal"/>" : "<@spring.message "inspect.label.heartrate.normal"/>";
        			sign = "<span class='alertCnt'><i class='fa " + status + " fa-lg' ></i> " + txt + "</span>";
        		}
        		return sign;
        	}
        }
	];
	
	var pressureColumnObj = [
        { data: "evalDate" },
        { data: "sbp" },
        { data: "dbp" },
        { data: null,
        	render: function ( data, type, row, meta ) {
        		var sign = "";
        		if(row.sbp != "--"){
        			var status = row.sbp <= 120 && row.dbp <= 80 ? "fa-check-circle" : "fa-exclamation-circle blink";
        			sign = "<span class='alertCnt'><i class='fa " + status + " fa-lg' ></i></span>";
        		}
        		return sign;
        	}
        }
	];
	
	createDataTable('.mix-list', 5, objData, mixColumnObj, page_info);
	
    //createDataTable('.temp-list', 5, objData, tempColumnObj, page_info);
	//createDataTable('.bpm-list', 5, objData, bpmColumnObj, page_info);
	//createDataTable('.pressure-list', 5, objData, pressureColumnObj, page_info);
	
}

//數據或本地圖檔上傳更新後，趨勢圖須翻新
function refreshChart(){
	var target = $(".item-list").find(".active");
	var deviceNo = target.data("item");
	var app = target.data("keyno");
	$(".chart-container").find("canvas").remove();
	$(".chart-container").append("<canvas id='resultChart' width='800' height='400' ></canvas>");
	if(deviceNo == 1){
		$(".switchBtn").val("<@spring.message "inspect.button.switch.wound.prop"/>");
	}
	createNewChart(deviceNo, app);
}

//新增醫囑圖至聊天室群組
function sendImgToGroup(){
	var target = $(".item-list").find(".active");
	var evalDate = $(".date-btn.active").html();
	var device = target.data("device");
	var bodypart = target.data("bodypart");

	html2canvas(document.querySelector("#capture"), {
	  onclone: function (content) {
	  	
	  },
	  scrollX: 0,
      scrollY: 0
	  //scrollY: -window.scrollY
	}).then(function(canvas) {
		$.ajax({
		    type: "POST",
		    url: "http://localhost:8080/WebSocket/chatroom/uploadNewFile",
		    data: {
				orderImg : canvas.toDataURL().replace("data:image/png;base64,", ""),
		        orderImgName: evalDate + "_" + device + "_" + bodypart + "_<@spring.message "inspect.button.orderChart"/>.png",
		        sendTime: new Date().getTime(),
		        room: ${sendingRoomId!""},
		        from: ${sendingUserId!""},
		        type: 2
		    },
		    dataType: "json",
		    
		    success: function(data){
		       if(data.data.success){
		       	  swal("<@spring.message "inspect.img.import.success.title"/>", "<@spring.message "inspect.img.import.success.text"/>", "success");
		       }                    	            	            
		    },
		    error: function(){
		    	swal("<@spring.message "inspect.img.import.fail.title"/>", "<@spring.message "inspect.img.import.fail.text"/>", "error");
		    }
		});
    });
}

//重置標註圖功能
function reZoomMark(){
	$('.mark-funclist').ZoomMark('destroy');
}

//執行醫囑圖標註
function exportImg(){
	var width = 0;
	var height = 0;
	var queryData = {"userFormKeyNo": $(".date-btn.active").data("formno")};
	var result = wg.evalForm.getJson({"data":JSON.stringify(queryData)}, "${base}/division/api/qryColorImages");
	var markImg = "${base}" + result.firstImg.url;
	
	var target = new Image();
	target.onload = function(){

		if(target.width <= 600 && target.height <= 600){
			width = target.width;
			height = target.height;
		}
		else if(target.width > 600 && target.height > 600){
			if(target.width > target.height){
				width = 500;
				height = (target.height / target.width ) * 500;
			}
			else{
				width = (target.width / target.height) * 500;
				height = 500;
			}
		}
		else{
			if(target.width > 600){
				width = 500;
				height = (target.height / target.width) * 500;
			}
			else{
				width = (target.width / target.height) * 500;
				height = 500;
			}
		}
		
		$(".markImg").attr('src', markImg).attr('width', width).attr('height', height);
	};
	target.src = "${base}" + result.firstImg.url;
	
    
    $('.mark-funclist').ZoomMark({
       'markList':[],
	   'markColor':'blue',
	   'afterMark':addRowToTabel
    });
    $('.radioItem').change(function(){
		$('.mark-funclist').ZoomMark('changeSettings',{
			'markColor':$('.colorSelect').find('input:checked').attr('markColor')
		});
	});
	
	$(".reset").click(function(){
		$('.mark-funclist').ZoomMark('reset');
	});
	$(".rotate").click(function(){
		angle = angle+90 >=360 ? 0:angle+90;
		$('.mark-funclist').ZoomMark('rotate',angle);
	})
	//
	$(".phrase").select2({
        language: '${__lang}',
        width: '100%',
        maximumInputLength: 10,
        minimumInputLength: 0,
        placeholder: '<@spring.message "inspect.placeholder.phrase"/>',
        dropdownParent: $('#myModal7'),
        allowClear: true,
        ajax: {
            url: '${base}/division/api/qryPhraseItems',
            type: 'POST',
            data: function (params){
                return {
                	userId: ${currentUser.id!""},
                    code: params.term 
                };
            },
            processResults: function (data, params){
 				var obj = JSON.parse(data);

                return {
                    results: obj.data,
                    pagination: {
                        more: false
                    }
                }
            }
        }
    }).on("select2:select", function(e) {
    	var phrase = $(this).find("option").last().html();
    	var insertPhrase = phrase.split("] ")[1];
 		insertAfterCursor($(".form-group textarea"), insertPhrase);
 		$(this).find("option").remove().trigger('change');
 	});
       
    $("#myModal10").modal('show');
}

function copyNote(id){
	var txtTarget = $(".form-group textarea");
	var txt = txtTarget.val();	
	$("#row_" + id).find(".command").val(txt);
	$("textarea[name='content']").val("");
	$("#myModal7").modal('hide');
}

function addRowToTabel(marks){
	var html = '<tr id="row_' + marks[marks.length-1].id + '"><td><span class="colorSpan" style="background-color:' + marks[marks.length-1].color + '">' + ($('.marksTable').find('tbody').find('tr').length + 1)+'</span></td>' +
	           '<td><div class="command-area"><textarea class="command"></textarea><span data-toggle="modal" onclick="writeNote(' + marks[marks.length-1].id + ')" href="#myModal7"></span></div></td>' + 
	           '<td><img class="deleteMark" src="${base}/images/woundInfo/delete.png" onclick="deleteMark(' + marks[marks.length-1].id + ')"></td></tr>';
	$('.marksTable').find('tbody').append(html);	
}

function writeNote(id){
	
	$(".phrase-into").attr("onClick", "copyNote(" + id + ")");
}

function deleteMark(id){
	$('.mark-funclist').ZoomMark('deleteMark',id);

	$('#row_'+id).remove();
	updateTableId();
}

function updateTableId(){
	$('.marksTable').find('tbody').find('.colorSpan').each(function(index,value){
		$(this).html(index+1);
	})
}

//進入個案群組討論
function enterChatGroup(){
	<#if sendingRoomId?exists && sendingRoomId?has_content>
	window.open("${base}/${__lang}/division/web/communication/chatroom/${sendingRoomId!""}");
	<#else>
	window.open("${base}/${__lang}/division/web/communication/chatroom");
	</#if>
}

//展示圖庫
function showGallery(formno, evalDate){
	var imgTemp = "";
	var target = $(".date-btn.active");
	var equipNo = $(".item-list").find(".active").data("item");

	//var formNo = $(".item-list").find(".active").data("keyno");
	//var formNo = target.data("formno");
	var plugin = "";
	var el = document.getElementById("img-list");
	var queryData = {"userFormKeyNo": formno, "isSingleForm" : false, "evalDate" : evalDate, "equipNo": equipNo};	
	var result = wg.evalForm.getJson({"data":JSON.stringify(queryData)}, "${base}/division/api/qryImages");
	
	if(result.success){
		var imgData = result.images;
				
		if(imgData.length > 0){
			showHintSwal("<@spring.message "inspect.img.open.waiting"/>");
			
			for(var i=0; i<imgData.length; i++){
				var date = imgData[i].evalDate;
				var width = returnValue(imgData[i].widthPixel);
				var height = returnValue(imgData[i].heightPixel);
				var estimatedWidth = returnValue(imgData[i].width);
				var estimatedHeight = returnValue(imgData[i].height);
				var estimatedArea = returnValue(imgData[i].area);
				var depth = returnValue(imgData[i].depth);
				var distance = returnValue(imgData[i].distance);
				var proportion = returnValue(imgData[i].epithelium) + "," + returnValue(imgData[i].granular) + "," + returnValue(imgData[i].slough) + "," + returnValue(imgData[i].eschar);		
				
				var photographerInfo = "<table class='photographer-info'><tbody><tr><td rowspan='2' class='photographer-" + imgData[i].creatorRole + "'></td>														" +
				 			  		   "<td class='photographer'>" + imgData[i].photographer + "</td></tr><tr><td>" + imgData[i].photoTime + " <@spring.message "inspect.label.uploaded"/></td></tr></tbody></table>" ;
				
				var photoInfo = "<table class='photo-info old' data-imgId='" + imgData[i].id + "' data-evalDate='" + imgData[i].evalDate + "'>" +
								"<tbody>" + imgData[i].tag + "</tbody></table>																  " ;
				
				imgTemp += '<li data-thumb="${base}' + imgData[i].url + '&q=128" data-src="${base}' + imgData[i].url + '"											' + 
						   'data-target="' + imgData[i].id + '" data-itemId="' + imgData[i].itemId + '" 															' +						   
						   'data-sub-html="' + photographerInfo + photoInfo + '"																					' +
						   'data-name="' + imgData[i].fileName + '" title="' + imgData[i].fileName + ' (' + date + '<@spring.message "inspect.label.uploaded"/>)">	' +  
						   '	<img src="${base}' + imgData[i].url + '" />                                                								   			' +
						   '</li>                                                                                          											' ;
			}
			$("#img-list").html("").append(imgTemp);
		
			setTimeout(function(){
				plugin = lightGallery(el,{
					selector: 'li',
					appendSubHtmlTo: '.lg-outer',
					plugins:[lgZoom, lgThumbnail]
				});
				
				$("#img-list").find("li").first().click();
				
				if(target.data("formno") != formno){
					$(".date-list").find(".date-btn[data-formno='" + formno + "']").trigger('click');
				}
				swal.close();
			},200);
		}
		else{
			if(target.data("formno") != formno){
				$(".date-list").find(".date-btn[data-formno='" + formno + "']").trigger('click');
			}
			
			confirmCheck("<@spring.message "inspect.img.view.fail.title"/>", "<@spring.message "inspect.img.view.fail.text"/>\n<@spring.message "inspect.img.upload.check.text"/>(" + evalDate + ")?", "warning", "btn-info", "<@spring.message "inspect.button.confirm"/>", "<@spring.message "inspect.button.cancel"/>", function(confirmed){
				if(confirmed){
					swal.close();
					upload();
				}
			});
		}
		
		if(!openImgItem){
			//擴充初始化添加刪除按鈕
			el.addEventListener('lgInit', function(event){
				plugin = event.detail.instance;
				var deleteBtn = '<span id="lg-delete" class="fa fa-trash-can lg-icon"><span>';
				//var analyzeBtn = '<span id="lg-analyze" style="display:inline" class="fa fa-brain lg-icon"></span>';
				var shareImgBtn = '<span id="lg-shareImg" style="display:inline" class="fa fa-share-from-square lg-icon" onclick="shareImg()"></span>';
				
				if($("#lg-delete").length <= 0){
					plugin.outer.find('.lg-toolbar').append(shareImgBtn).append(analyzeBtn).append(deleteBtn);
				}
				
				plugin.outer.find("#lg-delete").on("click", () => {
			      	console.log("執行刪除影像");
			      	var updateIdx = 0;
			      	var imgList = $("#img-list");
			      	var currentImage = $(".lg-thumb-item.active");
					var currentIdx = currentImage.attr("data-lg-item-id");
					var currentFormNo = $(".info-btn.customed.active").attr("data-formno");
					var currentAnsId = imgList.find("li:eq(" + currentIdx + ")").attr("data-target");
					
					var galleryItems = JSON.parse(
				        JSON.stringify(plugin.galleryItems),
				    );
				    
				    confirmCheck("<@spring.message "inspect.img.delete.title"/>", "<@spring.message "inspect.img.delete.confirm.text"/>\n<@spring.message "inspect.img.delete.irrecoverable.text"/>", "warning", "btn-info", "<@spring.message "inspect.button.confirm"/>", "<@spring.message "inspect.button.cancel"/>", function(confirmed){
						if(confirmed){
							//刪除指定影像
							var postData = {"userFormKeyNo": currentFormNo, "ansId": currentAnsId};
							var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/delImages?location=${__field}");
						    if(result.success){
						    	imgList.find("li:eq(" + currentIdx + ")").remove();
							    galleryItems.splice(currentIdx, 1);
							    plugin.updateSlides(galleryItems, 0);
							    
							    if(imgList.find("li").length <= 0) refreshChart();
							    
							    swal("<@spring.message "inspect.img.delete.success.title"/>", "<@spring.message "inspect.img.delete.success.text"/>", "success");						    	
						    }else{
						    	swal("<@spring.message "inspect.img.delete.fail.title"/>", "<@spring.message "inspect.img.delete.fail.text"/>", "error");
						    }
						}
					});
				
			    });
			    
			    //
			    
			    plugin.outer.find("#lg-analyze").on("click", () => {
			    	$("#img-list").trigger('lgSubHtmlUpdate', {
					  	index: 0,
					  	subHtml: '<div>New subHtml content</div>'
					});
			    });
			});
			
			//擴充初始化後添加備註內容
			el.addEventListener('lgAfterAppendSubHtml', function(e){
		
			  	$(".photo-info").find(".tab-func").click(function () {
					$(".photo-info").find(".func.collapse.in").collapse("hide");
				});
				//
				$(".photo-info").find(".btn").click(function(){
					btnTarget = $(".photo-info").find(".btn").not(".unselect");
					var item = btnTarget.data("item");
					btnTarget.toggleClass("unselect");
					if($(this).data("item") != item){
						$(this).toggleClass("unselect");
					}
					
					var info = $(this).closest("table.photo-info");
					var imgId = info.data("imgId");
					var bodypartId = $(this).data("item");
					var evalDate = info.data("evaldate");
					var postData = {"app": "${formId!""}", "imgId": imgId, "bodypartId": bodypartId, "evalDate": evalDate, "modifierId": ${currentUser.id!""}};	
			    	var data = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/setArchiveBodypartInfo");
				    if(data.success){
				    	swal("<@spring.message "inspect.img.archive.success.title"/>", "<@spring.message "inspect.img.archive.success.text"/> " + $(this).html(), "success");
				    }
		
				});
			});
			
			//擴充關閉後解除相冊元素
			el.addEventListener('lgAfterClose', function(event){
				setTimeout(() => {
			        var $lg = $('.lg-container');
			        if ($lg.length) {
					    $lg.remove();
				  	}
		      	}, 100);
			});
			
			openImgItem = true;
		}
	}

}

//抓取json值若無則設為0
function returnValue(insertValue){
	var realVal = insertValue === undefined ? 0 : insertValue;
	return realVal;
}

//分享影像至群組
function shareImg(){
	var target = $(".item-list").find(".active");
	var deviceName = target.data("device");
	var bodypart = target.data("bodypart");
	var index = parseInt($(".lg-counter-current").html()) - 1;
	var imgSrc = $(".lg-current").find("img").attr("src");
	console.log("imgSrc: " + imgSrc);
	toDataURL(imgSrc, function(dataUrl) {
	  	$.ajax({
		    type: "POST",
		    url: "http://localhost:8080/WebSocket/chatroom/uploadNewFile",
		    data: {
				orderImg : dataUrl.replace("data:image/jpeg;base64,", ""),
		        orderImgName: deviceName + "_" + bodypart + "_<@spring.message "inspect.label.testImgs"/>_" + index + ".jpeg",
		        sendTime: new Date().getTime(),
		        room: ${sendingRoomId!""},
		        from: ${sendingUserId!""},
		        type: 2
		    },
		    dataType: "json",
		    
		    success: function(result){
		       if(result.data.success){
		       	  	var filename = result.data.originalFilename;
	            	var fileSize = result.data.fileSize;
	            	var fileUrl = result.data.fileUrl;
					
	            	/*ws.sendFileMsg(new Date().getTime(), ${sendingUserId!""}, ${sendingRoomId!""}, filename, fileUrl, fileSize);
		       	  	*/
		       	  	swal("<@spring.message "inspect.img.share.success.title"/>", "<@spring.message "inspect.img.share.success.text"/>", "success");
		       }                    	            	            
		    },
		    error: function(){
		    	swal("<@spring.message "inspect.img.import.fail.title"/>", "<@spring.message "inspect.img.import.fail.text"/>", "error");
		    }
		});
	});
}

function toDataURL(url, callback) {
  	var xhr = new XMLHttpRequest();
  	xhr.onload = function() {
    	var reader = new FileReader();
    	reader.onloadend = function() {
      		callback(reader.result);
    	}
    	reader.readAsDataURL(xhr.response);
  	};
 	xhr.open('GET', url);
  	xhr.responseType = 'blob';
  	xhr.send();
}

$(".keyChar").click(function(){
	insertAfterCursor($(".form-group textarea"), $(this).text());
});

function getCursorPosition(obj) {
	var el = $(obj).get(0);
	var pos = 0;
	if('selectionStart' in el) {
		pos = el.selectionStart;
	} else if('selection' in document) {
		el.focus();
		var Sel = document.selection.createRange();
		var SelLength = document.selection.createRange().text.length;
		Sel.moveStart('character', -el.value.length);
		pos = Sel.text.length - SelLength;
	}
	return pos;
}

function insertAfterCursor(obj, text){
	var position = getCursorPosition(obj);
	var oldValue = $(obj).val();
	var newValue = oldValue.substring(0, position) + text + oldValue.substring(position);
	$(obj).val(newValue);
	$(obj).focus();
	$(obj)[0].setSelectionRange(position+text.length, position+text.length);
}

</script>

<#include "/skins/imas/casemgnt/chart.ftl" />
<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />