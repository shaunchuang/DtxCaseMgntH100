var userID;
var logList; 
var cookie_cid;
var cookie_name;
var cookie_contact;

function main_init(menupath){ 
    userID = getCookie('account');
    var getLoginInfo = getCookie("companyInfo");
    if(getLoginInfo != null){
        var parts = getLoginInfo.split("/");
        cookie_cid = parts[0];
        cookie_name = parts[1];
        cookie_contact = parts[2];
    }
    //
    $('#navbar_menu').load(menupath, function() {
        init_menu();
    });
    //   
    $('#footer_Content').load('template/footer.html');
}

function openPage(menu_obj) {
    var menu_id = $(menu_obj).parent().attr('id');
    $.cookie('menu_id', menu_id, { path: '/' });
}

function toggleMenuShow(menu_id) {
    var menu_obj = $("#" + menu_id);
    if (menu_obj != null) {
        menu_obj.addClass("active");
    }
}
    
function init_menu(){
    if($.cookie('menu_id') == undefined){
        return;
    }
    else{
        var menu_id = $.cookie('menu_id');
        toggleMenuShow(menu_id);
    }
}

function logout() {
    eraseCookie('account');
    eraseCookie('companyInfo');
    document.location = "index.html";
    /*getLogInfoByAccount (userID,function(json) {
        logList = json;
        setLogoutTime();
    });*/
}

function setLogoutTime(){
    //最新一筆登入資訊之登入時間
    var loginTime = logList.loginTime; 
    var loginYear = loginTime.split("-")[0];  
    var loginMonth = loginTime.split("-")[1];
    var loginDate = loginTime.split("-")[2];
    var time = loginTime.split("-")[3];
    var loginHour = time.split(":")[0];
    var loginMin = time.split(":")[1];
    var loginSec = time.split(":")[2];
	
    //抓取登出時間
    var timeNow = new Date();
    var logoutYear = timeNow.getFullYear();
    var logoutMonth = (timeNow.getMonth()+1<10 ? '0' : '') + (timeNow.getMonth()+1);
    var logoutDate = (timeNow.getDate()<10 ? '0' : '') + timeNow.getDate();
    var logoutHour = (timeNow.getHours()<10 ? '0' : '') + timeNow.getHours();
    var logoutMin = (timeNow.getMinutes()<10 ? '0' : '') + timeNow.getMinutes();
    var logoutSec = (timeNow.getSeconds()<10 ? '0' : '') + timeNow.getSeconds(); 
    var logoutTime = logoutYear +'-'+ logoutMonth +'-'+ logoutDate +'-'+ logoutHour +':'+ logoutMin +':'+ logoutSec;

    var Date_A = new Date(loginYear,loginMonth,loginDate,loginHour,loginMin,loginSec);    
    var Date_B = new Date(logoutYear,logoutMonth,logoutDate,logoutHour,logoutMin,logoutSec);    
    var Date_C = new Date(Date_B - Date_A);

    var LoginInfo = logList;
    LoginInfo.logoutTime = logoutTime;
    LoginInfo.duration = Math.floor(Date_C.getTime() / 3600000) + "小時 " + Date_C.getUTCMinutes() + "分 " + Date_C.getUTCSeconds() + "秒";

    editLogInfo (LoginInfo, function(json) {
        setTimeout("turnback();", 500);
    });
}

function turnback(){
    document.location = "login.html?back_url=" + window.location.pathname;
}

function changePassword(){
    document.location = "password.html";
}

function loadData(){
    getAllCityName();
    $('.afterLogin').removeClass('hidden');
    main_init("template/menu.html");
}

function loadReplyData(){    
    $('.afterLogin').removeClass('hidden');
    main_init("template/menu.html");
    getReplyList();
}

function loadMessageData(){    
    $('.afterLogin').removeClass('hidden');
    main_init("template/menu.html");
    getMessageList();
}

function isLogin(){
    $('.afterLogin').removeClass('hidden');
    main_init("template/menu.html");
}

function backLogin(){
    $('.beforeLogin').html('<span>帳號尚未登入<br/>您無任何權限可使用此網頁</span>');
    $('.beforeLogin').removeClass('hidden');
    main_init("template/menu.html");    
    setTimeout(function(){
        document.location = 'login.html';
    }, 1500); 
}

function redirect(){
    $('.isLogin').html('<span>目前已登入<br/>系統三秒後將導至首頁</span>');
    $('.isLogin').removeClass('hidden');
    main_init("template/menu.html");
    setTimeout(function(){
        document.location = 'index.html';
    }, 3000); 
}

function showLogin(){
    var remember = getCookie('remember');
    $('.isNotLogin').removeClass('hidden');
    main_init("template/menu.html");
    if (remember == 'true'){
        $( "#rememberMe").prop('checked', true);
        var originAccount = getCookie('originAccount');
        $("#user").val(originAccount);
    }
}

function hideRegister(){
    $('.isLogin').html('<span>登入狀態無法註冊<br/>系統三秒後將導至首頁</span>');
    $('.isLogin').removeClass('hidden');   
    main_init("template/menu.html");
    setTimeout(function(){
        document.location = 'index.html';
    }, 3000);
}

function goRegister(){
    $('.isNotLogin').removeClass('hidden');
    getAllCityName();
    main_init("template/menu.html");   
}



