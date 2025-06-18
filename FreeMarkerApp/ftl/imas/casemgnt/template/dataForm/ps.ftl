<#import "/util/spring.ftl" as spring />
  
<div id="data-content">
	<div class="row mg-b-10">
		<div class="col-md-12">
			<label class="form-label">主要問題描述</label>
			<textarea rows="3" class="form-control"></textarea>
		</div>								
	</div>
	<div class="row mg-b-10">
		<div class="col-md-3">
			<label class="form-label">情緒與心理狀態</label>
			<select class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="憂鬱/情緒低落">憂鬱/情緒低落</option>
				<option value="焦慮/容易緊張">焦慮/容易緊張</option>
				<option value="睡眠困難/多夢">睡眠困難/多夢</option>
				<option value="無法專注">無法專注</option>
				<option value="社交退縮">社交退縮</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">最近生活壓力事件</label>
			<select class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="家庭衝突">家庭衝突</option>
				<option value="工作/經濟困難">工作/經濟困難</option>
				<option value="親人離世">親人離世</option>
				<option value="感情/婚姻困擾">感情/婚姻困擾</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">家庭支持程度</label>
			<select class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="很好">很好</option>
				<option value="普通">普通</option>
				<option value="不足">不足</option>
			</select>
		</div>								
	</div>
	<div class="row mg-b-10">
		<div class="col-md-6">
			<label class="form-label">是否曾接受心理治療</label>
			<div class="inline-cotainer">
				<select class="dataForm form-control w-100" data-item="" >
					<option value="">請選擇</option>
					<option value="否">否</option>
					<option value="是">是</option>
				</select>
				<input type="text" class="dataForm form-control" data-item="11" placeholder="簡述時間與原因" readonly="">
			</div>
		</div>
		<div class="col-md-3">
			<label class="form-label">是否曾有自殺想法？</label>
			<select class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="從未">從未</option>
				<option value="偶爾">偶爾</option>
				<option value="經常">經常</option>
			</select>
		</div>
		<div class="col-md-3">
			<label class="form-label">是否曾有自傷行為？</label>
			<select class="dataForm form-control" data-item="" >
				<option value="">請選擇</option>
				<option value="無">無</option>
				<option value="有">有</option>
			</select>
		</div>
	</div>
	<div class="row mg-b-10">
		<div class="col-md-12">
			<label class="form-label">主關陳述/自述困難(個案/家屬)</label>
			<textarea rows="3" class="form-control"></textarea>
		</div>								
	</div>
	<div class="row mg-b-10">
		<div class="col-md-12">
			<label class="form-label">其他備註</label>
			<textarea rows="3" class="form-control"></textarea>
		</div>								
	</div>
	
	<style>

	</style>
</div>
