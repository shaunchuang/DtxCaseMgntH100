<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "chatroom.label.title"/></div>
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="container-fluid">
					<div class="row">
				    <!-- 左側群組列表 -->
				    	<div class="col-md-4 sidebar-custom">
				    		<div class="top-function-block">
				      			<h4 class="sidebar-custom-title">跨科諮詢</h4>
				      			<!--<button class="new-group-button"><i class="fa-solid fa-plus"></i> 新增群組</button>-->
				      		</div>
				      		<div class="search-box-custom">
				        	<input type="text" id="search-input" placeholder="搜尋群組名稱">
				        	<button class="search-group-btn" id="search-group-btn"><i class="fa-solid fa-search"></i></button>
						</div>
				    	<ul class="group-list-custom">
				        	<li class="group-item-custom active">
				        		<div class="chatgroup-hint">
				        			<div class="name-avatar">謝</div>
				        			<div class="message-hint-text">
				          				<div class="chatgroup-title">謝O易/34/M (4)</div>
				          				<div class="chatgroup-text">化千登免蛙由別光平，他愣保不「根想眼以</div>
				        			</div>
				        		</div>
				        		<div class="message-hint-info">
				        			<div>
				        				<div class="message-time">晚上11:30</div>
				          			</div>
				          			<div>
				          				<div class="badge-custom">3</div>
				          			</div>
				          		</div>
				        	</li>
				        	<li class="group-item-custom">
				        		<div class="chatgroup-hint">
				        			<div class="name-avatar">謝</div>
				        			<div class="message-hint-text">
				          				<div class="chatgroup-title">謝O易/34/M (4)</div>
				          				<div class="chatgroup-text">化千登免蛙由別光平，他愣保不「根想眼以</div>
				        			</div>
				        		</div>
				        		<div class="message-hint-info">
				        			<div>
				        				<div class="message-time">晚上11:30</div>
				          			</div>
				          			<div>
				          				<div class="badge-custom">3</div>
				          			</div>
				          		</div>
				        	</li>
				        	<li class="group-item-custom">
				        		<div class="chatgroup-hint">
				        			<div class="name-avatar">謝</div>
				        			<div class="message-hint-text">
				          				<div class="chatgroup-title">謝O易/34/M (4)</div>
				          				<div class="chatgroup-text">化千登免蛙由別光平，他愣保不「根想眼以</div>
				        			</div>
				        		</div>
				        		<div class="message-hint-info">
				        			<div>
				        				<div class="message-time">晚上11:30</div>
				          			</div>
				          			<div>
				          				<div class="badge-custom">3</div>
				          			</div>
				          		</div>
				        	</li>
				      	</ul>
				    </div>
				
				    <!-- 右側聊天區域 -->
					<div class="col-md-8 chat-container-custom">
				    	<div class="chat-blk">
					    	<div class="chat-header-custom">
					    		<div class="chat-left-title">
					    			<div class="name-avatar chat-header-avatar">謝</div>
					    			<h5 class="chat-header-title"> 謝O易/34/M (4) </h5>
					    			<button class="medical-record-btn" data-medical=""><i class="fa-solid fa-clipboard-user" title="個案病歷"></i></button>
					    		</div>
					    		<div class="chat-actions-custom">
					    			<img src="${base}/images/avatar/avatar.png" class="avatar-custom">
									<img src="${base}/images/avatar/avatar2.png" class="avatar-custom">
									<img src="${base}/images/avatar/avatar3.png" class="avatar-custom">
									<div class="extra-avatar" style="display: none;">+1</div>
					        		<button class="search-message-btn"><i class="fa-solid fa-search"></i></button>
					        		<button class="other-func-btn"><i class="fa-solid fa-ellipsis-vertical"></i></button>
					    		</div>
							</div>
							<!-- 原本直接放 input 的地方，改為整個容器 -->
							<div class="search-container" id="search-container" style="display: none;">
							    <!-- 左側放大鏡圖示 -->
							    <i class="fa-solid fa-search search-icon"></i>
							
							    <!-- 輸入框 -->
							    <input 
							        type="text" 
							        id="chat-message-search" 
							        class="chat-message-search" 
							        placeholder="搜尋訊息"
							    />
							
							    <!-- 右側 x 按鈕 (清除搜尋) -->
							    <button id="clear-search" class="clear-search-btn">
							        <i class="fa-solid fa-xmark"></i>
							    </button>
							</div>
					    	<div class="chat-box-custom" id="chat-box">
					    		<div id="no-search-result" style="display: none; text-align:center; color:#888; margin-top:10px;">
								    找不到符合的訊息
								</div>

	                			<div class="chat-message right">
								    <div class="chat-avatar">
								        <img src="${base}/images/avatar/avatar.png" alt="Avatar">
								    </div>
								    <div class="chat-text">
								        <div class="chat-message-content">您好，請問要如何讓小明達成追蹤的指標?</div>
								        <div class="chat-username-timestamp">
								            <div class="chat-username">陳建倫</div>
								            <div class="chat-timestamp">今天, 晚上11:30</div>
								        </div>
								    </div>
								</div>
								
								<div class="unread-divider">
	                    			<span>未讀訊息</span>
	                			</div>
	                			
		                		<div class="chat-message">
		                            <div class="chat-avatar">
		                                <img src="${base}/images/avatar/avatar2.png" alt="Avatar">
		                            </div>
		                            <div class="chat-text">
		                                <div class="chat-message-content">讓小明適度休息後，重新鼓勵他進行訓練，會達成目標的。</div>
		                                <div class="chat-username-timestamp">
			                                <div class="chat-username">程靜雯治療師</div>
			                                <div class="chat-timestamp">今天, 晚上11:30</div>
		                                </div>
		                            </div>
		                            
		                        </div>
							</div>
						</div> <!-- chat-blk -->
						<div class="chat-input-container default-blk">
							<div class="input-container">
								<div class="input-textarea">
									<div id="preview-container" class="preview-container"></div> <!-- 圖片預覽區域 -->
									<div id="reply-preview" class="reply-preview" style="display: none;"></div> 
									<textarea class="input-box" id="input-box" placeholder="請輸入訊息"></textarea>
								</div>
								<div class="input-func">
									<button class="btn btn-primary" id="attach-btn"><i class="fa-solid fa-paperclip"></i></button>
									<input type="file" id="image-upload" accept="image/*" style="display: none;">
									<div id="emoji-picker-container"></div>
									<button class="btn btn-primary" id="emoticons"><i class="fa-regular fa-face-smile"></i></button>
									<button id="send-btn" class="btn btn-primary" onclick=""><i class="fa-regular fa-paper-plane"></i> 送出</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>	
	</div>
