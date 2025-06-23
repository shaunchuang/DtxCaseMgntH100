<#include "/imas/widget/leftnav.ftl" />
			<div class="custom-blk">
				<!-- 模組標題與功能模組放置區 -->
				<div class="col-md-12 sub-bar">
	           		<#if revisit>
	           		<ul class="progressBar">
					    <li class="active">基本資料</li>
					    <li>個案評估</li>
					    <li>檢視訓練紀錄</li>
					    <li>診斷處置</li>
					    <li>治療安排</li>
					</ul>
					<#else>
					<ul class="progressBar">
					    <li class="active">基本資料</li>
					    <li>個案評估</li>
					    <li>診斷處置</li>
					    <li>治療安排</li>
					</ul>
					</#if>
					<div class="col-md-8 patient-info">
					    <div class="info-block">
					      <div class="info-l">姓名</div>
					      <div class="info-v">${ptInfo.name!""}</div>
					    </div>
					    <div class="info-block">
					      <div class="info-l">性別</div>
					      <div class="info-v">${ptInfo.genderName!""}</div>
					    </div>
					    <div class="info-block">
					      <div class="info-l">年齡</div>
					      <div class="info-v">${ptInfo.age!""} 歲</div>
					    </div>
					    <div class="info-block">
					      <div class="info-l">身分證字號</div>
					      <div class="info-v">${ptInfo.idno!""}</div>
					    </div>
					    <div class="info-block">
					      <div class="info-l">自述適應症</div>
					      <div class="info-v">${ptInfo.indication!""}</div>
					    </div>
						<div class="info-block">
					      <div class="info-l">建議轉診類別</div>
					      <div class="info-v">${ptInfo.therapyItem.therapyName}</div>
					    </div>
					</div>
				</div>
				<!-- 各功能模組內容放置區 -->
				<div class="clearfix"></div>
				<div class="main-content">
					<form action="" >
						<fieldset class="form-step active">
					        <div class="card pd-10">
								<div class="card-topic">個案資料</div>
								<div class="row mg-b-10">
									<div class="col-md-3">
										<label class="form-label"><@spring.message "view.label.name"/></label>
										<input type="text" id="patient-name" class="dataForm form-control" data-item="3" readonly="">
									</div>
									<div class="col-md-3">
										<label class="form-label"><@spring.message "view.label.gender"/></label>
										<select id="patient-gender" class="dataForm form-control" data-item="4" disabled>
											<option value=""><@spring.message "view.option.select.hint"/></option>
											<option value="M" <#if ptInfo.gender == "M">selected</#if>><@spring.message "view.option.male"/></option>
											<option value="F" <#if ptInfo.gender == "F">selected</#if>><@spring.message "view.option.female"/></option>
										</select>
									</div>
									<div class="col-md-3">
										<label class="form-label"><@spring.message "view.label.ptno"/></label>
										<input type="text" id="patient-charno" class="dataForm form-control" data-item="1" readonly="">
									</div>
									<div class="col-md-3">
										<label class="form-label">身分證字號</label>
										<input type="text" id="patient-idno" class="dataForm form-control" data-item="2" readonly="">
									</div>
								</div>
								<div class="row mg-b-10">
									<div class="col-md-3">
										<label class="form-label">出生日期</label>
										<input type="hidden" id="patient-birth" class="dataForm form-control birth" data-item="6" data-date-end-date="0d" />
									</div>
									<div class="col-md-3">
										<label class="form-label">聯絡電話</label>
										<input type="text" id="patient-phone" class="dataForm form-control" data-item="7" readonly="">
									</div>
									<div class="col-md-3">
										<label class="form-label">緊急聯絡人</label>
										<div class="inline-cotainer">
											<input type="text" id="patient-emergency-contact" class="dataForm form-control" data-item="12" readonly="">
											<select id="patient-emergency-relation" class="basicForm form-control" data-item="13">
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
									</div>
									<div class="col-md-3">
										<label class="form-label">緊急聯絡電話</label>
										<input type="text" id="patient-emergency-phone" class="dataForm form-control" data-item="14" readonly="">
									</div>
								</div>
								<div class="row mg-b-10">
									<div class="col-md-3">
										<label class="form-label">電子信箱</label>
										<input type="text" id="patient-email" class="dataForm form-control" data-item="8" readonly="">
									</div>
									<div class="col-md-3">
										<label class="form-label">婚姻狀態</label>
										<select id="patient-marital-status" class="dataForm form-control" data-item="" disabled>
											<option value="">請選擇</option>
											<option value="N">未婚</option>
											<option value="Y">已婚</option>
										</select>
									</div>
									<div class="col-md-6">
										<label class="form-label">聯絡地址</label>
										<#if __lang == "zh_TW" >
										<div class="inline-cotainer">
											<div id="twzipcode" class="zipcode inline-cotainer"></div>
											<#else>
											<div class="zipcode inline-cotainer">
												<input type="text" id="patient-city" name="country" placeholder="<@spring.message "view.placeholder.country"/>" class="dataForm form-control half" data-item="9">
												<input type="text" id="patient-district" name="city" placeholder="<@spring.message "view.placeholder.capital"/>" class="dataForm form-control half" data-item="10">
											</div>
											</#if>
											<input type="text" id="patient-address" class="dataForm form-control" data-item="11" readonly="">
										</div>
									</div>
								</div>
								<div class="row mg-b-10">
									<div class="col-md-12">
										<label class="form-label">個人病史</label>
										<div class="history-options multi-option">
											<#list personalDiseaseHistoryItems as pdhItems>
											<div class="option<#if ptInfo.medicalHistory?seq_contains(pdhItems.name)>selected</#if>" data-item="${pdhItems.id}" >${pdhItems.name}</div>
											</#list>				                 	
					                    </div>
					                    <textarea rows="2" class="form-control" placeholder="請填寫其他個人病史"></textarea>
									</div>
								</div>
								<div class="row mg-b-10">
									<div class="col-md-12">
										<label class="form-label">藥物過敏史</label>
										<div class="allergy-history-options multi-option">
											<#list drugAllergyHistoryItems as dahItems>
											<div class="option" data-item="${dahItems.id}" >${dahItems.name}</div>
											</#list>
										</div>
										<textarea rows="2" class="form-control" placeholder="請填寫其他藥物過敏史"></textarea>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<label class="form-label">藥物使用狀況</label>
										<div class="drug-use-status-options multi-option">
											<#list drugUseStatus as dus>
											<div class="option<#if ptInfo.drugUsageHistory?seq_contains(dus.name)>selected</#if>" data-item="${dus.id}" >${dus.name}</div>
											</#list>
										</div>
										<textarea rows="2" class="form-control" placeholder="請填寫其他藥物使用狀況"></textarea>
									</div>
								</div>
								<hr class="divider" />
								<div class="card-topic">其他資料</div>							
								<div id="data-container"></div>						
							</div>
							<div class="footer-btn-list">										
								<!--<button class="func-btn func-btn-edit" onclick=""><i class="fa fa-pen-to-square"></i> 編輯</button>-->
								<button class="func-btn func-btn-next confirm-check"><i class="fa fa-check"></i> 確認報到</button>
							</div>
					    </fieldset>  
					    <fieldset class="form-step">
					    	<div class="col-md-12 pd-h-5 mg-b-10 justify-content-between">
				            	<div class="col-md-5">
				            		<div class="d-flex justify-content-between align-items-center mb-3">
						              	<h4 class="mb-0">評估紀錄</h4>
						              	<button class="btn btn-outline-primary btn-sm add-ast">新增量表</button>
						            </div>
									<div class="list-group"></div>
								</div>
								<div class="col-md-7 default-blk evaluation-blk">    			
					    			<div id="evaluation-container" class="evaluation"></div>
					    		</div>							
				            </div>
				            <div class="footer-btn-list">								
								<button class="func-btn func-btn-prev"><i class="fa fa-circle-arrow-left"></i> 上一步</button>
								<button class="func-btn func-btn-next" onclick=""><i class="fa fa-circle-arrow-right"></i> 下一步</button>										
							</div>			            
					    </fieldset>
					    <#if revisit>
					    <fieldset class="form-step">
					    	<div id="caseResult-container"></div>
						    <div class="footer-btn-list">								
								<button class="func-btn func-btn-prev"><i class="fa fa-circle-arrow-left"></i> 上一步</button>
								<button class="func-btn func-btn-next" onclick=""><i class="fa fa-circle-arrow-right"></i> 下一步</button>										
							</div>
						</fieldset>
					    </#if>
					    <fieldset class="form-step">
					    	<table class="default-table">
								<tr>
									<td class="sub-title"><@spring.message "hcrecord.detail.label.bringIn"/></td>
									<td>
										<div class="inline-cotainer">
											<select class="form-control recordList">
												<option value="" ><@spring.message "hcrecord.detail.option.bringIn.hint"/></option>
												<#if prevFormNos?? && (prevFormNos?size > 0 )>
												<#list prevFormNos as prevFormNo>
												<option value="${prevFormNo.id}" <#if copy?has_content && prevFormNo.id == recordId>selected</#if> >${prevFormNo.text}</option>
												</#list>
												</#if>
											</select>
											<button class="bringInRecord func-btn" ><i class="fa fa-circle-check"></i> <@spring.message "hcrecord.detail.button.confirm"/></button>
										</div>
									</td>
								</tr>							
								<tr>
									<td class="sub-title"><@spring.message "hcrecord.detail.label.reserve"/></td>
									<td>
										<div class="inline-cotainer">
											<input type="text" class="form-control doctor-reserve-time" data-item="" disabled />
											<button class="booking func-btn"><i class="fa fa-calendar-days"></i> <@spring.message "hcrecord.detail.button.check.schedule"/></button>
										</div>
									</td>
								</tr>
								<tr>
									<td class="sub-title"><@spring.message "hcrecord.detail.label.subjective"/></td>
									<td>
										<textarea rows="3" class="hcForm form-control" placeholder="<@spring.message "hcrecord.detail.placeholder.subjective"/>" data-item="701" ></textarea>
									</td>
								</tr>
								<tr>
									<td class="sub-title"><@spring.message "hcrecord.detail.label.objective"/></td>
									<td>
										<textarea rows="3" class="hcForm form-control" placeholder="<@spring.message "hcrecord.detail.placeholder.objective"/>" data-item="702" ></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.diagnosis"/></td>
								</tr>
								<tr>
									<td><@spring.message "hcrecord.detail.label.maincode"/></td>
									<td>
										<select class="hcForm icd-code" data-item="703" >
											<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
										</select>
									</td>
								</tr>
								<tr>
									<td><@spring.message "hcrecord.detail.label.subcode1"/></td>
									<td>
										<select class="hcForm icd-code" data-item="704" >
											<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
										</select>
									</td>
								</tr>
								<tr>
									<td><@spring.message "hcrecord.detail.label.subcode2"/></td>
									<td>
										<select class="hcForm icd-code" data-item="705" >
											<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
										</select>
									</td>
								</tr>
								<tr>
									<td><@spring.message "hcrecord.detail.label.subcode3"/></td>
									<td>
										<select class="hcForm icd-code" data-item="706" >
											<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
										</select>
									</td>
								</tr>
								<tr>
									<td><@spring.message "hcrecord.detail.label.subcode4"/></td>
									<td>
										<select class="hcForm icd-code" data-item="707" >
											<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
										</select>
									</td>
								</tr>
								<tr>
									<td><@spring.message "hcrecord.detail.label.subcode5"/></td>
									<td>
										<select class="hcForm icd-code" data-item="708" >
											<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.plan"/></td>
								</tr>
								<tr>
									<td colspan="2">
										<table class="table table-striped table-bordered bootstrap-datatable table-customed d-fixed-table main-table">
											<thead>
										      <tr class="tablesorter-headerRow">
										      	<th width="33%"><@spring.message "hcrecord.detail.column.code"/></th>
										      	<th width="6%"><@spring.message "hcrecord.detail.column.period"/></th>
										      	<th width="8%"><@spring.message "hcrecord.detail.column.points"/></th>					      	
										      	<th width="17%"><@spring.message "hcrecord.detail.column.executor"/></th>    
										        <th width="9%"><@spring.message "hcrecord.detail.column.startDate"/></th>
										        <th width="9%"><@spring.message "hcrecord.detail.column.endDate"/></th>
										        <th width="18%"><@spring.message "hcrecord.detail.column.funcItem"/></th>
										      </tr>					      
										    </thead>
											<tbody id="list_cnt">
												<tr class="clone-row">
											      	<td>
											      		<select class="itemForm form-control paymentItemCode" data-item="801"></select>
											      	</td>
											      	<td>
											      		<input type="text" class="itemForm form-control amount" data-item="802" disabled />
											      	</td>
											      	<td>
											      		<input type="text" class="itemForm form-control points" data-item="803" disabled />
											      	</td>
											      	<td>
											      		<select class="itemForm form-control executor" data-item="804">
									                        <option value=""><@spring.message "hcrecord.detail.option.select.hint"/></option>
									                        <#list doctors as doctor>                              	
							                        		<option value="${doctor.id!""}">[${doctor.userNo!""}] ${doctor.name!""}</option>
							                        		</#list>					
									                    </select>
											      	</td>
											      	<td>
											      		<input type="text" class="itemForm form-control beginTime" data-item="805" />
											      	</td>
											      	<td>
											      		<input type="text" class="itemForm form-control endTime" data-item="806" />
											      	</td>
											      	<td>
											      		<button id="addRow" class="func-btn"><i class="fa fa-circle-plus"></i> <@spring.message "hcrecord.detail.button.add"/></button>
											      		<button id="cleanRow" class="func-btn"><i class="fa fa-circle-xmark"></i> <@spring.message "hcrecord.detail.button.clean"/></button>
											      	</td>
											      </tr>
									      	</tbody>
										</table>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<table class="table table-striped table-bordered bootstrap-datatable table-customed sub-table">
											<thead>
										      <tr class="tablesorter-headerRow">
										      	<th width="55%"><@spring.message "hcrecord.detail.column.copaymentCode"/></th>
										      	<th width="15%"><@spring.message "hcrecord.detail.column.totalPoints"/></th>
										      	<th width="15%"><@spring.message "hcrecord.detail.column.partPoints"/></th>					      	
										      	<th width="15%"><@spring.message "hcrecord.detail.column.serialNo"/></th>
										      </tr>							      
										    </thead>
											<tbody id="list_cnt">
												<tr>
											      	<td>
											      		<select class="hcForm basicForm form-control copaymentCode" data-item="709">
											      			<option value=""><@spring.message "hcrecord.detail.option.select.hint"/></option>
											      			<option value="K00"><@spring.message "hcrecord.detail.option.k00.hint"/></option>
									      					<option value="K20"><@spring.message "hcrecord.detail.option.k20.hint"/></option>
											      		</select>
											      	</td>
											      	<td>
											      		<input type="text" class="hcForm basicForm form-control total-points" data-item="710" disabled />
											      	</td>
											      	<td>
											      		<input type="text" class="hcForm basicForm form-control part-points" data-item="711" disabled />
											      	</td>
											      	<td>
											      		<input type="number" class="hcForm basicForm form-control patient-serial-no" data-item="712" />
											      	</td>
										      	</tr>
									      	</tbody>
										</table>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div class="footer-btn-list">
											<!-- 既有按鈕 -->
											<button class="func-btn func-btn-prev">
												<i class="fa fa-circle-arrow-left"></i> 上一步
											</button>
											<button class="func-btn func-btn-next" onclick="">
												<i class="fa fa-circle-arrow-right"></i> 下一步
											</button>

											<!-- 新增的超連結按鈕 -->
											<a class="func-btn"
											href="http://localhost:3000/dashboard/doctor/consultation/2"
											target="_blank">
												<i class="fa fa-stethoscope"></i> 前往諮詢頁
											</a>
										</div>
									</td>
								</tr>
							</table>
					    </fieldset>
					    <fieldset class="form-step">
					    	<div class="appointment-blks">
					    		<div class="col-4">
					    			<div class="question-grp">
			    						<span>治療類別：</span>
			    						<div class="therapy-options single-option">
			    							<div class="option" data-alias="DTX_PI">物理</div>
			    							<div class="option" data-alias="DTX_OT">職能</div>
			    							<div class="option" data-alias="DTX_ST">語言</div>
			    							<div class="option" data-alias="DTX_PSY">心理</div>
			    						</div>
									</div>
									<div class="question-grp">
			    						<span>治療師選擇：</span>
			    						<select class="form-control therapist-options">
			    							<option value="">請選擇治療師</option>
			    						</select>
									</div>
									<div class="question-grp">
			    						<span>預約日期：</span>
			    						<input type="text" class="form-control therapist-reserve-time" data-cat="date" disabled />
									</div>
									<div class="question-grp">
			    						<span>預約時間：</span>
			    						<input type="text" class="form-control therapist-reserve-time" data-cat="time" disabled />
									</div>
					    		</div>
					    		<div class="col-8">
					    			<div id="wg-Container" style="width:100%;"></div>
					    		</div>
					    	</div>
					    	<div class="footer-btn-list">								
								<button class="func-btn func-btn-prev"><i class="fa fa-circle-arrow-left"></i> 上一步</button>
								<button id="completeConsultation" class="func-btn func-btn-next appo-arrange" ><i class="fa fa-circle-arrow-right"></i> 完成初診</button>										
							</div>
					    </fieldset>
					</form>
				</div>
			</div>	
		</div>		
	</body>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
		<div class="modal-dialog " style="width:850px;">
			<div class="modal-content" >
				<div class="modal-header">
					預約看診時間
					<button type="button" class="close clean" data-dismiss="modal" data-form="0" aria-label="Close">
			          	<i class="fa fa-xmark" aria-hidden="true"></i>
			        </button>
				</div>
				<div class="modal-body">
					<div id="appointment-container" style="width:100%;"></div>           
				</div>
				<div class="modal-footer">    
					<button class="func-btn confirm-appo" >確認預約</button>			
					<button class="clean func-btn" data-dismiss="modal"><@spring.message "task.button.cancel"/></button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
		<div class="modal-dialog " style="width:900px;">
			<div class="modal-content" >
				<div class="modal-header">
					新增評估量表
					<button type="button" class="close clean" data-dismiss="modal" data-form="0" aria-label="Close">
			          	<i class="fa fa-xmark" aria-hidden="true"></i>
			        </button>
				</div>
				<div class="modal-body">
					<table class="table table-striped table-bordered bootstrap-datatable table-customed d-fixed-table main-table assessment-table">
						<thead>
					      <tr class="tablesorter-headerRow">
					      	<th width="8%">選擇</th>
					      	<th width="10%">類別</th>
					      	<th width="25%">量表名稱</th>
					      	<th width="20%">類型</th>
					      	<th width="30%">描述</th>
					      	<th width="7%">版本</th>
					      </tr>
					    </thead>
						<tbody id="list_cnt">
	
				      	</tbody>
					</table>
				</div>
				<div class="modal-footer">    
					<button class="func-btn ast-confirm">確認</button>			
					<button class="func-btn clean" data-dismiss="modal"><@spring.message "task.button.cancel"/></button>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

