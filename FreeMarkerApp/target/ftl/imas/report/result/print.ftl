<#import "/META-INF/spring.ftl" as spring />
<#import "/META-INF/mspring.ftl" as mspring />

<title>${field_name!""} - <@spring.message "result.print.label.title"/></title>
<script type="text/javascript" src="${base}/script/woundInfo/jquery.min.js"></script>
<script async type="text/javascript" src="${base}/script/woundInfo/bootstrap.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/utility.js"></script>
<script type="text/javascript" src="${base}/script/wg.evalForm.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/dataTables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/dataTables/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/image-picker.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/Chart.bundle.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/chartjs-plugin-labels.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/html2canvas.min.js"></script>
<script type="text/javascript" src="${base}/script/woundInfo/canvas2image.js"></script>
<script>
	verify();
	
	function verify(){
		var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/verifyLogout");
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

<link href="${base}/style/woundInfo/image-picker.css" rel="stylesheet" type="text/css">
<link href="${base}/style/imas/print.css" rel="stylesheet" type="text/css">

<body>
	<div class="navbar">
		<a class="navbar-title"><@spring.message "result.print.label.preview"/></a>
		<a class="pdf-upload"><@spring.message "result.print.button.pdf.download"/></a>
		<a class="png-upload"><@spring.message "result.print.button.img.download"/></a>	  	
	</div>
	<div class="inner_content_info_agileits" style="text-algin: center">
		<div class="container-fluid">
			<div id="report" class="modal-body img-template">			
				<table class="title-header">
					<tr>
						<td class="logo" width="20%"><img class="hospital-logo" /></td>
						<td class="main-title" width="60%">${field_name!""} <span><@spring.message "result.print.label.report"/></span></td>
						<td class="load-time" width="20%">${resultResp.printTime!""}</td>
					</tr>
				</table>
	            <div class="card-deck">
            		<div class="card">
		            	<div class="card-header"><@spring.message "result.print.label.basicInfo"/></div>
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
			          			<table class="report-info">
			          				<tr>
					            		<td><@spring.message "result.print.label.name"/></td>
					            		<td>${resultResp.name!""}</td>
					            		<td><@spring.message "result.print.label.gender"/></td>
					            		<td>${resultResp.gender!""}</td>
					            		<td><@spring.message "result.print.label.age"/></td>
					            		<td>${resultResp.age!""} <@spring.message "result.print.label.age.unit"/></td>				            		
					            	</tr>
			          				<tr>
					            		<td><@spring.message "result.print.label.ptno"/></td>
					            		<td>${resultResp.charNo!""}</td>
					            		<td><@spring.message "result.print.label.idno"/></td>
					            		<td>${resultResp.idNo!""}</td>
					            		<td><@spring.message "result.print.label.evalDate"/></td>
					            		<td>${resultResp.evalDate!""}</td>		            		
					            	</tr>
					            	<tr>
					            		<td><@spring.message "result.print.label.diagnosis"/></td>
					            		<td colspan="3"></td>
					            		<td><@spring.message "result.print.label.attendingDoctor"/></td>
					            		<td>${resultResp.manager!""}</td>
					            	</tr>			          							          									            						            	
			          			</table>
		          			</div>			            	
			          	</div>		          	
			        </div>
            	</div>
            	<#assign pageBreak = false>
            	<#if resultResp.fundusResp?? && (resultResp.fundusResp?size>0)>
            	<#assign itemList = resultResp.fundusResp>
            	<#list itemList as item>          	
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
		            	<div class="card-header">${item.itemName!""} <@spring.message "result.print.label.testInfo"/> - ${item.bodyPart!""}</div>
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
								<table class="analy-table">
									<tr class="title">
										<td colspan="6" ><@spring.message "result.print.label.testData"/></td>
									</tr>
									<tr>
										<td class="loc" rowspan="8"><@spring.message "result.print.label.ophthalmoscope.rightEye"/></td>
										<td class="analy-title" colspan="2"><@spring.message "result.print.label.ophthalmoscope.referral"/></td>
										<td class="loc" rowspan="8"><@spring.message "result.print.label.ophthalmoscope.leftEye"/></td>
										<td class="analy-title" colspan="2"><@spring.message "result.print.label.ophthalmoscope.referral"/></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ophthalmoscope.severity"/></td>
										<td><input type="text" value="${item.analyticInfo.l_severity!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
										<td><@spring.message "result.print.label.ophthalmoscope.severity"/></td>
										<td><input type="text" value="${item.analyticInfo.r_severity!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
									</tr>
									<tr>
										<td class="analy-title" colspan="2"><@spring.message "result.print.label.ophthalmoscope.proabilityOfDignosis"/></td>
										<td class="analy-title" colspan="2"><@spring.message "result.print.label.ophthalmoscope.proabilityOfDignosis"/></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ophthalmoscope.proliferative"/></td>
										<td><input type="text" value="${item.analyticInfo.l_proliferative!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
										<td><@spring.message "result.print.label.ophthalmoscope.proliferative"/></td>
										<td><input type="text" value="${item.analyticInfo.r_proliferative!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ophthalmoscope.severe"/></td>
										<td><input type="text" value="${item.analyticInfo.l_severe!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
										<td><@spring.message "result.print.label.ophthalmoscope.severe"/></td>
										<td><input type="text" value="${item.analyticInfo.r_severe!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ophthalmoscope.moderate"/></td>
										<td><input type="text" value="${item.analyticInfo.l_moderate!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
										<td><@spring.message "result.print.label.ophthalmoscope.moderate"/></td>
										<td><input type="text" value="${item.analyticInfo.r_moderate!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ophthalmoscope.mild"/></td>
										<td><input type="text" value="${item.analyticInfo.l_mild!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
										<td><@spring.message "result.print.label.ophthalmoscope.mild"/></td>
										<td><input type="text" value="${item.analyticInfo.r_mild!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ophthalmoscope.normal"/></td>
										<td><input type="text" value="${item.analyticInfo.l_normal!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
										<td><@spring.message "result.print.label.ophthalmoscope.normal"/></td>
										<td><input type="text" value="${item.analyticInfo.r_normal!""}" /> <@spring.message "result.print.label.percent.unit"/></td>
									</tr>
									<tr class="title">
										<td colspan="4" >
											<@spring.message "result.print.label.testResult"/>
											<label><input type="checkbox" <#if item.resultInfo.normal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.normal"/></span></label>
											<label><input type="checkbox" <#if item.resultInfo.abnormal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.abnormal"/></span></label>
										</td>											
										<td colspan="2" >
											<#if item.resultInfo.reason?has_content ><@spring.message "result.print.label.abnormal.reason"/> ${item.resultInfo.reason!""}</#if>
										</td>										
									</tr>
									<tr class="title">
										<td><@spring.message "result.print.label.plans"/></td>
										<#if item.solvingInfo?has_content >
										<td colspan="6">
											<div class="solvingInfo">
					            			<#if item.solvingInfo?? && item.solvingInfo?has_content >
					            				<#assign solvingInfos = item.solvingInfo?split("/")>
					            				<#list solvingInfos as solvingInfo>
					            				<label>${solvingInfo}</label>
					            				</#list>
					            			</#if>
					            			</div>
										</td>
										<#else>
										<td colspan="6"><@spring.message "result.print.label.none"/></td>										
										</#if>
									</tr>								
								</table>
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
			          			<table class="analy-table">
									<tr class="title">
										<td colspan="6" ><@spring.message "result.print.label.testImgs"/>(${item.itemName!""} - ${item.bodyPart!""})：<#if (item.colorImgList?size <= 0) ><@spring.message "result.print.label.none"/></#if></td>
									</tr>
									<#if (item.colorImgList?size > 0) >
									<tr>
										<td colspan="6" class="pd-h-0">
										<#assign imgList = item.colorImgList>
										<#list imgList as imgItem>
										<div class='col-xs-6 col-md-6 image_block'>
											<img class='image_container' src='${base}${imgItem.url}' />
										</div>
										</#list>
										</td>
									</tr>										
									</#if>
								</table>							
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	</#list>
            	</#if>
            	<#if resultResp.resp?? && (resultResp.resp?size>0)>
            	<#assign itemList = resultResp.resp>
				<#list itemList as item>        	
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
		            	<div class="card-header">${item.itemName!""} <@spring.message "result.print.label.testInfo"/> - ${item.bodyPart!""}</div>
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
			          			<table class="report-info">			          				
			          				<tr>
					            		<td><@spring.message "result.print.label.wound.part"/></td>
					            		<td colspan="3">${item.bodyPart!""}</td>
					            		<td><@spring.message "result.print.label.wound.staging"/></td>
					            		<td colspan="3">${item.staging!""}</td>				            		
					            	</tr>
					            	<tr>
					            		<td><@spring.message "result.print.label.wound.category"/></td>
					            		<td colspan="3">${item.acute!""}${item.chronic!""}</td>
					            		<td><@spring.message "result.print.label.wound.exudate"/></td>
					            		<td colspan="3">${item.volume!""}</td>			            		
					            	</tr>
					            	<tr>
					            		<td><@spring.message "result.print.label.wound.height"/></td>
					            		<td> ${item.analyticInfo.height!""} cm</td>	
					            		<td><@spring.message "result.print.label.wound.width"/></td>
					            		<td> ${item.analyticInfo.width!""} cm</td>	
					            		<td><@spring.message "result.print.label.wound.depth"/></td>
					            		<td> ${item.analyticInfo.depth!""} cm</td>	
					            		<td><@spring.message "result.print.label.wound.area"/></td>
					            		<td> ${item.analyticInfo.area!""} cm2</td>			            		
					            	</tr>
					            	<tr>
					            		<td><@spring.message "result.print.label.wound.epithelium"/></td>
					            		<td> ${item.analyticInfo.epithelium!""}%</td>
					            		<td><@spring.message "result.print.label.wound.granular"/></td>
					            		<td> ${item.analyticInfo.granular!""}%</td>
					            		<td><@spring.message "result.print.label.wound.slough"/></td>
					            		<td> ${item.analyticInfo.slough!""}%</td>
					            		<td><@spring.message "result.print.label.wound.eschar"/></td>
					            		<td> ${item.analyticInfo.eschar!""}%</td>					            		
					            	</tr>
					            	<tr>
					            		<td colspan="8"><@spring.message "result.print.label.healthEducationInfo"/><#if item.eduList?length <= 1><@spring.message "result.print.label.none"/></#if></td>
					            	</tr>
					            	<#if item.eduList?has_content && (item.eduList?length > 1)>
					            	<tr>					            		
					            		<td colspan="8">
					            			<div class="eduList">            			
					            				<#assign eduLists = item.eduList?split("/")>
					            				<#list eduLists as eduList>
					            				<label>${eduList}</label>
					            				</#list>					            			
					            			</div>
					            		</td>					            		
					            	</tr>
					            	</#if>
					            	<tr>
					            		<td colspan="8"><@spring.message "result.print.label.plans"/></td>
					            	</tr>
					            	<tr>
					            		<td colspan="8">
						            		<table class="method-table">
				            					<thead>
				            						<tr class="tablesorter-headerRow">
														<th width="40%"><@spring.message "result.print.column.applicationMethod"/></th>
														<th width="25%"><@spring.message "result.print.column.size"/></th>
														<th width="15%"><@spring.message "result.print.column.quantity"/></th>
														<th width="20%"><@spring.message "result.print.column.frequency"/></th>
													</tr>
				            					</thead>
				            					<tbody class="method-container">
													<#if (item.methodList?size>0) >
													<#assign methodList = item.methodList>
													<#list methodList as methodItem>
													<tr>
														<td>${methodItem.method!""}</td>
														<td>${methodItem.size!""}</td>
														<td>${methodItem.quantity!""}</td>
														<td>${methodItem.frequency!""}</td>
													</tr>
													</#list>
													</#if>
				            					</tbody>
				            				</table>
			            				</td>
					            	</tr>
					            	<tr>
					            		<td colspan="8"><@spring.message "result.print.label.wound.history"/></td>
					            	</tr>
					            	<tr>
					            		<td colspan="8" class="pd-h-0">
					            			<div class="chart-temp">
					            				<div class='col-md-6 chart-container'>
					            					<canvas width='400' height='300' id='sizeChart${item_index}'></canvas>
				            					</div>
				            					<div class='col-md-6 chart-container'>
					            					<canvas width='400' height='300' id='propChart${item_index}'></canvas>
				            					</div>
					            			</div>
					            		</td>
					            	</tr>					            							            						            	
			          			</table>
			          		</div>			            	
			          	</div>		          	
			        </div>
            	</div>
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
			          			<table class="report-info">
									<tr>
										<td colspan="8"><@spring.message "result.print.label.testImgs"/>(${item.itemName!""} - ${item.bodyPart!""})：<#if (item.colorImgList?size <= 0) ><@spring.message "result.print.label.none"/></#if></td>
									</tr>
									<#if (item.colorImgList?size > 0) >
									<tr>
										<td colspan="8" class="pd-h-0">
										<#assign imgList = item.colorImgList>
										<#list imgList as imgItem>
										<div class='col-xs-6 col-md-6 image_block'>
											<img class='image_container' src='${base}${imgItem.url}' />
										</div>
										</#list>
										</td>
									</tr>										
									</#if>
								</table>							
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	</#list>
				</#if>
				<#if resultResp.echoResp?? && (resultResp.echoResp?size>0)>
            	<#assign itemList = resultResp.echoResp>
            	<#list itemList as item>       	
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
		            	<div class="card-header">${item.itemName!""} <@spring.message "result.print.label.testInfo"/> - ${item.bodyPart!""}</div>
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
								<table class="report-info">
									<tr>
										<td colspan="8" ><@spring.message "result.print.label.testData"/></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ultrasound.probetype"/></td>
										<td><input type="text" value="${item.analyticInfo.probeType!""}" /></td>
										<td><@spring.message "result.print.label.ultrasound.tgc3"/> </td>
										<td><input type="text" value="${item.analyticInfo.tgc3!""}" /></td>
										<td><@spring.message "result.print.label.ultrasound.tgc2"/> </td>
										<td><input type="text" value="${item.analyticInfo.tgc2!""}" /></td>
										<td><@spring.message "result.print.label.ultrasound.tgc1"/> </td>
										<td><input type="text" value="${item.analyticInfo.tgc1!""}" /></td>
									</tr>
				 					<tr>
										<td><@spring.message "result.print.label.ultrasound.mode"/> </td>
										<td><input type="text" value="${item.analyticInfo.mode!""}" /></td>
										<td><@spring.message "result.print.label.ultrasound.pwr"/> </td>
										<td><input type="text" value="${item.analyticInfo.pwr!""}" /></td>
										<td><@spring.message "result.print.label.ultrasound.contrast"/> </td>
										<td><input type="text" value="${item.analyticInfo.contrast!""}" /></td>
										<td><@spring.message "result.print.label.ultrasound.depth"/> </td>
										<td><input type="text" value="${item.analyticInfo.depth!""}" /></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ultrasound.dr"/> </td>
										<td><input type="text" value="${item.analyticInfo.dr!""}" /></td>
										<td><@spring.message "result.print.label.ultrasound.focus"/> </td>
										<td><input type="text" value="${item.analyticInfo.focus!""}" /></td>
										<td><@spring.message "result.print.label.ultrasound.other"/> </td>
										<td colspan="3"><input type="text" value="${item.analyticInfo.other!""}" /></td>
									</tr>
									<tr>
										<td colspan="5" >
											<@spring.message "result.print.label.ultrasound.liver.result"/>
											<label><input type="checkbox" <#if item.liverResultInfo.normal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.normal"/></span></label>
											<label><input type="checkbox" <#if item.liverResultInfo.abnormal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.abnormal"/></span></label>
										</td>
										<td colspan="3" >
											<#if item.liverResultInfo.reason?has_content >
											<@spring.message "result.print.label.ultrasound.liver.abnormal.reason"/> ${item.liverResultInfo.reason!""}
											</#if>
										</td>
									</tr>										
									<tr>
										<td colspan="5" >
											<@spring.message "result.print.label.ultrasound.guts.result"/>
											<label><input type="checkbox" <#if item.gutsResultInfo.normal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.normal"/></span></label>
											<label><input type="checkbox" <#if item.gutsResultInfo.abnormal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.abnormal"/></span></label>
										</td>
										<td colspan="3" >
											<#if item.gutsResultInfo.reason?has_content >
											<@spring.message "result.print.label.ultrasound.guts.abnormal.reason"/> ${item.gutsResultInfo.reason!""}
											</#if>
										</td>
									</tr>										
									<tr>
										<td colspan="5" >
											<@spring.message "result.print.label.ultrasound.kidney.result"/>
											<label><input type="checkbox" <#if item.kidneyResultInfo.normal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.normal"/></span></label>
											<label><input type="checkbox" <#if item.kidneyResultInfo.abnormal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.abnormal"/></span></label>
										</td>
										<td colspan="3" >
											<#if item.kidneyResultInfo.reason?has_content >
											<@spring.message "result.print.label.ultrasound.kidney.abnormal.reason"/> ${item.kidneyResultInfo.reason!""}
											</#if>
										</td>
									</tr>									
									<tr>
										<td colspan="5" >
											<@spring.message "result.print.label.ultrasound.pancreas.result"/>
											<label><input type="checkbox" <#if item.pancreasResultInfo.normal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.normal"/></span></label>
											<label><input type="checkbox" <#if item.pancreasResultInfo.abnormal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.abnormal"/></span></label>
										</td>
										<td colspan="3" >
											<#if item.pancreasResultInfo.reason?has_content >
											<@spring.message "result.print.label.ultrasound.pancreas.abnormal.reason"/> ${item.pancreasResultInfo.reason!""}
											</#if>
										</td>
									</tr>									
									<tr>
										<td colspan="5" >
											<@spring.message "result.print.label.ultrasound.other.result"/>
											<label><input type="checkbox" <#if item.otherResultInfo.normal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.normal"/></span></label>
											<label><input type="checkbox" <#if item.otherResultInfo.abnormal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.abnormal"/></span></label>
										</td>
										<td colspan="3" >
											<#if item.otherResultInfo.reason?has_content >
											<@spring.message "result.print.label.ultrasound.other.abnormal.reason"/> ${item.otherResultInfo.reason!""}
											</#if>
										</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.plans"/></td>
										<#if item.solvingInfo?has_content >
										<td colspan="7">
											<div class="solvingInfo">
					            			<#if item.solvingInfo?? >
					            				<#assign solvingInfos = item.solvingInfo?split("/")>
					            				<#list solvingInfos as solvingInfo>
					            				<label>${solvingInfo}</label>
					            				</#list>
					            			</#if>
					            			</div>
										</td>
										<#else>
										<td colspan="7"><@spring.message "result.print.label.none"/></td>										
										</#if>
									</tr>									
								</table>
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
			          			<table class="report-info">
									<tr>
										<td colspan="8" ><@spring.message "result.print.label.testImgs"/>(${item.itemName!""} - ${item.bodyPart!""})：<#if (item.colorImgList?size <= 0) ><@spring.message "result.print.label.none"/></#if></td>
									</tr>
									<#if (item.colorImgList?size > 0) >
									<tr>
										<td colspan="8" class="pd-h-0">
										<#assign imgList = item.colorImgList>
										<#list imgList as imgItem>
										<div class='col-xs-6 col-md-6 image_block'>
											<img class='image_container' src='${base}${imgItem.url}' />
										</div>
										</#list>
										</td>
									</tr>										
									</#if>
								</table>							
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	</#list>
            	</#if>
				<#if resultResp.ekgResp?? && (resultResp.ekgResp?size>0)>
            	<#assign itemList = resultResp.ekgResp>
            	<#list itemList as item>      	
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
		            	<div class="card-header">${item.itemName!""} <@spring.message "result.print.label.testInfo"/> - ${item.bodyPart!""}</div>
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
								<table class="analy-table">
									<tr class="title">
										<td colspan="6" ><@spring.message "result.print.label.testData"/></td>
									</tr>
									<tr>
										<td class="title"><@spring.message "result.print.column.item"/></td>
										<td class="title"><@spring.message "result.print.column.code"/></td>
										<td class="title"><@spring.message "result.print.column.value"/></td>
										<td class="title"><@spring.message "result.print.column.item"/></td>
										<td class="title"><@spring.message "result.print.column.code"/></td>
										<td class="title"><@spring.message "result.print.column.value"/></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ecg.heartrate"/></td>
										<td><@spring.message "result.print.label.ecg.heartrate.code"/></td>
										<td><input type="text" value="${item.analyticInfo.hr!""}" /></td>
										<td><@spring.message "result.print.label.ecg.meanqtc"/></td>
										<td><@spring.message "result.print.label.ecg.meanqtc.code"/></td>
										<td colspan="4"><input type="text" value="${item.analyticInfo.qtc!""}" /></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ecg.meanprint"/></td>
										<td><@spring.message "result.print.label.ecg.meanprint.code"/></td>
										<td><input type="text" value="${item.analyticInfo.pr!""}" /></td>
										<td><@spring.message "result.print.label.ecg.pfrontaxis"/></td>
										<td><@spring.message "result.print.label.ecg.pfrontaxis.code"/></td>
										<td colspan="4"><input type="text" value="${item.analyticInfo.paxis!""}" /></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ecg.meanqrsdur"/></td>
										<td><@spring.message "result.print.label.ecg.meanqrsdur.code"/></td>
										<td><input type="text" value="${item.analyticInfo.qrs!""}" /></td>
										<td><@spring.message "result.print.label.ecg.tfrontaxis"/></td>
										<td><@spring.message "result.print.label.ecg.tfrontaxis.code"/></td>
										<td><input type="text" value="${item.analyticInfo.taxis!""}" /></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.ecg.meanqtint"/></td>
										<td><@spring.message "result.print.label.ecg.meanqtint.code"/></td>
										<td><input type="text" value="${item.analyticInfo.qt!""}" /></td>
									</tr>
									<tr class="title">
										<td><@spring.message "result.print.label.testResult"/></td>
										<td colspan="2" >
											<label><input type="checkbox" <#if item.resultInfo.normal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.normal"/></span></label>
											<label><input type="checkbox" <#if item.resultInfo.abnormal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.abnormal"/></span></label>
										</td>
										<td colspan="3" >
											<#if item.resultInfo.reason?has_content >
											<@spring.message "result.print.label.ecg.other.abnormal.reason"/> ${item.resultInfo.reason!""}
											</#if>
										</td>
									</tr>
									<tr class="title">
										<td><@spring.message "result.print.label.plans"/></td>
										<#if item.solvingInfo?has_content >
										<td colspan="7">
											<div class="solvingInfo">
					            			<#if item.solvingInfo?? >
					            				<#assign solvingInfos = item.solvingInfo?split("/")>
					            				<#list solvingInfos as solvingInfo>
					            				<label>${solvingInfo}</label>
					            				</#list>
					            			</#if>
					            			</div>
										</td>
										<#else>
										<td colspan="7"><@spring.message "result.print.label.none"/></td>										
										</#if>
									</tr>								
								</table>
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
			          			<table class="analy-table">
									<tr class="title">
										<td colspan="6" ><@spring.message "result.print.label.testImgs"/>(${item.itemName!""} - ${item.bodyPart!""})：<#if (item.colorImgList?size <= 0) ><@spring.message "result.print.label.none"/></#if></td>
									</tr>
									<#if (item.colorImgList?size > 0) >
									<tr>
										<td colspan="6" class="pd-h-0">
										<#assign imgList = item.colorImgList>
										<#list imgList as imgItem>
										<div class='col-xs-12 col-md-12 image_block'>
											<img class='image_container' src='${base}${imgItem.url}' />
										</div>
										</#list>
										</td>
									</tr>										
									</#if>
								</table>							
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	</#list>
            	</#if>
				<#if resultResp.fvcResp?? && (resultResp.fvcResp?size>0)>
            	<#assign itemList = resultResp.fvcResp>
            	<#list itemList as item>
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
		            	<div class="card-header">${item.itemName!""} <@spring.message "result.print.label.testInfo"/> - ${item.bodyPart!""}</div>
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
								<table class="analy-table detail">
									<tr class="title">
										<td colspan="13" ><@spring.message "result.print.label.testData"/></td>
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.column.param"/></td>
										<td class="analy-title"></td>
										<td class="analy-title"><@spring.message "result.print.column.lln"/></td>
										<td class="analy-title"><@spring.message "result.print.column.pred"/></td>
										<td class="analy-title"><@spring.message "result.print.column.best"/></td>
										<td class="analy-title"><@spring.message "result.print.column.pred.unit"/></td>
										<td class="analy-title"><@spring.message "result.print.column.zscore"/></td>
										<td class="analy-title"><@spring.message "result.print.column.pre1"/></td>
										<td class="analy-title"><@spring.message "result.print.column.pre2"/></td>
										<td class="analy-title"><@spring.message "result.print.column.pre3"/></td>
										<td class="analy-title"><@spring.message "result.print.column.post"/></td>
										<td class="analy-title"><@spring.message "result.print.column.percent"/></td>
										<td class="analy-title"><@spring.message "result.print.column.chg"/></td>									
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.fvc"/></td>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.unit.l"/></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_LNN!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_Pred!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_Best!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_PredPercent!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_ZScore!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_PRE1!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_PRE2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_PRE3!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_POST!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_PredPercent2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FVC_ChgPercent!""}" /></td>
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.fev1"/></td>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.unit.l"/></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_LNN!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_Pred!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_Best!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_PredPercent!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_ZScore!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_PRE1!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_PRE2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_PRE3!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_POST!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_PredPercent2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1_ChgPercent!""}" /></td>
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.fev1.fvc"/></td>
										<td class="analy-title"><@spring.message "result.print.label.percent.unit"/></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_LNN!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_Pred!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_Best!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_PredPercent!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_ZScore!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_PRE1!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_PRE2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_PRE3!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_POST!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_PredPercent2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndFVC_ChgPercent!""}" /></td>
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.pef"/></td>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.unit.ls"/></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_LNN!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_Pred!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_Best!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_PredPercent!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_ZScore!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_PRE1!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_PRE2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_PRE3!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_POST!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_PredPercent2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.PEF_ChgPercent!""}" /></td>
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.ela"/></td>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.unit.yrs"/></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_LNN!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_Pred!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_Best!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_PredPercent!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_ZScore!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_PRE1!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_PRE2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_PRE3!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_POST!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_PredPercent2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.ELA_ChgPercent!""}" /></td>
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.fef2575"/></td>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.unit.ls"/></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_LNN!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_Pred!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_Best!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_PredPercent!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_ZScore!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_PRE1!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_PRE2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_PRE3!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_POST!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_PredPercent2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEF2575_ChgPercent!""}" /></td>
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.fet"/></td>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.unit.s"/></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_LNN!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_Pred!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_Best!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_PredPercent!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_ZScore!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_PRE1!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_PRE2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_PRE3!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_POST!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_PredPercent2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FET_ChgPercent!""}" /></td>
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.fivc"/></td>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.unit.l"/></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_LNN!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_Pred!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_Best!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_PredPercent!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_ZScore!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_PRE1!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_PRE2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_PRE3!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_POST!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_PredPercent2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FIVC_ChgPercent!""}" /></td>
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.label.spirometer.fev1.vc"/></td>
										<td class="analy-title"><@spring.message "result.print.label.percent.unit"/></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_LNN!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_Pred!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_Best!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_PredPercent!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_ZScore!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_PRE1!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_PRE2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_PRE3!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_POST!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_PredPercent2!""}" /></td>
										<td><input type="text" class="btm-line" value="${item.analyticInfo.FEV1AndVC_ChgPercent!""}" /></td>
									</tr>
									<tr class="title">
										<td colspan="3"><@spring.message "result.print.label.testResult"/></td>
										<td colspan="4" >
											<label><input type="checkbox" <#if item.resultInfo.normal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.normal"/></span></label>
											<label><input type="checkbox" <#if item.resultInfo.abnormal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.abnormal"/></span></label>
										</td>
										<td colspan="6" >
											<#if item.resultInfo.reason?has_content >
											<@spring.message "result.print.label.abnormal.reason"/> ${item.resultInfo.reason!""}
											</#if>
										</td>
									</tr>
									<tr class="title">
										<td colspan="2"><@spring.message "result.print.label.plans"/></td>
										<#if item.solvingInfo?has_content >
										<td colspan="11">
											<div class="solvingInfo">
					            			<#if item.solvingInfo?? >
					            				<#assign solvingInfos = item.solvingInfo?split("/")>
					            				<#list solvingInfos as solvingInfo>
					            				<label>${solvingInfo}</label>
					            				</#list>
					            			</#if>
					            			</div>
										</td>
										<#else>
										<td colspan="11"><@spring.message "result.print.label.none"/></td>										
										</#if>
									</tr>									
								</table>
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
			          			<table class="analy-table detail">
									<tr class="title">
										<td colspan="13" ><@spring.message "result.print.label.testImgs"/>(${item.itemName!""} - ${item.bodyPart!""})：<#if (item.colorImgList?size <= 0) ><@spring.message "result.print.label.none"/></#if></td>
									</tr>
									<#if (item.colorImgList?size > 0) >
									<tr>
										<td colspan="13" class="pd-h-0">
										<#assign imgList = item.colorImgList>
										<#list imgList as imgItem>
										<div class='col-xs-12 col-md-12 image_block'>
											<img class='image_container ' src='${base}${imgItem.url}' />
										</div>
										</#list>
										</td>
									</tr>										
									</#if>
								</table>							
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	</#list>
				</#if>
				<#if resultResp.otoResp?? && (resultResp.otoResp?size>0)>
            	<#assign itemList = resultResp.otoResp>
            	<#list itemList as item>          	
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
		            	<div class="card-header">${item.itemName!""} <@spring.message "result.print.label.testInfo"/> - ${item.bodyPart!""}</div>
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
								<table class="report-info">
									<tr class="title">
										<td><@spring.message "result.print.label.testResult"/></td>
										<td>
											<label><input type="checkbox" <#if item.resultInfo.normal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.normal"/></span></label>
											<label><input type="checkbox" <#if item.resultInfo.abnormal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.abnormal"/></span></label>
										</td>
										<td>
											<#if item.resultInfo.reason?has_content >
											<@spring.message "result.print.label.abnormal.reason"/> ${item.resultInfo.reason!""}
											</#if>
										</td>
									</tr>					
									<tr class="title">
										<td><@spring.message "result.print.label.plans"/></td>
										<#if item.solvingInfo?has_content >
										<td colspan="2">
											<div class="solvingInfo">
					            			<#if item.solvingInfo?? && item.solvingInfo?has_content >
					            				<#assign solvingInfos = item.solvingInfo?split("/")>
					            				<#list solvingInfos as solvingInfo>
					            				<label>${solvingInfo}</label>
					            				</#list>
					            			</#if>
					            			</div>
										</td>
										<#else>
										<td colspan="2"><@spring.message "result.print.label.none"/></td>										
										</#if>
									</tr>									
								</table>
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
			          			<table class="analy-table detail">
									<tr class="title">
										<td colspan="3" ><@spring.message "result.print.label.testImgs"/>(${item.itemName!""} - ${item.bodyPart!""})：<#if (item.colorImgList?size <= 0) ><@spring.message "result.print.label.none"/></#if></td>
									</tr>
									<#if (item.colorImgList?size > 0) >
									<tr>
										<td colspan="3" class="pd-h-0">
										<#assign imgList = item.colorImgList>
										<#list imgList as imgItem>
										<div class='col-xs-12 col-md-12 image_block'>
											<img class='image_container' src='${base}${imgItem.url}' />
										</div>
										</#list>
										</td>
									</tr>										
									</#if>
								</table>							
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	</#list>
            	</#if>
				<#if resultResp.audioResp?? && (resultResp.audioResp?size>0)>
            	<#assign itemList = resultResp.audioResp>
            	<#list itemList as item>        	
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
		            	<div class="card-header">${item.itemName!""} <@spring.message "result.print.label.testInfo"/> - ${item.bodyPart!""}</div>
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
			          			<table class="analy-table audio-meters-detail">
									<tr>
										<td class="direction" colspan="3"><@spring.message "result.print.label.hearingDetector.rightEar"/></td>
										<td class="space"></td>
										<td class="direction" colspan="3"><@spring.message "result.print.label.hearingDetector.leftEar"/></td>
									</tr>
									<tr>
										<td class="analy-title"><@spring.message "result.print.label.hearingDetector.frequency"/></td>
										<td class="analy-title"><@spring.message "result.print.label.hearingDetector.hearing.level"/></td>
										<td class="analy-title"><@spring.message "result.print.label.hearingDetector.status"/></td>
										<td></td>
										<td class="analy-title"><@spring.message "result.print.label.hearingDetector.frequency"/></td>
										<td class="analy-title"><@spring.message "result.print.label.hearingDetector.hearing.level"/></td>
										<td class="analy-title"><@spring.message "result.print.label.hearingDetector.status"/></td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.125"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_125!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_125_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.125"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_125!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_125_status!""}</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.250"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_250!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_250_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.250"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_250!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_250_status!""}</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.500"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_500!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_500_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.500"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_500!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_500_status!""}</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.750"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_750!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_750_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.750"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_750!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_750_status!""}</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.1000"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_1000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_1000_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.1000"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_1000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_1000_status!""}</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.1500"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_1500!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_1500_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.1500"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_1500!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_1500_status!""}</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.2000"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_2000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_2000_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.2000"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_2000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_2000_status!""}</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.3000"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_3000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_3000_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.3000"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_3000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_3000_status!""}</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.4000"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_4000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_4000_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.4000"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_4000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_4000_status!""}</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.6000"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_6000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_6000_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.6000"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_6000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_6000_status!""}</td>
									</tr>
									<tr>
										<td><@spring.message "result.print.label.hearingDetector.hz.8000"/></td>
										<td><input type="text" value="${item.analyticInfo.r_Freq_8000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.r_Freq_8000_status!""}</td>
										<td></td>
										<td><@spring.message "result.print.label.hearingDetector.hz.8000"/></td>
										<td><input type="text" value="${item.analyticInfo.l_Freq_8000!""}" /> <@spring.message "result.print.label.hz.unit"/></td>
										<td>${item.analyticInfo.l_Freq_8000_status!""}</td>
									</tr>
									<tr class="title">
										<td><@spring.message "result.print.label.testResult"/></td>
										<td colspan="2">
											<label><input type="checkbox" <#if item.resultInfo.normal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.normal"/></span></label>
											<label><input type="checkbox" <#if item.resultInfo.abnormal?has_content >checked</#if> disabled /> <span><@spring.message "result.print.label.abnormal"/></span></label>
										</td>
										<td colspan="4">
											<#if item.resultInfo.reason?has_content >
											<@spring.message "result.print.label.abnormal.reason"/> ${item.resultInfo.reason!""}
											</#if>
										</td>
									</tr>
									<tr class="title">
										<td><@spring.message "result.print.label.plans"/></td>
										<#if item.solvingInfo?has_content >
										<td colspan="6">
											<div class="solvingInfo">
					            			<#if item.solvingInfo?? >
					            				<#assign solvingInfos = item.solvingInfo?split("/")>
					            				<#list solvingInfos as solvingInfo>
					            				<label>${solvingInfo}</label>
					            				</#list>
					            			</#if>
					            			</div>
										</td>
										<#else>
										<td colspan="6"><@spring.message "result.print.label.none"/></td>										
										</#if>
									</tr>
								</table>							
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>         	
            	<div class="card-deck <#if pageBreak = true>page-break<#else><#assign pageBreak = true></#if>" data-item="${item.itemNo!""}" data-keyno="${item.woundId!""}">
            		<div class="card">
			          	<div class="card-body">
			          		<div class="col-md-12 col-xs-12">
			          			<table class="analy-table audio-meters-detail">
									<tr class="title">
										<td colspan="7" ><@spring.message "result.print.label.testImgs"/>(${item.itemName!""} - ${item.bodyPart!""})：<#if (item.colorImgList?size <= 0) ><@spring.message "result.print.label.none"/></#if></td>
									</tr>
									<#if (item.colorImgList?size > 0) >
									<tr>
										<td colspan="7" class="pd-h-0">
										<#assign imgList = item.colorImgList>
										<#list imgList as imgItem>
										<div class='col-xs-12 col-md-12 image_block'>
											<img class='image_container' src='${base}${imgItem.url}' />
										</div>
										</#list>
										</td>
									</tr>
									</#if>
								</table>							
			          		</div>					            	
			          	</div>		          	
			        </div>
            	</div>
            	</#list>
            	</#if>
            	<div id="output"></div>							 		
    		</div>  		  		  				               
		</div>
	</div>	
