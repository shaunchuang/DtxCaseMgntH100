<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
           		<#if revisit>
           		<ul class="progressBar">
				    <li class="active">基本資料</li>
				    <li>檢視診斷報告</li>
				    <li>填寫評估量表</li>
				    <li>檢視訓練紀錄</li>
				    <li>制定訓練計畫</li>
				    <li>預約回診</li>
				</ul>
				<#else>
           		<ul class="progressBar">
				    <li class="active">基本資料</li>
				    <li>檢視診斷報告</li>
				    <li>填寫評估量表</li>
				    <li>制定訓練計畫</li>
				    <li>預約回診</li>
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
				</div>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<form action="" >
					<fieldset class="form-step active">
						<div class="card pd-10">
							<div class="card-topic">個案資料</div>
							<div class="row mg-b-10">								<div class="col-md-3">
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
							</div>							<div class="row mg-b-10">
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
							</div>							<div class="row mg-b-10">
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
								</div>								<div class="col-md-6">
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
										<div class="option<#if ptInfo.diseaseNames?seq_contains(pdhItems.id?string)> selected</#if>" data-item="${pdhItems.id}" >${pdhItems.name}</div>
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
										<div class="option<#if ptInfo.medicalHistory?seq_contains(dahItems.id?string)> selected</#if>" data-item="${dahItems.id}" >${dahItems.name}</div>
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
											<div class="option<#if ptInfo.drugUsageHistory?seq_contains(dus.id?string)> selected</#if>" data-item="${dus.id}" >${dus.name}</div>
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
				    	<div class="default-blks report-blks">
			            	<div class="col-5 default-blk">
			            		<div class="title">就診紀錄</div>
			            		<table class="table table-fixed">
									<thead>
								      	<tr>
								      		<th class="col-xs-1">序</th>
								      		<th class="col-xs-3">診斷日期</th>
								      		<th class="col-xs-2-5">診斷醫師</th>
						                    <th class="col-xs-5-5">診斷內容</th>						                    
								      	</tr>
								    </thead>
								    <tbody class="diagnosis-records">
								    	<#if hcRecords?? && (hcRecords?size>0) >
								    	<#list hcRecords as hcRecord>
								    	<tr data-record="${hcRecord.keyno}">
						                	<td class="col-xs-1">${hcRecord.serialno}</td>
								      		<td class="col-xs-3">${hcRecord.diagDate}</td>
								      		<td class="col-xs-2-5">${hcRecord.doctorName}</td>
						                    <td class="col-xs-5-5">${hcRecord.mainIcdCode}</td>					                    
						                </tr>
						                </#list>
								    	</#if>
								    </tbody>
								</table>
			            	</div>
			            	<div class="col-7 default-blk report-blk">
			            		<div id="report-container" class="report overflowY"></div>
			            	</div>							
			            </div>
			            <div class="footer-btn-list">								
							<button class="func-btn func-btn-prev"><i class="fa fa-circle-arrow-left"></i> 上一步</button>
							<button class="func-btn func-btn-next" onclick=""><i class="fa fa-circle-arrow-right"></i> 下一步</button>										
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
							<button class="func-btn func-btn-next" onclick="viewTrRecordCheckpoint()"><i class="fa fa-circle-arrow-right"></i> 下一步</button>										
						</div>	
				    </fieldset>
				    </#if>
				    <fieldset class="form-step">
				    	<table class="default-table d-fixed-table trainingPlan-table">
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
								<td class="sub-title"><@spring.message "hcrecord.detail.label.subjective"/></td>
								<td>
									<textarea rows="3" class="basicForm form-control subjective" placeholder="<@spring.message "hcrecord.detail.placeholder.subjective"/>" ></textarea>
								</td>
							</tr>
							<tr>
								<td class="sub-title"><@spring.message "hcrecord.detail.label.objective"/></td>
								<td>
									<textarea rows="3" class="basicForm form-control objective" placeholder="<@spring.message "hcrecord.detail.placeholder.objective"/>" ></textarea>
								</td>
							</tr>
							<tr>
								<td class="sub-title">選擇使用教案</td>
								<td>
									<div class="switch-toolbar mg-b-5">
									  	<button type="button" title="我的收藏" aria-pressed="false" class="switch-btn" disabled data-cat="library">我的收藏</button>
									  	<button type="button" title="系統推薦" aria-pressed="false" class="switch-btn" data-cat="recommend">系統推薦</button>
										<input type="text" class="form-control lesson" placeholder="請選擇下列其中一項個案訓練方案" disabled />
									</div>
									<div class="lesson-list">

				                        <!-- Repeat cards as needed -->
				                    </div>							
									<div class="lesson-pagination">
							            <button type="button" id="prevPage" class="pagination-btn">上一頁</button>
							            <span id="currentPage">1</span> / <span id="totalPage">1</span>
							            <button type="button" id="nextPage" class="pagination-btn">下一頁</button>
							        </div>
								</td>
							</tr>
							<tr>
								<td class="sub-title">訓練期間</td>
								<td>
									<div class="input-group method-group">
										<!-- 開始訓練日期 -->
										<div class="input-item">
											<span class="input-group-addon">起始訓練日期</span>
											<input type='text' id="datePicker" class="form-control" placeholder="請選擇日期" / >
										</div>
										<div class="input-item">
											<span class="input-group-addon">持續週數</span>
											<select class="training-period-input form-control" aria-describedby="basic-addon1">
				                                <option value="">請選擇</option>
				                                <option value="1">一週</option>
				                                <option value="2">兩週</option>
				                                <option value="3">三週</option>
				                                <option value="4">一個月</option>
				                            </select>
										</div>
										<div class="input-item">
											<span class="input-group-addon">訓練日選擇</span>
											<div class="training-days">
											    <div class="weekday-circle" data-day="1">一</div>
											    <div class="weekday-circle" data-day="2">二</div>
											    <div class="weekday-circle" data-day="3">三</div>
											    <div class="weekday-circle" data-day="4">四</div>
											    <div class="weekday-circle" data-day="5">五</div>
											    <div class="weekday-circle" data-day="6">六</div>
											    <div class="weekday-circle" data-day="0">日</div>
										  	</div>
										  	<input type='hidden' class="planForm form-control" data-item="" >
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td class="sub-title">使用方法</td>
								<td>
									<div class="input-group method-group">
										<div class="input-item">
											<span class="input-group-addon">每週</span>
											<select class="planForm form-control" id="frequencyPerWeek" aria-describedby="basic-addon1" data-item="202" name="weekly">
												<option value="0" >0</option>
												<option value="1" >1</option>
												<option value="2" >2</option>
												<option value="3" >3</option>
											</select>
											<span class="input-group-addon">次</span>
										</div>
										<div class="input-item">
											<span class="input-group-addon">每天</span>
											<select class="planForm form-control" id="frequencyPerDay" aria-describedby="basic-addon1" data-item="203" name="daily">
												<option value="0" >0</option>
												<option value="1" >1</option>
												<option value="2" >2</option>
												<option value="3" >3</option>
											</select>
											<span class="input-group-addon">次</span>
										</div>
										<div class="input-item">
											<span class="input-group-addon">每次</span>
											<select class="planForm form-control" id="durationPerSessionHour" aria-describedby="basic-addon1" data-item="204-1">
												<option value="0" >0</option>
												<option value="1" >1</option>
												<option value="2" >2</option>
												<option value="3" >3</option>
											</select>
											<span class="input-group-addon btn" onclick="">小時</span>
											<select class="planForm form-control" id="durationPerSessionMin" aria-describedby="basic-addon1" data-item="204-2">
												<option value="0" >0</option>
												<option value="15" >15</option>
												<option value="30" >30</option>
												<option value="45" >45</option>
											</select>
											<span class="input-group-addon">分鐘</span>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td class="sub-title">追蹤指標</td>
								<td>
									<div class="no-data-message">此教案無指標可追蹤</div>								   
									<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table target-table">
										<thead>
									      <tr class="tablesorter-headerRow">
									      	<th width="25%">指標類型</th>
									      	<th width="50%">達成目標</th>
									        <th width="25%"><@spring.message "hcrecord.detail.column.funcItem"/></th>
									      </tr>					      
									    </thead>
										<tbody id="list_cnt">
											<tr class="clone-row">
										      	<td>
										      		<select class="itemForm form-control indicator-select" id="indicatorSelect">
										      			<option value="">請選擇</option>
										      			<option value="ach">成就</option>
														<option value="stats">統計</option>
										      		</select>
										      	</td>
										      	<td>
										      		<div class="target-content">
													</div>
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
								<td class="sub-title">其他備註</td>
								<td>
									<textarea rows="3" class="basicForm form-control" id="planNote" placeholder="請填寫教案使用注意事項"></textarea>
								</td>
							</tr>					
							<tr>
								<td colspan="2">
									<div class="footer-btn-list">								
										<button class="func-btn func-btn-prev"><i class="fa fa-circle-arrow-left"></i> 上一步</button>
										<button class="func-btn func-btn-next validate-next"><i class="fa fa-circle-arrow-right"></i> 下一步</button>										
									</div>	
								</td>
							</tr>									
						</table>
				    </fieldset>
				    <fieldset class="form-step">
				    	<div class="appointment-blks">
				    		<div class="col-4">
				    			<table class="default-table">
				    				<tr>
										<td>
				    						<div class="question-grp">
					    						<span>治療師選擇：</span>
					    						<select class="form-control therapist-options">
					    							<option value="">請選擇治療師</option>
					    							<#if doctorList?? && (doctorList?size>0)>
					    							<#list doctorList as doctor>
					    							<option <#if doctor.id == currentUser.id>selected</#if>" value="${doctor.id}">${doctor.name}</option>
					    							</#list>
					    							</#if>
					    						</select>
											</div>
			    						</td>
				    				</tr>
				    				<tr>
				    					<td>
											<div class="question-grp">
												<span>預約日期：</span>
												<input type="text" class="form-control therapist-reserve-time" data-cat="date" placeholder="請點選右側可預約時段" disabled />
											</div>
											<div class="question-grp">
												<span>預約時間：</span>
												<input type="text" class="form-control therapist-reserve-time" data-cat="time" placeholder="請點選右側可預約時段" disabled />
											</div>
			    						</td>			  					
				    				</tr>
			    					<tr>
										<td>
											<div class="footer-btn-list">								
												<button class="func-btn func-btn-prev"><i class="fa fa-circle-arrow-left"></i> 上一步</button>
												<button id="completeConsultation" class="func-btn func-btn-next appo-arrange" ><i class="fa fa-circle-arrow-right"></i> 完成送出</button>										
											</div>	
										</td>
									</tr>
				    			</table>
				    		</div>
				    		<div class="col-8">
				    			<div id="wg-Container" style="width:100%;"></div>
				    		</div>
				    	</div>
				    </fieldset>
				</form>
			</div>
		</div>	
	</div>		
</body>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
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

<script>
/*定義全域變數*/
var planKeyNo = '';
var lessonEvalFormUserKeyNo = '';
var current_fs, next_fs, prev_fs;
var selectedDates = [];
var cUserId = ${currentUser.id!""};
var gCurPage = 1;
var limit = 100;
var api = "/Scale/api/qryScalesList";
var lessonStoreUrl = '${lessonStoreUrl!""}';
var globalAchDTO = [];
var globalStatsDTO = [];
var selectedAch = []; // 用於追蹤已選擇的成就
var selectedStats = []; // 用於追蹤已選擇的統計
var lessonCurrentPage = 1;
var lessonPageSize = 9;
var lessonTotalPage;
var lessonTotalCount;
var isLibrary = false;
var tagList = [];
var tagShow = true;
var patientInfo = ${patientInfo!""};
console.log('patientInfo:', patientInfo);

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

	// 初始化患者基本資料
	fillPatientInfo();

	$(".icd-code").each(function(idx){
		$(this).select2({
	        language: '${__lang}',
	        width: '100%',
	        maximumInputLength: 10,
	        minimumInputLength: 2,
	        placeholder: '<@spring.message "hcrecord.detail.option.enterCode"/>',
	        allowClear: true,
	        ajax: {
	            url: '/WgIcdCode/api/list',
	            type: 'POST',
	            data: function (params){
	                return {
	                    code: params.term 
	                };
	            },
	            processResults: function (data, params){
					console.log('data', data);
	 				var obj = JSON.parse(data);
	
	                return {
	                    results: obj.data,
	                    pagination: {
	                        more: false
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
		$(".main-content")[0].scrollTo(0,0);

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
		$(".main-content")[0].scrollTo(0,0);
		var $this = $(this);
        
        if($this.hasClass("validate-next")){
            e.preventDefault(); // 阻止預設行為
            var isValid = validateTrainingPlan();
            if(isValid){

                var current_fs = $this.closest("fieldset");
                var next_fs = current_fs.next();

                $(".progressBar li").eq($("fieldset").index(current_fs)).removeClass("active").addClass("done");
                $(".progressBar li").eq($("fieldset").index(next_fs)).addClass("active");

                current_fs.hide();
                next_fs.show();
            }
            // 如果驗證失敗，不進行任何操作

		} else {
		    e.preventDefault();
		
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
	    }
	});
	
	// 點擊進度條跳轉功能
	$(".progressBar li").click(function (e) {
	    e.preventDefault();
		$(".main-content")[0].scrollTo(0,0);
	
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
	        swal("提醒通知", "為確保資料正確，請依步驟順序進行，尚未填寫的步驟無法點選。", "warning");
	    }
	});

	
	initEditable(".editable-option");
	//顯示個案評估結果列表
 	triggerPatientEvalList();
	//初始化就診基本資料
	wg.template.updateNewPageContent('data-container', 'data-content', {}, '/ftl/imas/admin/dataForm?viewer=pt')
	//初始化就診紀錄
	wg.template.updateNewPageContent('report-container', 'report-content', {}, '/ftl/imas/diagnosisReport/msg/chooseMessage');
	//初始化治療師預約畫面
	wg.template.updateNewPageContent('wg-Container', 'therapist-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment?clinician=therapist&doctorId=${currentUser.id!""}');
	//初始化訓練歷程結果
	// temp
	//wg.template.updateNewPageContent('caseResult-container', 'caseResult', {"formId": ${formId!""}}, '${base}/${__lang}/division/web/${formId!""}/trainingResult');

	listLesson(1);
	
	$('#datePicker').datepicker({
    	language: 'zh-TW',
    	format: 'yyyy/mm/dd',
    	todayHighlight: true,
    	autoclose: true,
    	clearBtn: true,
    	todayBtn: 'linked',
    	// 其他自定義選項
    }).datepicker('setDate', new Date());
    
    // 教案選擇上下頁
    $('#prevPage').click(function(e){
	    e.preventDefault(); 
	    if(lessonCurrentPage > 1){
	        listLesson(lessonCurrentPage - 1);
	    }
	});
	
	$('#nextPage').click(function(e){
	    e.preventDefault(); 
	    if(lessonCurrentPage < lessonTotalPage){
	        listLesson(lessonCurrentPage + 1);
	    }
	});
    
    // 追蹤目標表格隱藏
    $('.target-table').hide();
});


/*確認個案報到觸發行為*/
$(".confirm-check").click(function(e){
	e.preventDefault();
	editPatientBaseInfo();
	var postData = {"slotId": ${slotId}, "cat": 1, "caseno": "${formId!""}"};
	console.log('postData', postData);
	const jsonData = JSON.stringify(postData);
	var result = wg.evalForm.getJson(jsonData, "/WgTask/api/checkin");
	if(!result.success){
		swal('報到失敗', "無法執行報到作業!", "error");
	}
});

/* 新增量表 */
$(".add-ast").click(function(e) {
	e.preventDefault();

	showScalesList();
	$("#myModal").modal('show');
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
    	$("#myModal").modal('hide');
    }
});

/*治療師點選變色*/
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

//治療師切換可預約時間表
$("body").on("change", ".therapist-options", function() {
	var doctorId = $(this).val();
	if(doctorId != ""){
		wg.template.updateNewPageContent('wg-Container', 'therapist-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment?clinician=therapist&doctorId=' + doctorId);
	}else{
		wg.template.updateNewPageContent('wg-Container', 'therapist-booking-content', {}, '/ftl/imas/admin/taskMgnt/appointment/msg/chooseMessage');
	}
});

//診斷報告檢視點擊
$(".diagnosis-records tr").click(function(e){
	e.preventDefault();
	
	var $tr = $(this);
	var keyno = $tr.attr("data-record");
	
	if ($tr.hasClass("selected")) {
		$tr.removeClass("selected");
		wg.template.updateNewPageContent('report-container', 'report-content', {}, '/ftl/imas/diagnosisReport/msg/emptyMessage');
	}else{
		$tr.parent().find("tr").removeClass("selected");
		$tr.toggleClass("selected");

		wg.template.updateNewPageContent('report-container', 'report-content', {}, '/ftl/imas/diagnosisReport?id=' + keyno);
		$('.report-blk').fadeIn(500); // 0.5秒淡入
	}

});

//使用教案點擊
function clickLesson(){
	$(".lesson-card").click(function(e){
		e.preventDefault();
		$(this).parent().find(".lesson-card").removeClass("selected");
		$(this).toggleClass("selected");
		var selectedName = $(this).find(".card-title").text();
		$('.lesson').val(selectedName);
        
		
		// 重設所有 .indicator-select 的值並觸發 change 事件
        $('.indicator-select').val('').trigger('change'); // 將 select 恢復到預設值
        // 清空所有 .target-content 的內容
        $('.target-content').empty(); 
        
        $('tr .clone').remove();
		
		var lessonKeyNo = $(this).data('lesson');
		
		const apiUrls = [
	        lessonStoreUrl + `/LessonAchievement/api/lesson`,
	        lessonStoreUrl + `/LessonStatistics/api/lesson`
	    ];
		console.log('apiUrls', apiUrls);
		console.log('lessonId', lessonKeyNo);
	    // 創建一個包含所有 fetch POST 請求的 Promise 陣列
	    const requests = apiUrls.map(url => 
	        $.ajax({
	            url: url,
	            type: 'POST',
	            dataType: 'json', // 設置返回的數據類型為 JSON
	            data: JSON.stringify({"lessonId": lessonKeyNo}),
	            error: function(xhr, status, error) {
	                console.error('Error:', error);
	            }
	        })
	    );
	    
	    Promise.all(requests)
	        .then(responses => {
	        	const [lessonAchievement, lessonStatistic] = responses;
	        	selectTarget(lessonAchievement, lessonStatistic);
	        });
	});
}

// 切換教案類型(個人收藏、系統推薦)
$(".switch-btn").click(function(e) {
    e.preventDefault();

    // 檢查當前按鈕是否已經是 selected
    if ($(this).hasClass("selected")) {
        // 如果已經是 selected，則移除 selected 類別
        $(this).removeClass("selected");
        getDataToPost();
    } else {
        // 否則，移除所有按鈕的 'selected' 類別，並為點擊的按鈕添加 'selected' 類別
        $(".switch-btn").removeClass("selected");
        $(this).addClass("selected");

        // 調用 AJAX 請求以更新教案資料
        getDataToPost();
    }
});

$(".weekday-circle").click(function(){
	$(this).toggleClass("active");
});

//滑鼠滾輪可左右滾動並選擇使用教案
var scrollContainer = document.querySelector('.lesson-list');

scrollContainer.addEventListener('wheel', (e) => {
    e.preventDefault();
    scrollContainer.scrollLeft += e.deltaY;
});

$('#addRow').on( 'click', function (e) {
	e.preventDefault();
	
	var currentRow = $(this).closest("tr");
	var selectCode = currentRow.find("select:eq(0)").val();
	var selectObj = currentRow.find("select");
	var inputEmptyLeng = currentRow.find("input").filter(function () {
	    return $.trim($(this).val()).length == 0
	}).length;

	if(inputEmptyLeng == 0 && selectObj.find("option").length != 0 && selectObj.val() != ""){
		var newcnt = currentRow.clone();
		
		var selectValues = [];
        selectObj.each(function () {
            selectValues.push($(this).val());
        });
		
		$(newcnt).addClass("clone");
		$(newcnt).find('.selected-option').addClass('added');
		$(newcnt).find("input, select").each(function(){
			$(this).attr("disabled", "disabled");
		});
		$(newcnt).find("td:last-child").html("").append("<button class='delete-row func-btn'><i class='fa fa-trash-can'></i> 刪除</button>");
		
		$(newcnt).find("select").each(function (index) {
            $(this).val(selectValues[index]);
        });
		
		$(this).closest("tr").before(newcnt);
		
		currentRow.find("select").val("").trigger('change');
		currentRow.find('.target-content').empty();
		currentRow.find("input[type='text']").val("");
		
		$(".delete-row").click(function(){
			e.preventDefault();
			$(this).closest("tr").remove();
		});

	}else{
		swal("新增失敗", "內容輸入不完整，無法新增資料!", "error");
	}
});

$(".delete-row").on('click', function(e){
	e.preventDefault();
	$(this).closest("tr").remove();
});

$("#cleanRow").on('click', function(e){
	e.preventDefault();
	
	var target = $(this).closest("tr");
	target.find("input[type='text']").val("");
	target.find("select").val("").trigger('change');
	//target.find('.paymentItemCode').find("option").remove();
	target.find('.target-content').empty();
});

function triggerPatientEvalList(){
	let postData = {"therapistId": cUserId, "patientId": "${formId!""}"};
	//var postData = {"patientId": "${formId!""}"};
    console.log('postData', postData);
	let result = wg.evalForm.getJson(JSON.stringify(postData), "/Assessment/api/getCaseAssessmentList");
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
		}
 		
 		wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {}, '/ftl/imas/admin/taskMgnt/evaluation/message?msg=emptyMessage');
	}else{
		wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {}, '/ftl/imas/admin/taskMgnt/evaluation/message?msg=addMessage');
	}
}

$("body").on("click", ".list-group-item, .do-fill", function(e) {
	e.preventDefault();
	
	if ($(e.target).is(".do-fill")) {
        e.stopPropagation(); // 阻止事件冒泡到 .list-group-item
    }
    
	var $item = $(this).hasClass("list-group-item") ? $(this) : $(this).closest(".list-group-item");
	var formId = $item.data("id");
	var mode = $item.data("mode");
	
	$(this).parent().find(".list-group-item").removeClass("selected");
	$(this).toggleClass("selected");

	wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {"isFromPatient": false}, '/ftl/imas/admin/taskMgnt/evaluation?formId=' + formId + '&mode=' + mode + '&patientId=' + ${formId!""});
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

// 建立教案卡片
function createCard(dtoList){
	var $lessonList = $('.lesson-list');
	$lessonList.empty();
	
	dtoList.forEach(function(dtoString){
		var dto = dtoString;
		var keyno = dto.lesson.id;
		var ansList = dto['evalItemAnses'];
		var cardHtml = `
			<div class="lesson-card" data-lesson="` + keyno +`">
				<img src="`+ lessonStoreUrl + `/File/api/file/path` + dto.lesson.headerImageUrl +`" class="card-img-top" alt="` + dto.lesson.lessonName + `">
				<div class="card-overlay">
					<button class="overlay-button">使用此教案</button>
					<i class="fa fa-circle-check"></i>
				</div>
				<div class="card-title">` + dto.lesson.lessonName + `</div>
				<div class="card-intro">` + dto.lesson.lessonBrief + `</div>
			</div>
		`;
		$('.lesson-list').append(cardHtml);
	});
	clickLesson();
}

/* 初始化教案列表 */
function listLesson(page = 1){
    lessonCurrentPage = page;
    getDataToPost();
}

function getDataToPost(){
	tagList = [];
    // 選取具有 'selected' 類別的按鈕
    let selectedCategory = $('.switch-toolbar .switch-btn.selected').data('cat');
	
	//temp
	/*
	if(selectedCategory == 'recommend'){
		let evalId = $('.evaluation-list').find('tr:first').data('id');
		let postData = {"assessmentId": evalId};
		$.ajax({
			url: '/Assessment/api/getCaseAssessment',
			type: 'POST',
		    dataType: 'json',
		    async: false,
		    data: {"data": JSON.stringify(postData)},
		    success: function(result){
		    	console.log(result);
		    	if(result.success){
		    		if(result.scale == 4){
		    			console.log('result.scale', result.scale);
		    			tagList.push("1");
		    		} else if (result.scale == 5){
		    			tagList.push("2");
		    		}
		    	}
		    }
		});
	} else if (selectedCategory == 'library'){
		
	}*/
	
	
    // 根據選取的按鈕設置 isLibrary
    /*let isLibrary = false;
    if(selectedButton.length > 0){
        // 方法一：根據按鈕的文字內容判斷
        if(selectedButton.text().trim() === '我的收藏'){
            isLibrary = true;
        } else {
            isLibrary = false;
        }
    }*/

    // 準備頁面資料
    let pageData = {
        "currentPage": lessonCurrentPage, 
        "pageSize": lessonPageSize
    };
    
    // 準備篩選資料
    let dataItem = {"tagList": tagList}
    // 發送 AJAX 請求
    postFilterApi(
        {
            "pageData": pageData,
            "isLibrary": isLibrary,
            "tagShow": tagShow,
            "dataItem": dataItem
        }, 
        function(response) {
            renderLessons(response);
        }
    );
}

/* 渲染教案卡片 */
function renderLessons(data){
    if(data.lessons) createCard(data.lessons);
    // 更新 totalPage 和 totalCount
    lessonTotalCount = data.totalCount;
    lessonTotalPage = Math.ceil(lessonTotalCount / lessonPageSize);
    $('#totalPage').text(lessonTotalPage);
    
    // 更新分頁按鈕狀態
    $('#currentPage').text(lessonCurrentPage);
    $('#prevPage').prop('disabled', lessonCurrentPage === 1);
    $('#nextPage').prop('disabled', lessonCurrentPage === lessonTotalPage);
}

function postFilterApi(data, callback){
    $.ajax({
        url: lessonStoreUrl + '/LessonMainInfo/api/filterlist', // 根據實際 API 端點調整
        type: 'POST',
        data: JSON.stringify(data),
        dataType: 'json',
        success: function(response){

            callback(response);
        },
        error: function(xhr, status, error){
            console.error('Error:', error);
            swal("載入失敗", "無法取得教案資料!", "error");
        }
    });
}

/* Id to KeyNo*/
function formatKey(key) {
	return key.toString().padStart(10, '0');
}

/* 制定訓練計畫function */
function selectTarget(lessonAch, lessonStats) {
	console.log('lessonAch: ', lessonAch);
	console.log('lessonStats: ', lessonStats);

    globalAchDTO = lessonAch;
    globalStatsDTO = lessonStats;

    $('.indicator-select').off('change').each(function () {
        var $select = $(this);
        var hasAchievements = globalAchDTO.length > 0;
        var hasStatistics = globalStatsDTO.length > 0;
		
		$('.no-data-message').hide();
		
        if (!hasAchievements && !hasStatistics){
        	$('.target-table').hide();
        	$('.no-data-message').show();
        	return;
        }
        $('.target-table').show()
        // 清除現有選項
        $select.empty();

        // 添加預設選項
        $select.append('<option value="">請選擇</option>');

        // 根據是否有成就和統計動態添加選項
        if (hasAchievements) {
            $select.append('<option value="ach">成就</option>');
        }
        if (hasStatistics) {
            $select.append('<option value="stats">統計</option>');
        }
        

        // 為 select 元素設置 change 事件
        $select.on('change', function () {
            var selectedValue = $(this).val();
            var $targetContent = $(this).closest('tr').find('.target-content');

            // 根據選擇的值更新內容
            if (selectedValue === '') {
                $targetContent.html('');
            } else if (selectedValue === 'ach') {

                var achOptions = '';
                $.each(globalAchDTO, function (index, achData) {
                    let achApiName = achData.apiName;
                    let achIcon = lessonStoreUrl + '/File/api/file/path' + achData.unlockedIconUrl;
                    let achName = achData.displayName;
                    let achDesc = achData.description;
                    

                    achOptions += `
                        <div class="dropdown-option" data-ach="` + achApiName + `">
                            <div class="achOptionItem">
                                <div class="col-2">
                                    <div class="achOptionImg">
                                        <img src="` + achIcon + `" alt="` + achName + `">
                                    </div>
                                </div>
                                <div class="col-10">
                                    <div class="achOptionAns">
                                        <div class="achOptionTitle">` + achName + `</div>
                                        <div class="achOptionDescript">` + achDesc + `</div>
                                    </div>
                                </div>
                            </div>
                        </div>`;
                });

                $targetContent.html(`
                        <div class="custom-dropdown">
                            <div class="selected-option">請選擇成就</div>
                            <div class="dropdown-options" style="display: none;">
                                ` + achOptions + `
                            </div>
                        </div>
                    `);

                // 實現下拉選單功能
                $targetContent.find('.selected-option').off('click').on('click', function () {
                    $(this).next('.dropdown-options').toggle();
                });

                $targetContent.find('.dropdown-option').off('click').on('click', function () {
                    var selectedAchApiName = $(this).data('ach');
                    var selectedAchName = $(this).find('.achOptionTitle').text();
                    var achDesc = $(this).find('.achOptionDescript').text();
                    var achIcon = $(this).find('.achOptionImg img').attr('src');

                    selectedAch.push(selectedAchName);

                    var selectedHtml = `
                            <img src="` + achIcon + `" alt="` + selectedAchName + `" class="selected-ach-icon" />
                            <span class="selected-ach-text" data-selectedAch="` + selectedAchApiName + `">` + selectedAchName + ` | ` + achDesc + `</span>
                        `;

                    $(this).closest('.custom-dropdown').find('.selected-option').html(selectedHtml);
                    $(this).closest('.dropdown-options').hide();
                });

            } else if (selectedValue === 'stats') {

                var optionText = '';
                $.each(globalStatsDTO, function (index, statsData) {
                    
                    const statName = statsData.apiName;
					const statDisplayName = statsData.displayName;
                    optionText += '<option value="' + statName + '">' + statName + ' | ' + statDisplayName + '</option>';
                });
                $targetContent.html(`
                        <select class="form-control stats-select">
                            <option value="">請選擇統計項目</option>
                            ` + optionText + `
                        </select>
                        <input type="text" class="itemForm form-control stats-value" placeholder="請輸入統計值" />
                    `);
            }
        });
    });
}

    function uploadTrainingPlan(){
        return new Promise(function(resolve, reject){
            // 準備資料
            var itemNumArr = getItemNumArray("trainingPlan-table", "basicForm");
            var itemArray = getItemValue("basicForm", itemNumArr);
            var hr;
            var min;
            itemArray = itemArray.filter((element) => {
                if (element.itemId == '204-1') {
                    hr = element.ans;
                    return false; // 移除符合條件的元素
                }
                
                if (element.itemId == '204-2') {
                    min = element.ans;
                    return false; // 移除符合條件的元素
                }
                
                return true; // 保留不符合條件的元素
            });

            var newAns = (parseInt(hr)*60 + parseInt(min)).toString();
            var newItem = {'itemId': '204', 'ans': newAns, 'op': 'e'}
            itemArray.push(newItem);
            
	        let lessons = [];
	        $(".lesson-card.selected").each(function() {
	            let lessonKeyNo = $(this).data('lesson');
	
	            // 收集成就資料
	            let achievementApis = [];
	            $(this).find(".clone").each(function() {
	                let achievement = $(this).find('.selected-ach-text').data('selectedach');
	                if (achievement) {
	                    achievementApis.push(achievement);
	                }
	            });
	
	            // 收集統計資料
	            let statisticsGoals = [];
	            $(this).find(".clone").each(function() {
	                let statistic = $(this).find('.stats-select').val();
	                let statisticValue = $(this).find('.stats-value').val();
	                if (statistic && statisticValue) {
	                    statisticsGoals.push({
	                        "apiName": statistic,
	                        "valueGoal": statisticValue
	                    });
	                }
	            });
	
	            // 組裝單個 lesson 結構
	            lessons.push({
	                "lessonKeyNo": lessonKeyNo,
	                "achievementApis": achievementApis,
	                "statisticsGoals": statisticsGoals
	            });
	        });
	        
            var trainingWeeks = $('.training-period-input').val();
            
            // 時間：
            var startDate = $('#datePicker').val();
            
            var endDate;

            // 根據訓練週數計算結束日期
            switch(trainingWeeks) {
                case '1': // 一週
                    endDate = new Date(startDate);
                    endDate.setDate(endDate.getDate() + 7);
                    break;
                case '2': // 兩週
                    endDate = new Date(startDate);
                    endDate.setDate(endDate.getDate() + 14);
                    break;
                case '3': // 三週
                    endDate = new Date(startDate);
                    endDate.setDate(endDate.getDate() + 21);
                    break;
                case '4': // 一個月
                    endDate = new Date(startDate);
                    endDate.setMonth(endDate.getMonth() + 1);
                    break;
                default:
                    endDate = null;
            }
            
            if (endDate) {
                var year = endDate.getFullYear();
                var month = String(endDate.getMonth() + 1).padStart(2, '0');
                var day = String(endDate.getDate()).padStart(2, '0');
                var formattedEndDate = year + '/' + month + '/' + day ;
            }
            
            var postData = {
                "startDate": startDate, 
                "endDate": formattedEndDate, 
                "userFormKeyNo": "${formId!""}",
                "items": itemArray, 
                "planKeyNo": planKeyNo,
                "lessonKeyNo": lessonKeyNo, 
                "creator": cUserId, 
                "ach": achList, 
                "stats": statsList, 
                "lessonEvalFormUserKeyNo": lessonEvalFormUserKeyNo
            };
            console.log('saveTrainingData： ', postData); 
            // 發送 AJAX 請求
            $.ajax({
	            url: '${base}/division/api/TrainingPlan/save',
	            type: 'POST',
	            data: {"data":JSON.stringify(postData)},
	            dataType: 'json',
	            success: function(result){
	                if(result.success){
	                    // 更新 planKeyNo 和 lessonEvalFormUserKeyNo
	                    if(result.planKeyNo){
	                        planKeyNo = result.planKeyNo;
	                        lessonEvalFormUserKeyNo = result.lessonEvalFormUserKeyNo;
	                    }
	                    resolve(true); // 表示成功
	                } else {
	                    swal("<@spring.message 'view.save.fail.title'/>", "<@spring.message 'view.save.fail.text'/>", "error");
	                    resolve(false); // 表示失敗
	                }
	            },
	            error: function(xhr, status, error){
	                console.error('AJAX error:', status, error);
	                swal("錯誤", "無法提交表單，請稍後再試。", "error");
	                resolve(false); // 表示失敗
	            }
	        });
        });
    }
    
	  /* 測試上傳訓練資料 */
    function uploadTrainingPlanV2(){
        return new Promise(function(resolve, reject){
            // 準備資料
            let subjective = $('.subjective').val();
			let objective = $('.objective').val();

            let hr = $('#durationPerSessionHour').val();
            let min = $('#durationPerSessionMin').val();
            let frequencyPerWeek = $('#frequencyPerWeek').val();
            let frequencyPerDay = $('#frequencyPerDay').val();
            
            
			console.log('選取時間: '+ hr +' 小時, ' + min +' 分鐘');
            
            let duration = parseInt(hr)*60 + parseInt(min);
            
            let achList = [];
            let statsList = [];
            $(".clone").each(function(){
                var achievement = $(this).find('.selected-ach-text').data('selectedach');
                if(achievement){
                    achList.push(achievement);
                }
                var statistic = $(this).find('.stats-select').val();
                var statisticValue = $(this).find('.stats-value').val();
                if(statistic && statisticValue){
                    var statsData = {"apiName": statistic, "statsValue": statisticValue}
                    statsList.push(statsData);
                }
            });
            
            let lessons = [];
	        $(".lesson-card.selected").each(function() {
	            let lessonKeyNo = $(this).data('lesson');
	
				let achievementApis = [];
				$('#list_cnt').find(".clone").each(function() {
				    let achievementElement = $(this).find('.selected-ach-text');
				    if (achievementElement.length > 0) {
				        let achievement = achievementElement.data('selectedach');
				        if (achievement) {
				            achievementApis.push(achievement);
				        } else {
				            console.warn("成就資料缺少: ", achievementElement);
				        }
				    } else {
				        console.warn("找不到 .selected-ach-text 元素");
				    }
				});
				
				let statisticsGoals = [];
				$('#list_cnt').find(".clone").each(function() {
				    let statistic = $(this).find('.stats-select').val();
				    let statisticValue = $(this).find('.stats-value').val();
				    if (statistic && statisticValue) {
				        statisticsGoals.push({
				            "apiName": statistic,
				            "valueGoal": statisticValue
				        });
				    } else if (statistic || statisticValue) {
				        console.warn("統計資料不完整: statistic=", statistic, ", valueGoal=", statisticValue);
				    }
				});
				
				console.log('statisticsGoals: ', statisticsGoals);
				console.log('achievementApis: ', achievementApis);
	
	            // 組裝單個 lesson 結構
	            lessons.push({
	                "lessonKeyNo": lessonKeyNo,
	                "achievementApis": achievementApis,
	                "statisticsGoals": statisticsGoals
	            });
	        });
	        
            let trainingWeeks = $('.training-period-input').val();
            let planNote = $('#planNote').val();
            // 時間：
            let startDate = $('#datePicker').val();
            startDate = startDate.replaceAll("/", "-");
            let startDateTime = startDate + ' 00:00:00';
            
            let endDate;
            // 根據訓練週數計算結束日期
            switch(trainingWeeks) {
                case '1': // 一週
                    endDate = new Date(startDate);
                    endDate.setDate(endDate.getDate() + 7);
                    break;
                case '2': // 兩週
                    endDate = new Date(startDate);
                    endDate.setDate(endDate.getDate() + 14);
                    break;
                case '3': // 三週
                    endDate = new Date(startDate);
                    endDate.setDate(endDate.getDate() + 21);
                    break;
                case '4': // 一個月
                    endDate = new Date(startDate);
                    endDate.setMonth(endDate.getMonth() + 1);
                    break;
                default:
                    endDate = null;
            }
            let formattedEndDate = '';
			if (endDate) {
			    let year = endDate.getFullYear();
			    let month = String(endDate.getMonth() + 1).padStart(2, '0');
			    let day = String(endDate.getDate()).padStart(2, '0');
			    let hours = String(endDate.getHours()).padStart(2, '0');
			    let minutes = String(endDate.getMinutes()).padStart(2, '0');
			    let seconds = String(endDate.getSeconds()).padStart(2, '0');
			    formattedEndDate = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
			}
            
            let trainingData = {
            	"therapist": cUserId,
            	"patientId": '${formId!""}',
            	"title": 'title',
				"subjective": subjective,
				"objective": objective,
            	"startDate": startDateTime,
            	"endDate": formattedEndDate,
            	"frequencyPerWeek": frequencyPerWeek,
            	"frequencyPerDay": frequencyPerDay,
            	"durationPerSession": duration,
            	"notes": planNote
            };
            
            console.log('saveTrainingData： ', trainingData); 
            // 發送 AJAX 請求
            $.ajax({
	            url: '/Training/api/savePlan',
	            type: 'POST',
	            data: JSON.stringify({'trainingData': trainingData, "lessons": lessons}),
	            dataType: 'json',
	            success: function(result){
	                console.log('AJAX response:', result);
	                if(result.success){
	                    // 更新 planKeyNo 和 lessonEvalFormUserKeyNo
	                    if(result.planKeyNo){
	                        planKeyNo = result.planKeyNo;
	                        lessonEvalFormUserKeyNo = result.lessonEvalFormUserKeyNo;
	                    }
	                    resolve(true); // 表示成功
	                } else {
	                    swal("<@spring.message 'view.save.fail.title'/>", "<@spring.message 'view.save.fail.text'/>", "error");
	                    resolve(false); // 表示失敗
	                }
	            },
	            error: function(xhr, status, error){
	                console.error('AJAX error:', status, error);
	                swal("錯誤", "無法提交表單，請稍後再試。", "error");
	                resolve(false); // 表示失敗
	            }
	        });
        });
    }

// 安排下次看診時間
$("#completeConsultation").click(function(e){
	e.preventDefault();

	//uploadTrainingPlanV2();
	//editPatientBaseInfo();
	
	var doctorId = $(".therapist-options option.selected").val();
	var slotId = $(".myc-available-time.selected").attr("data-unique");
	
	if(doctorId == undefined || slotId == undefined){
		swal("送出失敗", "請再次確認是否有安排下次看診時間!", "error");
	}else{
		var postData = {"creator": doctorId, "availableSlotId": slotId, "cat": 2, "caseNo": "${formId!""}"};
		var result = wg.evalForm.getJson(JSON.stringify(postData), "/WgTask/api/createNewAppo");
		
		if(result.success){
			successToDirect("作業完成", "完成個案評估與訓練計畫制定作業，系統自動導向首頁總覽中", "success", 1500, "/ftl/imas/dashboard");
		}else{
			if(result.msg == undefined) result.msg = "無法預約看診時間!";
			swal("預約失敗", result.msg, "error");
		}
	}
});

// 驗證訓練計劃填寫是否完整
function validateTrainingPlan() {
    // 檢查 subjective 和 objective 是否有填寫
    var subjective = $('.subjective').val().trim();
    var objective = $('.objective').val().trim();
    
    if (subjective === "") {
        swal("送出失敗", "請填寫主觀描述（Subjective）。", "warning");
        return false;
    }
    
    if (objective === "") {
        swal("送出失敗", "請填寫客觀描述（Objective）。", "warning");
        return false;
    }
    
    // 檢查每週或每天的選擇
    // 假設有兩個下拉選單分別代表每週和每天
    // 如果沒有，請根據實際情況調整選擇器
    var weekly = $('select[name="weekly"]').val(); // 請根據實際 name 或 id 調整
    var daily = $('select[name="daily"]').val();   // 請根據實際 name 或 id 調整
    
    if ((weekly && daily) && (weekly !== "0" && daily !== "0")) {
        swal("送出失敗", "每週和每天只能選擇其中一項。", "warning");
        return false;
    }
    
    if ((!weekly || weekly === "0") && (!daily || daily === "0")) {
        swal("送出失敗", "請選擇每週或每天其中一項。", "warning");
        return false;
    }
    
    // 檢查每次的時間輸入
    var hours = $('#durationPerSessionHour').val(); // 每次的小時數
    var minutes = $('#durationPerSessionMinute').val(); // 每次的分鐘數
    
    if ((hours === "0" || hours === "") && (minutes === "0" || minutes === "")) {
        swal("送出失敗", "當小時數為 0 或未填寫時，分鐘數必須填寫。", "warning");
        return false;
    }
    
    // 檢查其他必要欄位
    var lesson = $('.form-control.lesson').val().trim();
    var datePicker = $('#datePicker').val().trim();
    var trainingPeriod = $('.training-period-input').val();
    var remarks = $('#planNote').val().trim();
    
    if (lesson === "") {
        swal("送出失敗", "請選擇個案訓練方案。", "warning");
        return false;
    }
    
    if (datePicker === "") {
        swal("送出失敗", "請選擇開始訓練日期。", "warning");
        return false;
    }
    
    if (trainingPeriod === "") {
        swal("送出失敗", "請選擇訓練週數。", "warning");
        return false;
    }
    
    // 如果所有驗證都通過
    return true;
}

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
	let name = $('#patient-name').val()?.trim();
	if (name) data.name = name;
	
	let idno = $('#patient-idno').val()?.trim();
	if (idno) data.idno = idno;
	
	let gender = $('#patient-gender').val()?.trim();
	if (gender) data.gender = gender;
	
	let charno = $('#patient-charno').val()?.trim();
	if (charno) data.charno = charno;
	
	let phone = $('#patient-phone').val()?.trim();
	if (phone) data.phone = phone;
	
	let email = $('#patient-email').val()?.trim();
	if (email) data.email = email;
	
	let maritalStatus = $('#patient-marital-status').val()?.trim();
	if (maritalStatus) data.maritalStatus = maritalStatus;
	
	// 生日資料
	let year = $('.form-control.year').val();
	let month = $('.form-control.month').val();
	let day = $('.form-control.day').val();
	if (year && month && day) {
		// 轉為西元年並組合日期
		let birthYear = parseInt(year, 10) + 1911;
		let birth = birthYear + `-` + month.padStart(2, '0') + `-` + day.padStart(2, '0');
		data.birth = birth;
	}
	
	// 地址資訊
	let city = $('#twzipcode select[name="county"]').val()?.trim();
	if (city) data.city = city;
	
	let district = $('#twzipcode select[name="district"]').val()?.trim();
	if (district) data.district = district;
	
	let zipcode = $('#twzipcode input[name="zipcode"]').val()?.trim();
	if (zipcode) data.zipcode = zipcode;
	
	let address = $('#patient-address').val()?.trim();
	if (address) data.address = address;
	
	// 緊急聯絡人
	let emergencyContact = $('#patient-emergency-contact').val()?.trim();
	if (emergencyContact) data.emergencyContact = emergencyContact;
	
	let emergencyPhone = $('#patient-emergency-phone').val()?.trim();
	if (emergencyPhone) data.emergencyPhone = emergencyPhone;
	
	let emergencyRelation = $('#patient-emergency-relation').val()?.trim();
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

.therapist-options{
	display: block;
	margin-top: 5px;
}

.report-blks{
	height: 370px;
	max-height: 370px;
}

/* 教案字卡樣式 */
.lesson{
	margin-bottom: 5px;
}

.lesson-list {
	width: 100%;
    overflow-x: auto;
    white-space: nowrap;
}

.lesson-card {
	position: relative;
    width: 200px;
    height: 320px;
    border: 1px solid #ccc;
    background: #f2f2f2;
    border-radius: 4px;
    display: inline-block;
    margin-bottom: 5px;
    overflow: hidden;
    cursor: pointer;
    vertical-align: top;
}

.lesson-card img {
    width: 100%;
    height: 120px;
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
    transition: transform 0.3s ease;
}

.card-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 120px;
    background-color: rgba(0, 0, 0, 0.75); 
    display: none;
    justify-content: center;
    align-items: center;
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
}

.lesson-card:hover .card-overlay,
.lesson-card.selected .card-overlay {
    display: flex; /* Show overlay on hover */    
}

.lesson-card .overlay-button {
    background-color: #fff;
    color: #333;
    border: none;
    padding: 10px 20px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    border-radius: 4px;
}

.lesson-card.selected .overlay-button,
.card-overlay i {
    display: none;
}

.lesson-card.selected .card-overlay i{
	display: block;
	color: #01CA95;
	font-size: 40px;
	background: #fff;
	border-radius: 50%;
}

.lesson-card .card-title {
    font-size: 16px;
    font-weight: bold;
	text-align: left;
	padding: 5px;
}

.lesson-card .card-intro{
	font-size: 14px;
	padding: 0 5px 5px 5px;
	white-space: normal;	
}

.lesson-card .card-intro:not(:first-child){  //暫時先不調整
	/*margin-top: 5px;*/
}

/* 教案分頁功能 */
.lesson-pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 10px 0;
}

.pagination-btn {
    padding: 5px 10px;
    margin: 0 10px;
    cursor: pointer;
    background-color: #2C3E50;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 14px;
}

.pagination-btn:disabled {
    background-color: #cccccc;
    cursor: not-allowed;
}

#currentPage, #totalPage {
    font-weight: bold;
}

