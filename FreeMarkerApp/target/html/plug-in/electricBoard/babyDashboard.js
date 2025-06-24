
var SCENE_NAME = '';
var ZONE ='';
var FLOOR=0;
var ZONE_FLOOR=''; 
var MAX_TARGET =30;
var flipMsgbarTimeout = null; 
var imageLazyloadTimeout = null;
var webSocketIO = null;

var requestDataAndProcessUITimeout = null;  

function imageLazyload() { 
	imageLazyloadTimeout = setTimeout(function() {
        // html content which are from KindEditor that need be replace <img src=  to <img data-original=
    	$("img").lazyload({ threshold : 200, effect : "fadeIn" });  
                       
    }, 300); 
}

function unloadScene(hypeDocument, element, event, sceneName) { 
	var funcationName= 'unloadScene' + sceneName;
 	console.log(funcationName+" start");  
	clearTimeout(requestDataAndProcessUITimeout);
	clearTimeout(flipMsgbarTimeout);
	clearTimeout(imageLazyloadTimeout);

	SCENE_NAME = ''; 
 	console.log(funcationName+" end"); 
} 

function loadScene(hypeDocument, element, event, sceneName) { 

	var funcationName= 'loadScene' + sceneName;
 	console.log(funcationName+" start"); 

	SCENE_NAME = sceneName;
	
	if (SCENE_NAME=='WG15') {
		ZONE ="WG";
		FLOOR=15;
		MAX_TARGET = 30;
	} else if (SCENE_NAME=='HA2') {
		ZONE ="HA";
		FLOOR=2;
		MAX_TARGET = 40;
	} else if (SCENE_NAME=='HA3') {
		ZONE ="HA";
		FLOOR=3;
		MAX_TARGET = 40;
	}
	ZONE_FLOOR=ZONE+FLOOR;

	requestDataAndProcessUI(hypeDocument); 	

	//用來控制CSS
	$(".HYPE_element_container").find("div:eq(0)").each(function(){
		if ($(this).css('background-image').includes("FeedingBottle.png")){
			$(this).addClass("HYPE_Milk_Img");
		}
		if ($(this).css('background-image').includes("heart.png")){
			$(this).addClass("HYPE_Heart_Img");
		}
		if ($(this).css('background-image').includes("lung.png")){
			$(this).addClass("HYPE_Lung_Img");
		}
	});
	$(".Image1").parent().addClass("alertParent").append('<div class="alert"></div>');
	
	
	console.log(funcationName+" end");
}

function requestDataAndProcessUI(hypeDocument){
	var request = $.ajax({
	    dataType: "json",
	    url: BASE_URL + "/employee/electricBoard/listDate",
	    data: {
	    	page: PAGE_NO
	    },
	    timeout: 120000,
	    success: function(data) {
	    	/*
	    	data.dataList={
	    		id: "hy",
	    		items:[
	    			{roomno:"301",carno:"301",age:"27",ret:"0",bday:"2017-10-25",name:"陳瓅妍之女",milktype:"明治(+)",milkqty:"90(母)",milkTime:"10:20 ",alert:""}
	    			,{roomno:"302",carno:"302",age:"21",ret:"0",bday:"2017-10-26",name:"梁瑋家之男",milktype:"亞培",milkqty:"35(親)",milkTime:"13:15",alert:""}
	    			,{roomno:"303",carno:"303",age:"32",ret:"0",bday:"2017-11-02",name:"范文齊之女",milktype:"雪印",milkqty:"70(配)",milkTime:"12:45",alert:""}
	    			,{roomno:"305",carno:"305",age:"23",ret:"1",bday:"2017-11-01",name:"陳潔詩之男",milktype:"雀巢水解",milkqty:"50(母)",milkTime:"10:31",alert:""}
	    			,{roomno:"306",carno:"306",age:"28",ret:"0",bday:"2017-11-08",name:"吳宜家之男",milktype:"優生",milkqty:"18(親)",milkTime:"12:10",alert:""}
	    			,{roomno:"307",carno:"307",age:"34",ret:"0",bday:"2017-11-06",name:"吳庭欣之女",milktype:"雀巢水解",milkqty:"120(母)",milkTime:"12:10",alert:""}
	    			,{roomno:"501",carno:"501",age:"29",ret:"0",bday:"2017-10-30",name:"鄭渝芳之女",milktype:"雪印",milkqty:"100(母)",milkTime:"13:05",alert:""}
	    			,{roomno:"502",carno:"502",age:"28",ret:"1",bday:"2017-11-04",name:"許祐蜜之男",milktype:"亞培",milkqty:"80(配)",milkTime:"13:35",alert:""}
	    			,{roomno:"503",carno:"503",age:"21",ret:"0",bday:"2017-10-29",name:"范婷夢之女",milktype:"亞培",milkqty:"40(親)",milkTime:"10:20",alert:""}
	    		]
	    	};
	    	data.eventList={
	    		id:"hy",
	    		items:[
	    			{msg:"【客】護理協助-702-(13:05),【客】護理協助-703-(10:05)"}
	    			,{msg:"【嬰】推送寶寶-301-(08:05),【嬰】推送寶寶-602-(10:13),【嬰】請聯絡我-604-(13:28)"}
	    		]
	    	};
			*/
	    	
			processUI(hypeDocument, data.dataList, data.eventList);

			requestDataAndProcessUITimeout = setTimeout(function(){ requestDataAndProcessUI(hypeDocument) }, 10000);

	    },
	    error: function(){
	    	requestDataAndProcessUITimeout = setTimeout(function(){ requestDataAndProcessUI(hypeDocument) }, 10000);
	    }
	});

}


function processUI(hypeDocument, dataList, eventList){
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
          		$("#PanelGroup"+elementNumber + " .carno").html(dataList.items[key].roomno); 
          		$("#PanelGroup"+elementNumber + " .roomno").html(dataList.items[key].carno);
        	} else {
				$("#PanelGroup"+elementNumber + " .carno").html(dataList.items[key].roomno);
				$("#PanelGroup"+elementNumber + " .roomno").html(""); 
        	}
            if(dataList.items[key].name && dataList.items[key].name.length>1){
            	dataList.items[key].name = replaceAt(dataList.items[key].name, 1, "ｏ");
            }
            $("#PanelGroup"+elementNumber + " .bname").html(dataList.items[key].name);
        	$("#PanelGroup"+elementNumber + " .bday").html(dataList.items[key].bday);
        	$("#PanelGroup"+elementNumber + " .bage").html("A"+dataList.items[key].age); 
        	$("#PanelGroup"+elementNumber + " .bret").html("R"+dataList.items[key].ret); 
			$("#PanelGroup"+elementNumber + " .LungText").html("35");
        	$("#PanelGroup"+elementNumber + " .HeartText").html("110"); 

        	$("#PanelGroup"+elementNumber + " .Milk01").html(dataList.items[key].milktype);
        	$("#PanelGroup"+elementNumber + " .Milk02").html(dataList.items[key].milkqty);
        	$("#PanelGroup"+elementNumber + " .Milk03").html(dataList.items[key].milkTime);
        	$("#PanelGroup"+elementNumber + " .alert").html(dataList.items[key].alert);
        	
        	//儲存babyId -> elementNumber
        	if(dataList.items[key].babyId) babyIdToEelementNumber[dataList.items[key].babyId] = elementNumber;
        	if(babyIdHeart[dataList.items[key].babyId]){
        		$("#PanelGroup"+elementNumber + " .HeartText").text(babyIdHeart[dataList.items[key].babyId]);
        	}else{
        		$("#PanelGroup"+elementNumber + " .HeartText").text("");
        	}
        	if(babyIdLung[dataList.items[key].babyId]){
        		$("#PanelGroup"+elementNumber + " .LungText").text(babyIdLung[dataList.items[key].babyId]);
        	}else{
        		$("#PanelGroup"+elementNumber + " .LungText").text("");
        	}
        	//$("#PanelGroup"+elementNumber + " .Position01").html(dataList.items[key].bdweight);
        	//$("#PanelGroup"+elementNumber + " .Weight02").html(dataList.items[key].bdweight);
        	
        	if(!dataList.items[key].babyId){
        		$("#PanelGroup"+elementNumber + " .bage").hide();
        		$("#PanelGroup"+elementNumber + " .bret").hide();
        		$("#PanelGroup"+elementNumber + " .HYPE_Milk_Img").parent().parent().parent().hide();
        		$("#PanelGroup"+elementNumber + " .Image1").css({"background-image":"none"});
        		$("#PanelGroup"+elementNumber + " .HYPE_Heart_Img").hide();
        		$("#PanelGroup"+elementNumber + " .HYPE_Lung_Img").hide();
        	}
         
    	} 
	}


	var babyCount =0;
	var babyRoomCount =0;
	var momRoomCount =0;
	var outsideCount =0;
	var publicCount =0;  

	// show count 
	$("#babyRoomCount").html(babyRoomCount+'/'+babyCount);
	$("#momRoomCount").html(momRoomCount+'/'+babyCount);
	$("#publicCount").html(publicCount+'/'+babyCount);
	$("#outsideCount").html(outsideCount+'/'+babyCount); 


	if($("#monMsg1").find("marquee").length==0){
		$("#monMsg1").html("<marquee scrollamount='5' behavior='alternate' direction='right'>"+eventList.items[0].msg+"</marquee>");
		$("#monMsg").html("<marquee scrollamount='5' behavior='alternate' direction='right'>"+eventList.items[1].msg+"</marquee>");
	}else{
		$("#monMsg1 marquee").text(eventList.items[0].msg);
		$("#monMsg marquee").text(eventList.items[1].msg);
	}
}

function replaceAt(str, index, replacement){
	return str.substr(0, index) + replacement+ str.substr(index + replacement.length);
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
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url(./index.hyperesources/notifybelln.gif");
				} else {
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url(./index.hyperesources/transparent.gif");
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
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url(./index.hyperesources/notifybelln.gif");
				} else {
					$("#MsgBar"+SCENE_NAME+" .Image2").css("background-image", "url(./index.hyperesources/transparent.gif");
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
	if (item.carno != carnoMappingRoomno[item.carno])
		retVal= item.carno+"("+carnoMappingRoomno[item.carno]+")";
	else
		retVal=	item.carno; 
	if (old=="")
		return retVal;
	else
		return old+","+retVal;
} 