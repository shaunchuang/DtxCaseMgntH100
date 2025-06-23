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
			<label class="form-label">職業別</label>
			<select id="occupation" class="dataForm form-control" data-item="" >
				<option value="">請選擇職業別</option>
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
