<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>聊天系統 - 聊天室列表</title>
    
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="${basePath!""}html/AdminLTE/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="${basePath!""}html/AdminLTE/dist/css/adminlte.min.css">
    
    <style>
        .chat-list-item {
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .chat-list-item:hover {
            background-color: #f8f9fa;
        }
        .unread-badge {
            background-color: #dc3545;
            color: white;
            border-radius: 10px;
            padding: 2px 6px;
            font-size: 11px;
        }
        .last-message {
            color: #6c757d;
            font-size: 13px;
        }
        .chat-time {
            color: #6c757d;
            font-size: 12px;
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
                        <h1 class="m-0">聊天系統</h1>
                    </div>
                    <div class="col-sm-6">
                        <div class="float-sm-right">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createChatModal">
                                <i class="fas fa-plus"></i> 建立聊天室
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
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">我的聊天室</h3>
                            </div>
                            <div class="card-body">
                                <div id="chatRoomsList">
                                    <!-- 聊天室列表將通過 JavaScript 動態載入 -->
                                    <div class="text-center">
                                        <i class="fas fa-spinner fa-spin"></i>
                                        <p>載入中...</p>
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

<!-- 建立聊天室的Modal -->
<div class="modal fade" id="createChatModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">建立新聊天室</h4>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="createChatForm">
                    <div class="form-group">
                        <label for="roomName">聊天室名稱</label>
                        <input type="text" class="form-control" id="roomName" required>
                    </div>
                    <div class="form-group">
                        <label for="roomType">聊天室類型</label>
                        <select class="form-control" id="roomType">
                            <option value="GROUP">群組聊天</option>
                            <option value="PRIVATE">私人聊天</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="description">描述</label>
                        <textarea class="form-control" id="description" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="createChatRoom()">建立</button>
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
let caseMgntUrl = '${caseMgntUrl!""}';

$(document).ready(function() {
    // 取得當前使用者資訊
    getCurrentUser();
    
    // 載入聊天室列表
    loadChatRooms();
    
    // 定期更新聊天室列表
    setInterval(loadChatRooms, 30000); // 30秒更新一次
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
            // 重導向到登入頁面
            window.location.href = caseMgntUrl + '/security/login';
        }
    });
}

// 載入聊天室列表
function loadChatRooms() {
    $.ajax({
        url: caseMgntUrl + '/Chat/api/loadChatRooms',
        type: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        data: JSON.stringify({}),
        success: function(response) {
            if (response.success) {
                displayChatRooms(response.chatRooms);
            } else {
                $('#chatRoomsList').html('<div class="alert alert-danger">載入聊天室失敗: ' + response.message + '</div>');
            }
        },
        error: function(xhr, status, error) {
            console.error('載入聊天室失敗:', error);
            $('#chatRoomsList').html('<div class="alert alert-danger">載入聊天室時發生錯誤</div>');
        }
    });
}

// 顯示聊天室列表
function displayChatRooms(chatRooms) {
    let html = '';
    
    if (chatRooms.length === 0) {
        html = '<div class="text-center text-muted"><p>尚無聊天室，點擊上方按鈕建立新聊天室</p></div>';
    } else {
        html = '<div class="list-group">';
        chatRooms.forEach(function(room) {
            html += `
                <div class="list-group-item chat-list-item" onclick="openChatRoom(${room.id})">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">${room.name}</h5>
                        <small class="chat-time">${formatTime(room.updatedAt || room.createdAt)}</small>
                    </div>
                    <p class="mb-1 last-message">${room.description || '點擊進入聊天室'}</p>
                    <div class="d-flex justify-content-between">
                        <small>成員數: ${room.memberCount || 0}</small>
                        <span class="unread-badge" style="display: none;">0</span>
                    </div>
                </div>
            `;
        });
        html += '</div>';
    }
    
    $('#chatRoomsList').html(html);
}

// 建立聊天室
function createChatRoom() {
    const roomName = $('#roomName').val();
    const roomType = $('#roomType').val();
    const description = $('#description').val();
    
    if (!roomName.trim()) {
        alert('請輸入聊天室名稱');
        return;
    }
    
    $.ajax({
        url: caseMgntUrl + '/Chat/api/createChatRoom',
        type: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        data: JSON.stringify({
            roomName: roomName,
            roomType: roomType,
            description: description
        }),
        success: function(response) {
            if (response.success) {
                $('#createChatModal').modal('hide');
                $('#createChatForm')[0].reset();
                loadChatRooms(); // 重新載入列表
                alert('聊天室建立成功');
            } else {
                alert('建立聊天室失敗: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('建立聊天室失敗:', error);
            alert('建立聊天室時發生錯誤');
        }
    });
}

// 開啟聊天室
function openChatRoom(roomId) {
    // 跳轉到聊天室頁面
    window.location.href = caseMgntUrl + '/ftl/chat/chatroom.ftl?roomId=' + roomId;
}

// 格式化時間
function formatTime(timestamp) {
    if (!timestamp) return '';
    
    const date = new Date(timestamp);
    const now = new Date();
    const diffTime = Math.abs(now - date);
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    
    if (diffDays === 1) {
        return '今天 ' + date.toLocaleTimeString('zh-TW', {hour: '2-digit', minute: '2-digit'});
    } else if (diffDays <= 7) {
        return diffDays + '天前';
    } else {
        return date.toLocaleDateString('zh-TW');
    }
}
</script>

</body>
</html>
