<!-- modal template -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:450px;">
		<div class="modal-content" >
			<div class="modal-header item-header">
				<@spring.message "modal.label.addItem"/>
				<button type="button" class="close clean" data-dismiss="modal" data-form="0" aria-label="Close">
		          	<i class="fa fa-xmark" aria-hidden="true"></i>
		        </button>
			</div>
			<div class="modal-body">
				<form class="reg" >
					<table class="default-table">
					    <tr>
							<td><@spring.message "modal.label.testItem"/></td>
							<td>
								<select class="itemForm form-control main-item" data-item='697' >
									<option value=""><@spring.message "modal.option.item"/></option>		
							  		<#list examItemMap as item>
										<#if item_index != 0>
		                            		<option value="${item_index}">${item}</option>
		                            	</#if>	
		                            </#list>
								</select>
							</td>
						</tr>
						<tr class="part-option">
							<td><@spring.message "modal.label.bodypart"/></td>
							<td>
								<select class="itemForm form-control bodypart" aria-describedby="basic-addon1" data-item='247'>
									<option value=""><@spring.message "modal.option.bodypart"/></option>
									<#list examItemMap as item>
									<#if item_index == 1>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.eyes"/>"><@spring.message "modal.option.eyes"/></option>
									</optgroup>	
									<#elseif item_index == 2>
									<optgroup label="${item}(<@spring.message "modal.optgroup.front"/>)" data-item="${item_index}">								
								      	<option value="<@spring.message "modal.option.head"/>"><@spring.message "modal.option.head"/></option>
								      	<option value="<@spring.message "modal.option.face"/>"><@spring.message "modal.option.face"/></option>
								     	<option value="<@spring.message "modal.option.left.ear"/>"><@spring.message "modal.option.left.ear"/></option>
								     	<option value="<@spring.message "modal.option.right.ear"/>"><@spring.message "modal.option.right.ear"/></option>
								     	<option value="<@spring.message "modal.option.left.shoulder"/>"><@spring.message "modal.option.left.shoulder"/></option>
								     	<option value="<@spring.message "modal.option.right.shoulder"/>"><@spring.message "modal.option.right.shoulder"/></option>
								     	<option value="<@spring.message "modal.option.left.breast"/>"><@spring.message "modal.option.left.breast"/></option>
								     	<option value="<@spring.message "modal.option.right.breast"/>"><@spring.message "modal.option.right.breast"/></option>
								     	<option value="<@spring.message "modal.option.left.upper.arm"/>"><@spring.message "modal.option.left.upper.arm"/></option>
								     	<option value="<@spring.message "modal.option.right.upper.arm"/>"><@spring.message "modal.option.right.upper.arm"/></option>
								     	<option value="<@spring.message "modal.option.abdomen"/>"><@spring.message "modal.option.abdomen"/></option>
								     	<option value="<@spring.message "modal.option.left.foream"/>"><@spring.message "modal.option.left.foream"/></option>
								     	<option value="<@spring.message "modal.option.right.foream"/>"><@spring.message "modal.option.right.foream"/></option>
								     	<option value="<@spring.message "modal.option.genitals"/>"><@spring.message "modal.option.genitals"/></option>
								     	<option value="<@spring.message "modal.option.left.hand"/>"><@spring.message "modal.option.left.hand"/></option>
								     	<option value="<@spring.message "modal.option.right.hand"/>"><@spring.message "modal.option.right.hand"/></option>
								     	<option value="<@spring.message "modal.option.left.groin"/>"><@spring.message "modal.option.left.groin"/></option>
								     	<option value="<@spring.message "modal.option.right.groin"/>"><@spring.message "modal.option.right.groin"/></option>
								     	<option value="<@spring.message "modal.option.left.thigh"/>"><@spring.message "modal.option.left.thigh"/></option>
								     	<option value="<@spring.message "modal.option.right.thigh"/>"><@spring.message "modal.option.right.thigh"/></option>
								     	<option value="<@spring.message "modal.option.left.knee"/>"><@spring.message "modal.option.left.knee"/></option>
								     	<option value="<@spring.message "modal.option.right.knee"/>"><@spring.message "modal.option.right.knee"/></option>
								     	<option value="<@spring.message "modal.option.left.legal"/>"><@spring.message "modal.option.left.legal"/></option>
								     	<option value="<@spring.message "modal.option.right.legal"/>"><@spring.message "modal.option.right.legal"/></option>
								     	<option value="<@spring.message "modal.option.left.feet"/>"><@spring.message "modal.option.left.feet"/></option>
								     	<option value="<@spring.message "modal.option.right.feet"/>"><@spring.message "modal.option.right.feet"/></option>
								    </optgroup>
								    <optgroup label="${item}(<@spring.message "modal.optgroup.back"/>)" data-item="${item_index}">
								    	<option value="<@spring.message "modal.option.hindbrain"/>"><@spring.message "modal.option.hindbrain"/></option>
								      	<option value="<@spring.message "modal.option.neck"/>"><@spring.message "modal.option.neck"/></option>
								      	<option value="<@spring.message "modal.option.back"/>"><@spring.message "modal.option.back"/></option>
								      	<option value="<@spring.message "modal.option.left.back"/>"><@spring.message "modal.option.left.back"/></option>
								      	<option value="<@spring.message "modal.option.right.back"/>"><@spring.message "modal.option.right.back"/></option>
								      	<option value="<@spring.message "modal.option.waist"/>"><@spring.message "modal.option.waist"/></option>
								      	<option value="<@spring.message "modal.option.left.elbow"/>"><@spring.message "modal.option.left.elbow"/></option>
								      	<option value="<@spring.message "modal.option.right.elbow"/>"><@spring.message "modal.option.right.elbow"/></option>
								      	<option value="<@spring.message "modal.option.sacrum"/>"><@spring.message "modal.option.sacrum"/></option>
								      	<option value="<@spring.message "modal.option.left.wrist"/>"><@spring.message "modal.option.left.wrist"/></option>
								      	<option value="<@spring.message "modal.option.right.wrist"/>"><@spring.message "modal.option.right.wrist"/></option>
								      	<option value="<@spring.message "modal.option.anus"/>"><@spring.message "modal.option.anus"/></option>
								      	<option value="<@spring.message "modal.option.left.hip"/>"><@spring.message "modal.option.left.hip"/></option>
								      	<option value="<@spring.message "modal.option.right.hip"/>"><@spring.message "modal.option.right.hip"/></option>
								      	<option value="<@spring.message "modal.option.left.heel"/>"><@spring.message "modal.option.left.heel"/></option>
								      	<option value="<@spring.message "modal.option.right.heel"/>"><@spring.message "modal.option.right.heel"/></option>
								    </optgroup>
								    <optgroup label="${item}(<@spring.message "modal.optgroup.left"/>)" data-item="${item_index}">
								    	<option value="<@spring.message "modal.option.right.elbow.in"/>"><@spring.message "modal.option.right.elbow.in"/></option>
								      	<option value="<@spring.message "modal.option.left.rib"/>"><@spring.message "modal.option.left.rib"/></option>
								      	<option value="<@spring.message "modal.option.left.elbow.out"/>"><@spring.message "modal.option.left.elbow.out"/></option>
								      	<option value="<@spring.message "modal.option.left.llium"/>"><@spring.message "modal.option.left.llium"/></option>
								      	<option value="<@spring.message "modal.option.left.femur"/>"><@spring.message "modal.option.left.femur"/></option>
								      	<option value="<@spring.message "modal.option.right.knee.in"/>"><@spring.message "modal.option.right.knee.in"/></option>
								      	<option value="<@spring.message "modal.option.left.knee.out"/>"><@spring.message "modal.option.left.knee.out"/></option>
								      	<option value="<@spring.message "modal.option.right.ankle.in"/>"><@spring.message "modal.option.right.ankle.in"/></option>
								      	<option value="<@spring.message "modal.option.right.foot.in"/>"><@spring.message "modal.option.right.foot.in"/></option>
								      	<option value="<@spring.message "modal.option.left.ankle.out"/>"><@spring.message "modal.option.left.ankle.out"/></option>
								      	<option value="<@spring.message "modal.option.left.foot.out"/>"><@spring.message "modal.option.left.foot.out"/></option>			      	
								    </optgroup>
								    <optgroup label="${item}(<@spring.message "modal.optgroup.right"/>)" data-item="${item_index}">
								    	<option value="<@spring.message "modal.option.left.elbow.in"/>"><@spring.message "modal.option.left.elbow.in"/></option>
								      	<option value="<@spring.message "modal.option.right.rib"/>"><@spring.message "modal.option.right.rib"/></option>
								      	<option value="<@spring.message "modal.option.right.elbow.out"/>"><@spring.message "modal.option.right.elbow.out"/></option>
								      	<option value="<@spring.message "modal.option.right.llium"/>"><@spring.message "modal.option.right.llium"/></option>
								      	<option value="<@spring.message "modal.option.right.femur"/>"><@spring.message "modal.option.right.femur"/></option>
								      	<option value="<@spring.message "modal.option.left.knee.in"/>"><@spring.message "modal.option.left.knee.in"/></option>
								      	<option value="<@spring.message "modal.option.right.knee.out"/>"><@spring.message "modal.option.right.knee.out"/></option>
								      	<option value="<@spring.message "modal.option.left.ankle.in"/>"><@spring.message "modal.option.left.ankle.in"/></option>
								      	<option value="<@spring.message "modal.option.left.foot.in"/>"><@spring.message "modal.option.left.foot.in"/></option>
								      	<option value="<@spring.message "modal.option.right.ankle.out"/>"><@spring.message "modal.option.right.ankle.out"/></option>
								      	<option value="<@spring.message "modal.option.right.foot.out"/>"><@spring.message "modal.option.right.foot.out"/></option>			      	
								    </optgroup>
								    <#elseif item_index == 3>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.abdomen"/>"><@spring.message "modal.option.abdomen"/></option>
										<option value="<@spring.message "modal.option.bloodVessel"/>"><@spring.message "modal.option.bloodVessel"/></option>
										<option value="<@spring.message "modal.option.lungs"/>"><@spring.message "modal.option.lungs"/></option>
										<option value="<@spring.message "modal.option.gynecology"/>"><@spring.message "modal.option.gynecology"/></option>
									</optgroup>
									<#elseif item_index == 4>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.heart"/>"><@spring.message "modal.option.heart"/></option>
									</optgroup>
									<#elseif item_index == 5>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.lungs"/>"><@spring.message "modal.option.lungs"/></option>
									</optgroup>
									<#elseif item_index == 6>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.ears"/>"><@spring.message "modal.option.ears"/></option>
									</optgroup>
									<#elseif item_index == 7>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.ears"/>"><@spring.message "modal.option.ears"/></option>
									</optgroup>
									<#elseif item_index == 8>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.upperarm.ankle"/>"><@spring.message "modal.option.upperarm.ankle"/></option>
									</optgroup>
									<#elseif item_index == 9>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.skin"/>"><@spring.message "modal.option.skin"/></option>
									</optgroup>
									<#else>
									<!--<optgroup label="ABI">
										<option value="<@spring.message "modal.option.left"/>"><@spring.message "modal.option.left"/></option>
										<option value="<@spring.message "modal.option.right"/>"><@spring.message "modal.option.right"/></option>
									</optgroup>-->									
								    <optgroup label="<@spring.message "modal.optgroup.other"/>" data-item="0">
										<option value="<@spring.message "modal.option.other"/>"><@spring.message "modal.option.other"/></option>
									</optgroup>
								    </#if>
									</#list>							  			
								</select>
							</td>
						</tr>
						<tr class="hidden">
							<td><@spring.message "modal.label.other.bodypart"/></td>
							<td>
								<input type="text" class="form-control other-bodypart" />
							</td>
						</tr>
						<tr>
							<td><@spring.message "modal.label.evalDate"/></td>
							<td>
								<input type="text" class="form-control eval-date" />
							</td>
						</tr>						
						<tr>
							<td><@spring.message "modal.label.caseClose"/></td>
							<td>
								<select class="itemForm form-control" data-item='249'>
									<option value="N" selected><@spring.message "modal.option.no"/></option>
									<option value="Y"><@spring.message "modal.option.yes"/></option>
								</select>
							</td>
						</tr>										
					</table>
				</form>                
			</div>
			<div class="modal-footer">
				<button class="func-btn" onclick="addItemRecord()"><@spring.message "modal.button.save"/></button>            
				<button class="clean func-btn" data-dismiss="modal" data-form="0"><@spring.message "inspect.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:350px;">
		<div class="modal-content" >
			<div class="modal-header item-header">
				<@spring.message "modal.label.editItem"/>
				<button type="button" class="close clean" data-dismiss="modal" data-form="1" aria-label="Close">
		          	<i class="fa fa-xmark" aria-hidden="true"></i>
		        </button>
			</div>
			<div class="modal-body">
				<form class="reg" >
					<table class="default-table">
					    <tr>
							<td><@spring.message "modal.label.testItem"/></td>
							<td>
								<select class="editItemForm form-control main-item" data-item='697' disabled>
									<option value=""><@spring.message "modal.option.item"/></option>		
							  		<#list examItemMap as item>
										<#if item_index != 0>
		                            		<option value="${item_index}">${item}</option>
		                            	</#if>	
		                            </#list>
								</select>
							</td>
						</tr>
						<tr class="part-option">
							<td><@spring.message "modal.label.bodypart"/></td>
							<td>
								<select class="editItemForm form-control bodypart" aria-describedby="basic-addon1" data-item='247'>
									<option value=""><@spring.message "modal.option.bodypart"/></option>
									<#list examItemMap as item>
									<#if item_index == 1>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.eyes"/>"><@spring.message "modal.option.eyes"/></option>
									</optgroup>	
									<#elseif item_index == 2>
									<optgroup label="${item}(<@spring.message "modal.optgroup.front"/>)" data-item="${item_index}">								
								      	<option value="<@spring.message "modal.option.head"/>"><@spring.message "modal.option.head"/></option>
								      	<option value="<@spring.message "modal.option.face"/>"><@spring.message "modal.option.face"/></option>
								     	<option value="<@spring.message "modal.option.left.ear"/>"><@spring.message "modal.option.left.ear"/></option>
								     	<option value="<@spring.message "modal.option.right.ear"/>"><@spring.message "modal.option.right.ear"/></option>
								     	<option value="<@spring.message "modal.option.left.shoulder"/>"><@spring.message "modal.option.left.shoulder"/></option>
								     	<option value="<@spring.message "modal.option.right.shoulder"/>"><@spring.message "modal.option.right.shoulder"/></option>
								     	<option value="<@spring.message "modal.option.left.breast"/>"><@spring.message "modal.option.left.breast"/></option>
								     	<option value="<@spring.message "modal.option.right.breast"/>"><@spring.message "modal.option.right.breast"/></option>
								     	<option value="<@spring.message "modal.option.left.upper.arm"/>"><@spring.message "modal.option.left.upper.arm"/></option>
								     	<option value="<@spring.message "modal.option.right.upper.arm"/>"><@spring.message "modal.option.right.upper.arm"/></option>
								     	<option value="<@spring.message "modal.option.abdomen"/>"><@spring.message "modal.option.abdomen"/></option>
								     	<option value="<@spring.message "modal.option.left.foream"/>"><@spring.message "modal.option.left.foream"/></option>
								     	<option value="<@spring.message "modal.option.right.foream"/>"><@spring.message "modal.option.right.foream"/></option>
								     	<option value="<@spring.message "modal.option.genitals"/>"><@spring.message "modal.option.genitals"/></option>
								     	<option value="<@spring.message "modal.option.left.hand"/>"><@spring.message "modal.option.left.hand"/></option>
								     	<option value="<@spring.message "modal.option.right.hand"/>"><@spring.message "modal.option.right.hand"/></option>
								     	<option value="<@spring.message "modal.option.left.groin"/>"><@spring.message "modal.option.left.groin"/></option>
								     	<option value="<@spring.message "modal.option.right.groin"/>"><@spring.message "modal.option.right.groin"/></option>
								     	<option value="<@spring.message "modal.option.left.thigh"/>"><@spring.message "modal.option.left.thigh"/></option>
								     	<option value="<@spring.message "modal.option.right.thigh"/>"><@spring.message "modal.option.right.thigh"/></option>
								     	<option value="<@spring.message "modal.option.left.knee"/>"><@spring.message "modal.option.left.knee"/></option>
								     	<option value="<@spring.message "modal.option.right.knee"/>"><@spring.message "modal.option.right.knee"/></option>
								     	<option value="<@spring.message "modal.option.left.legal"/>"><@spring.message "modal.option.left.legal"/></option>
								     	<option value="<@spring.message "modal.option.right.legal"/>"><@spring.message "modal.option.right.legal"/></option>
								     	<option value="<@spring.message "modal.option.left.feet"/>"><@spring.message "modal.option.left.feet"/></option>
								     	<option value="<@spring.message "modal.option.right.feet"/>"><@spring.message "modal.option.right.feet"/></option>
								    </optgroup>
								    <optgroup label="${item}(<@spring.message "modal.optgroup.back"/>)" data-item="${item_index}">
								    	<option value="<@spring.message "modal.option.hindbrain"/>"><@spring.message "modal.option.hindbrain"/></option>
								      	<option value="<@spring.message "modal.option.neck"/>"><@spring.message "modal.option.neck"/></option>
								      	<option value="<@spring.message "modal.option.back"/>"><@spring.message "modal.option.back"/></option>
								      	<option value="<@spring.message "modal.option.left.back"/>"><@spring.message "modal.option.left.back"/></option>
								      	<option value="<@spring.message "modal.option.right.back"/>"><@spring.message "modal.option.right.back"/></option>
								      	<option value="<@spring.message "modal.option.waist"/>"><@spring.message "modal.option.waist"/></option>
								      	<option value="<@spring.message "modal.option.left.elbow"/>"><@spring.message "modal.option.left.elbow"/></option>
								      	<option value="<@spring.message "modal.option.right.elbow"/>"><@spring.message "modal.option.right.elbow"/></option>
								      	<option value="<@spring.message "modal.option.sacrum"/>"><@spring.message "modal.option.sacrum"/></option>
								      	<option value="<@spring.message "modal.option.left.wrist"/>"><@spring.message "modal.option.left.wrist"/></option>
								      	<option value="<@spring.message "modal.option.right.wrist"/>"><@spring.message "modal.option.right.wrist"/></option>
								      	<option value="<@spring.message "modal.option.anus"/>"><@spring.message "modal.option.anus"/></option>
								      	<option value="<@spring.message "modal.option.left.hip"/>"><@spring.message "modal.option.left.hip"/></option>
								      	<option value="<@spring.message "modal.option.right.hip"/>"><@spring.message "modal.option.right.hip"/></option>
								      	<option value="<@spring.message "modal.option.left.heel"/>"><@spring.message "modal.option.left.heel"/></option>
								      	<option value="<@spring.message "modal.option.right.heel"/>"><@spring.message "modal.option.right.heel"/></option>
								    </optgroup>
								    <optgroup label="${item}(<@spring.message "modal.optgroup.left"/>)" data-item="${item_index}">
								    	<option value="<@spring.message "modal.option.right.elbow.in"/>"><@spring.message "modal.option.right.elbow.in"/></option>
								      	<option value="<@spring.message "modal.option.left.rib"/>"><@spring.message "modal.option.left.rib"/></option>
								      	<option value="<@spring.message "modal.option.left.elbow.out"/>"><@spring.message "modal.option.left.elbow.out"/></option>
								      	<option value="<@spring.message "modal.option.left.llium"/>"><@spring.message "modal.option.left.llium"/></option>
								      	<option value="<@spring.message "modal.option.left.femur"/>"><@spring.message "modal.option.left.femur"/></option>
								      	<option value="<@spring.message "modal.option.right.knee.in"/>"><@spring.message "modal.option.right.knee.in"/></option>
								      	<option value="<@spring.message "modal.option.left.knee.out"/>"><@spring.message "modal.option.left.knee.out"/></option>
								      	<option value="<@spring.message "modal.option.right.ankle.in"/>"><@spring.message "modal.option.right.ankle.in"/></option>
								      	<option value="<@spring.message "modal.option.right.foot.in"/>"><@spring.message "modal.option.right.foot.in"/></option>
								      	<option value="<@spring.message "modal.option.left.ankle.out"/>"><@spring.message "modal.option.left.ankle.out"/></option>
								      	<option value="<@spring.message "modal.option.left.foot.out"/>"><@spring.message "modal.option.left.foot.out"/></option>			      	
								    </optgroup>
								    <optgroup label="${item}(<@spring.message "modal.optgroup.right"/>)" data-item="${item_index}">
								    	<option value="<@spring.message "modal.option.left.elbow.in"/>"><@spring.message "modal.option.left.elbow.in"/></option>
								      	<option value="<@spring.message "modal.option.right.rib"/>"><@spring.message "modal.option.right.rib"/></option>
								      	<option value="<@spring.message "modal.option.right.elbow.out"/>"><@spring.message "modal.option.right.elbow.out"/></option>
								      	<option value="<@spring.message "modal.option.right.llium"/>"><@spring.message "modal.option.right.llium"/></option>
								      	<option value="<@spring.message "modal.option.right.femur"/>"><@spring.message "modal.option.right.femur"/></option>
								      	<option value="<@spring.message "modal.option.left.knee.in"/>"><@spring.message "modal.option.left.knee.in"/></option>
								      	<option value="<@spring.message "modal.option.right.knee.out"/>"><@spring.message "modal.option.right.knee.out"/></option>
								      	<option value="<@spring.message "modal.option.left.ankle.in"/>"><@spring.message "modal.option.left.ankle.in"/></option>
								      	<option value="<@spring.message "modal.option.left.foot.in"/>"><@spring.message "modal.option.left.foot.in"/></option>
								      	<option value="<@spring.message "modal.option.right.ankle.out"/>"><@spring.message "modal.option.right.ankle.out"/></option>
								      	<option value="<@spring.message "modal.option.right.foot.out"/>"><@spring.message "modal.option.right.foot.out"/></option>			      	
								    </optgroup>
								    <#elseif item_index == 3>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.abdomen"/>"><@spring.message "modal.option.abdomen"/></option>
										<option value="<@spring.message "modal.option.bloodVessel"/>"><@spring.message "modal.option.bloodVessel"/></option>
										<option value="<@spring.message "modal.option.lungs"/>"><@spring.message "modal.option.lungs"/></option>
										<option value="<@spring.message "modal.option.gynecology"/>"><@spring.message "modal.option.gynecology"/></option>
									</optgroup>
									<#elseif item_index == 4>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.heart"/>"><@spring.message "modal.option.heart"/></option>
									</optgroup>
									<#elseif item_index == 5>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.lungs"/>"><@spring.message "modal.option.lungs"/></option>
									</optgroup>
									<#elseif item_index == 6>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.ears"/>"><@spring.message "modal.option.ears"/></option>
									</optgroup>
									<#elseif item_index == 7>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.ears"/>"><@spring.message "modal.option.ears"/></option>
									</optgroup>
									<#elseif item_index == 8>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.upperarm.ankle"/>"><@spring.message "modal.option.upperarm.ankle"/></option>
									</optgroup>
									<#elseif item_index == 9>
									<optgroup label="${item}" data-item="${item_index}">
										<option value="<@spring.message "modal.option.skin"/>"><@spring.message "modal.option.skin"/></option>
									</optgroup>
									<#else>
									<!--<optgroup label="ABI">
										<option value="<@spring.message "modal.option.left"/>"><@spring.message "modal.option.left"/></option>
										<option value="<@spring.message "modal.option.right"/>"><@spring.message "modal.option.right"/></option>
									</optgroup>-->									
								    <optgroup label="<@spring.message "modal.optgroup.other"/>" data-item="0">
										<option value="<@spring.message "modal.option.other"/>"><@spring.message "modal.option.other"/></option>
									</optgroup>
								    </#if>
									</#list>							  			
								</select>
							</td>
						</tr>
						<tr class="hidden">
							<td><@spring.message "modal.label.other.bodypart"/></td>
							<td>
								<input type="text" class="form-control other-wound" />
							</td>
						</tr>						
						<tr>
							<td><@spring.message "modal.label.caseClose"/></td>
							<td>
								<select class="editItemForm form-control" data-item='249'>
									<option value="N" selected><@spring.message "modal.option.no"/></option>
									<option value="Y"><@spring.message "modal.option.yes"/></option>
								</select>
							</td>
						</tr>										
					</table>
				</form>                
			</div>
			<div class="modal-footer">
				<button class="func-btn"><@spring.message "modal.button.save"/></button>            
				<button class="clean func-btn" data-dismiss="modal" data-form="1"><@spring.message "inspect.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:350px;">
		<div class="modal-content" >
			<div class="modal-header"><@spring.message "modal.label.deleteItem"/></div>
			<div class="modal-body">
				<@spring.message "modal.label.deleteItem.text"/>
				<table class="delItem-table">
					<tr>
						<td><@spring.message "modal.label.evalDate"/></td>
						<td class="delForm delEvaldate"></td>
					</tr>
					<tr>
						<td><@spring.message "modal.label.testItem"/></td>
						<td class="delForm" data-item="697"></td>
					</tr>
					<tr>
						<td><@spring.message "modal.label.bodypart"/></td>
						<td class="delForm" data-item="247"></td>
					</tr>										
				</table>
				<input type="text" class="delNo hidden" />
			</div>
			<div class="modal-footer">
				<button class="func-btn" onclick="delItemRecord()"><@spring.message "inspect.button.confirm"/></button>            
				<button class="func-btn" data-dismiss="modal"><@spring.message "inspect.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>
