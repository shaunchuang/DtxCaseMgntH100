<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "dicom.label.title"/></div>
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
			    <table class="default-table">				
					<tr>
						<td>選擇ImagingStudy ID：</td>
						<td>
					        <select id="imagingStudyId" class="form-control">
								<option value="">請選擇</option>
								<option value="manual">手動輸入</option>
							</select>
						</td>
					</tr>
					<tr id="manualInput" style="display: none;">
                        <td>StudyID:</td>
                            <td><input type="text" id="studyId" class="form-control"></td>
                        <td>SeriesID:</td>
                            <td><input type="text" id="seriesId" class="form-control"></td>
                        <td>InstanceID:</td>
                            <td><input type="text" id="instanceId" class="form-control"></td>
                    </tr>
                    <tr>
						<td colspan="4">
							<div class="footer-btn-list">
								<button class="func-btn" onclick="fetchImage()"><i class="fa fa-save"></i>搜尋圖片</button>
							</div>	
						</td>
					</tr>					
				</table>
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	 <img id="dicomImage" src="" alt="DICOM Image" style="display: none">
	            </div>
			</div>
		</div>	
	</div>
</body>

<script>


$(document).ready(function(){
	postImagingStudyList();
    changeMenu();
});

function changeMenu(){
	$('#imagingStudyId').on('change', function() {
            if ($(this).val() === 'manual') {
                $('#manualInput').show();
            } else {
                $('#manualInput').hide();
            }
        });
}

function fetchImage() {
    var imageId = $("#imagingStudyId").val();
    var postData = {"id": imageId};

    $.ajax({
        url: '${base}/division/api/dicom/image/show',
        type: 'POST',
        data: JSON.stringify(postData),
        contentType: 'application/json',
        success: function(response, status, xhr) {
            var parsedData = JSON.parse(response);
            $('#dicomImage').attr('src', 'data:image/jpeg;base64,' + parsedData.data).show();
        },
        error: function(xhr, status, error) {
            console.log('Error:', error);
        },
        processData: false
    });
}


function postImagingStudyList() {
    var baseUrl = "${base}/division/api/fhir/imagingstudy/list";
    var queryParam = 'data=' + encodeURIComponent('{"page_num":1,"limit":"100"}');
    var fullUrl = baseUrl + '?' + queryParam;

    $.ajax({
        url: fullUrl,
        method: 'POST',
        success: function(response) {
            createImagingStudyDropdown(JSON.parse(response).data);
        },
        error: function(error) {
            console.error('Error:', error);
        }
    });
}



function createImagingStudyDropdown(data) {
    var $selectElement = $('#imagingStudyId');
    $.each(data, function(index, item) {
        var option = $('<option>', {
            value: item.id,
            text: 'ID：' + item.id
        });
        $selectElement.append(option);
    });
}

	
</script>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />