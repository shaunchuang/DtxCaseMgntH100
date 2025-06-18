<script>
var newChart;

//建立各檢測項之趨勢圖
function createNewChart(deviceNo, app){
	var itemNo = parseInt(deviceNo);
	var target = $(".data-save");
	
	switch(itemNo){
		//眼底圖
		case 1:
			//getEyeLineChart(app);
			getItemLineChart(app , "<@spring.message "chart.label.ophthalmoscope"/>");
			break;
		//傷口圖
		case 2:
			target.val(app);
			getWoundLineChart(app, "<@spring.message "chart.label.wound"/>", 0);
			break;
		//超音波圖
		case 3:
			//getUltraSoundLineChart(app);
			getItemLineChart(app, "<@spring.message "chart.label.ultrasound"/>");
			break;
		//心電圖
		case 4:
			//getEcgLineChart(app);
			getItemLineChart(app, "<@spring.message "chart.label.ecg"/>");
			break;
		//肺量圖
		case 5:
			//getLfmLineChart(app);
			getItemLineChart(app, "<@spring.message "chart.label.spirometer"/>");
			break;
		//耳鏡圖
		case 6:
			//getOtoLineChart(app);
			getItemLineChart(app, "<@spring.message "chart.label.otoscope"/>");
			break;
		//聽力檢測圖
		case 7:
			//getAudioMetersLineChart(app);
			getItemLineChart(app, "<@spring.message "chart.label.hearingDetector"/>");
			break;
		//ABI圖
		case 8:
			//getEcgLineChart(app);
			getItemLineChart(app, "<@spring.message "chart.label.abi"/>");
			break;
		//皮膚鏡圖
		case 9:
			//getOtoLineChart(app);
			getItemLineChart(app, "<@spring.message "chart.label.dermatoscope"/>");
			break;
	}
}

//先統一樣板(除傷口圖外)趨勢圖資訊
function getItemLineChart(app, itemName){
	var postData = {"keyno": app};	
	var data = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/getItemChartData");
	var result = data.result;
	var formNo = [];
	var evalDate = [];
	var total = [];
	var arrHeight = [];
	var arrWidth = [];
	var arrDepth = [];
	var arrArea = [];
	var arrEpithelium = [];
	var arrGranular = [];
	var arrSlough = [];
	var arrEschar = [];
	var arrImgPath = [];

	for(var i=0; i<result.length; i++){
		formNo.push(result[i].formNo);
		evalDate.push(result[i].date);
		arrHeight.push(result[i].height);
		arrWidth.push(result[i].width);
		arrDepth.push(result[i].depth);
		arrArea.push(result[i].area);
		arrEpithelium.push(result[i].epithelium / 100 * result[i].area);
		arrGranular.push(result[i].granular / 100 * result[i].area);
		arrSlough.push(result[i].slough / 100 * result[i].area);
		arrEschar.push(result[i].eschar / 100 * result[i].area);
		arrImgPath.push("${base}" + result[i].imgPath);
	}
	total.push(formNo);
	total.push(evalDate);
	total.push(arrHeight);
	total.push(arrWidth);
	total.push(arrDepth);
	total.push(arrArea);
	total.push(arrEpithelium);
	total.push(arrGranular);
	total.push(arrSlough);
	total.push(arrEschar);
	total.push(arrImgPath);
	
	renderChart("resultChart", itemName, total, zh_chart.proportion);
}

