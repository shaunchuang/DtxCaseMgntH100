<#--<#import "/META-INF/spring.ftl" as spring />
<#import "/META-INF/mspring.ftl" as mspring />-->
<#import "/util/spring.ftl" as spring />
<#include "../widget/header.ftl" /> 

<script type="text/javascript" src="${base}/script/security/tripledes.js"></script>
<script type="text/javascript" src="${base}/script/security/mode-ecb-min.js"></script>
<script type="text/javascript" src="${base}/script/security/utils.js"></script>
<script type="text/javascript" src="${base}/script/imas/sweetalert.min.js"></script>

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
			<form id="login-form" class="form">
				<h1>DTx 個案管理平台</h1>
				<h4>醫療人員登入專用</h4>
				<#if testPageUrl??>  <#--依附於此專案的測試入口若存在於option table，預設存取WG DB--> 
	        		<div class="form-group">
			          	<select name="location" id="location" class="form-control">		          		
						    <option value="YT">${field_name}</option>
						</select>
		          	</div>
		        </#if>
		        <div class="form-group has-feedback">
		            <input name="account" id="account" class="form-control" placeholder="<@spring.message "login.placeholder.account"/>" type="text" validate='{required:true, messages:{required:"請輸入帳號"}}'>
		            <span class="glyphicon glyphicon-user form-control-feedback"></span>
	          	</div>
	          	<div class="form-group has-feedback">
		            <input name="password" id="password" class="form-control" placeholder="<@spring.message "login.placeholder.password"/>" type="password" validate='{required:true, chrnum:true, minlength:6, messages:{required:"請輸入密碼", minlength:"密碼長度必須大於{0}個字符"}}'>
		            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
	          	</div>
				<div class="form-group has-feedback captcha-group">
					<input name="captcha" id="captcha" class="form-control captcha-input" placeholder="請輸入驗證碼" type="text">
					<a href="javascript:void(0);" onclick="reloadCaptcha()" class="refresh-btn">
						<i class="fa fa-refresh"></i>
					</a>
					<img id="validateCodeImg" src="/security/api/captcha" onclick="reloadCaptcha()" class="captcha-img">
				</div>


     	
		      	<button type="button" id="login-btn" class="btn btn-primary btn-flat"><@spring.message "login.button.loginbtn"/></button>
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
<style>
.captcha-group {
  width: 250px; /* 讓整組跟其他輸入框一樣寬 */
  display: flex;
  align-items: center;
  justify-content: space-between; /* 三個元素平均分配 */
  margin: 0 auto 10px auto; /* 跟上面的輸入框一樣置中 */
}

/* 驗證碼輸入框 */
.captcha-input {
  flex: 1; /* 自動撐開剩餘空間 */
  height: 38px;
  padding-left: 10px !important;
  font-size: 16px;
  margin-right: 8px;
  margin-bottom: 0px !important;
  width: 140px !important;
}

/* refresh 按鈕 */
.refresh-btn {
  width: 34px;
  height: 34px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 8px;
  margin-left: 8px;
  text-decoration: none;
  cursor: pointer;
}

/* 驗證碼圖片 */
.captcha-img {
  height: 34px;
  width: 80px; /* 固定一個合理寬度，不然圖片會隨便變形 */
  object-fit: cover;
  border: 1px solid #ccc;
  border-radius: 5px;
  cursor: pointer;
}
</style>

<script type="text/javascript">

	function reloadCaptcha() {
        document.getElementById("validateCodeImg").src = "/security/api/captcha?" + new Date().getTime();
    }
	
	$("#account").focus();


	$("#login-btn").on("click", function() {
		
		var language = $('#langSelect').val();
		document.cookie = "_freemarker_lang=" + language + "; path=/; max-age=" + (60*60*24*30) + ";"
		console.log('language', language);
		console.log('account', $("#account").val().trim());
		console.log('password', $("#password").val().trim());
		console.log('captcha', $("#captcha").val().trim());

        $.ajax({
            url: "/security/api/login",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ 
                account: $("#account").val().trim(), 
                password: $("#password").val().trim(), 
                captcha: $("#captcha").val().trim(),
				location: "imas"
            }),
            dataType: "json",
            success: function(data) {
				console.log('data success:')
                if (data.success) {
					console.log("login success");
					if(data.casePlatform && data.casePlatform == "toInfoComplete") {
						swal({
							title: '登入成功', 
							type: 'success',
							timer: 1500,
							showConfirmButton: false
						}, function() {
							window.location.href = "/ftl/casetraining/infoComplete";
						});
					} else if(data.casePlatform && data.casePlatform == "infoCompleted") {
						swal({
							title: '登入成功', 
							type: 'success',
							timer: 1500,
							showConfirmButton: false
						}, function() {
							window.location.href = "/ftl/casetraining/caseDashboard";
						});
					} else {
						swal({
							title: '登入成功', 
							type: 'success',
							timer: 1500,
							showConfirmButton: false
						}, function() {
							window.location.href = "/ftl/imas/dashboard";
						});
					}
                } else {
					swal({title: '登入失敗',type: 'error'}, function() {
						window.location.href = "/ftl/imas/login"; 
					});
                }
            },
            error: function(xhr, status, error) {
                console.log("xhr", xhr);
                console.log("status", status);
                console.log("error", error);

            }
        });
    });
</script>

<#include "../widget/footer.ftl" />