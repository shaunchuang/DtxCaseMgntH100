<#assign isEmpty = false>
<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "review.label.title"/></div>
				</div>          
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
	            <div class="default-blks">
			  		<div class="col-5 default-blk appointment-blk">
			  			<div class="calendar-card pd-b-10">
			  			
			  			</div>
			  			<div class="appointment-card">
			  				<div class="title">預約回診 <button class="func-btn-custom btn-primary f-14">新增預約</button></div>
			  				<#if todayReviewInfo?? && todayReviewInfo.appoEvents?? && (todayReviewInfo.appoEvents?size>0)>
			  				<table class="table table-fixed mg-top-10">
							    <tbody class="appointment-events">						    	
	            					<#assign appoEvents = todayReviewInfo.appoEvents>
							    	<#list appoEvents as appoEvent>
							    	<tr>
					                    <td class="col-xs-9-5">
					                    	<div class="appo-main">
					                    		<div class="appo-time">${appoEvent.appoDate} ${appoEvent.appoTime}</div>
					                    		<div class="appo-target"><#if appoEvent.division??>${appoEvent.division} </#if>${appoEvent.doctorName} ${appoEvent.doctorAlias}</div>
					                    	</div>
					                    	<div class="appo-sub"><#if appoEvent.isFirstDiag >初診<#else>複診</#if>/顯示副標題</div>
					                    </td>
					                    <td class="col-xs-2-5 right-align">
					                    	<button class="func-btn-custom f-14 mg-right-5" data-keyno="${appoEvent.caseno}" data-slot="${appoEvent.slotId}">更改預約</button>
				                    	</td>
					                </tr>
					                </#list>
							    </tbody>
							</table>			  				
			  				<#else>
			  				<div class="cnt-empty">尚無預約回診</div>
							</#if>
			  			</div>
			  		</div>
				    <div class="col-7">
				    	
				    	<div class="default-blk lesson-blk">
					      	<div class="title mg-b-5">訓練計畫</div>
					      	<!--<div class="default-blk lesson-card">
					      		<img src="${base}/images/imas/lesson/lesson3.jpg" alt="Minecraft Dungeons">
							    <div class="card-content">
							        <div class="card-header">
							            <h3>Minecraft 訓練計畫</h3>
							            <span class="status-red">今日訓練未完成</span>
							        </div>
							        <div class="card-details">
							            <p>2024/05/26~2024/06/15 | 程靜雯 治療師 開立</p>
							        </div>
							        <div class="card-buttons">
							            <button class="func-btn-custom">提問與回覆</button>
							            <button class="func-btn-custom">檢視紀錄</button>
							            <button class="func-btn-custom btn-primary">教案使用</button>
							        </div>
							    </div>
					      	</div>
					      	<div class="default-blk lesson-card">
					      		<img src="${base}/images/imas/lesson/lesson2.jpg" alt="Minecraft Dungeons">
							    <div class="card-content">
							        <div class="card-header">
							            <h3>theBlu 訓練計畫</h3>
							            <span class="status-green">今日訓練已完成</span>
							        </div>
							        <div class="card-details">
							            <p>2024/05/26~2024/06/15 | 程靜雯 治療師 開立</p>
							        </div>
							        <div class="card-buttons">
							            <button class="func-btn-custom">提問與回覆</button>
							            <button class="func-btn-custom">檢視紀錄</button>
							            <button class="func-btn-custom btn-primary">教案使用</button>
							        </div>
							    </div>
					      	</div>-->
						</div>
						<div class="default-blk history-list-blk mg-b-10">
				    		<div class="title">就診歷程(僅列近期五筆紀錄)</div>
				    		<#if todayReviewInfo?? && todayReviewInfo.hcRecords?? && (todayReviewInfo.hcRecords?size>0)>
			  				<table class="table table-fixed">
								<thead>
							      	<tr>
							      		<th class="col-xs-2">看診日期</th>
					                    <th class="col-xs-4-5">科別-醫師/治療師</th>
					                    <th class="col-xs-3-5">適應症</th>
					                    <th class="col-xs-2">功能項</th>
							      	</tr>
							    </thead>
							    <tbody class="history-events">
							    	<#assign hcRecords = todayReviewInfo.hcRecords>
							    	<#list hcRecords as hcRecord>
							    	<tr>
					                    <td class="col-xs-2">${hcRecord.diagDate}</td>
					                    <td class="col-xs-4-5">${hcRecord.doctorName} ${hcRecord.doctorAlias}</td>
					                    <td class="col-xs-3-5"><span class="badge badge-tag">${hcRecord.indication}</span></td>
					                    <td class="col-xs-2"><button class="func-btn-custom f-14">檢視紀錄</button></td>
					                </tr>
							    	</#list>
							    </tbody>
							</table>		  				
			  				<#else>
				    		<div class="cnt-empty">尚無就診歷程</div>
							</#if>
				    	</div>
				    </div>
			  	</div>			  	
			</div>
		</div>
	</div>
</body>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:900px;">
		<div class="modal-content" >
			<div class="modal-header">
				新增預約看診時間
				<button type="button" class="close clean" data-dismiss="modal" data-form="0" aria-label="Close">
		          	<i class="fa fa-xmark" aria-hidden="true"></i>
		        </button>
			</div>
			<div class="modal-body d-flex d-flex-space">				
				<div class="col-3">
	    			<div class="doctor-list">
	    				<#if doctorInfos?? && (doctorInfos?size>0)>
						<#list doctorInfos as doctorInfo>
						<div class="doctor-card" data-doctor="${doctorInfo.id}">
							<#if doctorInfo.gender == "M">
                            <img src="${base}/images/imas/role/doctor.png" class="card-img-top" alt="${doctorInfo.name}">
                            <#else>
                            <img src="${base}/images/imas/role/doctorFemale.png" class="card-img-top" alt="${doctorInfo.name}">
                            </#if>	
                            <div class="doctor-name">${doctorInfo.name} ${doctorInfo.role}</div>
                        </div>
						</#list>
						</#if>
                    </div>
	    		</div>
	    		<div class="col-9">
	    			<div id="appointment-container" style="width:100%;"></div> 
	    		</div>          
			</div>
			<div class="modal-footer">    
				<button class="func-btn" onclick="reserve()">確認</button>			
				<button class="clean func-btn" data-dismiss="modal"><@spring.message "task.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>

<script>
var lessonStoreUrl = '${lessonStoreUrl!""}';

<#if todayReviewInfo?? >
var userKeyNo = '${todayReviewInfo.userKeyNo!""}';
<#else>
var userKeyNo = '';
</#if>

$(document).ready(function(){
	<#if todayReviewInfo?? && todayReviewInfo.appoDates?? && (todayReviewInfo.appoDates?size > 0) >
	var selectedDates = [<#list todayReviewInfo.appoDates as appoDate>"${appoDate?js_string}"<#if appoDate_has_next>,</#if></#list>];
	<#else>
	var selectedDates = [];
	</#if>
	setInlineDatePicker(".calendar-card", selectedDates);
	fetchTrainingPlanNew();
	
});

$(".appointment-events tr button").click(function(){
	wg.template.updateNewPageContent('appointment-container', 'doctor-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment?clinician=doctor');
	$("#myModal").modal('show');
});

$(".appointment-card .title button").click(function(){
	$('#myModal').on('shown.bs.modal', function () {
		wg.template.updateNewPageContent('appointment-container', 'doctor-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment/msg/chooseMessage?clinician=doctor');
	});
	$('#myModal').modal('show');
});

//醫師選擇點擊
$(".doctor-card").click(function(e){
	e.preventDefault();
	$(this).parent().find(".doctor-card").removeClass("selected");
	$(this).toggleClass("selected");
	
	var doctorId = $(this).attr("data-doctor");
	wg.template.updateNewPageContent('appointment-container', 'doctor-booking-content', {"doctorId": doctorId}, '/ftl/imas/admin/taskMgnt/appointment?clinician=doctor&doctorId=${currentUser.id!""}');
});
/*
function fetchTrainingPlan(){
	console.log('userKeyNo: ', userKeyNo);
	var response = wg.evalForm.getJson({"data":userKeyNo}, baseCaseMgntUrl + '/division/api/TrainingPlan/list');
	if (response.success){
		var planName = '';
		var lessonCardHtml = '';
		
		var trainingPlanList = response.trainingPlan;

		if(trainingPlanList.length > 0){
			trainingPlanList.forEach(trainingPlan => {
		
				console.log(trainingPlan);
	
	        	var lessonMain = '';
	        	var lessonId = trainingPlan.trainingLessons[0].lessonStoreKeyNo;
	        	var result = wg.evalForm.getJson({"lessonId": lessonId}, lessonStoreUrl + '/division/api/Lesson/GetLessonBasic');
	        	if(result.success){
	        		lessonMain = JSON.parse(result.lessonMain);
	        	
				
	        		var imageUrl = lessonMain.evalItemAnses['4'];
					var lessonName = lessonMain.evalItemAnses['1'];
	        		var startDateStr = formatDate(trainingPlan.startTime);
	        		var endDateStr = formatDate(trainingPlan.endTime);
	        	
	        		lessonCardHtml += `
	        			<div class="default-blk lesson-card">
							<img src="` + imageUrl + `" alt="` + lessonName + `">
							<div class="card-content">
								<div class="card-header">
									<h3>` + lessonName + ` 訓練計畫</h3>
									<!--<span class="status-red">今日訓練未完成</span>-->
								</div>
								<div class="card-details">
									<p>`+ startDateStr + `~` + endDateStr + ` | `+ trainingPlan.creatorName +` 治療師 開立</p>
								</div>
								<div class="card-buttons">
									<button class="func-btn-custom func-link" data-url="` + '${base}/${__lang}/division/web/dtxCaseQuestion/'+ trainingPlan.trainingPlanKeyNo + `">提問與回覆</button>
									<button class="func-btn-custom func-link" data-url="` + '${base}/${__lang}/division/web/dtxCaseRecord/'+ trainingPlan.trainingPlanKeyNo + `">檢視紀錄</button>
									<button class="func-btn-custom func-link btn-primary" data-url="` + '${base}/${__lang}/division/web/dtxCaseTraining/'+ trainingPlan.trainingPlanKeyNo + `">教案使用</button>
								</div>
							</div>
						</div>
	        		`;
			        // 動態綁定按鈕點擊事件
					$(document).off('click', '.func-link').on('click', '.func-link', function () {
					    var url = $(this).data('url');
					    window.location.href = url;
					});
	        	}
	        });
	        $('.lesson-blk').append(lessonCardHtml);
        }else{
        	$('.lesson-blk').append('<div class="cnt-empty">尚無訓練計畫</div>');
        }
	} else {
		$('.lesson-blk').append('<div class="cnt-empty">尚無訓練計畫</div>');
	}
}*/
/*
function fetchTrainingPlanNew(){
	console.log('patientId: ', userKeyNo);
	var response = wg.evalForm.getJson({"patientId":userKeyNo}, baseCaseMgntUrl + '/division/api/TrainingPlan/listNew');
	console.log(response);
	
	if(response.success){
		if(response.trainingPlan){
			var lessonCardHtml = '';
        	var trainingPlanList = response.trainingPlan;
		
			if(trainingPlanList.length > 0) {
				trainingPlanList.forEach(trainingPlan => {
	                console.log(trainingPlan);
	
	                // 計畫資訊
	                var startDateStr = formatDate(trainingPlan.startDate);
	                var endDateStr = formatDate(trainingPlan.endDate);
	                var therapistName = trainingPlan.therapistName || "治療師";
	
	                // 每個計畫中的課程
	                
	                if (trainingPlan.lessons && trainingPlan.lessons.length > 0) {
						var lesson = trainingPlan.lessons[0];
	                    var lessonId = lesson.lessonId;
	                    var lessonName = "課程名稱未提供"; // 預設課程名稱
	                    var imageUrl = ""; // 預設圖片
	
	                    // 查詢課程詳細資訊
	                    //var result = wg.evalForm.getJson({"lessonId": lessonId}, lessonStoreUrl + '/division/api/Lesson/GetLessonBasic');
						var lessonName;
						var imageUrl;
						$.ajax({
						  url: lessonStoreUrl + '/LessonMainInfo/api/get/lessonId/' + lessonId,
						  method: 'GET',
						  dataType: 'json'
						})
						.done(function(result) {
							console.log(result);
						    // 取 evalItemAnses 物件裡的欄位
						    lessonName = lessonMain.evalItemAnses['1'] || '預設課程名稱';
						    imageUrl  = lessonMain.evalItemAnses['4'] || '預設圖片 URL';
						
						    // 例如把它們顯示到頁面上
						    $('#lessonName').text(lessonName);
						    $('#lessonImage').attr('src', imageUrl);
						})
						.fail(function(jqXHR, textStatus, errorThrown) {
						  console.error('jQuery GET Error:', textStatus, errorThrown);
						  $('#jqResult').text('Error: ' + textStatus);
						});

	                    // 生成卡片 HTML
	                    lessonCardHtml += `
	                       <div class="default-blk lesson-card">
	                           <img src="`+ imageUrl +`" alt="` + lessonName + `">
	                           <div class="card-content">
	                               <div class="card-header">
	                                   <h3>` + lessonName + ` 訓練計畫</h3>
	                               </div>
	                               <div class="card-details">
	                                    <p>` + startDateStr + ` ~ ` + endDateStr + ` | ` + therapistName + ` 開立</p>
	                               </div>
	                               <div class="card-buttons">
	                                    <button class="func-btn-custom func-link" data-url="/ftl/casetraining/trainingQuestion?planId=` + trainingPlan.planId + `">提問與回覆</button>
	                                    <button class="func-btn-custom func-link" data-url="/ftl/casetraining/trainingRecord?planId=` + trainingPlan.planId + `">檢視紀錄</button>
	                                    <button class="func-btn-custom func-link btn-primary" data-url="/ftl/casetraining/trainingPlan?planId=` + trainingPlan.planId + `">教案使用</button>
	                                </div>
	                            </div>
	                        </div>
	                     `;

            		}
				});
				
            	$('.lesson-blk').append(lessonCardHtml);
			    
			    // 動態綁定按鈕點擊事件
			    $(document).off('click', '.func-link').on('click', '.func-link', function () {
				    var url = $(this).data('url');
				    window.location.href = url;
			    });
			            
	        } else {
	            $('.lesson-blk').append('<div class="cnt-empty">尚無訓練計畫</div>');
	        }
	    } else {
	        $('.lesson-blk').append('<div class="cnt-empty">尚無訓練計畫</div>');
	    }
	}
}*/

function formatDate(dateStr){
	var dateObj = new Date(dateStr);
	var formattedDate = dateObj.getFullYear() + '/' + 
    ('0' + (dateObj.getMonth() + 1)).slice(-2) + '/' + 
    ('0' + dateObj.getDate()).slice(-2);
    
    return formattedDate;
}

</script>

<style>

.calendar-card,
.calendar-card .datepicker-inline,
.calendar-card .table-condensed{
	width: 100%;
}

.datepicker-switch{
	font-size: 18px;
}

.datepicker table tr td.active{
	color: #000000 !important;
	background-color: #ffdb99 !important;
	border-color: #ffb733 !important;
}

.datepicker table tr td.active:hover{
	background-color: #ffc966 !important;
	border-color: #f59e00 !important;
}

.datepicker table tr td.today{
	color: #ffffff;
	background-color: #337ab7;
	border-color: #2e6da4;
	text-shadow: 0 -1px 0 rgba(0,0,0,.25);
}

.datepicker table tr td.today:hover{
	color: #ffffff;
	background-color: #204d74;
	border-color: #122b40;	
}

.appointment-card{
	padding: 10px 0;
	border-top: 1px solid #bfbfbf;
}

.appointment-events tr td,
.track-events tr td{
	display: block;
	align-items: center;
	/*padding: 10px 0 !important;*/
	padding-left: 0 !important;
	padding-right: 0 !important;
}

.appointment-events tr td(:last-child){
	
}

.appo-main, .appo-sub{	
	display: block;
}

.appo-sub{
	color: #8c8c8c;
}

.appo-main .appo-time{
	border-right: 1.5px solid #000000;
	padding-right: 5px;
}

.appo-main .appo-time,
.appo-main .appo-target{
	font-weight: 600;
	display: inline;
}

.history-list-blk, .lesson-blk{
	min-height: 200px;
}

.history-list-blk {
	margin-top: 1.5rem;
}

.lesson-card {
    display: flex;
    align-items: center;
    background-color: #ffffff;
}

.lesson-card img {
    width: 150px;
    height: 100px;
    border-radius: 8px;
    margin-right: 16px;
}

.card-content {
    flex: 1;
}

.card-header h3, .card-header .status-red,
.card-header .status-green, .card-details{
	font-weight: 600;
}

.card-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 8px;
}

.card-header h3 {
    margin: 0;
    font-size: 18px;
    color: #d38c12;
}

.card-header .status-red,
.card-header .status-green  {    
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 13px;
}

.card-header .status-red{
	background-color: #fce9e8;
    color: #e63946;
}

.card-header .status-green{
	background-color: #F0F9F2;
    color: #3a924d;
}

.card-details {
    font-size: 14px;
    color: #333;
    margin-bottom: 16px;
}

.card-buttons {
    display: flex;
    gap: 8px;
}

/*
.card-buttons .btn::after {
    content: "";
    display: inline-block;
    width: 8px;
    height: 8px;
    background-color: red;
    border-radius: 50%;
    margin-left: 8px;
}
*/

/* 醫師選單 */

.doctor-list {
	width: 80%;
	height: 100%;
	max-height: 400px;
    overflow-y: auto;
    white-space: nowrap;
    margin: 0 auto;
    padding: 10px 0;
    border: 1px solid #bfbfbf;
    border-radius: 5px;
}

.doctor-card {
	position: relative;
    width: 130px;
    height: auto;
    border: 1px solid #ccc;
    background: #f2f2f2;
    border-radius: 4px;
    display: block;
    margin: 0 auto;
    margin-bottom: 5px !important;
    overflow: hidden;
    cursor: pointer;
    text-align: center;
}

.doctor-card img {
    width: 60%;
    height: 80px;
    margin: 5px 0;
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
    transition: transform 0.3s ease;
}

.doctor-card .doctor-name {
    font-size: 16px;
    font-weight: bold;
	text-align: center;
	padding: 2px 5px;
	border-top: 0.5px solid #cccccc;
}

.doctor-card.selected .doctor-name{
	background: #d38c12;
	color: #ffffff;
	font-weight: 600;
	border: 1px solid #d38c12;
	text-shadow: 1px 1px 0 #444;	
}

.doctor-card:not(.selected):hover .doctor-name{
	background: #8c8c8c;
	color: #ffffff;
	border: 1px solid #8c8c8c;
}

</style>	

<#include "/imas/widget/widget.ftl" />