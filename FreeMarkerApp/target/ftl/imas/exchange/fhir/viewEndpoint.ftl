<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<#if isNewForm?? >
					<div class="item-name">EndPoint建檔</div>
					<#else>
					<div class="item-name">Endpoint總覽</div>
					</#if>
				</div>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<form class="form" id="endpointForm" action="${base}/division/api/fhir/endpoint/save" method="POST">
					<@spring.bind "endpointView" />
					<#-- Default -->
					<input type="hidden" name="name" value="dicom-web">
					<input type="hidden" name="metaView.profiles[0]" value="https://hapi.fhir.tw/fhir/StructureDefinition/MitwEndpoint">
				    <input type="hidden" name="connectionTypeDisplay" value="DICOM">
				    <input type="hidden" name="payloadMimeTypes[0]" value="application/dicom">
				    <input type="hidden" name="payloadTypeText" value="DICOM">
				<table class="default-table">				
					<tr>
						<td>流水編號(ID)：</td>
						<td colspan="3">
							<input type="text" id="serialNo" class="form-control" placeholder="由系統自動產生" disabled=disabled />
						</td>
					</tr>
					<tr>
						<td>EndPoint 網址：</td>
						<td>
							<@spring.formInput path="endpointView.address" attributes='class="form-control" placeholder="DICOM Server網址" ' />
						</td>
						<td>狀態：</td>
						<td>
						    <select id="status" name="status" class="form-control" >
						        <option value="">請選擇</option>
								<option value="ACTIVE" <#if endpointView.status?? && endpointView.status == 'ACTIVE'>selected=true</#if>>使用中</option>
								<option value="SUSPENDED" <#if endpointView.status?? && endpointView.status == 'SUSPENDED'>selected=true</#if>>暫停使用</option>
								<option value="ERROR" <#if endpointView.status?? && endpointView.status == 'ERROR'>selected=true</#if>>錯誤</option>
								<option value="OFF" <#if endpointView.status?? && endpointView.status == 'OFF'>selected=true</#if>>已下線</option>
								<option value="ENTERED-IN-ERROR" <#if endpointView.status?? && endpointView.status == 'ENTERED-IN-ERROR'>selected=true</#if>>錯誤紀錄</option>
								<option value="TEST" <#if endpointView.status?? && endpointView.status == 'TEST'>selected=true</#if>>測試用</option>
						    </select>
						</td>
					</tr>
					<tr>
						<td>連線狀態：</td>
						<td>
						    <select id="connectionType" name="connectionTypeCode" class="form-control param" >
						        <option value="">請選擇</option>
						        <option value="dicom-wado-rs"<#if endpointView.connectionTypeCode?? && endpointView.connectionTypeCode == 'dicom-wado-rs'>selected=true</#if>>DICOM-WADO-RS</option>
						        <option value="dicom-wado-uri"<#if endpointView.connectionTypeCode?? && endpointView.connectionTypeCode == 'dicom-wado-uri'>selected=true</#if>>DICOM-WADO-URI</option>
						    </select>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="footer-btn-list">
								<button onclick="submitForm(event, this)"><i class="fa fa-save"></i> 儲存</button>
							</div>	
						</td>
					</tr>					
				</table>
			</div>
		</div>	
	</div>
</body>

<script>

$(document).ready(function(){
    payloadTextChange()
});

function submitForm(e, obj){
	e.preventDefault();
	
	// 找到最近的表單元素
	var form = $(obj).closest('form');
	
	// 創建空的 postData 對象
	var postData = {};
	
	// 遍歷表單中的每個輸入字段
	$(form).find("input").each(function(){
		var inputName = $(this).attr("name");
    	var inputValue = $(this).val();
    	postData[inputName] = inputValue;
	});
	
	// 遍歷表單中的每個輸入字段
	$(form).find("select").each(function(){
		var selectName = $(this).attr("name");
    	var selectValue = $(this).val();
    	postData[selectName] = selectValue;
	});
	
	console.log(postData);
	
	// 取得targetURL
	var targetURL = $(form).attr('action');
	
	var result = wg.evalForm.getJson(postData, targetURL);
	if(result.success){
		<#if isNewForm?? >
			swal("創建成功", "病患資訊如下：\n" + result.msg, "success");	
		<#else>
			swal("更新成功", "病患資訊如下：\n" + result.msg, "success");
		</#if>
	}else{
		<#if isNewForm?? >
			swal("創建失敗！", result.msg, "error");
		<#else>
			swal("更新失敗！", result.msg, "error");
		</#if>
	}
}

function payloadTextChange(){
    // 監聽connectionType的選擇變化
    $('#connectionType').on('change', function() {
        // 獲取選擇的值
        var selectedValue = $(this).val();
        
        // 更新payloadTypeText的value
        $('input[name="payloadTypeText"]').val(selectedValue);
        $('input[name="connectionTypeDisplay"]').val(selectedValue);
    });
}
	
</script>

<style>
.lower{
	text-transform: lowercase;
}

.upper{
	text-transform: uppercase;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />