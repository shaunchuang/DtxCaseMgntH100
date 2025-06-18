<#import "/util/spring.ftl" as spring />
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
<link href="${base}/style/imas/widget/evaluation.css" rel="stylesheet" type="text/css">

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




<style>

body{
	margin: 0;
  	padding: 0;
  	height: 100%;
  	overflow: hidden;
}

/* 頁面整體架構設定 */

.custom-navbar{
	display: flex;  /*移除語言列補上*/
	align-items: center;  /*移除語言列補上*/
	background: #f2f2f2;
	min-height: 0;
	height: 50px;
	padding: 5px 0;
}

.custom-navbar{
	left: 0;
	top: 0;
	width: 100%;
	position: fixed;
	justify-content: space-between;
	margin-left: auto;
	margin-right: auto;
	padding: 0 15px;
	z-index: 1000;
}

.wrapper {
	position: relative;
	top: 160px;
	bottom: 60px;
    width: 100%;
    height: calc(100% - 220px);  /* 減掉 custom-navbar 的高度 */
    overflow-y: auto;  /* 內容超過時上下滾動 */
    padding: 0.5rem;
}

.wrapper.form-success .container h1 {
    transform: translateY(85px);
}

.top-bar{
	background: #00BE8C;
	color: #555;
	height: 40px;
	line-height: 40px;
	padding: 0 20px;
	font-weight: 600;
}

.main-content{
	width: 90%;
	margin: 0 auto;
}

.main-content h3{
	display: block;
}

.main-content form{
    /*text-align: center;*/
    position: relative;
}

.footer-btn-list button, tr td button:not(.func-btn-custom),
.modal-footer button, .evaluation-top-bar button{
	/*border: 1px solid #808080 !important;*/
}

.title-hint{
	text-align: center;
	padding: 5px 0;
	margin-bottom: 5px;
	border-radius: 5px;
	font-size: 16px;
	font-weight: 600;
	background: #e6e6e6;
	color: #4d4d4d
}

/** logo 設定 **/
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

.user-info{
	font-size: 15px;
}

.user-info:before{
	font-family: 'FontAwesome';
	margin-right: 5px;
	content: "\f007";
}


/* scroll滾動 width */
::-webkit-scrollbar {
  	height: 5px;
  	width: 5px;
}

/* scroll滾動 Track */
::-webkit-scrollbar-track {
  	background: #e6e6e6; 
}
 
/* scroll滾動 Handle */
::-webkit-scrollbar-thumb {
  	background: #bfbfbf; 
}

/* scroll滾動 hover */
::-webkit-scrollbar-thumb:hover {
  	background: #999999; 
}

/*  各模組共用區  */
.d-flex{
	display: flex !important;
}

.justify-content-between{
	justify-content: space-between!important;
}

.m-auto{
	margin: auto;
}

.col-3{
	width: 24%;
}

.col-4{
	width: 32%;
}

