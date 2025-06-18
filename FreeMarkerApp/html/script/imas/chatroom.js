
  var roomId = 3;
  var userId = 0;
  var userEmail = '';
  var userPwd = '';
  var userName = '';
  var userLoc = 'SYS';
  var webrtcPwd = '12345';
  var webrtcRoom = '8865105c-7a99-4140-a5a8-0f2e87ff43e5';
  var webrtcDomain = "meet.jit.si";
  var users = new DataMap();
  //var vConsole = new VConsole();
  var db;
  var indexedDB= window.indexedDB || window.webkitindexedDB || window.msIndexedDB || mozIndexedDB;
  var socket=null;
  var sessionId=null;
  var div = document.getElementById('div');

  var settings = {
      init: false,
      httpUrl: 'http://localhost:8080/WebSocket/',
      wsUrl : 'ws://127.0.0.1:3333',
      store: null
  };

   var ws = {
	      register: function() {
	          console.log("登入資訊:"+ userEmail+", "+userId);
          if (!window.WebSocket) {
              return;
          }
          if (socket.readyState == WebSocket.OPEN) {
              var data = {
                "act": "REGISTER",
                "sessionId": settings.sessionId,
                "userId": userId,
                "userEmail": userEmail
              };
              socket.send(JSON.stringify(data));
          } else {
        	  div.innerText = "Websocket連接沒有開啟！";
          }
      },
      registerAck: function(_data) {
          console.log("使用者登入成功，編號為:"+ userId);
          userId = _data.userId;
          userLoc = _data.userLoc;
          var data = {
              "act": "GETUSERINFO",
              "userId": userId 
          };
          socket.send(JSON.stringify(data));
      },
      recvUserInfo: function(_data) {
          console.log("取到用戶資訊");
          for (var i = 0; i < _data.users.length; i++) {
              addUser(_data.users[i].id,_data.users[i].name,_data.users[i].url,_data.users[i].type , _data.users[i].email, _data.users[i].memo);
          }

          for (var i = 0; i < _data.rooms.length; i++) {
              addRoom(_data.rooms[i].id,_data.rooms[i].owner,_data.rooms[i].name,_data.rooms[i].url , _data.rooms[i].memo, _data.rooms[i].members);
          } 

          readLocalRooms(function(items) {
        	  renderRoomList(items, true);
        	  $('.roomList ul li').on('click', function() {
        		  roomId = parseInt($(this).find('.interId:eq(0)').text());
        		  console.log("目前抓到的roomId為:" + roomId);
        		  console.log("抓到:" + $('.roomList ul li:first-child').html());
        		  console.log("抓到2:" + $(this).html());
        		  console.log("抓到3:" + $(this).find('.interId:eq(0)').text());
        		  console.log("抓到4:" + $(this).find('.interId').length);
        		  $('.roomList ul li').removeClass("selected");
        		  $(this).addClass("selected");
        		  renderRoomTitle(roomId);
        		  readLocalMsgsByRoom(roomId,function(items) {
        			  renderRoomBody(items, true);
        		  });
        	  });
          });
      },
      recvHistoryMsg: function(_data) {
          console.log("收到歷史訊息");
          for (var i = 0; i < _data.messages.length; i++) {
              addMsg(_data.messages[i].time, _data.messages[i].time, _data.messages[i].room, _data.messages[i].from, _data.messages[i].type, _data.messages[i].content, _data.messages[i].send, _data.messages[i].read, function() {});
          }
          readLocalMsgsByRoom(roomId,function(items) {
        	  renderRoomBody(items, true);
          });
      },
      unregister: function() {
          console.log("使用者登出");
          if (!window.WebSocket) {
              return;
          }
          if (socket.readyState == WebSocket.OPEN) {
              var data = {
                  "act": "UNREGISTER",
                  "sessionId": settings.sessionId,
                  "userId": userId
              };
              socket.send(JSON.stringify(data));
              socket.close();
          } else {
        	  div.innerText = "Websocket連接沒有開啟！";
          }
      },
      sendMessage: function(_data) {
          console.log("送出新的訊息:" +_data.id +", "+ _data.content);
          // if (!window.WebSocket) {
          // return;
          // }
          addMsg(_data.time, _data.time, _data.room, _data.from, _data.type, _data.content, _data.send, _data.read, function() {});

          if (socket.readyState == WebSocket.OPEN) {
              var data = {
            	  "act": "SENDMESSAGE",
            	  "time": _data.time,
            	  "room":_data.room,
            	  "from": _data.from,
            	  "type": _data.type,
            	  "content": _data.content
              };
              socket.send(JSON.stringify(data));
          } else {
              div.innerText = "Websocket連接沒有開啟！";
          }
      },
      sendMessageAck: function(_data) {
          console.log("成功傳送的訊息:"+_data.id);
          
          // 標註已經成功傳送的訊息
          updateMsgAck(_data.id);
      },
      recvMessage: function(_data) {
          console.log("收到新的訊息:"+_data.id+", "+_data.content);
          // console.log(_data);
          addMsg(_data.id, _data.time, _data.room, _data.from, _data.type, _data.content, 1, _data.read, function() {});

      },
      sendFileMsg: function(time, userId, roomId, filename,
          fileUrl, fileSize) {
          if (!window.WebSocket) {
              return;
          }
          if (socket.readyState == WebSocket.OPEN) {
        	  
        	  var ext = filename.split('.').pop().toLowerCase();
        	  console.log("ext:" + ext);
        	  var content;
        	  var fileType;
        	  if (ext=='png' || ext=='jpg' || ext=='jpeg'|| ext=='gif') {
        		  fileType = 2;
        		  content = "<img src='"+fileUrl+"'  download='"+filename+"' draggable='false' class='messageBox__image'>";
        	      //content = "<a href='"+fileUrl+"' download='"+filename+"'>"+filename+"<br><div style='float:right;'>"+fileSize+"</div></a>";
               } else {
            	  fileType = 3;
            	  content = "<a href='"+fileUrl+"' download='"+filename+"'>"+filename+"<br><div style='float:right;'>"+fileSize+"</div></a>";
               } 
              var data= {
                  "act": "SENDFILEMESSAGE",
                  "time": time,
                  "from": userId,
                  "room": roomId,
                  "type": fileType,
                  "content" : content,
                  "fileName": filename,
                  "fileUrl": fileUrl,
                  "fileSize": fileSize,
              }; 
              
              socket.send(JSON.stringify(data));
          } else {
              alert("Websocket連接沒有開啟！");
          }
      },
      recvFileMsg: function(data) {
          // 獲取、構造參數
          console.log(data);          
      }
}

