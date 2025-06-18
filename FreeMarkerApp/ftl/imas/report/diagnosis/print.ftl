<#import "/META-INF/spring.ftl" as spring />
<#import "/META-INF/mspring.ftl" as mspring />

<title>${field_name!""} - <@spring.message "diagnosis.print.label.title"/></title>
<script type="text/javascript" src="${base}/script/woundInfo/jquery.min.js"></script>
<script async type="text/javascript" src="${base}/script/woundInfo/bootstrap.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/utility.js"></script>
<script type="text/javascript" src="${base}/script/wg.evalForm.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/dataTables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/dataTables/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/html2canvas.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/canvas2image.js"></script>
<script>
	verify();
	
	function verify(){
		var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/multi/division/v1/api/verifyLogout");
		if(!result.success){
			location.href= "${base}/login";
		}
	}
</script>

<link href="${base}/style/woundInfo/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/style.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/dataTables/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/woundInfo/select.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/print.css" rel="stylesheet" type="text/css">

<body>
	<div class="navbar">
		<a class="navbar-title"><@spring.message "diagnosis.print.label.preview"/></a>
		<a class="pdf-upload"><@spring.message "result.print.button.pdf.download"/></a>  	
	</div>
	<div class="inner_content_info_agileits mt-5" style="text-algin: center">
		<div class="container-fluid">
			<div id="report" class="modal-body img-template">			
				<table class="certi-table">
					<tr>
						<td colspan="7">
							<div class="field-name">${field_name!""}</div>
							<div class="print-title"><@spring.message "diagnosis.print.label.certificate"/></div>
						</td>
					</tr>
					<tr>
						<td><@spring.message "diagnosis.print.label.name"/></td>
						<td colspan="2">${name!""}</td>
						<td class="b"><@spring.message "diagnosis.print.label.gender"/></td>
						<td>${gender!""}</td>
						<td class="b"><@spring.message "diagnosis.print.label.ptno"/></td>
						<td>${charNo!""}</td>
					</tr>
					<tr>
						<td><@spring.message "diagnosis.print.label.age"/></td>
						<td>${age!""} <@spring.message "diagnosis.print.label.age.unit"/></td>
						<td>${birth!""}</td>
						<td class="b"><@spring.message "diagnosis.print.label.idno"/></td>
						<td colspan="3">${idNo!""}</td>
					</tr>
					<tr>
						<td><@spring.message "diagnosis.print.label.address"/></td>
						<td colspan="6">${address!""}</td>
					</tr>
					<tr>
						<td><@spring.message "diagnosis.print.label.evalDate"/></td>
						<td colspan="2">${evalDate!""}</td>
						<td class="b"><@spring.message "diagnosis.print.label.division"/></td>
						<td colspan="3">${divisionName!""}</td>
					</tr>
					<tr>
						<td><@spring.message "diagnosis.print.label.diagnosis"/></td>
						<td colspan="6" class="icd-code"></td>
					</tr>
					<tr>
						<td><@spring.message "diagnosis.print.label.order"/></td>
						<td colspan="6" class="order"></td>
					</tr>
				</table>
				<div class="col-md-12 proof-text">
					<div class="hint"><@spring.message "diagnosis.print.label.hint"/></div>
					<div class="waring-info"><@spring.message "diagnosis.print.label.warningText"/></div>
					<div class="col-md-6 sign"><@spring.message "diagnosis.print.label.hospital.sign"/> </div>
					<div class="col-md-6 sign"><@spring.message "diagnosis.print.label.doctor.sign"/></div>
				</div>
				<div class="col-md-12 proof-date">
					${printDate!""}
				</div>	                   	
						 		
    		</div>  		  		  				               
		</div>
	</div>	
</body>

<script>

$(".pdf-upload").click(function () {
	document.title = "${field_name!""}_<@spring.message "diagnosis.print.label.pdfName"/>_${name!""}";
	window.print(); 
});

</script>

<style>

.proof-date{
	position: absolute;
	bottom: 50px;
	text-align: center;
}

.proof-date p{
	/*margin-left: 150px;*/
	display: inline;
	/*letter-spacing: 150px;*/
	font-size: 18px;;
}

.certi-table{
	width: 100%;
}

.certi-table tr td{
	border: 1px solid rgba(0, 0, 0, 0.4);
	padding: 8px;
	font-size: 18px;
}

.certi-table tr td:first-child,
.certi-table tr td.b{
	font-weight: 600;
	width: 1%;
    white-space: nowrap;
}

.field-name, .print-title{
	color: #000;
	font-size: 24px;
	width: 100%;
	display: block;
	text-align: center;
	font-weight: 600;
}

.print-title{
	margin: 5px 0px;
	/*letter-spacing: 5px;*/
}

.icd-code{
	height: 100px;
}

.order{
	height: 250px;
}

.proof-text, .sign, .proof-date{
	font-size: 18px;
	color: #000;
	padding-left: 0px;
	padding-right: 0px;
	left: 0;
	right: 0;
}

.proof-text .hint{
	padding-top: 10px;	
}

.waring-info{
	padding-top: 5px;
	padding-bottom: 100px;
}

.waring-info:before,
.waring-info:after{
	font-family: 'FontAwesome';
	font-weight: 600;
	content: '\f071';	
}

.waring-info:before{
	margin-right: 10px;
}

.waring-info:after{
	margin-left: 10px;
}

.img-template{
	height: 100%;
	text-align: unset
}

.print-btn:nth-child(1){
	bottom: 15mm;
}

@media print {
	.col-md-12, .col-md-6{
		float: left;
	}
	.col-md-12{
		width: 100%;
	}
	.col-md-6{
		width: 50%;
	}
	.proof-date{
		position: fixed;
	}
	html, body {
		margin: 0 !important; 
	    padding: 0 !important;
	    overflow: hidden;
	}
}
</style>