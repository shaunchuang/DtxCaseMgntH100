<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name">提問與回覆</div>
				</div>          
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
	            <div class="default-blks whole-blk">
	            	<div class="col-5">
	            	    <div class="default-blk plan-area">
		            		<div class="default-blks">
		            		    <div class="col-4">
		            		    	<div>
		            		    		<img class="trainingImg" src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/413150/header.jpg?t=1711128146">
		            		    	</div>
	                			</div>
	                			<div class="col-8 plan-detail">
	                				<div>
	                					<div class="sub-title training-title">Minecraft 訓練計畫 | <span>葉忠賢 治療師</span></div>
	                				</div>
	                				<div class="trainingPlan-Period">訓練期間：2024/08/04~2024/08/06</div>
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

	                				</tbody>
	                			</table>
	                		</div>
	                	</div>
	                	<div class="prev-Page">
	                		<button class="btn btn-primary prev-button" onclick="prevButton()"><i class="fa-solid fa-circle-arrow-left"></i>&nbsp;&nbsp;返回</button>
	                	</div>
                	</div>
                	<div class="col-7 default-blk">
                		<div class="chat-header">
                		    <h5>與治療師對話</h5>
                		    <button class="btn btn-sm btn-outline-primary" onclick="loadRoom()" title="重新載入訊息">
                		        <i class="fa-solid fa-refresh"></i> 刷新
                		    </button>
                		</div>
                		<div class="default-blk chat-messages" id="chatRoom" data-group="">
                			<div class="chat-message right">
							    <div class="chat-avatar">
							        <img src="/File/api/file/path/avatar/avatar2.png" alt="Avatar">
							    </div>
							    <div class="chat-text">
							        <div class="chat-message-content">您好，請問要如何讓小明達成追蹤的指標?</div>
							        <div class="chat-username-timestamp">
							            <div class="chat-username">王小明</div>
							            <div class="chat-timestamp">今天, 晚上11:30</div>
							        </div>
							    </div>
							</div>
							
	                        <div class="unread-divider">
                    			<span>未讀訊息</span>
                			</div>
							
	                		<div class="chat-message">
	                            <div class="chat-avatar">
	                                <img src="/File/api/file/path/avatar/avatar1.png" alt="Avatar">
	                            </div>
	                            <div class="chat-text">
	                                <div class="chat-message-content">讓小明適度休息後，重新鼓勵他進行訓練，會達成目標的。</div>
	                                <div class="chat-username-timestamp">
		                                <div class="chat-username">葉忠賢 治療師</div>
		                                <div class="chat-timestamp">今天, 晚上11:30</div>
	                                </div>
	                            </div>
	                        </div>
                		</div>
		                <div class="default-blk chat-input-container">
		                    <div class="chat-input">
		                        <textarea id="chatInput" class="form-control" placeholder="輸入您所遇到的問題..."></textarea>
		                    </div>
		                    <div class="chat-input-func">
		                        <button id="attachBtn" class="btn btn-primary"><i class="fa-solid fa-paperclip"></i>&nbsp;&nbsp;&nbsp;附加檔案</button>
		                        <button id="sendBtn" class="btn btn-primary" onclick="sendMessage()">送出</button>
		                    </div>
		                </div>
                	</div>
	            </div>
	        </div>
		</div>
	</div>
