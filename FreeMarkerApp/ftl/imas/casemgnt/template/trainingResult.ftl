<#import "/META-INF/spring.ftl" as spring />
<#import "/META-INF/mspring.ftl" as mspring />	
		
<div id="caseResult">
	<div>
	<!-- 各功能模組內容放置區 -->
		<div class="clearfix"></div>
			<div class="default-blks">
				<div class="col-5">
					<div class="default-blk record-list">
			    		<table id="trainingResultTable" class="table table-striped table-bordered bootstrap-datatable table-customed main-table" >
			    			<thead>
			    				<tr>
			    					<td>編號</td>
			    					<td>訓練日期</td>
			    					<td>訓練計畫名稱</td>
			    				</tr>
			    			</thead>
			    			<tbody>
			    				<tr class="recordTr">
			    					<td>01</td>
			    					<td>2024/04/12~2024/04/12</td>
			    					<td>Minecraft</td>
			    				</tr>
			    				<tr class="achTr">
			    					<td colspan="3">
			    						<div class="subtitle">
			    							<div>追蹤成就</div>
			    						</div>
			    						<div class="achContent">
						    				<div class="col-4">
						    					<div class="achItem">
								    				<div class="col-4">
								    					<div class="achImg">
								    						<img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
								    					</div>
								    				</div>
								    				<div class="col-8">
								    					<div class="achAns">
								    						<div class="achTitle">起床號</div>
								    						<div class="achDescript">順利從土法穿牆倖存</div>
								    					</div>
								    				</div>
							    				</div> <!-- achItem -->
						    				</div>
						    				<div class="col-4">
						    					<div class="achItem">
								    				<div class="col-4">
								    					<div class="achImg">
								    						<img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
								    					</div>
								    				</div>
								    				<div class="col-8">
								    					<div class="achAns">
								    						<div class="achTitle">起床號</div>
								    						<div class="achDescript">順利從土法穿牆倖存</div>
								    					</div>
								    				</div>
							    				</div> <!-- achItem -->
						    				</div>
						    				<div class="col-4">
						    					<div class="achItem">
								    				<div class="col-4">
								    					<div class="achImg">
								    						<img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
								    					</div>
								    				</div>
								    				<div class="col-8">
								    					<div class="achAns">
								    						<div class="achTitle">起床號</div>
								    						<div class="achDescript">順利從土法穿牆倖存</div>
								    					</div>
								    				</div>
							    				</div> <!-- achItem -->
						    				</div>
						    			</div>
						    			<div class="achContent">
						    				<div class="col-4">
						    					<div class="achItem">
								    				<div class="col-4">
								    					<div class="achImg">
								    						<img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
								    					</div>
								    				</div>
								    				<div class="col-8">
								    					<div class="achAns">
								    						<div class="achTitle">起床號</div>
								    						<div class="achDescript">順利從土法穿牆倖存</div>
								    					</div>
								    				</div>
							    				</div> <!-- achItem -->
						    				</div>
						    			</div>
						    		</td>
						    	</tr>
			    				<tr class="recordTr">
			    					<td>02</td>
			    					<td>2024/05/12~2024/05/12</td>
			    					<td>Portal 2</td>
			    				</tr>
			    				<tr class="achTr">
			    					<td colspan="3">
			    						<div class="subtitle">
			    							<div>追蹤成就</div>
			    						</div>
			    						<div class="achContent">
						    				<div class="col-4">
						    					<div class="achItem">
								    				<div class="col-4">
								    					<div class="achImg">
								    						<img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
								    					</div>
								    				</div>
								    				<div class="col-8">
								    					<div class="achAns">
								    						<div class="achTitle">起床號</div>
								    						<div class="achDescript">順利從土法穿牆倖存</div>
								    					</div>
								    				</div>
							    				</div> <!-- achItem -->
						    				</div>
						    				<div class="col-4">
						    					<div class="achItem">
								    				<div class="col-4">
								    					<div class="achImg">
								    						<img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
								    					</div>
								    				</div>
								    				<div class="col-8">
								    					<div class="achAns">
								    						<div class="achTitle">起床號</div>
								    						<div class="achDescript">順利從土法穿牆倖存</div>
								    					</div>
								    				</div>
							    				</div> <!-- achItem -->
						    				</div>
						    				<div class="col-4">
						    					<div class="achItem">
								    				<div class="col-4">
								    					<div class="achImg">
								    						<img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
								    					</div>
								    				</div>
								    				<div class="col-8">
								    					<div class="achAns">
								    						<div class="achTitle">起床號</div>
								    						<div class="achDescript">順利從土法穿牆倖存</div>
								    					</div>
								    				</div>
							    				</div> <!-- achItem -->
						    				</div>
						    			</div>
						    			<div class="achContent">
						    				<div class="col-4">
						    					<div class="achItem">
								    				<div class="col-4">
								    					<div class="achImg">
								    						<img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
								    					</div>
								    				</div>
								    				<div class="col-8">
								    					<div class="achAns">
								    						<div class="achTitle">起床號</div>
								    						<div class="achDescript">順利從土法穿牆倖存</div>
								    					</div>
								    				</div>
							    				</div> <!-- achItem -->
						    				</div>
						    			</div>
			    					</td>
			    				</tr>
			    			</tbody>
			    		</table>
			    	</div>
			    </div>
			    <div class="col-7">
			    	<div class="resultTab">
					    <ul class="trainingTab">
					    	<li class="active">訓練數據</li>
					    	<li>訓練紀錄</li>
					    </ul>
					    <div class="exportResult">匯出紀錄</div>
				    </div>
				    <div class="default-blk training-blk">
				    	<div id="trainingData">
					    	<div>
					    		<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table trainingData-table">
					    			<thead>
					    				<tr>
					    					<td>編號</td>
					    					<td>訓練日期</td>
					    					<td>開始時間</td>
					    					<td>結束時間</td>
					    					<td>使用時長</td>
					    					<td>成就狀態</td>
					    				</tr>
					    			</thead>
					    			<tbody>
					    				<tr>
					    					<td>01</td>
					    					<td>2024/04/12</td>
					    					<td>16:20</td>
					    					<td>18:20</td>
					    					<td>2小時</td>
					    					<td>
					    						<ul class="achResultList">
					    							<li>
					    								<img class="achResultImg" src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
					    								<div class="achTime">完成時間: 2024/04/12 18:20</div>
					    							</li>
					    							<li>
					    								<img class="achResultImg" src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
					    								<div class="achTime">完成時間: 2024/04/12 18:20</div>
					    							</li>
					    							<li>
					    								<img class="achResultImg" src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
					    								<div class="achTime">完成時間: 2024/04/12 18:20</div>
					    							</li>
					    							<li>
					    								<img class="achResultImg" src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
					    								<div class="achTime">完成時間: 2024/04/12 18:20</div>
					    							</li>
					    						<ul>
					    					</td>
					    				</tr>
					    				<tr>
					    					<td>02</td>
					    					<td>2024/04/12</td>
					    					<td>16:20</td>
					    					<td>18:20</td>
					    					<td>2小時</td>
					    					<td>
					    						<ul class="achResultList">
					    							<li>
					    								<img class="achResultImg" src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
					    								<div class="achTime">完成時間: 2024/04/12 18:20</div>
					    							</li>
					    							<li>
					    								<img class="achResultImg" src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
					    								<div class="achTime">完成時間: 2024/04/12 18:20</div>
					    							</li>
					    							<li>
					    								<img class="achResultImg" src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
					    								<div class="achTime">完成時間: 2024/04/12 18:20</div>
					    							</li>
					    							<li>
					    								<img class="achResultImg" src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/apps/620/SURVIVE_CONTAINER_RIDE.jpg">
					    								<div class="achTime">完成時間: 2024/04/12 18:20</div>
					    							</li>
					    						<ul>
					    					</td>
					    				</tr>
					    			</tbody>
					    		</table>
					    	</div>
					    	<div class="default-blk">
						    	<div class="statsData">
						    		<div class="col-3 statsItems">
						    			<div class="statsItem">
						    				<span>PS3.SP.progress</span>
						    			</div>
						    			<div class="statsItem">
						    				<span>PS3.SP.progress</span>
						    			</div>
						    			<div class="statsItem">
						    				<span>PS3.SP.progress</span>
						    			</div>
						    			<div class="statsItem">
						    				<span>PS3.SP.progress</span>
						    			</div>
						    			<div class="statsItem">
						    				<span>PS3.SP.progress</span>
						    			</div>
						    		</div>
						    		<div class="col-9">
						    			<canvas id="resultChart"></canvas>
						    		</div>
						    	</div>
						    </div>
					    </div> <!-- trainingData -->
					    <div id="trainingRecord">
					    	<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
					    		<tbody>
					    			<tr>
					    				<td>訓練成效</td>
					    				<td>
					    					<div>完成時間提升60%</div>
					    					<div>完成分數提升20%</div>
					    				</td>
					    			</tr>
					    			<tr>
					    				<td>訓練狀況</td>
					    				<td>
					    					<ul class="statusChoice">
					    						<li>
					    							<label>
					    								<input type="radio" name="status" value="1"><span class="custom-radio"></span><div class="choiceText">正常</div>
					    							</label>
					    						</li>
					    						<li>
					    							<label>
					    								<input type="radio" name="status" value="2"><span class="custom-radio"></span><div class="choiceText">異常</div>
					    							</label>
					    						</li>
					    					</ul>
					    				</td>
					    			</tr>
					    			<tr>
					    				<td>整體訓練描述</td>
					    				<td><textarea></textarea></td>
					    			</tr>
					    		</tbody>
					    	</table>
					    	<div class="saveArea">
					    	<div class="saveBtn">儲存</div>
					    </div>
					</div> <!-- trainingRecord -->
				</div>
			</div> <!-- default-blk -->
		</div> <!-- col-7 -->
	</div> <!-- default-blks -->
