var SCENE_NAME = '';
var ZONE ='';
var FLOOR=0;
var ZONE_FLOOR='';
var MAX_TARGET =30;
var flipMsgbarTimeout = null; 
var imageLazyloadTimeout = null;
var webSocketIO = null;

var requestDataAndProcessUITimeout = null; 

function imageLazyload(timeout) { 
	imageLazyloadTimeout = setTimeout(function() {
        // html content which are from KindEditor that need be replace <img src=  to <img data-original=
    	$("img").lazyload({ threshold : 200, effect : "fadeIn" });  
                       
    }, 300); 
}

function socketIO(socket) { 
} 



function unloadScene(hypeDocument, element, event, sceneName) { 
	var funcationName= 'unloadScene' + sceneName;
 	console.log(funcationName+" start"); 
 	clearTimeout(requestDataAndProcessUITimeout);
	clearTimeout(flipMsgbarTimeout);
	clearTimeout(imageLazyloadTimeout);

	SCENE_NAME = '';
	ZONE_FLOOR = '';
 	console.log(funcationName+" end"); 
}

function loadScene(hypeDocument, element, event, sceneName) {
	$("div.HYPE_element").each(function(){
		var str = $(this).css("background-image");
		if(str && str.indexOf("layout_hy")>0){
			$(this).parent().css("z-index", 1);
		}
	});

	
	var wa = $("div").filter(function() {
	    return $(this).text() === "媽媽房" ||  $(this).text() === "嬰兒室" ||  $(this).text() === "公共區" ||  $(this).text() === "外出中";
	})
	wa.css("font-size", "34px");
	wa.each(function(){
		$(this).parent().next().children().css("font-size", "34px");
	});
	
	var funcationName= 'loadScene' + sceneName;
 	console.log(funcationName+" start"); 

	SCENE_NAME = sceneName;
	
	if (SCENE_NAME=='WG15') {
		ZONE ="WG";
		FLOOR=15;
		MAX_TARGET = 30;
	} else if (SCENE_NAME=='HY02') {
		ZONE ="HY";
		FLOOR=2;
		MAX_TARGET = 60;
	} else if (SCENE_NAME=='HY03') {
		ZONE ="HY";
		FLOOR=3;
		MAX_TARGET = 40;
	} else if (SCENE_NAME=='HY05') {
		ZONE ="HY";
		FLOOR=5;
		MAX_TARGET = 40;
	} else if (SCENE_NAME=='HY06') {
		ZONE ="HY";
		FLOOR=6;
		MAX_TARGET = 40;
	} else if (SCENE_NAME=='HY07') {
		ZONE ="HY";
		FLOOR=7;
		MAX_TARGET = 40;
	} else if (SCENE_NAME=='HY08') {
		ZONE ="HY";
		FLOOR=8;
		MAX_TARGET = 40;
	}
	if(FLOOR<10)
		ZONE_FLOOR=ZONE+'0'+FLOOR;
	else
		ZONE_FLOOR=ZONE+FLOOR;

	
	requestDataAndProcessUI(hypeDocument); 	

	console.log(funcationName+" end");
}