/* 教案追蹤指標欄位*/
.achOptionItem {
	display: flex;
	padding: 1rem;
}

.achOptionAns{
	margin-left: 10px;
}

.achOptionTitle {
	font-weight: 900;
}

.achOptionImg {
	text-align: center;
}

.achOptionImg img {
	width: 42px;
	height: 42px;
}


/* 成就設定下拉式選單樣式 */
.custom-dropdown {
    position: relative;
    display: inline-block;
    width: 100%;
}

.selected-option {
    padding: 10px;
    border: 1px solid #ccc;
    cursor: pointer;
    background-color: #fff;
    border-radius: 4px;
}

.selected-option img{
	width: 42px;
	height: 42px;
}

.selected-option.added{
	cursor: not-allowed;
}

.dropdown-options {
    display: none; /* 初始隱藏 */
    position: absolute;
    background-color: #f9f9f9;
    min-width: 200px;
    max-height: 300px;
    overflow-y: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    border: 1px solid #ccc;
    border-top: none;
}

.dropdown-option {
    padding: 12px 16px;
    cursor: pointer;
}

.dropdown-option:hover {
    background-color: #f1f1f1;
}

.custom-dropdown:hover .dropdown-options {
    display: block;
}

.no-data-message {
    padding: 10px;
    color: #ff6666;
    font-weight: bold;
}