<div class="bootbox modal fade" id="myModal7" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:600px;">
		<div class="modal-content" >
			<div class="modal-header"><@spring.message "modal.label.phrase.choose"/></div>
			<div class="modal-body">
  				<div class="form-group">
    				<label for="phrase-title"><@spring.message "modal.label.phrase"/></label>
    				<select name="quickNo" class="form-control phrase" >
						<option value=""><@spring.message "modal.option.select.hint"/></option>
				    </select>
  				</div>
  				<div class="form-group">
    				<label for="phrase-cnt"><@spring.message "modal.label.phrase.content"/></label>
    				<textarea name="content" class="form-control" style="width:100%; height:150px" ></textarea>
  				</div>
			</div>
			<div class="modal-footer">             
    			<button class="phrase-into func-btn" ><@spring.message "modal.button.bringIn"/></button>
            	<button class="func-btn" data-dismiss="modal" ><@spring.message "inspect.button.cancel"/></button>
            </div>
		</div>
	</div>
</div>
<div class="modal fade" id="myModal8" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog " style="width:650px;">
        <div class="modal-content" >
            <div class="modal-body anal-content">
            	<div class="load-area">
            		<a class="isDisabled">
		            	<img src="${base}/images/woundInfo/loading.gif" class="load-img" />
		            	<h4 style="line-height:24px"><@spring.message "modal.label.woundImg.analysing"/></h4>
	            	</a>
            	</div>
            	<div class="anal-area hidden">
            		<span><@spring.message "modal.label.via.analyze"/></span>
            		<div class="col-md-12 anal-info">
            			<img alt="<@spring.message "modal.label.analyzed.img"/>" class="anal-img" />
            			<div class="bottom-right">
							<!--<button onclick="changeParam()"><i class="fa fa-sliders"></i> <@spring.message "modal.button.adjust.data"/></button>-->
							<!--<button onclick="goValid()"><i class="fa fa-certificate"></i> <@spring.message "modal.button.enable.certificate"/></button>-->
            			</div>
    				</div>   				
            		<div class="input-group col-md-12">
	            		<span class="input-group-addon"><@spring.message "result.print.label.wound.height"/></span>
						<input type="text" class="form-control" aria-describedby="basic-addon1" data-item="250" disabled="true" value="0">
						<span class="input-group-addon"><@spring.message "result.print.label.wound.width"/></span>
						<input type="text" class="form-control" aria-describedby="basic-addon1" data-item="251" disabled="true" value="0">						
						<span class="input-group-addon"><@spring.message "result.print.label.wound.area"/></span>
						<input type="text" class="form-control" aria-describedby="basic-addon1" data-item="315" disabled="true" value="0">
            		</div>
            		<span class="unit"><@spring.message "modal.label.pixel.unit"/></span>
            		<div class="input-group col-md-12">
            			<span class="input-group-addon"><@spring.message "result.print.label.wound.epithelium"/></span>
						<input type="text" class="form-control" aria-describedby="basic-addon2" data-item="445" value="0">
	            		<span class="input-group-addon"><@spring.message "result.print.label.wound.granular"/></span>
						<input type="text" class="form-control" aria-describedby="basic-addon2" data-item="446" value="0">
						<span class="input-group-addon"><@spring.message "result.print.label.wound.slough"/></span>
						<input type="text" class="form-control" aria-describedby="basic-addon2" data-item="447" value="0">
						<span class="input-group-addon"><@spring.message "result.print.label.wound.eschar"/></span>
						<input type="text" class="form-control" aria-describedby="basic-addon2" data-item="448" value="0">
            		</div>
            		<span><@spring.message "modal.label.percent.unit"/></span>
            	</div>                
            </div>
            <div class="modal-footer hidden">
            	<button class="func-btn" onclick="loadBinaryImg()" ><@spring.message "modal.button.wound.repaint"/></button>
            	<button class="func-btn" onclick="delOriginImg()" ><@spring.message "modal.button.delete.img"/></button>
            	<button class="func-btn" onclick="saveSize()" ><@spring.message "modal.button.bringIn.size"/></button>
            	<button class="func-btn" onclick="saveProp()" ><@spring.message "modal.button.bringIn.prop"/></button>
            	<button class="func-btn" onclick="saveAllData()" ><@spring.message "modal.button.bringIn.all"/></button>
            	<!--<button class="func-btn" onclick="saveImg()" ><@spring.message "modal.button.save.img"/></button>-->
            	<button class="leave func-btn" data-dismiss="modal" onclick="removeCanvas()" ><@spring.message "modal.button.cancel.and.finish"/></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal8-eye" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog " style="width:650px;">
        <div class="modal-content" >
            <div class="modal-body anal-content">
            	<div class="load-area">
            		<a class="isDisabled">
		            	<img src="${base}/images/woundInfo/loading.gif" class="load-img" />
		            	<h4 style="line-height:24px"><@spring.message "modal.label.fundusImg.analysing"/></h4>
	            	</a>
            	</div>
            </div>
            <div class="modal-footer hidden">
            	<button class="func-btn" onclick="delOriginImg()" ><@spring.message "modal.button.delete.img"/></button>
            	<button class="func-btn" onclick="saveData()" ><@spring.message "modal.button.bringIn"/></button>
            	<!--<button class="func-btn" onclick="saveImg()" ><@spring.message "modal.button.save.img"/></button>-->
            	<button class="leave func-btn" data-dismiss="modal" ><@spring.message "modal.button.cancel.and.finish"/></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal10" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog " style="width:1200px; ">
        <div class="modal-content" >
        	<div class="modal-header"><@spring.message "modal.label.orderMap.export"/></div>
            <div class="modal-body">
            	<div class="mark-panel">
					<div class="colorSelect">
						<span><@spring.message "modal.label.tag.color"/></span>
						<label for='m-red' class="m-red"><input type="radio" id="m-red" name="markColor" class="radioItem" markColor='red'/> █ <@spring.message "modal.label.tag.red"/></label>
						<label for='m-orange' class="m-orange"><input type="radio" id="m-orange" name="markColor" class="radioItem" markColor='orange'/> █ <@spring.message "modal.label.tag.orange"/></label>
						<!--<label for='m-yellow' class="m-yellow"><input type="radio" id="m-yellow" name="markColor" class="radioItem" markColor='yellow'/> █ <@spring.message "modal.label.tag.yellow"/></label>-->
						<label for='m-green' class="m-green"><input type="radio" id="m-green" name="markColor" class="radioItem" markColor='green'/> █ <@spring.message "modal.label.tag.green"/></label>
						<label for='m-blue' class="m-blue"><input type="radio" id="m-blue" name="markColor" class="radioItem" markColor='blue' checked="checked" /> █ <@spring.message "modal.label.tag.blue"/></label>
						<label for='m-purple' class="m-purple"><input type="radio" id="m-purple" name="markColor" class="radioItem" markColor='purple'/> █ <@spring.message "modal.label.tag.purple"/></label>						
						<p><@spring.message "modal.label.tag.hint"/></p>
					</div>
					<div id="capture" class="img-export-area">
						<div class="mark-funclist">
							<img class="markImg" />
							<button class="reset func-btn lipButton"><@spring.message "modal.button.reset"/></button>
							<button class="rotate lipButton func-btn"><@spring.message "modal.button.rotate"/></button>
						</div>
						<div class="content">			
							<table class="table table-bordered table-striped dataTable marksTable">
								<thead>
									<tr>
										<th style="width: 10%"><@spring.message "modal.column.no"/></th>
										<th style="width: 80%"><@spring.message "modal.column.plan"/></th>
										<th style="width: 10%"><@spring.message "modal.column.delete"/></th>
									</tr>
								</thead>
								<tbody>					
								</tbody>				
							</table>
						</div>
					</div>	
				</div>
            </div>
            <div class="modal-footer">
    			<button class="func-btn" onclick="sendImgToGroup()"><@spring.message "modal.button.export.to.group"/></button>
    			<button class="png-upload func-btn" ><@spring.message "modal.button.export"/></button>
            	<button class="func-btn" data-dismiss="modal" onclick="reZoomMark()" ><@spring.message "inspect.button.cancel"/></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal11" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog " style="width:650px;">
        <div class="modal-content" >
        	<div class="modal-header"><@spring.message "modal.label.data.adjustment"/></div>
            <div class="modal-body slider-grp">			
        		<div class="slider-bk">
        			<div class="col-md-2"><@spring.message "result.print.label.wound.height"/></div>
        			<div class="col-md-10">
            			<input type="range" class="slider" data-rangeItem="250" min="0" max="50" step="0.1" >
            			<input type="text" class="slider-value" data-valItem="250" value="0">
        			</div>
        		</div>
        		<div class="slider-bk">
        			<div class="col-md-2"><@spring.message "result.print.label.wound.width"/></div>
        			<div class="col-md-10">
            			<input type="range" class="slider" data-rangeItem="251" min="0" max="50" step="0.1" >
            			<input type="text" class="slider-value" data-valItem="251" value="0">
        			</div>
        		</div>
        		<div class="slider-bk">
        			<div class="col-md-2"><@spring.message "result.print.label.wound.area"/></div>
        			<div class="col-md-10">
            			<input type="range" class="slider" data-rangeItem="315" min="0" max="300" step="0.1" >
            			<input type="text" class="slider-value" data-valItem="315" value="0">
        			</div>
        		</div>
        		<div class="slider-bk">
        			<div class="col-md-2"><@spring.message "result.print.label.wound.epithelium"/></div>
        			<div class="col-md-10">
            			<input type="range" class="slider" data-rangeItem="445" min="0" max="100" >
            			<input type="text" class="slider-value" data-valItem="445" value="0">
        			</div>
        		</div>
        		<div class="slider-bk">
        			<div class="col-md-2"><@spring.message "result.print.label.wound.granular"/></div>
        			<div class="col-md-10">
            			<input type="range" class="slider" data-rangeItem="446" min="0" max="100" >
            			<input type="text" class="slider-value" data-valItem="446" value="0">
        			</div>
        		</div>
        		<div class="slider-bk">
        			<div class="col-md-2"><@spring.message "result.print.label.wound.slough"/></div>
        			<div class="col-md-10">
            			<input type="range" class="slider" data-rangeItem="447" min="0" max="100" >
            			<input type="text" class="slider-value" data-valItem="447" value="0">
        			</div>
        		</div>
        		<div class="slider-bk">
        			<div class="col-md-2"><@spring.message "result.print.label.wound.eschar"/></div>
        			<div class="col-md-10">
            			<input type="range" class="slider" data-rangeItem="448" min="0" max="100" >
            			<input type="text" class="slider-value" data-valItem="448" value="0">
        			</div>
        		</div>              
            </div>
            <div class="modal-footer">
                <button class="cancelRange func-btn"><@spring.message "modal.button.back"/></button>
                <button class="confirmRange func-btn"><@spring.message "modal.button.update"/></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal12" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:1100px;">
		<div class="modal-content" >
			<div class="modal-header"><@spring.message "modal.label.similar.case"/></div>
			<div class="modal-body">
				<div id="same-case-info" class="row">
					<div class="col-md-5">
						<p><@spring.message "modal.label.similar.caselist"/></p>
						<table class="table table-striped table-bordered bootstrap-datatable similar-case-list">
							<thead>
								<tr class="tablesorter-headerRow">
									<th class="hidden"><@spring.message "modal.column.id"/></th>
									<th width="30%"><@spring.message "modal.column.ptno"/></th>
									<th width="25%"><@spring.message "modal.column.name"/></th>
									<th width="35%"><@spring.message "modal.column.bodypart"/></th>
									<th width="10%"><@spring.message "modal.column.view"/></th>
								</tr>
							</thead>
							<tbody id="case_content">
							</tbody>
						</table>
					</div>
					<div class="col-md-7">
						<p><@spring.message "modal.label.medicine.desc"/></p>
						<div class="stage-blk">
							<span class="stage-color-b"><@spring.message "modal.label.level.eschar"/></span>
							<div class="medical-instr">
								<div class='image_block'>
									<img class='image_container' src='${base}/images/woundInfo/medical/resource/傷口清創凝膠.png' />
									<div class='image_desc'>傷口清創凝膠</div>
	      						</div>
	      						<div class='image_block'>
									<img class='image_container' src='${base}/images/woundInfo/medical/resource/傷口貼.png' />
									<div class='image_desc'>傷口貼</div>
	      						</div>
							</div>
						</div>
						<div class="bottom-arrow"></div>
						<div class="stage-blk">
							<span class="stage-color-y"><@spring.message "modal.label.level.slough"/></span>
							<div class="medical-instr">
								<div class='image_block'>
									<img class='image_container' src='${base}/images/woundInfo/medical/resource/傷口清創凝膠.png' />
									<div class='image_desc'>傷口清創凝膠</div>
	      						</div>
	      						<div class='image_block'>
									<img class='image_container' src='${base}/images/woundInfo/medical/resource/不沾黏高吸收傷口敷料.png' />
									<div class='image_desc'>不沾黏高吸收傷口敷料</div>
	      						</div>
	      						<div class='image_block'>
									<img class='image_container' src='${base}/images/woundInfo/medical/resource/抗生素紗布.png' />
									<div class='image_desc'>抗生素紗布</div>
	      						</div>
							</div>
						</div>
						<div class="bottom-arrow"></div>
						<div class="stage-blk">
							<span class="stage-color-r"><@spring.message "modal.label.level.granular"/></span>
							<div class='image_block'>
								<img class='image_container' src='${base}/images/woundInfo/medical/resource/長肉粉.png' />
								<div class='image_desc'>長肉粉</div>
      						</div>
      						<div class='image_block'>
								<img class='image_container' src='${base}/images/woundInfo/medical/resource/藻酸鈣敷料.jpeg' />
								<div class='image_desc'>藻酸鈣敷料</div>
      						</div>
							<div class='image_block'>
								<img class='image_container' src='${base}/images/woundInfo/medical/resource/不沾黏高吸收傷口敷料.png' />
								<div class='image_desc'>不沾黏高吸收傷口敷料</div>
      						</div>      						
						</div>
						<div class="bottom-arrow"></div>
						<div class="stage-blk">
							<span class="stage-color-p"><@spring.message "modal.label.level.epithelium"/></span>
							<div class='image_block'>
								<img class='image_container' src='${base}/images/woundInfo/medical/resource/傷口凝膠.png' />
								<div class='image_desc'>傷口凝膠</div>
      						</div>
							<div class='image_block'>
								<img class='image_container' src='${base}/images/woundInfo/medical/resource/不沾黏高吸收傷口敷料.png' />
								<div class='image_desc'>不沾黏高吸收傷口敷料</div>
      						</div>
						</div>
					</div>
				 </div>                                                                                                                                                                           
			</div>
			<div class="modal-footer">          
				<button class="case-load func-btn"><@spring.message "modal.button.export"/></button>
				<button class="clean func-btn" data-dismiss="modal"><@spring.message "modal.button.close"/></button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="myModal14" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:800px;">
		<div class="modal-content" >
			<div class="modal-header"><@spring.message "modal.label.symptom.return"/></div>
			<div class="modal-body">
				<table class="eval-table status-info-table">
					<tr class="status-topic">
						<td colspan='6'><i class="fa fa-circle"></i>　<@spring.message "modal.label.wound.symptom"/></td>
					</tr>                                                                                                                                           
					<tr>  																																	                                                                                                                                     
						<td style="width: 200px"><@spring.message "modal.label.question.fever"/></td>                                                                                                                        	 
						<td><label><input type="checkbox" class="evalInput" data-item="555" disabled /> <span><@spring.message "inspect.label.yes"/></span></label></td>                                                                        
						<td colspan='4'><label><input type="checkbox" class="evalInput" data-item="556" disabled /> <span><@spring.message "inspect.label.no"/></span></label></td>  																		 
					</tr>                                                                                                                                                            			
					<tr>  																																	                                                                                                                                    
						<td><@spring.message "modal.label.question.smell"/></td>                                                                                                                   
						<td><label><input type="checkbox" class="evalInput" data-item="557" disabled /> <span><@spring.message "inspect.label.yes"/></span></label></td>                                                                          
						<td colspan='4'><label><input type="checkbox" class="evalInput" data-item="558" disabled /> <span><@spring.message "inspect.label.no"/></span></label></td>  																		 
					</tr>                                                                                                                                                            				
					<tr>  																																	                                                                                                                                       
						<td><@spring.message "modal.label.question.exudate.level"/></td>                                                                                                                   
						<td><label><input type="checkbox" class="evalInput" data-item="559" disabled /> <span><@spring.message "modal.checkbox.dry"/></span></label></td>                                                                          
						<td><label><input type="checkbox" class="evalInput" data-item="560" disabled /> <span><@spring.message "modal.checkbox.small"/></span></label></td>  																		 
						<td><label><input type="checkbox" class="evalInput" data-item="561" disabled /> <span><@spring.message "modal.checkbox.medium"/></span></label></td>  																		 
						<td colspan='2'><label><input type="checkbox" class="evalInput" data-item="562" disabled /> <span><@spring.message "modal.checkbox.large"/></span></label></td>  																		 
					</tr>                                                                                                                                                            	
		           	<tr>  																																	                                                                                                                                         
						<td><@spring.message "modal.label.question.exudate.character"/></td>                                                                                                                   
						<td><label><input type="checkbox" class="evalInput" data-item="563" disabled /> <span><@spring.message "modal.checkbox.none"/></span></label></td>                                                                          
						<td><label><input type="checkbox" class="evalInput" data-item="564" disabled /> <span><@spring.message "modal.checkbox.serum"/></span></label></td>  																		 
						<td><label><input type="checkbox" class="evalInput" data-item="565" disabled /> <span><@spring.message "modal.checkbox.bloody"/></span></label></td>  																		 
						<td><label><input type="checkbox" class="evalInput" data-item="566" disabled /> <span><@spring.message "modal.checkbox.serous.fluid"/></span></label></td>  																		 
						<td><label><input type="checkbox" class="evalInput" data-item="567" disabled /> <span><@spring.message "modal.checkbox.purulent"/></span></label></td>  																		 
					</tr>
					<tr class="status-topic">
						<td colspan='6'><i class="fa fa-circle"></i>　<@spring.message "modal.label.wound.history"/></td>
					</tr>                                                                                                                                                            
					<tr>  																																	                                                                                                                                   
						<td><@spring.message "modal.label.question.non.healing"/></td>                                                                                                                   
						<td><label><input type="checkbox" class="evalInput" data-item="568" disabled /> <span><@spring.message "inspect.label.yes"/></span></label></td>                                                                          
						<td colspan='4'><label><input type="checkbox" class="evalInput" data-item="569" disabled /> <span><@spring.message "inspect.label.no"/></span></label></td>  																		 
					</tr>                                                                                                                                                            			
					<tr>  																																	                                                                                                                                    
						<td><@spring.message "modal.label.question.first.happend"/></td>                                                                                                                   
						<td><label><input type="checkbox" class="evalInput" data-item="570" disabled /> <span><@spring.message "inspect.label.yes"/></span></label></td>                                                                          
						<td colspan='4'><label><input type="checkbox" class="evalInput" data-item="571" disabled /> <span><@spring.message "inspect.label.no"/></span></label></td>  																		 
					</tr>                                                                                                                                                            						
				</table>                                                                                                                                                                             
			</div>
			<div class="modal-footer">          
				<button class="clean func-btn" data-dismiss="modal"><@spring.message "modal.button.close"/></button>
			</div>
		</div>
	</div>
</div>
<!-- add by tk -->
<div class="modal fade" id="myModal15" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:680px;">
	    <div class="modal-content" >
	        <div class="modal-body anal-content">
	        	<div class="load-area hidden">
	        		<a class="isDisabled">
	        		<img src="${base}/images/woundInfo/loading.gif" class="load-img" />
	        		<h4 style="line-height:24px"><@spring.message "modal.label.woundImg.analysing"/></h4>
	        		</a>
	        	</div>
	        	<div class="anal-area">        
	        		<span><@spring.message "modal.label.wound.area"/></span>
	        		<img id="myimg" class="hidden" style="width:100%;height:100%;" />
	        		
	        		<div id="tCanvas" style="width:640px;height:480px;background-size:contain;  background-repeat: no-repeat; background-position: center;"> 
						<canvas id="tSketchPad" width="640px" height="480px" style="position:absolute;border: 2px solid gray; z-index:100" ></canvas> 				
					</div>
					
					<img id="newimg" class="hidden" style="width:640px;height:480px;background-size:contain;  background-repeat: no-repeat; background-position: center;"/>  
	        	</div>
	        	              
	        </div>
	        <div class="modal-footer" Style="text-align:center">    
	        <div id="dLine" class="optionContainer" ></div><br>	
	                        <@spring.message "modal.label.funcItems"/>
	            <input  type="radio" name="Paintfunctions" value="1" checked><@spring.message "modal.label.clean"/>
	            <input  type="radio" name="Paintfunctions" value="3"> <@spring.message "modal.label.epithelium"/>
	            <input  type="radio" name="Paintfunctions" value="4"> <@spring.message "modal.label.granular"/>
	            <input  type="radio" name="Paintfunctions" value="5"> <@spring.message "modal.label.slough"/>
	            <input  type="radio" name="Paintfunctions" value="6"> <@spring.message "modal.label.eschar"/>
	                      
	         <br>
	         <br>
	        	<button class="func-btn" onclick="calculate()"><@spring.message "modal.button.calculate"/></button>
				<button id="HideBtn" class="func-btn" onclick="HideCanvas();" ><@spring.message "modal.button.hide.tag"/></button>
	        	<button class="func-btn" onclick="leaveModal15()"><@spring.message "modal.button.cancel.and.finish"/></button>
	        </div>
	    </div>
	</div>
