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
				    	<ul class="group-list-custom" id="group-list">
				        	<!-- 動態載入的聊天室列表將在這裡顯示 -->
				        	<li class="no-group-message" id="no-groups-message" style="display: none;">
				        		<div>暫無聊天群組</div>
				        	</li>
				      	</ul>
				    </div>
				
				    <!-- 右側聊天區域 -->
					<div class="col-md-8 chat-container-custom">
				    	<div class="chat-blk">
					    	<div class="chat-header-custom" id="chat-header" style="display: none;">
					    		<div class="chat-left-title">
					    			<div class="name-avatar chat-header-avatar" id="chat-avatar"></div>
					    			<h5 class="chat-header-title" id="chat-title"></h5>
					    			<button class="medical-record-btn" data-medical="" id="medical-record-btn"><i class="fa-solid fa-clipboard-user" title="個案病歷"></i></button>
					    		</div>
					    		<div class="chat-actions-custom">
					    			<!-- 動態載入的群組成員頭像將在這裡顯示 -->
									<div id="member-avatars"></div>
					        		<button class="search-message-btn" id="search-message-btn"><i class="fa-solid fa-search"></i></button>
					        		<button class="other-func-btn" id="other-func-btn"><i class="fa-solid fa-ellipsis-vertical"></i></button>
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
								<div class="no-message" id="no-chat-selected">
									<div>請選擇一個聊天群組開始對話</div>
								</div>
								<!-- 聊天訊息將在這裡動態載入 -->
							</div>
						</div> <!-- chat-blk -->
						<div class="chat-input-container default-blk" id="chat-input-container" style="display: none;">
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
									<button id="send-btn" class="btn btn-primary"><i class="fa-regular fa-paper-plane"></i> 送出</button>
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
// 全域變數
let currentChatRoom = null;
let currentUser = null;
let messages = [];
let chatRooms = [];

// API 基礎路徑
const API_BASE = '/Chat/api/';

// 初始化頁面
$(document).ready(function() {
    // 獲取當前用戶信息
    getCurrentUserInfo();
    
    // 初始化表情符號功能
    initEmojiPicker();
    
    // 初始化聊天功能
    initChatFeatures();
    
    // 載入聊天室列表
    loadChatRooms();
    
    // 設定定時器，定期更新訊息
    setInterval(refreshCurrentChat, 5000); // 每5秒更新一次
});