</body>
<script src="/html/script/imas/chatroom/emoji-mart-data"></script>
<script src="/html/script/imas/chatroom/browser.js"></script>

<script>
    /*** 表情符號功 ***/
    $(document).ready(function () {
        // 選取 DOM 元素
        const textarea = document.getElementById('input-box');
        const emojiButton = document.getElementById('emoticons');
        const pickerContainer = document.getElementById('emoji-picker-container');

        // 初始化 Emoji Picker
        const picker = new EmojiMart.Picker({
            data: window.EmojiMartData, // 使用 EmojiMart 的內建資料
            theme: 'light',
            onEmojiSelect: (emoji) => {
                textarea.value += emoji.native; // 將選取的 Emoji 插入文本框
                //pickerContainer.style.display = 'none'; // 隱藏 Picker
            },
        });

        // 將 Emoji Picker 插入容器
        pickerContainer.appendChild(picker);
		
		// 點擊按鈕顯示/隱藏 Picker
		emojiButton.addEventListener('click', (event) => {
		    event.stopPropagation(); // 防止點擊事件冒泡
		    const isPickerVisible = pickerContainer.style.display === 'block';
		    if (!isPickerVisible) {
		        const rect = emojiButton.getBoundingClientRect(); // 獲取按鈕的位置
		        const pickerHeight = pickerContainer.offsetHeight; // 取得 Picker 的高度
		        const pickerWidth = pickerContainer.offsetWidth; // 取得 Picker 的寬度
		
		        // 設置 Picker 的位置到按鈕的左上角
		        pickerContainer.style.top = (rect.top + window.scrollY - 50 ) + 'px'; // 顯示在按鈕的上方
		        pickerContainer.style.left = (rect.left + window.scrollX - 500) + 'px'; // 顯示在按鈕的左邊
		        pickerContainer.style.display = 'block';
		    } else {
		        pickerContainer.style.display = 'none';
		    }
		});

		// 點擊其他區域隱藏 Picker
		document.addEventListener('click', (event) => {
		    if (!pickerContainer.contains(event.target) && event.target !== emojiButton) {
		        pickerContainer.style.display = 'none';
		    }
		});
	});
