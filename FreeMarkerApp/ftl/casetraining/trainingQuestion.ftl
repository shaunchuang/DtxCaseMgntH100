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
	            <div class="default-blks">
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
	                				<!--<div>追蹤指標1：完成時間00:30:00</div>
	                				<div>追蹤指標2：完成分數80分</div>-->
	                			</div>
	                		</div>
	                		<div class="default-blks" id="recordList">
	                			<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
	                				<thead>
	                					<!--<tr>
	                						<th>編號</th>
	                						<th>訓練日期</th>
	                						<th>時間</th>
	                						<th>訓練結果</th>
	                					<tr>-->
	                					<tr>
	                						<th>編號</th>
	                						<th>訓練開始時間</th>
	                						<th>訓練結束時間</th>
	                						<th>訓練時長</th>
	                					<tr>
	                				</thead>
	                				<tbody>
	                					<!--<tr>
	                						<td>01</td>
	                						<td>2024/08/04</td>
	                						<td>下午05:06</td>
	                						<td class="aim-fail">未通過指標</td>
	                					</tr>
	                					<tr>
	                						<td>02</td>
	                						<td>2024/08/05</td>
	                						<td>下午05:13</td>
	                						<td class="aim-success">通過指標</td>
	                					</tr>-->
	                				</tbody>
	                			</table>
	                		</div>
	                	</div>
	                	<div class="prev-Page">
	                		<button class="btn btn-primary prev-button" onclick="prevButton()"><i class="fa-solid fa-circle-arrow-left"></i>&nbsp;&nbsp;返回</button>
	                	</div>
                	</div>
                	<div class="col-7 default-blk">
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

	var trainingPlan = ${trainingPlan!""};
	var lessonStoreUrl = '${lessonStoreUrl!""}';
	var lessonKeyNo = '';
	var lessonId = '';

	$(document).ready(function() {
        // 聊天室訊息區塊滾動至最底部
        $(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
        loadRoom();
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
	    $.ajax({
	        url: caseMgntUrl + "/division/api/chat/loadChatRoom",
	        type: "POST",
	        data: {data: JSON.stringify({'currentUserId': currentUserId, 'careUserId': therapistId})},
	        success: function(data) {
	            console.log(data);
	            let chatInfo = JSON.parse(data);
	            console.log(chatInfo);
	            
	            let messages = chatInfo.ChatMessages;
	            if(messages){
	            	$(".chat-messages").empty();
		            for (let i = 0; i < messages.length; i++) {
		                let message = messages[i];
		                
		                let messageHtml = '';
		                
		                let formattedTime = formatTime(new Date(message.createTime));
		                if (message.userId == currentUserId) {
		                    messageHtml = 
		                        '<div class="chat-message right">' +
		                            '<div class="chat-avatar">' +
		                                '<img src="${base}/images/dccs/avatar2.png" alt="Avatar">' +
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
		                                '<img src="${base}/images/dccs/avatar1.png" alt="Avatar">' +
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
	        },
	        error: function(data) {
	            console.log(data);
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
	    /* 發送訊息至API */
	    $.ajax({
	        url: caseMgntUrl + "/division/api/chat/sendMessage",
	        type: "POST",
	        data: {data: JSON.stringify({'chatGroupId': groupId, 'careUserId': therapistId, 'currentUserId': currentUserId, 'message': message})},
	        success: function(data) {
	            console.log(data);
	        },
	        error: function(data) {
	            console.log(data);
	        }
	    });
	    
	    let formattedTime = formatTime(new Date());
	    let messageHtml = 
	        '<div class="chat-message right">' +
	            '<div class="chat-avatar">' +
	                '<img src="${base}/images/dccs/avatar2.png" alt="Avatar">' +
	            '</div>' +
	            '<div class="chat-text">' +
	                '<div class="chat-message-content">' + message + '</div>' +
	                '<div class="chat-username-timestamp">' +
	                    '<div class="chat-username">' + currentUserName + '</div>' +
	                    '<div class="chat-timestamp">' + formattedTime + '</div>' +
	                '</div>' +
	            '</div>' +
	        '</div>';
	    
	    $(".chat-messages").append(messageHtml);
	    $("#chatInput").val("");
	    $(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
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
    	console.log(trainingPlanKeyNo);
    	var result = wg.evalForm.getJson({"data": trainingPlanKeyNo}, caseMgntUrl + '/division/api/TrainingPlan/get');
    	if(result.success){
    		var lessonMain = '';
    		var trainingPlan = result.trainingPlan;
    		var trainingLessons = trainingPlan.trainingLessons;
    		
			var startDateStr = formatDate(trainingPlan.startTime);
			var endDateStr = formatDate(trainingPlan.startTime);
    		
    		lessonId = trainingPlan.trainingLessons[0].lessonStoreKeyNo;
    		lessonKeyNo = trainingPlan.trainingLessons[0].trainingLessonKeyNo;
        	var result = wg.evalForm.getJson({"lessonId": lessonId}, lessonStoreUrl + '/division/api/Lesson/GetLessonBasic');
        	if(result.success){
        		lessonMain = JSON.parse(result.lessonMain);
        	} else {
        		swal('載入訓練計畫失敗','請聯絡管理員','error');
        	}
        	console.log(lessonMain);
			$('.trainingImg').attr("src", lessonMain.evalItemAnses['4']);
    		var titleHtml = lessonMain.evalItemAnses['1'] + " 訓練計畫 | <span>" + therapistName + " 治療師</span>";
    		$('.training-title').html(titleHtml);
    		
    		$('.trainingPlan-Period').text('訓練期間：' + startDateStr + ' ~ ' + endDateStr );
    		
    		trainingLessons.forEach( lesson => {
    			console.log(lesson);
    		});
    	} else {
    		swal('載入訓練計畫失敗','請聯絡管理員','error');
    	}
    }
    
    // 取得訓練紀錄
	function getTrainingRecord(){
		console.log(lessonKeyNo);
		var result = wg.evalForm.getJson({"data": lessonKeyNo}, caseMgntUrl + '/division/api/TrainingData/list');
		console.log('result', result);
		if(result.success){
			var trainingRecord = result.data;
			trainingRecord.forEach((record, index) => {
	        	var startTime = new Date(record.startTime).toLocaleString();
	        	var endTime = new Date(record.endTime).toLocaleString();
	        	var period = new Date(record.period).toISOString().substr(11, 8); // 轉換 period 為 HH:mm:ss 格式
				
				var recordHtml = `
					<tr>
						<td>` + (index+1) + `</td>
						<td>` + startTime + `</td>
						<td>` + endTime + `</td>
						<td>` + period + `</td>
					<tr>
				`
				$('#recordList tbody').append(recordHtml);  
			});
			
		} else {
			swal('載入訓練紀錄失敗','請聯絡管理員','error');
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
