<#-- <#import "/META-INF/spring.ftl" as spring /> -->
<#-- <#import "/META-INF/mspring.ftl" as mspring /> -->
<#import "/util/spring.ftl" as spring />
 
<div id="${moduleContent!""}">
	<#if message?exists >
		<#if message == "chooseMessage">
		<div class="info-message">
			<i class="fa fa-calendar-days"></i>
			<span>請先選擇醫師/治療師，再選擇預約時段</span>
		</div>
		</#if>
	<#else>
	<div id="${pickerId!""}"></div>
	<div class="hidden">
        <p>Selected date: <input type='text' class="form-control" <#if category?? >id="${category!""}-selected-date"<#else>id="selected-date"</#if> />
        <p>Selected time: <input type='text' class="form-control" <#if category?? >id="${category!""}-selected-time"<#else>id="selected-time"</#if> />
    </div>
    
    <script type="text/javascript" src="${base}/script/woundInfo/jquery-2.2.0.min.js"></script>   
	<script type="text/javascript" src="${base}/script/woundInfo/bootstrap.min.js"></script>
	<!--<script type="text/javascript" src="${base}/script/imas/utility.js?${.now}"></script>-->
	<script type="text/javascript" src="${base}/script/woundInfo/dataTables/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="${base}/script/woundInfo/dataTables/dataTables.bootstrap.min.js"></script>
	<script type="text/javascript" src="${base}/script/imas/widget/appointment.js"></script> 
	<link href="${base}/style/imas/widget/appointment.css" rel="stylesheet" type="text/css">
    <script>	
	var $ = jQuery.noConflict();
	var loaded = false;
	$(document).ready(function() {
		
		<#if !message?exists >
		$.when(
	        $.Deferred(function(deferred) {        	
	            if (typeof $.fn.markyourcalendar !== 'undefined') {
	                deferred.resolve();
	            } else {
	                // 使用 setInterval 確認 markyourcalendar 是否載入完畢                
	                var checkPlugin = setInterval(function() {
	                    if (typeof $.fn.markyourcalendar !== 'undefined' && $('#${pickerId!""}').is(':empty')) {
	                        clearInterval(checkPlugin);
	                        deferred.resolve();
	                    }else{
	                    	$import("${base}/script/imas/widget/appointment.js");
	                    }
	                }, 1000);  //每100毫秒檢查一次
	            }
	        })
	    ).done(function() {
	        // 載入完成後執行
	        <#if doctorId??>
	        	if(!loaded){
	            	triggerAppointment('${pickerId!""}', '${category!""}-reserve-time');
	            	loaded = true;
            	}
	        <#else>
	            swal("查詢失敗", "無法取得看診時間資訊", "error");
	        </#if>
	    });
		</#if>
	});
	
	function triggerAppointment(objId, reserveId){
		var queryData = {"beginDate": "${toDate!""}", "doctor": <#if doctorId??>${doctorId}</#if>};
		var result = wg.evalForm.getJson(JSON.stringify(queryData), "/WgAvailableSlots/api/qry");

		if(result.success){
			$('#' + objId).markyourcalendar({
		        months:['<@spring.message "appointment.label.jan"/>','<@spring.message "appointment.label.feb"/>','<@spring.message "appointment.label.mar"/>',
		        		'<@spring.message "appointment.label.apr"/>','<@spring.message "appointment.label.may"/>','<@spring.message "appointment.label.jun"/>',
		        		'<@spring.message "appointment.label.jul"/>','<@spring.message "appointment.label.aug"/>','<@spring.message "appointment.label.sep"/>',
		        		'<@spring.message "appointment.label.oct"/>','<@spring.message "appointment.label.nov"/>','<@spring.message "appointment.label.dec"/>'],
		        weekdays:['<@spring.message "appointment.label.sun"/>','<@spring.message "appointment.label.mon"/>','<@spring.message "appointment.label.tue"/>','<@spring.message "appointment.label.wed"/>',
		        		  '<@spring.message "appointment.label.thur"/>','<@spring.message "appointment.label.fri"/>','<@spring.message "appointment.label.sat"/>'],
		        availability: result.slots,
		        startDate: new Date("${toDate!""}"),
		        onClick: function(ev, data) {

		          	var cnt = data[0];
					var d = cnt.split(' ')[0];
		          	var t = cnt.split(' ')[1];
		          	$('.' + reserveId + '[data-cat="date"]').val(d);
		          	$('.' + reserveId + '[data-cat="time"]').val(t);
		          	$('#${category!""}-selected-date').val(d);
		          	$('#${category!""}-selected-time').val(t);
		          	//$("#myModal").modal('hide');
		        },
		        onClickNavigator: function(ev, startDate, instance) {
		        	var beginDate = formatGMTDate(startDate);		        	
		        	triggerAvailableSlots(beginDate, instance);
		        }
		  	});
	  	}

	  	
	  	checkExistDate();
	}
	
	function triggerAvailableSlots(beginDate, instance){
		var queryData = {"beginDate": beginDate, "doctor": <#if doctorId??>${doctorId}</#if>};
		var result = wg.evalForm.getJson(JSON.stringify(queryData), "/WgAvailableSlots/api/qry");
		if(result.success){
			instance.setAvailability(result.slots);
		}
	}
	
	//檢視有無點選預約日期-->點選預約按鈕需判斷
	function checkExistDate(){
		
	}
	
	</script>
	</#if>
	<style>
	.info-message{
		width: 100%;
		height: 100%;
		min-height: 300px;
		display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        background: #f2f2f2;
	}
	
	.info-message i{
		font-size: 48px;
		margin-bottom: 10px;
	}
	
	.info-message span{
		font-size: 18px;
		font-weight: 600;
	}
	</style>
</div>
