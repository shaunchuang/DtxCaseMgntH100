<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "task.label.title"/></div>
					<input type="hidden" class="hidden-case" />
					<input type="hidden" class="hidden-name" />
				</div>
				<div class="col-md-6 panel-heading">
	                <ul class="nav nav-tabs pull-right">
	                    <li>
	                    	<a class="nav-tab tab-name" href="#tabInfo_1" data-src="${__lang}/division/web/admin/taskMgnt/group" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo_1" >${field_name!""}</a>
                    	</li>
	                    <li>
	                    	<a class="nav-tab tab-name" href="#tabInfo_2" data-src="${__lang}/division/web/admin/taskMgnt/personal" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="#tabInfo_2" >${currentUser.name!""}</a>
                    	</li>
	                </ul>
	            </div>          
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div id='calendar'></div>
			</div>
		</div>
	</div>
</body>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:600px;">
		<div class="modal-content" >
			<div class="modal-header">
				<@spring.message "task.label.edit"/>
				<button type="button" class="close clean" data-dismiss="modal" data-form="0" aria-label="Close">
		          	<i class="fa fa-xmark" aria-hidden="true"></i>
		        </button>
			</div>
			<div class="modal-body">
				<div id="wg-Container" style="width:100%;">               
			</div>
			<div class="modal-footer">    
				<button class="case-track func-btn"><@spring.message "task.button.view"/></button> 
				<button class="delete func-btn"><@spring.message "task.button.delete"/></button>
				<button class="func-btn" onclick="formSubmit()"><@spring.message "task.button.save"/></button>			
				<button class="clean func-btn" data-dismiss="modal"><@spring.message "task.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>

<script>

var calender;

document.addEventListener('DOMContentLoaded', function() {
	var postData = {"creatorId": ${currentUser.id!""}, "isPersonal": true};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
    newCalendar(result, "");    

});

function custContent(catItem){
	$(".fc-visit-button").attr("data-cat", 1).addClass("search-cat");
    $(".fc-track-button").attr("data-cat", 2).addClass("search-cat").after("<div class='case-selection'><select class='search-case form-control' placeholder='<@spring.message "task.placeholder.case"/>' ></select></div>");
	$(".fc-import-button").after("<input type='file' class='uploadEvents' />");
	setCaseOption();
	activFunc(catItem);
}

function newCalendar(result, catNum){
	var calendarEl = document.getElementById('calendar');
    calendar = new FullCalendar.Calendar(calendarEl, {
    	themeSystem: 'bootstrap4',
    	weekNumbers: false,
    	customButtons: {
	    	visit: {
	      		text: '<@spring.message "task.label.visit"/>'
	    	},
	    	track: {
	      		text: '<@spring.message "task.label.track"/>'
	    	},
	    	import: {
	      		text: '<@spring.message "task.button.import"/>',
	      		click: function() {
	        		$(".uploadEvents").click();
	      		}
	    	},
	    	addBtn: {
	      		text: '<@spring.message "task.button.add"/>',
	      		click: function() {
	        		addTaskEvent();
	      		}
	    	}
	  	},
    	headerToolbar: {
    		start: 'visit track',
	        center: 'prev title next',
	        right: 'addBtn import'
      	},
      	<#if calendarAPI?? && calendarMail?? >
      	googleCalendarApiKey: "${calendarAPI!""}",
      	eventSources:[
      		{googleCalendarId: "${calendarMail!""}"}
      	],
      	</#if>
	  	/*events: {
		    googleCalendarId: 'kevin39777@gmail.com'
	  	},*/
      	locales: ['zh-tw', 'en'],
      	moreLinkText: '<@spring.message "task.label.viewmore"/>',
      	dayMaxEvents: 3,
      	height: 650,
      	events: result.data,     	
      	initialView: 'dayGridMonth',
      	eventContent: function (arg) {
            // 取得事件的相關資訊
            var eventId = arg.event.id;
            var eventTitle = arg.event.title;
            var eventStart = formatTime(arg.event.start, arg.event.extendedProps.cat);
            var eventEnd = formatTime(arg.event.end, arg.event.extendedProps.cat);
            console.log(eventId);
            // 在這裡可以進行進一步的處理，例如將資訊傳送到後端並存入資料庫
            //saveEventToDatabase(eventId, eventTitle, eventStart, eventEnd);

            // 或者進行其他自定義的操作

            // 返回事件內容
            return {
                html: '<b>' + eventStart + " " + eventTitle + '</b>',
            };
        },
      	dateClick: function(info) {  //點擊空白日期發生動作
      	  	var clickedDate = info.dateStr;
      	  	addTaskEvent();
      	  	$('input[name="beginDate"], input[name="endDate"]').val(clickedDate);    	
	  	},
	  	eventClick: function(data, jsEvent) { //點擊任務發生動作
      	  	editTaskEvent(data.event.id);
	  	},
	  	displayEventTime: false
    });
    calendar.render();
    //
    custContent(catNum);
}