<script>
	var caseKeyNo = '${formId!""}';
	var lessonStoreUrl = '${dtxLessonStoreUrl!""}';
	
	var resultChart = null;
	
	var dateArray = [];
	$(document).ready(function(){
		getTrainingPlanV2();
	    $('#trainingRecord').hide();
	    recordTab();
		recordTr();
    });
    

    
    function recordTab(){
    	$('.trainingTab li').click(function(){
            $('.trainingTab li').removeClass('active');
            $(this).addClass('active');
            if($(this).text() == '訓練數據'){
                $('#trainingData').show();
                $('#trainingRecord').hide();
            }else{
                $('#trainingData').hide();
                $('#trainingRecord').show();
            }
        });
    }
    
	function recordTr() {
	    // 初始化時隱藏所有相關元素
	    $('.training-blk').hide();
	    $('.resultTab').hide();
	    $('.arrow').hide();
	    $('.achTr').hide();
	    $('.statsTr').hide();
	
	    // 為 .recordTr 綁定點擊事件
	    $('.recordTr').click(function () {
	        const $nextAchTr = $(this).next('.achTr');
	        const $nextStatsTr = $nextAchTr.next('.statsTr');
	        var planId = $(this).data('plan-id');
	        console.log('click planId ', planId);
	
	        if ($nextAchTr.is(":visible")) {
	            // 如果目前的 .achTr 已經顯示，隱藏所有相關元素
	            $nextAchTr.hide();
	            $nextStatsTr.hide();
	            $('.training-blk').hide();
	            $('.resultTab').hide();
	            $('.arrow').hide();
	        } else {
	            // 隱藏所有其他的 .achTr 和 .statsTr
	            $('.achTr').hide();
	            $('.statsTr').hide();
	
	            // 顯示點擊對應的 .achTr 和 .statsTr
	            $nextAchTr.show();
	            $nextStatsTr.show();
	
	            // 顯示其他相關區塊
	            showPlanDetailV2(planId);
	            $('.training-blk').show();
	            $('.resultTab').show();
	            $('.arrow').show();
	        }
	    });
	}

    
    function getTrainingPlan(){
		var result = wg.evalForm.getJson({"data": caseKeyNo}, "${base}/division/api/TrainingPlan/list");

		if(result.success){
			$('#trainingResultTable tbody').empty();
			var planName = "";
			var trainingPlanList = result.trainingPlan;
			var trainingPlanRow = "";
			trainingPlanList.forEach((trainingPlan, index) => {
				// 列出訓練教案資訊
				var trainingLesson = trainingPlan.trainingLessons[0];
				
				// 訓練教案成就統計
				var trainingLessonAch = trainingLesson.achievement;
				var trainingLessonStats = trainingLesson.stats;
				
				var lessonId = trainingLesson.lessonStoreKeyNo;
				// 教案基本資料與成就
				var lessonResult = wg.evalForm.getJson({"lessonId": lessonId}, lessonStoreUrl + '/division/api/Lesson/GetLessonBasic');
				var achMesg = wg.evalForm.getJson({"lessonId": lessonId}, lessonStoreUrl + '/division/api/Lesson/GetLessonAchievement');
				var achDTO = [];
				if(achMesg.success){
					achDTO = JSON.parse(achMesg.achievementsDTO);
				} else {
					swal('載入訓練教案失敗','請聯絡管理員','error');
				}
				
				var lessonMain = '';
				
				if(lessonResult.success){
					lessonMain = JSON.parse(lessonResult.lessonMain);
				} else {
					swal('載入訓練教案失敗','請聯絡管理員','error');
				}
				
				// 訓練計畫基本資料
				var lessonName = lessonMain.evalItemAnses['1']; // 教案名稱
				var startDateStr = trainingPlan.startTime; // 開始時間
        		var endDateStr = trainingPlan.endTime; // 結束時間
				var achContent = '';
				
				// 開始一個新的 achContent 容器
				achContent += `<div class="achContent">`;
				// mapping 教案市集平台統計資料
				trainingLessonAch.forEach(lessonAch => {
				
				    achDTO.forEach(ach => {
				        if (ach.evalItemAnses['52'] === lessonAch) {
				            achContent += `
				                <div class="col-4">
				                    <div class="achItem">
				                        <div class="col-4">
				                            <div class="achImg">
				                                <img src="` + ach.evalItemAnses['55'] + `" alt="` + ach.evalItemAnses['53'] + `">
				                            </div>
				                        </div>
				                        <div class="col-8">
				                            <div class="achAns">
				                                <div class="achTitle">` + ach.evalItemAnses['53'] + `</div>
				                                <div class="achDescript">` + ach.evalItemAnses['54'] + `</div>
				                            </div>
				                        </div>
				                    </div> <!-- achItem -->
				                </div>
				            `;
				        }
				    });
				
				});
				// 關閉 achContent 容器
				achContent += `</div>`;
				
				statsContent = '';
				trainingLessonStats.forEach( lessonStats => {
					statsContent += `
						<div class="statsContent">
							<div>`+ lessonStats.apiName + ` >= ` + lessonStats.statsValue +`</div>
						</div>
					`;
				});
				
				
				trainingPlanRow += `
					<tr class="recordTr" data-plan-id="` + trainingPlan.trainingPlanKeyNo + `">
						<td>` + (index+1) + `</td>
						<td>` + startDateStr + `~` + endDateStr +`</td>
						<td>` + lessonName + `</td>
					</tr>
					<tr class="achTr">
						<td colspan="3">
							<div class="subtitle">
								<div>追蹤成就</div>
							</div>
						` + achContent + `
						</td>
					</tr>
					<tr class="statsTr">
						<td colspan="3">
							<div class="subtitle">
								<div>追蹤統計</div>
							</div>
							` + statsContent + `
						</td>
					</tr>
				`;
			});
			
			$('#trainingResultTable tbody').append(trainingPlanRow);
			$('.achTr').hide();
			$('.statsTr').hide();
		} else {
			swal('載入訓練計畫失敗','請聯絡管理員','error');
		}
    }
    

    function getTrainingPlanV2() {
    // 1. 取得訓練計畫列表
    let result = wg.evalForm.getJson({ "patientId": caseKeyNo }, "${base}/division/api/TrainingPlan/listNew");
    console.log('result', result);

    if (result.success) {
        // 清空表格
        $('#trainingResultTable tbody').empty();

        // 取得訓練計畫陣列
        let trainingPlanList = result.trainingPlan;
        console.log(trainingPlanList);

        // 累積要插入表格的字串
        let trainingPlanRow = "";

        // 2. 逐筆處理每個訓練計畫
        trainingPlanList.forEach((trainingPlan, index) => {

            // (a) 先取得第一個課程 (示例中假設只有第一筆需要)
            let trainingLesson = trainingPlan.lessons[0];

            // (b) 提取教案成就與統計資訊
            let trainingLessonAch = trainingLesson.achievements;
            let trainingLessonStats = trainingLesson.statistics;

            // (c) 取得 lessonId 用於後續 API 呼叫
            let lessonId = trainingLesson.lessonId;

            // 3. 取得教案基本資料
            let lessonResult = wg.evalForm.getJson(
                { "lessonId": lessonId },
                lessonStoreUrl + '/division/api/Lesson/GetLessonBasic'
            );

            let lessonMain = '';
            if (lessonResult.success) {
                lessonMain = JSON.parse(lessonResult.lessonMain);
            } else {
                swal('載入訓練教案失敗', '請聯絡管理員', 'error');
            }

            // 4. 取得教案成就
            let achMesg = wg.evalForm.getJson(
                { "lessonId": lessonId },
                lessonStoreUrl + '/division/api/Lesson/GetLessonAchievement'
            );

            let achDTO = [];
            if (achMesg.success) {
                achDTO = JSON.parse(achMesg.achievementsDTO);
            } else {
                swal('載入訓練教案失敗', '請聯絡管理員', 'error');
            }

            // 5. 組裝教案基本資訊
            let lessonName = lessonMain.evalItemAnses['1'];  // 教案名稱
            let startDateStr = formatDateV2(trainingPlan.startDate); // 開始時間
            let endDateStr = formatDateV2(trainingPlan.endDate);     // 結束時間

            // 6. 組裝成就內容
            let achContent = `<div class="achContent">`;

            // 根據 achievements 裡的資料，匹配 achDTO
            trainingLessonAch.forEach(lessonAch => {
                achDTO.forEach(ach => {
                    if (ach.evalItemAnses['52'] === lessonAch.apiName) {
                        achContent += `
                            <div class="col-4">
                                <div class="achItem">
                                    <div class="col-4">
                                        <div class="achImg">
                                            <img src="` + ach.evalItemAnses['55'] + `" alt="` + ach.evalItemAnses['53'] + `">
                                        </div>
                                    </div>
                                    <div class="col-8">
                                        <div class="achAns">
                                            <div class="achTitle">` + ach.evalItemAnses['53'] + `</div>
                                            <div class="achDescript">` + ach.evalItemAnses['54'] + `</div>
                                        </div>
                                    </div>
                                </div> <!-- achItem -->
                            </div>
                        `;
                    }
                });
            });
            achContent += `</div>`;

            // 7. 組裝統計內容
            let statsContent = '';
            trainingLessonStats.forEach(lessonStats => {
                statsContent += `
                    <div class="statsContent">
                        <div>` + lessonStats.apiName + ` > ` + lessonStats.valueGoal + `</div>
                    </div>
                `;
            });

            // 8. 組裝最終表格內容
            trainingPlanRow += `
                <tr class="recordTr" data-plan-id="` + trainingPlan.planId + `">
                    <td>` + (index + 1) + `</td>
                    <td>` + startDateStr + `~` + endDateStr + `</td>
                    <td>` + lessonName + `</td>
                </tr>
                <tr class="achTr">
                    <td colspan="3">
                        <div class="subtitle">
                            <div>追蹤成就</div>
                        </div>
                        ` + achContent + `
                    </td>
                </tr>
                <tr class="statsTr">
                    <td colspan="3">
                        <div class="subtitle">
                            <div>追蹤統計</div>
                        </div>
                        ` + statsContent + `
                    </td>
                </tr>
            `;
        });

        // 9. 追加至表格
        $('#trainingResultTable tbody').append(trainingPlanRow);

        // 10. 預設隱藏成就和統計列
        $('.achTr').hide();
        $('.statsTr').hide();

    } else {
        // 若載入失敗，顯示錯誤提示
        swal('載入訓練計畫失敗', '請聯絡管理員', 'error');
    }
}

    
    
    
    function showPlanDetail(planId){
    	// 取得訓練計畫(trainingPlan)
	    var planResult = wg.evalForm.getJson({"data": planId}, "${base}/division/api/TrainingPlan/get"); 
	    var lesson;
	        
	    if(planResult.success){
			lesson = planResult.trainingPlan.trainingLessons['0'];
	    } else {
	        swal('載入訓練計畫失敗','請聯絡管理員','error');
	    }
	        
	    var statsTarget = lesson.stats;
	    var achTarget = lesson.achievement;
	        
	    var statsArray = [];
	    var statsValueArray = [];
	    var statsButton = "";
	        
	    // 取得訓練結果(trainingData)
	    var lessonTrainingResult = wg.evalForm.getJson({"data":JSON.stringify(lesson.trainingLessonKeyNo)}, "${base}/division/api/TrainingData/list");
	    
	    createChart(lessonTrainingResult.data);
	    if(lessonTrainingResult.success){
	        $('.statsItems').empty();
	        $('.trainingData-table tbody').empty();
	        	
	        if(statsTarget.apiName && statsTarget.apiName != "" ){
	        
		    	statsArray.push(statsTarget.apiName);
		    	statsValueArray.push(statsTarget.statsValue);
		    	statsButton += `<div class="statsItem">
		        					<span>` + statsTarget.apiName + `</span>
		        				</div>`;
	        }
	        	
	        trainingResult = lessonTrainingResult.data;
	        
	        var recordHtml = "";
	        
		    trainingResult.forEach((record, index) => {
		        var startDateObj = new Date(record.startTime);
		        	
		        // 格式化日期為 'yyyy/MM/dd'
				var formattedStartDate = startDateObj.toLocaleDateString('zh-TW', {
					year: 'numeric',
					month: '2-digit',
					day: '2-digit',
				}).replace(/\//g, '/'); // 確保使用斜線分隔
					
				dateArray.push(formattedStartDate);
					
				var formattedStartTime = startDateObj.toLocaleTimeString('en-US', {
				    hour: '2-digit',
				    minute: '2-digit',
				    second: '2-digit',
				    hour12: false
				});
		        	
	        	var endDateObj = new Date(record.endTime);
	        		
				var formattedEndTime = endDateObj.toLocaleTimeString('en-US', {
				    hour: '2-digit',
				    minute: '2-digit',
				    second: '2-digit',
				    hour12: false
				});
	        		
	        	var period = new Date(record.period).toISOString().substr(11, 8); // 轉換 period 為 HH:mm:ss 格式
			    // 取得教案市集成就 
			    var lessonId = lesson.lessonStoreKeyNo;
				var lessonAch = wg.evalForm.getJson({"lessonId": lessonId}, lessonStoreUrl + '/division/api/Lesson/GetLessonAchievement');
	        	if(lessonAch.success){
	        		var achDTO = JSON.parse(lessonAch.achievementsDTO);
	        	} else {
	        		swal('載入訓練計畫失敗','請聯絡管理員','error');
	        	}
	        		

	        	// 取得訓練計畫底下訓練教案 成就與統計目標
	        	// 統計數據
	        	//statsTarget.forEach( stats => {

	        	//record.statsData.forEach( statsData => {

	        	//統計是否達成目標
	        	/*if(stats.apiName == statsData.apiName){
	        		if(Number(statsData.statsValue) > Number(stats.statsValue)){
	        			statsHtml += `<div class="stats-Achieve"></div>`	
	        		} else {
	        			statsHtml += `<div class="stats-notAchieve"></div>`
	        			}
	        		}*/
	        			//});
	        		//});
	        		
	        	// 成就資料顯示
	        	var achHtml = "";
	        	
	        	achTarget.forEach( ach => {
	        	
	        		record.achievement.forEach( achData => {
	        			if(achData.apiName == ach){
	        				achDTO.forEach( dto => {
	        					if(dto.evalItemAnses['52'] == ach){
	        						var unlockDate = new Date(achData.unlocktime * 1000);
	        						var unLockTime = unlockDate.toLocaleString("zh-TW");
	        						achHtml += `<li>
	        										<img class="achResultImg" src="` + dto.evalItemAnses['55'] + `">
	        										<div class="achTime">` + unLockTime + `</div>
	        									</li>`
	        						}
	        					});
	        			} else {
	        				achDTO.forEach( dto => {
	        					if(dto.evalItemAnses['52'] == ach){
	        						achHtml += `<li>
	        										<img class="achResultImg" src="` + dto.evalItemAnses['56'] + `">
	        										<div class="achTime">未完成</div>
	        									</li>`
	        					}
	        				});
	        			}
	        		});
	        	});
	        		
	        	recordHtml += `
	        		<tr>
	        			<td>` + (index+1) + `</td>
	        			<td>` + formattedStartDate + `</td>
	        			<td>` + formattedStartTime + `</td>
	        			<td>` + formattedEndTime + `</td>
	        			<td>` + period + `</td>
	        			<td><ul class="achResultList">` + achHtml + `</ul></td>
	        		</tr>
	        	`
		    });
		    $('.trainingData-table tbody').append(recordHtml);
		    
		    if(statsButton != "" ) {
		    	$('.statsItems').append(statsButton);
		    }
		}
    }
    
    function showPlanDetailV2(planId){
    	var planResult = wg.evalForm.getJson({"planId": planId}, "${base}/division/api/TrainingPlan/getNew"); 
	    
	    console.log('planResult: ', planResult);
	    
	    var lesson;
	    
	    if(planResult.success){
			lesson = planResult.trainingPlan.lessons[0];
	    } else {
	        swal('載入訓練計畫失敗','請聯絡管理員','error');
	    }
	    var achTarget = lesson.achievements;
	    var statsTarget = lesson.statistics;
	    
	    var statsArray = [];
	    var statsValueArray = [];
	    var statsButton = "";
	    
	    // 取得訓練結果(trainingData)
	    var lessonTrainingResult = wg.evalForm.getJson({"planId":planId, "lessonId": lesson.lessonId}, "${base}/division/api/v2/TrainingData/list");
	    resultData = lessonTrainingResult.data;
	    console.log('lessonTrainingResult: ', lessonTrainingResult);
	    createChart(resultData);
	    
	    if(lessonTrainingResult.success){
	    	$('.statsItems').empty();
	        $('.trainingData-table tbody').empty();
	        
	        if(statsTarget.apiName && statsTarget.apiName != "" ){
	        
		    	statsArray.push(statsTarget.apiName);
		    	statsValueArray.push(statsTarget.statsValue);
		    	statsButton += `<div class="statsItem">
		        					<span>` + statsTarget.apiName + `</span>
		        				</div>`;
	        }
	        
	        var recordHtml = "";
	        resultData.forEach((record, index) => {
	        	console.log("record index: ", record, index);
	        	var startDateObj = new Date(record.startTime);
		        	
		        // 格式化日期為 'yyyy/MM/dd'
				var formattedStartDate = startDateObj.toLocaleDateString('zh-TW', {
					year: 'numeric',
					month: '2-digit',
					day: '2-digit',
				}).replace(/\//g, '/'); // 確保使用斜線分隔
					
				dateArray.push(formattedStartDate);
					
				var formattedStartTime = startDateObj.toLocaleTimeString('en-US', {
				    hour: '2-digit',
				    minute: '2-digit',
				    second: '2-digit',
				    hour12: false
				});
		        	
	        	var endDateObj = new Date(record.endTime);
	        		
				var formattedEndTime = endDateObj.toLocaleTimeString('en-US', {
				    hour: '2-digit',
				    minute: '2-digit',
				    second: '2-digit',
				    hour12: false
				});
	        		
	        	var period = new Date(record.period).toISOString().substr(11, 8); // 轉換 period 為 HH:mm:ss 格式
			    // 取得教案市集成就 
			    var lessonId = lesson.lessonStoreKeyNo;
				var lessonAch = wg.evalForm.getJson({"lessonId": lessonId}, lessonStoreUrl + '/division/api/Lesson/GetLessonAchievement');
	        	if(lessonAch.success){
	        		var achDTO = JSON.parse(lessonAch.achievementsDTO);
	        	} else {
	        		swal('載入訓練計畫失敗','請聯絡管理員','error');
	        	}
	        	
	        	// 成就資料顯示
	        	var achHtml = "";
	        	
	        	achTarget.forEach( ach => {
	        	
	        		record.achievement.forEach( achData => {
	        			if(achData.apiName == ach){
	        				achDTO.forEach( dto => {
	        					if(dto.evalItemAnses['52'] == ach){
	        						var unlockDate = new Date(achData.unlocktime * 1000);
	        						var unLockTime = unlockDate.toLocaleString("zh-TW");
	        						achHtml += `<li>
	        										<img class="achResultImg" src="` + dto.evalItemAnses['55'] + `">
	        										<div class="achTime">` + unLockTime + `</div>
	        									</li>`
	        					}
	        				});
	        			} else {
	        				achDTO.forEach( dto => {
	        					if(dto.evalItemAnses['52'] == ach){
	        						achHtml += `<li>
	        										<img class="achResultImg" src="` + dto.evalItemAnses['56'] + `">
	        										<div class="achTime">未完成</div>
	        									</li>`
	        					}
	        				});
	        			}
	        		});
	        	});
	        	// 生成訓練數據tr
	        	recordHtml += `
	        		<tr>
	        			<td>` + (index+1) + `</td>
	        			<td>` + formattedStartDate + `</td>
	        			<td>` + formattedStartTime + `</td>
	        			<td>` + formattedEndTime + `</td>
	        			<td>` + period + `</td>
	        			<td><ul class="achResultList">` + achHtml + `</ul></td>
	        		</tr>
	        	`
	        });
	        $('.trainingData-table tbody').append(recordHtml);
		    
		    if(statsButton != "" ) {
		    	$('.statsItems').append(statsButton);
		    }
	    }
	    
    }
    
    // 建立表格所需要的資訊：
    // 開次訓練訓練日期字串list
    // 該日期訓練單次數據list (integer or double)
    // 統計的標題
    // 
	function createChart(trainingRecords) {
        // 確保訓練記錄按 startTime 升序排序
        trainingRecords.sort((a, b) => a.startTime - b.startTime);

        // 準備圖表的標籤和資料
        const labels = [];
        const singleTrainingTimes = []; // 單次訓練時長（分鐘）
        const cumulativeTrainingTimes = []; // 累積訓練時長（分鐘）

        let cumulativeTime = 0; // 初始化累積時間

        trainingRecords.forEach(record => {
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
            console.warn('沒有訓練紀錄資料來繪製圖表。');
            return;
        }

        // 取得 canvas 元素的上下文
        const ctx = document.getElementById('resultChart').getContext('2d');
		
		if(resultChart){
			resultChart.destroy();
		}
		
        // 創建圖表
        resultChart = new Chart(ctx, {
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
    
    function createChartV2(trainingRecords){
    	console.log(trainingRecords);
    
    }
    
    function formatDateV2(input){
        	const date = new Date(input);
		
			// 使用 toLocaleDateString 格式化
			const formattedDate = date.toLocaleDateString('zh-TW', {
			  year: 'numeric',
			  month: '2-digit',
			  day: '2-digit',
			}).replace(/\//g, '/'); // 確保分隔符為 "/"
			
			return formattedDate;
    }

</script>
<style>
	
	.record-list{
		overflow: auto;
		min-height: 42rem;
		height: auto;
	}
	
	.training-blk{
        border-radius: 0px 5px 5px 5px;
        min-height: 34rem;
        height: auto;
    }
	
	/* 訓練表格*/
	#trainingResultTable tbody tr:hover{
		background-color: #bfbfbf;
		cursor: pointer;
	}

    
    /* 左側訓練紀錄相關 */
	.subTitle{
		margin: 0.5rem 0rem 0rem 0.5rem;
	}
	
    .subTitle div{
    	font-size: 1.5rem;
    	font-weight: 900;
    }
    
    .achContent{
    	display: flex;
    	margin: 1rem 0;
    	
    }
    
    
    
    .achAns{
    	padding: 0;
    }
    
    .achTr{
        background-color: #ffffff;
    }
    
    .achTr:hover{
    	background-color: #ffffff !important;
    	cursor: default !important;
    }
    
    .achItem{
    	display: flex;
    }
    
    .achTitle{
    	font-size: 1.3rem;
    	font-weight: 700;
    }
    
    .achImg{
    	justify-content: center;
    	flex-direction: column;
    	align-items: center;
    	width: 100%;
        height: 100%;
    }
    
    .achImg img{
    	width: 100%;
    }
    
    .achDescript{
    	font-size: 1.2rem;
    }
    
    
    /* 訓練數據及訓練紀錄tab */
	.resultTab{
        display: flex;
        justify-content: space-between;
    }
    
	.trainingTab{
		display: flex;
		margin-bottom: 0;
		padding-left: 0;
	}
	
	.trainingTab li{
	
		font-size: 1.4rem;
		margin: 0rem 0.5rem 0rem 0rem;
		border-radius: 5px 5px 0 0 ;
		border: solid 1px #bfbfbf;
		border-bottom: 0;
		list-style-type: none;
		padding: 0rem 2rem 0rem 2rem;
		background-color: #bfbfbf;

	    display: flex; /* 使用 flexbox */
	    align-items: center; /* 垂直置中 */
		
		position: relative;
		top: 1px;
		z-index: 9;
	}
	
	.trainingTab li:hover{
        border-bottom: solid 1px #ffffff;
        background-color: #ffffff;
        cursor: pointer;
        top: 1px;
    }
    
    .trainingTab li.active{
        background-color: #ffffff;
    }
    
    /* 右側訓練紀錄tab 及 匯出紀錄按鈕 */
	#trainingData table{
		font-size: 1.2rem;
		margin: 0.2rem 0 0.1rem 0;
	}
	
	#trainingRecord table{
		font-size: 1.2rem;
	}
    
    .exportResult{
        margin: 0.5rem;
        padding: 0.1rem 2rem;
        border: solid 1px #00CB96;
        border-radius: 5px;
        text-align: center;
        color: #00CB96;
        font-size: 1.2rem;
    }
    
    .exportResult:hover{
        background-color: #00CB96;
        color: black;
        cursor: pointer;
        font-weight: bold;
    }
    
    /* 訓練數據之成就結果*/
    .achResultList{
    	display: flex;
    	padding: 0;
    	margin: 0;
    }
    
    .achResultList li{
    	list-style-type: none;
    	margin: 0rem 0.5rem 0rem 0.5rem;
    	display: flex;
    	align-items: center;
    	position: relative;
    }
    
    
	.achResultImg {
	    width: 3rem; /* 根據你的需求調整圖片大小 */
	    height: 3rem;
	    cursor: pointer;
	}
    
	.achTime {
	    visibility: hidden;
	    width: 120px;
	    background-color: #555;
	    color: #fff;
	    text-align: center;
	    border-radius: 6px;
	    padding: 5px 0;
	    position: absolute;
	    z-index: 1;
	    bottom: 125%; /* 提示框會在圖片上方顯示 */
	    left: 50%;
	    margin-left: -60px;
	    opacity: 0;
	    transition: opacity 0.3s;
	}
       
	.achTime::after {
	    content: "";
	    position: absolute;
	    top: 100%; /* 三角形的底部與提示框底部對齊 */
	    left: 50%;
	    margin-left: -5px;
	    border-width: 5px;
	    border-style: solid;
	    border-color: #555 transparent transparent transparent;
	}
    
	.achResultList li:hover .achTime {
	    visibility: visible;
	    opacity: 1;
	}
    
	/* 統計數據 */	
	.statsItems{
		margin: 0.5rem;
	}
	
	.statsItem{
		margin: 0.5rem;
        border: solid 1px #757575;
        border-radius: 5px;
        padding: 0.5rem 0.5rem 0.5rem 0.5rem;
        text-align: center;
    	color: #757575;
    	font-size: 1rem;
	}
	
	.statsItem:hover{
	    background-color: #00CB96;
        color: black;
        cursor: pointer;
        font-weight: bold;
    }
    
    .statsItem.active{
	    background-color: #00CB96;
        color: black;
        cursor: pointer;
        font-weight: bold;
    }
	
	.statsData{
        display: flex;
        margin: 0rem;
    }
    
    #resultChart{
        padding: 0.5rem;
    }
    
    /* 訓練紀錄tab下內容 */
    #trainingRecord table td:first-child {
	    width: 20%; 
	    white-space: nowrap; 
	}
    
    .statusChoice{
        display: flex;
    	padding: 0;
    	margin: 0;
    }
    
    .statusChoice li{
        list-style-type: none;
    	margin: 0rem 0.5rem 0rem 0.5rem;
    	width: 30%;
    	align-items: center;
    }
    
    .statusChoice label{
    	display: flex;
        justify-content: left;
        align-items: center;
        margin-bottom: 0;
    }
    
    .statusChoice input[type="radio"] {
        display: none;
    }
    
    .custom-radio {
        width: 20px;
        height: 20px;
        border: 2px solid #00CB96;
        display: inline-block;
        border-radius: 4px; /* 這裡可以設為 0 來完全去掉圓角 */
        position: relative;
        cursor: pointer;
    }
    
    .statusChoice input[type="radio"]:checked + .custom-radio::before {
        content: '';
        width: 12px;
        height: 12px;
        background-color: #00CB96;
        display: block;
        position: absolute;
        top: 2px;
        left: 2px;
        border-radius: 2px; /* 這裡可以設為 0 來去掉圓角 */
    }
    
    .choiceText{
        font-size: 1.5rem;
        margin-left: 0.5rem;
    }
    
    /* 訓練紀錄 儲存按鈕 */
    .saveArea{
    	display: flex;
    	justify-content: end;
    	margin: 2rem 2rem;
    }
    
    .saveBtn{
    	padding: 0.6rem 2rem;
    	border: solid 1px #00CB96;
    	border-radius: 5px;
    	text-align: center;
    	color: black;
    	font-size: 1.5rem;
    	background-color: #00CB96;
    
    }
    
    .saveBtn:hover{
    	background-color: #ffffff;
    	cursor: pointer;
    	font-weight: bold;
    }
    
</style>
</div>