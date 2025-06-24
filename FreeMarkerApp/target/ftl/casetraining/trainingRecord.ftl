<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name">檢視紀錄</div>
				</div>          
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
	            <div class="default-blks">
	            	<div class="col-5">
	            	    <div class="default-blk plan-area">
		            		<div class="default-blks">
		            		    <div class="col-4">
		            		    	<div>
		            		    		<img class="trainingImg" src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1672970/header.jpg?t=1717003107">
		            		    	</div>
	                			</div>
	                			<div class="col-8 plan-detail">
	                				<div>
	                					<div class="sub-title training-title">Minecraft 訓練計畫 | <span>程靜雯治療師</span></div>
	                				</div>
	                				<div class="trainingPlan-period">訓練期間：2024/08/04~2024/08/06</div>
	                				<!--<div>追蹤指標1：完成時間00:30:00</div>
	                				<div>追蹤指標2：完成分數80分</div>-->
	                			</div>
	                		</div>
	                		<div class="default-blks" id="recordList">
	                		
	                			<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
	                				<thead>
	                					<tr>
	                						<th>編號</th>
	                						<th>訓練開始時間</th>
	                						<th>訓練結束時間</th>
	                						<th>訓練時長</th>
	                					<tr>
	                				</thead>
	                				<tbody>
	                					<tr>
	                						<td>01</td>
	                						<td>2024/08/04 下午05:06</td>
	                						<td  class="aim-fail">00:44:00</td>
	                						<td>80</td>
	                						<td>80</td>
	                						<td>80</td>
	                					</tr>
	                					<tr>
	                						<td>02</td>
	                						<td>2024/08/05 下午04:06</td>
	                						<td>00:32:00</td>
	                						<td>70</td>
	                						<td>80</td>
	                						<td>80</td>
	                					</tr>
	                					<tr>
	                						<td>03</td>
	                						<td>2024/08/06 下午03:06</td>
	                						<td>00:28:00</td>
	                						<td class="aim-fail">50</td>
	                						<td>60</td>
	                						<td>80</td>
	                					</tr>
	                					<tr>
	                						<td>04</td>
	                						<td>2024/08/06 下午03:35</td>
	                						<td>00:33:00</td>
	                						<td>75</td>
	                						<td>60</td>
	                						<td>70</td>
	                					</tr>
	                				</tbody>
	                			</table>
	                		</div>
	                	</div>
		                <div class="prev-Page">
		                	<button class="btn btn-primary prev-button" onclick="prevButton()"><i class="fa-solid fa-circle-arrow-left"></i>&nbsp;&nbsp;返回</button>
		                </div>
                	</div>
                	<div class="col-7">
                		<div class="default-blk recordTable">
                			<div class="default-blks">
                				<div class="col-6 achievementTable">
                				</div>
                				<div class="col-6 statsTable">
                				</div>
                			</div>
                		</div>
                		<div class="default-blk chart-div">
                			<div class="chart-area">
                				<canvas id="resultChart"></canvas>
                				    <!-- 新增 Trend Chart 區 -->
							    <div id="trendChartContainer" style="display: none;">
							        <select id="dataSelector">
							            <option value="charCount">總字數</option>
							            <option value="wordCount">總詞數</option>
							            <option value="ttr">相異詞比率</option>
							            <option value="nouns">名詞數量</option>
							            <option value="verbs">動詞數量</option>
							            <option value="adjectives">形容詞數量</option>
							            <option value="mluW">平均語句總詞數</option>
							            <option value="mluC">平均語句總字數</option>
							        </select>
							        <canvas id="trendChart"></canvas>
							    </div>
                			</div>
                		</div>  
                	</div>
	            </div>
	        </div>
		</div>
	</div>
</body>
<script>
let lessonStoreUrl = '${lessonStoreUrl}';
let planId = '${planId}'; // 訓練計畫Id