</script>
<script>

</script>
<style>

	/* 全域樣式 */
	.container-fluid {
	    width: 100%;
		padding: 0;
	}
	
	/* 左側區域 */
	.sidebar-custom {
		padding: 1.5rem;
	}
	
	.top-function-block {
		display: flex;
		justify-content: space-between;
		align-items: center; /* 使內部元素垂直置中 */
	}
	
	.new-group-button {
		background-color: white;
		padding: 0.5rem;
		border-radius: 4px;
		padding-left: 1rem;
		padding-right: 1rem;
		border: 1px solid #9E9E9E;
		color: #5F5F5F;
		font-weight: 600;
	}
	
	.new-group-button:hover {
		color: white;
		background-color: #5F5F5F;
	}
	
	.new-group-button:active {
		background-color: #3E3E3E; /* 點擊時背景顏色變暗 */
		border-color: #3E3E3E; /* 點擊時邊框顏色變暗 */
		transform: scale(0.95); /* 點擊時縮小一點，模擬按壓效果 */
	}
	
	.sidebar-custom-title {
		margin-bottom: 15px;
		font-weight: 900;
		color: #009E75;
	}
	
	.search-box-custom {
		display: flex;
		margin-bottom: 15px;
	}
	
	.search-box-custom input {
		flex: 1;
		padding: 8px;
		border: 1px solid #ddd;
		border-right: none;
		border-radius: 4px 0 0 4px;
	}
	
	.search-box-custom button {
		padding: 8px 15px;
		border: 1px solid #ddd;
		background-color: white;
		color: black;
		cursor: pointer;
		border-radius: 0 4px 4px 0;
	}
	
	.search-box-custom button:hover {
		background-color: #f0f0f0; /* 滑鼠移入時背景變為淺灰色 */
		border-color: #bbb; /* 滑鼠移入時邊框變深 */
		color: #333; /* 滑鼠移入時文字顏色變深 */
	}
	
	.search-box-custom button:active {
		background-color: #e0e0e0; /* 點擊時背景變為更深的灰色 */
		border-color: #aaa; /* 點擊時邊框變為更深的灰色 */
		color: #111; /* 點擊時文字顏色更深 */
		transform: scale(0.95); /* 點擊時按鈕縮小模擬按壓效果 */
	}
	
	.name-avatar {
		width: 3rem; /* 圓形的寬度 */
		height: 3rem; /* 圓形的高度 */
		background-color: #333; /* 背景顏色（黑灰色）*/
		color: #fff; /* 文字顏色（白色） */
		font-weight: bold; /* 加粗文字 */
		display: flex; /* 使用 Flexbox 對齊 */
		justify-content: center; /* 水平置中 */
		align-items: center; /* 垂直置中 */
		border-radius: 50%; /* 圓形效果 */
		text-align: center; /* 文字置中 */
	}
	
	
	.group-list-custom {
		list-style: none;
		padding: 0;
	}
	
	.group-item-custom {
		display: flex;
		justify-content: space-between;
		padding: 10px;
		border: 1px solid #ddd;
		border-radius: 4px;
		margin-bottom: 5px;
		background-color: #f8f8f8;
		cursor: pointer;
	}
	
	.no-group-message {
	    display: flex; /* 使用 Flexbox */
	    justify-content: center; /* 水平置中 */
	    align-items: center; /* 垂直置中 */
	    text-align: center; /* 文字居中對齊 */
	    padding: 20px;
	    background-color: #f0f0f0;
	    color: #888;
	    border-radius: 8px;
	    margin-top: 10px;
	    min-height: 80%;
	}
	
	.group-item-custom.active {
		background-color: #EBFBF7;
	}
	
	.group-item-custom:hover {
		background-color: #EBFBF7;
	}
	
	.message-hint-text {
		margin-left: 1rem;
	}
	
	.chatgroup-hint {
		display: flex;
		align-items: center;
	}
	
	.chatgroup-text {
		font-size: 1rem;
		overflow: hidden;
	}
	
	.message-hint-info {
	  	display: flex;
	  	flex-direction: column; /* 垂直排列 */
	  	align-items: flex-end; /* 內容靠右對齊 */
	  	gap: 0.5rem; /* 元素之間的間距 */
	}
	
	.message-time {
		font-size: 1rem;
	}
	
	.badge-custom {
		width: 1.5rem; /* 圓形的寬度 */
		height: 1.5rem; /* 圓形的高度 */
		background-color: #00CB96;
		color: #fff;
		border-radius: 50%;
		text-align: center;
		font-size: 1rem;
	}

	#search-group-btn i{
		pointer-events: none;
	}

	/* 右側區域 */

	.chat-container-custom {
		padding: 1.5rem 1.5rem 1.5rem 0;
	}
	
	.chat-blk {
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	}
	
	
	.chat-header-custom {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 1rem;
		border: 1px solid #bfbfbf;
		border-bottom: none;
		border-radius: 4px 4px 0 0;
		background-color: #f8f8f8;
		flex-wrap: nowrap;
	}
	
	.chat-left-title {
		display: flex;
		align-items: center;
		gap: 1rem;
	}
	
	.medical-record-btn {
		border-radius: 4px;
		border: none;
		background-color: #f8f8f8;
		position: relative;
	    display: inline-block;
	}
	
	.medical-record-btn:hover {
		background-color: #d1e8e2;
	}
	
	.medical-record-btn:active {
		background-color: #d1e8e2;
		transform: scale(0.95);
	}

	/* 隱藏 tooltip 的初始樣式 */
	.medical-record-btn i::after {
	    content: attr(title); /* 取出 title 的值作為文字內容 */
	    position: absolute;
	    bottom: 100%; /* 出現在元素的上方 */
	    left: 50%;
	    transform: translateX(-50%);
	    background-color: #333;
	    color: #fff;
	    padding: 5px 10px;
	    border-radius: 4px;
	    font-size: 12px;
	    white-space: nowrap;
	    opacity: 0; /* 初始隱藏 */
	    visibility: hidden;
	    transition: opacity 0.2s ease-in-out;
	    z-index: 10;
	}

	/* 當滑鼠懸停時，顯示 tooltip */
	.medical-record-btn:hover i::after {
	    opacity: 1; /* 顯示 */
	    visibility: visible; /* 改變可見性 */
	}
	
	.chat-actions-custom {
		min-width: 25rem;
		display: flex;
		justify-content: right;
		align-items: center;
	}
	
	.chat-actions-custom button {
		margin-left: 10px;
		padding: 5px 10px;
		cursor: pointer;
		border: none;
		background-color: #f8f8f8;
	}
	
	.chat-box-custom {
		height: 100%;
		max-height: 35rem;
		overflow-y: auto;
		border: 1px solid #bfbfbf;
		border-radius: 0 0 4px 4px;
		padding: 10px;
		margin-bottom: 15px;
	}
	
	.no-message {
		display: flex; /* 使用 Flexbox */
	    text-align: center;
	    justify-content: center; /* 水平置中 */
	    padding: 20px;
	    background-color: #f0f0f0;
	    color: #888;
	    border-radius: 8px;
	    font-size: 14px;
	    margin-top: 10px;
	    align-items: center;
	    min-height: 80%;
	}

	/* 聊天室樣式 */
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
	    width: 3rem;
	    height: 3rem;
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
		background-color: #EBFBF7;
		color: black;
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
		background-color: #202020;
		color: white;
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
	
	.message-img {
		max-width: 100%; /* 限制圖片寬度不超過父容器 */
    	max-height: 150px; /* 限制圖片高度不超過 200px */
    	object-fit: contain; /* 確保圖片等比例縮放並保持完整 */
	}
	
	/* 當 chat-message 沒有 right 類別時，在 chat-message-content 的右邊添加 reply 符號 */
	.chat-message:not(.right) .chat-message-content {
		position: relative; /* 確保可以使用絕對定位 */
		display: inline-block; /* 讓內容正常對齊 */
		margin-right: 30px; /* 預留空間給符號 */
	}
	
	.reply-btn {
	    position: absolute;
	    top: 50%;
	    right: -20px; /* 位於右側 */
	    transform: translateY(-50%); /* 垂直置中 */
	    background: none;
	    border: none;
	    color: #3F3F3F;
	    font-size: 1rem;
	    cursor: pointer;
	}
	
	.reply-btn:hover {
	    color: #009E75; /* 滑鼠懸停效果 */
	}
	
	.reply-preview {
	    border-left: 4px solid #009E75;
	    padding: 10px;
	    margin-bottom: 10px;
	    background-color: #f9f9f9;
	    position: relative;
	    border-radius: 4px;
	}
	
	.reply-content {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	}
	
	.reply-text {
	    font-weight: bold;
	    color: #555;
	}
	
	.reply-message {
	    flex: 1;
	    margin-left: 10px;
	    overflow-wrap: break-word;
	}
	
	.remove-reply-btn {
	    background-color: transparent;
	    border: none;
	    font-size: 16px;
	    font-weight: bold;
	    color: #888;
	    cursor: pointer;
	}
	
	.remove-reply-btn:hover {
	    color: #f00;
	}


	.avatar-custom {
		width: 3rem;
		height: 3rem;
		border-radius: 50%;
		margin-right: 0.3rem;
	}
	
	.extra-avatar {
		width: 2.5rem;
		height: 2.5rem;
		background-color: #d9d9d9;
		color: #333;
		font-size: 14px;
		font-weight: bold;
		border-radius: 50%;
		display: flex;
		justify-content: center;
		align-items: center;
		border: 2px solid #fff;
		z-index: 0;
	}
	
	.message-content-custom {
		background-color: #fff;
		padding: 10px;
		border-radius: 4px;
		border: 1px solid #ddd;
	}
	
	.message-content-custom p {
		margin: 0;
	}
	
	.message-time-custom {
		display: block;
		margin-top: 5px;
		font-size: 12px;
		color: #888;
	}
	
	.chat-input-container {
		width: 100%;
		display: flex;
		border-radius: 4px; /* 整體圓角效果 */
	}
	
	.input-container {
		width: 100%;
		display: flex;
		align-items: center;
		justify-content: space-between;
		border-radius: 4px; /* 輸入框圓角效果 */
	}
	
	.input-container .icon {
		color: #fff; /* 圖示顏色 */
		font-size: 20px; /* 圖示大小 */
		margin: 0 10px;
		cursor: pointer;
	}
	
	.input-container .icon:hover {
		color: #00cc96; /* 懸停時顏色變化 */
	}
	
	.input-textarea {
		width: 70%;
	}
	
	.input-box {
		flex: 1;
		background-color: transparent;
		border: none;
		font-size: 16px;
		padding: 0 10px;
		outline: none; /* 去除邊框高亮 */
		width: 100%;
	}
	
	.input-box::placeholder {
		color: #a8a8a8; /* 提示文字顏色 */
		font-style: italic; /* 提示文字樣式 */
	}
	
	#send-btn {
		background-color: #009E75;
	}
	
	#attach-btn {
		background-color: white;
		border: none;
		color: grey;
	}
	
	#emoticons {
		background-color: white;
		border: none;
		color: grey;
	}

	#emoji-picker-container {
	    display: none;
	    position: absolute;
	    z-index: 100;
	    background: white;
	    border: 1px solid #ccc;
	    border-radius: 8px;
	    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	    transform: translate(-100%, -100%); /* 讓 Picker 在按鈕左上方 */
	}

        
    #emoticons i {
        pointer-events: none; /* 禁止 i 元素攔截點擊事件 */
    }

	.preview-container {
	    display: flex;
	    gap: 10px;
	    margin-bottom: 10px;
	    overflow-x: auto; /* 允許橫向滾動 */
	}
	
	.preview-wrapper {
	    position: relative; /* 確保按鈕能夠正確定位 */
	    display: inline-block;
	}
	
	.preview-image {
	    max-width: 100px; /* 圖片最大寬度 */
	    max-height: 100px; /* 圖片最大高度 */
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    object-fit: cover; /* 保持圖片比例 */
	}
	
	.remove-image-btn {
	    position: absolute;
	    top: 0;
	    right: -5px;
	    width: 20px;
	    height: 20px;
	    border: none;
	    background-color: #ff5c5c;
	    color: white;
	    font-size: 16px;
	    font-weight: bold;
	    border-radius: 50%;
	    cursor: pointer;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
	}
	
	.remove-image-btn:hover {
	    background-color: #ff1a1a;
	}
	
	
	.main-content {
		padding-top: 0rem !important;
		padding-left: 1.5rem !important;
		padding-right: 1.5rem !important;
	}
	
	/* 回覆 樣式 */
	.reply-container {
	    display: flex;
	    padding: 8px;
	    background-color: #f5f5f5;
	    border-left: 3px solid #009E75;
	    border-radius: 5px;
	    align-items: center; /* 垂直置中 */
	}
	
	.reply-avatar {
	    width: 2rem; /* 圓形的寬度 */
		height: 2rem; /* 圓形的高度 */
		background-color: #333; /* 背景顏色（黑灰色） */
		color: #fff; /* 文字顏色（白色） */
		font-weight: bold; /* 加粗文字 */
		display: flex; /* 使用 Flexbox 對齊 */
		justify-content: center; /* 水平置中 */
		align-items: center; /* 垂直置中 */
		border-radius: 50%; /* 圓形效果 */
		text-align: center; /* 文字置中 */
	    
	}
	
	.reply-content {
	    flex: 1;
	}
	
	.reply-username {
	    font-weight: bold;
	    color: #333333;
	    margin-left: 1rem;
	    margin-right: 1rem;
	}
	
	.reply-text {
	    color: grey;
	    font-size: 12px;
	}
	
	.reply-image {
		max-width: 100%; /* 限制圖片寬度不超過父容器 */
    	max-height: 150px; /* 限制圖片高度不超過 200px */
    	object-fit: contain; /* 確保圖片等比例縮放並保持完整 */
    	opacity: 0.8;
	}

	/* 搜尋容器外框 */
	.search-container {
	    position: relative; /* 讓內部元素可以使用絕對定位 */
	    width: 100%;       /* 或自行決定寬度 */
	    border: 1px solid #bfbfbf;
	    border-radius: 0;
	    background-color: #fff;
	    display: flex;         /* 水平並排：icon + input + x */
	    align-items: center;   /* 垂直置中 */
	    padding: 0 8px;        /* 左右內距 */
	    gap: 4px;              /* icon 與輸入框之間的小距離 */
	}
	
	/* 搜尋 icon，置於左側 */
	.search-icon {
	    color: #999;
	    font-size: 1rem;
	}
	
	/* 輸入框本身 */
	.chat-message-search {
	    flex: 1;            /* 讓輸入框自動撐滿剩餘空間 */
	    border: none;
	    outline: none;
	    font-size: 14px;
	    background-color: transparent;
	}
	
	/* 當 input 聚焦時，取消粗外框、改用輕微陰影 */
	.chat-message-search:focus {
	    outline: none;
	    box-shadow: 0 0 0 1px rgba(128, 128, 128, 0.1);
	}
	
	/* 右側 x 按鈕 */
	.clear-search-btn {
	    background: none;
	    border: none;
	    color: #999;
	    cursor: pointer;
	    font-size: 1.1rem;
	    padding: 4px;
	}
	
	.clear-search-btn:hover {
	    color: #666;
	}


</style>
<#include "/imas/widget/widget.ftl" />