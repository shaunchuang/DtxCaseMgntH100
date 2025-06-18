/**
 * @Author: Jian-Hong
 * @Since: 2016/09/10
 */

if(typeof(wg) === "undefined"){var wg = function(){}};
if(typeof(wg.utils) === "undefined"){wg.utils = {}};
wg.utils.evalFormUser = {};
$.extend(wg.utils.evalFormUser, {
	getEvalFormSubmitData: function(domId, userId){
		var data = new FormData();
		var items = new Set();
		$("#"+domId).find(".evalFormContent").find(".evalInput").each(function(){
			var evalItemId = $(this).attr("data-item");
			if($(this).is("input")){
				switch($(this).attr("type")){
				case "radio":
					if($(this).is(':checked')){
						items.add(evalItemId);
					}
					break;
				case "checkbox":
					if($(this).is(':checked')){
						items.add(evalItemId);
					}
					break;
				case "text": case "hidden":
					if($(this).val()){
						items.add(evalItemId);
						data.append("i-"+evalItemId+"-str", $(this).val());
					}
					break;
				}
			}else if($(this).is("textarea")){
				if($(this).val()){
					items.add(evalItemId);
					data.append("i-"+evalItemId+"-str", $(this).val());
				}
			}else if($(this).is("img")){
				if('true'===$(this).attr('data-upload')){
					items.add(evalItemId);
					var data_uri = $(this).attr("src");
					var blob = null;
					try {
						blob = dataURItoBlob(data_uri);
					}catch(err) {
					}
					data.append("i-"+evalItemId+"-img", blob);
				}
			}
		});
		if(items.size>0){
			data.append("items", Array.from(items).join(","));
		}
		data.append("isCopy", $("#"+domId).find(".isCopy").val());
		data.append("evalFormUserId", $("#"+domId).find(".evalFormUserId").val());
		data.append("evalFormId", $("#"+domId).find(".evalFormId").val());
		data.append("userId", userId);
		return data;
	}
});

function mySubmitForm(data){
	var form;
    form = $('<form />', {
     			action: "${base}/employee/evalForm/create/save",
       			method: "POST",
       			style: 'display: none;'
    		});
    			
   	for (var k in data) {
   	   if (data.hasOwnProperty(k)) {
   		   		$('<input />', {
          			type: 'hidden',
           			name: k,
           			value: data[k]
       			}).appendTo(form);
    	}
	}
   	form.appendTo('body').submit();
}

function triggerQuestion(obj, evalItemId){
	var span = $(obj).parent().parent().find("span.triggerGroup");
	$(span).html("");
	if($(obj).is(':checked')){
		$("span.tq"+evalItemId).each(function(){
			$(span).append($(this).html());
		});
	}
}

function dataURItoBlob(dataURI) {
    // convert base64/URLEncoded data component to raw binary data held in a string
    var byteString;
    if (dataURI.split(',')[0].indexOf('base64') >= 0)
        byteString = atob(dataURI.split(',')[1]);
    else
        byteString = unescape(dataURI.split(',')[1]);

    // separate out the mime component
    var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];

    // write the bytes of the string to a typed array
    var ia = new Uint8Array(byteString.length);
    for (var i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i);
    }

    return new Blob([ia], {type:mimeString});
}

$(function(){
	$("span.parentQuestionGroup").each(function(){
		var evenQuestionId = $(this).attr("data-param");
		$(this).append($(this).closest(".evalFormContent").parent().find("#hasParentQuestionPool span.pq"+evenQuestionId));
	});
	
	var opt_date={
		dateFormat: 'yy-mm-dd',
		showSecond: false,
		showMillisec: false,
		controlType:"select",
		changeYear: true,
		changeMonth: true,
		yearRange: "-100:+20"
	};
	//DatePicker
	$(".evalDateInput").datepicker(opt_date);
	
	//TimePicker
	$(".evalTimeInput").timepicker({
		show2400: true,
		'timeFormat': 'H:i'
	});
	
	//DatetimePicker
	var opt_datetime = {
	        dateFormat: 'yy-mm-dd',
	        showSecond: false,
	        showMillisec: false,
	        timeFormat: 'HH:mm',
	        controlType: "select"
	    };
	$(".evalDateTimeInput").datetimepicker(opt_datetime);
	
	//加入反勾選Radio功能
	$(".evalFormContent input:radio").parent().mouseup(function() {
		$(this).find("input:radio").trigger('mouseup');
	});
	$(".evalFormContent input:radio").mouseup(function(event) {
		event.stopPropagation();
		if($(this).is(':checked')){
			$(this).attr('previousValue', 'true');
		}else{
			$(this).attr('previousValue', 'false');
		}
    });
    $(".evalFormContent input:radio").click(function() {
    	if($(this).attr('previousValue') == 'true'){
    		$(this).prop("checked", false);
    	}
    });
});