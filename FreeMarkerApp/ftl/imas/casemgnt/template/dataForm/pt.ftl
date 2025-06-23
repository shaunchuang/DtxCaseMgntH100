<#import "/util/spring.ftl" as spring />
  
<div id="data-content">	<div class="row mg-b-10">
		<div class="col-md-12">
			<label class="form-label">主要問題描述</label>
			<textarea rows="3" id="mainIssueDesc" class="form-control"></textarea>
		</div>								
	</div>
	<div class="row mg-b-10">
		<div class="col-md-3">
			<label class="form-label">教育程度</label>
			<select id="educationLevel" class="dataForm form-control" data-item="">
				<option value="">請選擇</option>
				<option value="幼稚園">幼稚園</option>
				<option value="托兒所">托兒所</option>
				<option value="國小">國小</option>
				<option value="國中">國中</option>
				<option value="高中(職)">高中(職)</option>
				<option value="專科">專科</option>
				<option value="大學">大學</option>
				<option value="研究所以上">研究所以上</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">接受學前教育經驗</label>
			<select id="preeducationExp" class="dataForm form-control" data-item="">
				<option value="">請選擇</option>
				<option value="N">無</option>
				<option value="Y">有</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">父親教育程度</label>
			<select id="fatherEducation" class="dataForm form-control" data-item="" >
				<option value="">請選擇父親教育程度</option>
				<option value="不識字">不識字</option>
				<option value="國小">國小</option>
				<option value="國中">國中</option>
				<option value="高中(職)">高中(職)</option>
				<option value="專科">專科</option>
				<option value="大學">大學</option>
				<option value="研究所以上">研究所以上</option>
			</select>										
		</div>
		<div class="col-md-3">
			<label class="form-label">母親教育程度</label>
			<select id="motherEducation" class="dataForm form-control" data-item="" >
				<option value="">請選擇母親教育程度</option>
				<option value="不識字">不識字</option>
				<option value="國小">國小</option>
				<option value="國中">國中</option>
				<option value="高中(職)">高中(職)</option>
				<option value="專科">專科</option>
				<option value="大學">大學</option>
				<option value="研究所以上">研究所以上</option>
			</select>										
		</div>
	</div>	<div class="row mg-b-10">
		<div class="col-md-3">
			<label class="form-label">父親職業別</label>
			<select id="fatherOccupation" class="dataForm form-control" data-item="" >
				<option value="">請選擇父親職業別</option>
				<option value="學生">學生</option>
				<option value="軍公教">軍公教</option>
				<option value="醫務人員">醫務人員</option>
				<option value="金融保險業">金融保險業</option>
				<option value="服務業">服務業</option>
				<option value="資訊業">資訊業</option>
				<option value="電子業">電子業</option>
				<option value="營造業">營造業</option>
				<option value="商業">商業</option>
				<option value="大眾傳播">大眾傳播</option>
				<option value="其他">其他</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">母親職業別</label>
			<select id="motherOccupation" class="dataForm form-control" data-item="" >
				<option value="">請選擇母親職業別</option>
				<option value="學生">學生</option>
				<option value="軍公教">軍公教</option>
				<option value="醫務人員">醫務人員</option>
				<option value="金融保險業">金融保險業</option>
				<option value="服務業">服務業</option>
				<option value="資訊業">資訊業</option>
				<option value="電子業">電子業</option>
				<option value="營造業">營造業</option>
				<option value="商業">商業</option>
				<option value="大眾傳播">大眾傳播</option>
				<option value="其他">其他</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">家庭主要使用語言</label>
			<select id="familyLanguage" class="dataForm form-control" data-item="" >
				<option value="">請選擇主要語言</option>
				<option value="國語">國語</option>
				<option value="閩南語">閩南語</option>
				<option value="客家語">客家語</option>
				<option value="其他">其他</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">有無發展遲緩或身心障礙</label>
			<select id="developmentalDelay" class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="無">無</option>
				<option value="有">有</option>
			</select>
		</div>
	</div>	<div class="row mg-b-10">
		<div class="col-md-3">
			<label class="form-label">有無疑似語言發展問題</label>
			<select id="suspectedSpeechIssues" class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="無">無</option>
				<option value="有">有</option>
			</select>
		</div>
		<div class="col-md-9">
			<label class="form-label">語言發展問題(複選)</label>
			<div class="speech-dev-issue-options multi-option">
				<div class="option" data-item="1">構音異常</div>
				<div class="option" data-item="2">聲調異常</div>
				<div class="option" data-item="3">聲音異常</div>
				<div class="option" data-item="4">語暢異常</div>
				<div class="option" data-item="5">語調異常</div>
				<div class="option" data-item="6">語言理解困難</div>
				<div class="option" data-item="7">口語表達困難</div>
				<div class="option" data-item="8">無語言</div>
			</div>
		</div>
	</div>
	<div class="row mg-b-10">
		<div class="col-md-3">
			<label class="form-label">溝通方式</label>
			<select id="communicationMtd" class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="口語溝通">口語溝通</option>
				<option value="書寫">書寫</option>
				<option value="手語/手勢">手語/手勢</option>
				<option value="圖卡溝通">圖卡溝通</option>
				<option value="溝通輔具(如VOCA、iPad)">溝通輔具(如VOCA、iPad)</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">吞嚥困難程度</label>
			<select id="swallowDifficulty" class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="無困難">無困難</option>
				<option value="輕度嗆咳">輕度嗆咳</option>
				<option value="中度吞嚥困難">中度吞嚥困難</option>
				<option value="嚴重吞嚥困難">嚴重吞嚥困難</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">理解能力</label>
			<select id="comprehensionAbility" class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="完全理解">完全理解</option>
				<option value="理解簡單語句">理解簡單語句</option>
				<option value="僅理解單字或關鍵詞">僅理解單字或關鍵詞</option>
				<option value="幾乎無法理解">幾乎無法理解</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">表達能力</label>
			<select id="expressionAbility" class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="能清楚表達完整句子">能清楚表達完整句子</option>
				<option value="僅能表達單字/詞語">僅能表達單字/詞語</option>
				<option value="非語言表達為主(如點頭、手勢)">非語言表達為主(如點頭、手勢)</option>
				<option value="幾乎無法表達">幾乎無法表達</option>
			</select>
		</div>
	</div>
	<div class="row mg-b-10">
		<div class="col-md-12">
			<label class="form-label">主關陳述/自述困難(個案/家屬)</label>
			<textarea rows="3" id="difficultyDesc" class="form-control"></textarea>
		</div>								
	</div>
	<div class="row mg-b-10">
		<div class="col-md-12">
			<label class="form-label">其他備註</label>
			<textarea rows="3" id="otherRemarks" class="form-control"></textarea>
		</div>								
	</div>
	
	<style>

	</style>
</div>
