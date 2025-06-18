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
	                    	<a class="nav-tab tab-name" href="#tabInfo_1" data-src="${__lang}/division/web/admin/taskMgnt/group" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="#tabInfo_1" >${field_name!""}</a>
                    	</li>
	                    <li>
	                    	<a class="nav-tab tab-name" href="#tabInfo_2" data-src="${__lang}/division/web/admin/taskMgnt/personal" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="#tabInfo_2" >${currentUser.name!""}</a>
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
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:600px;">
		<div class="modal-content" >
			<div class="modal-header">
				<@spring.message "task.button.setting"/>
				<button type="button" class="close clean" data-dismiss="modal" data-form="0" aria-label="Close">
		          	<i class="fa fa-xmark" aria-hidden="true"></i>
		        </button>
			</div>
			<div class="modal-body">
				<form class="reg" >
					<table class="default-table">
						<tr>
							<td><@spring.message "task.label.api"/></td>
							<td>
								<input type="text" class="form-control api" <#if calendarAPI??>value="${calendarAPI!""}"</#if> />
							</td>
						</tr>
						<tr>
							<td><@spring.message "task.label.team.mail"/></td>
							<td>
								<input type="text" class="form-control mail" <#if calendarMail??>value="${calendarMail!""}"</#if> />
							</td>
						</tr>
					</table>
				</form>               
			</div>
			<div class="modal-footer">      
				<button class="func-btn" onclick="updateSetting()"><@spring.message "task.button.setting"/></button>
				<button class="clean func-btn" data-dismiss="modal"><@spring.message "task.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>
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
				<button class="func-btn" onclick="formSubmit()"><@spring.message "task.button.save"/></button>
				<button class="clean func-btn" data-dismiss="modal"><@spring.message "task.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>

<script>

var calender;

document.addEventListener('DOMContentLoaded', function() {
	var postData = {"isPersonal": false};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");	
	newCalendar(result, "");
});

function custContent(catItem){
	$(".fc-visit-button").attr("data-cat", 1).addClass("search-cat");
    $(".fc-track-button").attr("data-cat", 2).addClass("search-cat").after("<div class='case-selection'><select class='search-case form-control' placeholder='<@spring.message "task.placeholder.case"/>' ></select></div>");
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
	    	settingBtn: {
	      		text: '<@spring.message "task.button.setting"/>',
	      		click: function() {
	        		setExternalMail();
	      		}
	    	},
	    	syncBtn: {
	      		text: '<@spring.message "task.button.sync"/>',
	      		click: function() {
	        		syncCalendarEvent();
	      		}
	    	}
	  	},
    	headerToolbar: {
    		start: 'visit track',
	        center: 'prev title next',
	        <#if currentUser.employeeno?? && currentUser.employeeno == "ADMIN">
	        right: 'syncBtn settingBtn'
	        <#else>
	        right: ''
	        </#if>
      	},
      	<#if calendarAPI?? && calendarMail?? >
      	googleCalendarApiKey: "${calendarAPI!""}",
      	eventSources:[
      		{googleCalendarId: "${calendarMail!""}"}
      	],
      	</#if>
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
            // 在這裡可以進行進一步的處理，例如將資訊傳送到後端並存入資料庫
            //saveEventToDatabase(eventId, eventTitle, eventStart, eventEnd);

            // 或者進行其他自定義的操作

            // 返回事件內容
            return {
                html: '<b>' + eventStart + " " + eventTitle + '</b>',
            };
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
			var postData = {"isPersonal": false, "caseNo": caseNo};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
			calendar.destroy();
			newCalendar(result, "");
		}
		else{
			$(".search-cat.active").toggleClass("active");
			$(this).toggleClass("active");
			var postData = {"isPersonal": false, "cat": $(this).data("cat"), "caseNo": caseNo};
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
			postData = {"isPersonal": false, "cat": target.data("cat")};
			result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
			calendar.destroy();
			newCalendar(result, target.data("cat"));
		}
		else{
			postData = {"isPersonal": false};
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
			postData = {"isPersonal": false, "cat": target.data("cat"), "caseNo": caseNo};
			result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
			calendar.destroy();
			newCalendar(result, target.data("cat"));
		}
		else{
			postData = {"isPersonal": false, "caseNo": caseNo};
			result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryTaskList");
			calendar.destroy();
			newCalendar(result, "");
		}
		$(".hidden-case").val(caseNo);
		$(".hidden-name").val(caseName);
		
		setCaseOption();
 	});

}

//編輯事件
function editTaskEvent(id){
	wg.template.updateNewPageContent('wg-Container', 'myModuleContent', {}, '${base}/employee/task/edit?id=' + id);
	
	$("#caseNo").selectize({
    	sortField: 'text'
    });
    
    startDatePicker('input[name="beginDate"], input[name="endDate"]');
	
	multiSelectAdapter("#collaborateId_select", "#collaborateIds", '<@spring.message "task.placeholder.executor"/>');
	
	timeAdapter(".beginTime, .endTime", "beginTime", "endTime");
	
	$(".case-track").attr("onClick", "trackCase(" + id + ")").removeClass("hidden");
	
	$("#myModal").modal('show');
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

//設定外部行事曆連結
function setExternalMail(){	
	$("#myModal2").modal('show');
}

//更新設定資訊
function updateSetting(){
	var api = $(".api").val();
	var mail = $(".mail").val();
	if(api != "" && mail != ""){
		var postData = {"api": api, "mail": mail};
		var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/updateCalendarParam");
		if(result.success){
			swal("更新成功", "完成參數更新!", "success");
			$("#myModal2").modal('hide');
		}
	}else{
		swal("更新失敗", "參數更新未完全，請再次確認!", "error");
	}
}

//同步googleCalendar 事件資訊
function syncCalendarEvent(){
	
}

</script>	

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />