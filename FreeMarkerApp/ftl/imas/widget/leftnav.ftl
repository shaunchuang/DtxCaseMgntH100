<#import "/util/spring.ftl" as spring />
<title>${blogname}<#if subname??>｜${subname}</#if></title>
<link rel="icon" href="${base}/images/favicon.ico" type="image/x-icon">
<meta content="text/html; charset=UTF-8" http-equiv="content-type">
<#if !__lang?exists || !__lang?has_content >
<#assign __lang = "zh_TW" >
</#if>
<script type="text/javascript" src="${base}/script/woundInfo/jquery-2.2.0.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/bootstrap.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/moment.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/chart-utils.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/Chart.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/chartjs-plugin-datalabels.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/chartjs-plugin-annotation.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/chartjs-adapter-date-fns.bundle.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/utility.js?${.now}"></script>
<script type="text/javascript" src="${base}/script/wg.evalForm.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/html2canvas.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/canvas2image.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/dataTables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/dataTables/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/jquery.twzipcode.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/zoom-mark.js"></script>
<script type="text/javascript" src="${base}/script/imas/sweetalert.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/lightgallery.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/lg-thumbnail.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/lg-video.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/multi.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/jquery.multiselect.js"></script>
<script type="text/javascript" src="${base}/plug-in/qrcode/qrcode.js"></script>
<script type="text/javascript" src="${base}/plug-in/qrcode/jquery.qrcode.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/selectize.js"></script>
<script type="text/javascript" src="${base}/script/imas/fullCalender.js"></script>
<script type="text/javascript" src="${base}/script/imas/google-calendar.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/notify.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/jquery.breadcrumbs-generator.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/select2.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/select2.${__lang}.js"></script>
<script type="text/javascript" src="${base}/script/imas/timepicker.min.js" charset="big5"></script>
<script type="text/javascript" src="${base}/script/imas/bootstrap3-typeahead.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/bootstrap-tagsinput.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/jquery-dropdown-datepicker.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/widget/jszip.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/widget/FileSaver.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/widget/appointment.js"></script>
<script type="text/javascript" src="${base}/script/imas/chatroom.js"></script>

<script type="text/javascript" src="${base}/script/jquery-validation/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/script/jquery-validation/jquery.metadata.js"></script>
<script type="text/javascript" src="${base}/script/jquery-validation/validate.method.js"></script>
<script type="text/javascript" src="${base}/script/jquery-validation/additional-methods.js"></script>

<script type="text/javascript" src="${base}/script/mlog.utils.js"></script>
<script type="text/javascript" src="${base}/script/mlog.form.js"></script>
<script type="text/javascript" src="${base}/script/mlog.dialog.js"></script>
<script type="text/javascript" src="${base}/script/mlog.editor.js"></script>

<script type="text/javascript" src="${base}/script/wg.template.js?${.now}"></script>
<script type="text/javascript" src="${base}/script/wg.evalForm.js?${.now}"></script>

<link href="${base}/style/woundInfo/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/dataTables/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/select.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/widget/sweetalert.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/multi.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/widget/jquery.multiselect.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/selectize.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/fullCalender.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/widget/appointment.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/widget/evaluation.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/widget/common.css" rel="stylesheet" type="text/css">

<link href="${base}/style/imas/select2.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/timepicker.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/notify.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/lightgallery.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/lg-zoom.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/logo.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/bootstrap-tagsinput.css" rel="stylesheet" type="text/css">

<link href="${base}/style/imas/contextMenu.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${base}/script/imas/contextMenu.min.js"></script>
<script type="text/javascript" src="${base}/script/imas/ui.position.js"></script>

<script>
var page_info = {
	emptyTable:     "<@spring.message "page.label.empty"/>",
    zeroRecords: "<@spring.message "page.label.nomatch"/>",
    paginate: {
        first:      "<@spring.message "page.label.first"/>",
        previous:   "<@spring.message "page.label.previous"/>",
        next:       "<@spring.message "page.label.next"/>",
        last:       "<@spring.message "page.label.last"/>"
    }
}

var Utils = ChartUtils.init();

</script>

<style>
body{
	position: relative;
	min-height: 100vh;
	width: 100%;
	overflow: hidden;
	margin: 0; 
	padding: 0;
	scroll-behavior: smooth;
	
}

.input-group-addon{
	font-weight: 600;
}

.footer-btn-list button:not(.func-btn-edit):not(.func-btn-prev):not(.func-btn-next), .order-temp button,
.item-funclist a , tr td button:not(.func-btn-edit):not(.func-btn-prev):not(.func-btn-next),
.btn-blk button, .modal-footer button,
.default-blk:not(.history-blk) .title button, .evaluation-top-bar button{
	border: 1px solid #808080 !important;
	/*padding: 5px !important;*/
}

#breadcrumbs{
	height: 40px;
	line-height: 40px;
	margin-bottom: 0;
	padding-left: 0;
}

#breadcrumbs li {
  	display: inline-block;
}

#breadcrumbs li:first-child a{
	color: #00cb96;
	font-weight: 600;
	text-decoration: none;
}

#breadcrumbs li:not(:first-child) {
  	margin-left: 0.4em;
}

#breadcrumbs li:not(:first-child):before {
  	content: '|';
  	margin-right: 0.4em;
}

#btn:hover{
	cursor: pointer;
}

.sidebar{
	position: fixed;
	top: 0;
	left: 0;
	height: 100%;
	width: 63px; /*35px*/
	background: #00cb96;
	padding: 6px;
	transition: all 0.5s ease;
}

.sidebar.active{
	width: 180px;
}

.sidebar .logo_content .logo,
.sidebar .intro_content .logo{
	color: #fff;
	display: flex;
	height: 30px;
	width: 100%;
	align-items: center;
	opacity: 0;
	pointer-events: none;
	transition: all 0.5s ease;
	font-size: 16px;
}

.sidebar.active .logo_content .logo,
.sidebar.active .intro_content .logo{
	opacity: 1;
}

