/*
jQuery.ganttView v.0.8.8
Copyright (c) 2010 JC Grubbs - jc.grubbs@devmynd.com
MIT License Applies
*/

/*
Options
-----------------
showWeekends: boolean
data: object
cellWidth: number
cellHeight: number
slideWidth: number
dataUrl: string
behavior: {
	clickable: boolean,
	draggable: boolean,
	resizable: boolean,
	onClick: function,
	onDrag: function,
	onResize: function
}
*/

		  var stsObj = new Object();   //統計
		  var COLOR_CAL_LABEL = "#000";  //日期標示用
		  var COLOR_RESERVE = "rgb(217, 217, 217)";
		  var COLOR_ACTIVE = "rgb(255, 255, 102)";
		  var COLOR_SET ="rgb(255, 0, 0)";
		  var COLOR_UNSET ="rgb(255, 255, 255)";
		  var COLOR_HEAD ="rgb(255, 165, 0)";
		  var COLOR_TAIL ="rgb(0, 0, 255)";
		  var COLOR_EMPTY ="rgb(255, 255, 255)";
		  var COLOR_ALREADY ="rgb(0, 255, 0)";
		  var COLOR_SEG_SEL ="rgb(255, 255, 255)";
		  var EDIT_MODE=0; // 0:目前未定義修改標的初始狀態(預設) , 點選對應的cell後 ,抓出對應的修改標的，這時EDIT_MODE=1;
		  var MENU_MODE=0; // 0:未啟用 rightMenu選單  1:啟用rightMenu選單
		  var TA_CONTRACT=""; 
		  var TA_DAYS=0;
		  var TA_STATUS="";  // "R" ,"A" ,"T"
		  var TA_NAME="";
		  var EDIT_DAYS=0;
		  var localDD=[];
		  var TA_INDEX_FROM=-1;  	//選擇起點
		  var TA_INDEX_TO=-1;		//選擇迄點
		  var TA_SELBK={"oldfromIndex":-1,"oldfromTxt":"","oldtoIndex":-1,"oldTxt":""};
		  var LIVE_DAYS=-1;         //入住天數
		  
		  	    
		    function reCalculateDays(){
	    	  	
		    	 var count=0;		  
				  //每按一次，全部重新scan一次
				  globalDD=[];
				  //localDD=[];
				//----計算日數------------------
				  $( "div.ganttview-grid-row-cell" ).each(function (index, value) { 			    		  			  
						//用紅顏色來區別設定日
					  	//計算時 red + orange 一起算 (memo 存檔時會保留 L)
					    var cellbgcolor = $(this).css( "background-color" );
						//if( $(this).attr('style')=='background-color: red' ){
					  	if( cellbgcolor ==  COLOR_SET ){
						   //console.log(index+":"+$(this).attr('style'));
						   //globalDD.push($(this).attr("title")); //收集放入array
						   
						 //取的cell's parent
						 var partitle=$(this).parent( "div.ganttview-grid-row" ).attr("title");
						 var partitlearr=[];
						 partitlearr=partitle.split(",");
						 globalDD.push({
							 	cellindex:index,
							 	celltext: $(this).text(),
							    facname: partitlearr[0],
						        facid: partitlearr[1],
						        bookdate: $(this).attr("title"),
						        contract: TA_CONTRACT
						    });
						 	//update localDD
						 /*
							 localDD.push({
								 	cellindex:index,
								 	celltext: $(this).text(),
								    facname: partitlearr[0],
							        facid: partitlearr[1],
							        bookdate: $(this).attr("title"),
							        contract: $(this).data("contract")
							    });	
						   */ 
						   count++;
						}
					});	
				  
				  EDIT_DAYS=count;
				  return count;
		    	
		    }
		    
    		//取得 虛擬房類虛擬房 之 index
