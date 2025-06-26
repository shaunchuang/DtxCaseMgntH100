<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>聊天系統 - 聊天室</title>
    
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="${basePath!""}html/AdminLTE/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="${basePath!""}html/AdminLTE/dist/css/adminlte.min.css">
    
    <style>
        .chat-container {
            height: 600px;
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
            display: flex;
            flex-direction: column;
        }
        
        .chat-header {
            background-color: #f8f9fa;
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
            border-radius: 0.375rem 0.375rem 0 0;
        }
        
        .chat-messages {
            flex: 1;
            overflow-y: auto;
            padding: 15px;
            background-color: #fff;
        }
        
        .chat-input {
            border-top: 1px solid #dee2e6;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 0 0 0.375rem 0.375rem;
        }
        
        .message {
            margin-bottom: 15px;
            display: flex;
        }
        
        .message.own {
            justify-content: flex-end;
        }
        
        .message-bubble {
            max-width: 70%;
            padding: 10px 15px;
            border-radius: 18px;
            position: relative;
        }
        
        .message.own .message-bubble {
            background-color: #007bff;
            color: white;
        }
        
        .message:not(.own) .message-bubble {
            background-color: #e9ecef;
            color: #333;
        }
        
        .message-sender {
            font-size: 12px;
            color: #6c757d;
            margin-bottom: 5px;
        }
        
        .message-time {
            font-size: 11px;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .message.own .message-time {
            color: rgba(255,255,255,0.7);
        }
        
        .typing-indicator {
            padding: 10px;
            font-style: italic;
            color: #6c757d;
        }
        
        .member-list {
            max-height: 300px;
            overflow-y: auto;
        }
        
        .loading {
            text-align: center;
            padding: 20px;
            color: #6c757d;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
    <!-- Main content -->
    <div class="content-wrapper" style="margin-left: 0;">
        <!-- Content Header -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">
                            <a href="${caseMgntUrl!""}/ftl/chat/chatlist.ftl" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left"></i>
                            </a>
                            聊天室
                        </h1>
                    </div>
                    <div class="col-sm-6">
                        <div class="float-sm-right">
                            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#membersModal">
                                <i class="fas fa-users"></i> 成員列表
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="chat-container">
                            <!-- 聊天室標題 -->
                            <div class="chat-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h4 id="chatRoomName">載入中...</h4>
                                        <small id="chatRoomInfo" class="text-muted">載入聊天室資訊...</small>
                                    </div>
                                    <div>
                                        <button type="button" class="btn btn-outline-primary btn-sm" onclick="refreshMessages()">
                                            <i class="fas fa-sync-alt"></i> 刷新
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 訊息區域 -->
                            <div class="chat-messages" id="chatMessages">
                                <div class="loading">
                                    <i class="fas fa-spinner fa-spin"></i>
                                    載入訊息中...
                                </div>
                            </div>
                            
                            <!-- 輸入區域 -->
                            <div class="chat-input">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="messageInput" 
                                           placeholder="輸入訊息..." maxlength="1000">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary" type="button" onclick="sendMessage()">
                                            <i class="fas fa-paper-plane"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<!-- 成員列表Modal -->
<div class="modal fade" id="membersModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">聊天室成員</h4>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="membersList" class="member-list">
                    <div class="text-center">
                        <i class="fas fa-spinner fa-spin"></i>
                        載入中...
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
            </div>
        </div>
    </div>
</div>

<!-- AdminLTE JavaScript -->
<script src="${basePath!""}html/AdminLTE/plugins/jquery/jquery.min.js"></script>
<script src="${basePath!""}html/AdminLTE/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${basePath!""}html/AdminLTE/dist/js/adminlte.min.js"></script>

<script>
// 全域變數
let currentUser = null;
let currentRoomId = null;
let caseMgntUrl = '${caseMgntUrl!""}';
let chatMessages = [];
let lastMessageId = 0;

$(document).ready(function() {
    // 從URL參數取得房間ID
    const urlParams = new URLSearchParams(window.location.search);
    currentRoomId = urlParams.get('roomId');
    
    if (!currentRoomId) {
        alert('未指定聊天室');
        window.location.href = caseMgntUrl + '/ftl/chat/chatlist.ftl';
        return;
    }
    
    // 取得當前使用者資訊
    getCurrentUser();
    
    // 載入聊天室資訊
    loadChatRoomInfo();
    
    // 載入訊息
    loadMessages();
    
    // 設定輸入框事件
    $('#messageInput').on('keypress', function(e) {
        if (e.which === 13) { // Enter鍵
            sendMessage();
        }
    });
    
    // 設定聊天容器滾動事件（用於載入歷史訊息）
    $('#chatMessages').on('scroll', function() {
        if ($(this).scrollTop() === 0) {
            // 滾動到頂部時載入更多歷史訊息
            loadHistoryMessages();
        }
    });
    
    // 定期檢查新訊息 (暫時註解掉，因為後端API不支援afterMessageId)
    // setInterval(loadNewMessages, 5000); // 5秒更新一次
});

// 取得當前使用者資訊
function getCurrentUser() {
    $.ajax({
        url: caseMgntUrl + '/security/api/user',
        type: 'GET',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        success: function(response) {
            currentUser = response;
        },
        error: function(xhr, status, error) {
            console.error('取得使用者資訊失敗:', error);
            alert('請先登入系統');
            window.location.href = caseMgntUrl + '/security/login';
        }
    });
}

// 載入聊天室資訊
function loadChatRoomInfo() {
    // 這裡可以添加API來取得聊天室詳細資訊
    $('#chatRoomName').text('聊天室 #' + currentRoomId);
    $('#chatRoomInfo').text('聊天室ID: ' + currentRoomId);
}

// 載入訊息
function loadMessages() {
    $.ajax({
        url: caseMgntUrl + '/Chat/api/loadMessages',
        type: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        data: JSON.stringify({
            roomId: parseInt(currentRoomId),
            limit: 50
        }),
        success: function(response) {
            if (response.success) {
                chatMessages = response.messages;
                displayMessages();
                if (chatMessages.length > 0) {
                    lastMessageId = Math.max(...chatMessages.map(m => m.id));
                }
                scrollToBottom();
            } else {
                $('#chatMessages').html('<div class="alert alert-danger">載入訊息失敗: ' + response.message + '</div>');
            }
        },
        error: function(xhr, status, error) {
            console.error('載入訊息失敗:', error);
            $('#chatMessages').html('<div class="alert alert-danger">載入訊息時發生錯誤</div>');
        }
    });
}

// 手動刷新訊息
function refreshMessages() {
    // 重新載入最新的訊息
    loadMessages();
}

// 載入歷史訊息（向上滾動載入更多）
function loadHistoryMessages() {
    if (chatMessages.length === 0) return;
    
    const oldestMessageId = Math.min(...chatMessages.map(m => m.id));
    
    $.ajax({
        url: caseMgntUrl + '/Chat/api/loadMessages',
        type: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        data: JSON.stringify({
            roomId: parseInt(currentRoomId),
            limit: 20,
            beforeMessageId: oldestMessageId
        }),
        success: function(response) {
            if (response.success && response.messages.length > 0) {
                // 保存當前滾動位置
                const chatContainer = $('#chatMessages');
                const oldScrollHeight = chatContainer[0].scrollHeight;
                const oldScrollTop = chatContainer.scrollTop();
                
                // 將歷史訊息插入到現有列表前面
                chatMessages = response.messages.concat(chatMessages);
                displayMessages();
                
                // 恢復滾動位置，確保用戶不會被突然跳轉
                const newScrollHeight = chatContainer[0].scrollHeight;
                chatContainer.scrollTop(oldScrollTop + (newScrollHeight - oldScrollHeight));
            }
        },
        error: function(xhr, status, error) {
            console.error('載入歷史訊息失敗:', error);
        }
    });
}

// 顯示訊息
function displayMessages() {
    let html = '';
    
    if (chatMessages.length === 0) {
        html = '<div class="text-center text-muted"><p>尚無訊息，開始聊天吧！</p></div>';
    } else {
        // 添加載入更多歷史訊息的提示
        html += '<div class="text-center mb-2"><small class="text-muted"><i class="fas fa-arrow-up"></i> 向上滾動載入更多歷史訊息</small></div>';
        
        chatMessages.forEach(function(message) {
            const isOwn = currentUser && message.senderId === currentUser.id;
            html += `
                <div class="message ${isOwn ? 'own' : ''}">
                    <div class="message-bubble">
                        ${!isOwn ? '<div class="message-sender">' + (message.senderName || '使用者 ' + message.senderId) + '</div>' : ''}
                        <div class="message-content">${escapeHtml(message.content)}</div>
                        <div class="message-time">${formatTime(message.createdAt)}</div>
                    </div>
                </div>
            `;
        });
    }
    
    $('#chatMessages').html(html);
}

// 發送訊息
function sendMessage() {
    const content = $('#messageInput').val().trim();
    
    if (!content) {
        return;
    }
    
    $.ajax({
        url: caseMgntUrl + '/Chat/api/sendMessage',
        type: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        data: JSON.stringify({
            roomId: parseInt(currentRoomId),
            content: content,
            messageType: 'TEXT'
        }),
        success: function(response) {
            if (response.success) {
                $('#messageInput').val('');
                // 添加新訊息到列表
                chatMessages.push(response.message);
                displayMessages();
                lastMessageId = response.message.id;
                scrollToBottom();
            } else {
                alert('發送訊息失敗: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('發送訊息失敗:', error);
            alert('發送訊息時發生錯誤');
        }
    });
}

// 載入成員列表
function loadMembers() {
    $.ajax({
        url: caseMgntUrl + '/Chat/api/getRoomMembers',
        type: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        data: JSON.stringify({
            roomId: parseInt(currentRoomId)
        }),
        success: function(response) {
            if (response.success) {
                displayMembers(response.members);
            } else {
                $('#membersList').html('<div class="alert alert-danger">載入成員失敗: ' + response.message + '</div>');
            }
        },
        error: function(xhr, status, error) {
            console.error('載入成員失敗:', error);
            $('#membersList').html('<div class="alert alert-danger">載入成員時發生錯誤</div>');
        }
    });
}

// 顯示成員列表
function displayMembers(members) {
    let html = '';
    
    if (members.length === 0) {
        html = '<div class="text-center text-muted"><p>尚無成員</p></div>';
    } else {
        html = '<div class="list-group">';
        members.forEach(function(member) {
            html += `
                <div class="list-group-item">
                    <div class="d-flex w-100 justify-content-between">
                        <h6 class="mb-1">${member.userName || '使用者 ' + member.userId}</h6>
                        <small>${formatTime(member.joinedAt)}</small>
                    </div>
                </div>
            `;
        });
        html += '</div>';
    }
    
    $('#membersList').html(html);
}

// 當成員模態框顯示時載入成員列表
$('#membersModal').on('show.bs.modal', function() {
    loadMembers();
});

// 滾動到底部
function scrollToBottom() {
    const messagesDiv = $('#chatMessages');
    messagesDiv.scrollTop(messagesDiv[0].scrollHeight);
}

// HTML轉義
function escapeHtml(text) {
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };
    return text.replace(/[&<>"']/g, function(m) { return map[m]; });
}

// 格式化時間
function formatTime(timestamp) {
    if (!timestamp) return '';
    
    const date = new Date(timestamp);
    const now = new Date();
    const diffTime = Math.abs(now - date);
    const diffMinutes = Math.floor(diffTime / (1000 * 60));
    
    if (diffMinutes < 1) {
        return '剛才';
    } else if (diffMinutes < 60) {
        return diffMinutes + '分鐘前';
    } else if (diffMinutes < 1440) { // 24小時
        return Math.floor(diffMinutes / 60) + '小時前';
    } else {
        return date.toLocaleDateString('zh-TW') + ' ' + 
               date.toLocaleTimeString('zh-TW', {hour: '2-digit', minute: '2-digit'});
    }
}
</script>

</body>
</html>