function renderRoomTitle(_roomId) {
	readLocalRooms(function(items) {
		if(items.length > 0){
			for(var idx in items) {
				if (items[idx].id == _roomId){
					$('.roomHead__title').html(items[idx].name + "(" + items[idx].members + ")");
				}
			}
		}
		else{
			renderRoomTitle(_roomId);
		}
	});
	
}

function renderRoomList(items, clear) {
	console.log(items);
	const roomBody = $('.roomList ul');
	if (clear)
		roomBody.empty();

	for(var idx in items) {
		var grpName = items[idx].name.length > 13 ? items[idx].name.substring(0, 14) + "..." : items[idx].name;
		var member = "(" + items[idx].members + ")";
		roomBody.append('<li><div class="liLeft"><img src="static/img/avatar/' + items[idx].url + '"><div class="liRight">'+
					  '<p class="roomInfo"><span class="interId hidden">' + items[idx].id + '</span><span class="interName">'+
					  '<i class="fa fa-exclamation-circle fa-lg"></i>' + grpName + " " + member + '</span><span class="interInfo"></span></p><p class="memo">' + 
					  '<span class="interId hidden">' + items[idx].id + '</span><span class="interName">放置MEMO地方' +
					  '</span><span class="interinfo"></span></p></div></div></li>');

	}
}

function renderRoomBody(items, clear) {
	const roomBody = $('#js-roomBody');
	if (clear)
		roomBody.empty();
	
	roomBody.append('<div class="top-search hidden"><input type="text" id="search_txt" class="form-control" placeholder="搜尋相關文字" >' +
					'<span class="glyphicon glyphicon-search" title="查詢"></span></div>');
	for(var idx in items) {
		var typeDiv;
		var time = getTimeString(items[idx].time).split(" ");		
		var sendDate = time[0];
		var sendTime = time[1];
		if (items[idx].type == 2){
			var src = items[idx].content.split("'  download")[0].split("src='")[1];
			
			typeDiv = '<div class="messageBox__image" data-src="' + src + '">';
		}	
		else{ 
			typeDiv = '<div class="messageBox__text">';
		}	
		if (items[idx].from==userId)
			roomBody.append('<div class="messageBox messageBox--self"><div class="messageBox__time"><span class="hint">' + sendDate + '</span>' +
				'<span class="hint">' + sendTime + '</span></div><div class="messageBox__content"><div class="messageBox__message">' +
				typeDiv + items[idx].content + '</div>' +
				'</div></div></div>');
		else {
			var fromUser = users.get(items[idx].from);
			roomBody.append('<div class="messageBox"><img src="./static/img/avatar/'+fromUser.url+'" draggable="false" class="messageBox__user">' +
				'<div class="messageBox__content"> <div class="messageBox__name">'+fromUser.name+'</div>' +
				'<div class="messageBox__message"> '+typeDiv+items[idx].content+'</div>' +
				'<div class="messageBox__readMore">顯示更多</div> </div></div><div class="messageBox__time"><span class="hint">' + sendDate + '</span>' +
				'<span class="hint">' + sendTime + '</span></div></div>');
			}
	}
	
	$(".messageBox__message").each(function(){
		$(this).lightGallery({selector: 'div.messageBox__image'});
	});
	//lightGallery({selector: 'div.messageBox__image'});
	//$(".messageBox__image img").ImageViewer();

	const roomBodya = document.querySelector('#js-roomBody');
	
	if (clear) roomBodya.scrollTop = roomBodya.scrollHeight;
	
	$(".roomBody").scroll(function () {
		var scrollTop = $(this).scrollTop();
		if(scrollTop <= 0){
			$(".top-search").addClass('hidden');
		}
		else{
			//$(".top-search").removeClass('hidden');
			$(".top-search").addClass('hidden');
		}
	}); 	
}