function renderChart(className, mainTitle, arrData){
	var unit = mainTitle + " <@spring.message "chart.label.chartName"/>";
	var maxNum = 100;
	var minNum = 0;
	var imgLogoList = arrData[10];
	var dateLeng = arrData[1].length;
	var timeRange = getTimeRange(arrData[1]);
	var startPoints = [];
	
	var config = {
		type: 'line',
		data: {			
			labels: arrData[1],			
			datasets: [{
				label: "<@spring.message "chart.label.none"/>",
				backgroundColor: colors.red.stroke,
				borderColor: colors.red.stroke,
				//pointStyle: imgLogo,
				data: arrData[2],
				fill: false
			},{
				label: "<@spring.message "chart.label.none"/>",
				backgroundColor: colors.blue.stroke,
				borderColor: colors.blue.stroke,
				data: arrData[3],
				fill: false
			}, {
				label: "<@spring.message "chart.label.none"/>",
				fill: false,
				backgroundColor: colors.green.stroke,
				borderColor: colors.green.stroke,
				data: arrData[4]
			}],			
		},
		options: {
			animation: false,
			spanGaps: true,	//防止數據為0或null斷點情形
			layout:{
				padding:{
					right: 18
				}
			},			
			plugins:{
				responsive: true,
				legend: {
					position: 'bottom'
				},
				title: {
					display: true,
					font:{
						size: 18
					},
					text: unit
				},
				tooltip: {
		            callbacks: {
		                label: function(context) {
		                    var label = context.dataset.label || '';
	
		                    if (label) {
		                        label += ': ';
		                    }
		                    
		                    if (context.parsed.y !== null) {
		                    	label += context.parsed.y + " cm";
		                    }	
		                    return label;
		                },
		                title: function (item) {
							return "<@spring.message "chart.label.evalDate"/>" + item[0].label
						}
		            }
		        },		        				
	        },	        
			scales: {				
				x: {
					type: 'time',
					time:{
						tooltipFormat: 'yyyy-MM-dd',
						displayFormats:{
							day: 'yyyy-MM-dd'
						},
						minUnit: 'day'
											 
					},
					ticks:{
						source: 'data',
						font:{
							size: 16
						}
					},
					grid:{
						display: true
					},
					min: timeRange[0],
					max: timeRange[1],
					offset: true
				},
				y: {
					beginAtZero: true,
					offset: true,
					max: 40,
					ticks:{
						padding: 10
					},
					title:{
						display: false,
						text: '<@spring.message "chart.label.centimeter"/>'
					}	
				}
			}
		},		
		plugins: [{
			id: 'clickImg',
		    beforeDatasetsDraw(chart, args, options){      
		      	var {ctx, canvas, chartArea: {left, right, top, bottom, width, height} } = chart;
		      	startPoints = [];
				for(var i=0; i<imgLogoList.length; i++){
					if(imgLogoList[i] != ""){
						var imgLogo = new Image();
						imgLogo.src = imgLogoList[i];
						imgLogo.alt = arrData[0][i]
						if(imgLogo.complete){
							ctx.drawImage(imgLogo, chart.getDatasetMeta(0).data[i].x - (90/2), 40, 100, 100);
							startPoints.push(chart.getDatasetMeta(0).data[i].x - (90/2));
						}else{
							imgLogo.onload = () => chart.draw();
						}
					}

				}  
		    }
	  	},{
	  		id: 'moveChart',
	  		afterEvent(chart, args){
	  			var {ctx, canvas, chartArea: {left, right, top, bottom, width, height} } = chart;
	  			
	  			canvas.addEventListener('mousemove', (event) =>{
	  				var x = args.event.x;
	  				var y = args.event.y;

	  				if(x >= left - 15 && x <= left + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){
	  					canvas.style.cursor = 'pointer';
	  				}else if(x >= right - 15 && x <= right + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){
	  					canvas.style.cursor = 'pointer';
	  				}else{
	  					canvas.style.cursor = 'default';
	  				}

	  			})
	  		},
	  		afterDraw(chart, args, pluginOptions){
	  			var {ctx, chartArea: {left, right, top, bottom, width, height} } = chart;
	  			
	  			class CircleChevon{
	  				draw(ctx, x1, pixel){
	  					var angle = Math.PI / 180;
			  			ctx.beginPath();
			  			ctx.lineWidth = 3;
			  			ctx.strokeStyle = 'rgba(102,102,102,0.5)';
			  			ctx.fillStyle = 'white';
			  			ctx.arc(x1, height / 2 + top, 15, angle * 0, angle * 360, false);
			  			ctx.stroke();
			  			ctx.fill();
			  			ctx.closePath();
			  			
			  			// chevron Arrow Left
			  			ctx.beginPath();
			  			ctx.lineWidth = 3;
			  			ctx.strokeStyle = 'rgba(255,26,104,1)';
			  			ctx.moveTo(x1 + pixel, height / 2 + top - 7.5);
			  			ctx.lineTo(x1 - pixel, height / 2 + top);
			  			ctx.lineTo(x1 + pixel, height / 2 + top + 7.5);
			  			ctx.stroke();
			  			ctx.closePath();
	  				}
	  			}
	  			
	  			let drawCircleLeft = new CircleChevon();
	  			drawCircleLeft.draw(ctx, left, 5);
	  			
	  			let drawCircleRight = new CircleChevon();
	  			drawCircleLeft.draw(ctx, right, -5);
			
	  		}
	  	},{
	  		id: "clickChart",
	  		afterEvent(chart, args){
	  			var {ctx, canvas, chartArea: {left, right, top, bottom, width, height} } = chart;
	  			
	  			var event = args.event;
		      	if (event.type === 'click') {
		      		var updated = false;
			        var x = args.event.x;
	  				var y = args.event.y;
					var totalDataLeng = arrData[1].length;
					var minIdx = arrData[1].indexOf(chart.options.scales.x.min);
					var maxIdx = arrData[1].indexOf(chart.options.scales.x.max);
					
	  				if(x >= left - 15 && x <= left + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){
	  					if(minIdx - 4 <= 0){
	  						chart.options.scales.x.min = arrData[1][0];
	  					}
	  					else{
	  						chart.options.scales.x.min = arrData[1][minIdx - 4];
	  					}
	  					chart.options.scales.x.max = arrData[1][minIdx - 1];
	  					updated = true; 
	  				}
	  				else if(x >= right - 15 && x <= right + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){	  					  					
	  					if(totalDataLeng - 1 > maxIdx){
	  						chart.options.scales.x.min = arrData[1][maxIdx+1];
	  						if(arrData[1].length-1 > maxIdx + 4){
	  							chart.options.scales.x.max = arrData[1][maxIdx + 4];
	  						}
	  						else{
	  							chart.options.scales.x.max = arrData[1][totalDataLeng-1];
	  						}
	  						updated = true;
	  					}  					
	  				}
	  				
  					if(updated) chart.update();
		      	}
	  			
	  		}
	  	}]
	};
	
	newChart = new Chart(document.getElementById(className), config);
	var ctx = document.getElementById(className);
	
	function clickableScales(canvas, click){
		var height = newChart.scales.x.height;
		var top = newChart.scales.x.top;
		var bottom = newChart.scales.x.bottom;
		var left = newChart.scales.x.left;
		var right = newChart.scales.x.maxWidth / newChart.scales.x.ticks.length;
		var resetCoordinates = canvas.getBoundingClientRect();
		
		var maxDate = timestampToDate(newChart.scales.x.max);
		var maxIdx = arrData[1].indexOf(maxDate);
		var page = parseInt(maxIdx/4);

		var x = click.clientX - resetCoordinates.left;
		var y = click.clientY - resetCoordinates.top;

		var colorArray = [], weightArray = [];
		var changed = false;
		var formNo = "";
		
		if(startPoints.length > 0){
			for(var j=0; j<startPoints.length; j++){
				if(x >= startPoints[j] && x <= startPoints[j] + 100	&& y >= 40 && y<= 140){
					console.log(arrData[1][j]);
					showGallery(arrData[0][j], arrData[1][j]);	
				}
			}
		}

		for(var i=0; i<newChart.scales.x.ticks.length; i++){
			var color = "#666";
			var weight = "500";
			if(x >= left + (right * i) && x <= right + (right * i) && y >= top && y<= bottom){
				formNo = arrData[0][i + (page*4)];
				color = "#b37700";
				weight = "600";
				changed = true;			
			}
			colorArray.push(color);
			weightArray.push(weight);
			
		}
		newChart.config.options.scales.x.ticks.color = colorArray;
		newChart.config.options.scales.x.ticks.font.weight = weightArray;
		if(changed){
			newChart.update();
			$(".date-btn[data-formNo='" + formNo + "']").trigger('click');
		}
	}
	
	ctx.addEventListener('click', (e) =>{
		clickableScales(ctx, e);
	});
	
	const getLabelAndValue = Chart.controllers.line.prototype.getLabelAndValue;
	Chart.controllers.line.prototype.getLabelAndValue = function(index) {
	  	return getLabelAndValue.call(this, index);
	}
}