</div>
<!-- add by tk -->
<div class="modal fade" id="myModal18" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:850px;">
		<div class="modal-content" >
			<div class="modal-header">
				<@spring.message "modal.label.physiological.measurement.trends.chart"/>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          	<i class="fa fa-xmark" aria-hidden="true"></i>
		        </button>
			</div>
			<div class="modal-body">				
				<div class="show-hint"><@spring.message "modal.label.chart.generating"/></div>
				<div class="cnt-template hidden">
					<div class="func collapse in" id="mix_chart">
						<div class="card card-body mixChart-blk">
							<canvas width='700' height='280' class='mixChart'></canvas>
							<table class="table table-striped table-bordered bootstrap-datatable mix-list">
								<thead>
									<tr class="tablesorter-headerRow">
										<th><@spring.message "modal.column.evalDate"/></th>
										<th><@spring.message "modal.column.temperature"/></th>
										<th><@spring.message "modal.column.heartbeat"/></th>
										<th><@spring.message "modal.column.systolic.pressure"/></th>
										<th><@spring.message "modal.column.diastolic.perssure"/></th>													
									</tr>
								</thead>
								<tbody id="mix_content">
								</tbody>
							</table>
						</div>
					</div>
					<div class="func collapse" id="temp_chart">
						<div class="card card-body tempChart-blk">
							<canvas width='700' height='280' class='tempChart'></canvas>
							<table class="table table-striped table-bordered bootstrap-datatable temp-list">
								<thead>
									<tr class="tablesorter-headerRow">
										<th><@spring.message "modal.column.evalDate"/></th>
										<th><@spring.message "modal.column.temperature"/></th>
										<th><@spring.message "modal.column.result"/></th>							
									</tr>
								</thead>
								<tbody id="temp_content">
								</tbody>
							</table>
						</div>
					</div>
					<div class="func collapse" id="bpm_chart">
						<div class="card card-body bpmChart-blk">
							<canvas width='700' height='280' class='bpmChart'></canvas>
							<table class="table table-striped table-bordered bootstrap-datatable bpm-list">
								<thead>
									<tr class="tablesorter-headerRow">
										<th><@spring.message "modal.column.evalDate"/></th>
										<th><@spring.message "modal.column.heartbeat"/></th>
										<th><@spring.message "modal.column.result"/></th>						
									</tr>
								</thead>
								<tbody id="bpm_content">
								</tbody>
							</table>
						</div>
					</div>
					<div class="func collapse" id="pressure_chart">
						<div class="card card-body pressureChart-blk">
							<canvas width='700' height='280' class='pressureChart'></canvas>
							<table class="table table-striped table-bordered bootstrap-datatable pressure-list">
								<thead>
									<tr class="tablesorter-headerRow">
										<th><@spring.message "modal.column.evalDate"/></th>
										<th><@spring.message "modal.column.systolic.pressure"/></th>
										<th><@spring.message "modal.column.diastolic.perssure"/></th>
										<th><@spring.message "modal.column.result"/></th>
									</tr>
								</thead>
								<tbody id="pressure_content">
								</tbody>
							</table>
						</div>
					</div>
				</div>	              
			</div>
			<div class="modal-footer">            
				<button class="clean func-btn" data-dismiss="modal" data-form="3"><@spring.message "modal.button.close"/></button>
			</div>
		</div>
	</div>
</div>
<!-- modal template -->

<script>
var angle = 0;

$(".png-upload").click(function () {
	html2canvas(document.querySelector("#capture"), {
	  onclone: function (content) {
	  	
	  },
	  scrollX: 0,
      scrollY: 0
	  //scrollY: -window.scrollY
	}).then(function(canvas) {
		Canvas2Image.saveAsPNG(canvas, "<@spring.message "modal.label.report.file.name"/>");
    });
});

$(".case-load").click(function () {
	html2canvas(document.querySelector("#same-case-info"), {
	  onclone: function (content) {
	  	
	  },
	  scrollX: 0,
      scrollY: 0
	}).then(function(canvas) {
		Canvas2Image.saveAsPNG(canvas, "<@spring.message "modal.label.similar.case.file.name"/>");
    });
});

//開通憑證
function goValid(){
	window.open("https://140.96.170.74:8007/WoundService/api/v1.0/model_name");
}

//前往傷口數據調整畫面
function changeParam(){
	//$("#myModal8").modal('hide');
	
	var targetArr = [250,251,315,445,446,447,448];
	for(var i=0; i<targetArr.length; i++){
		var itemValue = $(".anal-area").find("[data-item='" + targetArr[i] + "']").val();
		$(".slider-grp").find("[data-rangeItem='" + targetArr[i] + "']").val(itemValue);
		$(".slider-grp").find("[data-valItem='" + targetArr[i] + "']").val(itemValue);
	}
	
	$("#myModal11").modal('show');

}

$('.slider').on('input', function() {
  	var value = $(this).val();
  	$(this).next("input[type='text']").val(value);
});

$('.slider-value').on('input', function() {
  	var value = $(this).val();
  	$(this).prev("input[type='range']").val(value);
});

//返回AI分析畫面
$('.cancelRange').click(function () {
    $("#myModal11").modal('hide');
    $("#myModal8").modal('show'); 
});

//更新調整後的傷口數據
$('.confirmRange').click(function () {
    $("#myModal11").modal('hide');
    
    var targetArr = [250,251,315,445,446,447,448];
	for(var i=0; i<targetArr.length; i++){
		var itemValue = $(".slider-grp").find("[data-valItem='" + targetArr[i] + "']").val();
		$(".anal-area").find("[data-item='" + targetArr[i] + "']").val(itemValue);
	}
	
    //$("#myModal8").modal('show'); 
});

//本地上傳傷口照片圖檔
function uploadImage(keyno){
	var fileData = $(".uploadFile").get(0).files;
	var fileLeng = fileData.length;
	//
	if(fileLeng > 0){
		for(var i=0; i < fileLeng; i++){
			(function(i){
		        asyncTask(fileData[i], keyno).done(function(res, status, jqXHR) {
		        	var resObj = JSON.parse(res);
		        	if(resObj.success){	
						fileLeng--;
		            	if(fileLeng === 0){
		            		setTimeout(function(){
		            			refreshChart();
								swal("<@spring.message "modal.label.upload.success.title"/>", "<@spring.message "modal.label.upload.success.text"/>", "success");
		            		},200);
		            	}
		        	}
				});
			})(i);	
		}		
    }   
}