function resendUnsendMessage() {
	if(window.WebSocket){
        readLocalMsgsByUnsend(userId, function resend(_data) {
            if (_data.length>0) {
            	console.log("重新傳送訊息筆數:"+_data.length);
            	for(var idx in _data) {
            		ws.sendMessage({
            			"time": _data[idx].time,
	            		"from": _data[idx].from,
	            		"room": _data[idx].room,
	            		"type": _data[idx].type,
	            		"send": 0,
	            		"content": _data[idx].content
	            	});
            	}
            }
        });
	}
}

function openWebsocket() {
	if(!window.WebSocket){
		window.WebSocket = window.MozWebSocket;
	}
	if(window.WebSocket){
		socket = new ReconnectingWebSocket(settings.wsUrl, null, {debug: false, reconnectInterval: 10000});
		// socket = new WebSocket(settings.wsUrl);
		socket.onmessage = function(event){
			var json = JSON.parse(event.data);
			if (json.status == 200) {
				var act = json.data.act;
				console.log("收到一條新訊息，類型為：" + act);
				switch(act) {
					case "REGISTERACK":
						ws.registerAck(json.data);
						break;
					case "GETUSERINFOACK":
						console.log("收到:" + JSON.stringify(json.data));
						ws.recvUserInfo(json.data);
					    readLocalUsers(function() {});
						break;
					case "GETHISTORYMSGACK":
						ws.recvHistoryMsg(json.data);
						break;
					case "SENDMESSAGEACK":
						ws.sendMessageAck(json.data);
						break;
					case "RECVMESSAGE":
						ws.recvMessage(json.data);
						renderRoomBody([json.data], false);
						break;
					default:
						console.log("不正確的類型！" + act);
				}
			} else {
				// alert(json.msg);
				console.log(json.msg);
			}
		};

		// 連接成功1秒後，將用戶信息註冊到服務器在線用戶表
		socket.onopen = setTimeout(function RepeatingRegister(event){
			console.log("WebSocket已啟動！");
			ws.register();
            resendUnsendMessage();
			setTimeout(RepeatingRegister, 10000);
		}, 1000)

		socket.onclose = function(event){
			console.log("WebSocket已關閉...");
		};
		
		socket.onerror = function(event){
			console.log("WebSocket已錯誤...");
		};
	} 
	else {
		// alert("您的瀏覽器不支持WebSocket！");
	}
}

$('#js-message').keydown(function(e) {
    if (e.keyCode == 13) {
        $('.sendBtn').trigger('click');
        e.preventDefault(); // 屏蔽enter對系統作用。按後增加\r\n等換行
    }
});

$('.sendBtn').on('click',function(e) {
	const vm = this;
	const userName = document.querySelector('#js-userName');
	let message = document.querySelector('#js-message');
	// 如果是按住shift則不傳送訊息(多行輸入)
	if (e.shiftKey) {
		return false;
	}
	// 如果輸入是空則不傳送訊息
	if (message.value.length <= 1 && message.value.trim() == '') {
		// 避免enter產生的空白換行
		e.preventDefault();
		return false;
	}
	// 對firebase的db做push，db只能接受json物件格式，若要用陣列要先轉字串來存

	ws.sendMessage({
		"time": new Date().getTime(),
		"from": userId,
		"room": roomId,
		"type": 1,
		"send": 0,
		"content": message.value
	});
	// 清空輸入欄位並避免enter產生的空白換行
	message.value = '';

	readLocalMsgsByRoom(roomId,function(items) {
		console.log("傳輸後現有訊息數:" + items.length);
		renderRoomBody(items, true);
	});
	e.preventDefault();
});

function getQueryStringParam() {
	var searchString = window.location.search.substring(1);
	//
	searchString = decodeURIComponent(searchString);
	if (searchString.length > 0) {
		var data = searchString.split('&');
		if (data.length > 0) {
			for ( var i = 0; i < data.length; i++) {
				var temp = data[i].split('=');
				if (temp[0] == "userId") {
					// userId = parseInt(temp[1]) ;
					userId =   parseInt(temp[1]);
				}
				if (temp[0] == "userPwd") {
					userPwd =   temp[1];
				}
				if (temp[0] == "roomId") {
					roomId =   parseInt(temp[1]);
				}
				if (temp[0] == "userEmail") {
					userEmail =   temp[1];
				}
				if (temp[0] == "userLoc") {
					userLoc =   temp[1];
				}
			}
		}
	}
}


function getJSessionId(){
	var jsId = document.cookie.match(/JSESSIONID=[^;]+/);
	if(jsId != null) {
		if (jsId instanceof Array)
			jsId = jsId[0].substring(11);
		else
			jsId = jsId.substring(11);
	}
	return jsId;
}

function getTimeString(_ms) {
    const now = new Date(_ms);
    const months = (now.getMonth() < 9) ? '0' + (now.getMonth()+1) : (now.getMonth()+1);
    const dates = (now.getDate() < 10) ? '0' + now.getDate() : now.getDate();
    const hours = (now.getHours() < 10) ? '0' + now.getHours() : now.getHours();
    const minutes = (now.getMinutes() < 10) ? '0' + now.getMinutes() : now.getMinutes();
    const ampm = ''; // (now.getHours() <= 12) ? "下午" : "上午";
    return months+'/'+ dates+ ' ' +ampm + hours +':'+minutes;
}

function open1(_callback){
	if(!indexedDB) {
        alert("該瀏覽器不支援IndexedDB");
    } 
	else {
		var request = indexedDB.open('chatroom', 1);
		console.log(request)
		request.onerror = function(event) {
			console.log(event);
	        div.innerText = "IndexedDB資料庫開啟失敗"
	    };

	    request.onsuccess = function(event) {
	    	db = event.target.result;
	    	console.log(event);
	    	div.innerText = "資料庫開啟成功"
	    		_callback();
	    };

	    request.onupgradeneeded = function (event) {
	    	db = event.target.result;
	    	var objectStore;
	    	if (!db.objectStoreNames.contains('chatroom')) {
	    		objectStore = db.createObjectStore('messages', { keyPath: 'id' });
	    		var idx = objectStore.createIndex('i_time', 'time', {
	    			unique: false,
	    			multiEntry: false
	    		});
	    		var idx = objectStore.createIndex('i_id', 'id', {
	    			unique: false,
	    			multiEntry: false
	    		});
	    		var idx = objectStore.createIndex('i_room', 'room', {
	    			unique: false,
	    			multiEntry: false
	    		});
	    		var idx = objectStore.createIndex('i_from_send', ['from','send'], {
	    			unique: false,
	    			multiEntry: false
	    		});
	    		objectStore = db.createObjectStore('rooms', { keyPath: 'id' });
	    		var idx = objectStore.createIndex('i_owner', 'owner', {
	    			unique: false,
	    			multiEntry: false
	    		});
	    		objectStore = db.createObjectStore('users', { keyPath: 'id' });
	    		var idx = objectStore.createIndex('i_id', 'id', {
	    			unique: false,
	    			multiEntry: false
	    		});
	    		var idx = objectStore.createIndex('i_email', 'email', {
	    			unique: false,
	    			multiEntry: false
	    		});
	    	}
	    }

	    request.onblocked = function(event){
	    	console.log(onblocked);
	    }
	}
}

function close1() {
	db.close();
	div.innerText = "資料庫關閉";
}

function addRoom(_id, _owner, _name, _url, _memo, _members) {
	var request = db.transaction(['rooms'], 'readwrite')
	.objectStore('rooms')
	.add({ id: _id, owner: _owner, name: _name, url: _url, memo: _memo, members : _members });

	request.onsuccess = function (event) {
		// console.log('数据写入成功');
		div.innerText = '數據寫入成功';
	};

	request.onerror = function (event) {
		console.log('數據寫入失敗');
		div.innerText = '數據寫入失敗';
	}
}

function addUser(_id, _name, _url, _type, _email, _memo) {

  /*
	 * { msgId: 6, username: '張三', otherUsername: '王麻子', senderType: 1, 1-傳送發,
	 * 2-接收方 msgType: 1 , 1-文字資訊, 2-圖片, 3-語音 msgContent: 'xxxxxx', isRead: 1
	 * 1-未讀, 2-已讀
	 */
	var request = db.transaction(['users'], 'readwrite')
	.objectStore('users')
	.add({ id: _id, name: _name, url: _url, email: _email, memo: _memo, type : 0 });
	// .add({ id: new Date().getTime(), name: _param, age: 24, email:
	// 'zhangsan@example.com' });

	request.onsuccess = function (event) {
		// console.log('数据写入成功');
		div.innerText = '數據寫入成功';
	};

	request.onerror = function (event) {
		console.log('數據寫入失敗');
		div.innerText = '數據寫入失敗';
	}
}

