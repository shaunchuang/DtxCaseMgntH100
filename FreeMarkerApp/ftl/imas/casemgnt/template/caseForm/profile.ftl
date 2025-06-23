<#import "/util/spring.ftl" as spring />

  
<div id="content">
	<div class="card pd-10">
		<div class="row mg-b-10">
			<div class="col-md-3">
				<label class="form-label"><@spring.message "view.label.name"/></label>
				<input type="text" class="dataForm form-control" data-item="3" readonly="">
			</div>
			<div class="col-md-3">
				<label class="form-label"><@spring.message "view.label.gender"/></label>
				<select class="dataForm form-control" data-item="4" disabled>
					<option value=""><@spring.message "view.option.select.hint"/></option>
					<option value="M" <#if ptInfo.gender == "M">selected</#if>><@spring.message "view.option.male"/></option>
					<option value="F" <#if ptInfo.gender == "F">selected</#if>><@spring.message "view.option.female"/></option>
				</select>
			</div>
			<div class="col-md-3">
				<label class="form-label"><@spring.message "view.label.ptno"/></label>
				<input type="text" class="dataForm form-control" data-item="1" readonly="">
			</div>
			<div class="col-md-3">
				<label class="form-label">身分證字號</label>
				<input type="text" class="dataForm form-control" data-item="2" readonly="">
			</div>
		</div>
		<div class="row mg-b-10">
			<div class="col-md-3">
				<label class="form-label">出生日期</label>
				<input type="hidden" class="dataForm form-control birth" data-item="6" data-date-end-date="0d" />
			</div>
			<div class="col-md-3">
				<label class="form-label">聯絡電話</label>
				<input type="text" class="dataForm form-control" data-item="7" readonly="">
			</div>
			<div class="col-md-3">
				<label class="form-label">緊急聯絡人</label>
				<div class="inline-cotainer">
					<input type="text" class="dataForm form-control" data-item="12" readonly="">
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
			</div>
			<div class="col-md-3">
				<label class="form-label">緊急聯絡電話</label>
				<input type="text" class="dataForm form-control" data-item="14" readonly="">
			</div>								
		</div>
		<div class="row mg-b-10">
			<div class="col-md-3">
				<label class="form-label">電子信箱</label>
				<input type="text" class="dataForm form-control" data-item="8" readonly="">
			</div>
			<div class="col-md-3">
				<label class="form-label">婚姻狀態</label>
				<select class="dataForm form-control" data-item="" disabled>
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
						<input type="text" name="country" placeholder="<@spring.message "view.placeholder.country"/>" class="dataForm form-control half" data-item="9">
						<input type="text" name="city" placeholder="<@spring.message "view.placeholder.capital"/>" class="dataForm form-control half" data-item="10">
					</div>
					</#if>
					<input type="text" class="dataForm form-control" data-item="11" readonly="">
				</div>
			</div>
		</div>
		<div class="row mg-b-10">
			<div class="col-md-12">
				<label class="form-label">個人病史</label>
				<div class="history-options multi-option">
					<#list personalDiseaseHistoryItems as pdhItems>
					<div class="option option--disabled <#if ptInfo.medicalHistory?seq_contains(pdhItems.name)>selected</#if>" data-item="${pdhItems.id}" >${pdhItems.name}</div>
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
				<textarea rows="2" class="form-control" placeholder="請填寫其他藥物使用狀況"></textarea>
			</div>
		</div>					
	</div>
	<script>
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
	});

	
	</script>
</div>
