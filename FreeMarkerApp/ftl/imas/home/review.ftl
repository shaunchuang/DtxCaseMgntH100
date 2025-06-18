<#include "/imas/widget/leftnav.ftl" />
<#assign roleAlias = "">
<#list currentUser.roles as role>
	<#if role.alias == "ADMIN">
		<#assign roleAlias = "ADMIN">
	<#elseif role.alias == "DOCTOR">
		<#assign roleAlias = "DOCTOR">
	</#if>
</#list>
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
	            <div class="default-blks appointment-blks">
			  		<div class="col-8 default-blk appointment-blk">
				      	<div class="title">今日個案預約行程 <!--<span class="badge badge-success">7</span>--></div>
						<table class="table table-fixed">
							<thead>
						      	<tr>
						      		<th class="col-xs-0-5">序</th>
						      		<th class="col-xs-1">類型</th>
				                    <th class="col-xs-1-5">患者姓名</th>
				                    <th class="col-xs-1-5">性別/年齡</th>
				                    <th class="col-xs-4">適應症</th>
				                    <th class="col-xs-1-5">預約時間</th>
				                    <th class="col-xs-2">報到狀態</th>
						      	</tr>
						    </thead> 
						    <tbody class="appointment-events">
						    	<#if todayReviewInfo?? && todayReviewInfo.appoEvents?? && (todayReviewInfo.appoEvents?size>0)>
            					<#assign appoEvents = todayReviewInfo.appoEvents>
						    	<#list appoEvents as appoEvent>
						    	<tr>
				                    <td class="col-xs-0-5">${appoEvent.serialno!""}</td>
				                    <td class="col-xs-1">
				                    	<#if appoEvent.isFirstDiag >
				                    	<span class="badge badge-tag badge-first-diag">初診</span>
				                    	<#else>
				                    	<span class="badge badge-tag badge-second-diag">複診</span>
				                    	</#if>
			                    	</td>
				                    <td class="col-xs-1-5">${appoEvent.name}</td>
				                    <td class="col-xs-1-5"><#if appoEvent.gender == "M">男<#else>女</#if> / ${appoEvent.age}</td>
				                    <td class="col-xs-4"><span class="badge badge-tag"><#if appoEvent.indication??>${appoEvent.indication}</#if></span></td>
				                    <td class="col-xs-1-5">${appoEvent.appoTime}</td>
				                    <td class="col-xs-2">
				                    	<#if appoEvent.checkinTime??><span class="badge badge-checkin">${appoEvent.checkinTime} 已報到</span>
				                    	<#else>
				                    	<button class="func-btn-custom btn-primary f-14" data-case="${appoEvent.caseno}" data-slot="${appoEvent.slotId}" ><i class="fa fa-user-check"></i> 報到</button>
				                    	</#if>
			                    	</td>
				                </tr>
						    	</#list>
						    	<#else>
						    	<tr>
						    		<td class="col-xs-12">暫無看診資訊</td>
						    	</tr>
						    	</#if>						    	
						    </tbody>
						</table>
				    </div>
				    <div class="col-4">
				    	<div class="time-blk">
				    		<div class="time-content">
					            <div class="date"></div>
					            <div class="day"></div>
					        </div>
					        <div class="time-content">
					            <div class="time"></div>
					        </div>
				    	</div>
				    	<div class="default-blk dashboard-blk">
					      	<div class="d-column d-today-column">
					      		<span class="d-title">今日預約個案</span>
								<#if todayReviewInfo?? && todayReviewInfo.waitCheckinNum??>
					      		<span>待報到人數：<p>${todayReviewInfo.waitCheckinNum}</p> 位</span>
								</#if>
				      		</div>
					      	<div class="d-column d-update-column">
					      		<span class="d-title">歷程更新個案</span>
								<#if todayReviewInfo?? && todayReviewInfo.trainingUpdateCaseNum??>
					      		<span>待檢視人數：<p>${todayReviewInfo.trainingUpdateCaseNum}</p> 位</span>
								</#if>
				      		</div>
					      	<div class="d-column d-abnormal-column">
					      		<span class="d-title">訓練異常個案</span>
								<#if todayReviewInfo?? && todayReviewInfo.abnormalCaseNum??>
					      		<span>待檢視人數：<p>${todayReviewInfo.abnormalCaseNum}</p> 位</span>
								</#if>
				      		</div>
						</div>
				    </div>
			  	</div>			  	
			  	<div class="default-blks track-blks">
			  		<div class="col-9 default-blk track-blk">
			  			<div class="title">個案訓練進展</div>
			  			<#if roleAlias == "DOCTOR" || roleAlias == "ADMIN">
						<table class="table table-fixed">
							<thead>
						      	<tr>
						      		<th class="col-xs-0-5">序</th>
				                    <th class="col-xs-1-5">姓名</th>
				                    <th class="col-xs-1-5">性別/年齡</th>
				                    <th class="col-xs-3">適應症</th>
				                    <th class="col-xs-2">領域/治療師</th>
				                    <th class="col-xs-2-5">目前訓練教案</th>
				                    <th class="col-xs-1">狀態</th>
						      	</tr>
						    </thead>
						    <tbody class="track-events">
						    	<#if todayReviewInfo?? && todayReviewInfo.trainingEvents?? && (todayReviewInfo.trainingEvents?size > 0 ) >
						    	<#list todayReviewInfo.trainingEvents as trainingEvent>
						    	<tr>
						    		<td class="col-xs-0-5">${trainingEvent.serialno!""}</td>
						    		<td class="col-xs-1-5">${trainingEvent.name!""}</td>
						    		<td class="col-xs-1-5"><#if trainingEvent.gender == "M">男<#else>女</#if> / ${trainingEvent.age!""}</td>
						    		<td class="col-xs-3"><span class="badge badge-tag">${trainingEvent.indication!""}</span></td>
						    		<td class="col-xs-2">${trainingEvent.therapCat!""} / ${trainingEvent.therapist!""}</td>
						    		<td class="col-xs-2-5">${trainingEvent.lesson!""}</td>
						    		<td class="col-xs-1"><span class="badge badge-tag badge-abnormal"><#if trainingEvent.isAbnormal>異常<#else>正常</#if></span></td>
						    	</tr>
						    	</#list>
						    	<#else>
						    	<tr>
						    		<td class="col-xs-12">暫無訓練進展資訊</td>
						    	</tr>
						    	</#if>						    	
						    </tbody>
						</table>
						<#else>
						<table class="table table-fixed">
							<thead>
						      	<tr>
				                    <th class="col-xs-1-5">姓名</th>
				                    <th class="col-xs-1-5">性別/年齡</th>
				                    <th class="col-xs-2">適應症</th>
				                    <th class="col-xs-2">訓練教案</th>
				                    <th class="col-xs-1-5">訓練頻率</th>
				                    <th class="col-xs-2-5">起始日期/治療週數</th>
				                    <th class="col-xs-1">狀態</th>
						      	</tr>
						    </thead>
						    <tbody class="track-events">
						    	<#if todayReviewInfo?? && todayReviewInfo.trainingEvents?? && (todayReviewInfo.trainingEvents?size > 0 ) >
						    	<#list todayReviewInfo.trainingEvents as trainingEvent>
						    	<tr>
						    		<td class="col-xs-1-5">${trainingEvent.name!""}</td>
				                    <td class="col-xs-1-5"><#if trainingEvent.gender == "M">男<#else>女</#if> / ${trainingEvent.age!""}</td>
				                    <td class="col-xs-2"><span class="badge badge-tag">${trainingEvent.indication!""}</span></td>
				                    <td class="col-xs-2">${trainingEvent.lesson!""}</td>
				                    <td class="col-xs-1-5">${trainingEvent.frequency!""}/${trainingEvent.times!""}次</td>
				                    <td class="col-xs-2-5">${trainingEvent.beginDate!""} / ${trainingEvent.duration!""}週</td>
				                    <td class="col-xs-1"><span class="badge badge-tag badge-abnormal"><#if trainingEvent.isAbnormal>異常<#else>正常</#if></span></td>
						    	</tr>
						    	</#list>
						    	<#else>
						    	<tr>
						    		<td class="col-xs-12">暫無訓練進展資訊</td>
						    	</tr>
						    	</#if>						    	
						    </tbody>
						</table>
						</#if>
			  		</div>
			  		<div class="arrow arrow-right"></div>
			  		<div class="col-3 default-blk history-blk">
			  			<div class="title"><p>葉安翰</p>個案訓練歷程</div>
						<ul class="timeline">
							<li>
								<a>2024/12/11</a>
								<p>完成本週第一次訓練</p>
							</li>
							<li>
								<a>2024/12/12</a>
								<p>完成本週第二次訓練</p>
							</li>
							<li class="abnormal">
								<a>2024/12/13</a>
								<p>訓練狀態異常</p>
							</li>
						</ul>
			  		</div>
			  	</div>
			</div>
		</div>
	</div>
</body>

<script>

document.addEventListener('DOMContentLoaded', function() {
    function updateTime() {
        var now = new Date();
        
        // 格式化日期
        var dateString = getNowDate(now);
        var timeString = getGMTTime(now);

        var days = ['<@spring.message "appointment.label.sun"/>', '<@spring.message "appointment.label.mon"/>', 
        			'<@spring.message "appointment.label.tue"/>', '<@spring.message "appointment.label.wed"/>', 
        			'<@spring.message "appointment.label.thur"/>', '<@spring.message "appointment.label.fri"/>',
        			'<@spring.message "appointment.label.sat"/>'];
        var dayString = days[now.getDay()];

        // 更新DOM
        $('.time-blk .date').text(dateString);
        $('.time-blk .day').text(dayString);
        $('.time-blk .time').text(timeString);
    }
    
    function scheduleUpdate() {
	    var now = new Date();
	    var secondsUntilNextMinute = 60 - now.getSeconds();
	    setTimeout(function() {
	        updateTime();
	        setInterval(updateTime, 60000);
	    }, secondsUntilNextMinute * 1000);
	}

    updateTime();
	scheduleUpdate();
	
	// 預設點擊第一筆訓練計畫
	$(".track-events tr:first").trigger("click");
});


$(document).ready(function(){
	activTrack();
});

/*$(".track-events tr").click(function(){
	$(".track-events tr").removeClass("selected");
	$(this).toggleClass("selected");
	
	$('.arrow, .history-blk').fadeIn(1000); // 1秒淡入
});*/
$(".track-events tr").click(function(){
    // 移除所有 tr 的 selected class
    $(".track-events tr").removeClass("selected");
    // 為當前點擊的 tr 添加 selected class
    $(this).toggleClass("selected");
    <#if roleAlias == "ADMIN" || roleAlias == "DOCTOR">
    // 取得被點擊的 tr 中第二個 td（姓名欄位）的文字
    var name = $(this).find("td:eq(1)").text();
    <#else>
    if($(this).find("td:eq(0)").hasClass('col-xs-12')){
    	var name = "";
    } else {
    	var name = $(this).find("td:eq(0)").text();
    }
    </#if>
    // 更新 history-blk 的標題
    $(".history-blk .title p").text(name);
    
    // 顯示 history-blk
    $('.arrow, .history-blk').fadeIn(1000);
});


$(".appointment-events button").click(function(){
	var caseno = $(this).attr("data-case");
	var slot = $(this).attr("data-slot");
	//wg.evalForm.getJson("", "/checkpoint/api/checkin");
	console.log("caseno: ", caseno);
	console.log("slot: ", slot);
	<#if roleAlias == "DOCTOR">
	window.open("/ftl/imas/diagnosis/doctor?patientId=" + caseno + "&slot=" + slot);
	<#else>
	window.open("/ftl/imas/diagnosis/therapist?patientId=" + caseno + "&slot=" + slot);
	</#if>
});

function activTrack(){
	<#if trainingEvents?? && (trainingEvents?size > 0 ) >
	$(".track-events tr:eq(0)").trigger('click');
	</#if>
}

</script>

<style>

.appointment-events tr td,
.track-events tr td{
	display: flex;
	align-items: center;
}