function requestDataAndProcessUI(hypeDocument){
	var events = [];
	$.ajax({
        url: BASE_URL + "/device/ovo/wgGetData.html",
        type: "POST",
        dataType: "json",
        data: {
            contractCode: "",
            dtype: "DATA_ANN"
        },
        async:false,
        success: function(data) {
        	events = JSON.parse(data.annData);
        }
	});
	var request = $.ajax({
	    dataType: "json",
	    url: BASE_URL + "/employee/nursingOverview/babyPosition?zone="+ZONE+"&floor="+FLOOR,
	    data: "",
	    timeout: 120000,
	    success: function(positionList) {
	    	/*
	    	positionList={
	    			"id":"HY02",
	    			"items":[
	    				{"carno":"801","roomno":"801","zone":"HY","floor":"2","posname":"801","sortVal":0},
	    				{"carno":"806","roomno":"806","zone":"HY","floor":"2","posname":"806","sortVal":0},
	    				{"carno":"301","roomno":"301","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"302","roomno":"302","zone":"HY","floor":"2","posname":"","sortVal":0},
	    				{"carno":"303","roomno":"303","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"305","roomno":"305","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"306","roomno":"306","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"307","roomno":"307","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"501","roomno":"501","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"502","roomno":"502","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"506","roomno":"506","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"507","roomno":"507","zone":"HY","floor":"2","posname":"5樓走廊","sortVal":0},
	    				{"carno":"602","roomno":"602","zone":"HY","floor":"2","posname":"6樓走廊","sortVal":0},
	    				{"carno":"605","roomno":"605","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"606","roomno":"606","zone":"HY","floor":"2","posname":"606","sortVal":0},
	    				{"carno":"701","roomno":"701","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"702","roomno":"702","zone":"HY","floor":"2","posname":"702","sortVal":0},
	    				{"carno":"703","roomno":"703","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0},
	    				{"carno":"705","roomno":"705","zone":"HY","floor":"2","posname":"705","sortVal":0},
	    				{"carno":"706","roomno":"706","zone":"HY","floor":"2","posname":"嬰兒室","sortVal":0}
	    			]
	    	}
	    	*/
	    	var dataList = { 
		 		"id": positionList.id,
			    "items": []
			};
	    	
	    	for(var i=0; i<positionList.items.length; i++){
	    		if(!(positionList.items)[i].carno){
	    			positionList.items.splice(i--,1);
	    			continue;
	    		}
	    		
	    		if((positionList.items)[i].posname==""){
	    			(positionList.items)[i].posname = "嬰兒室";
	    			(positionList.items)[i].isDetected = false;
	    		}else{
	    			(positionList.items)[i].isDetected = true;
	    		}
	    		
	    		if(getPosTag((positionList.items)[i].posname)){
	    			(positionList.items)[i].mapx = (getPosTag((positionList.items)[i].posname))[0];
			    	(positionList.items)[i].mapy = (getPosTag((positionList.items)[i].posname))[1] + 20;
			    	(positionList.items)[i].postype = (getPosTag((positionList.items)[i].posname))[2];
	    		}
		    	
		    	dataList.items.push({
		    		carno: (positionList.items)[i].carno,
		    		roomno: (positionList.items)[i].roomno
		    	});
	    	}
	    	
	    	for(var i=0; i<positionList.items.length; i++){
	    		if(!(positionList.items)[i].isDetected){
	    			positionList.items.splice(i, 1);
	    			i--;
	    		}
	    	}
		
	    	
	    	var messageList = { 
				"id": "HY02",
				"items": [
					{"carno":"all","msgs":[{"type":"", "delay":7,"msg":"【警告】近日來流感疫情升溫，有感冒症狀禁止接觸寶寶"},{"type":"", "delay":5,"msg":"【公告】本週三嬰兒室將進行紫外線消毒作業!"},{"type":"", "delay":5,"msg":"【提醒】目前室外溫度31度"}]},
					{"carno":"101","msgs":[{"type":"", "delay":12,"msg":"異常事項"},{"type":"", "delay":3,"msg":"交班項目"}]}, 
					{"carno":"102","msgs":[{"type":"", "delay":12,"msg":"異常事項"},{"type":"", "delay":3,"msg":"交班項目"}]}
				]
	    	};
	    	
	    	messageList["items"][0]["msgs"] = [];
			for(var i=0; i<events.length; i++){
				messageList["items"][0]["msgs"].push({"type":"", "delay":5,"msg":events[i].name});
			}

			var eventList = {};

			processUI(hypeDocument, dataList, messageList, positionList, eventList);

			requestDataAndProcessUITimeout = setTimeout(function(){ requestDataAndProcessUI(hypeDocument) }, 10000);

	    },
	    error: function(){
	    	requestDataAndProcessUITimeout = setTimeout(function(){ requestDataAndProcessUI(hypeDocument) }, 10000);
	    }
	});
	
}


function processUI(hypeDocument, dataList, messageList, positionList, eventList){

	var elementnoMappingCarno={};
	var carnoMappingElementno={};
	var carnoMappingRoomno={}; 

	for(var key in dataList.items) {
		if (dataList.items.hasOwnProperty(key)) { 
          var elementNumber = ("0" + key).slice(-2);
          elementnoMappingCarno[elementNumber]=dataList.items[key].carno;
          carnoMappingElementno[dataList.items[key].carno]=elementNumber;
          carnoMappingRoomno[dataList.items[key].carno]=dataList.items[key].roomno;
          
          if (dataList.items[key].carno!=dataList.items[key].roomno) { 
        	  $("#"+ZONE_FLOOR+"CAR"+elementNumber + " .HYPE_element:eq(0)").html(dataList.items[key].carno); 
          } else {
        	  $("#"+ZONE_FLOOR+"CAR"+elementNumber + " .HYPE_element:eq(0)").html(dataList.items[key].carno); 
          }
          
    	} 
	}	

	var dx = 40;
	var dy = 30;
	if(ZONE_FLOOR!='HY02'){
		dx = 100;
		dy = 70;
	}
	var xxxxx=[ 0,  -dx, -dx, -dx,   0,  dx, dx,  dx,   dx,    0,  -dx, -2*dx, -2*dx, -2*dx, -2*dx, -2*dx,   -dx,     0,    dx,  2*dx, 2*dx, 2*dx, 2*dx, 2*dx];
	var yyyyy=[dy,   dy,   0, -dy, -dy, -dy,  0,  dy, 2*dy, 2*dy, 2*dy,  2*dy,    dy,     0,   -dy, -2*dy, -2*dy, -2*dy, -2*dy, -2*dy,  -dy,    0,   dy, 2*dy];
	
	for(var key=0; key<MAX_TARGET; key++) {
		if (positionList.items.hasOwnProperty(key)) {
			var elementNumber = carnoMappingElementno[positionList.items[key].carno];
	        $("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('x', 2000);  
	        $("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('y', 700); 
			$("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('nex', -2);  
	        $("#"+ZONE_FLOOR+"CAR"+elementNumber).css('left', 2000);
			$("#"+ZONE_FLOOR+"CAR"+elementNumber).css('top', 700); 
    	}
	}

	var babyCount =0;
	var babyRoomCount =0;
	var momRoomCount =0;
	var outsideCount =0;
	var publicCount =0; 
	var babyRoomCarno ="";
	var momRoomCarno ="";
	var outsideCarno ="";
	var publicCarno ="";

	var thisFloorBabyCount =0;
	var thisFloorBabyRoomCount =0;
	var thisFloorMomRoomCount =0;
	var thisFloorOutsideCount =0;
	var thisFloorPublicCount =0;

	for(var key in positionList.items) {
		if (positionList.items.hasOwnProperty(key)) { 
			var elementNumber = carnoMappingElementno[positionList.items[key].carno]; 
			
			// count baby position state
			babyCount++;
			if (positionList.items[key].postype=="嬰兒室") {
				babyRoomCount++;
				babyRoomCarno=appendCarno(babyRoomCarno,carnoMappingRoomno,positionList.items[key]);
			}else if (positionList.items[key].postype=="媽媽房") {
				momRoomCount++;
				momRoomCarno=appendCarno(momRoomCarno,carnoMappingRoomno,positionList.items[key]);
			}else if (positionList.items[key].postype=="外出") {
				outsideCount++;
				outsideCarno=appendCarno(outsideCarno,carnoMappingRoomno,positionList.items[key]);
			}else if (positionList.items[key].postype=="走廊" || positionList.items[key].postype=="交誼廳" || positionList.items[key].postype=="茶水間") {
				publicCount++;
				publicCarno=appendCarno(publicCarno,carnoMappingRoomno,positionList.items[key]);
			}
			
			if(positionList.items[key].zone==ZONE){
				if((FLOOR=="2" && (getPosTag((positionList.items)[key].posname) && FLOOR==(getPosTag((positionList.items)[key].posname))[3])) ||
					(getPosTag((positionList.items)[key].roomno) && FLOOR==(getPosTag((positionList.items)[key].roomno))[3])){
					thisFloorBabyCount++;
					if (positionList.items[key].postype=="嬰兒室") thisFloorBabyRoomCount++;
					else if (positionList.items[key].postype=="媽媽房") thisFloorMomRoomCount++;
					else if (positionList.items[key].postype=="外出") thisFloorOutsideCount++;
					else if (positionList.items[key].postype=="走廊" || positionList.items[key].postype=="交誼廳" || positionList.items[key].postype=="茶水間") thisFloorPublicCount++;
				}
			}

			// set element position to map
			if(getPosTag((positionList.items)[key].posname) && FLOOR==(getPosTag((positionList.items)[key].posname))[3]){
				$("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('y', positionList.items[key].mapy); 
		        $("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('x', positionList.items[key].mapx);  
				$("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('nex', -2);  
				$("#"+ZONE_FLOOR+"CAR"+elementNumber).css("z-index", 1000);
				
		        var nex = isPositionOccupied(positionList,MAX_TARGET,ZONE_FLOOR,positionList.items[key].mapx,positionList.items[key].mapy);
		        if (nex==-1){
		        	$("#"+ZONE_FLOOR+"CAR"+elementNumber).css('left', positionList.items[key].mapx);
					$("#"+ZONE_FLOOR+"CAR"+elementNumber).css('top', positionList.items[key].mapy); 
					$("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('nex',-1);  
				} else {
					$("#"+ZONE_FLOOR+"CAR"+elementNumber).css('left', positionList.items[key].mapx+xxxxx[nex]);
					$("#"+ZONE_FLOOR+"CAR"+elementNumber).css('top', positionList.items[key].mapy+yyyyy[nex]);
					$("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('nex', nex);  
				}
			}
    	}
	}
	
	if(FLOOR=="2"){
		//修正2樓的顯示方式
		thisFloorBabyCount = babyCount;
		thisFloorBabyRoomCount = thisFloorBabyRoomCount;
		thisFloorMomRoomCount = momRoomCount;
		thisFloorPublicCount = publicCount;
		thisFloorOutsideCount = outsideCount;
	}
	// show count
	$(floorMapping(ZONE_FLOOR,"DataText1")).html(thisFloorBabyRoomCount+'/'+thisFloorBabyCount);
	$(floorMapping(ZONE_FLOOR,"DataText2")).html(thisFloorMomRoomCount+'/'+thisFloorBabyCount);
	$(floorMapping(ZONE_FLOOR,"DataText3")).html(thisFloorPublicCount+'/'+thisFloorBabyCount);
	$(floorMapping(ZONE_FLOOR,"DataText4")).html(thisFloorOutsideCount+'/'+thisFloorBabyCount);
	$(buildingMapping(ZONE_FLOOR,"babyRoomCount")).html(babyRoomCount+'/'+babyCount);
	$(buildingMapping(ZONE_FLOOR,"momRoomCount")).text(momRoomCount+'/'+babyCount);
	$(buildingMapping(ZONE_FLOOR,"publicCount")).text(publicCount+'/'+babyCount);
	$(buildingMapping(ZONE_FLOOR,"outsideCount")).text(outsideCount+'/'+babyCount); 
	$(buildingMapping(ZONE_FLOOR,"babyRoomCarno")).text(babyRoomCarno.split(",").sort().join(","));
	$(buildingMapping(ZONE_FLOOR,"momRoomCarno")).text(momRoomCarno.split(",").sort().join(","));
	$(buildingMapping(ZONE_FLOOR,"publicCarno")).text(publicCarno.split(",").sort().join(","));
	$(buildingMapping(ZONE_FLOOR,"outsideCarno")).text(outsideCarno.split(",").sort().join(",")); 

	// process message
	clearTimeout(flipMsgbarTimeout); 
	for(var key in messageList.items) {
		if (messageList.items.hasOwnProperty(key)) { 
          var elementNumber = ("0" + key).slice(-2);
          if (messageList.items[key].carno=="all" || messageList.items[key].carno=="") {
        	  flipMsgbarTimeout = delayedFlipMsgbar(hypeDocument,messageList.items[key].msgs,0); 
        	  break;
          }
    	} 
	}
}

function buildingMapping(zoneFloor, keyword){
	var obj={
			babyRoomCount: { tr: 0, td: 1 },
			momRoomCount: { tr: 1, td: 1 },
			publicCount: { tr: 2, td: 1 },
			outsideCount: { tr: 3, td: 1 },
			babyRoomCarno: { tr: 0, td: 2 },
			momRoomCarno: { tr: 1, td: 2 },
			publicCarno: { tr: 2, td: 2 },
			outsideCarno: { tr: 3, td: 2 }
	};
	var result = floorMapping(zoneFloor, keyword);
	return $(result).find("#feature-table tr:eq("+obj[keyword].tr+") td:eq("+obj[keyword].td+")");
}

function floorMapping(zoneFloor, keyword){
	var sceneMap = {
		HY02: 0,
		HY03: 1,
		HY05: 2,
		HY06: 3,
		HY07: 4,
		HY08: 5
	};
	var zMap = {
		DataText1: 14,
		DataText2: 16,
		DataText3: 15,
		DataText4: 17
	};
	
	var result = null;
	var zIndex = zMap[keyword]==null? 9: zMap[keyword];
	$("div.HYPE_element_container").each(function(){
		if ($(this).css('z-index') == zIndex) {
			tmp = $(this).find("div[hype_scene_index='"+sceneMap[zoneFloor]+"']");
			if(tmp.length>0) result = tmp;
		}
	});
	return result;
}

function isPositionOccupied(positionList,max,ZONE_FLOOR,x,y) { 
	var returnValue = -2;
	for(var key=0; key<max; key++) {
		var elementNumber = ("0" + key).slice(-2);
		if (parseInt($("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('y'))==y && parseInt($("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('x'))==x){
			if (parseInt($("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('nex'))>returnValue ){
				returnValue=parseInt($("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('nex'));
			}
		}
	}

	return returnValue+1;
}

function delayedFlipMsgbar(hypeDocument, msgs, i){
	  if (SCENE_NAME!=''){

	  	 if (msgs.length<=0)
	  	 	return ;
	  	 else if (msgs.length==1) {
	  	 	$("#MsgBar"+SCENE_NAME+" .Text1").html(msgs[i].msg); 
	  	 } else {
		　　　if (i < msgs.length){  
				if (msgs[i].delay>6) {
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url("+BASE_URL+"/plug-in/babyPosition/hy/notifybelln.gif");
				} else {
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url("+BASE_URL+"/plug-in/babyPosition/hy/transparent.gif");
				}

				if (i==0) {
					$("#MsgBar"+SCENE_NAME+" .Text1").html(msgs[msgs.length-1].msg); 
				} else {
					$("#MsgBar"+SCENE_NAME+" .Text1").html(msgs[i-1].msg); 
				}

			   	$("#MsgBar"+SCENE_NAME+" .Text2").html(msgs[i].msg);
			   	var symbolInstance = hypeDocument.getSymbolInstanceById('MsgBar'+SCENE_NAME);
			   	symbolInstance.startTimelineNamed('Flip Timeline', hypeDocument.kDirectionForward); 
			   	 
			    
				flipMsgbarTimeout = setTimeout(function(){ delayedFlipMsgbar(hypeDocument,msgs,i+1) }, msgs[i].delay*1000);
			   //$("#MsgBar"+SCENE_NAME+" .Text1").html(msgs[i].msg); 
			   //if (msgs[i].delay>6) {
			//		$("#MsgBar"+SCENE_NAME+" .Image1").attr("src","notifybelln.gif");
			//	} else {
			//		$("#MsgBar"+SCENE_NAME+" .Image1").attr("src","transparent.gif");
			//	}
		　　　} else {
		　　　　i = 0;
				if (msgs[i].delay>6) {
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url("+BASE_URL+"/plug-in/babyPosition/hy/notifybelln.gif");
				} else {
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url("+BASE_URL+"/plug-in/babyPosition/hy/transparent.gif");
				}
				if (i==0) {
					$("#MsgBar"+SCENE_NAME+" .Text1").html(msgs[msgs.length-1].msg); 
				} else {
					$("#MsgBar"+SCENE_NAME+" .Text1").html(msgs[i-1].msg); 
				}
				
		　　　　$("#MsgBar"+SCENE_NAME+" .Text2").html(msgs[i].msg);
			   var symbolInstance = hypeDocument.getSymbolInstanceById('MsgBar'+SCENE_NAME);
				symbolInstance.startTimelineNamed('Flip Timeline', hypeDocument.kDirectionForward);  
			   
				flipMsgbarTimeout = setTimeout(function(){ delayedFlipMsgbar(hypeDocument,msgs,i+1) }, msgs[i].delay*1000);
			   //$("#MsgBar"+SCENE_NAME+" .Text1").html(msgs[i].msg); 
			   //if (msgs[i].delay>6) {
				//	$("#MsgBar"+SCENE_NAME+" .Image1").attr("src","notifybelln.gif");
				//} else {
			//		$("#MsgBar"+SCENE_NAME+" .Image1").attr("src","transparent.gif");
			//	}
		　　　}
			}
		}
　　}

function appendCarno(old,carnoMappingRoomno, item){
	var retVal = "";
	if (item.carno != carnoMappingRoomno[item.carno])
		retVal= item.carno+"("+carnoMappingRoomno[item.carno]+")";
	else
		retVal=	item.carno; 
	if (old=="")
		return retVal;
	else
		return old+","+retVal;
} 