function activFunc(catNum){
	$(".search-cat[data-cat='" + catNum + "']").toggleClass("active");
    //
    $(".search-cat").click(function(){
    	var caseNo = $(".hidden-case").val();
	
		if($(this).hasClass("active")){
			$(this).toggleClass("active");
			var postData = {"creatorId": ${currentUser.id!""}, "isPersonal": true, "caseNo": caseNo};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
			calendar.destroy();
			newCalendar(result, "");
		}
		else{
			$(".search-cat.active").toggleClass("active");
			$(this).toggleClass("active");
			var postData = {"creatorId": ${currentUser.id!""}, "isPersonal": true, "cat": $(this).data("cat"), "caseNo": caseNo};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
			calendar.destroy();
			newCalendar(result, $(this).data("cat"));
		}
		
	});
	//
	$(".search-case").select2({
        language: '${__lang}',
        width: 'element',
        maximumInputLength: 10,
        minimumInputLength: 1,
        placeholder: '<@spring.message "task.placeholder.case"/>',
        dropdownParent: '.case-selection',
        allowClear: true,
        ajax: {
            url: '${base}/division/api/qryCaseInfoItems',
            type: 'POST',
            data: function (params){
                return {
                    queryParam: params.term 
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
    }).on("select2:unselecting", function(e) {
		$(".hidden-case").val("");
		$(".hidden-name").val("");
		var postData = "", result = "";
		var target = $(".search-cat.active");
		var activeLeng = target.length;

		if(activeLeng > 0){
			postData = {"creatorId": ${currentUser.id!""}, "isPersonal": true, "cat": target.data("cat")};
			result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
			calendar.destroy();
			newCalendar(result, target.data("cat"));
		}
		else{
			postData = {"creatorId": ${currentUser.id!""}, "isPersonal": true};
			result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
			calendar.destroy();
			newCalendar(result, "");
		}
		
 	}).on("select2:select", function(e) {
 		var postData = "", result = "";
 		var target = $(".search-cat.active");
 		var caseNo = $(this).find("option").last().val();
 		var caseName = $(this).find("option").last().html();
 		var activeLeng = target.length;
 		if(activeLeng > 0){			
			postData = {"creatorId": ${currentUser.id!""}, "isPersonal": true, "cat": target.data("cat"), "caseNo": caseNo};
			result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
			calendar.destroy();
			newCalendar(result, target.data("cat"));
		}
		else{
			postData = {"creatorId": ${currentUser.id!""}, "isPersonal": true, "caseNo": caseNo};
			result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
			calendar.destroy();
			newCalendar(result, "");
		}
		$(".hidden-case").val(caseNo);
		$(".hidden-name").val(caseName);
		
		setCaseOption();
 	});
 	//
 	$(".addTaskBtn").click(function(){
 		addTaskEvent();
 	});
}

//新增事件
function addTaskEvent(){
	wg.template.updateNewPageContent('wg-Container', 'myModuleContent', {}, '${base}/${__lang}/employee/task/create');
	
	$("#caseNo").selectize({
    	sortField: 'text'
    });
    
    $(".form-check-input").click(function(){
    	var clickType = $(this).data("type");
    	$(".hidden-type").val(clickType);
    });
    
    $(".delete").toggleClass("hidden").removeAttr("onclick");
    
    startDatePicker('input[name="beginDate"], input[name="endDate"]');

	multiSelectAdapter("#collaborateId_select", "#collaborateIds", '<@spring.message "task.placeholder.executor"/>');
	
	timeAdapter(".beginTime, .endTime", "beginTime", "endTime");
	
	$(".case-track").toggleClass("hidden");
	
	$("#myModal").modal('show');
}

//編輯事件
function editTaskEvent(id){
	wg.template.updateNewPageContent('wg-Container', 'myModuleContent', {}, '${base}/${__lang}/employee/task/edit?id=' + id);
	
	$("#caseNo").selectize({
    	sortField: 'text'
    });
    
    $(".delete").attr("onclick", "deleteTask(" + id + ")");
    
    startDatePicker('input[name="beginDate"], input[name="endDate"]');
    
    multiSelectAdapter("#collaborateId_select", "#collaborateIds", '<@spring.message "task.placeholder.executor"/>');
    
    timeAdapter(".beginTime, .endTime", "beginTime", "endTime");
    
    $(".case-track").attr("onClick", "trackCase(" + id + ")").removeClass("hidden");
	
	$("#myModal").modal('show');
}

function formSubmit(){
	if($("#taskForm").valid()){
		var action = $("#taskForm").attr("action");
	    $.ajax({
	     	type: "POST",
	      	url: action,
	      	data: $("#taskForm").serialize(),
	      	success: function() {
	        	swal({
				  	title: "<@spring.message "personal.task.save.success.title"/>",
				  	text: "<@spring.message "personal.task.save.success.text"/>",
				  	type: "success",
				  	timer: 1500,
				  	showConfirmButton: false
				},function(){
					$("#myModal").modal('hide');
				    location.reload();
				});
	       	}
	    });

	}
}

//設定設定的個案號碼
function setCaseOption(){
	var caseNo = $(".hidden-case").val();
	var caseName = $(".hidden-name").val();
	if(caseNo != "" && caseName != ""){		
		$('.search-case').append('<option value="' + caseNo + '">' + caseName + '</option>').trigger('change');
	}
}

//檢視個案資訊
function trackCase(id){
	var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/employee/task/id?id=" + id);
	if(result.success){
		var caseno = result.caseno;
		window.open("${base}/${__lang}/division/web/patient/" + caseno + "/inspection");
	}
	$("#myModal").modal('hide');
}

//刪除任務
function deleteTask(id){
	var delIds = [];
	delIds.push(id);
	var data = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/employee/task/doDeleteTask?id=" + delIds);
	if(data.success){
		swal({
		  	title: "<@spring.message "personal.task.delete.success.title"/>",
		  	text: "<@spring.message "personal.task.delete.success.text"/>",
		  	type: "success",
		  	timer: 1500,
		  	showConfirmButton: false
		},function(){
			$("#myModal").modal('hide');
		    location.reload();
		});
	}
	else{
		swal("<@spring.message "personal.task.delete.fail.title"/>", "<@spring.message "personal.task.delete.fail.text"/>", "error");
	}
}

//匯入事件清單
function uploadEvents(){
	
}

</script>

<style>
.uploadEvents{
	display: none !important;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />