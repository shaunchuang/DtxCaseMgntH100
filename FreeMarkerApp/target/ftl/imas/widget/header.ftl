<!DOCTYPE html>
<html>
  <head>
 	<meta http-equiv="Content-Type" content="text/html; CHARSET=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">    
    <meta name="description" content="${description!""}" />
	<meta name="keywords" content="${keyword!""}" />	
	<title>${blogname}<#if subname??>｜${subname}</#if></title>
	<link rel="icon" href="${base}/images/favicon.ico" type="image/x-icon">
	<link rel="alternate" type="application/rss+xml" href="${base}/rss.xml" title="${blogname}" />
	<link rel="alternate" type="application/atom+xml" href="${base}/atom.xml" title="${blogname}" />
	<link rel="author" href="https://www.facebook.com/"/>

	<meta http-equiv="X-UA-Compatible" content="IE=edge"> 	
    

	
    
    <#--  bbbb -->
	
    <script src="${base}/AdminLTE/plugins/jQuery/jQuery-2.2.0.min.js"></script> 

    <!-- FontAwesome 4.3.0 -->
    <link href="${base}/style/font-awesome-4.3.0/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Ionicons 2.0.0 -->
    <link href="${base}/style/ionicons/ionicons.min.css" rel="stylesheet" type="text/css">
    <!-- Theme style -->
    <link href="${base}/AdminLTE/dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="${base}/AdminLTE/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="${base}/AdminLTE/plugins/iCheck/all.css" rel="stylesheet" type="text/css" />
    <!-- Morris chart -->
    <link href="${base}/AdminLTE/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
    <!-- jvectormap -->
    <link href="${base}/AdminLTE/plugins/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
    <!-- Date Picker -->
    <#--<link href="${base}/AdminLTE/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />-->
    <!-- Daterange picker -->
    <link href="${base}/AdminLTE/plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
    <!-- bootstrap wysihtml5 - text editor -->
    <link href="${base}/AdminLTE/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="${base}/AdminLTE/plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- jQuery UI 1.11.4 -->
    <script type="text/javascript" src="${base}/script/timepicker/jquery.ui.datepicker-zh-TW.js" ></script>
    <link href="${base}/AdminLTE/plugins/jQueryUI/jquery-ui-1.11.4.css" rel="stylesheet" type="text/css" />    
    <script src="${base}/AdminLTE/plugins/jQueryUI/jquery-ui.js"></script>
	
	<#-- jquery-ui timepicker -->
	<link href='${base}/script/timepicker/jquery-ui-timepicker-addon.min.css' rel= 'stylesheet' >
	<script type="text/javascript" src="${base}/script/timepicker/jquery-ui-timepicker-addon.min.js" ></script>
	<script type='text/javascript' src='${base}/script/timepicker/jquery-ui-sliderAccess.js'></script>
	<script type="text/javascript" src="${base}/script/timepicker/jquery-ui-timepicker-zh-TW.js"></script>

	<#-- jquery multiselect -->
	<link rel="stylesheet" type="text/css" href="${base}/script/jquery-multiselect/jquery.multiselect.css">
	<script type="text/javascript" src="${base}/script/jquery-multiselect/src/jquery.multiselect.min.js"></script> 
	<link rel="stylesheet" type="text/css" href="${base}/script/jquery-multiselect/jquery.multiselect.filter.css">
	<script type="text/javascript" src="${base}/script/jquery-multiselect/src/jquery.multiselect.filter.js"></script>

    <!-- Bootstrap 3.3.4 -->
    <link href="${base}/AdminLTE/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />    
    <!-- Bootstrap 3.3.2 JS -->
    <script src="${base}/AdminLTE/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
      $.widget.bridge('uibutton', $.ui.button);
    </script>
    
    <!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>  -->     
    <script src="${base}/AdminLTE/plugins/morris/morris.min.js" type="text/javascript"></script>
	
	<!-- ChartJs -->
	<script src="${base}/AdminLTE/plugins/Chart.js" type="text/javascript"></script>
    <!-- Sparkline -->
    <script src="${base}/AdminLTE/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
    <!-- jvectormap -->
    <script src="${base}/AdminLTE/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
    <script src="${base}/AdminLTE/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
    <!-- jQuery Knob Chart -->
    <script src="${base}/AdminLTE/plugins/knob/jquery.knob.js" type="text/javascript"></script>
    <!-- daterangepicker -->
    <script src="${base}/script/moment/moment.min.js" type="text/javascript"></script>
    <script src="${base}/AdminLTE/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
    <!-- datepicker -->
    <#--
    <script src="${base}/AdminLTE/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="${base}/AdminLTE/plugins/datepicker/locales/bootstrap-datepicker.zh-TW.js" type="text/javascript"></script>
    -->
    <!-- Bootstrap WYSIHTML5 -->
    <script src="${base}/AdminLTE/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
    <!-- Slimscroll -->
    <script src="${base}/AdminLTE/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <#--
    <!-- FastClick END>
    <script src='${base}/AdminLTE/plugins/fastclick/fastclick.min.js'></script>
    -->
    <!-- iCheck -->
    <script src="${base}/AdminLTE/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <!-- InputMask -->
    <script src="${base}/AdminLTE/plugins/input-mask/jquery.inputmask.js" type="text/javascript"></script>
    <script src="${base}/AdminLTE/plugins/input-mask/jquery.inputmask.date.extensions.js" type="text/javascript"></script>
    <script src="${base}/AdminLTE/plugins/input-mask/jquery.inputmask.extensions.js" type="text/javascript"></script>
    <!-- fullCalendar ->  
    <!--
	<link href="${base}/AdminLTE/plugins/fullcalendar/fullcalendar.css" rel='stylesheet' />
	<link href="${base}/AdminLTE/plugins/fullcalendar/fullcalendar.print.css" rel='stylesheet' media='print' />    
	<script type="text/javascript" src="${base}/AdminLTE/plugins/fullcalendar/fullcalendar.js?${.now}"></script>
	-->
	<!-- fullCalendar 2.2.5-->
	<script type="text/javascript" src="${base}/script/fullcalendar/fullcalendar.js?${.now}"></script>
	<link href="${base}/script/fullcalendar/fullcalendar.css" rel='stylesheet' />
	<link href="${base}/script/fullcalendar/fullcalendar.print.css" rel='stylesheet' media='print' />    
  
	
    <!-- date-range-picker -->
    <script src="${base}/AdminLTE/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
    
    <!-- Bootstrap date time picker -->
    <#--
    <script src="${base}/script/datetimepicker/bootstrap-datetimepicker.js" type="text/javascript"></script>
    <script src="${base}/script/datetimepicker/locales/bootstrap-datetimepicker.zh-TW.js" type="text/javascript"></script>
    <link href="${base}/script/datetimepicker/bootstrap-datetimepicker.css" rel="stylesheet"/>
    -->
    
    <!-- Bootstrap Color Picker -->
    <link href="${base}/AdminLTE/plugins/colorpicker/bootstrap-colorpicker.min.css" rel="stylesheet"/>
    
    <!-- Bootstrap time Picker -->
    <#--
    <link href="${base}/AdminLTE/plugins/timepicker/bootstrap-timepicker.min.css" rel="stylesheet"/>   
    <script src="${base}/AdminLTE/plugins/timepicker/bootstrap-timepicker.min.js" type="text/javascript"></script>
   -->
   
    <!-- bootstrap color picker -->
    <script src="${base}/AdminLTE/plugins/colorpicker/bootstrap-colorpicker.min.js" type="text/javascript"></script>
      <!-- city area -->
    <script type="text/javascript" src="${base}/script/cityArea/cityArea.js?${.now}"></script>
    <!--highcharts模組-->
    <#--
	<script type="text/javascript" src="${base}/script/highcharts/highstock.js"></script> 		
	<script type="text/javascript" src="${base}/script/highcharts/highcharts-3d.js"></script>
	<script type="text/javascript" src="${base}/script/highcharts/modules/exporting.js"></script>	
	-->
	<script type="text/javascript" src="${base}/script/ppm/cloud.js"></script>
	<!--PPM模組-->
	<link rel="stylesheet" href="${base}/script/jquery-file-upload/jquery.fileupload.css">
	<script src="${base}/script/jquery-file-upload/jquery.iframe-transport.js"></script>
	<script src="${base}/script/jquery-file-upload/jquery.fileupload.js"></script>
    <!-- AdminLTE App -->
    <script src="${base}/AdminLTE/dist/js/app.min.js" type="text/javascript"></script>    
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <!--<script src="${base}/AdminLTE/plugins/dist/js/pages/dashboard.js" type="text/javascript"></script>-->    
    <!-- AdminLTE for demo purposes -->
    <script src="${base}/AdminLTE/dist/js/demo.js" type="text/javascript"></script>
    
    <!--mlog-->
	<script type="text/javascript" src="${base}/script/mlog.form.js"></script>
	<script type="text/javascript" src="${base}/script/mlog.dialog.js"></script>
	<script type="text/javascript" src="${base}/script/mlog.calendar.js?${.now}"></script>
	<script type="text/javascript" src="${base}/script/mlog.autocomplete.js?${.now}"></script>
	<script type="text/javascript" src="${base}/script/mlog.datatable.js?${.now}"></script>
	<script type="text/javascript" src="${base}/script/mlog.chart.js"></script>
	<script type="text/javascript" src="${base}/script/mlog.utils.js"></script>
	<script type="text/javascript" src="${base}/script/mlog.stat.js"></script>
	<script type="text/javascript" src="${base}/script/custom.js"></script>
	<script type="text/javascript" src="${base}/script/mlog.editor.js"></script>
	
	<#-- kind editor -->
	<script type="text/javascript" src="${base}/script/kindeditor/kindeditor.js" charset="utf-8"></script>
	
	<#-- dataTables -->
	<!-- <link rel=" stylesheet" type="text/css" href="${base}/script/jquery-dataTable/dataTables.css">  -->
	<!-- <script type="text/javascript" src="${base}/script/jquery-dataTable/1.10.0/js/jquery.dataTables.min.js" ></script>  -->		
    <link href="${base}/AdminLTE/plugins/datatables/jquery.dataTables.css" rel="stylesheet"/>
    <script src="${base}/AdminLTE/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
	
	<#-- jquery validate -->
	<script type="text/javascript" src="${base}/script/jquery-validation/jquery.validate.js"></script>
	<script type="text/javascript" src="${base}/script/jquery-validation/jquery.metadata.js"></script>
	<script type="text/javascript" src="${base}/script/jquery-validation/validate.method.js"></script> 
	<script type="text/javascript" src="${base}/script/jquery-validation/additional-methods.js"></script>
	
	<#--  end of bbbb -->
	
    <!-- Custom styles for this template -->  
    <link href="${base}/style/showcase.css" rel="stylesheet">
    <link href="${base}/style/style.css" rel="stylesheet">
    <link href="${base}/style/imas/user/justify.css" rel="stylesheet">
	
 
	   <!-- Slider Kit scripts -->
		<script type="text/javascript" src="${base}/script/jquery-sliderkit/jquery.easing.1.3.min.js"></script>
		<script type="text/javascript" src="${base}/script/jquery-sliderkit/jquery.mousewheel.min.js"></script>				
		<script type="text/javascript" src="${base}/script/jquery-sliderkit/jquery.sliderkit.1.9.2.pack.js"></script>		

		<!-- loadmask scripts -->
		<link rel="stylesheet" type="text/css" href="${base}/script/jquery-loadmask/loadmask.css">
		<script type="text/javascript" src="${base}/script/jquery-loadmask/loadmask.js"></script>

		<!-- jquery-growl -->
		<script type="text/javascript" src="${base}/script/jquery-growl/jquery.growl.js"></script>
		<link href="${base}/script/jquery-growl/jquery.growl.css" rel="stylesheet" type="text/css" /> 

		
		<script type="text/javascript" src="${base}/script/jquery-timepicker/jquery.timepicker.min.js?${.now}"></script>
		<link href="${base}/script/jquery-timepicker/jquery.timepicker.css" rel="stylesheet" type="text/css" />
		
		<!-- <script type="text/javascript" src="${base}/script/employee/javascript/modernizr.js"></script> -->
		


		<!-- Custom for this template  --> 
		<link rel="stylesheet" type="text/css" href="${base}/style/employee.css?${.now}">
		
		
		<script type="text/javascript" src="${base}/script/employee.js?${.now}"></script>
		
		<script type="text/javascript" src="${base}/script/wg.template.js?${.now}"></script>
		<script type="text/javascript" src="${base}/script/wg.evalForm.js?${.now}"></script>
		
		<!--  jquery ganttView -->
		<link rel="stylesheet" type="text/css" href="${base}/script/jquery.ganttView-master/jquery.ganttView.css">
		<script type="text/javascript" src="${base}/script/jquery.ganttView-master/date-zh-TW.js"></script>
		<script type="text/javascript" src="${base}/script/jquery.ganttView-master/jquery.ganttView.js"></script>

		<!--qtip-->
		<link type="text/css" rel="stylesheet" href="${base}/script/jquery-qtip/jquery.qtip.min.css">
		<script type="text/javascript" src="${base}/script/jquery-qtip/jquery.qtip.min.js"></script> 		
		
		
		<script type="text/javascript" src="${base}/plug-in/cookie/jquery.cookie.js"></script> 		
<script>
	var BASE_URL = "${base}";
	var LOGIN_USER_ID = "<#if currentUser??>${currentUser.id}</#if>";
</script>


<script type="text/javascript"> 
	var chkEventTimer;
			$(document).ready(function(){
				//加載
				mlog.load({
					contentSelector : "body"
				}); 
				//
				
				//取得事件項目
				//chkEvent();
				//chkEventTimer = $.timer(360000, chkEvent);
				//window.setInterval(chkEvent, 360000); 
			});
			/*
			function chkEvent() {
					$.ajax({
			            url: "${base}/api/employee/getMyTodoList",
			            data: {			                
			            },
			            type: "POST",
			            dataType: "json",
			            success: function (resultData) {
			                if (resultData) { 
			                	//$("#animated-bell-count").html("("+resultData.length+")");
			                	//$("#animated-bell").show();
			                } else {
			                	//$("#animated-bell-count").html("(0)");
			                	//$("#animated-bell").hide();
			                }
			            }
			        });
			}
			*/
		function openCertDialog(){
			$("#globalModal .modal-title").text("證照效期提醒");
			wg.template.updateDomContent("globalModal .modal-body", {}, "${base}/employee/cert/alert");
		}
		function updateCertNum(){
			$.ajax({
				url: "${base}/employee/cert/alert/num",
				type: "POST",
				success: function (resultData) {
					$("#animated-bell-count").html(resultData);
				}
			});
		}
		$(function(){
			updateCertNum();
		});
    </script>
    <style type= 'text/css'>
    @-moz-keyframes ringing{
		0%{moz-transform: rotate(-15deg);}
		2%{moz-transform: rotate(15deg);}
		4%{moz-transform: rotate(-18deg);}
		6%{moz-transform: rotate(18deg);}
		8%{moz-transform: rotate(-22deg);}
		10%{moz-transform: rotate(22deg);}
		12%{moz-transform: rotate(-18deg);}
		14%{moz-transform: rotate(18deg);}
		16%{moz-transform: rotate(-12deg);}
		18%{moz-transform: rotate(12deg);}
		20%{moz-transform: rotate(0deg);}
	}
	@-webkit-keyframes ringing{
		0%{webkit-transform: rotate(-15deg);}
		2%{webkit-transform: rotate(15deg);}
		4%{webkit-transform: rotate(-18deg);}
		6%{webkit-transform: rotate(18deg);}
		8%{webkit-transform: rotate(-22deg);}
		10%{webkit-transform: rotate(22deg);}
		12%{webkit-transform: rotate(-18deg);}
		14%{webkit-transform: rotate(18deg);}
		16%{webkit-transform: rotate(-12deg);}
		18%{webkit-transform: rotate(12deg);}
		20%{webkit-transform: rotate(0deg);}
	}
	@-ms-keyframes ringing{
		0%{ms-transform: rotate(-15deg);}
		2%{ms-transform: rotate(15deg);}
		4%{ms-transform: rotate(-18deg);}
		6%{ms-transform: rotate(18deg);}
		8%{ms-transform: rotate(-22deg);}
		10%{ms-transform: rotate(22deg);}
		12%{ms-transform: rotate(-18deg);}
		14%{ms-transform: rotate(18deg);}
		16%{ms-transform: rotate(-12deg);}
		18%{ms-transform: rotate(12deg);}
		20%{ms-transform: rotate(0deg);}
	}
	@keyframes ringing{
		0%{transform: rotate(-15deg);}
		2%{transform: rotate(15deg);}
		4%{transform: rotate(-18deg);}
		6%{transform: rotate(18deg);}
		8%{transform: rotate(-22deg);}
		10%{transform: rotate(22deg);}
		12%{transform: rotate(-18deg);}
		14%{transform: rotate(18deg);}
		16%{transform: rotate(-12deg);}
		18%{transform: rotate(12deg);}
		20%{transform: rotate(0deg);}
	}
	.animated-bell{
		animation: ringing 2.0s 5 ease 1.0s;
		display: inline-block;
		moz-animation: ringing 2.0s 5 ease 1.0s;
		moz-transform-origin: 50% 0;
		ms-animation: ringing 2.0s 5 ease 1.0s;
		ms-transform-origin: 50% 0;
		o-animation: ringing 2.0s 5 ease 1.0s;
		o-transform-origin: 50% 0;
		transform-origin: 50% 0;
		webkit-animation: ringing 2.0s 5 ease 1.0s;
		webkit-transform-origin: 50% 0;
	}
	.container {
		/*width: 100%;*/
	}
	.logo_name{
		width: 120px;
		height: 30px;
		margin-top: 0px;  /*移除語言列補上，原為4px*/
		background-size: 100% 100% !important;
		background: url('${base}/images/imas/itri_logo.png') no-repeat center center;
	}
	.navbar-multi-entry{
		align-items: center;
		display: inline-flex;
		float: right;
	}
	
	.entry-btn{
		display: flex;
		padding: 4px 10px;
		-webkit-box-align: center;
		align-items: center;
		grid-column-gap: 8px;
		grid-row-gap: 8px;
		border: 1.5px solid #808080;
		border-radius: 100px;
		-webkit-transition: all 1000ms ease;
		font-size: 14px;
		text-decoration: none;
		margin-left: 10px;	
		color: #595959;
	}
	
	.entry-btn:hover{
		background: #808080;
		color: #ffffff;
	}
	
	.navbar-multi-entry select{
		margin-left: 10px;
		background: #f2f2f2;
		border: 1px solid #f2f2f2;
		box-shadow: none;
	}
	
	<#if __field?? && __field=="HY">
	.skin-blue .main-header .navbar, .skin-blue .main-header li.user-header{
		background: #9c27b0 !important;
	}
	.btn, input.btn {
		background: #9b4abf;
	}
	</#if>
    </style>
  </head>

  <body class="skin-blue layout-top-nav" style='min-width:280px;'>
  	<!-- Modal -->
	<div id="globalModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Modal Header</h4>
				</div>
				<div class="modal-body">
					<p>Some text in the modal.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
				</div>
			</div>
		</div>
	</div>
  
    <!--content container start-->
    <div class="main-header">
	    <nav class="navbar navbar-static-top">
			<div class="container">
				<div class="navbar-header logo_name" >
					<!--<a href="${base}" class="navbar-brand">
						<#if !testPageUrl??>
							
						<#else>
							<img src="${base}/images/eye/eyexross_logo.png" style="width:12%; top:-10px; position:relative;">
						</#if>
					</a>-->
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
						<i class="fa fa-bars"></i>
					</button>
					<#if employee?exists && employee=="true" && employeeNavItems?exists>
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
							<i class="fa fa-bars"></i>
						</button>
					</#if>
				</div>
				
				<!-- 多重入口指示 -->

				<div class="navbar-multi-entry">
					<a class="entry-btn" href="/ftl/imas/login">醫療人員登入</a>
					<a class="entry-btn" href="${base}/case/register">個案註冊</a>
					<a class="entry-btn" href="${base}/case/login">個案訓練入口</a>
					<select id="langSelect" class="lang-list form-control" onchange="setLanguage(this)">
						<option value="zh_TW">繁體中文</option>
						<option value="en_US">English</option>
						<option value="th_TH">แบบไทย</option>
					</select>
				<div>	
					
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse pull-left" id="navbar-collapse">
					<ul class="nav navbar-nav">
						<#if !(healthManageInfo?exists && healthManageInfo=="true") && !(memberDataInfo?exists && memberDataInfo=="true") && !(hisCompanyDataInfo?exists && hisCompanyDataInfo=="true")>
							<#if employee?exists && employee=="true" && employeeNavItems?exists>
								<#list employeeNavItems as item>
									<#if item.open?? && item.open>
										<li class="main n${item_index}">
											<a title="${item.name?default("")}" href="${base}/employee/redirect?id=${item.id}">
												${item.name?default("")}
											</a>
										</li>
									</#if>
								</#list>
							</#if>
						<#else>
							<#if menuItems??>
	  							<#list menuItems as item>
									<#if item.open?? && item.open>
										<li><a href="${base}/employee/redirect?id=${item.id}"><#--<i class="fa fa-fw fa-chevron-right text-warning"></i>-->${item.name?default("")}</a></li>
									</#if>
								</#list>
							</#if>
						</#if>
	              	</ul>                       
	            </div><!-- /.navbar-collapse -->
				<#include "./main_nav.ftl" />				
			</div><!-- /.container-fluid -->
		</nav>
	</div>
	