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
	var funcationName= 'loadScene' + sceneName;
 	console.log(":"+funcationName+" start"); 

	SCENE_NAME = sceneName;
	
	if (SCENE_NAME=='WG15') {
		ZONE ="WG";
		FLOOR=15;
		MAX_TARGET = 30;
	} else if (SCENE_NAME=='HA2') {
		/*
		ZONE ="HA";
		FLOOR=2;
		MAX_TARGET = 40;
		*/
		ZONE ="WG";
		FLOOR=15;
		MAX_TARGET = 30;
	} else if (SCENE_NAME=='HA3') {
		/*
		ZONE ="HA";
		FLOOR=3;
		MAX_TARGET = 40;
		*/
		ZONE ="WG";
		FLOOR=15;
		MAX_TARGET = 30;
	}
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
	    url: BASE_URL + "/employee/nursingOverview/babyPosition?zone=WG&floor=15",
	    timeout: 120000,
	    success: function(positionList) {
	    	var dataList = {
	    		id: "WG",
	    		items:[]
	    	}
	    	
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
	    		
	    		(positionList.items)[i].mapx = (posArr[(positionList.items)[i].posname])[0];
		    	(positionList.items)[i].mapy = (posArr[(positionList.items)[i].posname])[1] + 20;
		    	(positionList.items)[i].postype = (posArr[(positionList.items)[i].posname])[2];
		    	
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
	    	
	    	/*
	    	var dataList = { 
			 		"id": "WG",
				    "items": [
				      {"carno": "101", "roomno": "101", "age":"5", "ret":"23", "bday":"2017/01/11", "name": "許家王子", "milktype":"混合混餵(雀巢)","milkqty":"10", "bdweight":2000},
				      {"carno": "102", "roomno": "102", "age":"10", "ret":"15", "bday":"2017/01/06", "name": "黃家公主", "milktype":"母奶親餵","milkqty":"30", "bdweight":3000},
				      {"carno": "103", "roomno": "103", "age":"15", "ret":"7", "bday":"2016/12/28", "name": "陳家公主", "milktype":"母奶瓶餵","milkqty":"60", "bdweight":3600},
				      {"carno": "105", "roomno": "105", "age":"5", "ret":"23", "bday":"2017/01/11", "name": "許家王子", "milktype":"混合混餵(雀巢)","milkqty":"10", "bdweight":2000},
				      {"carno": "106", "roomno": "106", "age":"10", "ret":"15", "bday":"2017/01/06", "name": "黃家公主", "milktype":"母奶親餵","milkqty":"30", "bdweight":3000},
				      {"carno": "107", "roomno": "107", "age":"15", "ret":"7", "bday":"2016/12/28", "name": "陳家公主", "milktype":"母奶瓶餵","milkqty":"60", "bdweight":3600},

				      {"carno": "201", "roomno": "7樓-1", "age":"5", "ret":"23", "bday":"2017/01/11", "name": "許家王子", "milktype":"混合混餵(雀巢)","milkqty":"10", "bdweight":2000},
				      {"carno": "202", "roomno": "202", "age":"10", "ret":"15", "bday":"2017/01/06", "name": "黃家公主", "milktype":"母奶親餵","milkqty":"30", "bdweight":3000},
				      {"carno": "203", "roomno": "203", "age":"15", "ret":"7", "bday":"2016/12/28", "name": "陳家公主", "milktype":"母奶瓶餵","milkqty":"60", "bdweight":3600},
				      {"carno": "205", "roomno": "205", "age":"5", "ret":"23", "bday":"2017/01/11", "name": "許家王子", "milktype":"混合混餵(雀巢)","milkqty":"10", "bdweight":2000},
				      {"carno": "206", "roomno": "206", "age":"10", "ret":"15", "bday":"2017/01/06", "name": "黃家公主", "milktype":"母奶親餵","milkqty":"30", "bdweight":3000},
				      {"carno": "207", "roomno": "207", "age":"15", "ret":"7", "bday":"2016/12/28", "name": "陳家公主", "milktype":"母奶瓶餵","milkqty":"60", "bdweight":3600},

				      {"carno": "301", "roomno": "301", "age":"5", "ret":"23", "bday":"2017/01/11", "name": "許家王子", "milktype":"混合混餵(雀巢)","milkqty":"10", "bdweight":2000},
				      {"carno": "302", "roomno": "302", "age":"10", "ret":"15", "bday":"2017/01/06", "name": "黃家公主", "milktype":"母奶親餵","milkqty":"30", "bdweight":3000},
				      {"carno": "303", "roomno": "303", "age":"15", "ret":"7", "bday":"2016/12/28", "name": "陳家公主", "milktype":"母奶瓶餵","milkqty":"60", "bdweight":3600},
				      {"carno": "305", "roomno": "305", "age":"5", "ret":"23", "bday":"2017/01/11", "name": "許家王子", "milktype":"混合混餵(雀巢)","milkqty":"10", "bdweight":2000},
				      {"carno": "306", "roomno": "306", "age":"10", "ret":"15", "bday":"2017/01/06", "name": "黃家公主", "milktype":"母奶親餵","milkqty":"30", "bdweight":3000},
				      {"carno": "307", "roomno": "307", "age":"15", "ret":"7", "bday":"2016/12/28", "name": "陳家公主", "milktype":"母奶瓶餵","milkqty":"60", "bdweight":3600},
				      {"carno": "308", "roomno": "307", "age":"15", "ret":"7", "bday":"2016/12/28", "name": "陳家公主", "milktype":"母奶瓶餵","milkqty":"60", "bdweight":3600}
				    ]
				};
	    	*/
	    	
			var messageList = { 
			 	"id": "WG",
			  	"items": [
			  		{	"carno":"all",
			  			"msgs":[
			  			        {"type":"", "delay":5,"msg":"【警告】近日來流感疫情升溫，有感冒症狀禁止接觸寶寶"},
			  			        {"type":"", "delay":5,"msg":"【公告】本週三嬰兒室將進行紫外線消毒作業!"},
			  			        {"type":"", "delay":5,"msg":"【提醒】目前室外溫度31度"}
			  			       ]
			  			},
				    //{"carno":"101","msgs":[{"type":"", "delay":12,"msg":"異常事項"},{"type":"", "delay":3,"msg":"交班項目"}]}, 
				    //{"carno":"102","msgs":[{"type":"", "delay":12,"msg":"異常事項"},{"type":"", "delay":3,"msg":"交班項目"}]}
			      ]
			}; 
			
			messageList["items"][0]["msgs"] = [];
			for(var i=0; i<events.length; i++){
				messageList["items"][0]["msgs"].push({"type":"", "delay":5,"msg":events[i].name});
			}
			
			/*
			var eventList = {  
				"id": "WG",
			  	"items": [ 
				    {"carno":"101","msgs":[{"type":"hr", "delay":12,"msg":"110"},{"type":"br", "delay":12,"msg":"40"},{"type":"err", "delay":12,"msg":"hr"}]}, 
				    {"carno":"102","msgs":[{"type":"hr", "delay":12,"msg":"160"},{"type":"br", "delay":12,"msg":"40"},{"type":"err", "delay":12,"msg":"br"}]}
			      ]
			}; 
			*/
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
          	$("#"+ZONE_FLOOR+"CAR"+elementNumber + " .Text1").html(dataList.items[key].carno); 
        	} else {
			$("#"+ZONE_FLOOR+"CAR"+elementNumber + " .Text1").html(dataList.items[key].carno); 
        	}
         
    	} 
	}	
	
	var dx = 35;
	var dy = 25;
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
			if (positionList.items[key].postype=="嬰兒室") {babyRoomCount++;babyRoomCarno=appendCarno(babyRoomCarno,carnoMappingRoomno,positionList.items[key]);}
				else if (positionList.items[key].postype=="媽媽房") {momRoomCount++;momRoomCarno=appendCarno(momRoomCarno,carnoMappingRoomno,positionList.items[key]);}
				else if (positionList.items[key].postype=="外出") {outsideCount++;outsideCarno=appendCarno(outsideCarno,carnoMappingRoomno,positionList.items[key]);}
				else if (positionList.items[key].postype=="走廊" || positionList.items[key].postype=="交誼廳" || positionList.items[key].postype=="茶水間") 
					{ publicCount++;publicCarno=appendCarno(publicCarno,carnoMappingRoomno,positionList.items[key]);}
			
			if (positionList.items[key].zone=='WG' && positionList.items[key].floor==15 ){
				thisFloorBabyCount++;
				if (positionList.items[key].postype=="嬰兒室") thisFloorBabyRoomCount++;
				else if (positionList.items[key].postype=="媽媽房") thisFloorMomRoomCount++;
				else if (positionList.items[key].postype=="外出") thisFloorOutsideCount++;
				else if (positionList.items[key].postype=="走廊" || positionList.items[key].postype=="交誼廳" || positionList.items[key].postype=="茶水間") thisFloorPublicCount++;
			}

			// set element position to map
	        $("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('y', positionList.items[key].mapy); 
	        $("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('x', positionList.items[key].mapx);  
			$("#"+ZONE_FLOOR+"CAR"+elementNumber).prop('nex', -2);  

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


	// show count
	$("#DataText1").html(thisFloorBabyRoomCount+'/'+thisFloorBabyCount);
	$("#DataText2").html(thisFloorMomRoomCount+'/'+thisFloorBabyCount);
	$("#DataText3").html(thisFloorPublicCount+'/'+thisFloorBabyCount);
	$("#DataText4").html(thisFloorOutsideCount+'/'+thisFloorBabyCount);
	$("#babyRoomCount").html(babyRoomCount+'/'+babyCount);
	$("#momRoomCount").html(momRoomCount+'/'+babyCount);
	$("#publicCount").html(publicCount+'/'+babyCount);
	$("#outsideCount").html(outsideCount+'/'+babyCount); 
	$("#babyRoomCarno").html(babyRoomCarno.split(",").sort().join(","));
	$("#momRoomCarno").html(momRoomCarno.split(",").sort().join(","));
	$("#publicCarno").html(publicCarno.split(",").sort().join(","));
	$("#outsideCarno").html(outsideCarno.split(",").sort().join(",")); 

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
		if (msgs.length<=0){
	  	 	return ;
	  	}else if (msgs.length==1) {
	  		$("#MsgBar"+SCENE_NAME+" .Text1").html(msgs[i].msg); 
	  	} else {
	  		if (i < msgs.length){  
				if (msgs[i].delay>6) {
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url("+BASE_URL+"/plug-in/babyPosition/wg/notifybelln.gif)");
				} else {
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url("+BASE_URL+"/plug-in/babyPosition/wg/transparent.gif)");
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

		　　　} else {
		　　　　	i = 0;
				if (msgs[i].delay>6) {
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url("+BASE_URL+"/plug-in/babyPosition/wg/notifybelln.gif)");
				} else {
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url("+BASE_URL+"/plug-in/babyPosition/wg/transparent.gif)");
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
		　　　}
	  	}
	}
}

function appendCarno(old,carnoMappingRoomno, item){
	var retVal = "";
	if (item.carno != carnoMappingRoomno[item.carno]){
		retVal= item.carno+"("+carnoMappingRoomno[item.carno]+")";
	}else
		retVal=	item.carno; 
	if (old=="")
		return retVal;
	else
		return old+","+retVal;
} 