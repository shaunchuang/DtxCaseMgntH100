<script type="text/javascript" src="${base}/script/socket.io.min.js?"></script>
<script type="text/javascript" src="${base}/script/corner-popup.min.js"></script>
<link href="${base}/style/corner-popup.min.css" rel="stylesheet" type="text/css" media="all" />

<script>
var socket = io('${WebSocketUrl}');
var itemArr = ['<@spring.message "inspect.label.all"/>','<@spring.message "inspect.label.ophthalmoscope"/>','<@spring.message "inspect.label.wound"/>','<@spring.message "inspect.label.ultrasound"/>','<@spring.message "inspect.label.ecg"/>','<@spring.message "inspect.label.spirometer"/>','<@spring.message "inspect.label.otoscope"/>','<@spring.message "inspect.label.hearingDetector"/>','<@spring.message "inspect.label.dermatoscope"/>'];

socket.on('division', function(jobj){
	var obj = JSON.parse(jobj);
	var desc = obj.msg;
	var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getLanguageLabel?labelName=" + desc);
	if(result.success){
		var labelTxt = result.labelTxt;
		if(labelTxt.indexOf("[patientName]") != -1) labelTxt = labelTxt.replace("[patientName]", obj.patientName);
		if(labelTxt.indexOf("[itemTxt]") != -1) labelTxt = labelTxt.replace("[itemTxt]", itemArr[obj.itemNo]);
		if(labelTxt.indexOf("[evalDate]") != -1) labelTxt = labelTxt.replace("[evalDate]", obj.evalDate);
	
		GrowlNotification.notify({
		  	title: '<@spring.message "socket.attention"/>',
		  	description: labelTxt,
		  	type: obj.msgType,
		  	image: {
		  		visible: true,
		  		customImage: "${base}/images/woundInfo/" + obj.msgType + ".png"
	  		},
		  	position: 'bottom-right',
		  	closeTimeout: 5000
		});
		
		doReloadWork(obj.msgCode);
	}

});

//接收醫材連線狀況
socket.on('equipConnect', function(jobj){
	var obj = JSON.parse(jobj);
	
	syncConnectInfo(obj);

});

function syncConnectInfo(obj){
	var equipNo = obj.equipNo;
	var target = $(".eq-item[data-item='" + equipNo + "']");
	var statusTag = obj.status == -1 ? "orange" : "green";
	console.log(statusTag);
	target.find(".item-t div").removeClass().addClass(statusTag);
	
	$(".caseno").val(obj.keyno);
	$(".caseInfo").find("span").html(obj.caseName);
	
	switch(equipNo){
		case 1:
			target.find(".temp").html(showValue(obj.temp));
			break;
		case 2:
			target.find(".sbp").html(showValue(obj.sbp));
			target.find(".dbp").html(showValue(obj.dbp));
			target.find(".bpm").html(showValue(obj.bpm));
			break;
		case 3:
			target.find(".u-images").html(showValue(obj.ultraSoundImages));
			break;
	}
}

function showValue(txt){
	var value = "---";
	if(txt != null) value = txt;

	return value ;
}

function doReloadWork(code){
	var keyno = $(".info-card").find("input[type=hidden]").val();
	var msgDate = getTodate();
	switch(code){
		case "S001":
			showItemImgNum(msgDate);
			break;
		case "S002":			
			if(window.location.href.indexOf("inspection") != -1){
				showPhysicalInfo(keyno);
			}
			break;
	}
}

//接收目前歸檔資訊
socket.on('archiveInfo', function(jobj){
	var obj = JSON.parse(jobj);
	$(".archive-info").find("span").html(obj.name);
	$(".caseno").val(obj.keyno);
	$(".case").html(obj.name);

});

//顯示今日檢測項目對應影像數量(20220103更新)
function showItemImgNum(msgDate){
	var target = $("#record_content").find("td:contains(" + msgDate + ")").next("td");
	console.log("target length:" + target.length);
	if(target.length > 0){
		var keyno = $(".info-card").find("input[type=hidden]").val();
		var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/multi/division/v1/api/qryItemImages?keyno=" + keyno + "&evalDate= " + msgDate + "&location=${__field}");
		if(result.success){
			for(var i=0; i<result.data.length; i++){
				target.find(".item-blk:eq(" + i + ")").find(".img-count").html(result.data[i].imgNum);
			}
		}
	}
}

</script>