function addMsg(_id, _time, _room, _from, _type, _content, _send, _read, _callback) {

	/*
	 * { msgId: 6, username: '張三', otherUsername: '王麻子', senderType: 1, 1-傳送發,
	 * 2-接收方 msgType: 1 , 1-文字資訊, 2-圖片, 3-語音 msgContent: 'xxxxxx', isRead: 1
	 * 1-未讀, 2-已讀
	 */
	var request = db.transaction(['messages'], 'readwrite')
	.objectStore('messages')
	// .put({ id: _id, time: new Date().getTime(), from: _from, to: _to,
	// content: _content, type: 1, email: 'zhangsan@example.com' });
	// .add({ id: new Date().getTime(), time: new Date().getTime(), from:
	// _from, to: _to, type:_type, content: _content });
	.put({ id: _id, time: _time, room:_room, from: _from, type:_type, content: _content, send: _send, read: _read });

	request.onsuccess = function (event) {
		// console.log('数据写入成功');
		div.innerText = '數據寫入成功';
		if (_callback!=null)
			_callback();
	};

	request.onerror = function (event) {
		console.log('數據寫入失敗');
		div.innerText = '數據寫入失敗';
	}
}

function getLocalUserByEmail(_email, _callback) {
	var store = db.transaction(['users'], 'readonly').objectStore('users');
	var index = store.index('i_email');
	var keyRange = IDBKeyRange.only(_email.toLowerCase());
	var lastUser = [];
	index.openCursor(keyRange).onsuccess = function(event) {
		var cursor = event.target.result;
		if (cursor) {
			if (!users.containsObj(cursor.value.id)) {
				users.put(cursor.value.id, { id: cursor.value.id, name: cursor.value.name, url: cursor.value.url, email: cursor.value.email, memo: cursor.value.memo});
			}
			if (cursor.value.id==userId){
				userName = cursor.value.name;
			}
			if (cursor.value.email==userEmail){
				userId = cursor.value.id;
				userName = cursor.value.name;
				userEmail = cursor.value.email;
			}
			lastUser = cursor.value;
			cursor.continue();
		} else {
			// console.log('已無法找到更多數據！');
			_callback(lastUser);
		}
	};
}

function readLocalUsers(_callback) {
	var objectStore = db.transaction(['users'], 'readonly').objectStore('users');
	objectStore.openCursor().onsuccess = function (event) {
		var cursor = event.target.result;
		if (cursor) {
			if (!users.containsObj(cursor.value.id)) {
				users.put(cursor.value.id, { id: cursor.value.id, name: cursor.value.name, url: cursor.value.url, email: cursor.value.email, memo: cursor.value.memo});
			}
			if (cursor.value.id==userId){
				userName = cursor.value.name;
			}
			if (cursor.value.email==userEmail){
				userId = cursor.value.id;
				userName = cursor.value.name;
				userEmail = cursor.value.email;
			}
			cursor.continue();
		} else {
			// console.log('已無法找到更多數據！');
			_callback();
		}
	};
}

function readLocalRooms(_callback) {
	var objectStore = db.transaction(['rooms'], 'readonly').objectStore('rooms');

	var items = [];
	objectStore.openCursor().onsuccess = function (event) {
		var cursor = event.target.result;
		if (cursor) {
			items.push(cursor.value);
			cursor.continue();
		} else {
			// console.log('已無法找到更多數據！');
			_callback(items);
		}
		console.log("讀取該個案聊天室數量為:" + items.length + " 個");
	};	
}

function updateMsgAck(_id, _callback) {
	var transaction = db.transaction(['messages'], 'readwrite');
	var store = transaction.objectStore('messages');
	store.openCursor(_id).onsuccess = function(event) {
		var cursor = event.target.result;
		if (cursor) {
			cursor.value.send = 1;
			store.put(cursor.value);
			cursor.continue();
		} else {
			// console.log("搜尋完成");
		}
	};
}

function update(_param, _callback) {
	var keyRange = IDBKeyRange.only(_param);
	var transaction = db.transaction(['chatroom'], 'readwrite');
	var store = transaction.objectStore('messages');
	var index = store.index('i_name');
	index.openCursor(onlyKeyRange).onsuccess = function(event) {
		var cursor = event.target.result;
		if (cursor) {
			cursor.value.isRead = 2;
			store.put(cursor.value);
			cursor.continue();
		} else {
			// console.log("搜尋完成");
		}
	};
}

