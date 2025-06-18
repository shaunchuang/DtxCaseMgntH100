if(typeof(wg) === "undefined"){var wg = function(){}};
wg.template = {};
$.extend(wg.template, {
	SingleSelectValid: function(single, formId) {	
		var count = 0;
		if(!formId) count = $('input:checkbox[name=id]:checked').length;
		else       count = $('#'+formId+' input:checkbox[name=id]:checked').length;
		if(count==0) { alert("請選擇其中一筆紀錄!"); return false;}
		if(count>1 && single==1) { alert("僅能單選!"); return false;}
		return true;
	},

	checkAll : function(_this, cbName) {
		var array = document.getElementsByName(cbName);
		for ( var i = 0; i < array.length; i++) {
			array[i].checked = _this.checked;
		}
	},
	
	popupWindow: function(submitData, url){
		$.ajax({
			url: url,
			type: "POST",
			data: submitData,
			async: false,
			success: function (data) {
		        var popupWin = window.open('', '_blank');
		        popupWin.document.open();
		        popupWin.document.write(data);
		        popupWin.document.close();
			}
		});
	},
	
	replaceDomContent: function(domId, data){
		var tmp = $('<div></div>').html(data);
		var content = $(tmp).find("#myPageContent").html();
		$("#" + domId).html(content);
		
		//為表格加入排序的功能
		if (typeof loadSorted === "function") {
			loadSorted();
		} 
	},
	
	replaceNewDomContent: function(domId, replaceId, data){
		var tmp = $('<div></div>').html(data);
		var content = $(tmp).find("#" + replaceId).html();

		// 檢查是否找到 replaceId 的內容
		if (content) {
			$("#" + domId).html(content);
		} else {
			console.error("替換失敗: 找不到 Replace ID = " + replaceId + " 的內容");
			return false; // 返回失敗標誌
		}

		//為表格加入排序的功能
		if (typeof loadSorted === "function") {
			loadSorted();
		} 
	},
	
	updateDomContent: function(domId, submitData, url){
		$.ajax({
			url: url,
			type: "POST",
			data: submitData,
			async: false,
			success: function (data, status, xhr) {
				if (data.indexOf("/doSecurity")>0) {
					window.location=BASE_URL+"/login";
				}else{
					var isHTML = RegExp.prototype.test.bind(/(<([^>]+)>)/i);
					if(isHTML(data)){
						wg.template.replaceDomContent(domId, data);
					}
					else{
						var obj = JSON.parse(data);
						return obj;
					}	            	

				}
					
			}
		});
	},
	
	updateNewDomContent: function(domId, replaceId, submitData, url){
		showTimerHintSwal("Loading...", 1000);
		$.ajax({
			url: url,
			type: "POST",
			data: submitData,
			async: true,
			success: function (data, status, xhr) {
				if (data.indexOf("/doSecurity")>0) {
					window.location=BASE_URL+"/login";
				}else{
					var isHTML = RegExp.prototype.test.bind(/(<([^>]+)>)/i);
					
					if(isHTML(data)){
						wg.template.replaceNewDomContent(domId, replaceId, data);
					}
					else{
						var obj = JSON.parse(data);
						return obj;
					}	            	

				}
					
			}
		});
	},

	updateNewDomContentV2: function(domId, replaceId, submitData, url){
		showTimerHintSwal("Loading...", 1000);
		$.ajax({
			url: url,
			type: "GET",
			data: submitData,
			async: true,
			success: function (data, status, xhr) {
				if (data.indexOf("/doSecurity")>0) {
					window.location=BASE_URL+"/login";
				}else{
					var isHTML = RegExp.prototype.test.bind(/(<([^>]+)>)/i);
					
					if(isHTML(data)){
						wg.template.replaceNewDomContent(domId, replaceId, data);
					}
					else{
						var obj = JSON.parse(data);
						return obj;
					}	            	

				}
					
			}
		});
	},
	
	updateDomContentWithASync: function(domId, submitData, url){
		$.ajax({
			url: url,
			type: "POST",
			data: submitData,
			async: true,
			success: function (data) {
				if (data.indexOf("/doSecurity")>0) {
					window.location=BASE_URL+"/login";
				} else
					wg.template.replaceDomContent(domId, data); 
			}
		});
	},
	
	updatePageContent: function(submitData, url){
		wg.template.updateDomContent('wg-tabContainer', submitData, url);
	},
	
	updateNewPageContent: function(formId, replaceId, submitData, url){
		wg.template.updateNewDomContent(formId, replaceId, submitData, url);
	},

	updateNewPageContentV2: function(formId, replaceId, submitData, url){
		wg.template.updateNewDomContentV2(formId, replaceId, submitData, url);
	},
	
	multiPartSubmitForm: function(formID, dataUriIDs){
		var submitData = new FormData($("#"+formID)[0]);
		var action = $("#"+formID).attr("action");
		var data_uri = "";
		var blob = "";
		
		//將Image的DataUri轉換成Blob物件，接著上傳到Server
		if(dataUriIDs){
			for(var i=0; i<dataUriIDs.length; i++){
				var data_uri = $("#"+dataUriIDs[i]).attr("src");
				var blob = this.dataURItoBlob(data_uri);
				submitData.append(dataUriIDs[i], blob);
			}
		}
		
		$.ajax({
			url: action,
			type: "POST",
			data: submitData,
			cache: false,
          	contentType: false,
          	processData: false,
			async: false,
			success: function (data) {
				wg.template.replaceDomContent('wg-tabContainer', data);
			}
		});
		
	},
	
	ajaxSubmitMultiPartForm: function(formID, dataUriIDs, isAsync, callback){
		var submitData = new FormData($("#"+formID)[0]);
		var action = $("#"+formID).attr("action");
		var data_uri = "";
		var blob = "";
		
		//將Image的DataUri轉換成Blob物件，接著上傳到Server
		if(dataUriIDs){
			for(var i=0; i<dataUriIDs.length; i++){
				var data_uri = $("#"+dataUriIDs[i]).attr("src");
				var blob = this.dataURItoBlob(data_uri);
				submitData.append(dataUriIDs[i], blob);
			}
		}
		
		if(!isAsync) isAsync = false;
		
		$.ajax({
			url: action,
			type: "POST",
			data: submitData,
          	contentType: false,
          	processData: false,
			async: isAsync,
			dataType: "json",
			success: function (data) {
				if(typeof callback === "function") callback();
				if(data.msg){
					alert(data.msg);
				}
			}
		});
	},
	
	dataURItoBlob: function (dataURI) {
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
	},
	
	submitForm: function(formID, replaceId, action){
		if(!action){
			action = $("#"+formID).attr("action");
		}else if(action.endsWith("/login")){
			window.location=action;
			return;
		}
		var data = $("#"+formID).serialize();
		
		wg.template.updateNewPageContent(formID, replaceId, data, action);
	},
	
	confirmSubmit : function(formId, action, msg) {
		var default_msg = '確認刪除選擇項嗎？';
		if (msg) {
			if (msg.endsWith("/login")){
				window.location=msg;
				return
			} else
				default_msg = msg;
		}
		if (confirm(default_msg)) {
			wg.template.submitForm(formId, action);
		}
	},
	
	resetFormInput: function(formID){
		$('#' + formID + " input").not(':button, :submit, :reset, :hidden').val('').removeAttr('checked');
		$('#' + formID + " option:selected").removeAttr("selected");
	},
	
	updatePageContentByTreeItem: function(base, submitData, treeItemId){
		var url = wg.template.getCallBackByTreeItem(base, treeItemId);
		if(url){ 
			if (url.endsWith("/login"))
				window.location=base + url;
			else
				wg.template.updatePageContent(submitData, base + url);
		}
	},
	
	updateRightViewByTreeItem: function(base, submitData, treeItemId){
		var url = wg.template.getCallBackByTreeItem(base, treeItemId);
		if(url){
			if (url.endsWith("/login"))
				window.location=base + url;
			else
				wg.template.updateDomContent("rightViewContainer", submitData, base + url);
		}
	},
	
	getCallBackByTreeItem: function(base, treeItemId){
		var callBack = "";
		$.ajax({
			url: base + "/widget/treeItemCallback",
			type: "POST",
			data: {"id": treeItemId},
			async: false,
			success: function (url) {
				callBack = url;
			}
		});
		return callBack;
	},
	
	isValidImage: function (fileName) {
		var ext = this.getExtension(fileName).toLowerCase();
		var validExt = ["png", "jpg"];
		var found = $.inArray(ext, validExt) > -1;
		if(!found){
			alert("僅支援圖片格式：["+validExt.join()+"]");
		}
		return found;
	},
	
	getExtension: function (fileName){
	  	if(fileName){
	   		var pos = fileName.lastIndexOf('.');
	   		if(pos>-1){
	   			return fileName.substring(pos+1, fileName.length);
	   		}
	   	}
	   	return "";
	},
	
	progressStart: function(){
		var obj={};
		
		$.ajax({
			url: BASE_URL+"/createProgressBar",
			type: "POST",
			async: false,
			dataType: "json",
			success: function (data) {
				obj.pid = data.pid;
			}
		});
		if($("#zzprogressModal").length<=0){
			var pb = '<div id="zzprogressModal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false"><div class="modal-dialog"><div class="modal-content"><div class="modal-body"><div class="text-center msgInfo">Please wait ...</div><div class="progress"><div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:100%"></div></div></div></div></div></div>';
			$(pb).appendTo("body");
		}
		wg.template.progressValue(0);
		$("#zzprogressModal").modal('show');
		obj.intervalId = setInterval(function(){
			$.ajax({
				url: BASE_URL+"/getProgressBar",
				data:{
					pid: obj.pid
				},
				type: "POST",
				dataType: "json",
				success: function(data){
					if(data.percentage!=-1){
						wg.template.progressValue(data.percentage);
					}
					if(data.msg){
						$("#zzprogressModal .msgInfo").text(data.msg);
					}
				}
			});
		}, 500);
		return obj;
	},
	
	progressEnd: function(pbObj){
		$.ajax({
			url: BASE_URL+"/deleteProgressBar",
			data:{
				pid: pbObj.pid
			},
			type: "POST",
			async: false
		});
		wg.template.progressValue(100);
		setTimeout(function(){$("#zzprogressModal").modal('hide');}, 500);
		clearInterval(pbObj.intervalId);
	},
	
	progressValue: function(percentage){
		$("#zzprogressModal .progress-bar").attr("aria-valuenow", percentage);
		$("#zzprogressModal .progress-bar").css("width", percentage+"%");
		$("#zzprogressModal .progress-bar").text(percentage+"%");
	},
	
	momCheckinDate: function(days){
		if($("#momTemplateInfo div:eq(1) label:eq(1)").html()){
			var date = new Date($("#momTemplateInfo div:eq(1) label:eq(1)").html().replace(/\//g, "-"));
			if(days) date.addDays(days);
			return wg.template.formatDate(date);
		}else{
			return "";
		}
	},
	
	momCheckoutDate: function(days){
		if($("#momTemplateInfo div:eq(1) label:eq(2)").html()){
			var date = new Date($("#momTemplateInfo div:eq(1) label:eq(2)").html().replace(/\//g, "-"));
			if(days) date.addDays(days);
			return wg.template.formatDate(date);
		}else{
			return "";
		}
	},
	
	babyCheckinDate: function(days){
		if($("#babyTemplateInfo div:eq(1) label:eq(1)").html()){
			var date = new Date($("#babyTemplateInfo div:eq(1) label:eq(1)").html().replace(/\//g, "-"));
			if(days) date.addDays(days);
			return wg.template.formatDate(date);
		}else{
			return "";
		}
	},
	
	babyCheckoutDate: function(days){
		if($("#babyTemplateInfo div:eq(1) label:eq(2)").html()){
			var date = new Date($("#babyTemplateInfo div:eq(1) label:eq(2)").html().replace(/\//g, "-"));
			if(days) date.addDays(days);
			return wg.template.formatDate(date);
		}else{
			return "";
		}
	},
	
	formatDate: function (date) {
	    var d = new Date(date),
	        month = '' + (d.getMonth() + 1),
	        day = '' + d.getDate(),
	        year = d.getFullYear();

	    if (month.length < 2) month = '0' + month;
	    if (day.length < 2) day = '0' + day;

	    return [year, month, day].join('-');
	}
});
