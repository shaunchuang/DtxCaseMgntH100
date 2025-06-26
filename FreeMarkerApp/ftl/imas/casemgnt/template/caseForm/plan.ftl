<#import "/util/spring.ftl" as spring />
  
<div id="content">
	<div class="col-md-12 pd-h-0 d-flex g-15 justify-content-between">
    	<div class="col-md-5 pd-h-0 data-blk">
    		<div class="d-flex justify-content-between align-items-center mb-3">
              	<h4 class="mb-0">訓練計畫列表</h4>
            </div>
			<div class="lesson-list-group">
				
			</div>
		</div>
		<div class="col-md-7 pd-h-0 data-blk">
			<div class="d-flex justify-content-between align-items-center mb-3">
              	<h4 class="mb-0">詳細內容與成果</h4>
            </div>    			
			<div id="data-container" class="data-content"></div>
		</div>							
    </div>
    
    <script>
    const lessonStoreUrl = '${lessonStoreUrl!""}';
    console.log('lessonStoreUrl: ', lessonStoreUrl);
    $(document).ready(function(){
		adjustHeight();

		fetchTrainingPlan();		
	});
	
	function fetchTrainingPlan(){
        console.log('patientId: ', ${formId!""});
		var response = wg.evalForm.getJson(JSON.stringify({"patientId":${formId!""}}), '/Training/api/listPlan');

        if (response.success){
			var planName = '';
			var lessonCardHtml = '';
			
			var trainingPlanList = response.trainingPlans;
            console.log('Training Plans:', trainingPlanList);
			if(trainingPlanList.length > 0){
				trainingPlanList.forEach(trainingPlan => {
			
					console.log(trainingPlan);
			        // 計畫資訊
	            	let startDateStr = formatDate(trainingPlan.startDate);
	                let endDateStr = formatDate(trainingPlan.endDate);
	                let therapistName = trainingPlan.therapistName || "治療師";
	                // 每個計畫中的課程
	                if (trainingPlan.lessons && trainingPlan.lessons.length > 0) {
						let lesson = trainingPlan.lessons[0];
	                    let lessonId = lesson.lessonId;
	                    let lessonName = "課程名稱未提供"; // 預設課程名稱
	                    let imageUrl = ""; // 預設圖片

						$.ajax({
							url: lessonStoreUrl + '/LessonMainInfo/api/get/lessonId/' + lessonId,
							method: 'GET',
							dataType: "json",
							async: false, // 同步請求以確保在生成卡片前獲取到數據
							success: function(data) {
								lessonName = data.lessonName || "課程名稱未提供"; // 如果沒有課程名稱，使用預設值
								imageUrl = lessonStoreUrl + '/File/api/file/path' + data.headerImageUrl || ""; // 如果沒有圖片，使用空字串
							},
							error: function(xhr, status, error) {
								console.error("AJAX error:", status, error);
								console.log("Response:", xhr.responseText);
								}
						})
		        	
		        		lessonCardHtml += `
		        			<div class="default-blk lesson-card" data-plan="` + trainingPlan.planId + `">
								<img src="` + imageUrl + `" alt="` + lessonName + `">
								<div class="card-content">
									<div class="card-header">
										<h3>` + lessonName + ` 訓練計畫</h3>
									</div>
									<div class="card-details">
										<div class="card-details-row">
											<p class="period-text">`+ startDateStr + `~` + endDateStr + `</p>
											<span class="status-green">進行中</span>
										</div>
										<p class="staff-text">`+ therapistName + ` 治療師 開立</p>
									</div>
								</div>
							</div>
		        		`;
		        	}
		        });
		        $('.lesson-list-group').append(lessonCardHtml);	        
	        }else{
	        	$(".lesson-list-group").append("<div class='cnt-empty'>目前尚無訓練計畫</div>")
	        }
		} else {
			$(".lesson-list-group").append("<div class='cnt-empty'>目前尚無訓練計畫</div>")
		}
		
		wg.template.updateNewPageContent('data-container', 'data-content', {}, '/ftl/imas/patient/analysis?msg=emptyMessage');

		$("body").on("click", ".lesson-card", function(e) {
			e.preventDefault();
			let planId = $(this).data('plan');
			console.log('Selected Plan ID:', planId);
			wg.template.updateNewPageContent('data-container', 'data-content', {}, '/ftl/imas/patient/analysis/detail?patientId=' + ${formId!""} + '&planId=' + planId);
		});

		if($(".lesson-list-group").length > 0){
			$(".lesson-list-group").children().first().trigger('click');
		}
	}

    function formatDate(dateStr){
        var dateObj = new Date(dateStr);
        var formattedDate = dateObj.getFullYear() + '/' + 
        ('0' + (dateObj.getMonth() + 1)).slice(-2) + '/' + 
        ('0' + dateObj.getDate()).slice(-2);
        
        return formattedDate;
    }
    </script>
	
	<style>
	.lesson-card {
	    display: flex;
	    align-items: center;
	    background-color: #ffffff;
	    margin-bottom: 5px;
	    margin-left: auto;
        margin-right: auto;
	}
	
	.lesson-card:hover{
		cursor: pointer;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.55);
	}
	
	.lesson-card img {
	    width: 100px;
	    height: 80px;
	    border-radius: 8px;
	    margin-right: 16px;
	    object-fit: cover; /* 確保圖片填充區域 */
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
	}
	
	.card-content {
	    flex: 1;
	    display: flex;
        flex-direction: column;
	}
	
	.card-header {
	    display: flex;
	    align-items: center;
	    justify-content: space-between;
	    margin-bottom: 8px;
	}
	
	.card-header h3 {
        margin: 0; /* 移除預設外邊距 */
        font-size: 1.6rem; /* 標題字體大小 */
        color: #d38c12; /* Minecraft 黃色調 */
        font-weight: 700; /* 加粗 */
    }
    
    .card-details-row span{
    	padding: 4px 8px;
        border-radius: 4px;
        font-weight: 600; /* 加粗 */
        white-space: nowrap;
    }
	
	span.status-red{
		background-color: #fce9e8;
	    color: #e63946;
	}
	
	span.status-green{
		background-color: #F0F9F2;
	    color: #3a924d;
	}
	
	.card-details {
	    margin-bottom: 12px;
	}
	
	.card-details-row {
        display: flex;
        justify-content: space-between; /* 左右對齊 */
        align-items: center; /* 垂直居中 */
        margin-bottom: 4px; /* 與下方開立人員資訊間距 */
    }
    
    .card-details-row .period-text {
        margin: 0; /* 移除預設外邊距 */
        color: #333;
        font-weight: 600;
    }
    
    .card-details .staff-text {
        margin: 0; /* 移除預設外邊距 */
        color: #6c757d; /* 較淺的顏色 */
    }

	    .main-content, .main-inner {
		overflow-y: hidden !important;
	}
	
	.data-blk {
	    overflow-y: auto; /* 讓這兩個區域各自擁有滾動條 */
	    box-sizing: border-box; /* 確保 padding 和 border 不會增加元素總寬高 */
	}
	</style>
</div>