.time-blk{
	position: relative;
	width: 100%;
	height: 120px;
	border-radius: 5px;
	margin-bottom: 5px;
	background: url('/html/images/dccs/time-bk.png') no-repeat center center;
	background-size: cover;
	/*額外*/
	display: flex;
    justify-content: center;
    align-items: center;
    color: #ffffff;
    font-size: 18px;
    font-weight: bold;
    text-align: center;
}

.time-blk::before {
    content: '';
    position: absolute; /* 使覆蓋圖層確實覆蓋於背景圖之上 */
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.55); /* 設置灰色背景並設置透明度 */
    border-radius: 5px; /* 可選：設置圓角 */
}

.time-content {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
    padding: 5px;
    position: relative; /* 確保白色文字位置在時間內容之後 */
    z-index: 1; /* 將白色文字設置在灰色透明層之上 */
}

.date, .day {
    font-size: 24px;
}

.day {
    margin-top: 5px;
}

.time {
    font-size: 48px;
}

.date, .day, .time {
    margin: 0; /* 确保没有额外的外边距 */
}

.dashboard-blk{
	font-size: 16px;
}

.d-column{
	background: #FAFAFA;
	border: 0.1px solid #bfbfbf;
	border-radius: 5px;
	padding: 8px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.d-column:not(:last-child){
	margin-bottom: 5px;
}


.d-column span.d-title {
    position: relative;
    padding-left: 30px; /* 根據圖標的大小和間距調整 */
    font-weight: 600;
}

/* 統一設置圖標大小和樣式 */
.d-column span.d-title:before {
    font-family: 'FontAwesome'; /* 確保使用 Font Awesome 字體 */
    font-weight: 900; /* 確保使用 Font Awesome 的粗體字重 */
    color: #ffffff; /* 設置圖標顏色 */
    background-color: #00CB96; /* 設置圖標背景顏色 */
    width: 20px; /* 固定寬度 */
    height: 20px; /* 固定高度 */
    display: flex; /* 使用 Flexbox 居中圖標 */
    align-items: center; /* 垂直居中 */
    justify-content: center; /* 水平居中 */
    border-radius: 4px; /* 設置圓角 */
    margin-right: 5px; /* 圖標與文本的間距 */
    position: absolute; /* 確保圖標相對於父元素定位 */
    left: 0; /* 圖標在左側 */
    top: 50%; /* 垂直居中 */
    transform: translateY(-50%); /* 垂直居中調整 */
    padding: 13px; /* 移除內邊距，讓圖標大小一致 */
    box-sizing: border-box; /* 確保寬高包含邊框和內邊距 */
}

.d-today-column span.d-title:before{	
	content: '\f073';	
}

.d-update-column span.d-title:before{	
	content: '\f4fd';	
}

.d-abnormal-column span.d-title:before{	
	content: '\e53f';	
}

.d-column span p{
	display: inline;
	font-weight: 600;
	font-size: 24px;
	color: #009E75;
}

/*歷程 plugin*/
ul.timeline {
    list-style-type: none;
    position: relative;
    max-height: 300px;
    overflow-y: auto;
    padding-top: 10px;   
}
ul.timeline:before {
    content: ' ';
    background: #d4d9df;
    display: inline-block;
    position: absolute;
    left: 27px;
    width: 5px;
    height: 100%;
    z-index: 400;
}
ul.timeline > li {
    margin: 20px 0;
    padding-left: 20px;
}
ul.timeline > li:before {
    content: ' ';
    background: white;
    display: inline-block;
    position: absolute;
    border-radius: 50%;
    border: 5px solid #3EA441;
    left: 20px;
    width: 20px;
    height: 20px;
    z-index: 400;
}
ul.timeline > li.abnormal:before {
	border: 5px solid #FFD233;
}

ul.timeline > li > a{
	color: #595959;
	font-weight: 600;
	font-size: 16px;
	text-decoration: none;
}

</style>	

<#-- <#include "/skins/imas/casemgnt/socket.ftl" /> -->
<#include "/imas/widget/widget.ftl" />