function asyncTask(obj, keyno){
	var dfd = $.Deferred();
	var formInfo = new FormData();
	formInfo.append("userFormKeyNo", keyno);
	formInfo.append("userId", ${currentUser.id!""});
	formInfo.append("myImg", obj);
	formInfo.append("location", "${__filed!""}");
    
    var res = $.ajax({
        url: "${base}/division/api/localUploadPhoto",
        type: "POST",
        data: formInfo,
        contentType: false,
        cache: false,
        processData:false,
        success: function(data){

        }
    });
    return res.promise();
}

function resetOrder(serialNo){
	var keyno = $(".info-card").find("input[type=hidden]").val();
	var beginDate = $(".left-nav li.active a").html();
	var orderData = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getOrderByKeyno?keyno=" + keyno + "&beginDate=" + beginDate);
	$("#tabInfo" + serialNo).find(".final-command.new").val(orderData.order);
	//
	$("#tabInfo" + serialNo).find(".send-order").click(function() {
		var keyno = $(".info-card").find("input[type=hidden]").val();
		var itemKeyno = $(".record-list").find(".highlight").attr("data-keyno");
		var order = $(this).closest("div").find("textarea").val();	
		var postData = {"keyno": keyno, "examItemKeyno": itemKeyno, "order": order, "evalDate": getTodate()};
    	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/writeOrder");
    	if(result.success){
    		swal("<@spring.message "modal.label.order.send.success.title"/>","<@spring.message "modal.label.order.send.success.text"/>", "success");
    	}
	});
}

