<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "casemgnt.label.caseView.title"/></div>
					<span class="patient-hint">${patientName!""}</span>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="home">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.back"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/caseView">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "casemgnt.menu.view"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/inspection">
						<i class="fa fa-stethoscope fa-lg"></i>
						<span><@spring.message "casemgnt.menu.cure.history"/></span>
					</div>
					<div class="module-blk" data-src="">
						<i class="fa fa-chart-simple fa-lg"></i>
						<span><@spring.message "casemgnt.menu.state"/></span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/patient/${formId!""}/hcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.hcRecord"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/ltcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.ltcRecord"/></span>
					</div>
					<div class="module-blk" data-src="">
						<i class="fa fa-file-waveform fa-lg"></i>
						<span><@spring.message "casemgnt.menu.evaluation"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/careCourse">
						<i class="fa fa-clock-rotate-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careCourse"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/carePlan">
						<i class="fa fa-clipboard-list fa-lg"></i>
						<span><@spring.message "casemgnt.menu.carePlan"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/careTeam">
						<i class="fa fa-people-group fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careTeam"/></span>
					</div>
				</div>           
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<table class="default-table">
					<#if isNewForm || copy?has_content >
					<tr>
						<td><@spring.message "hcrecord.detail.label.bringIn"/></td>
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
								<button class="goback func-btn"><i class="fa fa-circle-chevron-left"></i> <@spring.message "hcrecord.detail.button.back"/></button>
							</div>
						</td>
					</tr>
					<#else>
					<tr>
						<td colspan="2" class="sub-title">
							<@spring.message "hcrecord.detail.label.evalDate"/>
							<a href="${base}/${__lang}/division/web/patient/${formId!""}/hcRecord"><i class="fa fa-undo"></i> 返回健保紀錄列表</a>							
						</td>
					</tr>
					<tr>
						<#if mode == "view">
						<td colspan="2">${hcInfo.evalDate!""}</td>
						<#else>
						<td colspan="2">
							<input type="text" class="form-control" value="${hcInfo.evalDate!""}" disabled />
						</td>
						</#if>
					</tr>
					</#if>
					<tr>
						<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.reserve"/></td>				
					</tr>
					<tr>
						<td colspan="2">
							<div class="inline-cotainer">
								<div class="appoint">
									<#if isNewForm || copy?has_content >
									<span><@spring.message "hcrecord.detail.label.reserve.date"/></span>
									<input type="text" class="form-control reserveDate" disabled />
									<span><@spring.message "hcrecord.detail.label.reserve.time"/></span>
									<input type="text" class="form-control reserveTime" disabled />
									<#else>
									<#if !reserveDate?has_content>
									<#assign reserveDate = "---" >
									</#if>
									<#if !reserveTime?has_content>
									<#assign reserveTime = "---" >
									</#if>
									<span><@spring.message "hcrecord.detail.label.reserve.date"/> ${reserveDate!""}</span>							
									<span><@spring.message "hcrecord.detail.label.reserve.time"/> ${reserveTime!""}</span>
									</#if>
								</div>
								<div class="appoint-search text-right">
									<#if isNewForm || copy?has_content>
									<button class="booking func-btn"><i class="fa fa-calendar-days"></i> <@spring.message "hcrecord.detail.button.check.schedule"/></button>
									</#if>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.subjective"/></td>
					</tr>
					<tr>
						<td colspan="2">
							<#if isNewForm>
							<textarea rows="3" class="basicForm form-control" placeholder="<@spring.message "hcrecord.detail.placeholder.subjective"/>" data-item="701" ></textarea>
							<#else>
								<#if mode == "view">
								${hcInfo.subjective!""}
								<#else>
								<textarea rows="3" class="basicForm form-control" placeholder="<@spring.message "hcrecord.detail.placeholder.subjective"/>" data-item="701" >${hcInfo.subjective!""}</textarea>
								</#if>
							</#if>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.objective"/></td>
					</tr>
					<tr>
						<td colspan="2">
							<#if isNewForm>
							<textarea rows="3" class="basicForm form-control" placeholder="<@spring.message "hcrecord.detail.placeholder.objective"/>" data-item="702" ></textarea>
							<#else>
								<#if mode == "view">
								${hcInfo.objective!""}
								<#else>
								<textarea rows="3" class="basicForm form-control" placeholder="<@spring.message "hcrecord.detail.placeholder.objective"/>" data-item="702" >${hcInfo.objective!""}</textarea>
								</#if>
							</#if>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.diagnosis"/></td>
					</tr>
					<tr>
						<td><@spring.message "hcrecord.detail.label.maincode"/></td>
						<td>
							<#if isNewForm>
							<select class="basicForm icd-code" data-item="703" >
								<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
							</select>
							<#else>
								<#if mode == "view">
								${hcInfo.mainIcdCode.viewTxt!""}
								<#else>
								<select class="basicForm icd-code" data-item="703" >
									<option value="${hcInfo.mainIcdCode.code!""}" >${hcInfo.mainIcdCode.codeTxt!""}</option>
								</select>
								</#if>
							</#if>
						</td>
					</tr>
					<tr>
						<td><@spring.message "hcrecord.detail.label.subcode1"/></td>
						<td>
							<#if isNewForm>
							<select class="basicForm icd-code" data-item="704" >
								<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
							</select>
							<#else>
								<#if mode == "view">
								${hcInfo.subIcdCode1.viewTxt!""}
								<#else>
								<select class="basicForm icd-code" data-item="704" >
									<option value="${hcInfo.subIcdCode1.code!""}" >${hcInfo.subIcdCode1.codeTxt!""}</option>
								</select>
								</#if>
							</#if>
						</td>
					</tr>
					<tr>
						<td><@spring.message "hcrecord.detail.label.subcode2"/></td>
						<td>
							<#if isNewForm>
							<select class="basicForm icd-code" data-item="705" >
								<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
							</select>
							<#else>
								<#if mode == "view">
								${hcInfo.subIcdCode2.viewTxt!""}
								<#else>
								<select class="basicForm icd-code" data-item="705" >
									<option value="${hcInfo.subIcdCode2.code!""}" >${hcInfo.subIcdCode2.codeTxt!""}</option>
								</select>
								</#if>							
							</#if>
						</td>
					</tr>
					<tr>
						<td><@spring.message "hcrecord.detail.label.subcode3"/></td>
						<td>
							<#if isNewForm>
							<select class="basicForm icd-code" data-item="706" >
								<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
							</select>
							<#else>
								<#if mode == "view">
								${hcInfo.subIcdCode3.viewTxt!""}
								<#else>
								<select class="basicForm icd-code" data-item="706" >
									<option value="${hcInfo.subIcdCode3.code!""}" >${hcInfo.subIcdCode3.codeTxt!""}</option>
								</select>
								</#if>							
							</#if>
						</td>
					</tr>
					<tr>
						<td><@spring.message "hcrecord.detail.label.subcode4"/></td>
						<td>
							<#if isNewForm>
							<select class="basicForm icd-code" data-item="707" >
								<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
							</select>
							<#else>
								<#if mode == "view">
								${hcInfo.subIcdCode4.viewTxt!""}
								<#else>
								<select class="basicForm icd-code" data-item="707" >
									<option value="${hcInfo.subIcdCode4.code!""}" >${hcInfo.subIcdCode4.codeTxt!""}</option>
								</select>
								</#if>							
							</#if>
						</td>
					</tr>
					<tr>
						<td><@spring.message "hcrecord.detail.label.subcode5"/></td>
						<td>
							<#if isNewForm>
							<select class="basicForm icd-code" data-item="708" >
								<option value="" ><@spring.message "hcrecord.detail.option.select.hint"/></option>
							</select>
							<#else>
								<#if mode == "view">
								${hcInfo.subIcdCode5.viewTxt!""}
								<#else>
								<select class="basicForm icd-code" data-item="708" >
									<option value="${hcInfo.subIcdCode5.code!""}" >${hcInfo.subIcdCode5.codeTxt!""}</option>
								</select>
								</#if>						
							</#if>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="sub-title"><@spring.message "hcrecord.detail.label.plan"/></td>
					</tr>
					<tr>
						<td colspan="2">
							<#if isNewForm>
							<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
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
						                        <#list executors as executor>                              	
						                        <option value="${executor.id!""}">[${executor.userNo!""}] ${executor.name!""}</option>
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
							<#else>
							<#if mode == "view">
							<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
								<thead>
							      <tr class="tablesorter-headerRow">
							      	<th width="40%"><@spring.message "hcrecord.detail.column.code"/></th>
							      	<th width="10%"><@spring.message "hcrecord.detail.column.period"/></th>
							      	<th width="10%"><@spring.message "hcrecord.detail.column.points"/></th>					      	
							      	<th width="20%"><@spring.message "hcrecord.detail.column.executor"/></th>    
							        <th width="10%"><@spring.message "hcrecord.detail.column.startDate"/></th>
							        <th width="10%"><@spring.message "hcrecord.detail.column.endDate"/></th>
							      </tr>					      
							    </thead>
								<tbody id="list_cnt">
									<#if hcInfo.paymentItems?has_content>									
									<#assign itemList = hcInfo.paymentItems>
									<#list itemList as info>
									<tr class="clone-row">
								      	<td>${info.paymentItemCode.codeTxt!""}</td>
								      	<td>${info.amount!""}</td>
								      	<td>${info.points!""}</td>
								      	<td>${info.executor.codeTxt!""}</td>
								      	<td>${info.beginTime!""}</td>
								      	<td>${info.endTime!""}</td>								      	
							      	</tr>
								    </#list>
								    </#if>  
						      	</tbody>
							</table>
							<#else>
							<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table">
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
									<#if hcInfo.paymentItems?has_content>
									<#assign itemList = hcInfo.paymentItems>
									<#list itemList as info>
									<tr class="clone-row clone" <#if !copy?has_content>data-keyno="${info.keyno!""}"</#if> >
										<td>
											<select class="itemForm form-control paymentItemCode" data-item="801" <#if !copy??>disabled</#if>>
												<option value="${info.paymentItemCode.code!""}">${info.paymentItemCode.codeTxt!""}</option>
											</select>									
										</td>
										<td>
								      		<input type="text" class="itemForm form-control amount" data-item="802" value="${info.amount!""}" disabled />
								      	</td>
								      	<td>
								      		<input type="text" class="itemForm form-control points" data-item="803" value="${info.points!""}" disabled />
								      	</td>
								      	<td>
								      		<select class="itemForm form-control executor" data-item="804" <#if !copy??>disabled</#if>>
						                        <option value=""><@spring.message "hcrecord.detail.option.select.hint"/></option>
						                        <#assign executorId = info.executor.code>
						                        <#list executors as executor>                              	
						                        <option value="${executor.id!""}" <#if executor.id?string == executorId>selected</#if>>[${executor.userNo!""}] ${executor.name!""}</option>
						                        </#list>			
						                    </select>
								      	</td>
								      	<td>
								      		<input type="text" class="itemForm form-control beginTime" value="${info.beginTime!""}" data-item="805" <#if !copy??>disabled</#if> />
								      	</td>
								      	<td>
								      		<input type="text" class="itemForm form-control endTime" value="${info.endTime!""}" data-item="806" <#if !copy??>disabled</#if> />
								      	</td>
								      	<td>
								      		<button class="delete-row func-btn"><i class="fa fa-trash-can"></i> <@spring.message "hcrecord.detail.button.delete"/></button>
								      	</td>
									</tr>
									</#list>
									</#if>
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
						                        <#list executors as executor>                              	
						                        <option value="${executor.id!""}">[${executor.userNo!""}] ${executor.name!""}</option>
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
							</#if>
		                    </#if>
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
									<#if isNewForm>
									<tr>
								      	<td>
								      		<select class="basicForm form-control copaymentCode" data-item="709">
								      			<option value=""><@spring.message "hcrecord.detail.option.select.hint"/></option>
								      			<option value="K00"><@spring.message "hcrecord.detail.option.k00.hint"/></option>
								      			<option value="K20"><@spring.message "hcrecord.detail.option.k20.hint"/></option>
								      		</select>
								      	</td>
								      	<td>
								      		<input type="text" class="basicForm form-control total-points" data-item="710" disabled />
								      	</td>
								      	<td>
								      		<input type="text" class="basicForm form-control part-points" data-item="711" disabled />
								      	</td>
								      	<td>
								      		<input type="number" class="basicForm form-control patient-serial-no" data-item="712" />
								      	</td>							      	
							      	</tr>
							      	<#else>	
							      	<#if mode == "view" >						      	
							      	<tr>
							      		<td>${hcInfo.coPaymentCode.codeTxt!""}</td>
								      	<td>${hcInfo.total_points!""}</td>
								      	<td>${hcInfo.part_points!""}</td>
								      	<td>${hcInfo.serial_no!""}</td>
							      	</tr>
							      	<#else>
							      	<tr>
								      	<td>
								      		<select class="basicForm form-control copaymentCode" data-item="709">
								      			<option value=""><@spring.message "hcrecord.detail.option.select.hint"/></option>
								      			<option value="K00" <#if hcInfo.coPaymentCode.code == "K00">selected</#if>><@spring.message "hcrecord.detail.option.k00.hint"/></option>
								      			<option value="K20" <#if hcInfo.coPaymentCode.code == "K20">selected</#if>><@spring.message "hcrecord.detail.option.k20.hint"/></option>
								      		</select>
								      	</td>
								      	<td>
								      		<input type="text" class="basicForm form-control total-points" data-item="710" value="${hcInfo.total_points!""}" disabled />
								      	</td>
								      	<td>
								      		<input type="text" class="basicForm form-control part-points" data-item="711" value="${hcInfo.part_points!""}" disabled />
								      	</td>
								      	<td>
								      		<input type="number" class="basicForm form-control patient-serial-no" data-item="712" value="${hcInfo.serial_no!""}" />
								      	</td>							      	
							      	</tr>
							      	</#if>
							      	</#if>
						      	</tbody>
							</table>
						</td>
					</tr>					
					<tr>
						<td colspan="2">
							<div class="footer-btn-list">								
								<#if isNewForm || copy??>
								<button class="goback func-btn"><i class="fa fa-circle-xmark"></i> <@spring.message "hcrecord.detail.button.cancel"/></button>
								<button class="func-btn" onclick="createHcInfo()"><i class="fa fa-save"></i> <@spring.message "hcrecord.detail.button.save"/></button>
								<#else>
								<#if mode?has_content && mode == "edit">
								<button class="goback func-btn"><i class="fa fa-circle-xmark"></i> <@spring.message "hcrecord.detail.button.cancel"/></button>
								<button class="func-btn" onclick="createHcInfo()"><i class="fa fa-save"></i> <@spring.message "hcrecord.detail.button.save"/></button>
								<button class="cancelRegis func-btn"><i class="fa fa-ban"></i> <@spring.message "hcrecord.detail.button.cancel.registration"/></button>
								</#if>
								</#if>
							</div>	
						</td>
					</tr>									
				</table>
			</div>
		</div>	
	</div>
</body>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:850px;">
		<div class="modal-content" >
			<div class="modal-header">
				選擇預約看診時間區段
				<button type="button" class="close clean" data-dismiss="modal" data-form="0" aria-label="Close">
		          	<i class="fa fa-xmark" aria-hidden="true"></i>
		        </button>
			</div>
			<div class="modal-body">
				<div id="wg-Container" style="width:100%;">               
			</div>
			<div class="modal-footer">    
				<button class="func-btn" onclick="reserve()">預約</button>			
				<button class="clean func-btn" data-dismiss="modal"><@spring.message "task.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>

<script>

$(document).ready(function(){
	startDatePicker('.birth');
	//
	$("#twzipcode").twzipcode({
    	zipcodeIntoDistrict: true
    });
    //
    $(".icd-code").each(function(idx){
		$(this).select2({
	        language: '${__lang}',
	        width: '100%',
	        maximumInputLength: 10,
	        minimumInputLength: 2,
	        placeholder: '<@spring.message "hcrecord.detail.option.enterCode"/>',
	        allowClear: true,
	        ajax: {
	            url: '${base}/division/api/qryICDCodeList',
	            type: 'POST',
	            data: function (params){
	                return {
	                    queryParam: params.term 
	                };
	            },
	            processResults: function (data, params){
	
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
	 	
	 	<#if !isNewForm>
	 	//$(this).prop('disabled', true);
	 	</#if>
 	});
 	//
 	selectAdapter(".paymentItemCode", 2, "<@spring.message "hcrecord.detail.option.planCode"/>", "${base}/division/api/qryServicePaymentItemList", "${__lang}");
 	//
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
});

$('.booking').on('click', function(){	
	wg.template.updateNewPageContent('wg-Container', 'myModuleContent', {}, '${base}/${__lang}/division/web/admin/taskMgnt/appointment');
	startAppointment();
	$("#myModal").modal('show');
});

$('#addRow').on( 'click', function () {
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

$(".delete-row").on('click', function(){
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

$("#cleanRow").on('click', function(){
	var target = $(this).closest("tr");
	target.find("input[type='text']").val("");
	target.find("select").val("").trigger('change');
	target.find('.paymentItemCode').find("option").remove();
});

$(".clone-row").find(".executor").on( 'change', function () {
	var selectValue = $(this).val();
	$(this).find("option").removeAttr('selected');
	$(this).find("option[value='" + selectValue + "']").attr('selected', true);
	$(this).val(selectValue);
});

$(".bringInRecord").on('click', function(){
	var recordkeyno = $(".recordList").val();
	if(recordkeyno == ""){
		swal("操作失敗", "尚未選擇任一筆歷史紀錄", "error");
	}else{
		window.location = "${base}/${__lang}/division/web/patient/${formId!""}/hcRecord/history/" + recordkeyno;
	}
});

//新增健保資料
function createHcInfo(){
	var itemNumArr = getItemNumArray("default-table", "basicForm");
	var itemArray = getItemValue("basicForm", itemNumArr);
	<#if isNewForm || copy??>
	var postData = {"creatorId":${currentUser.id!""}, "formName": "健保記錄V2", "evalDate": getEvalDate(), "app": "${formId!""}", "items": itemArray};	
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createUserForm?");
	<#else>
	<#if mode == "edit">
	var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": "${recordId!""}", "items": itemArray};	
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/editUserForm?");
	</#if>
	</#if>
	var subResult = "";
	
	if(result.success){		
		var cloneNum = $(".clone").length;
		if(cloneNum > 0){
			var finish = true;
			$(".clone").each(function(){
				if($(this).attr("data-keyno") == undefined){	//只更新新處置紀錄
					itemArray = [];
					$(this).find(".itemForm").each(function(){
						itemArray.push({"itemId": $(this).attr("data-item"), "ans": $(this).val(), "op": "e"});
					});
					postData = {"creatorId":${currentUser.id!""}, "formName": "健保處置項目V2", "evalDate": <#if isNewForm || copy??>getEvalDate()<#else>formatDate("${hcInfo.evalDate!""}")</#if>, "app": result.id, "items": itemArray<#if !isNewForm && !copy??>, "createDate": formatDate("${hcInfo.evalDate!""}"), "modifyDate": formatDate("${hcInfo.evalDate!""}")</#if>};
					subResult = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createUserForm?");
					if(!result.success) finish = false;
				}
			});
			
			if(finish){
				successToDirect("<@spring.message "hcrecord.detail.save.success.title"/>", "<@spring.message "hcrecord.detail.save.success.text"/>", "success", 1500, "${base}/${__lang}/division/web/patient/${formId!""}/hcRecord");
			}
			else{
				swal("<@spring.message "hcrecord.detail.save.fail.title"/>", "<@spring.message "hcrecord.detail.save.fail.text"/>", "error");
			}
		}
		else{
			successToDirect("<@spring.message "hcrecord.detail.save.success.title"/>", "<@spring.message "hcrecord.detail.save.success.text"/>", "success", 1500, "${base}/${__lang}/division/web/patient/${formId!""}/hcRecord");

		}
	}
	else{
		swal("<@spring.message "hcrecord.detail.save.fail.title"/>", "<@spring.message "hcrecord.detail.save.fail.text"/>", "error");
	}
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

<#if mode?has_content && mode == "edit">
$('.cancelRegis').on( 'click', function () {
	confirmCheck("<@spring.message "hcrecord.detail.registration.cancel.confirm.title"/>", "<@spring.message "hcrecord.detail.registration.cancel.confirm.text"/>", "warning", "btn-danger", "<@spring.message "hcrecord.detail.button.confirm"/>", "<@spring.message "hcrecord.detail.button.cancel"/>", function(confirmed){
		if(confirmed){			
			var postData = {"userFormKeyNo": "${recordId!""}"};
			var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/removeUserForm?");
		    if(result.success){
		    	successToDirect("<@spring.message "hcrecord.detail.registration.cancel.success.title"/>", "<@spring.message "hcrecord.detail.registration.cancel.success.text"/>", "success", 1500, "${base}/${__lang}/division/web/patient/${formId!""}/hcRecord");
			}else{
				swal("<@spring.message "hcrecord.detail.registration.cancel.fail.title"/>", "<@spring.message "hcrecord.detail.registration.cancel.fail.text"/>", "error");
			}
		}
	});
});
</#if>

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

$(".goback").click(function(e){
	e.preventDefault();
	window.location = "${base}/${__lang}/division/web/patient/${formId!""}/hcRecord";
});

function startAppointment(){
	$('#picker').markyourcalendar({
        months:['<@spring.message "appointment.label.jan"/>','<@spring.message "appointment.label.feb"/>','<@spring.message "appointment.label.mar"/>',
        		'<@spring.message "appointment.label.apr"/>','<@spring.message "appointment.label.may"/>','<@spring.message "appointment.label.jun"/>',
        		'<@spring.message "appointment.label.jul"/>','<@spring.message "appointment.label.aug"/>','<@spring.message "appointment.label.sep"/>',
        		'<@spring.message "appointment.label.oct"/>','<@spring.message "appointment.label.nov"/>','<@spring.message "appointment.label.dec"/>'],
        weekdays:['<@spring.message "appointment.label.mon"/>','<@spring.message "appointment.label.tue"/>','<@spring.message "appointment.label.wed"/>',
        		  '<@spring.message "appointment.label.thur"/>','<@spring.message "appointment.label.fri"/>','<@spring.message "appointment.label.sat"/>','<@spring.message "appointment.label.sun"/>'],
        availability: [
          ['09:00', '09:45', '10:30', '11:45', '13:00'],
          ['10:30', '11:45', '14:30'],
          ['09:00', '10:30', '13:45'],
          ['08:30', '09:30', '11:15', '12:30', '14:45'],
          ['11:00', '12:15', '13:00', '14:00'],
          ['10:15', '12:00'],
          ['09:45', '11:00', '12:15']
        ],
        startDate: new Date("2024-04-16"),
        onClick: function(ev, data) {
          // data is a list of datetimes
          var d = data[0].split(' ')[0];
          var t = data[0].split(' ')[1];
          $('#selected-date').val(d);
          $('#selected-time').val(t);
        },
        onClickNavigator: function(ev, instance) {
          var arr = [
            [
              ['09:00', '09:45', '10:30', '11:45', '13:00'],
	          ['10:30', '11:45', '14:30'],
	          ['09:45', '11:00', '12:15'],
	          ['08:30', '09:30', '11:15', '12:30', '14:45'],
	          ['11:00', '12:15', '13:00', '14:00'],
	          ['09:00', '10:30', '13:45'],
	          ['10:15', '12:00']          
            ],
            [
              ['08:30', '09:30', '11:15', '12:30', '14:45'],
	          ['10:30', '11:45', '14:30'],
	          ['09:45', '11:00', '12:15'],          
	          ['11:00', '12:15', '13:00', '14:00'],
	          ['09:00', '10:30', '13:45'],
	          ['10:15', '12:00'],
	          ['09:00', '09:45', '10:30', '11:45', '13:00']
            ],
            [
              ['09:45', '11:00', '12:15'],
              ['08:30', '09:30', '11:15', '12:30', '14:45'],
	          ['10:30', '11:45', '14:30'],
	          ['10:15', '12:00'],          
	          ['11:00', '12:15', '13:00', '14:00'],
	          ['09:00', '10:30', '13:45'],	          
	          ['09:00', '09:45', '10:30', '11:45', '13:00']
            ],
            [
              ['09:00', '10:30', '13:45'],
              ['09:45', '11:00', '12:15'],
              ['09:00', '09:45', '10:30', '11:45', '13:00'],
	          ['10:30', '11:45', '14:30'],
	          ['10:15', '12:00'],          
	          ['11:00', '12:15', '13:00', '14:00'],
	          ['08:30', '09:30', '11:15', '12:30', '14:45']	          
            ],
            [
              ['11:00', '12:15', '13:00', '14:00'],
              ['09:00', '10:30', '13:45'],             
              ['09:00', '09:45', '10:30', '11:45', '13:00'],
	          ['10:30', '11:45', '14:30'],
	          ['10:15', '12:00'],          
	          ['09:45', '11:00', '12:15'],
	          ['08:30', '09:30', '11:15', '12:30', '14:45']
            ],
            [
              ['11:00', '12:15', '13:00', '14:00'],
              ['09:00', '10:30', '13:45'],
              ['08:30', '09:30', '11:15', '12:30', '14:45']             
              ['09:00', '09:45', '10:30', '11:45', '13:00'],
	          ['10:30', '11:45', '14:30'],
	          ['10:15', '12:00'],          
	          ['09:45', '11:00', '12:15']        
            ],
            [
              ['11:00', '12:15', '13:00', '14:00'],
              ['09:00', '10:30', '13:45'],
              ['10:15', '12:00'],             
              ['09:00', '09:45', '10:30', '11:45', '13:00'],
	          ['10:30', '11:45', '14:30'],	          
	          ['08:30', '09:30', '11:15', '12:30', '14:45']          
	          ['09:45', '11:00', '12:15'] 
            ]
          ]
          var rn = Math.floor(Math.random() * 10) % 7;
          instance.setAvailability(arr[rn]);
        }
      });
}

function reserve(){
	var selectedDate = $('#selected-date').val();
	var selectedTime = $('#selected-time').val();
	if(selectedDate != "" && selectedTime != ""){
		var postData = {"creatorId": ${currentUser.id!""}, "cat": 2,"caseno": "${formId!""}", "beginDate": selectedDate, "beginTime": selectedTime, "note": "預約看診。"};
		var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createNewTask");
	    if(result.success){	
			$(".reserveDate").val(selectedDate);
			$(".reserveTime").val(selectedTime);
			$("#myModal").modal('hide');
			swal('預約成功', "已成功預約患者下次看診日期!", "success");
		}else{
			swal('預約失敗', "無法預約成功，請再試一次!", "error");
		}
	}else{
		swal('選擇時間', "尚未選擇預約時間", "error");
	}

}
				
</script>

<style>
select.form-control:disabled,
input[type="text"].form-control:disabled{
	background-color: #fff;
	border-color: #ced4da;
	-webkit-box-shadow: none;
	box-shadow: none;
	-webkit-transition: none;
}

.main-table tbody tr td span{
	font-weight: 500 !important;
}

.main-table tbody tr td{
	width: fit-content;
	white-space: normal !important;
}

.sub-title a{
	float: right;
	color: #666666;
}

.sub-title a:hover{
	cursor: pointer;
	text-decoration: none;
	color: #8c8c8c;
}

.appoint{
	flex: 1;
}

.appoint-search{
	flex: 0.2;
}

.appoint span,
.appoint input[type='text']{
	display: inline;
}

.appoint input[type='text']{
	width: 35%;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />