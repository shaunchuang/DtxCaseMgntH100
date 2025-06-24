<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "sectionIndex.label.title"/></div>
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
				      	<canvas id="caseStatusChart" width="300" height="200"></canvas>
				      	<p class="update-time"></p>
				      	<p class="total"></p>
				    </div>
				    <div class="col-md-6 chart-blk">
				      	<canvas id="monthlyCaseChart" width="300" height="200"></canvas>
				      	<p class="update-time"></p>
				      	<p class="total"></p>
				    </div>
				    <div class="col-md-6 chart-blk">
				      	<canvas id="medicalTestChart" width="300" height="200"></canvas>
				      	<p class="update-time"></p>
				      	<p class="total"></p>
				    </div>
			  	</div>			  	
			</div>
		</div>
	</div>
</body>

<script>

var mainTitle = ['<@spring.message "sectionIndex.label.service.cases"/>','<@spring.message "sectionIndex.label.visit.times"/>','<@spring.message "sectionIndex.label.test.analysis"/>'];
var testKitName = ["<@spring.message "sectionIndex.label.all"/>","<@spring.message "sectionIndex.label.ophthalmoscope"/>","<@spring.message "sectionIndex.label.wound"/>","<@spring.message "sectionIndex.label.ultrasound"/>","<@spring.message "sectionIndex.label.ecg"/>","<@spring.message "sectionIndex.label.spirometer"/>","<@spring.message "sectionIndex.label.otoscope"/>","<@spring.message "sectionIndex.label.hearingDetector"/>","<@spring.message "sectionIndex.label.abi"/>"];

$(document).ready(function(){
	var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/outputSectionIndexReport");
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
        zip.file(downloadDate + "_<@spring.message "sectionIndex.label.title"/>_" + canvasName + '圖表.png', canvas.toDataURL("image/png").split('base64,')[1], { base64: true });
    });

    // 產生 zip 檔案
    zip.generateAsync({ type: "blob" })
        .then(function (content) {
            // 使用 FileSaver.js 或類似的庫下載 zip 檔案
            saveAs(content, "charts下載測試.zip");
        });
}

function getChartInfo(result){
	getCaseStatusInfo(result.statusInfos, result.statusTotalNum);
	getMonthlyCaseInfo(result.monthlyCaseInfos, result.monthlyCaseTotalNum);
	getMedicalTestInfo(result.medicalTestInfos, result.medicalTestTotalNum);
	
	$(".update-time").html(result.reportDate);
}

//依照個案狀態取得個案量數據
function getCaseStatusInfo(result, totalNum){
	var status = [];
	var num = [];
	for(var i=0; i<result.length; i++){
		status.push(result[i].labelName);
		num.push(result[i].num);
	}
	
	showTotalTxt("caseStatusChart", totalNum);
	renderChart("caseStatusChart", mainTitle[0], num, status, "<@spring.message "sectionIndex.label.caseNum"/>", "<@spring.message "sectionIndex.label.patient.unit"/>");
}

function renderChart(className, title, arrData, labelData, labelName, unit){
	
	var config = {
		type: 'bar',
		data: {			
			labels: labelData,			
			datasets: [{
				label: labelName,
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
		                    	label += context.parsed.x + " " + unit;
		                    }	
		                    return label;
		                }
		            }
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

//依照每月份取得個案訪視人次數據
function getMonthlyCaseInfo(result, totalNum){
	var monthlyCase = [];
	var num = [];
	for(var i=0; i<result.length; i++){
		monthlyCase.push(result[i].labelName);
		num.push(result[i].num);
	}
	
	showTotalTxt("monthlyCaseChart", totalNum);
	renderChart("monthlyCaseChart", mainTitle[1], num, monthlyCase, "<@spring.message "sectionIndex.label.case"/>", "<@spring.message "sectionIndex.label.case.unit"/>");
}

//依照取得個案檢測設備數據
function getMedicalTestInfo(result, totalNum){
	var test = [];
	var num = [];
	for(var i=0; i<result.length; i++){
		var kitName = testKitName[result[i].labelName];
		test.push(kitName);
		num.push(result[i].num);
	}
	
	showTotalTxt("medicalTestChart", totalNum);
	renderChart("medicalTestChart", mainTitle[2], num, test, "<@spring.message "sectionIndex.label.usetimes"/>", "<@spring.message "sectionIndex.label.times.unit"/>");
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