function readLocalMsgsByRoom(_room, _callback) {
	var objectStore = db.transaction(['messages'], 'readonly').objectStore('messages');
	var keyRange = IDBKeyRange.only(_room);
	var items = [];
	div.innerText = "";
	var index = objectStore.index('i_room');
	index.openCursor(keyRange).onsuccess = function (event) {
		var cursor = event.target.result;
		if (cursor) {
			// console.log('id: ' + cursor.key);
			// console.log('time: ' + cursor.value.time);
			// console.log('from: ' + cursor.value.from);
			// console.log('room: ' + cursor.value.room);
			// console.log('content: ' + cursor.value.content);
			// console.log('---------------------');
			items.push(cursor.value);
			cursor.continue();
		} else {
			// console.log('已無法找到更多數據！');
			items.sort(function (a, b) {
				if (a.key > b.key) {
					return 1;
				}
				if (a.key < b.key) {
					return -1;
				}
				// a must be equal to b
				return 0;
			});

			_callback(items);
		}
	};
}

function readLocalMsgsByUnsend(_from,_callback) {
	var objectStore = db.transaction(['messages'], 'readonly').objectStore('messages');
	var keyRange = IDBKeyRange.only([_from,0]);
	var items = [];
	div.innerText = "";
	var index = objectStore.index('i_from_send');
	index.openCursor(keyRange).onsuccess = function (event) {
		var cursor = event.target.result;
		if (cursor) {
			// console.log('id: ' + cursor.key);
			// console.log('time: ' + cursor.value.time);
			// console.log('from: ' + cursor.value.from);
			// console.log('to: ' + cursor.value.to);
			// console.log('content: ' + cursor.value.content);
			if (cursor.value.send==0)
				items.push(cursor.value);
				cursor.continue();
		} else {
			_callback(items);
		}
	};
}

function searchSubstr(_param, _callback) {
	var keyRange = IDBKeyRange.bound(_param, _param + '\uffff');
	var transaction = db.transaction(['chatroom'], 'readonly');
	var store = transaction.objectStore('messages');
	var index = store.index('i_name');
	div.innerText = "";
	index.openCursor(keyRange).onsuccess = function(event) {
		var cursor = event.target.result;
		if (cursor) {
			// store.delete(cursor.value.msgId);
			// console.log('Id: ' + cursor.key);
			// console.log('Name: ' + cursor.value.name);
			// console.log('Age: ' + cursor.value.age);
			// console.log('Email: ' + cursor.value.email);

			div.innerText = div.innerText  +', Id: ' + cursor.key +',Name: ' + cursor.value.name;

			cursor.continue();
		} else {
			// console.log("搜尋完成");
			_callback();
		}
	};
}

function searchOnly(_param, _callback) {
	var keyRange = IDBKeyRange.only(_param);
	var transaction = db.transaction(['chatroom'], 'readonly');
	var store = transaction.objectStore('messages');
	var index = store.index('i_name');
	div.innerText = "";
	index.openCursor(keyRange).onsuccess = function(event) {
		var cursor = event.target.result;
		if (cursor) {
			// store.delete(cursor.value.msgId);
			// console.log('Id: ' + cursor.key);
			// console.log('Name: ' + cursor.value.name);
			// console.log('Age: ' + cursor.value.age);
			// console.log('Email: ' + cursor.value.email);

			div.innerText = div.innerText  +', Id: ' + cursor.key +',Name: ' + cursor.value.name;

			cursor.continue();
		} else {
			// console.log("遍歷完成");
			_callback(data);
		}
	};
}


function delByKey(_param, callback) {
	var transaction = db.transaction(['chatroom'], 'readwrite');
	var store = transaction.objectStore('messages');
	var request = store.delete(_param);
	transaction.oncomplete = function(e) {
		callback();
	};
}

function delByName(_param, _callback) {
	var keyRange = IDBKeyRange.only(_param);
	var transaction = db.transaction(['chatroom'], 'readwrite');
	var store = transaction.objectStore('messages');
	var index = store.index('i_name');
	index.openCursor(keyRange).onsuccess = function(event) {
		var cursor = event.target.result;
		if (cursor) {
			store.delete(cursor.value.id);
			cursor.continue();
		} else {
			// console.log("遍歷完成");
			// _callback(data);
		}
	};
}

// 删除資料庫
function deleteDB() {
	var deleteQuest = this.indexedDB.deleteDatabase("chatroom");
	deleteQuest.onerror = function () {
		console.log('删除資料庫出錯');
	};
	deleteQuest.onsuccess = function () {
		div.innerText = "删除資料庫成功";
	}
}


