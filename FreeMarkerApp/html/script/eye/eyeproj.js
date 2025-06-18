

/* note : should include   
<link rel="stylesheet" type="text/css"
	href="${base}/script/eye/jquery-toast-plugin/dist/jquery.toast.min.css">
<script type="text/javascript"
	src="${base}/script/eye/jquery-toast-plugin/dist/jquery.toast.min.js"></script>
	
<script src="${base}/AdminLTE/plugins/Chart.js" type="text/javascript"></script>
<script src="${base}/AdminLTE/plugins/chartjs/Chart.PieceLabel.min.js"></script>	
*/	
	

function ToogleRadio(radio,radio_name)
{	
    if(radio.data("waschecked") == true){
        radio.prop("checked", false);
        radio.data("waschecked", false);
    }else{
        radio.data("waschecked", true);       
        //清除其他not checked radio's waschecked	            
        $("input:radio[name="+radio_name+"]").each(function(){
            if($(this)[0].checked == false){
            	$(this).data("waschecked", false);
            }
        });     
    }	
}

function bindRadioClickRest(radio_name)
{	
    $('input[type=radio][name='+radio_name+']').on('click',function(){
    	ToogleRadio($(this),radio_name);   	       
    });	    
}

function eye_toastMessage(htmlmsg,delayms){
	
	$.toast({
	    heading: 'Information',
	    text: htmlmsg,
	    //bgColor: '#FF1356',
	    //textColor: 'white'
	    icon: 'info',
	    loader: false,        // Change it to false to disable loader
	    position: 'top-center',	    
	    stack:5,
	    hideAfter: delayms, 
	    loaderBg: '#9EC600'  // To change the background
	        
	})
	
}


function updateAI_all(postUrl,keyno,saveflag)
{
	
	if(keyno==''){
		alert("請輸入表單編號");
		return 0;
	}
		
	eye_toastMessage('>>> AI分析中，請稍後! <<<',2500);
	$.ajax({
	       url: postUrl,//'${base}/device/api2/eye/updateAI_all',
	       type: "POST",
	       dataType: 'json' ,
	       async:true,
		   data: {
			   keyno:keyno,
			   saveflag:saveflag //"1"    //saveflag="0"  取得AI info,不存入DB "1"
		   },	
	       success: function(data) {
	    	   if(data.success=="true")
	    		   {
	    		   	//alert("AI 評估完畢!!");
	    		   	eye_toastMessage('AI 評估完畢!!',1200);
	    		   	return 1;
	    		   }
	    	   else{
	    		   alert(data.errmsg);
	    		   return 0;
	    	   }
		   }
	});
	
	
}

function getFName(inputstr){
	return inputstr.split('\\').pop().split('/').pop();
}

<!-- 從DB中抓AI評估結果 ，若無，要重新從AI網站進行評估-->
function showAIData(baseUrl,postUrl,keyno,imgid,canvas_pred_id,canvas_sever_id,toid)
{
	
	
	$.ajax({
	       url: postUrl,//'${base}/device/api2/eye/getAIByKeyno',
	       type: "POST",
	       dataType: 'json' ,	
		   data: {
			   keyno:keyno,
			   imgid:imgid
		   },	
	       success: function(data) {

	    	   if(data.success=='true'){
	    		   var y_data = [];	   	    		
	    	       var x_data= [];
	    		   var ys_data = []	;	   	    		
	    	       var xs_data= [];
	    	       var x_color =[];
	    	       var xs_color =[];
	    	       var kk=JSON.parse(data.result);
	    		   for (var ii = 0; kk!=null &&  ii < kk.length; ii++) {
	    			    var aiobj=kk[ii].ai;
	    			    
	    			    
	    			   
	    buildAIAttachImgRegion(baseUrl,canvas_pred_id+"_img",imgid,getFName(aiobj.heatmap_url),getFName(aiobj.lesion_image_url),getFName(aiobj.preprocessed_image),getFName(aiobj.preprocessed_lesion_image_url),toid);
	    			    
	    			    
	    			    //左方圖
	      				y_data.push(aiobj.Prediction.Proliferative);
	       				x_data.push("Proliferative"); x_color.push('rgb(213,0,0)');
	       				y_data.push(aiobj.Prediction.Severe);
	       				x_data.push("Severe");   x_color.push('rgb(255,23,68)'); 
	       				y_data.push(aiobj.Prediction.Moderate);
	       				x_data.push("Moderate"); x_color.push('rgb(255,138,128)');   				
	    			  	y_data.push(aiobj.Prediction.Mild);
	    			  	x_data.push("Mild"); 	x_color.push('rgb(255, 185, 0)');
	       				y_data.push(aiobj.Prediction.No);
	       				x_data.push("No");  x_color.push('rgb(16, 164, 16)');

	       				//右方圖
	       				ys_data.push(aiobj.Severity.DR);
	       				xs_data.push("Severity");  //DR
	       				xs_color.push('rgb(183,28,28)');
	       				       				
	       				ys_data.push(aiobj.Severity.NonDR);
	       				xs_data.push("NonDR");  //DR
	       				xs_color.push('rgb(16, 164, 16)');
	       				
	       				/*
	       				if(simflag==1)
	       					ys_data.push(aiobj.Severity.NonDR);
	       				else
	       					ys_data.push(aiobj.Severity["Non-DR"]);   					
	       				xs_data.push("NonDR");
	       				*/
	    		   }
	    		   
	    		   var title="";
	    		   if(kk==null || kk.length==0)
	    			{
	    			   	$("#ai_div").hide();
	    			   	
	    			   	
	    			   	$("#"+canvas_pred_id+"_img").hide();//AI附屬圖
	    			   	
	    			   	$("#"+canvas_pred_id).hide();
	    			   	$("#"+canvas_sever_id).hide();
	    			}
	    		   else{
	    			   $("#ai_div").show();
	    			   $("#"+canvas_pred_id+"_img").show()
  	    			   $("#"+canvas_pred_id).show();
	    			   $("#"+canvas_sever_id).show();

	    			   displayChartDonult(canvas_sever_id,"Referral",xs_data,ys_data,'rgb(5, 9, 172)',xs_color);
	    			   displayChart(canvas_pred_id,"Probability for Each Diagnosis",x_data,y_data,'rgb(255, 99, 132)',x_color);
	    			   console.log("pred c_w="+$("#"+canvas_pred_id).width()+" c_h="+$("#"+canvas_pred_id).height());
	    		   }
	    		   
	    	   }
	    	   
		   }
	});
	
	
}

function ChgImage(targetid,divid)
{	
	targetid=targetid.trim();
    var url=$("#"+targetid).attr("src");
	$("#"+divid).attr('src',url);	
		
}

function buildAIAttachImgRegion(baseUrl,divid,imgid,i_heat,i_lesion,i_pre,i_pre_lesion,toid)
{

	var imglist='';
	
	var inner="'"+imgid+"_o"+"'"+","+"'"+toid+"'";
	imglist+='<img class="resize" id='+imgid+'_o'+' width="50" src="'+baseUrl+'/download.action?fileName='+imgid+'"'+' onclick='+'"ChgImage('+inner+')">原圖';
	
	inner="'"+imgid+"_pre"+"'"+","+"'"+toid+"'";
	imglist+='<img class="resize" id='+imgid+'_pre'+' width="50" src="'+baseUrl+'/dnphoto?fileName='+i_pre+'"'+' onclick='+'"ChgImage('+inner+')">強化';
		
	inner="'"+imgid+"_lesion"+"'"+","+"'"+toid+"'";
	imglist+='<img class="resize" id='+imgid+'_lesion'+' width="50" src="'+baseUrl+'/dnphoto?fileName='+i_lesion+'"'+' onclick='+'"ChgImage('+inner+')">Region of Interest';
	
	/*
	inner="'"+imgid+"_pre_lesiont"+"'"+","+"'"+toid+"'";
	imglist+='<img class="resize" id='+imgid+'_pre_lesiont'+' width="50" src="'+baseUrl+'/dnphoto?fileName='+i_pre_lesion+'"'+' onclick='+'"ChgImage('+inner+')">PRE_LE';
	
	inner="'"+imgid+"_heat"+"'"+","+"'"+toid+"'";
	imglist+='<img class="resize" id='+imgid+'_heat'+' width="50" src="'+baseUrl+'/dnphoto?fileName='+i_heat+'"'+' onclick='+'"ChgImage('+inner+')">HEAT';
	*/

	$("#"+divid).html(imglist);			    		 			    		 
	 
}

function displayChart(canvasid,title,xdata,ydata,color,data_color){
	
	var ctx = document.getElementById(canvasid).getContext('2d');
	//console.log(ctx);
	//ctx.height = 100;
	var chartOptions = {
	        title: {
	            display: false,
	            text: 'Custom Chart Title'
	        },
	        legend: {
	            display: false
	        },	        
	      	tooltips: {
	        	callbacks: {
	          	label: function(tooltipItem) {
	            //console.log(tooltipItem)
	            	return tooltipItem.xLabel;
	            }
	          }},	        
			maintainAspectRatio: true,
			  scales: {
			    yAxes: [{
			     // barPercentage: 0.5
			    }],
	            xAxes: [{
	                ticks: {
	                    min: 0,
	                    max: 100
	                }
	            }]
			  },
			  elements: {
			    rectangle: {
			      borderSkipped: 'left',
			    }
			  }
			};
	var chart = new Chart(ctx, {
	    // The type of chart we want to create
	    type: 'horizontalBar',
	    
	    // The data for our dataset
	    data: {
	        //labels: ["January", "February", "March", "April", "May", "June", "July"],
	    	labels: xdata,
	        datasets: [{
	            label: title,
	            backgroundColor: data_color,//color, //'rgb(255, 99, 132)',
	            //borderColor: 'rgb(255, 99, 132)',
	            //data: [0, 10, 5, 2, 20, 30, 45],
	            data: ydata,
		    	//borderWidth: 20,
		    	//hoverBorderWidth: 0
	        }]
	    },

	    // Configuration options go here
	    options: chartOptions
	});
	
}

function displayChartDonult(canvasid,title,xdata,ydata,color,data_color){
	
	
	displayChartGauge(canvasid,title,xdata,ydata,color,data_color);
	if(1==1)
		return ;
	
	
	var donult_labels= ["DR","NonDR"];
	var ctx = document.getElementById(canvasid).getContext('2d');
	//console.log(ctx);
	//ctx.height = 100;
	var chartOptions = {
	        title: {
	            display: false,
	            text: 'Referral Rate'
	        },
	        legend: {
	            display: true
	        },
			maintainAspectRatio: true,
	        rotation: -Math.PI,
	        cutoutPercentage: 30,
	        circumference: Math.PI,
	        animation: {
			animateRotate : true,
			animateScale : true,
	        },

			};
	var chart = new Chart(ctx, {
	    // The type of chart we want to create
	    type: 'doughnut',
	    
	    // The data for our dataset
	    data: {
	        //labels: ["January", "February", "March", "April", "May", "June", "July"],
	    	labels: donult_labels,
	        datasets: [{
	            label: title,
	            backgroundColor: data_color,//color, //'rgb(255, 99, 132)',
	            //borderColor: 'rgb(255, 99, 132)',
	            //data: [0, 10, 5, 2, 20, 30, 45],
	            data: ydata,
		    	//borderWidth: 20,
		    	//hoverBorderWidth: 0
	        }]
	    },

	    // Configuration options go here
	    options: chartOptions
	});

	
	
	
}

<!--gauge test not: should include gauge.js after chart.js-->
function displayChartGauge(canvasid,title,xdata,ydata,color,data_color){
	
	//var donult_labels= ["DR","NonDR"];
	var ctx = document.getElementById(canvasid).getContext('2d');
	//console.log(ctx);
	//ctx.height = 100;
	var gaugeData=ydata[0];
	
	var chartOptions = {
            events: [],
            showMarkers: true,		
	
	        title: {
	            display: true,
	            text: 'Referral Rate',
	            position:'bottom'
	        },
	        maintainAspectRatio: true,
	        /*
	        legend: {
	            display: true
	        },
			maintainAspectRatio: true,
			
	        rotation: -Math.PI,
	        cutoutPercentage: 30,
	        circumference: Math.PI,
	        animation: {
	        	animateRotate : true,
				nimateScale : true,
	        },
*/
			};
	var chart = new Chart(ctx, {
	    // The type of chart we want to create
	    type: 'tsgauge',
	    
	    // The data for our dataset
	    data: {
	        //labels: ["January", "February", "March", "April", "May", "June", "July"],
	    	//labels: donult_labels,
	        datasets: [{
				//backgroundColor: ["#0fdc63", "#0fdc63", "#0fdc63", "#0fdc63", "#0fdc63"],
	        	backgroundColor: ["#05371d", "#294800", "#5e5200", "#a14c00", "#eb121b"],
				borderWidth: 0,
				gaugeData: {
					value: gaugeData,
					valueColor: "#ff7143"
				},
				gaugeLimits: [0, 20, 40,60,80, 100]
	        }]
	    },

	    // Configuration options go here
	    options: chartOptions
	});

	
	
	
}