//立即儲存表單資料(20220103更新)
function saveEvalFormValue(className, recordno, itemNum){
	var newArray = [];
	var obj;
	var target = $(".collapse-content[data-recordno='" + recordno +  "'").find("." + className + "[data-item='" + itemNum + "']");
	if(target.is("input[type='checkbox']")){
		//專屬多選選項情況
		if(target.closest('tr').length == 0 || target.closest('tr').hasClass("multi-chk")){
       		if(target.prop('checked')){
       			obj = {"itemId": itemNum, "ans": target.next("span").html(), "op": "e"};
       		}
       		else{
       			obj = {"itemId": itemNum, "ans": "", "op": "r"};
       		}
       		newArray.push(obj);
		}
		
		//若非多選情況下
		if(!target.closest('tr').hasClass("multi-chk")){
			//若沒有標示single-chk情況下
			if(!target.closest('tr').hasClass("single-chk")){			
			    target.closest('tr').find('input[type="checkbox"]').each(function(){
			    	var itemId = $(this).data('item');
		       		if($(this).prop('checked')){
		       			obj = {"itemId": itemId, "ans": target.next("span").html(), "op": "e"};
		       		}
		       		else{
		       			obj = {"itemId": itemId, "ans": "", "op": "r"};
		       		}
		       		newArray.push(obj);
			    });
		    }
		    else{		    	
		    	target.closest('table').find("tr").each(function(){
		    		if($(this).hasClass('single-chk')){
		    			$(this).find('input[type="checkbox"]').each(function(){
					       	var itemId = $(this).data('item');
					       	if($(this).prop('checked')){
				       			obj = {"itemId": itemId, "ans": target.next("span").html(), "op": "e"};
				       		}
				       		else{
				       			obj = {"itemId": itemId, "ans": "", "op": "r"};
				       		}
				       		newArray.push(obj);
					    });					    
		    		}
		    	});
		    }   
		}		
	}
	else{
		obj = {"itemId": itemNum, "ans": target.val(), "op": "e"};
		newArray.push(obj);
	}
	
	return newArray;
}

//設置傷口評估表單欄位值
function setEvalFormValue(divClassName, className, result){
	var savedArray = [];

	result.filter(function(obj) {		
		if(obj.exist){
			var target = $("." + divClassName + ".active").find("." + className + "[data-item='" + obj.itemId + "']");
			if(target.is("input[type='checkbox']")){
				target.attr('data-checked', true);
				target.prop('checked', true).trigger('change');
			}
			else{
				target.val(obj.ans);
			}
			savedArray.push(obj.itemId);
		}
	});
	
}

//取得新增潛行深洞紀錄與醫囑處置欄位值
function createFormValue(obj, start, end){
	var newArray = [];
	var item;	
	for(var i = start; i<= end; i++){
		var target = $(obj).closest("tr").find("[data-item='" + i + "']");
		if(target.val() != ""){
			item = {"itemId": i, "ans": target.val()};
			newArray.push(item);
		}		
	}
	return newArray;
}

//取得潛行深洞紀錄與醫囑處置欄位值進行編輯/刪除動作
function getFormValue(obj, order, start, end){
	var newArray = [];
	var item;	
	for(var i = start; i<= end; i++){
		var target = $(obj).closest("tr").find("[data-item='" + i + "']");
		if(target.val() != ""){
			item = {"itemId": i, "ans": target.val(), "op": order};
			newArray.push(item);
		}		
	}
	return newArray;
}

//設定欲取值之對應data-item
function getItemsArray(start, end){
	var newArray = [];
	for(var i = start; i<= end; i++){		
		newArray.push(i);
	}
	return newArray;
}

//設置傷口症狀及傷口史資訊
function setStatusInfo(targetClassName, className, obj){
	var inputLength = obj.length;
	for(var i=0; i < inputLength; i++){
		$("." + targetClassName).find("." + className).each(function(){
			if(obj[i].itemId == $(this).data('item') && obj[i].exist){
				$(this).prop('checked', true).trigger('change');								
			}
		})
	}
	/*$("." + targetClassName).find("." + className).each(function(){	
		console.log($(this).data('item'));	
		for(var i=0; i < inputLength; i++){
			console.log("itemId：" + obj[i].itemId);		
			if($(this).data('item') == obj[i].itemId && obj[i].exist){
				if($(this).is("input[type='checkbox']")){
					$(this).prop('checked', true).trigger('change');
					break;
				}							
			}
		}
		//break;		
	});*/

}

//確認複製歷史檢測項目與患部紀錄
function confirmCopy(){
	var keyno = $(".info-card").find("input[type=hidden]").val();
	var evalDate = $(".copy-date").val();
	var chkLeng = $(".item-chk:checked").length;
	var createEvalFormlist = [];
	if(evalDate != "" && chkLeng > 0){
		$(".item-chk:checked").each(function(){
			var item = {"creatorId":${currentUser.id!""}, "formName": "檢測項目V2", "evalDate": evalDate + " 00:00:00", "app": keyno, "items": [{"itemId": 247, "ans": $(this).attr('data-bodypart')},{"itemId": 249, "ans": "N"},{"itemId": 697, "ans": $(this).attr('data-deviceNo')}]};
			createEvalFormlist.push(item);
		});
		var postData = {"CreateEvalFormViewList": createEvalFormlist};
		var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/copyHistoryItemRecord?location=${__field}");
		if(result.success){
			$(".selectAll, .item-chk").prop('checked', false);
			$(".copy-date").val("");
			$(".refresh").click();			
			swal("<@spring.message "modal.label.copy.success.title"/>","<@spring.message "modal.label.copy.success.text"/>", "success");
		}
	}
	else{
		swal("<@spring.message "modal.label.copy.fail.title"/>","<@spring.message "modal.label.copy.fail.text"/>", "warning");
	}
}

//刪除檢測項目與患部紀錄
function delItemRecord(){
	var keyno = $(".info-card").find("input[type=hidden]").val();
	var postData = {"userFormKeyNo": $(".delNo").val()};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/removeUserForm?");
	//
	if(result.success && keyno != ""){
		showItemTable(keyno);
		refreshContent();	
    	finishDelLocInfo();
	}
}

//完成刪除項目與患部紀錄觸發
function finishDelLocInfo(){
	setTimeout(function(){
		$("#myModal4").modal('hide');
		//待補彈跳視窗
	},500);
}

//片語選擇功能專用
function createOpt(objName, result){
	var target = $("select[name='" + objName + "']");
	$("textarea[name='content']").val("");
	target.find('option').not(':first').remove();
	for(var i=0; i<result.length; i++){
		target.append("<option value='" + result[i].id + "'>" + result[i].cat + "</option>");
	}
}

</script>