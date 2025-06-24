<#import "/util/spring.ftl" as spring />
<div id="data-content">	
	<div class="card evaluationDetails">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0">關鍵量表趨勢概覽</h5>
        </div>
        <div class="card-body">
            <div class="row mg-0 chart-blks">
            	<div class="col-md-6 pd-h-0 chart-blk">
                    <canvas class="chart" data-name="ADHD量表數據" data-scaleId="1" width="300" height="200"></canvas>
                    <p class="update-time"></p>
                </div>
                <div class="col-md-6 pd-h-0 chart-blk">
                    <canvas class="chart" data-name="巴氏量表數據" data-scaleId="2" width="300" height="200"></canvas>
                    <p class="update-time"></p>
                </div>
                <div class="col-md-6 pd-h-0 chart-blk">
                    <canvas class="chart" data-name="IADL Scale數據" data-scaleId="3" width="300" height="200"></canvas>
                    <p class="update-time"></p>
                </div>
                 <div class="col-md-6 pd-h-0 chart-blk">
                    <canvas class="chart" data-name="日常生活活動能力" data-scaleId="4" width="300" height="200"></canvas>
                    <p class="update-time"></p>
                </div>           	
            </div>
        </div>
    </div>

	<script>
	
	var allChartData = [
        {
            title: "ADHD量表",
            scaleId: 1,
            data: [
                { evalDate: "2025-06-22", score: 65 },
                { evalDate: "2025-06-23", score: 68 },
                { evalDate: "2025-06-24", score: 62 }
            ]
        },
        {
            title: "巴氏量表",
            scaleId: 2,
            data: [
                { evalDate: "2025-06-22", score: 85 },
                { evalDate: "2025-06-23", score: 87 },
                { evalDate: "2025-06-24", score: 86 }
            ]
        },
        {
            title: "IADL Scale",
            scaleId: 3,
            data: [
                { evalDate: "2025-06-22", score: 70 },
                { evalDate: "2025-06-23", score: 73 },
                { evalDate: "2025-06-24", score: 71 }
            ]
        },
        {
            title: "日常生活活動能力",
            scaleId: 4,
            data: [
                { evalDate: "2025-06-22", score: 90 },
                { evalDate: "2025-06-23", score: 92 },
                { evalDate: "2025-06-24", score: 91 }
            ]
        }
    ];
	
	$(document).ready(function(){
		adjustHeight();
		renderCharts(allChartData);
	});
	
	function renderCharts(rowdata) {
        rowdata.forEach(chartConfig => {
            var chartName = chartConfig.title;
            var chartScaleId = chartConfig.scaleId; // 從配置中取得 scaleId
            var rawData = chartConfig.data;

            // 將原始數據轉換為 Chart.js 的標籤和數據值
            var labels = rawData.map(item => {
                const d = new Date(item.evalDate);
                return (d.getMonth() + 1).toString() + '/' + d.getDate().toString(); // 格式化為 MM/DD 作為 Chart.js 標籤
            });
            var dataScores = rawData.map(item => item.score);

            // 取得最新更新時間 (從最後一筆數據點取得)
            var latestDataPoint = rawData[rawData.length - 1];
            // 使用 evalDate 字串直接解析為 Date 物件
            var latestDate = new Date(latestDataPoint.evalDate); 
            var latestUpdateTime = (latestDate.getMonth() + 1).toString().padStart(2, '0') + '/' + latestDate.getDate().toString().padStart(2, '0') + ' ' + new Date().toLocaleTimeString('zh-TW', { hour: '2-digit', minute: '2-digit' });

            // 根據 data-scaleId 屬性找到對應的 canvas 元素
            var canvas = document.querySelector('canvas.chart[data-scaleId="' + chartScaleId + '"]'); // 已修改

            if (canvas) {
                // 找到相關聯的 update-time 段落
                var updateTimeParagraph = canvas.nextElementSibling;
                if (updateTimeParagraph && updateTimeParagraph.classList.contains('update-time')) {
                    updateTimeParagraph.textContent = latestUpdateTime;
                }

                // 如果已存在圖表實例，則銷毀它 (這對重新渲染或調整大小很重要)
                if (canvas.chart) {
                    canvas.chart.destroy();
                }

                // 創建新的 Chart.js 實例並將其儲存在 canvas 元素上
                canvas.chart = new Chart(canvas, {
                    type: 'line', // 趨勢圖使用折線圖
                    data: {
                        labels: labels,
                        datasets: [{
                            label: chartName + ' (分數)', // 圖表標題包含數據名稱
                            data: dataScores,
                            borderColor: 'rgba(75, 192, 192, 1)',
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            tension: 0.3, // 平滑曲線
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false, // 允許 Chart.js 根據父容器管理長寬比
                        plugins: {
                            title: {
                                display: true,
                                text: chartName, // 圖表主標題
                                font: {
                                    size: 16
                                }
                            },
                            legend: {
                                display: false // 如果標題清楚，則無需圖例
                            }
                        },
                        scales: {
                            x: {
                                title: {
                                    display: true,
                                    text: '日期'
                                },
                                ticks: {
                                    maxRotation: 45,
                                    minRotation: 45,
                                    autoSkip: true, // 如果標籤過多，自動跳過
                                    maxTicksLimit: 10 // 限制可見刻度數
                                }
                            }
                            ,
                            y: {
                                title: {
                                    display: true,
                                    text: '分數'
                                },
                                beginAtZero: true, // Y 軸從零開始
                                max: 100 // Y 軸最大分數
                            }
                        }
                    }
                });
            }
        });
    }
	
	</script>
	
	<style>
	
	.card:not(:first-child) {
        margin-top: 10px;
    }
    
    .card .card-header{
    	border-top-left-radius: 0.5rem;
    	border-top-right-radius: 0.5rem;
    	padding: 0 10px;
    }
    
    .card-body{
    	padding: 10px;
    }
    
    hr{
    	margin: 10px 0 !important;
    }
    
    .method-list-group{
    	list-style-type: none;
    	padding-left: 20px;
    }
    
    .method-list-group li:before,
    .card-body h5:before {
    	font-family: 'FontAwesome';
		margin-right: 10px;		
    }
    
    .method-list-group li:before{
    	color: #198754;
		content: "\f058";
    }
    
    .card-body h5:before{
    	content:"\f0c8";
    }
    
    .card-body table{
    	font-size: 1.5rem;
    }
    
    .card-body table thead{
    	border-bottom: 1px solid #cccccc;
    }
    
    .chart-blk{
    	width: 50% !important;
    }
    
    .chart-blk p.update-time{
    	font-size: 1rem;
    }
    
    .chart-blk p:before{
		margin-right: 5px;
	}
    
	</style>
</div>