var current_fs, next_fs, prev_fs;
var selectedDates = [];
var cUserId = ${currentUser.id!""};
var gCurPage = 1;
var sortClass = "";
var sortOrder = "";
var limit = 100;
var gSerach = false;
//var api = "/Assessment/api/getCaseAssessmentList";
var api = "/Scale/api/qryScalesList";
var base = "${base}";
var lang_ref = "${__lang}";
var field = "${__field}";
var formId = "${formId!""}";
var patientInfo = ${patientInfo!""};
console.log('patientInfo:', patientInfo);
/*定義欄位*/
var columnObj = [
    { data: "id", className: "id select-chk",
    	render: function ( data, type, row, meta ) {
    		return '<input type="checkbox" data-id="' + row.id + '" />';
    	}
	},
	{ data: "catId", className: "catId",
		render: function ( data, type, row, meta ) {
    		return '<span class="category-label label-' + row.catId.toLowerCase() + '">' + row.catName + '</span>';
    	}
	},
    { data: "name", className: "name" },
    { data: "type", className: "type"},
    { data: "desc", className: "text-ellipsis" },
    { data: "version" }
];

/*定義排序*/
var columnDefs = [
	{targets: [0,1,2,3,4,5], orderable: false}
];

$(document).ready(function(){
	// 初始化日期選擇器
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
	
	
	$("#twzipcode").twzipcode({
    	zipcodeIntoDistrict: false
    });
	// 在日期選擇器初始化完成後，填入患者資料
	setTimeout(function() {
		fillPatientInfo();
	}, 100);

	$('.startDate, .endDate').datepicker({
        language: "${__lang?replace('_', '-')}",
        autoclose: true,
        todayHighlight: true
    });
	
	$(".icd-code").each(function(idx){
		$(this).select2({
	        language: '${__lang}',
	        width: '100%',
	        maximumInputLength: 10,
	        minimumInputLength: 2,
	        placeholder: '<@spring.message "hcrecord.detail.option.enterCode"/>',
	        allowClear: true,
	        ajax: {
	            url: '/WgIcdCode/api/search',
	            type: 'POST',
				data: function(params) {
					// 將查詢參數包裝成 JSON 格式
					return JSON.stringify({
						code: params.term
					});
				},
	            processResults: function (data, params){
					console.log(data);
	 				if(data.message){
						return {
							results: [{ id: 'no-results', text: data.message }],
							pagination: {
								more: false
							}
						}
					} else {
						return {
							results: data.icdCodes,
							pagination: {
								more: false
							}
						}
					}
	            }
	        }
	    }).on("select2:unselecting", function(e) {	    	
			$(this).find("option").remove();
	 	});

 	});


	// 上一步
	$(".func-btn-prev").click(function (e) {
	    e.preventDefault();
	
	    var current_fs = $("fieldset:visible");
	    var prev_fs = current_fs.prev("fieldset");
	
	    if (prev_fs.length > 0) {
	        var currentIndex = $("fieldset").index(current_fs);
	
	        // 1 移除當前步驟的 "active"
	        $(".progressBar li").eq(currentIndex).removeClass("active");
	
	        // 2 如果當前步驟不是 "done"，將其設為 "touched"
	        if (!$(".progressBar li").eq(currentIndex).hasClass("done")) {
	            $(".progressBar li").eq(currentIndex).addClass("touched");
	        }
	
	        // 3 設置前一個步驟為 "active"
	        $(".progressBar li").eq(currentIndex - 1).removeClass("touched").addClass("active");
	
	        // 4 顯示對應的 fieldset
	        current_fs.hide().removeClass("active");
	        prev_fs.show().addClass("active");
	    }
	});
	
	// 下一步
	$(".func-btn-next").click(function (e) {
	    e.preventDefault();
		window.scrollTo(0,0);

	    var current_fs = $("fieldset:visible");
	    var next_fs = current_fs.next("fieldset");
	
	    if (next_fs.length > 0) {
	        var currentIndex = $("fieldset").index(current_fs);
	
	        // 1 移除當前步驟的 "active" 和 "touched"，並設為 "done"
	        $(".progressBar li").eq(currentIndex).removeClass("active touched").addClass("done");
	
	        // 2 設置下一個步驟為 "active"
	        $(".progressBar li").eq(currentIndex + 1).removeClass("touched").addClass("active");
	
	        // 3 顯示對應的 fieldset
	        current_fs.hide().removeClass("active");
	        next_fs.show().addClass("active");
	    }
	});
	
	// 點擊進度條跳轉功能
	$(".progressBar li").click(function (e) {
	    e.preventDefault();
	
	    var index = $(this).index(); // 點擊的進度條索引
	    var target_fs = $("fieldset").eq(index); // 對應的 fieldset
	    var current_fs = $("fieldset:visible"); // 當前顯示的 fieldset
	
	    // 只允許點擊 "done"、"touched" 或 "active" 的步驟
	    if ($(this).hasClass("done") || $(this).hasClass("touched") || $(this).hasClass("active")) {
	        var currentIndex = $("fieldset").index(current_fs);
	
	        // 1 移除當前步驟的 "active"，若非 "done" 則設為 "touched"
	        if (!$(".progressBar li").eq(currentIndex).hasClass("done")) {
	            $(".progressBar li").eq(currentIndex).removeClass("active").addClass("touched");
	        } else {
	            $(".progressBar li").eq(currentIndex).removeClass("active");
	        }
	
	        // 2 設置目標步驟為 "active"
	        $(".progressBar li").removeClass("active");
	        $(".progressBar li").eq(index).addClass("active");
	
	        // 3 顯示對應的 fieldset
	        current_fs.hide().removeClass("active");
	        target_fs.show().addClass("active");
	    } else {
	        swal("","您只能跳轉到已完成、已觸及或當前的步驟！", "warning");
	    }
	});
	
	selectAdapter(".paymentItemCode", 2, "<@spring.message "hcrecord.detail.option.planCode"/>", "/MedicalServicePaymentItems/api/searchByCodeAndItem", "${__lang}");
	
	$('.paymentItemCode').on('select2:selecting', function(e) {
 		var obj = $(this).closest("tr");
	    var data = e.params.args.data;
	    $(this).find("option").remove();
	    obj.find(".amount").val(data.amount);
	    obj.find(".points").val(data.points);
	    <#if copy??>
	    if(!$(this).prop('disabled')) $(".copaymentCode").trigger('change');
	    </#if>
  	});
 	//
 	timeAdapter(".beginTime, .endTime", "beginTime", "endTime");
 	
 	//顯示個案評估結果列表
 	triggerPatientEvalList();
	
	//wg.template.updateNewPageContent('wg-Container', 'therapist-booking-content', {}, '${base}/${__lang}/division/web/admin/taskMgnt/appointment/therapist/msg/chooseMessage');
	
	wg.template.updateNewPageContent('wg-Container', 'therapist-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment/msg/chooseMessage?clinician=therapist');

	<#if revisit> 
	wg.template.updateNewPageContent('caseResult-container', 'caseResult', {"formId": ${formId!""}}, '${base}/${__lang}/division/web/${formId!""}/trainingResult');
	
	wg.template.updateNewPageContent('data-container', 'data-content', {}, '/ftl/imas/admin/dataForm?viewer=pt');
	<#else>
	//wg.template.updateNewPageContent('data-container', 'data-content', {}, '/ftl/imas/admin/dataForm?viewer=doctor');
	wg.template.updateNewPageContent('data-container', 'data-content', {}, '/ftl/imas/admin/dataForm?viewer=pt');
	
	</#if>
});

/*確認個案報到觸發行為*/
$(".confirm-check").click(function(){
	editPatientBaseInfo();
});
$(".confirm-check").click(function(){
	var postData = {"slotId": ${slotId}, "cat": 1, "caseno": "${formId!""}"};
	const jsonData = JSON.stringify(postData);
	var result = wg.evalForm.getJson(jsonData, "/WgTask/api/checkin");
	
	if(!result.success){
		swal('報到失敗', "無法執行報到作業!", "error");
	}
});

/*相關病史點選變色*/
$(".option:not(.editable-option):not(.option--disabled)").click(function() {
    var $parent = $(this).parent("div");

    if ($parent.hasClass("single-option")) {
        // 單選處理
        $parent.find(".option").removeClass("selected");
        $(this).addClass("selected");
    }else{
        // 多選處理
        $(this).toggleClass("selected");
    }
});

/*預約看診*/
$('.booking').on('click', function(e){
	e.preventDefault();
	wg.template.updateNewPageContent('appointment-container', 'doctor-booking-content', {"doctorId": ${currentUser.id!""}}, '/ftl/imas/admin/taskMgnt/appointment?clinician=doctor&doctorId=${currentUser.id!""}');	
	
	$("#myModal").modal('show');
});

$('#addRow').on( 'click', function (e) {
	e.preventDefault();
	
	var selectCode = $(this).closest("tr").find("select:eq(0)").val();
	var selectObj = $(this).closest("tr").find("select");
	var inputEmptyLeng = $(this).closest("tr").find("input").filter(function () {
	    return $.trim($(this).val()).length == 0
	}).length;
	
	if(verify(selectCode)){
		swal("代碼重複", "處置代碼重複請修正後再新增!", "error");
		return;
	}	
	
	if(inputEmptyLeng == 0 && selectObj.find("option").length != 0 && selectObj.val() != ""){
		var newcnt = $(this).closest("tr").clone();
		
		$(newcnt).addClass("clone");
		$(newcnt).find("input, select").each(function(){
			$(this).attr("disabled", "disabled");
		});
		$(newcnt).find("td:last-child").html("").append("<button class='delete-row func-btn'><i class='fa fa-trash-can'></i> 刪除</button>");
	
		$(this).closest("tr").before(newcnt);
		
		$(".delete-row").click(function(){
			$(this).closest("tr").remove();
			$(".copaymentCode").trigger('change');
		});
		
		$(".copaymentCode").trigger('change');
	}else{
		swal("<@spring.message "hcrecord.detail.add.fail.title"/>", "<@spring.message "hcrecord.detail.add.fail.text"/>", "error");
	}
});