let trainingPlan = ${trainingPlan!""};
console.log('trainingPlan: ', trainingPlan);
let therapistId = trainingPlan.therapistId; // 治療師Id
let therapistName = trainingPlan.therapistName; // 治療師姓名

let lessonIdForStore = trainingPlan.lessons[0].lessonId; // 教案市集Id

        const data = {
            dates: ['2024-11-15', '2024-11-16', '2024-11-17', '2024-11-18'],
            charCount: [158, 445, 233, 183],
            wordCount: [87, 259, 133, 106],
            ttr: [0.741, 0.469, 0.647, 0.770],
            nouns: [44, 111, 62, 48],
            verbs: [28, 103, 49, 32],
            adjectives: [0, 1, 0, 0],
            mluW: [2.5, 4.45, 3.33, 2.94],
            mluC: [4.65, 7.67, 5.83, 5.38]
        };
    $(document).ready(function(){

		getTrainingRecord(function(trainingRecords){
			createChart(trainingRecords);
		});
		getTrainingPlan();
    });

    function getTrainingPlan(){
    	console.log('trainingPlan: ', trainingPlan);
    	if(trainingPlan) {
    		let planDetail = trainingPlan;
    		let lessonMain = '';
    		lessonIdForStore = planDetail.lessons[0].lessonId;
			$.ajax({
				url: lessonStoreUrl + '/LessonMainInfo/api/get/lessonId/' + lessonIdForStore,
				type: 'GET',
				dataType: 'json',
				async: false,
				success: function(response) {
					lessonMain = response;
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.error('Error with LessonMainInfo:', textStatus, errorThrown);
					console.error('Response Text:', jqXHR.responseText);
					swal('載入教案失敗','請聯絡管理員','error');
				}
			});
			console.log('lessonMain: ', lessonMain);
        	let imageUrl = lessonStoreUrl + '/File/api/file/path' + lessonMain.headerImageUrl   || "";
			let lessonName = lessonMain.lessonName;
        	let startDateStr = formatDate(planDetail.startDate);
        	let endDateStr = formatDate(planDetail.endDate);
        	
        	$('.trainingImg').attr('src', imageUrl);
        	let titleHtml = lessonName + ' 訓練計畫 | <span>' + therapistName + " 治療師</span>";
        	$('.training-title').html(titleHtml);
        	
        	$('.trainingPlan-period').text('訓練期間：' + startDateStr + ' ~ ' + endDateStr );
    	} else {
    		swal('載入訓練計畫失敗','請聯絡管理員','error');
    	}
    }
    
    /* 取得成就資料 */
	function getAchievement(callback) {
	    $.ajax({
	        url: lessonStoreUrl + '/LessonAchievement/api/lesson',
	        type: "POST",
	        data: JSON.stringify({"lessonId": lessonIdForStore}),
	        dataType: 'json',
	        success: function(response) {
	            console.log('Achievement:', response);
	            callback(response);
	        },
	            error: function(err) {
				console.log('Error:', err);
	        }
	    });
	}
	
	
	function getTrainingRecord(callback){
		console.log('lessonId For Store', lessonIdForStore);
		$.ajax({
            url: '/Training/api/listData',
            type: "POST",
            dataType: 'json',
            data: JSON.stringify({"planId": planId, "lessonId": lessonIdForStore}), // 訓練教案KeyNo
            success: function(response){
                console.log('Training Record:', response);
                getAchievement(function(achievement) {
	                renderTrainingRecord(response, achievement);
	                if (callback && typeof callback === 'function') {
                        callback(response.data);
                    }
            	});
            },
            error: function(err){
                console.log('Error:', err);
            }
        });
	}
	
	// 重新渲染訓練紀錄
	function renderTrainingRecord(res, achievements) {
		let response = res;
		console.log('renderTrainingRecord response:', response);
		response.data.sort(function (a, b) { return b.startTime - a.startTime; });

		const $tbody = $('#recordList tbody');
    	$tbody.empty();
		// ❷ 沒資料 → 印提示、隱藏詳細區與圖表
		if (response.data.length === 0) {
			$tbody.append(
				'<tr><td colspan="4" class="text-center text-muted">目前沒有訓練紀錄</td></tr>'
			);
			$('.recordTable').hide();   // 詳細區
			//$('.chart-div').hide();     // 圖表
			return;                     // 直接結束
		}
		let recordHtml = '';

		response.data.forEach(function (record, index) {
			let startTime = new Date(record.startTime).toLocaleString();
			let endTime   = new Date(record.endTime).toLocaleString();
			let period    = formatPeriod(record.period);

			recordHtml +=
				'<tr data-index="' + index + '">' +
					'<td>' + (index + 1) + '</td>' +
					'<td>' + startTime + '</td>' +
					'<td>' + endTime + '</td>' +
					'<td>' + period + '</td>' +
				'</tr>';
		});

		$('#recordList tbody').append(recordHtml);

		// 點擊顯示詳情
		$('#recordList tbody tr').on('click', function () {
			let idx = $(this).data('index');
			if (idx !== undefined) {
				showDetails(response.data[idx], achievements);
				$('.recordTable').show();
			} else {
				console.error('無法取得 index');
			}
		});
	}

	// 顯示詳細資料
	function showDetails(record, achievements) {
		if (!record) {
			console.error('record is undefined');
			return;
		}

		/* ---------- 成就區 ---------- */
		var achievementHtml =
			'<table class="table table-striped table-bordered bootstrap-datatable table-customed">' +
				'<thead>' +
					'<tr>' +
						'<th>#</th>' +
						'<th>成就名稱 / 描述</th>' +
						'<th>達成時間</th>' +
					'</tr>' +
				'</thead>' +
				'<tbody>';

		if (record.achievement && record.achievement.length > 0) {
			record.achievement.forEach(function (achieve, idx) {
				var detail = achievements.find(function (a) { return a.apiName === achieve.apiname; }) || {};
				var title  = detail.displayName  || achieve.apiname;
				var desc   = detail.description  || '';
				var imgUrl = detail.unlockedIconUrl || '';
				var unlockTime = achieve.unlocktime
					? new Date(achieve.unlocktime * 1000).toLocaleString()
					: 'N/A';

				achievementHtml +=
					'<tr>' +
						'<td class="indexNum">' + (idx + 1) + '</td>' +
						'<td>' +
							'<div class="achContent d-flex">' +
								'<div class="achImg me-2">' +
									(imgUrl ? '<img src="' + imgUrl + '" alt="' + title + '"/>' : '') +
								'</div>' +
								'<div class="achAns">' +
									'<div class="achTitle fw-bold">' + title + '</div>' +
									'<div class="achDescript text-muted">' + desc + '</div>' +
								'</div>' +
							'</div>' +
						'</td>' +
						'<td>' + unlockTime + '</td>' +
					'</tr>';
			});
		} else {
			achievementHtml +=
				'<tr><td colspan="3" class="text-center">無成就資料</td></tr>';
		}

		achievementHtml += '</tbody></table>';

		/* ---------- 統計數據區 ---------- */
		var statsHtml =
			'<table class="table table-striped table-bordered bootstrap-datatable table-customed">' +
				'<thead>' +
					'<tr>' +
						'<th>#</th>' +
						'<th>統計名稱</th>' +
						'<th>統計值</th>' +
					'</tr>' +
				'</thead>' +
				'<tbody>';

		if (record.statsData && record.statsData.length > 0) {
			record.statsData.forEach(function (stat, idx) {
				statsHtml +=
					'<tr>' +
						'<td class="indexNum">' + (idx + 1) + '</td>' +
						'<td>' + (stat.apiName || '未定義') + '</td>' +
						'<td>' + (stat.statsValue != null ? stat.statsValue : 'N/A') + '</td>' +
					'</tr>';
			});
		} else {
			statsHtml +=
				'<tr><td colspan="3" class="text-center">無統計數據</td></tr>';
		}

		statsHtml += '</tbody></table>';

		/* ---------- 注入畫面 ---------- */
		$('.achievementTable').html(
			'<div class="subTitle">成就資訊</div>' + achievementHtml
		);

		$('.statsTable').html(
			'<div class="subTitle">統計數據</div>' + statsHtml
		);
	}

    function createChart(trainingRecords) {
    	console.log('chart record:', trainingRecords);
    	// 確保訓練記錄按 startTime 升序排序
        trainingRecords.sort((a, b) => a.startTime - b.startTime);

        // 準備圖表的標籤和資料
        const labels = [];
        const singleTrainingTimes = []; // 單次訓練時長（分鐘）
        const cumulativeTrainingTimes = []; // 累積訓練時長（分鐘）

        let cumulativeTime = 0; // 初始化累積時間

        trainingRecords.forEach(record => {
            console.log('處理紀錄: ', record);
            // 訓練日期（只顯示日期部分）
            const date = new Date(record.startTime).toLocaleDateString();
            labels.push(date);

            // 單次訓練時間（轉換為分鐘數，period 為毫秒）
            const periodMinutes = record.period / (1000 * 60); // 將毫秒轉換為分鐘
            singleTrainingTimes.push(parseFloat(periodMinutes.toFixed(2))); // 保留兩位小數並轉為數字

            // 累積訓練時間
            cumulativeTime += periodMinutes;
            cumulativeTrainingTimes.push(parseFloat(cumulativeTime.toFixed(2))); // 保留兩位小數並轉為數字
        });

        // 檢查是否有資料
        if (labels.length === 0) {
            $('#resultChart')
            .parent()                      // 取 canvas 容器
            .html('<p class="text-center text-muted">無訓練紀錄，暫無圖表</p>');
        	return;
    	}

        // 取得 canvas 元素的上下文
        const ctx = document.getElementById('resultChart').getContext('2d');

        // 創建圖表
        const resultChart = new Chart(ctx, {
            type: 'bar', // 設定主要圖表類型為柱狀圖
            data: {
                labels: labels, // 設置 x 軸標籤（訓練日期）
                datasets: [
                    {
                        type: 'bar', // 明確設置為柱狀圖
                        label: '單次訓練時間 (分鐘)',
                        data: singleTrainingTimes, // 單次訓練時長資料
                        backgroundColor: 'rgba(255, 99, 132, 0.2)', // 長條圖顏色
                        borderColor: 'rgba(255, 99, 132, 1)', // 邊框顏色
                        borderWidth: 1,
                        yAxisID: 'y'
                    },
                    {
                        type: 'line', // 明確設置為折線圖
                        label: '累積訓練時間 (分鐘)',
                        data: cumulativeTrainingTimes, // 累積訓練時長資料
                        backgroundColor: 'rgba(75, 192, 192, 0.2)', // 折線圖顏色
                        borderColor: 'rgba(75, 192, 192, 1)', // 邊框顏色
                        borderWidth: 2,
                        fill: false, // 不填充下方區域
                        tension: 0.4,
                        yAxisID: 'y'
                    }
                ]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true, // y 軸從 0 開始
                        title: {
                            display: true,
                            text: '訓練時間 (分鐘)' // 更新標題為分鐘
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: '訓練日期' // x 軸標題
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true, // 顯示圖例
                        position: 'top'
                    }
                }
            }
        });
    }
	
    // 返回總覽
    function prevButton(){
    	window.location.href = "/ftl/casetraining/caseDashboard";
    }
	
	// 格式化 period 為 HH:mm:ss
	function formatPeriod(milliseconds){
	    let totalSeconds = Math.floor(milliseconds / 1000);
	    let hours = Math.floor(totalSeconds / 3600);
	    let minutes = Math.floor((totalSeconds % 3600) / 60);
	    let seconds = totalSeconds % 60;
	
	    return (
	        String(hours).padStart(2, '0') + ':' +
	        String(minutes).padStart(2, '0') + ':' +
	        String(seconds).padStart(2, '0')
	    );
	}
	
	function createJsonChart() {
            const ctx = document.getElementById('trendChart').getContext('2d');
            const chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: data.dates,
                    datasets: [{
                        label: '總字數',
                        data: data.charCount,
                        borderColor: 'rgba(75, 192, 192, 1)',
                        tension: 0.1,
                        fill: false
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
                        }
                    },
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: '日期'
                            }
                        },
                        y: {
                            title: {
                                display: true,
                                text: '數值'
                            }
                        }
                    }
                }
            });

            document.getElementById('dataSelector').addEventListener('change', (event) => {
                const selectedData = event.target.value;
                chart.data.datasets[0].label = 
                    selectedData === 'charCount' ? '總字數' :
                    selectedData === 'wordCount' ? '總詞數' :
                    selectedData === 'ttr' ? '相異詞比率' :
                    selectedData === 'nouns' ? '名詞數量' :
                    selectedData === 'verbs' ? '動詞數量' :
                    selectedData === 'adjectives' ? '形容詞數量' :
                    selectedData === 'mluW' ? '平均語句總詞數' : '平均語句總字數';

                chart.data.datasets[0].data = data[selectedData];
                chart.update();
            });
        }
        
        function formatDate(input){
        	const date = new Date(input);
		
			// 使用 toLocaleDateString 格式化
			const formattedDate = date.toLocaleDateString('zh-TW', {
			  year: 'numeric',
			  month: '2-digit',
			  day: '2-digit',
			}).replace(/\//g, '/'); // 確保分隔符為 "/"
			
			console.log(formattedDate);
			return formattedDate;
        }
	

</script>
<style>
	.plan-area{
		height: 90%;
		min-height: 450px;
	}
	
	.trainingImg{
		width: 100%;
		border-radius: 10px;
	}
	
	.training-title{
        font-weight: 700;
        font-size: 1.8rem;
    }
    
    .training-title span{
        font-weight: 400;
    }
    
    .plan-detail{
        padding-left: 1rem;
        font-size: 1.5rem;
    }
    
    .aim-success{
    	font-weight: 500;
    	color: #03781D;
    }
    
    .aim-fail{
    	font-weight: 500;
    	color: #FF0000;
    }
    
    .prev-Page{
    	margin-top: 1.5rem;
    }
    
    .prev-button{
    	padding: 0.8rem 2.5rem;
    	background-color: #FFFFFF;
    	color: #9E9E9E;
    	border-color: #9E9E9E;
    	font-weight: 900;
    }
    
    .prev-button:hover{
    	background-color: #9E9E9E;
    	color: #FFFFFF;
    	border-color: #9E9E9E;
    }
    
    .prev-button:selection{
    	background-color: #9E9E9E;
    	color: #FFFFFF;
    	border-color: #9E9E9E;
    }
    
    .main-table th{
    	font-size: 1.5rem;
    }
    
    .main-table tbody tr:hover{
    	background-color: #d5d9ec;
    	cursor: pointer;
    }
    
    .recordTable{
    	display: none;
    }
    
    .subTitle{
    	font-size: 2rem;
    	font-weight: 700;
    }
    
    .indexNum{
    	text-align: center;
    }
    
    .achContent{
    	display: flex;
    }
    
    .achAns{
    	padding-left: 1rem;
    }
    
    .achTitle{
    	font-size: 1.5rem;
    	font-weight: 700;
    }
    
    .achImg{
    	display: flex;
    	justify-content: center;
    	flex-direction: column;
    	align-items: center;
        width: 100%;
        height: 100%;
    }
    
    /* 圖表區塊 */
    .chart-div{
        display: flex;
    	justify-content: center;
    	margin-top: 1rem;
    }
    
    .chart-area{
    	width: 80%;
    	height: 30rem;
    }
    
</style>
</html>