//		    function getVRoomIndex(){
//		    	  var firstVRindex=0;
//				  $( "div.ganttview-grid-row-cell" ).each(function (index, value) {					  
//					  var partitle=$(this).parent( "div.ganttview-grid-row" ).attr("title");
//					  var partitlearr=[];
//					  partitlearr=partitle.split(",");
//					  //console.log("parent's title[0]="+partitlearr[0]+"parent's title[1]="+partitlearr[1]);
//					  
//					  if(partitlearr[0]=="虛擬房類虛擬房"){
//						  firstVRindex=index;
//						  return false;
//					  }
//					  
//					});
//				  return firstVRindex;	  
//		    }	    
		    
		    
		    
		    
		    function checkIfContinuousEmpty(targetIndex){
		    	  var mm="";
		    	  var returnFlag=1;
				  //檢查目地區是否有空位	  
				  jQuery.each( globalDD, function( i, item ) {
						var ii=targetIndex+i;	
						mm='div.ganttview-grid-row-cell:eq('+ii+')';
						if( $(mm).data("contract")!=undefined  && $(mm).data("contract")!=""){
							returnFlag=0;
							return false;						
						}
				  });				  
				  return returnFlag;		    			    			    	
		    }
	
		    function checkIfContinuousEmptyForSelect(targetIndex,totday){
		    	  var mm="";
		    	  var returnFlag=1;
				  //檢查目地區是否有空位	
				  for( var i = 0; i < totday; i++ ) {	
					  var ii=targetIndex+i;	
					  mm='div.ganttview-grid-row-cell:eq('+ii+')';
					  if( $(mm).data("contract")!=undefined  && $(mm).data("contract")!=""){
							returnFlag=0;
							return false;						
						}
				  	}
				  return returnFlag;		    			    			    	
		    }
		    		        		    
		    
		    //reset(恢復至原位置，與原顏色狀態)
		    function rightMouseClick_refresh(){
		    	
		    	 // var index=targetIndex;
				  //var target=$( "div.ganttview-grid-row-cell" ).get(index);				  
				  
				  //先移除
				  var mm="";
				  $( "div.ganttview-grid-row-cell" ).each(function (index, value) { 						  
						mm='div.ganttview-grid-row-cell:eq('+index+')';
						//移除原資訊
						if(TA_CONTRACT!=undefined && TA_CONTRACT!="" && TA_CONTRACT == $(mm).data("contract")){
							$(mm).data( "contract","" )
							$(mm).css('background-color',COLOR_EMPTY);
							$(mm).text("");
						}			  						  
					});
				  
					//位置顯示
			    	localDD = localDD.sort(function (a, b) {
			    		var aa = new Date(a.bookdate.replace(/-/g,'/'));
			    		var bb = new Date(b.bookdate.replace(/-/g,'/'));
			    		return aa > bb ? 1 : -1; // asc
			    	})	
					jQuery.each( localDD, function( i, item ) {
						mm='div.ganttview-grid-row-cell:eq('+item.cellindex+')';
						$(mm).data( "contract", item.contract );
						$(mm).css('background-color',COLOR_SET);
						
						//$(mm).text(item.celltext);
						//$(mm).text(TA_NAME+" "+(i+1)+"/"+globalDD.length);
						var ss= TA_NAME+" "+'<span style="font-size:1.2em;">'+(i+1)+'</span>'+"/"+globalDD.length ;
						$(mm).html(ss);							

						if(TA_STATUS=="R" && TA_CONTRACT == $(mm).data("contract"))
							$(mm).css('background-color',COLOR_RESERVE);
						else if(TA_STATUS=="A" && TA_CONTRACT == $(mm).data("contract"))
							$(mm).css('background-color',COLOR_ACTIVE);
						else 
							$(mm).css('background-color',COLOR_UNSET);	
					});				  
					EDIT_MODE=0;
				  	  
				  //每按一次，全部重新scan一次		  
				  var count=0;
				  count= reCalculateDays();	
				  var msg='共住'+count+'日';
				  $("#eventMessage").text(msg);
				  
				  $("div.custom-menu").hide();

		}		    
		    //退出重選: reset(恢復至原位置，與原顏色狀態)
		    function rightMouseClick_reset(){
		    	
		    	 // var index=targetIndex;
				  //var target=$( "div.ganttview-grid-row-cell" ).get(index);				  
				  
				  //先移除
				  var mm="";
				  $( "div.ganttview-grid-row-cell" ).each(function (index, value) { 						  
						mm='div.ganttview-grid-row-cell:eq('+index+')';
						//移除原資訊
						if(TA_CONTRACT!=undefined && TA_CONTRACT!="" && TA_CONTRACT == $(mm).data("contract")){
							$(mm).data( "contract","" )
							$(mm).css('background-color',COLOR_EMPTY);
							$(mm).text("");
						}			  						  
					});
				  
					//位置顯示
				    reDrawSlotInfoByLocalDD(1);
			  
					EDIT_MODE=0;
				  	  
				  //每按一次，全部重新scan一次		  
				  var count=0;
				  count= reCalculateDays();	
				  var msg='共住'+count+'日';
				  $("#eventMessage").text(msg);
				  $("div.custom-menu").hide();
		
		} 		    
		    //恢復選取:reset(恢復至原位置，並選取)
		    function rightMouseClick_reset_withHighlight(){
		    	
//		    	  var index=targetIndex;
//				  var target=$( "div.ganttview-grid-row-cell" ).get(index);				  
				  
				  //先移除
				  var mm="";
				  $( "div.ganttview-grid-row-cell" ).each(function (index, value) { 						  
						mm='div.ganttview-grid-row-cell:eq('+index+')';
						//移除原資訊
						if(TA_CONTRACT!=undefined && TA_CONTRACT!="" && TA_CONTRACT == $(mm).data("contract")){
							$(mm).data( "contract","" )
							$(mm).css('background-color',COLOR_EMPTY);
							$(mm).text("");
						}			  						  
					});
				  
					//位置顯示
				  	reDrawSlotInfoByLocalDD(0);
				  	/*
					jQuery.each( localDD, function( i, item ) {
						mm='div.ganttview-grid-row-cell:eq('+item.cellindex+')';
						$(mm).data( "contract", item.contract );
						$(mm).css('background-color',COLOR_SET);						
						$(mm).text(item.celltext);						
					});				  
					*/
				  	  
				  //每按一次，全部重新scan一次		  
				  var count=0;
				  count= reCalculateDays();	
				  var msg='共住'+count+'日';
				  $("#eventMessage").text(msg);
				  $("div.custom-menu").hide();

		}		    
		    //移動選取
		    function rightMouseClick_move(targetIndex){
		    	
		  	  	  var index=targetIndex;
		  	  	  var target=$( "div.ganttview-grid-row-cell" ).get(index);
		    	
//				  var target_index = $( "div.ganttview-grid-row-cell" ).index( target );		  
//				  var target=$( "div.ganttview-grid-row-cell" ).get(target_index);
		 
				  var bgcolor = $(target).css( "background-color" );
				  
				  //檢查目地區是否有空位
				  var continuousFlag=checkIfContinuousEmpty(targetIndex);
				  
				  if(continuousFlag==0){					  
					  alert("目地區空位不足!");
					  $("div.custom-menu").hide();
					  return;					  					 
				  }
				  
				  //先移除
				  var mm="";
				  $( "div.ganttview-grid-row-cell" ).each(function (index, value) { 						  
						mm='div.ganttview-grid-row-cell:eq('+index+')';
						//移除原資訊
						if(TA_CONTRACT!=undefined && TA_CONTRACT!="" && TA_CONTRACT == $(mm).data("contract")){
						//if( bgcolor ==  COLOR_SET){
							$(mm).data( "contract","" )
							$(mm).css('background-color',COLOR_EMPTY);
							$(mm).text("");
						}			  						  
					});
				  

				  //新位置顯示。因為是全部移動，使用globalDD比較快
				  jQuery.each( globalDD, function( i, item ) {
					  var ii=targetIndex+i;
					  mm='div.ganttview-grid-row-cell:eq('+ii+')';
					  $(mm).data( "contract", item.contract );
					  $(mm).css('background-color',COLOR_SET);
				  });

				  	  
				  //每按一次，全部重新scan一次		  
				  var count=0;
				  count= reCalculateDays();	//update globalDD
				  var msg='共住'+count+'日';
				  $("#eventMessage").text(msg);
				  reDrawSlotInfo(); //draw globalDD
				  
				  $("div.custom-menu").hide();
		    }
		    
		    //用於編輯時 動態重新顯示名字 by globalDD
		    function reDrawSlotInfo(){
				
		    	globalDD = globalDD.sort(function (a, b) {
					  var aa = new Date(a.bookdate.replace(/-/g,'/'));
					  var bb = new Date(b.bookdate.replace(/-/g,'/'));
		    		 return aa > bb ? 1 : -1; // asc
		    	})		   	
		    	
				jQuery.each( globalDD, function( i, item ) {
					mm='div.ganttview-grid-row-cell:eq('+item.cellindex+')';
					$(mm).data( "contract", item.contract );
					$(mm).css('background-color',COLOR_SET);						
					//$(mm).text(item.celltext);
					if(TA_NAME==undefined){ 
						console.log("undefined TA_NAME");
						TA_NAME="";					
					}
					if(LIVE_DAYS<0) //預設模式 : 分母為動態
					{
						//$(mm).text(TA_NAME+" "+(i+1)+"/"+globalDD.length);
						var ss= TA_NAME+" "+'<span style="font-size:1.2em;">'+(i+1)+'</span>'+"/"+globalDD.length ;
						$(mm).html(ss);						
					}
					else{
						//$(mm).text(TA_NAME+" "+(i+1)+"/"+LIVE_DAYS);  //分母固定
						var ss= TA_NAME+" "+'<span style="font-size:1.2em;">'+(i+1)+'</span>'+"/"+LIVE_DAYS ;
						$(mm).html(ss);
					}
/*
					if(TA_STATUS=="R" && TA_CONTRACT == $(mm).data("contract"))
						$(mm).css('background-color',COLOR_RESERVE);
					else if(TA_STATUS=="A" && TA_CONTRACT == $(mm).data("contract"))
						$(mm).css('background-color',COLOR_ACTIVE);
					else 
						$(mm).css('background-color',COLOR_UNSET);
*/							
				});	
		    	
		    }
		    
		    //用於編輯時 動態重新顯示名字 by localDD
		    function reDrawSlotInfoByLocalDD(cssflag){
				
		    	localDD = localDD.sort(function (a, b) {
					  var aa = new Date(a.bookdate.replace(/-/g,'/'));
					  var bb = new Date(b.bookdate.replace(/-/g,'/'));
		    		 return aa > bb ? 1 : -1; // asc
		    	})		   	
		    		    	
				jQuery.each( localDD, function( i, item ) {
					mm='div.ganttview-grid-row-cell:eq('+item.cellindex+')';
					$(mm).data( "contract", item.contract );
					$(mm).css('background-color',COLOR_SET);						
					//$(mm).text(item.celltext);
					if(TA_NAME==undefined){ 
						console.log("undefined TA_NAME");
						TA_NAME="";					
					}
					if(LIVE_DAYS<0) //預設模式 : 分母為動態
					{
						//$(mm).text(TA_NAME+" "+(i+1)+"/"+globalDD.length);
						var ss= TA_NAME+" "+'<span style="font-size:1.2em;">'+(i+1)+'</span>'+"/"+globalDD.length ;
						$(mm).html(ss);						
					}
					
					//for 退出重選
					if(cssflag==1){
						  if(TA_STATUS=="R" && TA_CONTRACT == $(mm).data("contract"))
							  $(mm).css('background-color',COLOR_RESERVE);
						  else if(TA_STATUS=="A" && TA_CONTRACT == $(mm).data("contract"))
							  $(mm).css('background-color',COLOR_ACTIVE);
						  else 
							  $(mm).css('background-color',COLOR_UNSET);							
					}
						
						
				});	
		    	
		    }		    
		    //關閉選單:取消操作 退出選單
		    function rightMouseClick_Exist(){	
		    	$("div.custom-menu").hide();
		    	return;
		    } 
		   //選取起迄點模式
		    function rightMouseClick_segSelectMove(targetIndex,fromIndex,toIndex){
		    	//console.log("[segSelect] fromIndex="+fromIndex+" toIndex="+toIndex);
		    	
		    	//begin		    		    	
		  	  	  var index=targetIndex;
		  	  	  var target=$( "div.ganttview-grid-row-cell" ).get(index);
		 
				  var bgcolor = $(target).css( "background-color" );
				  
				  
				  //計算日數
				  var selFrom='div.ganttview-grid-row-cell:eq('+fromIndex+')';
				  var date_selFrom = new Date($(selFrom).attr("title").replace(/-/g,'/'));
				  var selTo='div.ganttview-grid-row-cell:eq('+toIndex+')';
				  var date_selTo   = new Date($(selTo).attr("title").replace(/-/g,'/'));
				  var totdays  =  parseInt(Math.abs(date_selFrom  -  date_selTo)  /  1000  /  60  /  60  /24)+1;
				  //console.log("totdays="+totdays);
	  
				  //取得新位置的起迄日期				  
				  var mm_target_From='div.ganttview-grid-row-cell:eq('+targetIndex+')';
				  var dateFrom = new Date($(mm_target_From).attr("title").replace(/-/g,'/'));
				  var tend=targetIndex+totdays-1;
				  var mm_target_To='div.ganttview-grid-row-cell:eq('+tend+')';
				  var dateTo   = new Date($(mm_target_To).attr("title").replace(/-/g,'/'));
				  

				  //檢查目地區是否有空位
				  var continuousFlag=checkIfContinuousEmptyForSelect(targetIndex,totdays);
				  
				  if(continuousFlag==0){					  
					  alert("小提醒:目地區空位不足!");
					  $("div.custom-menu").hide();
					  return;					  					 
				  }
				  
				  //檢查新位置是否overlap原規劃(用日期觀點)
				  var overlapflag=0;			  
				  $( "div.ganttview-grid-row-cell" ).each(function (index, value) {
					    var mmold='div.ganttview-grid-row-cell:eq('+index+')';					    					    					    
						if(TA_CONTRACT!=undefined && TA_CONTRACT!="" && TA_CONTRACT == $(mmold).data("contract") )
						{
							var thisdate = new Date($(mmold).attr("title").replace(/-/g,'/'));					
							//檢查新位置
							if(thisdate<date_selFrom || thisdate>date_selTo) //只看原規劃擷取區間之外的點
							{
							  //測試新位置的每個點，不能與原規劃的點重疊 
							  for( var i = 0; i < totdays; i++ ) {			  				
									var ii=targetIndex+i;										
									var mm_target='div.ganttview-grid-row-cell:eq('+ii+')';
									if($(mmold).attr("title")!="" && $(mmold).attr("title")==$(mm_target).attr("title")){
										overlapflag=1;
										return false; //break
									}										
							  	}
							
							 }		
						}
						if(overlapflag==1) return false;
					});
				  
				  if(overlapflag == 1){
					  alert("小提醒:目地區日期與原規劃日期部分重疊，會導致同一日住二間!");
					  $("div.custom-menu").hide();
					  return;	
				  }
				  

				  
				  //確定無重疊後，移除
				  var lastIndex=0;  //to do...
				  $( "div.ganttview-grid-row-cell" ).each(function (index, value) {
					    var mmold='div.ganttview-grid-row-cell:eq('+index+')';					    					    					    
						if(TA_CONTRACT!=undefined && TA_CONTRACT!="" && TA_CONTRACT == $(mmold).data("contract") )
						{
							var thisdate = new Date($(mmold).attr("title").replace(/-/g,'/'));							
							if(thisdate>=date_selFrom && thisdate<=date_selTo) 
							{

								//清除
								$(mmold).data( "contract","" );
								$(mmold).css('background-color',COLOR_EMPTY);
								$(mmold).text("");																
																
							}			  																	
						}						
					});
				  
				   //顯示新位置
				  for( var i = 0; i < totdays; i++ ) {			  				
						//置入新位置的資訊
						var ii=targetIndex+i;
						mm='div.ganttview-grid-row-cell:eq('+ii+')';
						$(mm).data( "contract", TA_CONTRACT );
						$(mm).css('background-color',COLOR_SET);
				  	}
				  
				  //每按一次，全部重新scan一次		  
				  var count=0;
				  count= reCalculateDays();  //update globalDD	
				  var msg='共住'+count+'日';
				  $("#eventMessage").text(msg);
				  
				  
				  reDrawSlotInfo(); //draw globalDD
				  
				  
				  $("div.custom-menu").hide();		    	

		    	//end
		    	
		    	//console.log("segSelectMove Done! reset TA_INDEX_*");
		    	TA_INDEX_FROM=-1;
		    	TA_INDEX_TO=-1;
		    	TA_SELBK.oldfromIndex=-1;
		    	TA_SELBK.oldtoIndex=-1;
		    	$("div.custom-menu").hide();
		    	return;

		  }
		    
		    function rightMouseClick_segSelectExist(){
		    	//console.log("exist[segSelect] =");
		    	TA_SELBK.oldfromIndex=-1;
		    	TA_SELBK.oldtoIndex=-1;
		    	if(TA_INDEX_FROM>0 || TA_INDEX_TO>0)
		    		reDrawSlotInfo(); //draw globalDD
		    	
		    	TA_INDEX_FROM=-1;
		    	TA_INDEX_TO=-1;		
		    	$("div.custom-menu").hide();
		    	return;
		    }		    
		    
		    function rightMouseClick_segSelectFrom(fromIndex){
		    			    	
		    	//同一合約才接受		    	
				var mm='div.ganttview-grid-row-cell:eq('+fromIndex+')';
				//console.log("[segSelect]fromIndex="+fromIndex+" code="+$(mm).data("contract"));			
				if( $(mm).data("contract")==undefined ||  $(mm).data("contract")=="" ||  $(mm).data("contract")!=TA_CONTRACT){
		    		alert("小提醒:需同一客戶!")
		    		$("div.custom-menu").hide();
		    		return;
				}
				
				if(TA_SELBK.oldfromIndex==-1){
					//初始備份
					TA_SELBK.oldfromIndex=fromIndex;
					TA_SELBK.oldfromTxt=$(mm).text();
				}else{
					//恢復備份
					var oldmm='div.ganttview-grid-row-cell:eq('+TA_SELBK.oldfromIndex+')';
					$(oldmm).text(TA_SELBK.oldfromTxt);
					//重新備份
					TA_SELBK.oldfromIndex=fromIndex;
					TA_SELBK.oldfromTxt=$(mm).text();
				}	
				//console.log("TA_SELBK.oldfromIndex="+TA_SELBK.oldfromIndex+ " txt="+TA_SELBK.oldfromTxt);
				//標示設定
				$(mm).text("<<"+TA_NAME);
				
		    	
		    	TA_INDEX_FROM=fromIndex;
		    	$("div.custom-menu").hide();
		    	return;	    
		  }		    
		    function rightMouseClick_segSelectTo(toIndex){

		    	//同一合約才接受		    	
				var mm='div.ganttview-grid-row-cell:eq('+toIndex+')';
				//console.log("[segSelect]toIndex="+toIndex+" code="+$(mm).data("contract"));
				if( $(mm).data("contract")==undefined  || $(mm).data("contract")=="" || $(mm).data("contract")!=TA_CONTRACT){
		    		alert("小提醒:需同一客戶!")
		    		$("div.custom-menu").hide();
		    		return;
				}
					
				var mm_from='div.ganttview-grid-row-cell:eq('+TA_INDEX_FROM+')';
				
				//console.log("#from:"+$(mm_from).attr("title")+" #to:"+$(mm).attr("title"));
				var dateTo   = new Date($(mm).attr("title").replace(/-/g,'/'));
				var dateFrom = new Date($(mm_from).attr("title").replace(/-/g,'/'));
				//console.log("from:"+dateFrom+" to:"+dateTo);
				if ( dateTo <= dateFrom){
		    		alert("小提醒:迄點須大於起點!")
		    		$("div.custom-menu").hide();
		    		return;
		    	}
												
		    	//處理顯示用
				if(TA_SELBK.oldtoIndex==-1){
					//初始備份
					TA_SELBK.oldtoIndex=toIndex;
					TA_SELBK.oldtoTxt=$(mm).text();
				}else{
					//恢復備份
					var oldmm='div.ganttview-grid-row-cell:eq('+TA_SELBK.oldtoIndex+')';
					$(oldmm).text(TA_SELBK.oldtoTxt);
					//重新備份
					TA_SELBK.oldtoIndex=toIndex;
					TA_SELBK.oldtoTxt=$(mm).text();
				}	
				//console.log("TA_SELBK.oldfromIndex="+TA_SELBK.oldfromIndex+ " txt="+TA_SELBK.oldfromTxt);
				//標示設定
				$(mm).text(TA_NAME+">>");		    	
		    	
		    			    	
	
		    	
		    	TA_INDEX_TO=toIndex;
		    	$("div.custom-menu").hide();
		    	return;
		    }
		    
		    
		  //清除選取:將該合約原設定紅色全部清除
		    function rightMouseClick_clear(targetIndex){
			  	  var index=targetIndex;
		  	  	  var target=$( "div.ganttview-grid-row-cell" ).get(index);
				  // `this` is the DOM element that was clicked
				  //var index = $( "div.ganttview-grid-row-cell" ).index( target );		  
				 // var ddobj=$( "div.ganttview-grid-row-cell" ).get(index);				  
				  //console.log("target index="+index+"contr="+$(target).data("contract"));

				  var bgcolor = $(target).css( "background-color" );
				  $( "div.ganttview-grid-row-cell" ).each(function (index, value) { 
					  bgcolor = $(this).css( "background-color" );
					   //清除紅色
					  if( bgcolor ==  COLOR_SET || bgcolor == COLOR_UNSET ){
						  if(TA_CONTRACT == $(this).data("contract"))
							  $(this).css('background-color',COLOR_UNSET);
					  }
					  //EDIT_MODE=0;
				  });
				  	  
				  //每按一次，全部重新scan一次		  
				  var count=0;
				  count= reCalculateDays();	
				  var msg='共住'+count+'日';
				  $("#eventMessage").text(msg);
				  $("div.custom-menu").hide();
		  }
		    
			//自動移動到VRroom (備用)