.logo_content .logo span,
.intro_content .logo span{
	font-size: 20px !important;
	margin-right: 5px;
	letter-spacing: 2;
}

.logo_content .logo i,
.intro_content .logo i{
	font-size: 28px;
	margin-right: 5px;
}

.logo_content .logo .logo_name,
.intro_content .logo .logo_name{
	font-size: 20px;
	font-weight: 400;
}

.intro_content{
	position: absolute;
	bottom: 5px;
	font-size: 16px;
	left: 10px;
	color: #fff;
	text-shadow: #737373 0.05em 0.05em 0.05em;
}

.sidebar #btn{
	position: absolute;
	color: #fff;
	left: 50%;
	top: 0px;
	font-size: 20px;
	height: 30px;
	width: 30px;
	text-align: center;
	line-height: 50px;
	transform: translateX(-50%);
}

.sidebar.active #btn{
	left: 90%;
}

.sidebar ul{
	padding: 0;
	/*margin-top: 20px;*/
	list-style-type: none;
}

.sidebar ul li{
	position: relative;
	width: 100%;
	/*margin: 5px 0;*/
	padding: 2px 0;
	list-style: none;
	border-radius: 12px;
}

.sidebar ul li:first-child{
	padding-top: 5px;
}

.sidebar .links_name{
	width: 150px;
	opacity: 0;
	pointer-events: none;
	transition: all 0.5s ease;
	white-space: break-spaces;
	<#if __lang == "zh_TW" >
	font-size: 16px;
	line-height: 16px;
	<#else>
	font-size: 14px;
	line-height: 14px;
	</#if>
}

.sidebar.active .links_name{
	opacity: 1;
	pointer-events: auto;
	text-shadow: 1px 1.5px #737373;
	font-weight: 600;
}

.sidebar .fa-caret-down{
	opacity: 0;
}

.sidebar.active .fa-caret-down{
	opacity: 1;
}

.sidebar ul li .tooltip{
	position: absolute;
	left: 122px;
	top: 50%;
	transform: translate(-50%, -50%);
	border-radius: 6px;
	height: 35px;
	width: 122px;
	line-height: 35px;
	text-align: center;
	background: #fff;
	box-shadow: 0 5px rgba(0,0,0,0.2);
	transition: 0s;
	opacity: 0;
	pointer-events: none;
}

.sidebar.active ul li .tooltip{
	display: none;	
}

.sidebar ul li:hover .tooltip{
	top: 50%;
	opacity: 1;
	transition: all 0.5s ease;
}

.sidebar ul li a{
	color: #fff;
	display: flex;
	align-items: center;
	text-decoration: none;
	transition: all 0.1s ease;
	white-space: nowrap;
	font-size: 18px;
	padding: 8px 0;
}

ul.sub-menu li a{
	<#if __lang == "zh_TW" >
	font-size: 16px !important;
	line-heigth: 16px !important;
	<#else>
	font-size: 14px !important;
	line-heigth: 14px !important;
	</#if>	
	padding: 5px 0;
	white-space: break-spaces;
}

.sidebar ul li a:hover,
.sidebar ul li a.active{
	color: #000000;
	background: #fff;
	border-radius: 2px;
}

ul.sub-menu li a:hover,
ul.sub-menu li a.active{
	color: #fff !important;
	font-weight: 600 !important;
	background: #00cb96 !important;
	text-shadow: 1px 1.5px #737373 !important;
}

.sidebar ul li a:hover .links_name,
.sidebar ul li a.active .links_name{
	text-shadow: none;
}

.sidebar ul li a i{
	margin-right: 5px;
	min-width: 25px;
	border-radius: 12px;
	text-align: center;
	font-size: 16px;
}

.sidebar.active ul li a .fa-caret-down.arrow-rotate{
  	transform: rotate(-180deg);
}

.sidebar .profile_content{
	position: absolute;
	color #fff;
	bottom: 0;
	left: 0;
}

.sub-menu{
	margin: 0 !important;
	position: static !important;
  	display: none !important;
}

.sidebar.active .nav_list li .sub-menu.show{
	display: block !important;
}

.sub-menu li{
	padding-left: 25px !important;
	font-size: 16px !important;
	font-weight: 600 !important;
}

.content-blk{
	position: absolute;
	height: 100%;
	width: calc(100% - 63px);
	left: 63px;
}

.sidebar.active ~ .content-blk{
	width: calc(100% - 180px);
	left: 180px;
}

.custom-blk{
	height: calc(100% - 40px);
	overflow-y : hidden;
	width: 100%;
}

.top-bar{
	background: #11101d;
	color: #fff;
	height: 40px;
	line-height: 40px;
	padding: 0 20px;
}

.message-alert, .list-btn, .top-content > .item-name,
.item-title > .item-name, .item-title > .patient-hint{
	display: inline;
}

.message-alert{
	position: relative;
	margin-right: 25px;
}

.message-alert span{
	position: absolute;
	top: -5px;
	right: -3px;
	background: #ff5050;
	color: #fff;
	padding: 2px;
	border-radius: 30px;
	width: 5px;
	height: 5px;
	text-align: center;
	font-size: 8px;
	
}

.list-btn{
	margin-left: 10px;
}

.message-alert:hover, .list-btn:hover{
	cursor: pointer;
}

.sub-bar{
	background: #d7e6f4;	
	height: auto;
	padding: 0px 15px;

}

.item-title, .sub-func{
	padding: 10px 0;
	display: flex;
}

.sub-func{
	font-size: 16px;
	display: flex;
  	justify-content: flex-end;
  	align-items: center;
}

.sub-func > .inner-addon { 
    position: relative;
    margin-right: 10px; 
}

.sub-func > .inner-addon > span {
  	position: absolute;
  	padding: 10px;
  	pointer-events: none;
}

.sub-func > .right-addon > span{ 
	top: -1px;
	right: 0px;
}

.sub-func > .right-addon > span:hover { 
	cursor: pointer !important;
}

.right-addon input {
	width: 300px; 
	padding-right: 30px;
	border-radius: 20px; 	
}