</body>

<div class="modal fade" id="imgSelectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog " style="width:800px; ">
        <div class="modal-content" >
            <div class="modal-body text-center date-content">
            	<span><@spring.message "result.print.label.chooseImg"/></span>
            	<select class="img-pick hidden" multiple>
            		<optgroup label='<@spring.message "result.print.label.colorImg"/>'>
            		
            		</optgroup>
            		<optgroup label='<@spring.message "result.print.label.thermalImg"/>'></optgroup>
            	</select>
                <div class="date-btn">
                	<input type="button" class="confirm-list-btn" value="<@spring.message "result.print.button.confirm"/>" />
                	<input type="button" data-dismiss="modal" value="<@spring.message "result.print.button.cancel"/>" />
                </div>	
            </div>
        </div>
    </div>
</div>

<script>

$( document ).ready(function() {
	switch("${__field}"){
    	case "YT":
			$(".hospital-logo").attr("src", "${base}/images/imas/logo/${field_img_name}.png");
			break;
    } 
	
	doGetData();
});

$(".png-upload").click(function () {
	html2canvas(document.body, {
	  onclone: function (content) {
	  	//var btns = content.getElementsByClassName("print-btn");
	  	var delBtns = content.getElementsByClassName("del-btn");
	  	/*for(var i=0; i<btns.length; i++){
	  		btns[i].style.display = 'none';
	  	}*/
	  	for(var i=0; i<delBtns.length; i++){
	  		delBtns[i].style.display = 'none';
	  	}
	  	//content.getElementsByClassName("addImgHint")[0].style.display = 'none';
	  }
	}).then(function(canvas) {
		Canvas2Image.saveAsPNG(canvas, "${field_name!""}_<@spring.message "result.print.label.imgName"/>");
    });
});

$(".pdf-upload").click(function () {
	document.title = "${field_name!""}_<@spring.message "result.print.label.pdfName"/>";
	window.print(); 
});

$(".addImgHint a").click(function(){
	$("#imgSelectModal").modal('show');
});

function doGetData(){
	<#if resultResp.resp?? && (resultResp.resp?size>0)>
	<#assign itemList = resultResp.resp>
	<#list itemList as item>
	
	var sizeData = [];
	var propData = [];
	var dateArr = [<#list item.dateArr as dateArr>"${dateArr!""}",</#list>];
	var widthArr = [<#list item.widthArr as widthArr>"${widthArr!""}",</#list>];
	var heightArr = [<#list item.heightArr as heightArr>"${heightArr!""}",</#list>];
	var depthArr = [<#list item.depthArr as depthArr>"${depthArr!""}",</#list>];
	var areaArr = [<#list item.areaArr as areaArr>"${areaArr!""}",</#list>];
	var epitheliumArr = [<#list item.epitheliumArr as epitheliumArr>"${epitheliumArr!""}",</#list>];
	var granularArr = [<#list item.granularArr as granularArr>"${granularArr!""}",</#list>];
	var sloughArr = [<#list item.sloughArr as sloughArr>"${sloughArr!""}",</#list>];
	var escharArr = [<#list item.escharArr as escharArr>"${escharArr!""}",</#list>];
	
	sizeData.push(heightArr);
	sizeData.push(widthArr);
	sizeData.push(depthArr);
	
	for(var i=0; i<areaArr.length; i++){	
		epitheliumArr[i] = Number(epitheliumArr[i]) / 100 * areaArr[i];
		granularArr[i] = Number(granularArr[i]) / 100 * areaArr[i];
		sloughArr[i] = Number(sloughArr[i]) / 100 * areaArr[i];
		escharArr[i] = Number(escharArr[i]) / 100 * areaArr[i];
	}
	
	propData.push(epitheliumArr);
	propData.push(granularArr);
	propData.push(sloughArr);
	propData.push(escharArr);
	
	renderDimension("sizeChart${item_index}", dateArr, sizeData);
	renderProportion("propChart${item_index}", dateArr, propData, areaArr);
	
	</#list>
	</#if>	
}

//傷口尺寸變化顯示圖
function renderDimension(className, dateArr, sizeData){
	//console.log(showDate);
	//console.log(evalDate);
	//console.log(arrData);
	//console.log(arrDataTitle);
	var unit = "<@spring.message "result.print.label.wound.sizeChart"/>";
	var maxNum = 30;
	var minNum = 10;
	
	var config = {
		type: 'line',
		data: {
			labels: dateArr,
			datasets: [{
				label: "<@spring.message "result.print.label.chart.height"/>",
				backgroundColor: colors.red.stroke,
				borderColor: colors.red.stroke,
				data: sizeData[0],
				fill: false
			},{
				label: "<@spring.message "result.print.label.chart.width"/>",
				backgroundColor: colors.blue.stroke,
				borderColor: colors.blue.stroke,
				data: sizeData[1],
				fill: false
			}, {
				label: "<@spring.message "result.print.label.chart.depth"/>",			
				backgroundColor: colors.green.stroke,
				borderColor: colors.green.stroke,
				data: sizeData[2],
				fill: false
			}]
		},
		options: {
			animation: false,
			spanGaps: true,	//防止數據為0或null斷點情形
			responsive: true,
			legend: {
				position: 'bottom',
			},
			title: {
				display: true,
				fontSize: 14,
				text: unit
			},
			tooltips: {
	            callbacks: {
	                label: function(t, d) {
	                    var label = d.datasets[t.datasetIndex].label || '';

	                    if (label) {
	                        label += ': ';
	                    }
	                    label += t.yLabel + " <@spring.message "chart.label.centimeter"/>";
	                    return label;
	                },
	                title: function (item) {
						return "<@spring.message "chart.label.evalDate"/>" + item[0].xLabel
					}
	            }
	        },
			scales: {
				xAxes: [{
					gridLines: {display: true}
				}],
				yAxes: [{
					gridLines: {display: true},
					ticks: {
						min: 0,
						max: maxNum,
						stepSize: minNum
					},
					scaleLabel: {
                        display: true,
                        labelString: '<@spring.message "chart.label.tag.centimeter"/>'
                    }
				}]
			}
		}
	};

	return new Chart(document.getElementById(className), config);
}

//面積組織比例顯示圖
function renderProportion(className, dateArr, propData, areaData){
	
	var unit = "<@spring.message "result.print.label.wound.propChart"/>";
	var maxNum = 60;
	var minNum = 10;

	var config = {
		type: 'line',
		data: {
    		labels: dateArr,
    		datasets: [{
    			label: "<@spring.message "result.print.label.chart.epithelium"/>",
		     	fill: true,
	    	  	backgroundColor: colors.pink.fill,
		      	pointBackgroundColor: colors.pink.stroke,
		     	borderColor: colors.pink.stroke,
		     	pointHighlightStroke: colors.pink.stroke,
		      	borderCapStyle: 'butt',
		      	data: propData[1],		
	    	}, {
		      	label: "<@spring.message "result.print.label.chart.granular"/>",
		      	fill: true,
		      	backgroundColor: colors.cherryRed.fill,
		      	pointBackgroundColor: colors.cherryRed.stroke,
		      	borderColor: colors.cherryRed.stroke,
		      	pointHighlightStroke: colors.cherryRed.stroke,
		      	borderCapStyle: 'butt',
		      	data: propData[2],
		    }, {
		      	label: "<@spring.message "result.print.label.chart.slough"/>",
		      	fill: true,
		      	backgroundColor: colors.lightYellow.fill,
		      	pointBackgroundColor: colors.yellow.stroke,
		      	borderColor: colors.yellow.stroke,
		      	pointHighlightStroke: colors.yellow.stroke,
		      	borderCapStyle: 'butt',
		      	data: propData[3],
		    }, {
		      	label: "<@spring.message "result.print.label.chart.eschar"/>",
		      	fill: true,
		      	backgroundColor: colors.black.fill,
		      	pointBackgroundColor: colors.darkGrey.stroke,
		      	borderColor: colors.darkGrey.stroke,
		      	pointHighlightStroke: colors.darkGrey.stroke,
		      	borderCapStyle: 'butt',
		      	data: propData[4],
		    }]
  		},
  		options: {
  			animation: false,
			spanGaps: true,	//防止數據為0或null斷點情形
    		responsive: true,
    		legend: {
				position: 'bottom',
			},
    		title: {
				display: true,
				fontSize: 14,
				text: unit
			},
    		tooltips: {
		      	callbacks: {
			        title: function(t, d) {
			          return "<@spring.message "chart.label.evalDate"/>" + d.labels[t[0].index] + " (<@spring.message "chart.label.totalArea"/> " + areaData[t[0].index] + " <@spring.message "chart.label.cm2"/>)";
			        },
			        label: function(t, d) {
			          var label = d.datasets[t.datasetIndex].label;
			          var value = d.datasets[t.datasetIndex].data[t.index];
			          var propArea = areaData[t.index] * prop / 100;

			          return label + " <@spring.message "chart.label.occupy"/> " + prop + '<@spring.message "chart.label.percent"/>(<@spring.message "chart.label.area"/> ' + Number(propArea).toFixed(1) + ' <@spring.message "chart.label.cm2"/>)';
			        }
		      	}
		    },
    		// Can't just just `stacked: true` like the docs say
    		scales: {
	      		yAxes: [{
	        		stacked: true,
	        		beginAtZero: true,
					offset: true,
	        		scaleLabel: {
                        display: true,
                        labelString: '<@spring.message "chart.label.tag.cm2"/>'
                    },
                    ticks: {
						min: 0,
						max: maxNum,
						stepSize: minNum
					}
	      		}]
			}	    	
  		}
	};

	return new Chart(document.getElementById(className), config);
}

function addColorImgTemp(colorImgData, thermalData){
	var selectedList = "";

	if(colorImgData.length > 0){
		for(var i=0; i< colorImgData.length; i++){
			$("optgroup[label='<@spring.message "result.print.label.colorImg"/>']").append("<option data-img-label='<@spring.message "result.print.label.color"/>-" + (i+1) + "' data-img-alt='" + colorImgData[i].fileName + "' data-img-src='${base}" + colorImgData[i].url + "&q=low' value='<@spring.message "result.print.label.color"/>-" + (i+1) + "'></option>");
		}
	}
		
	if(thermalData.length > 0){
		for(var i=0; i< thermalData.length; i++){
			$("optgroup[label='<@spring.message "result.print.label.thermalImg"/>']").append("<option data-img-label='<@spring.message "result.print.label.thermal"/>-" + (i+1) + "' data-img-alt='" + thermalData[i].fileName + "' data-img-src='${base}" + thermalData[i].url + "&q=low' value='<@spring.message "result.print.label.thermal"/>-" + (i+1) + "'></option>");
		}
	}
		
	$(".img-pick").imagepicker({
      	hide_select : true,
      	show_label : true,
      	changed:function(){
      		selectedList = "";
      		var list = $(this).val();
      		if(list != null){
	      		for(var i=0; i<list.length; i++){
	      			var src = $(this).find("option[value='" + list[i] + "']").data('img-src');
	      			selectedList += "<div class='col-xs-6 col-md-6 image_block'><img class='image_container' src='" + src + "' /><div class='image_desc'>" + list[i] + "</div>" +
	      							"<span class='del-btn' data-value='" + list[i] + "'><i class='fa fa-times-circle fa-2x'></i></span></div>";
	      		}
	        }
	    }
    });
    
    $(".confirm-list-btn").click(function(){
    	$(".image_block").remove();
    	$(".addImgHint").before(selectedList);
    	$("#imgSelectModal").modal('hide');
    	
    	$(".image_block span").click(function(){    	
			var imgName = $(this).attr("data-value");
			$(this).parent().remove();
			$(".image_picker_selector").find("p").each(function(){
			    if($(this).html() == imgName){
			    	$(this).parent().click();
			    }
		    });
		});
    });	    
        
}

</script>