</body>
<script>

	let trainingPlan = ${trainingPlan!""};
	let lessonStoreUrl = '${lessonStoreUrl!""}';
	let lessonId = '';
	let lessonMain;
	// 當前使用者資訊
	let currentUser = ${cUser!""};
	let currentUserName = '${currentUser.name!""}';
	// 從 trainingPlan 中取得治療師資訊
	let therapistId = '';
	let therapistName = '';
	if (trainingPlan && trainingPlan.therapistId) {
		therapistId = trainingPlan.therapistId;
		therapistName = trainingPlan.therapistName || '治療師';
		console.log('載入治療師資訊:', {therapistId: therapistId, therapistName: therapistName});
	} else {
	    console.warn('trainingPlan或therapistId未定義:', trainingPlan);
	}

	$(document).ready(function() {
        // 聊天室訊息區塊滾動至最底部
        $(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
        
        // 確保trainingPlan載入完成後再載入聊天室
        if (trainingPlan && trainingPlan.therapistId) {
            loadRoom();
        } else {
            // 如果trainingPlan尚未載入，等待一下再嘗試
            setTimeout(function() {
                if (trainingPlan && trainingPlan.therapistId) {
                    therapistId = trainingPlan.therapistId;
                    therapistName = trainingPlan.therapistName || '治療師';
                    console.log('延遲載入治療師資訊:', {therapistId: therapistId, therapistName: therapistName});
                    loadRoom();
                } else {
                    console.error('trainingPlan載入失敗，無法初始化聊天室');
                }
            }, 1000);
        }
        
        enterEvent();
        
        // 設定每10秒重新載入一次聊天室
    	setInterval(loadRoom, 10000);
    	
    	getTrainingPlan();
    	getTrainingRecord();
    });
    
    // 監聽textarea Enter事件 按下Enter後送出訊息
    function enterEvent(){
    	$("#chatInput").on("keypress", function(e) {
            if (e.which === 13) {
                sendMessage();
            }
        });
    }
      
    // 返回總覽
    function prevButton(){
    	window.location.href = "/ftl/casetraining/caseDashboard";
    }
    
	// 建立聊天室 聊天室姓名待更新
	function loadRoom() {
	    // 確保therapistId有值
	    if (!therapistId) {
	        console.error('therapistId未定義，無法載入聊天室');
	        alert('治療師資訊未載入，請重新整理頁面');
	        return;
	    }
	    
	    $.ajax({
	        url: "/Chat/api/loadChatRoom",
	        type: "POST",
	        contentType: "application/json",
	        data: JSON.stringify({'currentUserId': ${currentUser.id!""}, 'careUserId': therapistId}),
			async: false,
	        success: function(data) {
	            console.log(data);
	            let chatInfo = typeof data === 'string' ? JSON.parse(data) : data;
	            console.log(chatInfo);
	            
	            if (!chatInfo.success) {
	                console.error('載入聊天室失敗:', chatInfo.message);
	                return;
	            }
	            
	            let messages = chatInfo.ChatMessages;
	            if(messages){
	            	$(".chat-messages").empty();
	            	
	            	// 按時間排序訊息（從舊到新）
	            	messages.sort(function(a, b) {
	            	    return a.createTime - b.createTime;
	            	});
	            	
		            for (let i = 0; i < messages.length; i++) {
		                let message = messages[i];
		                
		                let messageHtml = '';
		                
		                let formattedTime = formatTime(new Date(message.createTime));
		                if (message.userId == currentUser.id) {
		                    messageHtml = 
		                        '<div class="chat-message right">' +
		                            '<div class="chat-avatar">' +
		                                '<img src="/File/api/file/path/avatar/avatar2.png" alt="Avatar">' +
		                            '</div>' +
		                            '<div class="chat-text">' +
		                                '<div class="chat-message-content">' + message.content + '</div>' +
		                                '<div class="chat-username-timestamp">' +
		                                    '<div class="chat-username">' + currentUserName + '</div>' +
		                                    '<div class="chat-timestamp">' + formattedTime + '</div>' +
		                                '</div>' +
		                            '</div>' +
		                        '</div>';
		                } else {
		                    messageHtml = 
		                        '<div class="chat-message">' +
		                            '<div class="chat-avatar">' +
		                                '<img src="/File/api/file/path/avatar/avatar1.png" alt="Avatar">' +
		                            '</div>' +
		                            '<div class="chat-text">' +
		                                '<div class="chat-message-content">' + message.content + '</div>' +
		                                '<div class="chat-username-timestamp">' +
		                                    '<div class="chat-username">' + therapistName + '治療師</div>' +
		                                    '<div class="chat-timestamp">' + formattedTime + '</div>' +
		                                '</div>' +
		                            '</div>' +
		                        '</div>';
		                }
		                $(".chat-messages").append(messageHtml);
		            }
	            }
	            $(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
	            $('#chatRoom').attr('data-group', chatInfo.ChatGroupId);
	            
	            // 設置聊天室標題
	            if (chatInfo.roomName) {
	                console.log('聊天室名稱:', chatInfo.roomName);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('載入聊天室失敗:', error);
	            console.error('Response:', xhr.responseText);
	            alert('載入聊天室失敗，請重新整理頁面');
	        }
	    });
	}

	    
  
	// 送出聊天室訊息
	function sendMessage() {
	    let message = $("#chatInput").val();
	    if (message.trim() === "") {
	        return;
	    }
	    
	    let groupId = $('#chatRoom').attr('data-group');
	    if (!groupId) {
	        console.error('聊天室ID未載入');
	        alert('聊天室未載入，請重新整理頁面');
	        return;
	    }
	    
	    /* 發送訊息至API */
	    $.ajax({
	        url: "/Chat/api/sendMessage",
	        type: "POST",
	        contentType: "application/json",
	        data: JSON.stringify({'chatGroupId': groupId, 'careUserId': therapistId, 'currentUserId': ${currentUser.id!""}, 'message': message}),
	        success: function(data) {
	            console.log(data);
	            let response = typeof data === 'string' ? JSON.parse(data) : data;
	            if (response.success) {
	                console.log('訊息發送成功');
	                // 發送成功後重新載入訊息
	                setTimeout(function() {
	                    loadRoom();
	                }, 100); // 稍微延遲以確保伺服器已處理
	            } else {
	                console.error('發送訊息失敗:', response.message);
	                alert('發送訊息失敗: ' + response.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('發送訊息失敗:', error);
	            console.error('Response:', xhr.responseText);
	            alert('發送訊息失敗，請重試');
	        }
	    });
	    
	    // 清空輸入框
	    $("#chatInput").val("");
	}

    // 格式化聊天室日期
    function formatTime(date) {
	    let hours = date.getHours();
	    let minutes = date.getMinutes();
	    let ampm = hours >= 12 ? '下午' : '上午';
	    hours = hours % 12;
	    hours = hours ? hours : 12; // the hour '0' should be '12'
	    minutes = minutes < 10 ? '0'+minutes : minutes;
	    let strTime = hours + ':' + minutes;
	    let today = new Date();
	    let isToday = date.toDateString() === today.toDateString();
	    let formattedDate = isToday ? "今天" : (date.getMonth() + 1) + "/" + date.getDate();
	    return formattedDate + ', ' + ampm + strTime;
	}
    
    
    function getTrainingPlan(){
		console.log(trainingPlan);
    	
    	let trainingLessons = trainingPlan.lessons;
    		
		let startDateStr = formatDate(trainingPlan.startDate);
		let endDateStr = formatDate(trainingPlan.endDate);

		console.log('訓練計畫開始時間:', startDateStr);
		console.log('訓練計畫結束時間:', endDateStr);

    	lessonIdForStore = trainingPlan.lessons[0].lessonId;
        $.ajax({
			url: lessonStoreUrl + '/LessonMainInfo/api/get/lessonId/' + lessonIdForStore,
			type: 'GET',
			dataType: 'json',
			async: false,
			success: function(response) {
				console.log('LessonMainInfo response:', response);
				lessonMain = response;
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.error('Error with LessonMainInfo:', textStatus, errorThrown);
				console.error('Response Text:', jqXHR.responseText);
				swal('載入教案失敗','請聯絡管理員','error');
			}
		});

		$('.trainingImg').attr("src", lessonStoreUrl + '/File/api/file/path' + lessonMain.headerImageUrl);
    	var titleHtml = lessonMain.lessonName + " 訓練計畫 | <span>" + therapistName + " 治療師</span>";
    	$('.training-title').html(titleHtml);
    	
    	$('.trainingPlan-Period').text('訓練期間：' + startDateStr + ' ~ ' + endDateStr );
    		
    	trainingLessons.forEach( lesson => {
    		console.log(lesson);
    	});
    }
    
	function getTrainingRecord(callback){
		console.log('lessonId For Store', lessonIdForStore);
		$.ajax({
            url: '/Training/api/listData',
            type: "POST",
            dataType: 'json',
            data: JSON.stringify({"planId": String(trainingPlan.planId), "lessonId": lessonIdForStore}), // 訓練教案KeyNo
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
</script>
<style>

	.whole-blk{
		height: 86%;
		max-height: 55rem;
	}

    /* 訓練計畫樣式 */
	.plan-area{
		height: 100%;
		min-height: 400px;
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
    }
    
    .prev-button:hover{
    	background-color: #9E9E9E;
    	color: #FFFFFF;
    	border-color: #9E9E9E;
    }
    
    
	/* 聊天室樣式 */
	.chat-header {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    padding: 10px 15px;
	    border-bottom: 1px solid #ddd;
	    background-color: #f8f9fa;
	}
	
	.chat-header h5 {
	    margin: 0;
	    color: #333;
	}
	
	.chat-messages {
	    height: 80%;
	    max-height: 300px;
	    overflow-y: scroll;
	    padding: 10px;
	    background-color: #fff;
	}
	
	.chat-message {
	    display: flex;
	    margin-bottom: 10px;
	    align-items: flex-start;
	}
	
	.chat-message.right {
	    flex-direction: row-reverse;
	}
	
	.chat-avatar {
	    margin: 0 10px;
	}
	
	.chat-avatar img {
	    width: 40px;
	    height: 40px;
	    border-radius: 50%;
	}
	
	.chat-text {
	    padding: 0;
	    border-radius: 10px;
	    max-width: 70%;
	    position: relative;
	}
	
	.chat-username-timestamp {
	    display: flex;
	    margin-top: 5px;
	    font-size: 1.2rem;
	    color: #888;
	}
	
	.chat-message-content {
		background-color: black;
		color: white;
	    margin-bottom: 5px;
	    padding: 1rem 1.5rem 1rem 1.5rem;
	    border-radius: 0 10px 10px 10px;
	    width: fit-content;
	}
	
	.chat-username {
	    font-weight: bold;
	}
	
	.chat-timestamp {
	    text-align: right;
	    margin-left: 2rem;
	}
	
	.chat-message.right .chat-message-content {
        background-color: #EBFBF7;
        color: black;
        border-radius: 10px 0px 10px 10px;
        
        justify-content: flex-end;
        margin-left: auto;
    }
	
	.chat-message.right .chat-username-timestamp {
	    justify-content: flex-start;
	}
	
	.chat-message.right .chat-username {
	    margin-left: auto;
	}
	
	.chat-message.right .chat-timestamp {
	    margin-right: 0;
	}
	
	.unread-divider {
	    text-align: center;
	    border-top: 1px solid #ccc;
	    margin-top: 20px;
	    position: relative;
	}
	
	.unread-divider span {
	    position: relative;
	    top: -12px;
	    background: #fff;
	    padding: 0 10px;
	    color: #999;
	}


		/* 聊天輸入樣式 */
	.chat-input-container {
        margin-top: 1.5rem;
    }
    
    .chat-input-func {
    	margin-top: 1rem;
    	text-align: right;
    }
    
    #chatInput {
    	height: 60px;
    	border: none;
    }
    
    #sendBtn {
    	margin-left: 0.5rem;
    	padding: 0.5rem 2rem;
    	background-color: #009E75;
    	border-color: #009E75;
    	color: #FFFFFF;
    }
    
    #sendBtn:hover{
    	background-color: #FFFFFF;
    	color: #009E75;
    	border-color: #009E75;
    }
    
    #attachBtn {
    	padding: 0.5rem 2rem;
    	background-color: #FFFFFF;
    	border-color: #9E9E9E;
    	color: #9E9E9E;
    }
    
    #attachBtn:hover{
    	background-color: #9E9E9E;
    	color: #FFFFFF;
    	border-color: #9E9E9E;
    }
</style>
</html>