//取得眼底趨勢圖資訊
function getEyeLineChart(app){

}

//取得傷口趨勢圖資訊
function getWoundLineChart(app, mainTitle, index){
	var data = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getWoundChartData?app=" + app);
	var result = data.result;
	var formNo = [];
	var evalDate = [];
	var total = [];
	var arrHeight = [];
	var arrWidth = [];
	var arrDepth = [];
	var arrArea = [];
	var arrEpithelium = [];
	var arrGranular = [];
	var arrSlough = [];
	var arrEschar = [];
	var arrImgPath = [];
	
	if(result != undefined && result.length > 0){
		for(var i=0; i<result.length; i++){
			formNo.push(result[i].formNo);
			evalDate.push(result[i].date);
			arrHeight.push(result[i].height);
			arrWidth.push(result[i].width);
			arrDepth.push(result[i].depth);
			arrArea.push(result[i].area);
			arrEpithelium.push(result[i].epithelium / 100 * result[i].area);
			arrGranular.push(result[i].granular / 100 * result[i].area);
			arrSlough.push(result[i].slough / 100 * result[i].area);
			arrEschar.push(result[i].eschar / 100 * result[i].area);
			arrImgPath.push("${base}" + result[i].imgPath);
		}
	}
	total.push(formNo);
	total.push(evalDate);
	total.push(arrHeight);
	total.push(arrWidth);
	total.push(arrDepth);
	total.push(arrArea);
	total.push(arrEpithelium);
	total.push(arrGranular);
	total.push(arrSlough);
	total.push(arrEschar);
	total.push(arrImgPath);
	
	if(index == 0){
		renderWoundDimension("resultChart", mainTitle, "<@spring.message "chart.label.size"/>", total);
	}
	else{
		renderWoundProp("resultChart", mainTitle, "<@spring.message "chart.label.proportion"/>", total);
	}
}

