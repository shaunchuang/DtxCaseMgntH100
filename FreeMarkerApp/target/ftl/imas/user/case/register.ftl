<#import "/META-INF/spring.ftl" as spring />
<#import "/META-INF/mspring.ftl" as mspring />
<#include "../../widget/header.ftl" /> 

<script type="text/javascript" src="${base}/script/security/tripledes.js"></script>
<script type="text/javascript" src="${base}/script/security/mode-ecb-min.js"></script>
<script type="text/javascript" src="${base}/script/security/utils.js"></script>
<script type="text/javascript" src="${base}/script/imas/sweetalert.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/utility.js?${.now}"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>

<link href="${base}/style/imas/widget/sweetalert.css" rel="stylesheet" type="text/css">

<style>
.main-header{
	position: unset;
}

.main-footer{
	padding: 10px 0;
}

.skin-blue .main-header .navbar{
	display: flex;  /*移除語言列補上*/
	align-items: center;  /*移除語言列補上*/
	background: #f2f2f2;
	min-height: 0;
	height: 50px;
	padding: 5px 0;
}

.skin-blue .main-header .navbar .nav>li>a{
	color: #595959;
}

.wrapper{
	background: #50a3a2;
	background: -webkit-linear-gradient(top left, #50a3a2 0%, #53e3a6 100%);
	background: -moz-linear-gradient(top left, #50a3a2 0%, #53e3a6 100%);
	background: -o-linear-gradient(top left, #50a3a2 0%, #53e3a6 100%);
	background: linear-gradient(to bottom right, #50a3a2 0%, #53e3a6 100%);
	position: absolute;
	left: 0;
	margin: 10px 0;
	width: 100%;
	max-height: 100%;
	height: calc(100% - 94px);
	min-height: 0 !important;
	overflow: hidden;
	
	&.form-success{
		.container{
			h1{
				transform: translateY(85px);
			}
		}
	}
}

.main-container{
	max-width: 600px;
	margin: 0 auto;
	padding: 30px 0;
	text-align: center;
	
	h1{
		font-size: 40px;
		transition-duration: 1s;
		transition-timing-function: ease-in-put;
		font-weight: 600;
		color: #ffffff;
		text-shadow: #737373 0.05em 0.05em 0.05em;
		margin-bottom: 15px;
	}
	
	h4{
		font-size: 20px;
		transition-duration: 1s;
		transition-timing-function: ease-in-put;
		font-weight: 600;
		color: #ffffff;
		text-shadow: #737373 0.05em 0.05em 0.05em;
		margin-bottom: 10px;
	}
}

form{
	padding: 15px 0;
	position: relative;
	z-index: 2;
	font-size: 16px;
	font-weight: 600;
	
	.form-control{
		display: block;
		width: 250px;
		font-size: 16px;
		font-weight: 500;
		text-align: left;
		margin: 0 auto 10px auto;
	}
	
	input.form-control{
		padding-left: 35px;
		padding-right: 0 !important;
	}
	
	span{
		left: 175px;
	}
	
	.form-group input[name='validateCode'], .form-group div{
		display: inline;
	}
	
	.form-group input[name='validateCode']{
		width: 158px;
	}
	
	#validateCode{
		height: 30px;
		margin-top: -5px;
	}
	
	.fa-refresh, .fa-refresh:hover{
		color: #ffffff;
		text-shadow: #737373 0.05em 0.05em 0.05em;
	}
	
	button{
		appearance: none;
		outline: 0;
		background-color: white;
		border: 0;
		padding: 10px 15px;
		color: @prim;
		border-radius: 5px !important;
		width: 250px;
		height: 2.5em !important;
		cursor: pointer;
		font-size: 16px !important;
		font-weight: 600 !important;
		transition-duration: 0.25s;
		
		&:hover{
			background-color: rgb(245, 247, 249);
		}
	}
}

.bg-bubbles{
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	
	li{
		position: absolute;
		list-style: none;
		display: block;
		width: 60px;
		height: 60px;
		background-color: rgba(255, 255, 255, 0.15);
		bottom: -160px;
		
		-webkit-animation: square 10s infinite;
		animation:         square 10s infinite;
		
		-webkit-transition-timing-function: linear;
		transition-timing-function: linear;
		
		&:nth-child(1){
			left: 10%;
		}
		
		&:nth-child(2){
			left: 20%;
			
			width: 100px;
			height: 100px;
			
			animation-delay: 2s;
			animation-duration: 17s;
		}
		
		&:nth-child(3){
			left: 25%;
			width: 50px;
			height: 50px;
			
			animation-delay: 2s;
			animation-duration: 25s;
			background-color: rgba(255, 255, 255, 0.3);
		}
		
		&:nth-child(4){
			left: 40%;
			width: 80px;
			height: 80px;
			
			animation-duration: 22s;
			
			background-color: rgba(255, 255, 255, 0.15);
		}
		
		&:nth-child(5){
			left: 70%;
		}
		
		&:nth-child(6){
			left: 80%;
			width: 120px;
			height: 120px;
			
			animation-delay: 3s;
			background-color: rgba(255, 255, 255, 0.2);
		}
		
		&:nth-child(7){
			left: 32%;
			width: 150px;
			height: 150px;
			
			animation-delay: 7s;
		}
		
		&:nth-child(8){
			left: 55%;
			width: 70px;
			height: 70px;
			
			animation-delay: 15s;
			animation-duration: 30s;
		}
		
		&:nth-child(9){
			left: 90%;
			width: 160px;
			height: 160px;
			
			animation-delay: 8s;
		}
	}
}

@-webkit-keyframes square {
  0%   { transform: translateY(0); }
  100% { transform: translateY(-700px) rotate(600deg); }
}

@keyframes square {
  0%   { transform: translateY(0); }
  100% { transform: translateY(-700px) rotate(600deg); }
}
</style>

<div class="wrapper">
	<div class="main-container">			
		<form id="registrationForm" action="${base}/doRegister" method="post" class="form">
			<h1>個案註冊</h1>
			<h4>會員手機驗證</h4>
	        <div class="form-group has-feedback">
	            <input name="name" id="name" class="form-control" placeholder="<@spring.message "login.placeholder.name"/>" type="text" validate='{required:true, messages:{required:"請輸入個案姓名"}}'>
	            <span class="glyphicon glyphicon-user form-control-feedback"></span>
          	</div>
          	<div class="form-group has-feedback">
	            <input name="telCell" id="userData.telCell" class="form-control" placeholder="<@spring.message "login.placeholder.mobile"/>" type="text" validate='{required:true, messages:{required:"請輸入手機號碼"}}'>
	            <span class="glyphicon glyphicon-phone form-control-feedback"></span>
          	</div>
          	<div class="form-group has-feedback">
	            <input name="password" class="form-control" placeholder="<@spring.message "login.placeholder.newpass"/>" type="password" validate='{required:true, chrnum:true, minlength:6, messages:{required:"請輸入密碼", minlength:"密碼長度必須大於{0}個字符"}}'>
	            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          	</div>
          	<div class="form-group has-feedback">
	          	<div class="g-recaptcha" data-sitekey="6LfaPPwpAAAAAG7mgMoUw_qP30NAMjpQHpfXc2xa"></div>
          	</div>          	
	      	<button type="submit" class="btn btn-primary btn-flat" ><@spring.message "login.button.registerbtn"/></button>
	    </form>
	</div>
	
	<ul class="bg-bubbles">
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
	</ul>
</div>
<script type="text/javascript">
	
	$(document).ready(function(){
		<#if SPRING_SECURITY_LAST_EXCEPTION?has_content>
			swal('登入失敗', '${SPRING_SECURITY_LAST_EXCEPTION.message}', 'error');
		</#if>
	});

	$('#registrationForm').submit(function(event) {
        event.preventDefault();
        var recaptchaResponse = grecaptcha.getResponse();
        if (recaptchaResponse.length == 0) {
            swal("尚未驗證",'請驗證您不是機器人', "error");
            return false;
        }
        
        var formDataArr = $(this).serializeArray();
        var info = {};
        
        formDataArr.forEach(function(item) {
	        info[item.name] = item.value;
	    });
               	
		var result = wg.evalForm.getJson({"data":JSON.stringify(info)}, $(this).attr('action'));
		if(result.success){
			successToDirect("註冊完成", result.message, "success", 1500, "${base}/case/login");
		}else{
			swal("註冊失敗", result.message, "error");
		}

        /*$.ajax({
            url: $(this).attr('action'),
            method: $(this).attr('method'),
            data: $(this).serialize(),
            success: function(response) {
            	swal("註冊完成", "註冊成功", "success");
                console.log(response);
            },
            error: function(xhr, status, error) {
                // 處理錯誤
            }
        });*/
    });
	
 	function escapeFrame() {
	    if (window.top.location.href != window.location.href) {
	        window.top.location.reload();
	    }
	}
	
	function changeImg() {
	    var img = document.getElementById('validateCode');
	    img.src = "${base}/common/validateCode?" + Math.random();
	    img.style.visibility = "visible";
	    img.style.backgroundColor = "black";
	}
	
	function getUrlParam(sParam) {
	    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
	        sURLVariables = sPageURL.split('&'),
	        sParameterName,
	        i;
	
	    for (i = 0; i < sURLVariables.length; i++) {
	        sParameterName = sURLVariables[i].split('=');
	
	        if (sParameterName[0] === sParam) {
	            return sParameterName[1] === undefined ? true : sParameterName[1];
	        }
	    }
	}
	
	$("#email").focus();
	escapeFrame();

</script>

<#include "../../widget/footer.ftl" />