// 自定義數據結構：已發送用戶消息表
function DataMap() {
	this.elements = new Array();

	// 獲取MAP元素個數
	this.size = function() {
		return this.elements.length;
	};

	// 判斷MAP是否為空
	this.isEmpty = function() {
		return (this.elements.length < 1);
	};

	// 刪除MAP所有元素
	this.clear = function() {
		this.elements = new Array();
	};

	// 向MAP中增加元素（key, value)
	this.put = function(_key, _value) {
		this.elements.push({
			key: _key,
			value: _value
		});
	};

	// 刪除指定KEY的元素，成功返回True，失敗返回False
	this.removeByKey = function(_key) {
		var bln = false;
		try {
			for (i = 0; i < this.elements.length; i++) {
				if (this.elements[i].key == _key) {
					this.elements.splice(i, 1);
					return true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 刪除指定VALUE的元素，成功返回True，失敗返回False
	this.removeByValue = function(_value) { // removeByValueAndKey
		var bln = false;
		try {
			for (i = 0; i < this.elements.length; i++) {
				if (this.elements[i].value == _value) {
					this.elements.splice(i, 1);
					return true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 刪除指定VALUE的元素，成功返回True，失敗返回False
	this.removeByValueAndKey = function(_key, _value) {
		var bln = false;
		try {
			for (i = 0; i < this.elements.length; i++) {
				if (this.elements[i].value == _value &&
					this.elements[i].key == _key) {
					this.elements.splice(i, 1);
					return true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 獲取指定KEY的元素值VALUE，失敗返回NULL
	this.get = function(_key) {
		try {
			for (i = 0; i < this.elements.length; i++) {
				if (this.elements[i].key == _key) {
					return this.elements[i].value;
				}
			}
		} catch (e) {
			return false;
		}
		return false;
	};

	this.sort = function() {
		this.elements.sort();
	}

	// 獲取指定索引的元素（使用element.key，element.value獲取KEY和VALUE），失敗返回NULL
	this.element = function(_index) {
		if (_index < 0 || _index >= this.elements.length) {
			return null;
		}
		return this.elements[_index];
	};

	// 判斷MAP中是否含有指定KEY的元素
	this.containsKey = function(_key) {
		var bln = false;
		try {
			for (i = 0; i < this.elements.length; i++) {
				if (this.elements[i].key == _key) {
					bln = true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 判斷MAP中是否含有指定VALUE的元素
	this.containsValue = function(_value) {
		var bln = false;
		try {
			for (i = 0; i < this.elements.length; i++) {
				if (this.elements[i].value == _value) {
					bln = true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 判斷MAP中是否含有指定VALUE的元素
	this.containsObj = function(_key, _value) {
		var bln = false;
		try {
			for (i = 0; i < this.elements.length; i++) {
				if (this.elements[i].value == _value &&
					this.elements[i].key == _key) {
					bln = true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 獲取MAP中所有VALUE的數組（ARRAY）
	this.values = function() {
		var arr = new Array();
		for (i = 0; i < this.elements.length; i++) {
			arr.push(this.elements[i].value);
		}
		return arr;
	};

	// 獲取MAP中所有VALUE的數組（ARRAY）
	this.valuesByKey = function(_key) {
		var arr = new Array();
		for (i = 0; i < this.elements.length; i++) {
			if (this.elements[i].key == _key) {
				arr.push(this.elements[i].value);
			}
		}
		return arr;
	};

	// 獲取MAP中所有KEY的數組（ARRAY）
	this.keys = function() {
		var arr = new Array();
		for (i = 0; i < this.elements.length; i++) {
			arr.push(this.elements[i].key);
		}
		return arr;
	};

	// 獲取key通過value
	this.keysByValue = function(_value) {
		var arr = new Array();
		for (i = 0; i < this.elements.length; i++) {
			if (_value == this.elements[i].value) {
				arr.push(this.elements[i].key);
			}
		}
		return arr;
	};

	// 獲取MAP中所有KEY的數組（ARRAY）
	this.keysRemoveDuplicate = function() {
		var arr = new Array();
		for (i = 0; i < this.elements.length; i++) {
			var flag = true;
			for (var j = 0; j < arr.length; j++) {
				if (arr[j] == this.elements[i].key) {
					flag = false;
					break;
				}
			}
			if (flag) {
				arr.push(this.elements[i].key);
			}
		}
		return arr;
	};

	// 移除MAP中重覆KEY的數組（ARRAY）
	this.removeDataMapDuplicateKeys = function() {
		var arr = new DataMap();
		for (i = 0; i < this.elements.length; i++) {
			var flag = false;
			for (var j = 0; j < arr.size(); j++) {
				if (arr.elements[j].key == this.elements[i].key) {
					flag = true;
					break;
				}
			}
			if (!flag) {
				arr.put(this.elements[i].key, this.elements[i].value);
			}
		}

		this.elements = arr.elements;
		// return arr;
	};
}

function webrtc(){
	window.open("./webrtc.html?loc="+userLoc+"&name="+userName+"&room="+roomId, "_blank");
}


/*
 * // msgRef = firebase中的資料表/messages/，若沒有的會自動建立 const msgRef =
 * firebase.database().ref('/messages/'); const storageRef =
 * firebase.storage().ref('/images/'); default { // 指定此頁使用的name name:
 * 'ChatRoom', // 資料位置，於html中可用{{}}渲染出來 data() { return { hoverMessageId: null,
 * userName: '', // 名稱 messages: [], // 訊息內容 upload: false, // 上傳進度框 progress: '' //
 * 上傳進度%數 } }, // 這個頁面的functions methods: { //彈出設定視窗 setName() { const vm =
 * this; vm.userNameSet = true; }, // 儲存設定名稱 saveName() { //
 * vue的mtthod中this是指export中這整塊的資料 const vm = this; const userName =
 * document.querySelector('#js-userName').value; if (userName.trim() == '') {
 * return; } // 這裡的vm.userName(this.userName)就是data()裡面的userName vm.userName =
 * userName; vm.userNameSet = false; }, // 取得時間 getTime() { const now = new
 * Date(); const hours = now.getHours(); const minutes = now.getMinutes();
 * return `${(hours &gt;= 12) ? "下午" : "上午"} ${hours}:${(minutes &lt; 10) ? '0' +
 * minutes : minutes}`; }, // 傳送訊息 sendMessage(e) { const vm = this; const
 * userName = document.querySelector('#js-userName'); let message =
 * document.querySelector('#js-message'); // 如果是按住shift則不傳送訊息(多行輸入) if
 * (e.shiftKey) { return false; } // 如果輸入是空則不傳送訊息 if (message.value.length &lt;=
 * 1 &amp;&amp; message.value.trim() == '') { // 避免enter產生的空白換行
 * e.preventDefault(); return false; } //
 * 對firebase的db做push，db只能接受json物件格式，若要用陣列要先轉字串來存 msgRef.push({ userName:
 * userName.value, type: 'text', message: message.value, //
 * 取得時間，這裡的vm.getTime()就是method中的getTime timeStamp: vm.getTime() }) //
 * 清空輸入欄位並避免enter產生的空白換行 message.value = ''; e.preventDefault(); }, // 傳送圖片
 * sendImage(e) { const vm = this; const userName =
 * document.querySelector('#js-userName'); // 取得上傳檔案的資料 const file =
 * e.target.files[0]; const fileName = Math.floor(Date.now() / 1000) +
 * `_${file.name}`; const metadata = { contentType: 'image/*' }; // 取得HTML進度條元素
 * let progressBar = document.querySelector('#js-progressBar'); // 上傳資訊設定 const
 * uploadTask = storageRef.child(fileName).put(file, metadata); // 上傳狀態處理
 * uploadTask.on(firebase.storage.TaskEvent.STATE_CHANGED, // 上傳進度
 * function(snapshot) { let progress = Math.floor((snapshot.bytesTransferred /
 * snapshot.totalBytes) * 100); if (progress &lt; 100) { // 開啟進度條 vm.upload =
 * true; vm.progress = `${progress}%`; progressBar.setAttribute('style',
 * `width:${progress}%`); } }, // 錯誤處理 function(error) {
 * msgRef.child('bug/').push({ userName: userName.value, type: 'image', message:
 * error.code, timeStamp: vm.getTime() }) }, // 上傳結束處理 function() { var
 * downloadURL = uploadTask.snapshot.downloadURL; msgRef.push({ userName:
 * userName.value, type: 'image', message: downloadURL, timeStamp: vm.getTime() }) //
 * 關閉進度條 vm.upload = false; }); }, // 刪除訊息 deleteMessage(id) { const message =
 * msgRef.child(id) message.remove() }, //顯示更多 readMore(e) { // 把內容高度限制取消
 * e.target.previousElementSibling.setAttribute('style', 'max-height: 100%;') //
 * 隱藏"顯示更多"按紐 e.target.setAttribute('style', 'display: none;'); } }, //
 * mounted是vue的生命週期之一，代表模板已編譯完成，已經取值準備渲染元件了 mounted() { const vm = this;
 * msgRef.on('value', function(snapshot) { const val = snapshot.val(); const
 * messageData = val ? Object.keys(val).map(key =&gt; ({ id: key, ...val[key]
 * })) : null vm.messages = messageData; }) }, // update是vue的生命週期之一，在元件渲染完成後執行
 * updated() { // 判斷內容高度超過300就隱藏起來，把"顯示更多"按紐打開 const messages =
 * document.querySelectorAll('.messageBox__message'); messages.forEach((message)
 * =&gt; { if (message.offsetHeight &gt; 300) {
 * message.querySelector('.messageBox__readMore').setAttribute('style',
 * 'display: block'); } }) // 當畫面渲染完成，把聊天視窗滾到最底部(讀取最新消息) const roomBody =
 * document.querySelector('#js-roomBody'); roomBody.scrollTop =
 * roomBody.scrollHeight; }
 */
