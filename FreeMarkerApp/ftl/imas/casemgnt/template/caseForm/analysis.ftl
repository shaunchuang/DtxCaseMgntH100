<#import "/util/spring.ftl" as spring />
  
<div id="data-content">
	<#if message?exists >
		<#if message == "emptyMessage">
		<div class="info-message">
			<!--<i class="fa fa-eye-slash"></i>-->
			<span>點擊左側訓練計畫圖卡，以檢視詳細內容與分析</span>
		</div>
		</#if>
	<#else>	
	<div class="card trainingPlanDetails">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h5 class="detailPlanTitle">訓練計畫內容</h5>
        </div>
        <div class="card-body">
            <p><strong>使用期間：</strong> <span class="detailUsePeriod">2024/05/26~2024/06/15</span></p>
            <p><strong>負責人員：</strong> <span class="detailTherapist">程靜雯 治療師</span></p>
            <hr>
            <h5>訓練時間安排</h5>
            <p class="detailParameters">每週 2 次，每次 50 分鐘，計 10 次。</p>
            <h5>訓練項目與參數設定</h5>
            <ul class="method-list-group">
                <li>感統活動 (觸覺箱、平衡木) 15 分鐘</li>
                <li>專注力桌面遊戲 (找不同、拼圖) 20 分鐘</li>
                <li>聽從指令訓練 (三步驟指令) 10 分鐘</li>
            </ul>           
            <h5>相關備註</h5>
            <p class="detailNotes">個案對獎勵系統反應良好，但情緒波動時專注力易受影響。</p>
        </div>
    </div>
    <div class="card trainingPlanChart">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0">訓練進度與趨勢圖</h5>
        </div>
        <div class="card-body">
            <div class="chart-placeholder">
                <canvas id="resultChart" width="400" height="200"></canvas>
            </div>
            <p class="text-muted text-center"><small>此處將動態載入與訓練計畫相關的成果圖表。</small></p>
        </div>
    </div>
    <div class="card trainingPlanRawData" >
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0">原始數據</h5>
        </div>
        <div class="card-body">
            <table class="table table-striped table-bordered bootstrap-datatable table-customed">
                <thead>
                    <tr>
                        <th>序號</th>
                        <th>訓練開始時間</th>
                        <th>訓練結束時間</th>
                        <th>總計時長</th>
                    </tr>
                </thead>
                <tbody class="rowdata-body">
                    <!-- Dynamic content here -->
                </tbody>
            </table>
            <p class="text-muted text-center"><small>此處將動態載入與圖表對應的原始數據。</small></p>
        </div>
    </div>	
	</#if>
    <script>
    let lessonStoreUrl = '${lessonStoreUrl}';
    let planId = '${planId}'; // 訓練計畫Id
    console.log('planId', planId);
    let trainingPlan
    let lessonIdForPlan = ''; // 訓練教案KeyNo
    let lessonIdForStore;
    let lessonAch;
    let therapistId;
    let therapistName;
    <#if trainingPlan??>
        trainingPlan = ${trainingPlan!""};
        console.log('trainingPlan: ', trainingPlan);
        lessonIdForStore = trainingPlan.lessons[0].lessonId; // 教案市集KeyNo
        lessonAch; // 教案成就
        therapistId = trainingPlan.therapistId; // 治療師Id
        therapistName = trainingPlan.therapistName; // 治療師姓名
    </#if>

    $(document).ready(function(){
        <#if trainingPlan??>
        getTrainingRecord(function(trainingRecords){
            createChart(trainingRecords);
        });
        getTrainingPlan();
        </#if>
        adjustHeight();
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
            
            let imageUrl = lessonStoreUrl + '/File/api/file/path' + lessonMain.headerImageUrl || "";
            let lessonName = lessonMain.lessonName;
            let startDateStr = formatDateNew(planDetail.startDate);
            let endDateStr = formatDateNew(planDetail.endDate);
            
            // 更新訓練計畫詳細資訊
            $('.detailPlanTitle').text(lessonName + ' 訓練計畫');
            $('.detailUsePeriod').text(startDateStr + '~' + endDateStr);
            $('.detailTherapist').text((planDetail.therapistName || therapistName) + ' 治療師');
            
            // 組合規則文字
            let ruleText = '';
            if (planDetail.frequencyPerWeek) ruleText += '每週' + planDetail.frequencyPerWeek + '次';
            if (planDetail.frequencyPerDay) {
                if (ruleText) ruleText += '，';
                ruleText += '每天' + planDetail.frequencyPerDay + '次';
            }
            if (planDetail.durationPerSession) {
                if (ruleText) ruleText += '，';
                const minutes = parseInt(planDetail.durationPerSession, 10) || 0;
                const hours = Math.floor(minutes / 60);
                const remainingMinutes = minutes % 60;
                const formattedTime = (hours > 0 ? hours + '小時' : '') + remainingMinutes + '分鐘';
                ruleText += '每次' + formattedTime;
            }
            $('.detailParameters').text(ruleText || '未設定');
            
            // 更新訓練項目與參數設定
            $('.method-list-group').empty();
            /* ---------- 追蹤指標 ---------- */
            const achRes = wg.evalForm.getJson(JSON.stringify({"lessonId": lessonIdForStore}), lessonStoreUrl + '/LessonAchievement/api/lesson');
            console.log('achRes', achRes);
            const statsRes = wg.evalForm.getJson(JSON.stringify({"lessonId": lessonIdForStore}), lessonStoreUrl + '/LessonStatistics/api/lesson');
            console.log('statsRes', statsRes);
            if (planDetail.lessons && planDetail.lessons.length > 0) {
                planDetail.lessons.forEach(lesson => {
                    if(lesson.achievements && lesson.achievements.length > 0) {
                        lesson.achievements.forEach(ach => {
                            console.log('list ach');
                            achRes.forEach(resAch => {
                                if(resAch.apiName == ach.apiName) {
                                    console.log('match achievement:', resAch);
                                    let achImage = lessonStoreUrl + '/File/api/file/path' + resAch.unlockedIconUrl;
                                    $('.method-list-group').append('<li><img src="' + achImage + '" class="achievement-image" style="width: 30px; height: 30px; margin-right: 10px; vertical-align: middle;">' + resAch.displayName + ' | ' + resAch.description + '</li>');
                                }
                            });
                        });
                    }

                    if (lesson.statistics && lesson.statistics.length > 0) {
                        lesson.statistics.forEach(stat => {
                            console.log('list stat');
                            statsRes.forEach(resStat => {
                            if(resStat.apiName == stat.apiName) {
                                console.log('match stat:', resStat);
                                $('.method-list-group').append('<li>' + resStat.displayName + ' | ' + resStat.apiName + ` &gt; ` + stat.valueGoal + ' </li>');
                            }
                            });
                        });
                    }
                });
            } else {
                $('.method-list-group').append('<li>無訓練項目</li>');
            }
            
            // 更新備註
            $('.detailNotes').text(planDetail.notes || '無特殊備註');
        } else {
            swal('載入訓練計畫失敗','請聯絡管理員','error');
        }
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
    
    /* 取得成就資料 */
    function getAchievement(callback) {
        $.ajax({
            url: lessonStoreUrl + '/LessonAchievement/api/lesson',
            type: "POST",
            dataType: 'json',
            data: JSON.stringify({"lessonId": lessonIdForStore}),
            success: function(response){
                console.log('Achievement:', response);
                if (callback && typeof callback === 'function') {
                    callback(response);
                }
            },
            error: function(err){
                console.log('Achievement Error:', err);
                if (callback && typeof callback === 'function') {
                    callback([]);
                }
            }
        });
    }

    
    // 重新渲染訓練紀錄到原始數據表格
    function renderTrainingRecord(res, achievements) {
        let response = res;
        console.log('renderTrainingRecord response:', response);
        response.data.sort(function (a, b) { return b.startTime - a.startTime; });
        
        const $tbody = $('.rowdata-body');
        $tbody.empty();
        
        // 沒資料的處理
        if (response.data.length === 0) {
            $tbody.append('<tr><td colspan="4" class="text-center text-muted">目前沒有訓練紀錄</td></tr>');
            return;
        }
        $('p.text-muted').hide(); // 隱藏提示文字
        let recordHtml = '';
        response.data.forEach(function (record, index) {
            console.log('Record: ', record);
            const startDate = new Date(record.startTime);
            const endDate = new Date(record.endTime);
            const formattedStartTime = formatDate(startDate);
            const formattedEndTime = formatDate(endDate);
            const formattedPeriod = formatPeriod(record.period);
            recordHtml += `
                <tr data-record-index="` + index + `">
                    <td>` + (index + 1) + `</td>
                    <td>` + formattedStartTime + `</td>
                    <td>` + formattedEndTime + `</td>
                    <td>` + formattedPeriod + `</td>
                </tr>
            `;
        });
        
        $tbody.append(recordHtml);
    }
    
    // 格式化日期時間
    function formatDate(date) {
        if (!date) return '';
        return date.getFullYear() + '/' + 
               String(date.getMonth() + 1).padStart(2, '0') + '/' + 
               String(date.getDate()).padStart(2, '0') + ' ' +
               String(date.getHours()).padStart(2, '0') + ':' + 
               String(date.getMinutes()).padStart(2, '0') + ':' + 
               String(date.getSeconds()).padStart(2, '0');
    }
    
    // 格式化新日期格式
    function formatDateNew(dateString) {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.getFullYear() + '/' + 
               String(date.getMonth() + 1).padStart(2, '0') + '/' + 
               String(date.getDate()).padStart(2, '0');
    }
    
    // 格式化 period 為 HH:mm:ss
    function formatPeriod(milliseconds){
        if (!milliseconds) return '00:00:00';
        let totalSeconds = Math.floor(milliseconds / 1000);
        let hours = Math.floor(totalSeconds / 3600);
        let minutes = Math.floor((totalSeconds % 3600) / 60);
        let seconds = totalSeconds % 60;
        
        return String(hours).padStart(2, '0') + ':' + 
               String(minutes).padStart(2, '0') + ':' + 
               String(seconds).padStart(2, '0');
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
    	padding: 0 10px 10px 10px;
    }
    
    hr{
    	margin: 10px 0 !important;
    }
    
    .method-list-group{
    	list-style-type: none;
    	padding-left: 20px;
    }

    .method-list-group li{
        margin-bottom: 10px;
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
    
	</style>
</div>