$(".delete-row").on('click', function(e){
	e.preventDefault();
	
	<#if mode?has_content && mode == "edit">
	var keyno = $(this).closest("tr").attr("data-keyno");
	var trobj = $(this).closest("tr");
	if(keyno != undefined){
		confirmCheck("<@spring.message "hcrecord.detail.delete.confirm.title"/>", "<@spring.message "hcrecord.detail.delete.confirm.text"/>", "warning", "btn-danger", "<@spring.message "hcrecord.detail.button.confirm"/>", "<@spring.message "hcrecord.detail.button.cancel"/>", function(confirmed){
			if(confirmed){			
				var postData = {"recordId": keyno};
				var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/removeUserForm?");
			    if(result.success){
					trobj.remove();
					$(".copaymentCode").trigger('change');
					swal("<@spring.message "hcrecord.detail.delete.success.title"/>", "<@spring.message "hcrecord.detail.delete.success.text"/>", "success");
				}else{
					swal("<@spring.message "hcrecord.detail.delete.fail.title"/>", "<@spring.message "hcrecord.detail.delete.fail.text"/>", "error");
				}
			}
		});
	}else{
		trobj.remove();
		$(".copaymentCode").trigger('change');		
	}
	
	<#else>
	$(this).closest("tr").remove();
	$(".copaymentCode").trigger('change');
	</#if>
	
});

$("#cleanRow").on('click', function(e){
	e.preventDefault();
	
	var target = $(this).closest("tr");
	target.find("input[type='text']").val("");
	target.find("select").val("").trigger('change');
	target.find('.paymentItemCode').find("option").remove();
});

$(".clone-row").find(".executor").on( 'change', function (e) {
	e.preventDefault();
	
	var selectValue = $(this).val();
	$(this).find("option").removeAttr('selected');
	$(this).find("option[value='" + selectValue + "']").attr('selected', true);
	$(this).val(selectValue);
});

/* 新增量表 */
$(".add-ast").click(function(e) {
	e.preventDefault();
	
	showScalesList();
	$("#myModal2").modal('show');
});

//顯示量表管理之列表
function showScalesList(){
	var queryData = {"userId": cUserId, "param": $(".param").val(), "patientId": "${formId}", "page_num": 1, "limit": limit};
	initAjaxDataSortTableV2('.assessment-table', limit, api, queryData, columnObj, columnDefs, page_info, false);
}

//量表新增確認
$(".ast-confirm").click(function(){
	var selectedIds = [];
	$('.assessment-table input[type="checkbox"]:checked').each(function() {
        selectedIds.push($(this).data('id'));
    });
    selectedIds.sort((a, b) => a - b);
    
    var postData = {"therapistId": cUserId, "patientId": "${formId!""}", "scaleIds": selectedIds, "showList": true};
    var result = wg.evalForm.getJson(JSON.stringify(postData), "/Assessment/api/createAssessment");
    if(result.success){
    	showAssessmentList(result.data);
    	$("#myModal2").modal('hide');
    }
});

function getTherapyCat(catId){
	var catName = "";
	switch(catId){
		case 'PT':
			catName = "<@spring.message "treatment.abbr.pt"/>";
			break;
		case 'OT':
			catName = "<@spring.message "treatment.abbr.ot"/>";
			break;
		case 'PS':
			catName = "<@spring.message "treatment.abbr.ps"/>";
			break;
		case 'ST':
			catName = "<@spring.message "treatment.abbr.st"/>";
			break;
	}
	
	return catName;
}


//醫師預約時間確認行為
$(".confirm-appo").click(function(e){
	e.preventDefault();
	var slotId = $(".myc-available-time.selected").attr("data-unique");
	var postData = {"userId": cUserId, "slotId": slotId, "cat": 1, "caseno": "${formId!""}"};
	var result = wg.evalForm.getJson(JSON.stringify(postData), "/WgTask/api/createNewAppo");
	console.log("slotResult: ", result);
	if(result.success){
		swal("預約成功", "已成功預約下次看診時間!", "success");
		$('.doctor-reserve-time').val(result.slotTime);
		$(".clean").trigger('click');
	}else{
		if(result.msg == undefined) result.msg = "無法預約看診時間!";
		swal("預約失敗", result.msg, "error");
	}
});

//顯示個案評估列表
function triggerPatientEvalList(){
	var postData = {"patientId": "${formId!""}"};
 	var result = wg.evalForm.getJson(JSON.stringify(postData), "/Assessment/api/getCaseAssessmentList?location=${__field}");
 	console.log("result.data: ", result.data);
	if(result.success){
 		showAssessmentList(result.data);
 	}
}
//顯示個案評估量表列表
function showAssessmentList(data, redirectId){
	$(".list-group").empty();
	
	if(data.length > 0){
 		$.each(data, function (i, item) {
 			var subfuncList = item.subfuncList != "" ? `<div class="sub-func-list">`+ item.subfuncList + `</div>` : "";
 			var html = `
		    <div class="list-group-item card-hover mb-2" data-id=`+ item.id + ` data-mode=`+ item.mode + `>
		    	<div class="d-flex justify-content-between">
		    		<div class="flex-grow-1 me-2">
		          		<div class="d-flex align-items-center mb-1">
		            		`+ item.cat + `
		            		<p class="form-name mg-b-0">`+ item.scaleName + `</p>
		          		</div>
		        	</div>
		        	<div class="text-end">`+ item.result + `</div>
		      	</div>
		      	<div class="sub-content">
		        	<div class="sub-content-left">
		          		<small class="text-muted">填寫日期：`+ item.assessmentDate + `</small>
		          		<small class="text-muted">前次評量：`+ item.lastAssessmentDate + `</small>
		          		<small class="text-muted">填寫者：`+ item.editor + `</small>
		        	</div>
		        	<div class="sub-content-right">
		        		`+ item.level + subfuncList + `		        		
	        		</div>
		      	</div>
		    </div>
		  	`;
 			
 			$(".list-group").append(html);
 		});
 		
 		if(redirectId != undefined){
			$(".list-group-item[data-id='" + redirectId + "']").trigger('click');
		} else {
 			wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {}, '/ftl/imas/admin/taskMgnt/evaluation/message?msg=emptyMessage');
		}
	}else{
		wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {}, '/ftl/imas/admin/taskMgnt/evaluation/message?msg=addMessage');
	}
}

$("body").on("click", ".list-group-item, .do-fill", function(e) {
	e.preventDefault();
	
	if ($(e.target).is(".do-fill")) {
        e.stopPropagation();
    }
    

	var $item = $(this).hasClass("list-group-item") ? $(this) : $(this).closest(".list-group-item");
	var formId = $item.data("id");
	var mode = $item.data("mode");
	
	$(this).parent().find(".list-group-item").removeClass("selected");
	$(this).toggleClass("selected");
	
	wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {"isFromPatient": false}, '/ftl/imas/admin/taskMgnt/evaluation?formId=' + formId + '&mode=' + mode + '&patientId=${formId!""}');
	$('.evaluation-blk').fadeIn(500); // 0.5秒淡入
});

//播放錄影回放影片
$("body").on("click", ".video-play", function(e) {
	e.preventDefault();

});

//檢視數據歷程
$("body").on("click", ".chart-review", function(e) {
	e.preventDefault();

});

function createHcInfo() {
    // 收集健保主表資料（用 class 取值）
    var healthRecord = {
        patientId: formId, // 病患ID
        subjective: $(".hcForm.subjective").val(), // 主觀描述
        objective: $(".hcForm.objective").val(), // 客觀描述
        mainDiagnosisCode: $(".hcForm.main-diagnosis").val(), // 主診斷碼
        secondaryDiagnosisCodes: [
            $(".hcForm.secondary-diagnosis1").val(),
            $(".hcForm.secondary-diagnosis2").val(),
            $(".hcForm.secondary-diagnosis3").val(),
            $(".hcForm.secondary-diagnosis4").val(),
            $(".hcForm.secondary-diagnosis5").val()
        ].filter(function(code){ return code && code.trim() !== ""; }), // 過濾空值
        copaymentCode: $(".hcForm.copaymentCode").val(), // 部分負擔代碼
        totalPoint: parseInt($(".hcForm.total-points").val() || "0"), // 合計點數
        copayment: parseInt($(".hcForm.part-points").val() || "0"), // 部分負擔金額
        serialNum: $(".hcForm.patient-serial-no").val() // 就醫序號
    };

    // 收集治療處置項目
    var treatments = [];
    $(".clone").each(function () {
        var treatment = {
            treatmentCode: $(this).find(".paymentItemCode").val(),
            totalMount: $(this).find(".amount").val(),
            point: parseInt($(this).find(".points").val() || "0"),
            executiveId: $(this).find(".executor").val(),
            startTime: $(this).find(".beginTime").val(),
            endTime: $(this).find(".endTime").val()
        };
        if (treatment.treatmentCode && treatment.treatmentCode.trim() !== "") {
            treatments.push(treatment);
        }
    });

    var formData = {
        creatorId: cUserId,
        healthRecord: healthRecord,
        treatments: treatments
    };
	
    // 欄位完整性檢查
    function isEmpty(val) { return val == null || val.toString().trim() === "" || (typeof val === 'number' && isNaN(val)); }
    // 檢查主表欄位
    for (var key in healthRecord) {
        if (key !== 'secondaryDiagnosisCodes' && isEmpty(healthRecord[key])) {
            swal('請填寫完整資料', '主表欄位不得為空', 'warning');
            e.stopImmediatePropagation();
            e.preventDefault();
            return false;
        }
    }
    // 檢查處置項目欄位
    for (var i = 0; i < treatments.length; i++) {
        var tr = treatments[i];
        for (var f in tr) {
            if (isEmpty(tr[f])) {
                swal('請填寫完整資料', '第 ' + (i+1) + ' 筆處置欄位「' + f + '」不得為空', 'warning');
                e.stopImmediatePropagation();
                e.preventDefault();
                return false;
            }
        }
    }
	
    console.log("收集到的健保主表資料:", healthRecord);
    console.log("收集到的治療處置資料:", treatments);
    console.log("完整健保資料:", formData);

	$.ajax({
		url: "/HealthInsuranceRecord/api/save",
		data: JSON.stringify(formData),
		method: "POST",
		contentType: "application/json",
		success: function (result) {
			if (result.success) {
				swal("資料儲存成功", "健保資料已成功儲存!", "success");
			} else {
				swal("資料儲存失敗", result.msg || "無法儲存健保資料!", "error");
			}
		},
		error: function (error) {
			swal("資料儲存失敗", "無法儲存健保資料!", "error");
		}
	});

    // allow event to propagate to next-step handler
    return true;
}


function verify(specificTxt){
	var duplicated = false;
	var codeArray = [];
	var cloneNum = $(".clone").length;
	if(cloneNum > 0){
		$(".clone").each(function(){
			var code = $(this).find("select:eq(0)").val();
			codeArray.push(code);
		});
		
		if(codeArray.includes(specificTxt))	duplicated = true;
	}
	return duplicated;
}

// 部分負擔點數計算
$(".copaymentCode").change(function(){
	if($(this).val() != ""){
		var totalPoints = 0;
		//處置費用總計
		$(".clone").each(function(){
			var point = $(this).find(".points").val();
			if(point != "") totalPoints += parseInt(point);
		});
		$(".total-points").val(totalPoints);
		
		if($(this).val() == "K00"){
			$(".part-points").val(Math.round(totalPoints*0.05));
		}else{
			//未來藥費納入需要扣除
			//假設居家照護醫療費用總額為 10,000 元，其中藥費和藥事服務費總額為 2,000 元
			//實際居家照護醫療費用為 10,000 元 - 2,000 元 = 8,000 元
			//計算方式為 8,000 元 * 5% = 400 元
			//假設藥品部分負擔為 10%。計算方式為 2,000 元 * 10% = 200 元
			//將部分負擔醫療費用和藥品部分負擔相加，即 400 元 + 200 元 = 600 元
			$(".part-points").val(Math.round(totalPoints*0.05));
		}
	}
});

//選擇治療類別觸發行為
$(".therapy-options .option").click(function(){
	wg.template.updateNewPageContent('wg-Container', 'therapist-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment/msg/chooseMessage?clinician=therapist');
	console.log('選擇治療類別', $(this).val());
	$('.therapist-reserve-time').val('');
	
	var postData = {"alias": $(this).data("alias")};
	//var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/qryUserListByRole");
	console.log('postData', postData);
	var result = wg.evalForm.getJson(JSON.stringify(postData), "/User/api/listUserRole");
	console.log(result);
	if(result.success){
		showDoctorList(result.doctors);
	}
});

//治療師切換可預約時間表
$("body").on("change", ".therapist-options", function() {
	var doctorId = $(this).val();
	if(doctorId != ""){
		wg.template.updateNewPageContent('wg-Container', 'therapist-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment?clinician=therapist&doctorId=' + doctorId);
	}else{
		wg.template.updateNewPageContent('wg-Container', 'therapist-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment/msg/chooseMessage?clinician=therapist');
	}
});