.method-group{
	display: flex !important;
	flex-wrap: wrap !important;
	gap: 10px;
}

.input-item{
	display: inline-flex;
	align-items: center;
}

.input-item .input-group-addon{
	display: flex;
	align-items: center;
	height: 34px;
	width: auto !important;
}

.input-item select{
	min-width: 80px !important;
}

.input-item input[type='text']{
	width: 130px !important;
}

.training-days {
	display: inline-flex;
	flex-wrap: wrap;
	gap: 8px;
	height: 34px;
	border: .2px solid #ccc;
	padding: 0px 15px;
	align-items: center;
}

.training-days label {
	display: flex;
	align-items: center;
	gap: 8px;
	font-size: 16px;
	white-space: nowrap;
}

.training-days input[type='checkbox']{
	scale: 1.5;
}

.weekday-circle {
  	width: 25px;
  	height: 25px;
  	border-radius: 50%;
  	background-color: #e0e0e0;
  	color: #333;
  	text-align: center;
  	line-height: 25px;
  	font-weight: bold;
  	cursor: pointer;
  	transition: all 0.2s ease;
  	user-select: none;
}
.weekday-circle.active {
  	background-color: #007bff;
  	color: #ffffff;
}

/* toggle 客製化 css*/
.switch-toolbar {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 5px; 
    width: 100%;
}