.col-5{
	width: 40%;
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

.col-xs-6-5{
	width: 54.1666%;
}

.col-xs-7-5{
	width: 62.5%;
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

.pd-h-20{
	padding-left: 20px;
	padding-right: 20px;
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

.mg-0{
	margin: 0;
}

.mg-5{
	margin: 5px;
}

.mg-10{
	margin: 10px;
}

.mg-v-5{
	margin: 5px 0;
}

.mg-v-10{
	margin: 10px 0;
}

.mg-left-5{
	margin-left: 5px;
}

.mg-right-5{
	margin-right: 5px;
}

.mg-top-5{
	margin-top: 5px;
}

.mg-top-10{
	margin-top: 10px;
}

.mg-b-5{
	margin-bottom: 5px !important;
}

.mg-b-10{
	margin-bottom: 10px !important;
}

.w-60{
	width: 60% !important;
}

.w-70{
	width: 70% !important;
}

.w-75{
	width: 75% !important;
}

.w-80{
	width: 80% !important;
}

.w-85{
	width: 85% !important;
}

.w-90{
	width: 90% !important;
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

.flex-label{
	display: flex;
	align-items: center;	
}

.flex-label input{
	margin: 0 5px 0 0;
	zoom: 1.5;
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
	display: none !important;
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

.main-table thead, .sub-table thead{
	border-bottom: 2px solid #808080;
}

div.dataTables_paginate{
	float: none;
}

/*基本表單、不具分頁功能的table*/
.default-table{
	width: 100%;
	max-width: 100%;
	margin: 0 auto;
}

.d-fixed-table{
	table-layout: fixed;  /*後來補的*/
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
	position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    background-color: #fff;
    padding: 10px 20px;
    z-index: 999;
    box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    gap: 10px;
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
	font-size: 18px;
	color: #009e75;
	font-weight: 600;
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
}

.dropdown-toggle, .dropdown-toggle:hover,
.dropdown-toggle:focus, .dropdown-toggle:focus-visible{
	background-color: #f2f2f2 !important;
	border-color: #f2f2f2 !important;
	color: #000000 !important;
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

/* 出生日期擴充設定 */
.date-dropdowns,
.inline-container{
	display: flex;
	justify-content: space-between;
	gap: 10px;
	align-items: center;
}


/** 告知訊息背景設定 **/
.card-hint{
	background: #fff7e6;
	color: #996600;
	padding: 10px;
	margin-bottom: 10px;
	font-size: 1.6rem;
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

/* 按鈕客製化 */
.func-btn {
  	display: inline;
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

.func-btn:hover{
	background: #f2f2f2 !important;
	font-weight: 600 !important;
	text-decoration: none  !important;
	cursor: pointer;
}

.btn-border{
	border: 1px solid #808080 !important;	
}

.func-btn:not(.func-btn-edit):not(.func-btn-prev):not(.func-btn-next):not(.func-btn-appo):not(.func-btn-cancel):hover{
	background: #f2f2f2 !important;
	font-weight: 600 !important;
	text-decoration: none  !important;
	cursor: pointer;
}

.func-btn-prev, .func-btn-next, .func-btn-appo, .func-btn-cancel{
	color: #ffffff;
	font-size: 16px;
	font-weight: 600;
	text-shadow: 1px 1px 0 #444;
	padding: 10px 25px;
}

.func-btn-edit, .func-btn-prev{
	background: linear-gradient(274.95deg, #757575 9.04%, #A6A5A5 103.11%);
}

.func-btn-prev, .func-btn-appo, .func-btn-cancel{
	display: none;
}

.func-btn-next, .func-btn-appo, .func-btn-cancel{
	background: linear-gradient(92.64deg, #01CB96 0%, #029D74 90.03%);
}

.func-btn-edit:hover, .func-btn-prev:hover{
	background: linear-gradient(274.95deg, #595959 9.04%, #8C8C8C 103.11%) !important;
}

.func-btn-next:hover, .func-btn-appo:hover, .func-btn-cancel:hover{
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

/* 狀態標示客製化 */
.badge-finish, .badge-no-result{
	font-size: 16px;
	border: 1px solid #777;
	border-radius: 5px;
	padding: 5px 7px;
	background: #ffffff;
	color: #777;
}

.badge-finish:before{
	font-family: FontAwesome;
    content: "\f058";
    margin-right: 5px;
    color: #19B83C;
}

.badge-incomplete{
	background-color: #999999;
    color: white;
}

.badge-incomplete:before{
	font-family: FontAwesome;
    content: "\f044";
    margin-right: 5px;
}

/*輕度、中度、重度狀態*/
.badge-mild, .badge-moderate, .badge-severe{
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

.badge-tag{
	font-size: 16px;
	border-radius: 5px;	
	padding: 5px 7px;
}

.badge-tag:not(.badge-first-diag):not(.badge-second-diag):not(.badge-normal):not(.badge-abnormal){
	width: max-content;
	text-align: left;
	white-space: break-spaces;
}

/** 表單設定樣式 **/
.inline-container span{
	white-space: pre;
	font-weight: 600;
}

fieldset{
	width: 100%;
}

fieldset:first-of-type{
    display: block;
}

fieldset:nth-of-type(n+2) {
    display: none;
}

/* 填寫步驟設定 */
.progress-bar-wrapper{
	position: fixed;
    top: 50px; /* 高度與 .custom-navbar 相同 */
    left: 0;
    width: 100%;
    padding-top: 10px;
    background: #fff;
    z-index: 999;
}

.custom-progress-bar{
    width: 70%;
    margin: 0 auto 15px auto;
    overflow: hidden;
    color: lightgrey;
    display: flex;
    justify-content: center;
    padding-left: 0;
}

.custom-progress-bar .active{
    color: #00BE8C;
}

.custom-progress-bar .done{
    color: #00BE8C;
}

.custom-progress-bar .touched{
    color: #aafae5;
}

.custom-progress-bar li{
    list-style-type: none;
    font-size: 15px;
    width: 33%;
    position: relative;
    font-weight: 400;
    text-align: center;
}

.custom-progress-bar li[name="info"]:before,
.custom-progress-bar li[name="phealth"]:before,
.custom-progress-bar li[name="problem"]:before,
.custom-progress-bar li[name="evaluation"]:before,
.custom-progress-bar li[name="appo"]:before{
	font-family: FontAwesome;
}

.custom-progress-bar li[name="info"]:before{
    content: "\f007";
}

.custom-progress-bar li[name="phealth"]:before{
    content: "\e500";
}

.custom-progress-bar li[name="problem"]:before{
    content: "\f071";
}

.custom-progress-bar li[name="evaluation"]:before{
    content: "\f328";
}

.custom-progress-bar li[name="appo"]:before{
    content: "\f133";
}

.custom-progress-bar li:before{
    width: 50px;
    height: 50px;
    line-height: 45px;
    display: block;
    font-size: 20px;
    color: #ffffff;
    background: lightgray;
    border-radius: 50%;
    margin: 0 auto 10px auto;
    padding: 2px;
}

.custom-progress-bar li:nth-child(n+2):after{
    content: '';
    width: 100%;
    height: 10px;
    background: lightgray;
    position: absolute;
    left: -50%;
    top: 20px;
    z-index: -1;
}

.custom-progress-bar li.active:before,
.custom-progress-bar li.active:after{
    background: #00BE8C;
}

.custom-progress-bar li.done:before,
.custom-progress-bar li.done:after{
    background: #00BE8C;
}

.custom-progress-bar li.touched:before,
.custom-progress-bar li.touched:after{
    background: #aafae5;
}

.custom-progress-bar li.active.done,
.custom-progress-bar li.active.touched {
    color: #00BE8C; /* Active 覆蓋 Done 或 Touched */
}

.custom-progress-bar li.active.done:before,
.custom-progress-bar li.active.done:after,
.custom-progress-bar li.active.touched:before,
.custom-progress-bar li.active.touched:after {
    background: #00BE8C; /* Active 覆蓋 Done 或 Touched */
}

/* fixed-table設定 */
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
	display: flex;
	align-items: center;
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
}

.table-fixed thead tr th, .table-fixed tbody tr td {
    box-sizing: border-box;
}

.overflowY{
	overflow-y : auto;
}

/* 制式block與標題樣式 */
.default-blks{
	display: flex;
	justify-content: space-between;
	padding: 0 5px;
	margin-bottom: 10px;
}

.default-blk{	
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
}

.default-blk .title p{
	font-size: inherit;
	display: inline;
	margin: 0 10px 0 0;
}

.default-blk .title{
	display: flex;
	align-items: center;
}

.default-blk:not(.history-blk) .title{
	justify-content: space-between;
}

.default-blk .title span{
	background-color: #00CB96; 
    color: #ffffff;
    margin-left: 10px;
    padding: 2px 10px;
    border-radius: 5px;
    font-size: 16px;
}

.evaluation-blk{
	text-align: left;
}

.evaluation-blk .evaluation{
	height: 350px;
	max-height: 350px;
}

.appointment-blks{
	display: flex;
	justify-content: space-between;
	padding: 0 5px;
	margin: 0 auto;	
}

/* 指引箭頭樣式 */

.arrow-icon {
    display: block;
    width: 0;
    height: 0;
    border: 15px solid transparent;
    margin: 5px auto; /* 居中 */
}

.arrow-icon.arrow-right {
    border-left-color: #ccc !important;
    border-right-width: 0 !important;
}

/* 醫師選單 */

.doctor-list {
	width: 100%;
	height: 100%;
	max-height: 400px;
    overflow-y: auto;
    white-space: nowrap;
    margin: 0 auto;
    padding: 10px 0;
    border: 1px solid #bfbfbf;
    border-radius: 5px;
}

.doctor-card {
	position: relative;
    width: 130px;
    height: auto;
    border: 1px solid #ccc;
    background: #f2f2f2;
    border-radius: 4px;
    display: block;
    margin: 0 auto;
    margin-bottom: 5px !important;
    overflow: hidden;
    cursor: pointer;
    text-align: center;
}

.doctor-card img {
    width: 80px;
    height: 80px;
    margin: 5px 0;
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
    transition: transform 0.3s ease;
}

.doctor-card .doctor-name {
    font-size: 16px;
    font-weight: bold;
	text-align: center;
	padding: 2px 5px;
	border-top: 0.5px solid #cccccc;
}

.doctor-card.selected .doctor-name{
	background: #d38c12;
	color: #ffffff;
	font-weight: 600;
	border: 1px solid #d38c12;
	text-shadow: 1px 1px 0 #444;	
}

.doctor-card:not(.selected):hover .doctor-name{
	background: #8c8c8c;
	color: #ffffff;
	border: 1px solid #8c8c8c;
}

.notion-alert{
	display: none;
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

.option{
	display: inline-block;
	margin-bottom: 5px;
	font-size: 16px;
	border: 1px solid #a6a6a6;
	border-radius: 5px;
	padding: 5px 10px;
	cursor: pointer;
}

.option--disabled{
	cursor: not-allowed;
}

/* 适用于input元素的样式 */
.editable-option {
  	outline: none;
  	width: fit-content;
}

.no-bord {
    border: 0 !important;
}

#myc-nav-container {
    margin: 5px;
}

.evalution-wrt {
    border: 1px solid #ccc;
    border-radius: 4px;
}

.color-grey{
	color: #777;
	font-weight: 600;
	font-size: 16px;
}

/* 個案基本資料樣式 */
.card-topic{
	font-size: 1.5rem;
	margin-bottom: 10px;
	background: linear-gradient(to right, #d9d9d9, #ffffff);
	color: #404040;
	padding: 5px;
	font-weight: 600;
}

.card-topic:before{
	font-family: 'FontAwesome';
	margin-right: 5px;
	content: '\f0c8';
}

.card{
	margin: auto;
	border-radius: 5px;
	/*box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);*/
}

.card .row{
	margin-bottom: 10px;
}

.form-req .form-label::after{
	content: '*';
	color: #ff0000;
	margin-left: 5px;
}

label.form-label{
	font-size: 1.6rem;
}

.divider{
	margin: 15px 0;
}

.inline-cotainer{
	display: flex;
	gap: 5px;
}

.inline-cotainer select,
.inline-cotainer button{
	display: inline-block;
}

.inline-cotainer select{
	/*width: calc(100% - 180px);*/
	min-width: 150px;
}

.inline-cotainer button{
	margin-left: auto;
  	margin-right: 0;
}

/* 這段會讓 swal 的內容訊息文字改為左對齊 */
.sweet-alert p {
    text-align: left !important;
    padding: 0 10px;
}


@media (max-width: 992px){
	.card .row{
		margin-bottom: 0px;
	}
	
	.form-label {
	  	margin-top: 10px;
	}
	
	.row:first-of-type div:first-child .form-label {
	  	margin-top: 0;
	}
}

</style>

<body>
	<div class="custom-navbar">
		<div class="navbar-header logo_name">
					
		</div>
		<div class="navbar-multi-entry">
			<div class="user-info">${currentUser.username!""}</div>	
			<div class="dropdown">
			  	<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
			  	<div class="menu-item dropdown-menu" aria-labelledby="dropdownMenuButton">
			    	<a class="dropdown-item" onclick="logout()"><@spring.message "leftnav.button.logout"/></a>
			  	</div>
			</div>
		</div>
	</div>
	<div class="progress-bar-wrapper">
	    <ul class="custom-progress-bar">
	      	<li class="active" name="info"><strong>基本資料</strong></li>
	      	<li name="problem"><strong>描述困擾</strong></li>
	      	<li name="phealth"><strong>健康狀態</strong></li>	      	
	      	<li name="evaluation"><strong>量表評估</strong></li>
	      	<li name="appo"><strong>初診預約</strong></li>
	    </ul>
  	</div>	
	<div class="wrapper">
		<div class="main-content">
		    <form data-form-id="">		    		    
				<fieldset>		
					<div class="card w-60 pd-10">
						<div class="card-hint">請填寫個人真實且完整資訊，以利後續聯繫與資料建檔。<span class="text-danger">* 為必填欄位</span></div>
						<div class="form-group form-req">
							<label class="form-label"><@spring.message "view.label.name"/></label>
							<input type="text" class="dataForm form-control" data-item="3" value="${currentUser.username!""}" readonly="">
						</div>
						<div class="form-group form-req">
							<label class="form-label"><@spring.message "view.label.gender"/></label>
							<select class="dataForm form-control" data-item="4">
								<option value=""><@spring.message "view.option.select.hint"/></option>
								<option value="M"><@spring.message "view.option.male"/></option>
								<option value="F"><@spring.message "view.option.female"/></option>
							</select>
						</div>
						<div class="form-group form-req">
							<label class="form-label">身份證字號</label>
							<input type="text" class="dataForm form-control" data-item="2" >
						</div>
						<div class="form-group form-req">
							<label class="form-label">出生日期</label>
							<input type="hidden" class="dataForm form-control birth" data-item="6" data-date-end-date="0d" />
						</div>						
						<div class="form-group form-req">
							<label class="form-label">聯絡電話</label>
							<input type="text" class="dataForm form-control" data-item="7" value="${currentUser.telCell!""}" readonly="">
						</div>
						<div class="form-group form-req">
							<label class="form-label">緊急聯絡人</label>
							<input type="text" class="dataForm form-control" data-item="12" >
						</div>
						<div class="form-group form-req">
							<label class="form-label">緊急聯絡人關係</label>
							<select class="basicForm form-control" data-item="13">
								<option value="">選擇關係</option>
								<option value="GRFTH" ><@spring.message "view.option.grfth"/></option>
								<option value="GRMTH" ><@spring.message "view.option.grmth"/></option>
								<option value="INLAW" ><@spring.message "view.option.inlaw"/></option>
								<option value="FTH" ><@spring.message "view.option.fth"/></option>
								<option value="MTH" ><@spring.message "view.option.mth"/></option>
								<option value="UNCLE" ><@spring.message "view.option.uncle"/></option>
								<option value="AUNT" ><@spring.message "view.option.aunt"/></option>
								<option value="COUSN" ><@spring.message "view.option.cousn"/></option>
							</select>
						</div>
						<div class="form-group form-req">
							<label class="form-label">緊急聯絡電話</label>
							<input type="text" class="dataForm form-control" data-item="14">
						</div>								
						<div class="form-group">
							<label class="form-label">電子信箱</label>
							<input type="text" class="dataForm form-control" data-item="8" >
						</div>
						<div class="form-group">
							<label class="form-label">婚姻狀態</label>
							<select class="dataForm form-control" data-item="" >
								<option value="">請選擇</option>
								<option value="N">未婚</option>
								<option value="Y">已婚</option>
							</select>
						</div>
						<div class="form-group form-req">
							<label class="form-label">聯絡地址</label>
							<#if __lang == "zh_TW" >
							<div class="inline-cotainer">
								<div id="twzipcode" class="zipcode inline-cotainer"></div>
								<#else>
								<div class="zipcode inline-cotainer">
									<input type="text" name="country" placeholder="<@spring.message "view.placeholder.country"/>" class="dataForm form-control half" data-item="9">
									<input type="text" name="city" placeholder="<@spring.message "view.placeholder.capital"/>" class="dataForm form-control half" data-item="10">
								</div>
								</#if>
								<input type="text" class="dataForm form-control" data-item="11" >
							</div>
						</div>
					</div>
				</fieldset>
				<fieldset>
					<div class="card w-60 pd-10">
						<div class="card-hint">請簡單描述目前的主要困擾，您的描述將幫助我們推薦適合的初步評估問卷與安排合適的專業人員。<span class="text-danger">* 為必填欄位</span></div>
						<div class="form-group form-req">
							<label class="form-label">您主要有何症狀/問題?(擇一)</label>
							<div class="symdrome-options single-option">
								<input type="hidden" class="basicForm form-control" data-item="37" />
								<#list indications as indication>
								<div class="option" data-id="${indication.id}" >${indication.name}</div>
								</#list>
							</div>							
						</div>
						<div class="form-group form-req">
							<label class="form-label">請描述您所遇到的困難或問題(個案/家屬)</label>
							<textarea rows="3" class="form-control" placeholder="請根據您本身的狀況進行描述，將提供醫師/治療師參考"></textarea>							
						</div>					
					</div>
				</fieldset>
				<fieldset>
					<div class="card w-60 pd-10">
						<div class="card-hint">請提供目前健康相關資訊，您提供的資訊將有助於我們完整評估目前情況，必要時將協助分流安排更合適的服務。<span class="text-danger">* 為必填欄位</span></div>
						<div class="form-group form-req">
							<label class="form-label">個人病史</label>
							<div class="history-options multi-option">
								<#list personalDiseaseHistoryItems as pdhItems>
								<div class="option " data-item="${pdhItems.id}" >${pdhItems.name}</div>
								</#list>				                 	
		                    </div>
		                    <textarea rows="3" class="form-control" placeholder="請填寫其他個人病史"></textarea>
						</div>
						<div class="form-group form-req">
							<label class="form-label">藥物過敏史</label>
							<div class="allergy-history-options multi-option">
								<#list drugAllergyHistoryItems as dahItems>
								<div class="option" data-item="${dahItems.id}" >${dahItems.name}</div>
								</#list>
							</div>
							<textarea rows="3" class="form-control" placeholder="請填寫其他藥物過敏史"></textarea>
						</div>
						<div class="form-group">
							<label class="form-label">藥物使用狀況</label>
							<textarea rows="3" class="form-control" placeholder="請填寫其他藥物使用狀況"></textarea>
						</div>
					</div>
				</fieldset>								
				<fieldset>
					<div class="w-60 m-auto justify-content-between">  	
						<div class="card-hint">
							根據您所提供的基本資料與困擾描述，我們建議您可先完成以下量表並確認送出，若目前不方便填寫或暫無評估量表，可直接點選「下一步」跳過此階段。
						</div>		
		    			<div id="evaluation-container" class="evaluation"></div>						
		            </div>				
				</fieldset>
				<fieldset>
					<div class="appointment-blks w-80">
						<div class="col-3 pd-h-20">
							<div class="title-hint">預約看診掛號</div>
							<div class="doctor-list">
								<#if doctorInfos?? && (doctorInfos?size>0)>
								<#list doctorInfos as doctorInfo>
								<div class="doctor-card" data-doctor="${doctorInfo.id}">
									<#if doctorInfo.gender == "M">
		                            <img src="${base}/images/imas/role/doctor.png" class="card-img-top" alt="${doctorInfo.name}">
		                            <#else>
		                            <img src="${base}/images/imas/role/doctorFemale.png" class="card-img-top" alt="${doctorInfo.name}">
		                            </#if>	
		                            <div class="doctor-name">${doctorInfo.name}</div>
		                        </div>
								</#list>
								</#if>
	                        </div>
						</div>
						<div class="col-9">
			    			<div id="wg-Container" style="width:100%;"></div>
			    		</div>
					</div>				
				</fieldset>
			</form>
		</div>	
	</div>
	<div class="footer-btn-list">
	    <button class="func-btn func-btn-prev"><i class="fa fa-circle-arrow-left"> 上一步</i></button>
	    <button class="func-btn func-btn-next"><i class="fa fa-circle-arrow-right"> 下一步</i></button>
	    <button class="func-btn func-btn-appo"><i class="fa fa-calendar-check"> 預約</i></button>
		<button class="func-btn func-btn-cancel"><i class="fa fa-ban"> 暫不預約</i></button>
  	</div>
</body>
<script type="text/javascript">	
	
	// 利用fieldsets標籤觸發前一頁、下一頁
	var current_fs, next_fs, previous_fs; // fieldsets
	var opacity;
	var current = 1;
	var steps = $("fieldset").length;
	var optionNameArr = ['輸入其他個人病史', '輸入其他藥物過敏史'];
	var touchedSteps = [];


	$(document).ready(function(){
		//顯示日曆
		$(".birth").dropdownDatepicker({
			minYear: 1920 - 1911,
			maxYear: ${maxYear} - 1911,
			dayLabel: '日',
	        monthLabel: '月',
	        yearLabel: '年',
			onChange: function(day, month, year){
				if(year && month && day){
					var birth = [year, month, day].join('-');
					$(this).val(birth);
					countAge(".calAge", birth, true);
				}else{
					$(".calAge").val("");
				}
		    }
		});
		//
		<#if __lang == "zh_TW" >
		$("#twzipcode").twzipcode({
	    	zipcodeIntoDistrict: false
	    });	  
	    </#if>
	    
		wg.template.updateNewPageContent('wg-Container', 'therapist-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment/msg/chooseMessage?clinician=doctor');
	    
		wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {}, '/ftl/imas/admin/taskMgnt/evaluation/message?msg=emptyMessage');

	});
	
	/*相關選項點選變色*/
	$(".option").click(function() {
	    var $parent = $(this).parent("div");

        if ($parent.hasClass("single-option")) {
        	// 單選處理
	        $parent.find(".option").removeClass("selected");
	        $(this).addClass("selected");
	        $parent.find("input[type='hidden']").val($(this).attr("data-id"));
	    }else{
	        var $options = $parent.find(".option");
	        var isFirst = $(this).is($options.first());
	
	        // 點擊第一個 option
	        if (isFirst) {
	            if ($(this).hasClass("selected")) {
	                // 如果原本已選，取消選取並解除 disable
	                $(this).removeClass("selected");
	                $options.removeClass("option--disabled");
	            } else {
	                // 選取第一個，其他加上 disabled
	                $(this).addClass("selected");
	                $options.not($(this)).addClass("option--disabled").removeClass("selected");
	            }
	        } else {
	            // 點擊非第一個 option 時，若目前未被 disable，則切換選取狀態
	            if (!$(this).hasClass("option--disabled")) {
	                $(this).toggleClass("selected");
	            }
	        }
	    }
	});
	
	//醫師選擇點擊
	$(".doctor-card").click(function(e){
		e.preventDefault();

		$(this).parent().find(".doctor-card").removeClass("selected");
		$(this).toggleClass("selected");
		$("#wg-Container").empty();
		
		var doctorId = $(this).attr("data-doctor");
		wg.template.updateNewPageContent('wg-Container', 'therapist-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment/msg/chooseMessage?clinician=therapist&doctorId=' + doctorId);

	});

	//下一頁觸發
	$(".func-btn-next").click(function(e) {
		e.preventDefault();

		current_fs = $("form").find("fieldset:visible");
   		next_fs = current_fs.next("fieldset");
	    var api = current_fs.attr("data-api");
	    var stepPass = true;
	    var formId = $("form").attr("data-form-id") || null;
		var index = $('fieldset').index(current_fs);
		var itemNumArr, itemArray, queryData, result;

	    if (validateRequiredFields(current_fs) && next_fs.length) {

	    	if(index == 0){
	    		/*itemNumArr = getItemNumArray("default-table", "basicForm");
				itemArray = getItemValue("basicForm", itemNumArr);
	    		queryData = {"source": "case", "formName": "基本資料V2", "evalDate": getEditTime(), "app": "", "items": itemArray};		
				result = wg.evalForm.getJson({"data":JSON.stringify(queryData)}, api);
			    if(result.success){
			    	$("form").attr("data-form-id", result.id);
			    	stepPass = updateUserInfo(itemArray);
			    }*/
	    	}else{
	    		/*itemNumArr = getItemNumArray("default-table", "basicForm, multi-option .option");
				itemArray = getItemValue("basicForm, multi-option .option", itemNumArr);   		
	    		queryData = {"userFormKeyNo": formId, "items": itemArray};
	    		result = wg.evalForm.getJson({"data":JSON.stringify(queryData)}, api);
	    		if(result.success){
	    			stepPass = true;
	    			triggerAssessmentList();
	    		}*/
	    	}
	    	
	    	if(index == 2){
	    		triggerAssessmentList();
	    	}   	
	    	
	    	//通過驗證才可進行下關卡
	    	if(stepPass){
	    		current_fs.animate({opacity: 0}, {
		            step: function(now) {
		                current_fs.css('display', 'none');
		                next_fs.css({'opacity': 1 - now});
		            },
		            duration: 500,
		            complete: function() {
		                next_fs.show();
		
		                // ✅ 滾回 wrapper 的頂端
		                $(".wrapper").scrollTop(0);
		                
		                var totalSteps = $("fieldset").length;
    					var nextIndex = $("fieldset").index(next_fs);
    					console.log(nextIndex);
    					if (nextIndex > 0) {
					        $(".func-btn-prev").show();
					    } else {
					        $(".func-btn-prev").hide();
					    }
					    
					    if (nextIndex === totalSteps - 1) {
					        $(".func-btn-next").hide();
					        $(".func-btn-appo, .func-btn-cancel").show();
					    } else {
					        $(".func-btn-next").show();
					        $(".func-btn-appo, .func-btn-cancel").hide();
					    }
		            }
		        });
		        
		        //步驟條下一步顯示
		    	$(".custom-progress-bar li").eq($("fieldset").index(next_fs)).addClass("active");

	        }
        }
    }
	
	//按上一頁觸發
	$(".func-btn-prev").click(function(e) {
		e.preventDefault();
		
	    current_fs = $("form").find("fieldset:visible");
    	previous_fs = current_fs.prev("fieldset");
    	
	    if (previous_fs.length) {
	    	var totalSteps = $("fieldset").length;
        	var prevIndex = $("fieldset").index(previous_fs);
	        // Remove class active
	        $(".custom-progress-bar li").eq($("fieldset").index(current_fs)).removeClass("active");
	
			current_fs.animate({ opacity: 0 }, {
	            step: function(now) {
	                opacity = 1 - now;
	                current_fs.css('display', 'none');
	                previous_fs.css('opacity', opacity);
	            },
	            duration: 500,
	            complete: function() {
	                previous_fs.show();
	
	                // ✅ 滾回 wrapper 的頂端
	                $(".wrapper").scrollTop(0);
	
	                // 按鈕顯示邏輯
	                if (prevIndex > 0) {
	                    $(".func-btn-prev").show();
	                } else {
	                    $(".func-btn-prev").hide();
	                }
	
	                if (prevIndex === totalSteps - 1) {
	                    $(".func-btn-next").hide();
	                    $(".func-btn-appo, .func-btn-cancel").show();
	                } else {
	                    $(".func-btn-next").show();
	                    $(".func-btn-appo, .func-btn-cancel").hide();
	                }
	            }
	        });
	    }
	});
	
	function updateUserInfo(itemArray){
		var postData = {"userId": ${currentUser.id!""}, "items" : itemArray};
		var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/syncUserInfo");
		if(result.success) return true;
		return false;
	}
	
	function triggerAssessmentList(){
		var formId = $("form").attr("data-form-id");
		var symdromeId = $('.symdrome-options .option.selected').data('id');
		
		var postData = {"patientId": formId, "syndromeId": symdromeId, "isFromPatient": true};
	    var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/getCaseAssessmentList");
	    if(result.success){
	    	showAssessmentList(result.data);
	    }
	}
	
	//顯示個案評估量表列表
	function showAssessmentList(data, redirectId){
		
		if(data.length > 0){
			var patientId = $("form").attr("data-form-id");
			var formId = data[0].id;
	
			wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {"isFromPatient": true}, '/division/web/patient/' + patientId + '/evaluation/' + formId + '/edit');

		}else{
			wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {}, '/ftl/imas/admin/taskMgnt/evaluation/message?msg=nextStepMessage');

		}
	}
	
	//顯示特定評估量表結果
	function showAssessmentResult(redirectId){
		var patientId = $("form").attr("data-form-id");
		wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {"isFromPatient": true}, '/division/web/patient/' + patientId + '/evaluation/' + redirectId + '/view');
	}
	
	//預約看診並更改使用者(個案)狀態為APPROVED
	$(".func-btn-appo").click(function(e){
		e.preventDefault();
	
		var doctorId = $(".doctor-card.selected").attr("data-doctor");
		var slotId = $(".myc-available-time.selected").attr("data-unique");
		var formId = $("form").attr("data-form-id");
		
		if(doctorId == undefined || slotId == undefined){
			swal("送出失敗", "請再次確認是否有安排下次看診時間!", "error");
		}else{
			var api = "/WgTask/api/createNewAppo";
			var postData = {"userId": doctorId, "slotId": slotId, "cat": 1, "caseno": formId};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, api);
			
			if(result.success){
				var statusChanged = enableUserStatus();
				if(statusChanged){
					successToDirect("註冊完成", "系統自動導向首頁總覽中...", "success", 1500, "${base}/${__lang}/division/web/review");
				}
			}else{
				if(result.msg == undefined) result.msg = "無法預約看診時間!";
				swal("預約失敗", result.msg, "error");
			}
		}
	});
	
	$(".func-btn-cancel").click(function(e){
		e.preventDefault();
		
		var statusChanged = enableUserStatus();
		if(statusChanged){
			successToDirect("註冊完成", "系統自動導向首頁總覽中...", "success", 1500, "${base}/${__lang}/division/web/review");
		}else{
			swal("註冊失敗", "無法完成註冊，請洽工作人員!", "error");
		}
	});
	
	//變更使用者狀態
	function enableUserStatus(){
		var postData = {"userId": ${currentUser.id!""}, "enableApproved": true};
		var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/userApproved");
		return result.success;
	}
	
	//識別必要項目欄位填寫狀況
	function validateRequiredFields(scope) {
	    var missingFields = [];
	
	    scope.find('.form-req').each(function () {
	        var group = $(this);
	        var label = group.find('.form-label').first().text().trim();
	        var multiOptionLeng = group.find('.multi-option').length;
	        var singleOptionLeng = group.find('.single-option').length;
	
	        // 檢查 input, textarea, select (排除 type=hidden)
	        var inputsValid = true;
	        
	        if(multiOptionLeng == 0 && singleOptionLeng == 0){
		        group.find('input:not([type=hidden]), textarea, select').each(function () {
		            if ($(this).is('select')) {
		                if (!$(this).val()) inputsValid = false;
		            } else if (!$(this).val().trim()) {
		                inputsValid = false;
		            }
		        });
	        }
	
	        // 檢查 multi-option
	        if (multiOptionLeng > 0) {
	            var hasSelected = group.find('.multi-option .option.selected').length > 0;
	            if (!hasSelected) inputsValid = false;
	        }
	
	        // 檢查 single-option
	        if (singleOptionLeng > 0) {
	            var hasSelected = group.find('.single-option .option.selected').length > 0;
	            if (!hasSelected) inputsValid = false;
	        }
	
	        if (!inputsValid) {
	            missingFields.push(label);
	        }
	    });
	
	    if (missingFields.length > 0) {
	    	var message = missingFields.map(function(f) {
		        return '• ' + f;
		    }).join('\n');
		    
		    swal("請填寫以下必填欄位", message, "warning");

	        return false;
	    }
	
	    return true;
	}

</script>