//顯示對應治療類別之治療師名單
function showDoctorList(objList){
	$(".therapist-options").find('option:not(:first)').remove();
	
	var cnt = "";
	$.each(objList, function(index, obj) {
		cnt += `<option value="` + obj.id + `" >` + obj.username + `</option>`;
	});
	$(".therapist-options").append(cnt);
	
}

$("#completeConsultation").click(function(e){
	e.preventDefault();
	createHcInfo();
	editPatientBaseInfo();
	var doctorId = $(".therapist-options .option.selected").attr("data-doctor");
	console.log('doctorId', doctorId);
	
	var slotId = $(".myc-available-time.selected").attr("data-unique");
	console.log('slotId', slotId);

	if(doctorId == undefined || slotId == undefined){
		swal("送出失敗", "請再次確認是否有安排下次看診時間!", "error");
	}else{
		var postData = {"creator": doctorId, "availableSlotId": slotId, "cat": 2, "caseNo": "${formId!""}"};
		var result = wg.evalForm.getJson(JSON.stringify(postData), "/WgTask/api/createNewAppo");
		
		if(result.success){
			successToDirect("診斷完成", "完成個案診斷與評估作業，系統自動導向首頁總覽中", "success", 1500, "/ftl/imas/dashboard");
		}else{
			if(result.msg == undefined) result.msg = "無法預約看診時間!";
			swal("預約失敗", result.msg, "error");
		}
	}
});

// === 自動填入 patientInfo 函數 ===
function fillPatientInfo() {
    if (typeof patientInfo === 'object' && patientInfo) {
        console.log('正在自動填入患者資料:', patientInfo);
        
        // 姓名
        $('#patient-name').val(patientInfo.name || "");
        // 性別
        $('#patient-gender').val(patientInfo.gender || "");
        // 病歷號
        $('#patient-charno').val(patientInfo.charno || "");
        // 身分證字號
        $('#patient-idno').val(patientInfo.idno || "");
        // 聯絡電話
        $('#patient-phone').val(patientInfo.phone || "");
        // 緊急聯絡人
        $('#patient-emergency-contact').val(patientInfo.emergencyContact || "");
        // 緊急聯絡人關係
        $('#patient-emergency-relation').val(patientInfo.emergencyRelation || "");
        // 緊急聯絡電話
        $('#patient-emergency-phone').val(patientInfo.emergencyPhone || "");
        // 電子信箱
        $('#patient-email').val(patientInfo.email || "");
        // 婚姻狀態
        var maritalValue = "";
        if (patientInfo.maritalStatus === "已婚") {
            maritalValue = "Y";
        } else if (patientInfo.maritalStatus === "未婚") {
            maritalValue = "N";
        }
        $('#patient-marital-status').val(maritalValue);

		// === 地址 (縣市/鄉鎮/郵遞區號) ===
		$('#twzipcode').twzipcode('set', {
		zipcode : patientInfo.zipcode  || '',   // 若有郵遞區號可一起帶入
		county  : patientInfo.city     || '',   // 例如「新竹縣」
		district: patientInfo.district || ''    // 例如「竹北市」
		});
        // 聯絡地址
        $('#patient-address').val(patientInfo.address || "");
        
		if (patientInfo.birth) {
		// 期望格式：1995-04-18
		const [y, m, d] = patientInfo.birth.split("/");
		console.log('患者出生日期: ', y, m, d);
		// 將前導零去掉，轉成數字
		const yearNum = parseInt(y, 10);

		// 若大於 1911 視為西元年，否則視為本就民國年
		const rocYear = yearNum > 1911 ? yearNum - 1911 : yearNum;
		// dropdownDatepicker 會以 input id 為基底產生三個 select
		$('.form-control.year').val(rocYear);
		$('.form-control.month').val(m);
		$('.form-control.day').val(d);

		// 同步隱藏欄位，供後端送出
		$("#patient-birth").val(patientInfo.birth);
		}
        console.log('患者資料填入完成');
    } else {
        console.warn('patientInfo 資料不存在或格式不正確');
    }
}

function editPatientBaseInfo() {
	let formId = ${formId!""};
	console.log('formId: ', formId);
	// 驗證必要欄位
	if (!formId) {
		swal("錯誤", "無法取得病患 ID", "error");
		return;
	}

	// 收集 Patient 基本資料
	let patientData = collectPatientBasicData();
	console.log('收集到的病患基本資料:', patientData);
	// 收集 OtherPatientInfo 資料
	let otherPatientInfo = collectOtherPatientInfo();
	console.log('收集到的其他病患資訊:', otherPatientInfo);
	// 建立請求資料物件
	let postData = {
		"patientId": formId,
		...patientData,
		"otherPatientInfo": otherPatientInfo
	};

	// 發送請求
	try {
		console.log('發送更新病患資料請求:', postData);
		let response = wg.evalForm.getJson(JSON.stringify(postData), "/Patient/api/editPatientInfo");
		console.log('更新病患資料回應:', response);
		if (response.success) {
			swal("修改成功", response.message || "患者資料已更新", "success");
		} else {
			swal("修改失敗", response.error || response.message || "無法更新患者資料", "error");
		}
	} catch (error) {
		console.error('更新病患資料時發生錯誤:', error);
		swal("修改失敗", "系統錯誤，請稍後再試", "error");
	}
}

/**
 * 收集病患基本資料
 * 僅收集非空值，實現選擇性更新
 */
function collectPatientBasicData() {
	let data = {};
	
	// 基本個人資料
	let idno = $('#idno').val()?.trim();
	if (idno) data.idno = idno;
	
	let gender = $('#gender').val()?.trim();
	if (gender) data.gender = gender;
	
	let maritalStatus = $('#maritalStatus').val()?.trim();
	if (maritalStatus) data.maritalStatus = maritalStatus;
	
	let year = $('.form-control.year').val();
	let month = $('.form-control.month').val();
	let day = $('.form-control.day').val();
	/*
	let birth = year + `-` + month + `-` + day;
	if (birth) data.birth = birth;
	*/
	// 地址資訊
	let city = $('#city').val()?.trim();
	if (city) data.city = city;
	
	let district = $('#district').val()?.trim();
	if (district) data.district = district;
	
	let address = $('#address').val()?.trim();
	if (address) data.address = address;
	
	// 緊急聯絡人
	let emergencyContact = $('#emergencyContact').val()?.trim();
	if (emergencyContact) data.emergencyContact = emergencyContact;
	
	let emergencyPhone = $('#emergencyPhone').val()?.trim();
	if (emergencyPhone) data.emergencyPhone = emergencyPhone;
	
	let emergencyRelation = $('#emergencyRelation').val()?.trim();
	if (emergencyRelation) data.emergencyRelation = emergencyRelation;
	
	// 醫療相關資訊
	let otherHistoryDisease = $('#otherHistoryDisease').val()?.trim();
	if (otherHistoryDisease !== undefined) data.otherHistoryDisease = otherHistoryDisease;
	
	let otherMedicalHistory = $('#otherMedicalHistory').val()?.trim();
	if (otherMedicalHistory !== undefined) data.otherMedicalHistory = otherMedicalHistory;
	
	let otherDrugUseStatus = $('#otherDrugUseStatus').val()?.trim();
	if (otherDrugUseStatus !== undefined) data.otherDrugUseStatus = otherDrugUseStatus;
	
	let diseaseId = $('#diseaseId').val();
	if (diseaseId && !isNaN(diseaseId)) data.diseaseId = parseInt(diseaseId);
	
	// 個人病史（對應 class="history-options"）
	const diseaseCategoryIds = getSelectedCategoryIds('history-options');
	if (diseaseCategoryIds.length) data.diseaseCategoryIds = diseaseCategoryIds;

	// 藥物過敏史（class="allergy-history-options"）
	const medicalCategoryIds = getSelectedCategoryIds('allergy-history-options');
	if (medicalCategoryIds.length) data.medicalCategoryIds = medicalCategoryIds;

	// 藥物使用狀況（class="drug-use-status-options"）
	const drugUseStatusCategoryIds = getSelectedCategoryIds('drug-use-status-options');
	if (drugUseStatusCategoryIds.length) data.drugUseStatusCategoryIds = drugUseStatusCategoryIds;
	
	return data;
}

