<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<#if isNewForm?? >
					<div class="item-name">新增醫學影像(ImagingStudy)</div>
					<#else>
					<div class="item-name">FHIR個案總覽</div>
					<span class="patient-hint">${patientName!""}</span>
					</#if>
				</div>
				<#if !isNewForm?? >
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.back"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/caseView">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "casemgnt.menu.view"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/observation">
						<i class="fa fa-stethoscope fa-lg"></i>
						<span>生理量測</span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/imagingstudy">
						<i class="fa fa-image fa-lg"></i>
						<span>檢測影像</span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/exchange/fhir/patient/${patientId!""}/diagnosticreport">
						<i class="fa fa-file-pdf fa-lg"></i>
						<span>診斷報告</span>
					</div>		
				</div>
           		</#if>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
			    <form class="form" id="imagingStudyForm" action="${base}/division/api/fhir/imagingstudy/save" method="POST">
				    <@spring.bind "imagingStudyView"/>
				    <#-- Default -->
				    <input type="hidden" name="metaView.profiles[0]" value="https://hapi.fhir.tw/fhir/StructureDefinition/ImagingStudyBase">
				    <input type="hidden" name="SIUID_Use" value="OFFICIAL">
				    <input type="hidden" name="ACSN_Use" value="OFFICIAL">
				    <input type="hidden" name="status" value="AVAILABLE">
				    <#if !isNewForm??>
				    <input type="hidden" name="id" value="${imagingStudyView.id!""}">
				    <#else>
				    <input type="hidden" name="id" id="id" value="">
				    </#if>
				    <table class="default-table">
				        <#if !isNewForm??>				
					    <tr>
						    <td>ImagingStudy識別碼(ID)：</td>
						    <td>
							    <@spring.formInput path="imagingStudyView.id" attributes='class="form-control" disabled="disabled"'/>
						    </td>
					</#if>
						<td>StudyUID</td>
						<td>
							<@spring.formInput path="imagingStudyView.SIUID_Value" attributes='class="form-control StudyUID"'/>
						</td>
					</tr>
					<tr>
						<td>檢查單號：</td>
						<td>
							<@spring.formInput path="imagingStudyView.ACSN_Value" attributes='class="form-control ACSN_Value"'/>
						</td>
						<td>Endpoint ID：</td>
						<td>
							<#if isNewForm??>
                            <input type="text" name="endpoints[0]" class="form-control" value="Endpoint/${endpointId!""}">
                            <#else>
                            <@spring.formInput path="imagingStudyView.endpoints[0].reference" attributes='class="form-control" placeholder="端點參照,如：Endpoint/5" ' />
                            </#if>	
							</select>
						</td>
					</tr>
					<tr>
						<td>個案參照：</td>
						<td>
                            <#if isNewForm?? >
							<input type="text" name="subject" class="form-control" value="Patient/${patientId!""}" placeholder="病患參照(subject),如：Patient/5">
							<#else>
							<#assign ref = imagingStudyView.subject?if_exists.reference!"">
							<input type="text" name="subject" class="form-control" value="${ref!""}" placeholder="病患參照(subject),如：Patient/5">
							</#if>
						</td>
					</tr>
					<tr>
						<td>Modality：</td>
						<td>
						    <span>Code：</span>
						    <@spring.formInput path="imagingStudyView.imagingStudySeriesComponentViews[0].modalityCode" attributes='class="form-control ModalityCode"'/>
						    <span>Display：</span>
						    <@spring.formInput path="imagingStudyView.imagingStudySeriesComponentViews[0].modalityDisplay" attributes='class="form-control"'/>
						</td>
						<td>BodySite：</td>
						<td>
						    <span>Code：</span>
						    <@spring.formInput path="imagingStudyView.imagingStudySeriesComponentViews[0].bodySiteCode" attributes='class="form-control"'/>
						    <span>Display：</span>
						    <@spring.formInput path="imagingStudyView.imagingStudySeriesComponentViews[0].bodySiteDisplay" attributes='class="form-control"'/>
						</td>
					</tr>
					<tr>
						<td>Series數量：</td>
						<td>
							<@spring.formInput path="imagingStudyView.numberOfSeries" attributes='class="form-control SeriesNumber" type="number"'/>
						</td>
						<td>Instance數量：</td>
						<td>
                            <@spring.formInput path="imagingStudyView.numberOfInstance" attributes='class="form-control InstanceNumber" type="number"'/>
						</td>
					</tr>
					<tr>
						<td>診斷碼：</td>
						<td>
						    <span>Code：</span>
                            <@spring.formInput path="imagingStudyView.procedureCode" attributes='class="form-control half"'/>
						    <span>Display：</span>
						    <@spring.formInput path="imagingStudyView.procedureDisplay" attributes='class="form-control half"'/>
						</td>
					</tr>
					<tr>
						<td>Series ID：</td>
						<td>
							<@spring.formInput path="imagingStudyView.imagingStudySeriesComponentViews[0].uid" attributes='class="form-control SeriesUID"'/>
						</td>
						<td>Instance ID：</td>
						<td>
							<@spring.formInput path="imagingStudyView.imagingStudySeriesComponentViews[0].imagingStudySeriesInstanceComponentViews[0].uid" attributes='class="form-control InstanceUID"'/>
						</td>
					</tr>
					<tr>
						<td>SOP Class：</td>
						<td>
							<@spring.formInput path="imagingStudyView.imagingStudySeriesComponentViews[0].imagingStudySeriesInstanceComponentViews[0].sopClassCode" attributes='class="form-control SopClassCode"'/>
						</td>
					</tr>
					<#if isNewForm?? >
					<tr>
					    <td colspan="4">
					        <input type="file" id="dicomFile" name="dicomFile" accept=".dcm">
					    </td>
					</tr>
					<#else>
					<tr>
					    <td style="text-align: center;" colspan="4">
					        <img src="${base}/${__lang}/division/api/dicom/image/show?imagingStudyId=${imagingStudyView.id!""}" width="300px" alt="dicom imaging">
					    </td>
					</tr>
					</#if>
					<tr>
						<td colspan="4">
							<div class="footer-btn-list">
								<button class="func-btn" onclick="submitForm(event, this)"><i class="fa fa-save"></i> 儲存</button>
							</div>	
						</td>
					</tr>					
				</table>
			  </form>
			</div>
		</div>	
	</div>
</body>
<script src="https://unpkg.com/dicom-parser/dist/dicomParser.min.js"></script>

<script>

$(document).ready(function(){
    var studyUID, seriesUID, instanceUID;
    dicomDetect()
});


function submitForm(e, obj) {
    e.preventDefault();

    var form = $(obj).closest('form');
    var file = $('#dicomFile')[0].files[0];

    if (!file) {
        swal('創建失敗', '請先選擇一個 DICOM 檔案', 'error');d
    }

    try {
        
        var status = uploadDICOM();

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

        var result = wg.evalForm.getJson(postData, form.attr('action'));

        if (result.success && status) {
        <#if isNewForm?? >
			//swal("創建成功", "病患資訊如下：\n" + result.msg, "success");
			swal({
			  	title: "創建成功",
			  	text: "檢測影像資訊如下：\n" + result.msg,
			  	type: "success",
			  	showConfirmButton: true
			},function(confirm){
				if(confirm) window.location.href = "${base}/${__lang}/division/web/exchange/fhir/patient/${patientId!""}/imagingstudy";
			});	
		<#else>
			swal({
			  	title: "更新成功",
			  	text: "檢測影像資訊如下：\n" + result.msg,
			  	type: "success",
			  	showConfirmButton: true
			},function(confirm){
				if(confirm) window.location.href = "${base}/${__lang}/division/web/exchange/fhir/patient/${patientId!""}/imagingstudy";
			});	
		</#if>
        } else {
        <#if isNewForm?? >
			swal("創建失敗！", result.msg, "error");
		<#else>
			swal("更新失敗！", result.msg, "error");
		</#if>
        }
    } catch (error) {
        swal("錯誤", error, "error");
    }
}


function generateUUID() {
    return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, c =>
        (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
    );
}

function dicomDetect(){
    $('#dicomFile').change(function(event) {
        var file = event.target.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var arrayBuffer = e.target.result;

                try {
                    var byteArray = new Uint8Array(arrayBuffer);
                    var dataSet = dicomParser.parseDicom(byteArray);

                    studyUID = dataSet.string('x0020000d');
                    seriesUID = dataSet.string('x0020000e');
                    instanceUID = dataSet.string('x00080018'); 

                    $('.StudyUID').val(studyUID);
                    $('.SeriesUID').val(seriesUID);
                    $('.InstanceUID').val(instanceUID);
                    if(dataSet.string('x00080060')){$('.ModalityCode').val(dataSet.string('x00080060'));}
                    if(dataSet.string('x00200011')){$('.SeriesNumber').val(dataSet.string('x00200011'));}
                    if(dataSet.string('x00200013')){$('.InstanceNumber').val(dataSet.string('x00200013'));}
                    if(dataSet.string('x00200020')){console.log('There is no Patient Orientation');}
                    if(dataSet.string('x00080050')){$('.ACSN_Value').val(dataSet.string('x00080050'));}
                    if(dataSet.string('x00080016')){$('.SopClassCode').val(dataSet.string('x00080016'));}
                } catch (error) {
                    console.error('Error parsing DICOM file', error);
                }
            };
            reader.readAsArrayBuffer(file);
        }
    });
}

function uploadDICOM() {
    return new Promise((resolve, reject) => {
        var file = $('#dicomFile')[0].files[0];
        var formData = new FormData();
        formData.append('dicomFile', file);

        $.ajax({
            url: '${base}/${__lang}/division/api/dicom/image/upload', 
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if(response.success) {
                    return true;
                } else {
                    return false;
                }
            },
            error: function() {
                return false;
            }
        });
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