.switch-btn {
    text-align: center;
    padding: 0.2em 0.5em;
    line-height: 1.5;
    border-radius: 0.25em;
    color: #000000;
    font-weight: 600;
    background-color: #e6e6e6;
    border-color: #e6e6e6;
    cursor: pointer;
}

.switch-btn.selected {
    color: #ffffff;
    background-color: #2C3E50;
    border-color: #2C3E50;
}

.switch-btn.selected:before{
	font-family: 'FontAwesome';
	content: '\f058';
	margin-right: 5px;
}

.switch-toolbar input[type="text"] {
    flex: 1;
    display: inline;
    padding: 0.2em 0.5em;
    border-radius: 0.25em;
}

/*  待修正 by 政煊*/
.datePicker-group{
	margin-right: 3rem;
	width: 50%;
}

.datePicker-group-prepend{
	font-weight: 600;
	border: #ccc 1px solid;
	background-color: #eee;
	padding: 1rem;
	white-space: nowrap; /* 防止文字換行 */
}

.training-period-group{
	width: 30%;
}

.training-period-group-prepend{
	font-weight: 600;
	border: #ccc 1px solid;
	background-color: #eee;
	padding: 1rem;
	white-space: nowrap; /* 防止文字換行 */
}

</style>

<#include "/imas/widget/widget.ftl" />