/**
 * 收集其他病患資訊
 * 僅收集非空值，實現選擇性更新
 */
function collectOtherPatientInfo() {
	let data = {};
	let speechDevIssues = [];
	
	// 主要問題和困難描述
	let mainIssueDesc = $('#mainIssueDesc').val()?.trim();
	if (mainIssueDesc !== undefined && mainIssueDesc !== "") data.mainIssueDesc = mainIssueDesc;
	
	let difficultyDesc = $('#difficultyDesc').val()?.trim();
	if (difficultyDesc !== undefined && difficultyDesc !== "") data.difficultyDesc = difficultyDesc;
	
	// 教育和職業資訊
	let educationLevel = $('#educationLevel').val()?.trim();
	if (educationLevel && educationLevel !== "") data.educationLevel = educationLevel;
	
	let occupation = $('#occupation').val()?.trim();
	if (occupation && occupation !== "") data.occupation = occupation;
	
	let familyLanguage = $('#familyLanguage').val()?.trim();
	if (familyLanguage && familyLanguage !== "") data.familyLanguage = familyLanguage;
	
	let preeducationExp = $('#preeducationExp').val()?.trim();
	if (preeducationExp && preeducationExp !== "") data.preeducationExp = preeducationExp;
	
	// 家庭資訊
	let fatherEducation = $('#fatherEducation').val()?.trim();
	if (fatherEducation && fatherEducation !== "") data.fatherEducation = fatherEducation;
	
	let motherEducation = $('#motherEducation').val()?.trim();
	if (motherEducation && motherEducation !== "") data.motherEducation = motherEducation;
	
	let fatherOccupation = $('#fatherOccupation').val()?.trim();
	if (fatherOccupation && fatherOccupation !== "") data.fatherOccupation = fatherOccupation;
	
	let motherOccupation = $('#motherOccupation').val()?.trim();
	if (motherOccupation && motherOccupation !== "") data.motherOccupation = motherOccupation;
	
	// 語言和溝通能力
	$('.speech-dev-issue-options .option.selected').each(function () {
		const id = parseInt($(this).data('item'));
		if (!isNaN(id)) speechDevIssues.push(id);
	});
	if (speechDevIssues.length) data.speechDevIssues = speechDevIssues;

	let communicationMtd = $('#communicationMtd').val()?.trim();
	if (communicationMtd && communicationMtd !== "") data.communicationMtd = communicationMtd;
	
	let suspectedSpeechIssues = $('#suspectedSpeechIssues').val()?.trim();
	if (suspectedSpeechIssues && suspectedSpeechIssues !== "") data.suspectedSpeechIssues = suspectedSpeechIssues;
	
	let comprehensionAbility = $('#comprehensionAbility').val()?.trim();
	if (comprehensionAbility && comprehensionAbility !== "") data.comprehensionAbility = comprehensionAbility;
	
	let expressionAbility = $('#expressionAbility').val()?.trim();
	if (expressionAbility && expressionAbility !== "") data.expressionAbility = expressionAbility;
	
	// 醫療和發展狀況
	let swallowDifficulty = $('#swallowDifficulty').val()?.trim();
	if (swallowDifficulty && swallowDifficulty !== "") data.swallowDifficulty = swallowDifficulty;
	
	let psychologicalState = $('#psychologicalState').val()?.trim();
	if (psychologicalState && psychologicalState !== "") data.psychologicalState = psychologicalState;
	
	let developmentalDelay = $('#developmentalDelay').val()?.trim();
	if (developmentalDelay && developmentalDelay !== "") data.developmentalDelay = developmentalDelay;
	
	// 心理治療和風險評估
	let psychologicalTreatment = $('#psychologicalTreatment').val()?.trim();
	if (psychologicalTreatment && psychologicalTreatment !== "") data.psychologicalTreatment = psychologicalTreatment;
	
	let treatmentDetails = $('#treatmentDetails').val()?.trim();
	if (treatmentDetails !== undefined && treatmentDetails !== "") data.treatmentDetails = treatmentDetails;
	
	let suicidalThoughts = $('#suicidalThoughts').val()?.trim();
	if (suicidalThoughts && suicidalThoughts !== "") data.suicidalThoughts = suicidalThoughts;
	
	let selfHarmBehavior = $('#selfHarmBehavior').val()?.trim();
	if (selfHarmBehavior && selfHarmBehavior !== "") data.selfHarmBehavior = selfHarmBehavior;
	
	// 家庭和社會支持
	let recentStressEvents = $('#recentStressEvents').val()?.trim();
	if (recentStressEvents !== undefined && recentStressEvents !== "") data.recentStressEvents = recentStressEvents;
	
	let familySupportLevel = $('#familySupportLevel').val()?.trim();
	if (familySupportLevel && familySupportLevel !== "") data.familySupportLevel = familySupportLevel;
	
	// 其他備註
	let otherRemarks = $('#otherRemarks').val()?.trim();
	if (otherRemarks !== undefined && otherRemarks !== "") data.otherRemarks = otherRemarks;
	
	return data;
}

/**
 * 從自訂 .option 甚至 checkbox / select all in one 抓取選中 ID
 * categoryType 例如：history-options、allergy-history-options …
 */
function getSelectedCategoryIds(categoryType) {
    const ids = [];

    $(`.` + categoryType + ` .option.selected`).each(function () {
        const id = parseInt($(this).data('item'));   // 讀 data-item
        if (!isNaN(id)) ids.push(id);
    });

    return ids;
}

$('.speech-dev-issue-options .option').on('click', function () {
	$(this).toggleClass('selected');
	// 更新選中狀態
	const selectedIds = getSelectedCategoryIds('speech-dev-issue-options');
	console.log('選中的語言發展問題 ID:', selectedIds);
});
</script>

<style>

/* 治療類別選項 */
.therapy-options{
	display: flex;
	flex-wrap: wrap;
	gap: 5px;
}

.therapy-options .option{
	flex: 1;
	text-align: center;
}

</style>

<#-- <#include "/imas/casemgnt/socket.ftl" /> -->
<#include "/imas/widget/widget.ftl" />