// 獲取當前用戶信息
function getCurrentUserInfo() {
    $.ajax({
        url: API_BASE + 'getCurrentUser',
        method: 'GET',
        success: function(response) {
            if (response.success) {
                currentUser = response.user;
            } else {
                console.error('獲取用戶信息失敗:', response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('獲取用戶信息請求失敗:', error);
        }
    });
}

// 初始化表情符號功能
function initEmojiPicker() {
    const textarea = document.getElementById('input-box');
    const emojiButton = document.getElementById('emoticons');
    const pickerContainer = document.getElementById('emoji-picker-container');

    // 初始化 Emoji Picker
    const picker = new EmojiMart.Picker({
        data: window.EmojiMartData,
        theme: 'light',
        onEmojiSelect: (emoji) => {
            textarea.value += emoji.native;
        },
    });

    pickerContainer.appendChild(picker);

    // 點擊按鈕顯示/隱藏 Picker
    emojiButton.addEventListener('click', (event) => {
        event.stopPropagation();
        const isPickerVisible = pickerContainer.style.display === 'block';
        if (!isPickerVisible) {
            const rect = emojiButton.getBoundingClientRect();
            pickerContainer.style.top = (rect.top + window.scrollY - 50) + 'px';
            pickerContainer.style.left = (rect.left + window.scrollX - 500) + 'px';
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
}

// 初始化聊天功能
function initChatFeatures() {
    // 發送訊息按鈕事件
    $('#send-btn').click(function() {
        sendMessage();
    });
    
    // 輸入框 Enter 鍵發送訊息
    $('#input-box').keypress(function(e) {
        if (e.which === 13 && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    });
    
    // 搜尋群組功能
    $('#search-group-btn').click(function() {
        searchGroups();
    });
    
    $('#search-input').keypress(function(e) {
        if (e.which === 13) {
            searchGroups();
        }
    });
    
    // 搜尋訊息功能
    $('#search-message-btn').click(function() {
        toggleMessageSearch();
    });
    
    // 圖片上傳功能
    $('#attach-btn').click(function() {
        $('#image-upload').click();
    });
    
    $('#image-upload').change(function() {
        handleImageUpload(this);
    });
}

// 載入聊天室列表
function loadChatRooms() {
    $.ajax({
        url: API_BASE + 'loadChatRooms',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({}),
        success: function(response) {
            if (response.success) {
                chatRooms = response.chatRooms || [];
                
                // 為每個聊天室加載額外資訊
                Promise.all(chatRooms.map(room => loadChatRoomExtraInfo(room)))
                    .then(() => {
                        renderChatRoomList(chatRooms);
                    });
            } else {
                console.error('載入聊天室失敗:', response.message);
                showNoGroups();
            }
        },
        error: function(xhr, status, error) {
            console.error('載入聊天室請求失敗:', error);
            showNoGroups();
        }
    });
}

// 載入聊天室額外資訊
function loadChatRoomExtraInfo(room) {
    return new Promise((resolve) => {
        $.ajax({
            url: API_BASE + 'getChatRoomDetails',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ roomId: room.id }),
            success: function(response) {
                if (response.success) {
                    room.lastMessage = response.chatRoom.lastMessage;
                    room.lastMessageTime = response.chatRoom.lastMessageTime;
                    room.unreadCount = response.chatRoom.unreadCount;
                }
                resolve();
            },
            error: function() {
                resolve(); // 即使失敗也繼續
            }
        });
    });
}

// 渲染聊天室列表
function renderChatRoomList(rooms) {
    const groupList = $('#group-list');
    groupList.empty();
    
    if (rooms.length === 0) {
        showNoGroups();
        return;
    }
    
    rooms.forEach(function(room, index) {
        const listItem = createChatRoomListItem(room, index === 0);
        groupList.append(listItem);
    });
    
    // 自動選擇第一個聊天室
    if (rooms.length > 0) {
        selectChatRoom(rooms[0]);
    }
}

// 創建聊天室列表項目
function createChatRoomListItem(room, isActive) {
    const avatarText = room.name ? room.name.charAt(0) : '?';
    const lastMessage = room.lastMessage || '暫無訊息';
    const lastTime = room.lastMessageTime ? formatTime(new Date(room.lastMessageTime)) : '';
    const unreadCount = room.unreadCount || 0;
    
    return `
        <li class="group-item-custom ${isActive ? 'active' : ''}" data-room-id="${room.id}">
            <div class="chatgroup-hint">
                <div class="name-avatar">${avatarText}</div>
                <div class="message-hint-text">
                    <div class="chatgroup-title">${room.name}</div>
                    <div class="chatgroup-text">${lastMessage}</div>
                </div>
            </div>
            <div class="message-hint-info">
                <div>
                    <div class="message-time">${lastTime}</div>
                </div>
                <div>
                    ${unreadCount > 0 ? `<div class="badge-custom">${unreadCount}</div>` : ''}
                </div>
            </div>
        </li>
    `;
}

// 顯示無群組訊息
function showNoGroups() {
    const groupList = $('#group-list');
    groupList.empty();
    $('#no-groups-message').show();
}

// 選擇聊天室
function selectChatRoom(room) {
    currentChatRoom = room;
    
    // 更新UI選中狀態
    $('.group-item-custom').removeClass('active');
    $(`.group-item-custom[data-room-id="${room.id}"]`).addClass('active');
    
    // 顯示聊天標題
    updateChatHeader(room);
    
    // 載入聊天訊息
    loadChatMessages(room.id);
    
    // 顯示聊天輸入區
    $('#chat-input-container').show();
    $('#no-chat-selected').hide();
}

// 更新聊天標題
function updateChatHeader(room) {
    const avatarText = room.name ? room.name.charAt(0) : '?';
    $('#chat-avatar').text(avatarText);
    $('#chat-title').text(room.name);
    $('#chat-header').show();
    
    // 載入群組成員頭像
    loadRoomMembers(room.id);
}

// 載入聊天訊息
function loadChatMessages(roomId) {
    $.ajax({
        url: API_BASE + 'loadMessages',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            roomId: roomId,
            limit: 50
        }),
        success: function(response) {
            if (response.success) {
                messages = response.messages;
                renderMessages(messages);
                scrollToBottom();
            } else {
                console.error('載入訊息失敗:', response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('載入訊息請求失敗:', error);
        }
    });
}

// 渲染訊息列表
function renderMessages(messages) {
    const chatBox = $('#chat-box');
    chatBox.empty();
    
    if (messages.length === 0) {
        chatBox.append('<div class="no-message"><div>暫無訊息</div></div>');
        return;
    }
    
    messages.forEach(function(message) {
        const messageElement = createMessageElement(message);
        chatBox.append(messageElement);
    });
}

// 創建訊息元素
function createMessageElement(message) {
    const isCurrentUser = message.senderId === getCurrentUserId();
    const messageClass = isCurrentUser ? 'chat-message right' : 'chat-message';
    const timestamp = formatTimestamp(new Date(message.createdAt));
    
    return `
        <div class="${messageClass}" data-message-id="${message.id}">
            <div class="chat-avatar">
                <img src="${getAvatarUrl(message.senderId)}" alt="Avatar">
            </div>
            <div class="chat-text">
                <div class="chat-message-content">${escapeHtml(message.content)}</div>
                <div class="chat-username-timestamp">
                    <div class="chat-username">${message.senderName || '未知用戶'}</div>
                    <div class="chat-timestamp">${timestamp}</div>
                </div>
            </div>
        </div>
    `;
}

// 發送訊息
function sendMessage() {
    const messageContent = $('#input-box').val().trim();
    if (!messageContent || !currentChatRoom) {
        return;
    }
    
    $.ajax({
        url: API_BASE + 'sendMessage',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            roomId: currentChatRoom.id,
            content: messageContent,
            messageType: 'TEXT'
        }),
        success: function(response) {
            if (response.success) {
                $('#input-box').val(''); // 清空輸入框
                addMessageToChat(response.message);
                scrollToBottom();
            } else {
                alert('發送訊息失敗: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('發送訊息請求失敗:', error);
            alert('發送訊息失敗，請稍後再試');
        }
    });
}

// 添加訊息到聊天區域
function addMessageToChat(message) {
    const chatBox = $('#chat-box');
    const noMessage = chatBox.find('.no-message');
    if (noMessage.length > 0) {
        noMessage.remove();
    }
    
    const messageElement = createMessageElement(message);
    chatBox.append(messageElement);
}

// 搜尋群組
function searchGroups() {
    const searchTerm = $('#search-input').val().trim().toLowerCase();
    if (!searchTerm) {
        renderChatRoomList(chatRooms);
        return;
    }
    
    const filteredRooms = chatRooms.filter(room => 
        room.name.toLowerCase().includes(searchTerm)
    );
    renderChatRoomList(filteredRooms);
}

// 切換訊息搜尋
function toggleMessageSearch() {
    const searchContainer = $('#search-container');
    const isVisible = searchContainer.is(':visible');
    
    if (isVisible) {
        searchContainer.hide();
        $('#chat-message-search').val('');
        // 清除搜尋高亮
        clearMessageHighlight();
    } else {
        searchContainer.show();
        $('#chat-message-search').focus();
    }
}

// 載入群組成員
function loadRoomMembers(roomId) {
    $.ajax({
        url: API_BASE + 'getRoomMembers',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            roomId: roomId
        }),
        success: function(response) {
            if (response.success) {
                renderMemberAvatars(response.members);
            }
        },
        error: function(xhr, status, error) {
            console.error('載入群組成員失敗:', error);
        }
    });
}

// 渲染成員頭像
function renderMemberAvatars(members) {
    const memberAvatars = $('#member-avatars');
    memberAvatars.empty();
    
    const maxShow = 3;
    members.slice(0, maxShow).forEach(function(member) {
        const avatar = `<img src="${getAvatarUrl(member.userId)}" class="avatar-custom" alt="${member.userName}">`;
        memberAvatars.append(avatar);
    });
    
    if (members.length > maxShow) {
        const extraCount = members.length - maxShow;
        memberAvatars.append(`<div class="extra-avatar">+${extraCount}</div>`);
    }
}

// 刷新當前聊天
function refreshCurrentChat() {
    if (currentChatRoom) {
        loadChatMessages(currentChatRoom.id);
    }
}

// 工具函數
function formatTime(date) {
    const now = new Date();
    const diff = now - date;
    const hours = Math.floor(diff / (1000 * 60 * 60));
    
    if (hours < 24) {
        return date.toLocaleTimeString('zh-TW', { hour: '2-digit', minute: '2-digit' });
    } else {
        return date.toLocaleDateString('zh-TW');
    }
}

function formatTimestamp(date) {
    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    const messageDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
    
    if (messageDate.getTime() === today.getTime()) {
        return '今天, ' + date.toLocaleTimeString('zh-TW', { hour: '2-digit', minute: '2-digit' });
    } else {
        return date.toLocaleDateString('zh-TW') + ', ' + date.toLocaleTimeString('zh-TW', { hour: '2-digit', minute: '2-digit' });
    }
}

function scrollToBottom() {
    const chatBox = $('#chat-box');
    chatBox.scrollTop(chatBox[0].scrollHeight);
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function getAvatarUrl(userId) {
    // 這裡可以根據實際需求修改頭像路徑
    return '${base}/images/avatar/avatar.png';
}

function getCurrentUserId() {
    return currentUser ? currentUser.id : null;
}

function clearMessageHighlight() {
    $('.chat-message-content').removeClass('highlight');
}

function handleImageUpload(input) {
    if (input.files && input.files[0]) {
        const file = input.files[0];
        const reader = new FileReader();
        
        reader.onload = function(e) {
            const previewContainer = $('#preview-container');
            const wrapper = $('<div class="preview-wrapper"></div>');
            const img = $('<img class="preview-image">').attr('src', e.target.result);
            const removeBtn = $('<button class="remove-image-btn">×</button>');
            
            removeBtn.click(function() {
                wrapper.remove();
            });
            
            wrapper.append(img).append(removeBtn);
            previewContainer.append(wrapper);
        };
        
        reader.readAsDataURL(file);
    }
}

// 群組列表點擊事件
$(document).on('click', '.group-item-custom', function() {
    const roomId = $(this).data('room-id');
    const room = chatRooms.find(r => r.id === roomId);
    if (room) {
        selectChatRoom(room);
    }
});
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
	
	.chat-message-content.highlight {
		background-color: #fff3cd !important;
		border: 1px solid #ffeaa7;
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


	/* 成員頭像樣式 */
	.avatar-custom {
		width: 2rem;
		height: 2rem;
		border-radius: 50%;
		margin-left: 5px;
		object-fit: cover;
	}
	
	.extra-avatar {
		width: 2rem;
		height: 2rem;
		background-color: #666;
		color: white;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 0.8rem;
		margin-left: 5px;
	}
	
	/* 載入狀態樣式 */
	.loading {
		text-align: center;
		padding: 20px;
		color: #888;
	}
	
	.loading:before {
		content: '';
		display: inline-block;
		width: 20px;
		height: 20px;
		border: 2px solid #f3f3f3;
		border-top: 2px solid #009E75;
		border-radius: 50%;
		animation: spin 1s linear infinite;
		margin-right: 10px;
	}
	
	@keyframes spin {
		0% { transform: rotate(0deg); }
		100% { transform: rotate(360deg); }
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