//取得趨勢圖載入顯示日期範圍(目前首次載入以4天為限)
function getTimeRange(dateArr){
	var timeRange = [];
	var startDate = "", endDate = "";

	if(dateArr.length < 4 ){
		startDate = dateArr[0];
		endDate = dateArr[dateArr.length-1];
	}
	else{
		startDate = dateArr[0];
		endDate = dateArr[3];
	}
	timeRange.push(startDate);
	timeRange.push(endDate);
	return timeRange;
}

//將timestamp轉換為日期
function timestampToDate(str){
    var realDate = new Date(str);
    var year = realDate.getFullYear();
    var month = (realDate.getMonth()+1<10 ? '0' : '') + (realDate.getMonth()+1);
    var date = (realDate.getDate()<10 ? '0' : '') + realDate.getDate();
    var dateTime = year + '-' + month + '-' + date;
    return dateTime;
}

//產出傷口尺寸趨勢圖
function renderWoundDimension(className, mainTitle, subTitle, arrData){
	var unit = mainTitle + subTitle + " <@spring.message "chart.label.chartName"/>";
	var maxNum = 100;
	var minNum = 0;
	var imgLogoList = arrData[10];
	var dateLeng = arrData[1].length;	
	var timeRange = getTimeRange(arrData[1]);
	var startPoints = [];

	var config = {
		type: 'line',
		data: {			
			labels: arrData[1],			
			datasets: [{
				label: "<@spring.message "chart.label.height"/>",
				backgroundColor: colors.red.stroke,
				borderColor: colors.red.stroke,
				//pointStyle: imgLogo,
				data: arrData[2],
				fill: false
			},{
				label: "<@spring.message "chart.label.width"/>",
				backgroundColor: colors.blue.stroke,
				borderColor: colors.blue.stroke,
				data: arrData[3],
				fill: false
			}, {
				label: "<@spring.message "chart.label.depth"/>",
				fill: false,
				backgroundColor: colors.green.stroke,
				borderColor: colors.green.stroke,
				data: arrData[4]
			}],			
		},
		options: {
			animation: false,
			spanGaps: true,	//防止數據為0或null斷點情形
			layout:{
				padding:{
					right: 18
				}
			},
			interaction: {
	            mode: 'index',
	            axis: 'y'
	        },	
			plugins:{
				responsive: true,
				legend: {
					position: 'bottom',
				},
				title: {
					display: true,
					font:{
						size: 18
					},
					text: unit
				},
				tooltip: {
		            callbacks: {
		                label: function(context) {
		                    var label = context.dataset.label || '';
	
		                    if (label) {
		                        label += ': ';
		                    }
		                    
		                    if (context.parsed.y !== null) {
		                    	label += context.parsed.y + " <@spring.message "chart.label.centimeter"/>";
		                    }	
		                    return label;
		                },
		                title: function (item) {
							return "<@spring.message "chart.label.evalDate"/>" + item[0].label
						}
		            }
		        },		        				
	        },	        
			scales: {				
				x: {
					type: 'time',
					time:{
						tooltipFormat: 'yyyy-MM-dd',
						displayFormats:{
							day: 'yyyy-MM-dd'
						},
						minUnit: 'day'			 
					},
					min: timeRange[0],
					max: timeRange[1],
					ticks:{
						source: 'data',
						font:{
							size: 16
						}
					},
					grid:{
						display: true
					},					
					offset: true
				},
				y: {
					beginAtZero: true,
					offset: true,
					max: 40,
					ticks:{
						padding: 10
					},
					title:{
						display: true,
						text: '<@spring.message "chart.label.tag.centimeter"/>'
					}	
				}
			}
		},		
		plugins: [{
		    id: 'clickImg',
		    beforeDatasetsDraw(chart, args, options){      
		      	var {ctx, canvas, chartArea: {left, right, top, bottom, width, height} } = chart;
		      	startPoints = [];
				for(var i=0; i<imgLogoList.length; i++){
					if(imgLogoList[i] != ""){
						var imgLogo = new Image();
						imgLogo.src = imgLogoList[i];
						if(imgLogo.complete){
							console.log(i + " ： " + chart.getDatasetMeta(0).data[i].x);
							ctx.drawImage(imgLogo, chart.getDatasetMeta(0).data[i].x - (90/2), 40, 100, 100);
							startPoints.push(chart.getDatasetMeta(0).data[i].x - (90/2));
						}else{
							imgLogo.onload = () => chart.draw();
						}
					}

				}  
		    }
	  	},{
	  		id: 'moveChart',
	  		afterEvent(chart, args){
	  			var {ctx, canvas, chartArea: {left, right, top, bottom, width, height} } = chart;
	  			
	  			canvas.addEventListener('mousemove', (event) =>{
	  				var x = args.event.x;
	  				var y = args.event.y;

	  				if(x >= left - 15 && x <= left + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){
	  					canvas.style.cursor = 'pointer';
	  				}else if(x >= right - 15 && x <= right + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){
	  					canvas.style.cursor = 'pointer';
	  				}else{
	  					canvas.style.cursor = 'default';
	  				}

	  			});
	  			
	  		},
	  		afterDraw(chart, args, pluginOptions){
	  			var {ctx, chartArea: {left, right, top, bottom, width, height} } = chart;
	  			
	  			class CircleChevon{
	  				draw(ctx, x1, pixel){
	  					var angle = Math.PI / 180;
			  			ctx.beginPath();
			  			ctx.lineWidth = 3;
			  			ctx.strokeStyle = 'rgba(102,102,102,0.5)';
			  			ctx.fillStyle = 'white';
			  			ctx.arc(x1, height / 2 + top, 15, angle * 0, angle * 360, false);
			  			ctx.stroke();
			  			ctx.fill();
			  			ctx.closePath();
			  			
			  			// chevron Arrow Left
			  			ctx.beginPath();
			  			ctx.lineWidth = 3;
			  			ctx.strokeStyle = 'rgba(255,26,104,1)';
			  			ctx.moveTo(x1 + pixel, height / 2 + top - 7.5);
			  			ctx.lineTo(x1 - pixel, height / 2 + top);
			  			ctx.lineTo(x1 + pixel, height / 2 + top + 7.5);
			  			ctx.stroke();
			  			ctx.closePath();
	  				}
	  			}
	  			
	  			let drawCircleLeft = new CircleChevon();
	  			drawCircleLeft.draw(ctx, left, 5);
	  			
	  			let drawCircleRight = new CircleChevon();
	  			drawCircleLeft.draw(ctx, right, -5);
	  			
	  		}
	  	},{
	  		id: "clickChart",
	  		afterEvent(chart, args){
	  			var {ctx, canvas, chartArea: {left, right, top, bottom, width, height} } = chart;
	  			var point = chart.getElementsAtEventForMode(args.event, 'grid', { intersect: true }, false);
	  			
	  			//const canvasPosition = Chart.helpers.getRelativePosition(e, chart);
	
	            // Substitute the appropriate scale IDs
	            const dataX = chart.scales.x.getValueForPixel(args.event.x);
	            const dataY = chart.scales.y.getValueForPixel(args.event.y);
	            //console.log("dataX: " + dataX);
	            //console.log("dataY: " + dataY);
	  			
	  			var event = args.event;
		      	if (event.type === 'click') {

		      		var updated = false;
			        var x = args.event.x;
	  				var y = args.event.y;
					var totalDataLeng = arrData[1].length;
					var minIdx = arrData[1].indexOf(chart.options.scales.x.min);
					var maxIdx = arrData[1].indexOf(chart.options.scales.x.max);
					
	  				if(x >= left - 15 && x <= left + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){
	  					if(minIdx - 4 <= 0){
	  						chart.options.scales.x.min = arrData[1][0];
	  					}
	  					else{
	  						chart.options.scales.x.min = arrData[1][minIdx - 4];
	  					}
	  					chart.options.scales.x.max = arrData[1][minIdx - 1];
	  					updated = true;
	  				}
	  				else if(x >= right - 15 && x <= right + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){
	  					  					
	  					if(totalDataLeng - 1 > maxIdx){
	  						chart.options.scales.x.min = arrData[1][maxIdx+1];
	  						if(arrData[1].length-1 > maxIdx + 4){
	  							chart.options.scales.x.max = arrData[1][maxIdx + 4];
	  						}
	  						else{
	  							chart.options.scales.x.max = arrData[1][totalDataLeng-1];
	  						}
	  						updated = true;
	  					}  					
	  				}
	  				
  					if(updated) chart.update();
		      	}
	  			
	  		}
	  	}]
	};
	
	newChart = new Chart(document.getElementById(className), config);
	var ctx = document.getElementById(className);
	
	function clickableScales(canvas, click){
		var height = newChart.scales.x.height;
		var top = newChart.scales.x.top;
		var bottom = newChart.scales.x.bottom;
		var left = newChart.scales.x.left;
		var right = newChart.scales.x.maxWidth / newChart.scales.x.ticks.length;
		var resetCoordinates = canvas.getBoundingClientRect();
		
		var maxDate = timestampToDate(newChart.scales.x.max);
		var maxIdx = arrData[1].indexOf(maxDate);
		var page = parseInt(maxIdx/4);

		var x = click.clientX - resetCoordinates.left;
		var y = click.clientY - resetCoordinates.top;

		var colorArray = [], weightArray = [];
		var changed = false;
		var formNo = "";
		
		if(startPoints.length > 0){
			for(var j=0; j<startPoints.length; j++){
				if(x >= startPoints[j] && x <= startPoints[j] + 100	&& y >= 40 && y<= 140){
					showGallery(arrData[0][j], arrData[1][j]);	
				}
			}
		}

		for(var i=0; i<newChart.scales.x.ticks.length; i++){
			var color = "#666";
			var weight = "500";
			if(x >= left + (right * i) && x <= right + (right * i) && y >= top && y<= bottom){
				formNo = arrData[0][i + (page*4)];
				color = "#b37700";
				weight = "600";
				changed = true;			
			}
			colorArray.push(color);
			weightArray.push(weight);
			
		}
		newChart.config.options.scales.x.ticks.color = colorArray;
		newChart.config.options.scales.x.ticks.font.weight = weightArray;
		if(changed){
			newChart.update();
			$(".date-btn[data-formNo='" + formNo + "']").trigger('click');
		}
	}
	
	ctx.addEventListener('click', (e) =>{
		clickableScales(ctx, e);
	});
	
	const getLabelAndValue = Chart.controllers.line.prototype.getLabelAndValue;
	Chart.controllers.line.prototype.getLabelAndValue = function(index) {
	  	return getLabelAndValue.call(this, index);
	}
}

//產出傷口組織比例趨勢圖
function renderWoundProp(className, mainTitle, subTitle, arrData){
	var unit = mainTitle + subTitle + " <@spring.message "chart.label.chartName"/>";
	var maxNum = 100;
	var minNum = 0;
	var imgLogoList = arrData[10];
	var dateLeng = arrData[1].length;
	var timeRange = getTimeRange(arrData[1]);
	var startPoints = [];
	
	var config = {
		type: 'line',
		data: {			
			labels: arrData[1],
			datasets: [{
				label: "<@spring.message "chart.label.epithelium"/>",
				fill: true,
	    	  	backgroundColor: colors.pink.fill,
		      	pointBackgroundColor: colors.pink.stroke,
		     	borderColor: colors.pink.stroke,
		     	pointHighlightStroke: colors.pink.stroke,
		      	borderCapStyle: 'butt',
				data: arrData[6]
			},{
				label: "<@spring.message "chart.label.granular"/>",
				fill: true,
	    	  	backgroundColor: 'rgb(255, 140, 102, 0.8)',
		      	pointBackgroundColor: 'rgb(255, 140, 102)',
		      	borderColor: 'rgb(255, 140, 102)',
		      	pointHighlightStroke: 'rgb(255, 140, 102)',
		      	borderCapStyle: 'butt',
				data: arrData[7]
			}, {
				label: "<@spring.message "chart.label.slough"/>",
				fill: true,
	    	  	backgroundColor: colors.lightYellow.fill,
		      	pointBackgroundColor: colors.yellow.stroke,
		      	borderColor: colors.yellow.stroke,
		      	pointHighlightStroke: colors.yellow.stroke,
		      	borderCapStyle: 'butt',
				data: arrData[8]
			}, {
				label: "<@spring.message "chart.label.eschar"/>",
				fill: true,
				backgroundColor: 'rgb(191, 191, 191, 0.8)',
		      	pointBackgroundColor: 'rgb(191, 191, 191)',
		      	borderColor: 'rgb(191, 191, 191)',
		      	pointHighlightStroke: 'rgb(191, 191, 191)',
		      	borderCapStyle: 'butt',
				data: arrData[9]
			}],			
		},
		options: {
			animation: false,
			spanGaps: true,	//防止數據為0或null斷點情形
			layout:{
				padding:{
					right: 18
				}
			},
			interaction: {
	            mode: 'index',
	            axis: 'y'
	        },
			plugins:{
				responsive: true,
				legend: {
					position: 'bottom',
				},
				title: {
					display: true,
					font:{
						size: 18
					},
					text: unit
				},
				tooltip: {
		            callbacks: {
		                label: function(context) {
		                    var label = context.dataset.label || '';
		                    var value = "", proportion = "", propSign = "";
		                    if (context.parsed.y !== null) {
		                    	value = context.parsed.y;
		                    	proportion = value / arrData[5][context.dataIndex] * 100;
		                    	propSign = arrData[5][context.dataIndex] == 0 ? "--" :　proportion.toFixed(1);
		                    	label += " <@spring.message "chart.label.occupy"/> " +  propSign + " <@spring.message "chart.label.percent"/> (<@spring.message "chart.label.area"/> " + value.toFixed(1) + " <@spring.message "chart.label.cm2"/>)";
		                    }	
		                    return label;
		                },
		                title: function (item) {
							return "<@spring.message "chart.label.evalDate"/>" + item[0].label + " (<@spring.message "chart.label.totalArea"/> " + arrData[5][item[0].dataIndex] + " <@spring.message "chart.label.cm2"/>)";
						}
		            }
		        }				
	        },
	        elements: {
		      line: {
		        fill: false,
		        tension: 0.4
		      }
		    },	        
			scales: {				
				x: {
					type: 'time',
					time:{
						tooltipFormat: 'yyyy-MM-dd',
						displayFormats:{
							day: 'yyyy-MM-dd'
						},
						minUnit: 'day'
											 
					},
					ticks:{
						source: 'data',
						font:{
							size: 16
						}
					},
					grid:{
						display: true
					},
					min: timeRange[0],
					max: timeRange[1],
					offset: true
				},
				y: {
					beginAtZero: true,
					offset: true,
					stacked: true,
					max: 250,
					ticks:{
						padding: 10
					},
					title:{
						display: true,
						text: '<@spring.message "chart.label.tag.cm2"/>'
					}	
				}
			}
		},
		plugins: [{
		    id: 'clickImg',
		    beforeDatasetsDraw(chart, args, options){      
		      	var {ctx, canvas, chartArea: {left, right, top, bottom, width, height} } = chart;
				for(var i=0; i<imgLogoList.length; i++){
					if(imgLogoList[i] != ""){
						var imgLogo = new Image();
						imgLogo.src = imgLogoList[i];
						if(imgLogo.complete){
							ctx.drawImage(imgLogo, chart.getDatasetMeta(0).data[i].x - (90/2), 40, 100, 100);
							startPoints.push(chart.getDatasetMeta(0).data[i].x - (90/2));
						}else{
							imgLogo.onload = () => chart.draw();
						}
					}

				}  
		    }
	  	},{
	  		id: 'moveChart',
	  		afterEvent(chart, args){
	  			var {ctx, canvas, chartArea: {left, right, top, bottom, width, height} } = chart;
	  			
	  			canvas.addEventListener('mousemove', (event) =>{
	  				var x = args.event.x;
	  				var y = args.event.y;

	  				if(x >= left - 15 && x <= left + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){
	  					canvas.style.cursor = 'pointer';
	  				}else if(x >= right - 15 && x <= right + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){
	  					canvas.style.cursor = 'pointer';
	  				}else{
	  					canvas.style.cursor = 'default';
	  				}

	  			})
	  		},
	  		afterDraw(chart, args, pluginOptions){
	  			var {ctx, chartArea: {left, right, top, bottom, width, height} } = chart;
	  			
	  			class CircleChevon{
	  				draw(ctx, x1, pixel){
	  					var angle = Math.PI / 180;
			  			ctx.beginPath();
			  			ctx.lineWidth = 3;
			  			ctx.strokeStyle = 'rgba(102,102,102,0.5)';
			  			ctx.fillStyle = 'white';
			  			ctx.arc(x1, height / 2 + top, 15, angle * 0, angle * 360, false);
			  			ctx.stroke();
			  			ctx.fill();
			  			ctx.closePath();
			  			
			  			// chevron Arrow Left
			  			ctx.beginPath();
			  			ctx.lineWidth = 3;
			  			ctx.strokeStyle = 'rgba(255,26,104,1)';
			  			ctx.moveTo(x1 + pixel, height / 2 + top - 7.5);
			  			ctx.lineTo(x1 - pixel, height / 2 + top);
			  			ctx.lineTo(x1 + pixel, height / 2 + top + 7.5);
			  			ctx.stroke();
			  			ctx.closePath();
	  				}
	  			}
	  			
	  			let drawCircleLeft = new CircleChevon();
	  			drawCircleLeft.draw(ctx, left, 5);
	  			
	  			let drawCircleRight = new CircleChevon();
	  			drawCircleLeft.draw(ctx, right, -5);
 			
	  		}
	  	},{
	  		id: "clickChart",
	  		afterEvent(chart, args){
	  			var {ctx, canvas, chartArea: {left, right, top, bottom, width, height} } = chart;
	  			
	  			var event = args.event;
		      	if (event.type === 'click') {
		      		var updated = false;
			        var x = args.event.x;
	  				var y = args.event.y;
					var totalDataLeng = arrData[1].length;
					var minIdx = arrData[1].indexOf(chart.options.scales.x.min);
					var maxIdx = arrData[1].indexOf(chart.options.scales.x.max);
					
	  				if(x >= left - 15 && x <= left + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){
	  					if(minIdx - 4 <= 0){
	  						chart.options.scales.x.min = arrData[1][0];
	  					}
	  					else{
	  						chart.options.scales.x.min = arrData[1][minIdx - 4];
	  					}
	  					chart.options.scales.x.max = arrData[1][minIdx - 1];
	  					updated = true;
	  				}
	  				else if(x >= right - 15 && x <= right + 15 && y >= height / 2 + top - 15 && y <= height / 2 + top + 15){  					  					
	  					if(totalDataLeng - 1 > maxIdx){
	  						chart.options.scales.x.min = arrData[1][maxIdx+1];
	  						if(arrData[1].length-1 > maxIdx + 4){
	  							chart.options.scales.x.max = arrData[1][maxIdx + 4];
	  						}
	  						else{
	  							chart.options.scales.x.max = arrData[1][totalDataLeng-1];
	  						}
	  						updated = true;
	  					}  					
	  				}
	  				
  					if(updated) chart.update();
		      	}	  			
	  		}
	  	}]
	};
	
	newChart = new Chart(document.getElementById(className), config);
	var ctx = document.getElementById(className);
	
	function clickableScales(canvas, click){

		var height = newChart.scales.x.height;
		var top = newChart.scales.x.top;
		var bottom = newChart.scales.x.bottom;
		var left = newChart.scales.x.left;
		var right = newChart.scales.x.maxWidth / newChart.scales.x.ticks.length;
		var resetCoordinates = canvas.getBoundingClientRect();
		
		var maxDate = timestampToDate(newChart.scales.x.max);
		var maxIdx = arrData[1].indexOf(maxDate);
		var page = parseInt(maxIdx/4);

		var x = click.clientX - resetCoordinates.left;
		var y = click.clientY - resetCoordinates.top;

		var colorArray = [], weightArray = [];
		var changed = false;
		var formNo = "";
		
		if(startPoints.length > 0){
			for(var j=0; j<startPoints.length; j++){
				if(x >= startPoints[j] && x <= startPoints[j] + 100	&& y >= 40 && y<= 140){
					showGallery(arrData[0][j], arrData[1][j]);
					$(".date-list").find(".date-btn[data-formno='" + arrData[0][j] + "']").trigger('click');
				}
			}
		}

		for(var i=0; i<newChart.scales.x.ticks.length; i++){
			var color = "#666";
			var weight = "500";
			if(x >= left + (right * i) && x <= right + (right * i) && y >= top && y<= bottom){
				formNo = arrData[0][i + (page*4)];
				color = "#b37700";
				weight = "600";
				changed = true;			
			}
			colorArray.push(color);
			weightArray.push(weight);
			
		}
		newChart.config.options.scales.x.ticks.color = colorArray;
		newChart.config.options.scales.x.ticks.font.weight = weightArray;
		if(changed){
			newChart.update();
			$(".date-btn[data-formNo='" + formNo + "']").trigger('click');
		}
	}
	
	ctx.addEventListener('click', (e) =>{
		clickableScales(ctx, e);
	});
	
}

//取得超音波趨勢圖資訊
function getUltraSoundLineChart(app){

}

//取得心電圖趨勢圖資訊
function getEcgLineChart(app){

}

//取得肺量趨勢圖資訊
function getLfmLineChart(app){

}

//取得耳鏡趨勢圖資訊
function getOtoLineChart(app){

}

//取得聽力檢測趨勢圖資訊
function getAudioMetersLineChart(app){

}


</script>