.item-title > .item-name,
.item-title > .patient-hint{
	font-weight: 600;
}

.item-title > .item-name:before{
	content: "  ";
	display: inline-block;
	position: relative;
	top: 2.5px;
	width: 0.8rem;
	height: 2rem;
	margin-right: 0.8rem;
	background-size: 100%;
	background-image: linear-gradient(to bottom, #00b19c, #00b19c);
}

.item-title > .item-name{
	font-size: 1.5em;	
	color: #404040;	
}

.item-title > .patient-hint{
	margin-left: 15px;
	font-size: 1.1em;
	color: #ffffff;
	background: #737373;
	padding: 4px 10px;
	border-radius: 5px;
	/*vertical-align: text-bottom;*/
}

.main-content{
	padding: 10px;
	/*滾輪介面位置調動*/
	height: calc(100% - 100px);
	overflow-y : auto;
}

.main-content h3{
	display: block;
}


/* width */
::-webkit-scrollbar {
  	height: 3px;
  	width: 3px;
}

/* Track */
::-webkit-scrollbar-track {
  	background: #e6e6e6; 
}
 
/* Handle */
::-webkit-scrollbar-thumb {
  	background: #bfbfbf; 
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  	background: #999999; 
}



/*右側頁籤切換功能*/

.panel-heading{
	padding-bottom: 0;
	/*padding-top: 20px;*/
    display: inline;
}
.nav-tabs{
	border-bottom: none;
}
.nav-justified{
	margin-bottom: -1px;
}


/*** 標籤樣式 ***/
.nav-tabs > li > a[aria-expanded="false"]:hover{
	background: #f2f2f2 !important;
}

.nav-tabs > li > a,
.nav-tabs > li > a:hover,
.nav-tabs > li > a:focus {
	color: #31708f;	
	padding: 10px 8px;
}
.nav-tabs > .open > a,
.nav-tabs > .open > a:hover,
.nav-tabs > .open > a:focus,
.nav-tabs > li > a:hover,
.nav-tabs > li > a:focus {
	color: #31708f;
	background-color: #bce8f1;
	border-color: transparent;
}
.nav-tabs > li > a[aria-expanded="true"],
.nav-tabs > li > a[aria-expanded="true"]:hover,
.nav-tabs > li > a[aria-expanded="true"]:focus {
	color: #31708f;
	background-color: #fff;
	border-color: #bce8f1;
	border-bottom-color: transparent;
}

/*各模組形式共用區*/
.d-flex{
	display: flex !important;
}

.justify-content-between{
	justify-content: space-between!important;
}

.align-items-center{
	align-items: center!important;
}

.flex-grow-1{
	flex-grow: 1 !important;
}

.w-auto{
	width: auto !important;
}

.w-50{
	width: 50px !important;
}

.w-100{
	width: 100px !important;
}

.w-150{
	width: 150px !important;
}

.w-200{
	width: 200px !important;
}

.col-3{
	width: 24%;
}

.col-4{
	width: 32%;
}

.col-5{
	width: 41%;
}

.col-6{
	width: 49%;
}

.col-7{
	width: 58%;
}

.col-8{
	width: 67%;
}

.col-9{
	width: 75%;
}

.col-xs-0-5{
	width: 4.1666%;
}

.col-xs-1-5{
	width: 12.5%;
}

.col-xs-2-5{
	width: 20.8333%;
}

.col-xs-3-5{
	width: 29.1666%;
}

.col-xs-4-5{
	width: 37.5%;
}

.col-xs-5-5{
	width: 45.8333%;
}

.pd-0{
	padding: 0;
}

.pd-5{
	padding: 5px;
}

.pd-10{
	padding: 10px;
}

.pd-h-0{
	padding-left: 0px;
	padding-right: 0px;
}

.pd-h-5{
	padding-left: 5px;
	padding-right: 5px;
}

.pd-h-10{
	padding-left: 10px;
	padding-right: 10px;
}

.pd-l-5{
	padding-left: 5px;
}

.pd-r-5{
	padding-right: 5px;
}

.pd-l-10{
	padding-left: 10px;
}

.pd-r-10{
	padding-right: 10px;
}

.pd-v-0{
	padding-top: 0px;
	padding-bottom: 0px;
}

.pd-v-5{
	padding-top: 5px;
	padding-bottom: 5px;
}

.pd-v-10{
	padding-top: 10px;
	padding-bottom: 10px;
}

.pd-v-15{
	padding-top: 15px;
	padding-bottom: 15px;
}

.pd-t-5{
	padding-top: 5px;
}

.pd-b-5{
	padding-bottom: 5px;
}

.pd-t-10{
	padding-top: 10px;
}

.pd-b-10{
	padding-bottom: 10px;
}

.mg-0{
	margin: 0 !important;
}

.mg-5{
	margin: 5px !important;
}

.mg-10{
	margin: 10px !important;
}

.mg-v-5{
	margin: 5px 0 !important;
}

.mg-v-10{
	margin: 10px 0 !important;
}

.mg-left-5{
	margin-left: 5px !important;
}

.mg-right-5{
	margin-right: 5px !important;
}

.mg-top-5{
	margin-top: 5px !important;
}

.mg-top-10{
	margin-top: 10px !important;
}

.me-2{
	margin-right: .5rem!important;
}

.mb-1{
	margin-bottom: .25rem!important;
}

.mb-2{
	margin-bottom: .5rem!important;
}

.mg-b-0{
	margin-bottom: 0px !important;
}

.mg-b-5{
	margin-bottom: 5px !important;
}

.mg-b-10{
	margin-bottom: 10px !important;
}

.border-b-2{
	border-bottom: 2px solid #808080;
}

.border-b-3{
	border-bottom: 3px solid #808080;
}

.f-14{
	font-size: 14px !important;
}

.f-16{
	font-size: 16px !important;
}

.f-18{
	font-size: 18px !important;
}

.f-20{
	font-size: 20px !important;
}

.f-light{
	font-weight: 400 !important;
}

.f-bold{
	font-weight: 600 !important;
}

.divide{
	padding: 0;
	width: 1px;
}

.input-group{
	width: 100%;
	max-width: 100%;
	margin-bottom: 10px;
}

.form-control{
	border: 1px solid #b3b3b3;
}

.btn:hover{
	background: #666666;
	color: #ffffff;
}

.func-btn {
  	display: inline;
  	min-width: 75px;
  	padding: 5px 10px;
  	border-radius: 6px;
  	color: #3D3D3D;
  	background: #fff;
  	border: none;
  	box-shadow: 0px 3px 1px rgba(0, 0, 0, 0.2);
  	user-select: none;
  	-webkit-user-select: none;
  	touch-action: manipulation;
}

.func-btn:not(.func-btn-edit):not(.func-btn-prev):not(.func-btn-next):hover{
	background: #f2f2f2 !important;
	font-weight: 600 !important;
	text-decoration: none  !important;
	cursor: pointer;
}

.func-btn-main{
	color: #ffffff;
	font-size: 16px;
	font-weight: 600;
	text-shadow: 1px 1px 0 #444;
}

.func-btn-main{
	background: linear-gradient(92.64deg, #01CB96 0%, #029D74 90.03%);
}

.func-btn-main:hover{
	background: linear-gradient(92.64deg, #00B783 0%, #027A5A 90.03%) !important;
}

.func-btn-custom{
	padding: 4px 10px;
    border: 1px solid #009E75;
    border-radius: 4px;
    background-color: white;
    color: #009E75;
    cursor: pointer;
    font-weight: 600;
}

.func-btn-custom.btn-primary {
    background-color: #009E75;
    color: white;
}

.func-btn-custom:hover {
    background-color: #009E75;
    color: white;
}

.func-btn-custom.btn-primary:hover {
    background-color: #1e9e63;
    border: 1px solid #009E75;
}

/*具有分頁功能的table*/
table{
	border: none !important;
}

.table>thead>tr>th, .table>tbody>tr>th, 
.table>tfoot>tr>th, .table>thead>tr>td,
.table>tbody>tr>td, .table>tfoot>tr>td{
	line-height: 1.42857143;
	vertical-align: middle;
	padding: 6px 8px;
	border: none;
}

.table>thead>tr>th input:not(input[type='button']), 
.table>tbody>tr>th input:not(input[type='button']), 
.table>thead>tr>td input:not(input[type='button']),
.table>tbody>tr>td input:not(input[type='button']),
.table>thead>tr>th select, .table>tbody>tr>th select, .table>thead>tr>td select, .table>tbody>tr>td select,
table>thead>tr>th textarea, table>tbody>tr>th textarea, table>thead>tr>td textarea, table>tbody>tr>td textarea{
	width: 100%;
	box-sizing: border-box;
}

table>tbody>tr>td textarea{
	padding: 10px;
}

.table-header, .table-footer{
	width: 100%;
}

.table-header{
	font-size: 16px;
}

.main-table, .sub-table{
	margin-top: 5px;
}

.main-table, .main-table thead tr th,
.main-table tbody tr td,
.sub-table, .sub-table thead tr th,
.sub-table tbody tr td{
	border: none;
}

.main-table thead tr th:not(:last-child),
.main-table tbody tr td:not(:last-child),
.sub-table thead tr th:not(:last-child),
.sub-table tbody tr td:not(:last-child){
	/*border-right: 0.5px solid #e6e6e6;*/
}

.main-table thead, .result-table thead, .sub-table thead{
	border-bottom: 2px solid #808080;
}

.main-table tbody tr:hover{
	background: #d9d9d9 !important;
	cursor: pointer;
}

.main-table tbody tr:has(td input[type="checkbox"]:checked){
	background: #fff2b3;
}

.main-table tbody tr:has(td input[type="checkbox"]:checked) td:first-child{
	border-left: 5px solid #cc6600;
}

.main-table tbody tr:has(td input[type="checkbox"]:checked) td:last-child {
	border-right: 5px solid #cc6600;
}

div.dataTables_paginate{
	float: none;
}


.module-list{
	height: fit-content;
	max-height: max-content;
	margin-bottom: 10px;
	background: #ebf2fa;
	border-radius: 5px;
	box-shadow: 4px 0 4px -2px rgba(0, 0, 0, 0.2);
	padding: 0 15px;
}

.module-blk{
	/*display: inline-block;
	display: inline-table;*/
	display: table-cell;
	padding: 8px 10px;
	height: 100%;
	text-align: center;	
	margin-right: 5px;
	max-width: 170px;
	max-height: 90px;
}

.module-blk:hover{
	background: #fff;
	border: 0;
	cursor: pointer;
}

.module-blk.active{
	background: #fff;
	/*border: 1.5px solid #bfbfbf;*/
	box-shadow: 4px 0 4px -2px rgba(0, 0, 0, 0.2), -4px 0 4px -2px rgb(0 0 0 / 20%);
}

.module-blk i, .module-blk span{
	display: block;
}

.module-blk i{
	font-size: 22px;
	margin-bottom: 5px;
}

.module-blk span{
	font-size: 16px;
	line-height: 16px;
	/*display: table-row;*/
	vertical-align: middle;
}

.module-blk.active span{
	font-weight: 600;
}

/*基本表單、不具分頁功能的table*/
.default-table{
	width: 100%;
	max-width: 100%;	
}

.d-fixed-table{
	table-layout: fixed;  /*後來補的*/
}

.d-fixed-table tr td.text-ellipsis{
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.default-table tr td{
	padding: 10px;
	border-bottom: 0.5px solid #f2f2f2;
}

.default-table tr:last-child td{
	border: none;
}

.default-table tr td:nth-child(odd){
	/*width: 1%;*/
	width: 160px;
	font-weight: 600;
	/*white-space: nowrap;*/
}

.default-table tr td input,
.default-table tr td textarea,
.default-table tr td select{
	font-weight: 500;
}

textarea{
	resize: none;
}

.footer-btn-list{
	/*border-top: 0.2px solid #e6e6e6;*/
	padding: 10px 0;
	/*margin-top: 10px;*/
	text-align: center;
}

.footer-btn-list button:not(:last-child){
	margin-right: 10px;
}

/*縣市地區選擇器*/
.form-inline{
	margin-bottom: 5px;
}

.form-inline select{
	margin-right: 5px;
}

.sub-title{
	font-size: 16px;
	color: #009e75;
	font-weight: 600;
}

.inline-cotainer{
	display: flex;
	gap: 5px;
}

.inline-cotainer select,
.inline-cotainer button{
	display: inline-block;
}

.inline-cotainer button{
	margin-left: auto;
  	margin-right: 0;
}

/** select2選擇器設定 **/
.select2-container {
    width: 100% !important;
}

/** modal 設定 **/
.modal-open .modal{
	/*overflow-y: hidden !important;*/
}

.modal-body iframe{
	width: 100%;
	height: 550px;
	border: none;
}

.modal-header, .modal-footer{
	font-size: 16px;
}

.modal-header{
	text-align: left;
	font-weight: 600;
}

.modal-dialog{
	display: inline-block;
	vertical-align: middle;
	text-align: left;
}

.modal-body > span > b{
	color: #007ec8;
	background: #fff;
}

.modal{
	text-align: center;
	padding: 0!important;
}

.modal:before{
	content: '';
	display: inline-block;
	height: 100%;
	vertical-align: middle;
	margin-right: -4px;
}

.modal-open{
	padding-right: 0!important
}

.modal-header .close{
	width: 25px;
	height: 25px;
	border-radius: 50%;
	color: #fff;
	background: #8c8c8c;
	float: right!important;
	opacity: 0.5;
}

.modal-header .close:hover{
	opacity: 0.8;
}

.modal-footer{
	text-align: center;
}

.modal-footer button:not(:last-child){
	margin-right: 10px;
}

/** 下拉式選單 設定 **/
.dropdown{
	display: inline;
	background: #000 !important;
}

.dropdown-toggle, .dropdown-toggle:hover,
.dropdown-toggle:focus, .dropdown-toggle:focus-visible{
	background-color: #11101d !important;
	border-color: #11101d !important;
	color: #fff !important;
}

.dropdown-toggle::after{	
	display: inline-block;
	margin-left: .255em;
	vertical-align: .255em;
	content: "";
	border-top: 0.3em solid;
	border-right: 0.3em solid transparent;
	border-bottom: 0;
	border-left: 0.3em solid transparent;
}

.menu-item.dropdown-menu{
	right: 0;
	min-width: 100px;
	left: inherit;
}

.open > .menu-item.dropdown-menu{
	height: 35px;
	line-height: 35px;
	text-align: center;
	padding: 0;
	margin: 5px 0;
}

.menu-item.dropdown-menu > a, .menu-item.dropdown-menu > a:hover,
.menu-item.dropdown-menu > a:focus{
	text-decoration: none;
	cursor: pointer;
}

/** 左側選單logo 設定 **/
.logo_name{
	width: 150px;
	height: 30px;
	background-size: 100% 100% !important;	
}

/** 上方選單歸檔資訊 設定 **/
.archive-info{
	display: inline-block;
	margin-right: 50px;
	cursor: pointer;
}

.archive-info span{
	font-weight: 600;
}


/** 告知訊息背景設定 **/
.warning-info, .search-hint{
	background: #ffdd99;
	color: #664400;
	padding: 5px 10px;
	font-weight: 600;
}

.search-hint{
	margin-bottom: 10px;
}

.search-hint b{
	color: #000;
	background: #fff;
	padding: 0 8px;
}

.search-hint b, .search-hint p{
	display: inline-block;
}

/** 列表關鍵字搜尋設定 **/
input[type="search"] {
  -webkit-appearance: searchfield;
}

input[type="search"]::-webkit-search-cancel-button {
  -webkit-appearance: searchfield-cancel-button;
}

input[type="search"]::-webkit-search-cancel-button:hover{
	cursor: pointer;
}

/* 編輯或新增資料必要標註 */
.star::before{
	color: red;
	content: "* ";
}

.sub-t{
	background: #eeeee4;
}

.pd-t-15{
	padding-top: 15px !important;
}

.pd-b-15{
	padding-bottom: 15px !important;
}

.h-color{
	color: #4472c4;
	font-weight: 600;
}

.normal{
	color: green;
}

.abnormal{
	font-weight: 600;
	color: #cc6600;
}

.hb-color{
	background: #ffe6cc;
}

.hb-color.highlight{
	border: 1px solid #994d00;
}

.half{
	width: 150px !important;
	display: inline-block !important;
}

.half.postCode{
	width: 110px !important;
	margin-right: 5px;
}

/* chart呈現設定 */
.chart-blks {
    display: flex;
    flex-wrap: wrap; /* 允許 Flexbox 在需要時換行 */
    justify-content: space-between;
}

.chart-blk{
    border: 0.5px solid #bfbfbf;
    border-radius: 5px;
    width: 49%;
    padding: 20px 5px 5px 5px;
    box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.3);
    margin-bottom: 20px;
	position: relative;
}

.chart-blk p{
	position: absolute; 
	color: #737373;
	z-index: 100;
}

.chart-blk p.update-time{	
	right: 15px; 
	top: 10px; 	
}

.chart-blk p.total{	
	right: 15px; 
	bottom: -5px; 	
}

.chart-blk p:before{
	font-family: 'FontAwesome';
	margin-right: 10px;
}

.chart-blk p.update-time:before{
	content: "\f017";	
}

.chart-blk p.total:before{
	content: "\e473";	
}

.chart-blk p.note:before{
	content: "\f06a";
}

/*各式標籤樣式設定*/
td .badge-score, td .badge-incomplete{
	width: 100% !important;
	text-align: center !important;
}

.badge-first-diag, .badge-second-diag,
.badge-normal, .badge-abnormal{
	color: #212529;
	border: none;
}

.badge-first-diag{
	background: #FCBDBD;
}

.badge-second-diag{
	background: #A1E3F9;
}

/*正常狀態*/
.badge-normal{
	color: #ffffff;
	background: #3EA441; /*#2670FF*/
}

/*異常狀態*/
.badge-abnormal{
	background: #FFD233;
}

/*輕度、中度、重度狀態*/
.badge-mild, .badge-moderate, .badge-severe, .badge-incomplete{
	font-size: 16px !important;
	color: #ffffff;
}

.badge-mild{
	background: #19B83C;
}

.badge-moderate{	
	background: #eb9d17;
}

.badge-severe{
	background: #eb4034;
}

.badge-incomplete{
	background: #999999;
}

.badge-incomplete:before{
	font-family: FontAwesome;
    content: "\f044";
    margin-right: 5px;
}

.badge-checkin{
	border: 1px solid #777;
	background: #ffffff;
	color: #777;	
}

.badge-tag, .badge-checkin{
	padding: 5px 7px;
}

.badge-tag, .badge-checkin{
	font-size: 14px;
	border-radius: 5px;	
}

.badge-tag:not(.badge-first-diag):not(.badge-second-diag):not(.badge-normal):not(.badge-abnormal){
	width: max-content;
	text-align: left;
	white-space: break-spaces;
}

.badge-score{
	font-size: 16px;
}
/*
.badge-score:before{
	font-family: FontAwesome;
    content: "\f682";
    margin-right: 5px;
}*/

/* 制式block與標題樣式 */
.default-blks{
	display: flex;
	justify-content: space-between;
	padding: 0 5px;
	margin-bottom: 10px;
}

.default-blk, .ques-blk{	
	border-radius: 5px;
	border: 1px solid #bfbfbf;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 10px;	
	height: auto;
}

.default-blk .title{
	color: #009E75;
	font-size: 18px;
	font-weight: 600;
	display: flex;
	align-items: center;	
}

.default-blk:not(.history-blk) .title{
	justify-content: space-between;
}

.default-blk .title p{
	font-size: inherit;
	display: inline;
	margin: 0 10px 0 0;
}

.default-blk .title span{
	background-color: #00CB96; 
    color: #ffffff;
    margin-left: 10px;
    padding: 2px 10px;
    border-radius: 5px;
    font-size: 16px;
}

.ques-blk{	
	position: relative;
	border: 1px solid #d9d9d9 !important;
	box-shadow: none !important;
	padding: 10px 5px;
	margin: 0 auto !important;
	margin-bottom: 5px !important;
}

/* fixed-table 設定 */
.table-fixed{
	margin-top: 5px;
	margin-bottom: 10px;
}

.table-fixed tbody{
	width: 100%;
	max-height: 210px;
    overflow-y: auto;
    display: block;
}

.table-fixed thead tr th,
.table-fixed tbody td{
	/*float: left;*/
}

.table-fixed tbody td{
	border-bottom: 0.5px solid #cccccc !important;
}

.table-fixed thead tr th{
	background: #f2f2f2;
	border-bottom: 1.5px solid #808080 ;
}

.table-fixed tbody tr:hover td{
	cursor: pointer;
	background: #d9d9d9 !important;
}

.table-fixed tbody tr.selected td{
	cursor: pointer;
	background: #fff2b3 !important;
}

.table-fixed tbody tr.selected td:first-child{
	border-left: 5px solid #cc6600;
}

.table-fixed tbody tr:nth-child(even) td{
	background-color: rgba(242, 242, 242, 0.4);
}

.table-fixed thead, .table-fixed tbody, .table-fixed tr{
    width: 100%;
}

.table-fixed thead, .table-fixed tbody tr{
	display: flex;
}

.table-fixed thead tr{
	display: inherit;
}

.table-fixed tbody tr{
	height: fit-content;
	align-items: center;
}

.table-fixed thead tr th, .table-fixed tbody tr td {
	display: flex;
	align-items: center;
	align-self: stretch;
    box-sizing: border-box;
}

.overflowY{
	overflow-y : auto;
}

/* 出生日期擴充設定 */

.date-dropdowns{
	display: flex;
	justify-content: space-between;
	gap: 10px;
	align-items: center;
}

/* 指引箭頭樣式 */

.arrow {
    display: block;
    width: 0;
    height: 0;
    border: 15px solid transparent;
    margin: 5px auto; /* 居中 */
}

.arrow.arrow-right {
    border-left-color: #ccc;
    border-right-width: 0;
}

.arrow, .history-blk{
    display: none;
}

/* 無內容顯示樣式 */
.cnt-empty{
	width: 100%;
	min-height: 100px;
	background: #f2f2f2;
	color: #666666;
	margin-top: 5px;
	font-size: 16px;
	font-weight: 600;
	display: flex; /* 使用 Flexbox */
    align-items: center; /* 垂直居中 */
    justify-content: center; /* 水平居中 */
}

/* 客製化選項樣式 */
.option{
	display: inline-block;
	margin-bottom: 5px;
	font-size: 16px;
	border: 1px solid #a6a6a6;
	border-radius: 5px;
	padding: 5px 10px;
	cursor: pointer;
}

.option:not(.option--disabled):not(.selected):hover{
	color: #595959;
	background: #e6e6e6;
	border: 1px solid #595959;
	font-weight: 600;
}

.option.selected{
	color: #4d4d4d;
	background: #fbe29d;	
	font-weight: 600;
	/*border: 1px solid #d38c12;*/
}

.question-grp select, .question-grp input, .therapist-options{
	margin-top: 5px;
}

/* 輸入框及選擇框無法編輯之設定 */

input[type="text"][readonly], input[type="text"]:disabled, select:disabled{
	background-color: #ffffff !important;
}

/* 提示訊息框架設計 */
.info-message{
	width: 100%;
	height: 100%;
	display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: #f2f2f2;
}

.info-message i{
	font-size: 48px;
	margin-bottom: 10px;
}

.info-message span{
	font-size: 18px;
	font-weight: 600;
}

</style>

<script>
var lastZoom = getZoomLevel();

function adjustHeight() {
    var containerHeight = $('.content-blk').height();
    var topHeight = $('.top-bar').outerHeight(true);
    var subHeight = $('.sub-bar').outerHeight(true);
    var cntHeight = containerHeight - topHeight - subHeight;

    $('.main-content').height(cntHeight);
}

function getZoomLevel() {
  	return (window.outerWidth / window.innerWidth) || 1;
}

function applyZoom(wrapperSelector) {
  	var zoom = getZoomLevel();
  	console.log("Zoom level:", zoom);
  	if (zoom !== 1) {
    	var scale = 1 / zoom;
    	var zoomPercent = zoom * 100;
    	$(wrapperSelector).css({
      		transform: `scale(` + scale + `)`,
      		'transform-origin': 'top left',
      		width: zoomPercent + '%',
      		height: zoomPercent + '%'
		});
  	}else{
  		$(wrapperSelector).css({
          	transform: '',
          	'transform-origin': '',
          	width: '',
          	height: ''
        });
  	}
}

function monitorZoom(wrapperSelector) {
	var lastZoom = getZoomLevel();
    applyZoom(wrapperSelector); // 初始套用

    $(window).on('resize', function () {
        var newZoom = getZoomLevel();
        if (Math.abs(newZoom - lastZoom) > 0.05) {
          	lastZoom = newZoom;
          	applyZoom(wrapperSelector);
        }
    });
}

$(document).ready(function() {
    adjustHeight();
	console.log("Screen Width:", window.screen.width, "Screen Height:", window.screen.height);
	console.log("Initial Zoom level:", getZoomLevel());
	
	// 監控縮放變化並套用樣式
	monitorZoom('.zoom-wrapper');

    // 當窗口大小改變時，重新計算高度
    $(window).resize(function() {
        adjustHeight();
    });

    // 如果內容動態變化，則需要手動調用adjustHeight()
    $('.top-bar, .sub-bar').on('DOMSubtreeModified', function() {
        adjustHeight();
    });
});
</script>

<div class="modal fade" id="archiveModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:400px;">
		<div class="modal-content" >
			<div class="modal-header">
				<@spring.message "leftnav.label.switchCase"/>
				<button type="button" class="close clean" data-dismiss="modal" data-form="0" aria-label="Close">
		          	<i class="fa fa-xmark" aria-hidden="true"></i>
		        </button>
			</div>
			<div class="modal-body">
				<table class="info info-style-2" style="width: 100%">
					<tr>
						<td><@spring.message "leftnav.label.caseChoose"/></td>
						<td>
							<select class="form-control patient-code" /></select>
						</td>						
					</tr>
				</table>              
			</div>
			<div class="modal-footer">         
				<button class="func-btn" onclick="updateArchiveInfo()"><@spring.message "leftnav.button.update"/></button>
				<button class="clean func-btn" data-dismiss="modal"><@spring.message "leftnav.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>
<#if field_abbrev_ename == "TOYUAN">
	<#assign logo = "logo_taoyuan">
<#elseif field_abbrev_ename == "TZUCHI">
	<#assign logo = "logo_tzuchi">
<#elseif field_abbrev_ename == "TPECH">
	<#assign logo = "logo_tpech">
<#elseif field_abbrev_ename == "SHH">
	<#assign logo = "logo_shh">
<#elseif field_abbrev_ename == "WFH">
	<#assign logo = "logo_wfh">
<#elseif field_abbrev_ename == "YSH">
	<#assign logo = "logo_ysh">
<#elseif field_abbrev_ename == "NTGL">
	<#assign logo = "logo_ntgl">
<#elseif field_abbrev_ename == "FUSION">
	<#assign logo = "logo_fusion">
<#elseif field_abbrev_ename == "LIEYU">
	<#assign logo = "logo_lieyu">	
<#else>
	<#assign logo = "logo_itri">
</#if>
<#assign roleName = "">

<#list currentUser.roles as role>
    <#if role.alias == "DOCTOR">
        <#assign roleName = "醫師">
        <#break>
    <#elseif role.alias == "DTX_PSY" && roleName != "醫師">
        <#assign roleName = "心理治療師">
	<#elseif role.alias == "DTX_ST" && roleName != "醫師">
		<#assign roleName = "語言治療師">
	<#elseif role.alias == "DTX_OT" && roleName != "醫師">
		<#assign roleName = "職能治療師">
	<#elseif role.alias == "DTX_PI" && roleName != "醫師">
		<#assign roleName = "物理治療師">
	<#elseif role.alias == "CASE" && roleName != "醫師">
		<#assign roleName = "個案">
    <#elseif role.alias == "ADMIN" && roleName == "">
        <#assign roleName = "系統管理員">
    </#if>
</#list>

<body>
	<div class="zoom-wrapper">
		<div class="sidebar active">
			<div class="logo_content">
				<div class="logo"><!--<span>IMAS</span>-->
					<!--<i class="fa fa-bars"></i>-->
					<div class="logo_name ${logo}"></div>
				</div>
				<i class="fa fa-bars" id="btn"></i>	
			</div>
			<#if roleName == "個案">
			<nav id="sitemaps">
				<ul class="nav_list">
					<li>
						<a href="/ftl/casetraining/caseDashboard" class="active">
							<i class="fa fa-home" ></i>
							<span class="links_name"><@spring.message "leftnav.menu.homepage"/></span
							<i class="fa fa-caret-down arrow-rotate" ></i>
						</a>
						<ul class="sub-menu show">
							<li><a href="/ftl/casetraining/caseDashboard"><@spring.message "leftnav.submenu.review"/></a></li>
						</ul>
					</li>
				</ul>
			</nav>
			<#else>
			<nav id="sitemaps">
				<ul class="nav_list">
					<li>
						<a href="#"<#if menuNum == 1>class="active"</#if>>
							<i class="fa fa-home" ></i>
							<span class="links_name"><@spring.message "leftnav.menu.homepage"/></span>
							<i class="fa fa-caret-down<#if menuNum == 1> arrow-rotate</#if>" ></i>
						</a>
						<ul class="sub-menu<#if menuNum == 1> show</#if>">
					        <li><a href="/ftl/imas/dashboard"><@spring.message "leftnav.submenu.review"/></a></li>
					        <!--<li><a href="#" onclick="readCard()"><@spring.message "leftnav.submenu.readcard"/></a></li>-->
					        <li><a href="${base}/${__lang}/division/web/patient/new"><@spring.message "leftnav.submenu.case.create"/></a></li>
					        <li><a href=""><@spring.message "leftnav.submenu.appointment"/></a></li>
				      	</ul>
					</li>
					<li>
						<a href="#"<#if menuNum == 2>class="active"</#if>>
							<i class="fa fa-clipboard-list" ></i>
							<span class="links_name"><@spring.message "leftnav.menu.casemgnt"/></span>
							<i class="fa fa-caret-down<#if menuNum == 2> arrow-rotate</#if>" ></i>
						</a>
						<ul class="sub-menu<#if menuNum == 2> show</#if>">
					        <li><a href="/ftl/imas/casemgnt/caselist"><@spring.message "leftnav.submenu.caselist"/></a></li>
				      	</ul>
					</li>	
					<li>	
						<a href="#"<#if menuNum == 3>class="active"</#if>>
							<i class="fa fa-message" ></i>
							<span class="links_name"><@spring.message "leftnav.menu.communication"/></span>
							<i class="fa fa-caret-down<#if menuNum == 3> arrow-rotate</#if>" ></i>
						</a>
						<ul class="sub-menu<#if menuNum == 3> show</#if>">
					        <li><a href="${base}/${__lang}/division/web/communication/chatroom"><@spring.message "leftnav.submenu.group.meeting"/></a></li>
				      	</ul>
					</li>	
					<li>	
						<a href="#"<#if menuNum == 4>class="active"</#if>>
							<i class="fa fa-file-medical" ></i>
							<span class="links_name"><@spring.message "leftnav.menu.exchange"/></span>
							<i class="fa fa-caret-down<#if menuNum == 4> arrow-rotate</#if>" ></i>
						</a>
						<ul class="sub-menu<#if menuNum == 4> show</#if>">
					        <li><a href="${base}/${__lang}/division/web/exchange/hcRecordMgnt"><@spring.message "leftnav.submenu.hcmgnt"/></a></li>
					        <li><a href="${base}/${__lang}/division/web/exchange/ltcRecordMgnt"><@spring.message "leftnav.submenu.ltcmgnt"/></a></li>
					        <li><a href="${base}/${__lang}/division/web/exchange/fhir"><@spring.message "leftnav.submenu.fhir"/></a></li>
				      	</ul>
					</li>
					<li>	
						<a href="#"<#if menuNum == 5>class="active"</#if>>
							<i class="fa fa-line-chart" ></i>
							<span class="links_name"><@spring.message "leftnav.menu.report"/></span>
							<i class="fa fa-caret-down<#if menuNum == 5> arrow-rotate</#if>" ></i>
						</a>
						<ul class="sub-menu<#if menuNum == 5> show</#if>">
					        <!--<li><a href="${base}/${__lang}/division/web/report/diagnosis"><@spring.message "leftnav.submenu.diagnosis"/></a></li>-->
					        <li><a href="${base}/${__lang}/division/web/report/result"><@spring.message "leftnav.submenu.result"/></a></li>
					        <li><a href="${base}/${__lang}/division/web/report/basic"><@spring.message "leftnav.submenu.basic"/></a></li>
					        <li><a href="${base}/${__lang}/division/web/report/sectionIndex"><@spring.message "leftnav.submenu.sectionIndex"/></a></li>
					        <li><a href="${base}/${__lang}/division/web/report/caseIndex"><@spring.message "leftnav.submenu.caseIndex"/></a></li>
					        <li><a href="/ftl/imas/dtxanalysis"><@spring.message "leftnav.submenu.lessonIndex"/></a></li>
				      	</ul>
					</li>	
					<li>	
						<a href="#"<#if menuNum == 6>class="active"</#if>>
							<i class="fa fa-gear" ></i>
							<span class="links_name"><@spring.message "leftnav.menu.administrative"/></span>
							<i class="fa fa-caret-down<#if menuNum == 6> arrow-rotate</#if>" ></i>
						</a>
						<ul class="sub-menu<#if menuNum == 6> show</#if>">
							<li><a href="/ftl/imas/admin/taskMgnt/personal"><@spring.message "leftnav.submenu.task"/></a></li>
					        <li><a href="/ftl/imas/admin/userRoleMgnt/role"><@spring.message "leftnav.submenu.userRolemgnt"/></a></li>
					        <li><a href="/ftl/imas/admin/other/phraseMgnt"><@spring.message "leftnav.submenu.othermgnt"/></a></li>				        
				      	</ul>
					</li>
				</ul>		
			</nav>
			</#if>
			<div class="intro_content">
				<span><@spring.message "leftnav.label.copyright"/></span>
			</div>
		</div>
		<div class="content-blk">
			<!-- 上方內容放置區(如：導覽列、使用者與網頁介紹) -->
			<div class="top-bar">
				<div class="route pull-left">
					<ol id="breadcrumbs"></ol>
				</div>	
				<div class="pull-right">
					<!--<div class="archive-info" onclick="setArchivePatient()">
						<i class="fa fa-shuffle"></i>
						<@spring.message "leftnav.label.nowArchiveCase"/> <span></span>
					</div>
					<div class="message-alert">
						<i class="fa fa-bell"></i>
						<span class="message-item"></span>
					</div>-->
					<div class="user-info">
						<i class="fa fa-user"></i>
						${roleName!""} - ${currentUser.username!""}
						<div class="dropdown">
						  	<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
						  	<div class="menu-item dropdown-menu" aria-labelledby="dropdownMenuButton">
						    	<a class="dropdown-item" onclick="logout()"><@spring.message "leftnav.button.logout"/></a>
						  	</div>
						</div> 
					</div>	 	
				</div>
			</div>