//		    function rightMouseClick_move_to_VRoom(){
//		    	
//		    	  //要移到哪裡?????
//		    	  var getfirstIndex=getVRoomIndex();
//		    	
//		  	  	  var index=getfirstIndex;
//		  	  	  var target=$( "div.ganttview-grid-row-cell" ).get(index);
//		 
//				  var bgcolor = $(target).css( "background-color" );
//				  
//				  //檢查目地區是否有空位
//				  var continuousFlag=checkIfContinuousEmpty(targetIndex);
//				  
//				  if(continuousFlag==0){					  
//					  alert("目地區空位不足!");
//					  $("div.custom-menu").hide();
//					  return;					  					 
//				  }
//				  
//				  //先移除
//				  var mm="";
//				  $( "div.ganttview-grid-row-cell" ).each(function (index, value) { 						  
//						mm='div.ganttview-grid-row-cell:eq('+index+')';
//						//移除原資訊
//						if(TA_CONTRACT!=undefined && TA_CONTRACT!="" && TA_CONTRACT == $(mm).data("contract")){
//						//if( bgcolor ==  COLOR_SET){
//							$(mm).data( "contract","" )
//							$(mm).css('background-color',COLOR_EMPTY);
//							$(mm).text("");
//						}			  						  
//					});			 
//					Query.each( globalDD, function( i, item ) {
//							var ii=targetIndex+i;
//							//target_index=target_index+i;
//							mm='div.ganttview-grid-row-cell:eq('+ii+')';
//							$(mm).data( "contract", item.contract );
//							$(mm).css('background-color',COLOR_SET);
//							$(mm).text(TA_NAME+" "+(i+1)+"/"+globalDD.length);
//					});				  
//				  	  
//				  //每按一次，全部重新scan一次		  
//				  var count=0;
//				  count= reCalculateDays();	
//				  var msg='共住'+count+'日';
//				  $("#eventMessage").text(msg);
//				  $("div.custom-menu").hide();
//		  }		    
		    
		    
		    
		  
(function (jQuery) {
			
    jQuery.fn.ganttView = function () {
    	  	
    	//reset global var 
		  //var TA_CONTRACT=""; 
		  //var TA_DAYS=0;
		  //var TA_STATUS="";  // "R" ,"A" ,"T"
		  //var TA_NAME="";
		  //console.log("reset TA_NAME="+TA_NAME);
    	
    	var args = Array.prototype.slice.call(arguments);
    	
    	if (args.length == 1 && typeof(args[0]) == "object") {
        	build.call(this, args[0]);
    	}
    	
    	if (args.length == 2 && typeof(args[0]) == "string") {
    		handleMethod.call(this, args[0], args[1]);
    	}
    	
        
		//beg add  
    	//固定加上左移右移箭頭
    	$( "div.ganttview-vtheader .ganttview-vtheader-item .ganttview-vtheader-series-name" ).each(function (index, value) {
        	//console.log("targetName="+targetName+" "+value.innerText);
        	
        	var mv_right='<button type="button" onclick="ScrollTo(500);"><i class="fa fa-arrow-right"></i></button>';
        	var mv_left ='<button type="button" onclick="ScrollTo(-500);"><i class="fa fa-arrow-left"></i></button>';
        	$(this).attr('style', 'background-color: white ; align: right');
        	//$(this).html(value.innerText+mv_left+mv_right);
        	$(this).html(value.innerText);

		});	
    	
    	$( "div.ganttview-vtheader .ganttview-vtheader-item .ganttview-vtheader-series-name-arrow" ).each(function (index, value) {
        	//console.log("targetName="+targetName+" "+value.innerText);
        	
        	var mv_right='<button type="button" onclick="ScrollTo(500);"><i class="fa fa-arrow-right"></i></button>';
        	var mv_left ='<button type="button" onclick="ScrollTo(-500);"><i class="fa fa-arrow-left"></i></button>';
        	//$(this).attr('style', 'background-color: white ; align: right');
        	$(this).html(mv_left+mv_right);
        	//$(this).html("");

		});	
    	
    	
    	    	    	
    	$('.ganttview-vtheader-series-name').on( "click", function() {
        	
    		var targetName=$(this).text(); //308

            $( "div.ganttview-vtheader .ganttview-vtheader-item .ganttview-vtheader-series-name" ).each(function (index, value) {
            	//console.log("targetName="+targetName+" "+value.innerText);

            	if(targetName === value.innerText){      
            		$(this).attr('style', 'background-color: orange ; align: right');
            		//$(this).html(value.innerText+mv_left+mv_right);
            	}
            	else{
            		$(this).attr('style', 'background-color: white ; align: right');
            		//$(this).html(value.innerText);
            	}         	
            	
            	
            	/*
            	if(targetName === value.innerText){      
            		$(this).attr('style', 'background-color: orange ; align: right');
            		$(this).html(value.innerText+"<i class='fa fa-hand-o-right'></i>");
            	}
            	else{
            		$(this).attr('style', 'background-color: white');
            		$(this).html(value.innerText);
            	}
            	*/
			});		              
        });
    	
    	
    	

   	
    	/*
        $('div.ganttview-grid-row-cell').on('contextmenu', function(event){
        	
        	event.preventDefault();
        	//rightMouseClick_clear(this);
        	
        	var index = $( "div.ganttview-grid-row-cell" ).index( this );
        	rightMouseClick_reset(index);
  
        });
        */


	
    	//kkk
    	$('div.ganttview-grid-row-cell').bind("contextmenu", function(event) {
    		    	    
    	    event.preventDefault();   
    	    var index = $( "div.ganttview-grid-row-cell" ).index( this );
    	    
//    	    if(EDIT_MODE!=1) { //進入編輯模式才有選單
    	    if(EDIT_MODE!=1 || MENU_MODE!=1) { //有設定 rightMenu 才有選單
    	    	//console.log("right click! but not in Edit mode, do nothing. index="+index);    	
    	    	return;
    	    }
    	    
			var mm='div.ganttview-grid-row-cell:eq('+index+')';
    	    //console.log("[edit mode]right click! index="+index+" code="+$(mm).data("contract"));  	      	    

    	    var ftns="";  	   
    	    $("div.custom-menu").hide(); //先隱藏 	 
    	    //var line_break='<br>';
    	    var line_break='';
    	    if(TA_INDEX_FROM<0 && TA_INDEX_TO<0){
    	    	//正常選單
        	    ftns="<button type='button' class='btn' onclick='rightMouseClick_segSelectFrom("+index+");'>選取起點</button>";
        	    ftns+=line_break+"<button type='button' class='btn' onclick='rightMouseClick_clear("+index+");'>清除選取</button>";
    	    	ftns+=line_break+"<button type='button' class='btn' onclick='rightMouseClick_move("+index+");'>移動選取</button>";
    	    	ftns+=line_break+"<button type='button' class='btn' onclick='rightMouseClick_reset_withHighlight();'>恢復選取</button>";
    	    	ftns+=line_break+"<button type='button' class='btn' onclick='rightMouseClick_reset();'>退出重選</button>";
    	    	ftns+=line_break+"<button type='button' class='btn' onclick='rightMouseClick_Exist();'>關閉選單</button>";
    	    	ftns+=line_break+"<button type='button' class='btn' onclick='postApSlotMerge();'>確定送出</button>";
    	    }else{
    	    	//起訖模式選單
        	    ftns="<button type='button' class='btn' onclick='rightMouseClick_segSelectFrom("+index+");'>區間選擇:選起點</button>";
        	    ftns+=line_break+"<button type='button' class='btn' onclick='rightMouseClick_segSelectTo("+index+");'>區間選擇:選迄點</button>";
        	    if( EDIT_MODE==1 && TA_INDEX_FROM>0 && TA_INDEX_TO>0) //二者都設定了，才可移動
        	    	ftns+=line_break+"<button type='button' class='btn' onclick='rightMouseClick_segSelectMove("+index+","+TA_INDEX_FROM+","+TA_INDEX_TO+");'>移動至此</button>";
        	    ftns+=line_break+"<button type='button' class='btn' onclick='rightMouseClick_segSelectExist();'>退出區間選擇模式</button>";
    	    }
	      	$("<div class='custom-menu'>"+ftns+"</div>")
	    	        .appendTo("body")
	    	        .css({top: event.pageY + "px", left: event.pageX + "px"});    
	    }).bind("click", function(event) {
	    		    $("div.custom-menu").hide();
    		});

    	
    	//kkk
		$( "div.ganttview-grid-row-cell" ).click(function(e) {	
			
			//e.preventDefault();
		  // `this` is the DOM element that was clicked
		  var index = $( "div.ganttview-grid-row-cell" ).index( this );		  
		  var ddobj=$( "div.ganttview-grid-row-cell" ).get(index);
//		  console.log(" index="+index);
		  //取的cell's parent		  		  
//		  var partitle=$(this).parent( "div.ganttview-grid-row" ).attr("title");
//		  var partitlearr=[];
//		  partitlearr=partitle.split(",");
//		  console.log("parent's title[0]="+partitlearr[0]+"parent's title[1]="+partitlearr[1]);
//		  
//		  var getfirstIndex=getVRoomIndex();
//		  console.log("getfirstIndex="+getfirstIndex);
		  
		  
		  var xx=ddobj.title;
		  //console.log("div index="+index+'[xx]='+xx+' text='+ddobj.textContent);  //div index=1[xx]=2017-5-18
		 
		  var mm='div.ganttview-grid-row-cell:eq('+index+')';
		  
		  if(EDIT_MODE==0)  //尚未EDIT_MODE=1 ,TA_CONTRACT 根據click的位置取得
		  {
			TA_CONTRACT= $(mm).data("contract");
			TA_STATUS = $(mm).data("status");
			TA_NAME = $(mm).text().substr(0,3);			
			//console.log("#TA_CONTRACT:"+TA_CONTRACT+" TA_STATUS:"+TA_STATUS+ " TA_NAME:"+TA_NAME);
		  }

		  //console.log("click-->#TA_CONTRACT:"+TA_CONTRACT+" TA_STATUS:"+TA_STATUS);
		  
		  if(TA_CONTRACT==undefined){
			  TA_CONTRACT="";			  
		  }
		  	  
		  if(EDIT_MODE==0){
			  if(TA_CONTRACT=="" || TA_CONTRACT=="WG_CALENDAR_ROOM"){
				  alert("請選擇修改標的!");
				  return;
			  }
		      		    	
			  var daycc=0;		  
			  localDD=[];

			  //將選擇的合約標的，填滿紅色
			  $( "div.ganttview-grid-row-cell" ).each(function (index, value) {
				  
				   //填滿紅色
				    if(TA_CONTRACT!=undefined && TA_CONTRACT!="" && TA_CONTRACT == $(this).data("contract")){				    	    	
				    	//若該target合約狀態為終止，則不進入編輯模式
				    	if(TA_STATUS=="T"){
				    		alert("小提醒:客戶合約已正式終止，不可變更!");
				    		return false;  //break loop
				    	}
				    	
				    	$(this).css('background-color',COLOR_SET);
				    	EDIT_MODE=1;
				    	//備份原位置 至 localDD (用於右選單功能之恢復原位置)
				    	//取的cell's parent
						 var partitle=$(this).parent( "div.ganttview-grid-row" ).attr("title");
						 var partitlearr=[];
						 partitlearr=partitle.split(",");
						 localDD.push({
							 	cellindex:index,
							 	celltext: $(this).text(),
							    facname: partitlearr[0],
						        facid: partitlearr[1],
						        bookdate: $(this).attr("title"),
						        contract: $(this).data("contract")
						    });
	
				    	daycc++;
				    }	
			  });
			  contractChg(daycc); //取得原合約規畫
			  //console.log("daycc="+daycc+" localDD size="+localDD.length);

			  
		  }else{ //inside EDIT_MODE
		  //console.log("inside EDIT_MODE "); 		  		  
		  //----檢查設定條件------------------
		  //設定時如果已經填滿紅色,取消為白色	  
		  var bgcolor = $(mm).css( "background-color" );
		  //console.log("bgcolor="+bgcolor);
		  //DodgerBlue  == rgb(30, 144, 255)
		  //yellow  == rgb(255, 255, 0)
		  //red   == rgb(255, 0, 0)
		  //if( $(mm).attr('style')=='background-color: DodgerBlue' ){
		  //if( bgcolor ==  'rgb(30, 144, 255)' ){
		  if( bgcolor ==  COLOR_RESERVE ){
			  alert("小提醒:客戶預約中，不可設定!");
		  }
		  //else  if( $(mm).attr('style')=='background-color: green' ){
		  else if( bgcolor ==  COLOR_ALREADY ){		  
			  alert("小提醒:客戶合約已完成，不可設定!");
		  }		  
		  else if( bgcolor ==  COLOR_ACTIVE ){
			  alert("小提醒:客戶合約已生效，不可設定!");
		  }
//		  else if( $(mm).attr('style')=='background-color: orange' ){
//			  alert("小提醒:目前編輯對象 為入住狀態，不可設定!");   //2017.3.30 先取消此限制
//		  }		  
		 // else if( $(mm).attr('style')=='background-color: red'){
		  else if( bgcolor ==  COLOR_SET ){
			  $(mm).css('background-color',COLOR_UNSET);
			 // $(mm).attr('style', 'background-color: white');
		  }else{  //填滿紅色
			  
			  if(LIVE_DAYS>0 && globalDD.length==LIVE_DAYS){				  
				  alert("已達預計入住天數，無法新增");
				  return;
			  }

			  //不可以同一天
			  var checkflag=checkIfSameDate(globalDD,$(mm).attr("title"));
			  //console.log("ckeflag="+checkflag);
			  if(checkflag == 1){	
				alert("小提醒:不可以同一天!");
				return;
			  }			
			  //$(mm).attr('style', 'background-color: red');
			  $(mm).css('background-color',COLOR_SET);
		      $(mm).data( "contract", TA_CONTRACT );
		  }		  
		  
		//----End檢查設定條件------------------
	  } //else{ //inside EDIT_MODE
		  
		  //每按一次，全部重新scan一次		  
		  var count=0;
		  count= reCalculateDays();
			  				  
		  //show result		
		  var msg='共住'+count+'日'; //+objToString(globalDD);
		  //console.log("ss="+ss);
		  //div index=352[xx]=2017-5-17 [total]=1 [details]=[{"facname":"現代簡約207","facid":"WG_FAC_20170103131001_5144","bookdate":"2017-5-17"}]
		  //var ss=msg+" div index="+index+'[xx]='+xx +" [total]="+count+"contract="+$(mm).data("contract")+" [details]="+JSON.stringify(globalDD);
		  //console.log(ss);
		  $("#eventMessage").text(msg);
		  
		  reDrawSlotInfo(); //編號及時重標
		  
		  
		});	 //.click(
		
		//end add
    	
    };


    
    
    
	//beg add
    
    //若有重新設定區間再撈一次的情形(ie.EDIT_MODE=3) ,只做填滿紅色 
    function initalReFillRed(){
    	 //console.log("initalReFillRed-->EDIT_MODE="+EDIT_MODE+" TA_CONTRACT="+TA_CONTRACT);
    	 
    	  var daycc=0;		  
		  localDD=[];
		  $( "div.ganttview-grid-row-cell" ).each(function (index, value) {			  
			  //EDIT_MODE-3 :for 如果天數 與 該合約實際天數不同，就重新設定區間 再撈一次 ,瞭取完直接填紅並且EDIT_MODEg設回1
			  if(EDIT_MODE==3 && TA_CONTRACT!=undefined && TA_CONTRACT!="" && TA_CONTRACT == $(this).data("contract") ){				    	    	
			    	//若該target合約狀態為終止，則不進入編輯模式
				  /*
			    	if(TA_STATUS=="T"){
			    		alert("小提醒:客戶合約已正式終止，不可變更!");
			    		return false;  //break loop
			    	}
			    	*/			    	
			    	$(this).css('background-color',COLOR_SET);
			    	
			    	//備份原位置 至 localDD ，以利右選單操作
			    	//取的cell's parent
					 var partitle=$(this).parent( "div.ganttview-grid-row" ).attr("title");
					 var partitlearr=[];
					 partitlearr=partitle.split(",");
					 localDD.push({
						 	cellindex:index,
						 	celltext: $(this).text(),
						    facname: partitlearr[0],
					        facid: partitlearr[1],
					        bookdate: $(this).attr("title"),
					        contract: $(this).data("contract")
					    });
					 daycc++;
			  }			  		
			});		
		  //console.log("refill done!");
    }
    
    
    function initialScan(){
    	  var count=0;
    	  globalDD=[];  //用於紀錄隨時最新更新，確定送出時採用此數據
    	 // EDIT_MODE=0;
    	  
    	  //console.log("initialScan-->EDIT_MODE="+EDIT_MODE+" TA_CONTRACT="+TA_CONTRACT);
    	  
    	  if(EDIT_MODE==3){
    		  initalReFillRed();
    		  EDIT_MODE=1;
    	  }
    	  
		  $( "div.ganttview-grid-row-cell" ).each(function (index, value) {
			  
//			  var mm='div.ganttview-grid-row-cell:eq('+index+')';
				//用紅顏色來區別設定日
			  	//計算時 red + orange 一起算 (memo 存檔時會保留 L)
			    var cellbgcolor = $(this).css( "background-color" );
				//if( $(this).attr('style')=='background-color: red' ){
			  	if( cellbgcolor ==  COLOR_SET ){	
			  		EDIT_MODE=1; //如果指定合約，從CONTROLLER 就會設定紅色， 直接進入EDIT
				//if( $(this).attr('style')=='background-color: red'){
				   //console.log(index+":"+$(this).attr('style'));
				   //globalDD.push($(this).attr("title")); //收集放入array
				   
				 //取的cell's parent
				 var partitle=$(this).parent( "div.ganttview-grid-row" ).attr("title");
				 var partitlearr=[];
				 partitlearr=partitle.split(",");
				 globalDD.push({
					 	cellindex:index,
					    facname: partitlearr[0],
				        facid: partitlearr[1],
				        bookdate: $(this).attr("title"),
				        contract: $(this).data("contract"),
				    });
				   count++;
				}
			});		  
		  //show result		
		  EDIT_DAYS=count;
		  var msg='共住'+count+'日'; //+objToString(globalDD);		  
		  //console.log("ss="+ss);
		  //var ss="div index="+index+'[xx]='+xx +" [total]="+count+" [details]="+JSON.stringify(globalDD);
		  //console.log(ss);
		  $("#eventMessage").text(msg);		  		  
		
    }
    
	function checkIfSameDate(arr,target){
		var flag=0;
		jQuery.each( arr, function( i, val ) {
			//console.log("val="+val+"  target="+target);
			//if(val.valueOf() == target.valueOf()){
			if(val['bookdate'].valueOf() == target.valueOf()){
			flag=1;
			return false;  //break , found!
			}
		});
		return flag;		
	}
		
	function objToString (obj) {
	    var str = '';
	    for (var p in obj) {
	        if (obj.hasOwnProperty(p)) {
	            //str += p + '::' + obj[p].facid + '\n';
	            str += obj[p].facname+':'+obj[p].bookdate+' ';
	        }
	    }
	    return str;
	}	
	//end add    
    
    
    function build(options) {
    	
    	var els = this;
        var defaults = {
            showWeekends: true,
            cellWidth: 105,
            cellHeight: 31,
            slideWidth: 400,
            vHeaderWidth: 100,
            behavior: {
            	clickable: true,
            	draggable: false,
            	resizable: false
            }
        };
        
        var opts = jQuery.extend(true, defaults, options);

		if (opts.data) {
			build();
		} else if (opts.dataUrl) {
			jQuery.getJSON(opts.dataUrl, function (data) { opts.data = data; build(); });
		}

		function build() {
			
			var minDays = Math.floor((opts.slideWidth / opts.cellWidth)  + 5);
			var startEnd = DateUtils.getBoundaryDatesFromData(opts.data, minDays);
			opts.start = startEnd[0];
			opts.end = startEnd[1];
			//console.log("opts.start="+opts.start);
			//console.log("opts.end="+opts.end);
			
	        els.each(function () {

	            var container = jQuery(this);
	            var div = jQuery("<div>", { "class": "ganttview" });
	            new Chart(div, opts).render();
				container.append(div);
				
				var w = jQuery("div.ganttview-vtheader", container).outerWidth() +
					jQuery("div.ganttview-slide-container", container).outerWidth();
	            container.css("width", (w + 2) + "px");
	            
	            new Behavior(container, opts).apply();
	                   
	        });	
	        //beg add
	        var editMode=0; //顯示修改標的的初始狀態: 0:白底(全部清除)模式 (預設)  1:紅底模式
	        if(opts.editMode === undefined) {
	        	editMode=0;      	
	        }else
	        	editMode=opts.editMode;
	        
	        if(opts.editStyle === undefined) {
	        	EDIT_MODE=0;      	
	        }else
	        	EDIT_MODE=opts.editStyle;
	        
	        if(opts.rightMenu === undefined) { //控制右mousse click出現的選單
	        	MENU_MODE=0;   //不出現，簡易模式   	
	        }else
	        	MENU_MODE=opts.rightMenu; //>0 全功能模式
	        
	        if(opts.liveDays === undefined) { //入住天數 ，如果>0 表示 顯示入住天數分母要固定
	        	LIVE_DAYS=-1;   
	        }else
	        	LIVE_DAYS=opts.liveDays;
	        
      
	        //console.log("bef#editStyle-->EDIT_MODE="+EDIT_MODE);
	        showBookings(opts.data,editMode);	       
	        initialScan();
	        //console.log("aft#editStyle-->EDIT_MODE="+EDIT_MODE);
	        
	        //test 
	        stsCnts(opts.data,editMode);
	        console.log("stsCnts done");
	        //end add
		}
		//beg add
		function showBookings(facilityData,editMode){
			
			facilityData.forEach(   //by facility
					function(obj) { 
						
						if(obj.bookings==null) return;
						var occpyarr=obj.bookings;
						var facid=obj.id;
						//console.log("#editMode="+editMode);
						  $( "div.ganttview-grid-row" ).each(function (index, value) {
							  //console.log("ganttview-grid-row:"+index);
							  var cellparinfo=$(this).attr("title");
							  //取得parent id
							  var partitlearr=[];
							  partitlearr=cellparinfo.split(",");
							  var parent_facid=partitlearr[1];
							  //console.log("parent's title[0]="+partitlearr[0]+"parent's title[1]="+partitlearr[1]);
						      //console.log("#####editMode="+editMode);
							  for( var i = 0; i < occpyarr.length; i++ ) {
								  if(facid === parent_facid ){
									//console.log("plot it="+occpyarr[i].celldt);
									$(this).children().each(function (index, value) {				 
										  var cellinfo=$(this).attr("title"); // var cellelement='div.ganttview-grid-row-cell:eq('+index+')';				  
										  if(cellinfo===occpyarr[i].celldt){  //yyyy-mm-dd
											  ////											  
											  //$(this).text(occpyarr[i].name.substr(0,3)); //show user name
											  
											  /////$(this).text(occpyarr[i].name.substr(0,3)+occpyarr[i].nth+'/'+occpyarr[i].max); //show user name
											  if(occpyarr[i].code!="WG_CALENDAR_ROOM")
											  {
												  var ss= occpyarr[i].name.substr(0,3)+'<span style="font-size:1.2em;">'+occpyarr[i].nth+'</span>'+"/"+occpyarr[i].max ;
												  $(this).html(ss);
											  }else{
												  
												  $(this).html(occpyarr[i].name);
											  }
											  
											  //console.log("cell info:"+occpyarr[i].code);  //cell info:201610011
											  //put contract info
											  $(this).data( "contract", occpyarr[i].code );
											  $(this).data( "status", occpyarr[i].status );
											  
											  //console.log("cell info:"+occpyarr[i].name+" status="+occpyarr[i].apstatus);  //cell info:201610011
											  if(occpyarr[i].apstatus==='TL')  //target
											  {
												   //取得TA_* during showBookings
													TA_CONTRACT= occpyarr[i].code;
													TA_STATUS = occpyarr[i].status;
													TA_NAME = occpyarr[i].name.substr(0,3);
													
												  if(editMode==0)
													  $(this).css('background-color',COLOR_UNSET);
													  //$(this).attr('style', 'background-color: white'); // orange,Edit mode:Target 入住中												  
												  else
													  $(this).css('background-color',COLOR_SET);
													  //$(this).attr('style', 'background-color: red'); // orange,Edit mode:Target 入住中												  
												  
											  }
											  else if(occpyarr[i].apstatus==='TR')
											  {
												  if(editMode==0)
													  $(this).css('background-color',COLOR_UNSET);
												  	  //$(this).attr('style', 'background-color: white'); // red,Edit mode: Target 已生效
												  else
													  $(this).css('background-color',COLOR_SET);
													  //$(this).attr('style', 'background-color: red'); // red,Edit mode: Target 已生效
											  }
											  else if(occpyarr[i].apstatus==='L')
												  //$(this).attr('style', 'background-color: yellow'); // 其他客戶入住中
											  	  $(this).css('background-color',COLOR_ACTIVE);
											  else{		
												  //依合約狀態顯示
												  if(occpyarr[i].status==='R'){													  
													  //$(this).attr('style', 'background-color: DodgerBlue'); //  合約預約者 mark 藍色
													  $(this).css('background-color',COLOR_RESERVE);
												  }else if(occpyarr[i].status==='T'){	//終止												  
													  $(this).css('background-color',COLOR_ALREADY);
												  }
												  else{
													  //$(this).attr('style', 'background-color: purple');
													  $(this).attr('style', 'background-color: white');
													  $(this).attr('style','font-weight:bolder');
													  $(this).attr('style', 'color: '+ COLOR_CAL_LABEL +'; '+originalStyle);
												  }
											  }
											  
											  var originalStyle = $(this).attr('style');
											  if(occpyarr[i].nth==1){
												  $(this).attr('style', 'color: '+ COLOR_HEAD +'; '+originalStyle);
												  //$(this).css('color',orange);
												  
											  }
											  else if(occpyarr[i].nth==occpyarr[i].max){
												  $(this).attr('style', 'color: '+ COLOR_TAIL +'; '+originalStyle);
												  //$(this).attr('style', 'color: green '+'; '+originalStyle);
												  
											  }
											  
											  
											  ////
											  											  
										  }
									});
								  }
							  }
							  //console.log("ganttview-grid-row:Done");
						  });
					}
			);
	
		}
		//end add
		
		
    }
   
	function stsCnts(facilityData,editMode){
		
		stsObj = new Object();
		var dtArr =[];
		
		for(var key in facilityData)
		{
			if(facilityData[key].id=='WG_CALENDAR_ROOM')//抓第一個"日期標示"物件，當成日期索引
			{
				var datearr=facilityData[key].bookings;//日期索引array
				for( var i = 0; i < datearr.length; i++ )
				{
					dtArr.push(datearr[i].celldt);
				}
				break;
			}
		}
		/*
		console.log("dtArr.length="+dtArr.length);
		for( var i = 0; i < dtArr.length; i++ )
		{
			console.log(i+" "+dtArr[i]);
		}
		*/
		
		for( var i = 0; i < dtArr.length; i++) 
		{
			var mdate=dtArr[i]; //日期索引
			//initialize 
	    	var tmpobj = new Object();			    		 
	    	tmpobj.ml=0;tmpobj.mr=0;tmpobj.mt=0;
	    	tmpobj.bl=0;tmpobj.br=0;tmpobj.bt=0;
	    	stsObj[mdate]=tmpobj;							
			//統計每個日期的數量			
			for(var key in facilityData)
			{
				if(facilityData[key].id!='WG_CALENDAR_ROOM')//非"日期標示"才考慮
				{
					var mrow=facilityData[key].bookings;//日期索引array
					var foundflag=false;
					for( var dti = 0; dti < mrow.length; dti++ )
					{												
						if(mrow[dti].celldt==mdate)
						{																										
							//統計
							if(facilityData[key].series[0].codename!='托嬰房' && mrow[dti].apstatus=='L') // mom 入住
							{
								if(stsObj[mdate]!=null && stsObj[mdate].ml!=null) stsObj[mdate].ml +=1;
								else stsObj[mdate].ml=1;
									
							}else if(facilityData[key].series[0].codename!='托嬰房' && mrow[dti].apstatus=='R') // mom 預約
							{
								if(stsObj[mdate]!=null && stsObj[mdate].mr!=null) stsObj[mdate].mr +=1;
								else stsObj[mdate].mr=1;
								
							}else if(facilityData[key].series[0].codename!='托嬰房' && mrow[dti].apstatus=='T') // mom 到期
							{
								if(stsObj[mdate]!=null && stsObj[mdate].mt!=null) stsObj[mdate].mt +=1;
								else stsObj[mdate].mt=1;
								
							}else if(facilityData[key].series[0].codename=='托嬰房' && mrow[dti].apstatus=='L') // baby 入住
							{
								if(stsObj[mdate]!=null && stsObj[mdate].bl!=null) stsObj[mdate].bl +=1;
								else stsObj[mdate].bl=1;
								
							}else if(facilityData[key].series[0].codename=='托嬰房' && mrow[dti].apstatus=='R') // baby 預約
							{
								if(stsObj[mdate]!=null && stsObj[mdate].br!=null) stsObj[mdate].br +=1;
								else stsObj[mdate].br=1;
								
							}else if(facilityData[key].series[0].codename=='托嬰房' && mrow[dti].apstatus=='T') // baby 到期
							{
								if(stsObj[mdate]!=null && stsObj[mdate].bt!=null) stsObj[mdate].bt +=1;
								else stsObj[mdate].bt=1;
								
							}else{
								
								
							}								
							foundflag=true;
						}
						if(foundflag==true)
							break;  //break for( var dti = 0; dti < mrow.length; dti++ )
					}//for( var dti = 0; dti < mrow.length; dti++ )
				}//if//非"日期標示"才考慮				
			}//for(var key in facilityData)
		}//for( var i = 0; i < dtArr.length; i++)
		
		
		/*
		for( var i = 0; i < dtArr.length; i++ )
		{
			console.log(dtArr[i] +" LRT:mom-->"+stsObj[dtArr[i]].ml+","+stsObj[dtArr[i]].mr+","+stsObj[dtArr[i]].mt+" baby-->"+stsObj[dtArr[i]].bl+","+stsObj[dtArr[i]].br+","+stsObj[dtArr[i]].bt);
		}		
		console.log("!dtArr.length="+dtArr.length);
		*/
		
		

}    
    
    
    
    
	function handleMethod(method, value) {
		
		if (method == "setSlideWidth") {
			var div = $("div.ganttview", this);
			div.each(function () {
				var vtWidth = $("div.ganttview-vtheader", div).outerWidth();
				$(div).width(vtWidth + value + 1);
				$("div.ganttview-slide-container", this).width(value);
			});
		}
	}

	var Chart = function(div, opts) {
		
		function render() {
			addVtHeader(div, opts.data, opts.cellHeight);

            var slideDiv = jQuery("<div>", {
                "class": "ganttview-slide-container",
                "css": { "width": opts.slideWidth + "px" }
            });
			
            dates = getDates(opts.start, opts.end);
            addHzHeader(slideDiv, dates, opts.cellWidth);
            addGrid(slideDiv, opts.data, dates, opts.cellWidth, opts.showWeekends);
            addBlockContainers(slideDiv, opts.data);
            addBlocks(slideDiv, opts.data, opts.cellWidth, opts.start);
            div.append(slideDiv);
            applyLastClass(div.parent());
		}
		
		//var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
		var monthNames = Date.CultureInfo.monthNames;

		// Creates a 3 dimensional array [year][month][day] of every day 
		// between the given start and end dates
        function getDates(start, end) {
            var dates = [];
			dates[start.getFullYear()] = [];
			dates[start.getFullYear()][start.getMonth()] = [start]
			var last = start;
			while (last.compareTo(end) == -1) {
				var next = last.clone().addDays(1);
				if (!dates[next.getFullYear()]) { dates[next.getFullYear()] = []; }
				if (!dates[next.getFullYear()][next.getMonth()]) { 
					dates[next.getFullYear()][next.getMonth()] = []; 
				}
				dates[next.getFullYear()][next.getMonth()].push(next);
				last = next;
			}
			return dates;
        }

        function addVtHeader(div, data, cellHeight) {
            var headerDiv = jQuery("<div>", { "class": "ganttview-vtheader" });
            
            for (var i = 0; i < data.length; i++) {
                var itemDiv = jQuery("<div>", { "class": "ganttview-vtheader-item" });
                //beg add
                //console.log("color="+data[i].series[0].color);
                itemDiv.append(jQuery("<div>", {
                    "class": "ganttview-vtheader-item-name",
                    "css": { "height": (data[i].series.length * cellHeight) + "px","background-color": data[i].series[0].color },
                    "html": data[i].htmltag
                }).append(""));
                
                //end add
                //console.log("i="+i+" data[i].htmltag="+data[i].htmltag+" data[i].name="+data[i].name);
                /*
                itemDiv.append(jQuery("<div>", {
                    "class": "ganttview-vtheader-item-name",
                    "css": { "height": (data[i].series.length * cellHeight) + "px" }               
                }).append(data[i].name));
                */
                var seriesDiv = jQuery("<div>", { "class": "ganttview-vtheader-series" });
                //console.log("data[i].series.length="+data[i].series.length);
                for (var j = 0; j < data[i].series.length; j++) {
                	//beg add
                	var newlabel="";
                	//console.log("data[i].series[j].codename="+data[i].series[j].codename);
                	/*
                	if(data[i].series[j].name!='empty')
                		newlabel=data[i].series[j].name;
                	*/
                	newlabel = data[i].name; 
                	
                    seriesDiv.append(jQuery("<div>", { "class": "ganttview-vtheader-series-name" })
    						.append(newlabel));
                    
                    
                    seriesDiv.append(jQuery("<div>", { "class": "ganttview-vtheader-series-name-arrow" })
    						.append("ssss"));
                    
                	//end add
                    /*
                    seriesDiv.append(jQuery("<div>", { "class": "ganttview-vtheader-series-name" })
						.append(data[i].series[j].name));
						*/
                }
                itemDiv.append(seriesDiv);
                headerDiv.append(itemDiv);
            }
            div.append(headerDiv);
        }

        function addHzHeader(div, dates, cellWidth) {
            var headerDiv = jQuery("<div>", { "class": "ganttview-hzheader" });
            var monthsDiv = jQuery("<div>", { "class": "ganttview-hzheader-months" });
            var daysDiv = jQuery("<div>", { "class": "ganttview-hzheader-days" });
            var totalW = 0;
            var month_m=0;
			for (var y in dates) {
				for (var m in dates[y]) {
					month_m= parseInt(m)+1;
					var w = dates[y][m].length * cellWidth;
					totalW = totalW + w;
					monthsDiv.append(jQuery("<div>", {
						"class": "ganttview-hzheader-month",
						"css": { "width": (w - 1) + "px" }
					}).append(monthNames[m] + "/" + y));
					
					for (var d in dates[y][m]) {
						daysDiv.append(jQuery("<div>", { "class": "ganttview-hzheader-day" })
							.append(month_m + "/" + dates[y][m][d].getDate()));
					}
				}
			}
            monthsDiv.css("width", totalW + "px");
            daysDiv.css("width", totalW + "px");
            headerDiv.append(monthsDiv).append(daysDiv);
            div.append(headerDiv);
        }

        function addGrid(div, data, dates, cellWidth, showWeekends) {
            var gridDiv = jQuery("<div>", { "class": "ganttview-grid" });
            var rowDiv = jQuery("<div>", { "class": "ganttview-grid-row" });
			
			//Setup rowDiv
			for (var y in dates) {
				for (var m in dates[y]) {
					for (var d in dates[y][m]) {
						var cellDiv = jQuery("<div>", { "class": "ganttview-grid-row-cell" });
						if (DateUtils.isWeekend(dates[y][m][d]) && showWeekends) { 
							cellDiv.addClass("ganttview-weekend"); // 用css class 標註假日顏色							
						}
						//beg add
						var datestr= dates[y][m][d].getFullYear()  + '-' + (dates[y][m][d].getMonth()+1) + '-' +  dates[y][m][d].getDate();
						cellDiv.attr("title",datestr);
						//console.log("title="+datestr);
						//end add						
						rowDiv.append(cellDiv); //將每個"日" 加到 rowDiv 
					}
				}
			}
            var w = jQuery("div.ganttview-grid-row-cell", rowDiv).length * cellWidth;
            rowDiv.css("width", w + "px");
            gridDiv.css("width", w + "px");
			//console.log("rooms="+data.length);
		
            for (var i = 0; i < data.length; i++) {   //主要task (範例數據中為FeatureX) ,對比於 room
				for (var j = 0; j < data[i].series.length; j++) {   //每個主Task 的breakdown , 例如範例數據中 Feature1 含 Planned,Actual 二個series
					//console.log(i+"-->data[i].series="+data[i].series.length+"(code)="+data[i].series[j].code+"(codename)="+data[i].series[j].codename+"(name)="+data[i].series[j].name);
					var mod_rowDiv= rowDiv.clone();
					mod_rowDiv.attr("title",data[i].series[j].codename+data[i].name+","+data[i].series[j].code);
                    //gridDiv.append(rowDiv.clone()); //rowDiv對每個breakdown 都一樣，將每個"rowDiv" 加到 gridDiv
					gridDiv.append(mod_rowDiv); //rowDiv對每個breakdown 都一樣，將每個"rowDiv" 加到 gridDiv
                }				
            }
            div.append(gridDiv);
        }

        function addBlockContainers(div, data) {
            var blocksDiv = jQuery("<div>", { "class": "ganttview-blocks" });
            for (var i = 0; i < data.length; i++) {
                for (var j = 0; j < data[i].series.length; j++) {
                    blocksDiv.append(jQuery("<div>", { "class": "ganttview-block-container" }));
                }
            }
            div.append(blocksDiv);
        }

        function addBlocks(div, data, cellWidth, start) {
            var rows = jQuery("div.ganttview-blocks div.ganttview-block-container", div);
            var rowIdx = 0;
            for (var i = 0; i < data.length; i++) {
                for (var j = 0; j < data[i].series.length; j++) {
                    var series = data[i].series[j];
					//beg add
					//Series's name ='empty' 視為空房 ，塞入一個
					if(series.name=='empty') {
						var empty_block = jQuery("<div>", { "class": "empty_ganttview-block-container" });
						jQuery(rows[rowIdx]).append(empty_block);
						rowIdx = rowIdx + 1;										
						continue;
					}
                    //end add                    
                    var size = DateUtils.daysBetween(series.start, series.end) + 1;
					var offset = DateUtils.daysBetween(start, series.start);
					var block = jQuery("<div>", {
                        "class": "ganttview-block",
                        "title": series.name + ", " + size + " days",
                        "css": {
                            "width": ((size * cellWidth) - 9) + "px",
                            "margin-left": ((offset * cellWidth) + 3) + "px"
                        }
                    });
                    addBlockData(block, data[i], series);
                    if (data[i].series[j].color) {
                        block.css("background-color", data[i].series[j].color);
                    }
                    block.append(jQuery("<div>", { "class": "ganttview-block-text" }).text(size));
                    jQuery(rows[rowIdx]).append(block);
                    rowIdx = rowIdx + 1;
                }
            }
        }
        
        function addBlockData(block, data, series) {
        	// This allows custom attributes to be added to the series data objects
        	// and makes them available to the 'data' argument of click, resize, and drag handlers
        	var blockData = { id: data.id, name: data.name };
        	jQuery.extend(blockData, series);
        	block.data("block-data", blockData);
        }

        function applyLastClass(div) {
            jQuery("div.ganttview-grid-row div.ganttview-grid-row-cell:last-child", div).addClass("last");
            jQuery("div.ganttview-hzheader-days div.ganttview-hzheader-day:last-child", div).addClass("last");
            jQuery("div.ganttview-hzheader-months div.ganttview-hzheader-month:last-child", div).addClass("last");
        }
		
		return {
			render: render
		};
	}

	var Behavior = function (div, opts) {
		
		function apply() {
			
			if (opts.behavior.clickable) { 
            	bindBlockClick(div, opts.behavior.onClick); 
        	}
        	
            if (opts.behavior.resizable) { 
            	bindBlockResize(div, opts.cellWidth, opts.start, opts.behavior.onResize); 
        	}
            
            if (opts.behavior.draggable) { 
            	bindBlockDrag(div, opts.cellWidth, opts.start, opts.behavior.onDrag); 
        	}
		}

        function bindBlockClick(div, callback) {
            jQuery("div.ganttview-block", div).on("click", function () {
                if (callback) { callback(jQuery(this).data("block-data")); }
            });
        }
        
        function bindBlockResize(div, cellWidth, startDate, callback) {
        	jQuery("div.ganttview-block", div).resizable({
        		grid: cellWidth, 
        		handles: "e,w",
        		stop: function () {
        			var block = jQuery(this);
        			updateDataAndPosition(div, block, cellWidth, startDate);
        			if (callback) { callback(block.data("block-data")); }
        		}
        	});
        }
        
        function bindBlockDrag(div, cellWidth, startDate, callback) {
        	jQuery("div.ganttview-block", div).draggable({
        		axis: "x", 
        		grid: [cellWidth, cellWidth],
        		stop: function () {
        			var block = jQuery(this);
        			updateDataAndPosition(div, block, cellWidth, startDate);
        			if (callback) { callback(block.data("block-data")); }
        		}
        	});
        }
        
        function updateDataAndPosition(div, block, cellWidth, startDate) {
        	var container = jQuery("div.ganttview-slide-container", div);
        	var scroll = container.scrollLeft();
			var offset = block.offset().left - container.offset().left - 1 + scroll;
			
			// Set new start date
			var daysFromStart = Math.round(offset / cellWidth);
			var newStart = startDate.clone().addDays(daysFromStart);
			block.data("block-data").start = newStart;

			// Set new end date
        	var width = block.outerWidth();
			var numberOfDays = Math.round(width / cellWidth) - 1;
			block.data("block-data").end = newStart.clone().addDays(numberOfDays);
			jQuery("div.ganttview-block-text", block).text(numberOfDays + 1);
			
			// Remove top and left properties to avoid incorrect block positioning,
        	// set position to relative to keep blocks relative to scrollbar when scrolling
			block.css("top", "").css("left", "")
				.css("position", "relative").css("margin-left", offset + "px");
        }
        
        return {
        	apply: apply	
        };
	}

    var ArrayUtils = {
	
        contains: function (arr, obj) {
            var has = false;
            for (var i = 0; i < arr.length; i++) { if (arr[i] == obj) { has = true; } }
            return has;
        }
    };

    var DateUtils = {
    	
        daysBetween: function (start, end) {
            if (!start || !end) { return 0; }
            start = Date.parse(start); end = Date.parse(end);
            if (start.getYear() == 1901 || end.getYear() == 8099) { return 0; }
            var count = 0, date = start.clone();
            while (date.compareTo(end) == -1) { count = count + 1; date.addDays(1); }
            return count;
        },
        
        isWeekend: function (date) {
            return date.getDay() % 6 == 0;
        },

		getBoundaryDatesFromData: function (data, minDays) {
			var minStart = new Date(); maxEnd = new Date();
			for (var i = 0; i < data.length; i++) {
				for (var j = 0; j < data[i].series.length; j++) {
					var start = Date.parse(data[i].series[j].start);
					var end = Date.parse(data[i].series[j].end)
					if (i == 0 && j == 0) { minStart = start; maxEnd = end; }
					if (minStart.compareTo(start) == 1) { minStart = start; }
					if (maxEnd.compareTo(end) == -1) { maxEnd = end; }
				}
			}
			
			// Insure that the width of the chart is at least the slide width to avoid empty
			// whitespace to the right of the grid
			if (DateUtils.daysBetween(minStart, maxEnd) < minDays) {
				maxEnd = minStart.clone().addDays(minDays);
			}
			
			return [minStart, maxEnd];
		}
    };


    
    
})(jQuery);