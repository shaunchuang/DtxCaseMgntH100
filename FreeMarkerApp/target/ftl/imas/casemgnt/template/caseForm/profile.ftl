<#import "/util/spring.ftl" as spring />

  
<div id="content">
	<div class="card pd-10">		<div class="row mg-b-10">
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
		</div>		<div class="row mg-b-10">
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
		</div>		<div class="row mg-b-10">
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
						<input type="text" name="country" placeholder="<@spring.message "view.placeholder.country"/>" class="dataForm form-control half" data-item="9">
						<input type="text" name="city" placeholder="<@spring.message "view.placeholder.capital"/>" class="dataForm form-control half" data-item="10">
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
						</#list>				            				    </div>
                <textarea id="otherHistoryDisease" rows="2" class="form-control" placeholder="請填寫其他個人病史"></textarea>
			</div>
		</div>
		<div class="row mg-b-10">
			<div class="col-md-12">
				<label class="form-label">藥物過敏史</label>
					<div class="allergy-history-options multi-option">
						<#list drugAllergyHistoryItems as dahItems>
							<div class="option<#if ptInfo.medicalHistory?seq_contains(dahItems.id?string)> selected</#if>" data-item="${dahItems.id}" >${dahItems.name}</div>
						</#list>					</div>
				<textarea id="otherMedicalHistory" rows="2" class="form-control" placeholder="請填寫其他藥物過敏史"></textarea>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<label class="form-label">藥物使用狀況</label>
					<div class="drug-use-status-options multi-option">
						<#list drugUseStatus as dus>
							<div class="option<#if ptInfo.drugUsageHistory?seq_contains(dus.id?string)> selected</#if>" data-item="${dus.id}" >${dus.name}</div>
						</#list>					</div>
				<textarea id="otherDrugUsageHistory" rows="2" class="form-control" placeholder="請填寫其他藥物使用狀況"></textarea>
			</div>
		</div>					
	</div>
	<script>
	var patientInfo = ${patientInfo!""};
	console.log('patientInfo:', patientInfo);
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
		setTimeout(function() {
			fillPatientInfo();
		}, 500);
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

		$('#otherHistoryDisease').val(patientInfo.otherDiseaseName || "");
		$('#otherMedicalHistory').val(patientInfo.otherMedicalHistory || "");
		$('#otherDrugUsageHistory').val(patientInfo.otherDrugUsageHistory || "");

        // === 自動填入 dataForm/pt.ftl 相關欄位 (otherPatientInfo) ===
        if (patientInfo.otherPatientInfoDTO) {
			
            console.log('正在自動填入其他患者資料:', patientInfo.otherPatientInfoDTO);
            const otherInfo = patientInfo.otherPatientInfoDTO;

            // 主要問題描述
            $('#mainIssueDesc').val(otherInfo.mainIssueDesc || "");
            
            // 教育和職業資訊
            $('#educationLevel').val(otherInfo.educationLevel || "");
            $('#occupation').val(otherInfo.occupation || "");
            $('#preeducationExp').val(otherInfo.preeducationExp || "");
            
            // 家庭教育程度
            $('#fatherEducation').val(otherInfo.fatherEducation || "");
            $('#motherEducation').val(otherInfo.motherEducation || "");
            
            // 家庭職業
            $('#fatherOccupation').val(otherInfo.fatherOccupation || "");
            $('#motherOccupation').val(otherInfo.motherOccupation || "");
            
            // 家庭語言
            $('#familyLanguage').val(otherInfo.familyLanguage || "");
            
            // 發展和語言問題
            $('#developmentalDelay').val(otherInfo.developmentalDelay || "");
            $('#suspectedSpeechIssues').val(otherInfo.suspectedSpeechIssues || "");
            
            // 語言發展問題(複選) - speechDevIssues 是陣列
            if (otherInfo.speechDevIssues && Array.isArray(otherInfo.speechDevIssues)) {
				console.log('語言發展問題:', otherInfo.speechDevIssues);
                $('.speech-dev-issue-options .option').removeClass('selected');
                otherInfo.speechDevIssues.forEach(function(id) {
                    $('.speech-dev-issue-options .option[data-item="' + id + '"]').addClass('selected');
                });
            }
            
            // 溝通和表達能力
            $('#communicationMtd').val(otherInfo.communicationMtd || "");
            $('#swallowDifficulty').val(otherInfo.swallowDifficulty || "");
            $('#comprehensionAbility').val(otherInfo.comprehensionAbility || "");
            $('#expressionAbility').val(otherInfo.expressionAbility || "");
              // 困難描述和備註
            $('#difficultyDesc').val(otherInfo.difficultyDesc || "");
            $('#otherRemarks').val(otherInfo.otherRemarks || "");
            
            // === ps.ftl 相關欄位 ===
            // 情緒與心理狀態
            $('#psychologicalState').val(otherInfo.psychologicalState || "");
            
            // 最近生活壓力事件
            $('#recentStressEvents').val(otherInfo.recentStressEvents || "");
            
            // 家庭支持程度
            $('#familySupportLevel').val(otherInfo.familySupportLevel || "");
            
            // 心理治療相關
            $('#psychologicalTreatment').val(otherInfo.psychologicalTreatment || "");
            $('#treatmentDetails').val(otherInfo.treatmentDetails || "");
            
            // 風險評估
            $('#suicidalThoughts').val(otherInfo.suicidalThoughts || "");
            $('#selfHarmBehavior').val(otherInfo.selfHarmBehavior || "");
            
            console.log('其他患者資料填入完成');
        }
        
        console.log('患者資料填入完成');
    } else {
        console.warn('patientInfo 資料不存在或格式不正確');
    }
}

	
	</script>
</div>
