<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "caseIndex.label.title"/></div>
				</div>
				<div class="col-md-6 sub-func">
					<button class="func-btn mg-left-5" role="button" onclick="downloadChart()"><@spring.message "report.button.download.chart" /></button>
					<button class="func-btn mg-left-5" role="button" onclick="downloadData()"><@spring.message "report.button.download.data" /></button>
				</div>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
	            <div class="chart-blks">
				    <div class="col-md-6 chart-blk">
				      	<canvas id="closeCatChart" width="300" height="200"></canvas>
				      	<p class="update-time"></p>
				      	<p class="total"></p>
				    </div>
				    <div class="col-md-6 chart-blk">
				      	<canvas id="abnormalCatChart" width="300" height="200"></canvas>
				      	<p class="update-time"></p>
				      	<p class="total"></p>
				    </div>
			  	</div>			  	
			</div>
		</div>
	</div>
</body>

<script>

var mainTitle = ['<@spring.message "caseIndex.label.caseclose.analysis"/>', '<@spring.message "caseIndex.label.abnormal.result.analysis"/>'];

$(document).ready(function(){
	var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/outputCaseIndexReport");
	getChartInfo(result);
});

function downloadChart() {
    // 創建一個 JSZip 實例
    var zip = new JSZip();

    $(".chart").each(function (idx) {
        var canvas = this;
        var canvasId = canvas.id;
        var canvasName = mainTitle[idx];
        var downloadDate = imgFormateDate(true);

        // 將圖表資料加入 zip 檔案
        zip.file(downloadDate + "_<@spring.message "caseIndex.label.title"/>_" + canvasName + '圖表.png', canvas.toDataURL("image/png").split('base64,')[1], { base64: true });
    });

    // 產生 zip 檔案
    zip.generateAsync({ type: "blob" })
        .then(function (content) {
            // 使用 FileSaver.js 或類似的庫下載 zip 檔案
            saveAs(content, "charts下載測試.zip");
        });
}

function getChartInfo(result){
	getCloseCatInfo(result.closeCatInfos, result.closeCatTotalNum);
	getAbnormalCatInfo(result.abnormalResultInfos, result.abnormalResultTotalNum);
	
	$(".update-time").html(result.reportDate);
}

//依照結案狀態取得個案數數據
function getCloseCatInfo(result, totalNum){
	var closeCat = [];
	var num = [];
	
	if(result.length > 0){
		for(var i=0; i<result.length; i++){
			closeCat.push(result[i].labelName);
			num.push(result[i].num);
		}
	}	
	
	showTotalTxt("closeCatChart", totalNum);
	renderChart("closeCatChart", mainTitle[0], num, closeCat);
}

//依照異常狀況取得對應累積次數
function getAbnormalCatInfo(result, totalNum){
	var abnormalCat = [];
	var num = [];
	
	if(result.length > 0){
		for(var i=0; i<result.length; i++){
			abnormalCat.push(result[i].labelName);
			num.push(result[i].num);
		}
	}	
	
	showTotalTxt("abnormalCatChart", totalNum);
	renderChart("abnormalCatChart", mainTitle[1], num, abnormalCat);
}

function renderChart(className, title, arrData, labelData){
	
	var config = {
		type: 'bar',
		data: {			
			labels: labelData,			
			datasets: [{
				label: "<@spring.message "caseIndex.label.caseNum"/>",
				backgroundColor:(context) =>{
					if(context.element != undefined){
	            		var {ctx} = context.chart;
	            		var {x, width} = context.element;
	            		var grd = ctx.createLinearGradient(50, 0, 250, 0);
						//grd.addColorStop(1, 'rgb(139, 168, 218)');
						//grd.addColorStop(0.7, 'rgb(119, 153, 212)');
						grd.addColorStop(0.7, 'rgb(100, 139, 206)');
						//grd.addColorStop(0.3, 'rgb(81, 124, 200)');
						grd.addColorStop(0, colors.customBlue.stroke);
						return grd;
					}
				},
				data: arrData,
				borderWidth: 1,
				categoryPercentage: 1.0,
				barPercentage: 0.5
			}],			
		},
		options: {
			indexAxis: 'y',
			animation:{
				y: false
			},
			spanGaps: true,	//防止數據為0或null斷點情形
			layout:{
				padding:{
					right: 18
				}
			},			
			plugins:{
				responsive: true,
				legend: {
					position: 'bottom',
					labels:{
						font:{
							size: 16
						}
					}
				},
				title: {
					display: true,
					font:{
						size: 22
					},
					color: '#b37400',
					text: title
				},
				tooltip: {
		            callbacks: {
		                label: function(context) {
		                    var label = context.dataset.label || '';
	
		                    if (label) {
		                        label += ': ';
		                    }
		                    
		                    if (context.parsed.x !== null) {
		                    	label += context.parsed.x + " <@spring.message "caseIndex.label.patient.unit"/>";
		                    }	
		                    return label;
		                }
		            }
		        },
		        customText: {
			        text: [{
			            text: 'Lorem ipsum',
			            x: 0,
			            y: 0,
			            textAlign: 'center',
			            size: '30px',
			            color: 'black',
			            font: 'Arial black'
			          }
			        ]
		      	}       				
	        },	        
			scales: {
				x: {
					ticks: {
			            stepSize: 1,
			            font:{
			            	size: 14
			            },
			            color: '#000'
		         	}
				},				
				y: {
					beginAtZero: true,
					ticks: {
			            font:{
			            	size: 14			            	
			            },
			            color: '#000'
		         	}						
				}
			}
		}
	};
	
	var newChart = new Chart(document.getElementById(className), config);	
}

//顯示總數
function showTotalTxt(idName, totalNum){
	$("#" + idName).parent("div").find(".total").html(totalNum);
}

</script>

<style>


</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />