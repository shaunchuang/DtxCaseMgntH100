<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "admin.menu.otherMgnt"/></div>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="/ftl/imas/admin/other/phraseMgnt">
						<i class="fa fa-quote-left fa-lg"></i>
						<span><@spring.message "admin.menu.phraseMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/scaleMgnt">
						<i class="fa fa-table-list fa-lg"></i>
						<span><@spring.message "admin.menu.scaleMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/deviceMgnt">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "admin.menu.deviceMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/lessonMgnt">
						<i class="fa fa-upload fa-lg"></i>
						<span><@spring.message "admin.menu.lessonMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/profitMgnt">
						<i class="fa fa-coins fa-lg"></i>
						<span><@spring.message "admin.menu.profitMgnt"/></span>
					</div>
					<div class="module-blk active" data-src="/ftl/imas/admin/other/medicalMgnt">
						<i class="fa fa-pills fa-lg"></i>
						<span><@spring.message "admin.menu.medicalMgnt"/></span>
					</div>										
				</div>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<#assign isNew = isNewForm>
				<#if isNew>
				<form class="form" id="resourceForm" action="${base}/employee/MedicalMng/doCreateResource" method="POST">
				<#else>
				<form class="form" id="resourceForm" action="${base}/employee/MedicalMng/doEditResource" method="POST">
				</#if>
					<@spring.bind "resource" />
					<#if !isNew>
					<@spring.formHiddenInput path="resource.id" />
					<@spring.formHiddenInput path="resource.createTime" />
					</#if>
					<table class="default-table">
						<#if isNew>
						<tr>
							<td><@spring.message "medical.detail.label.addMethod"/></td>
							<td>
								<div class="form-check">
								  	<input class="form-check-input" type="radio" name="flexRadioDefault" data-item=1 checked>
								  	<label class="form-check-label" for="flexRadioDefault1"><@spring.message "medical.detail.label.manual"/></label>
								</div>
								<div class="form-check">
								  	<input class="form-check-input" type="radio" name="flexRadioDefault" data-item=2 >
								  	<label class="form-check-label" for="flexRadioDefault2"><@spring.message "medical.detail.label.upload"/></label>
								</div>
								<div class="form-check pull-right">
									<a class="template-url"><@spring.message "medical.detail.label.example.file"/></a>
								</div>						
							</td>
						</tr>
						<tr class="upload-method hidden">
							<td><@spring.message "medical.detail.label.fileUpload"/></td>
							<td>
								<input type="file" class="uploadFile" />
							</td>
						</tr>
						<#else>
						<tr>
							<td><@spring.message "medical.detail.label.id"/></td>
							<td>
								<@spring.formInput path="resource.id" attributes='class="form-control" disabled="disabled"' />
							</td>
						</tr>
						</#if>
						<tr>
							<td><@spring.message "medical.detail.label.resource"/></td>
							<td>
								<@spring.formInput path="resource.name" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "medical.detail.label.quickcode"/></td>
							<td>
								<@spring.formInput path="resource.quickNo" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "medical.detail.label.nhicode"/></td>
							<td>
								<@spring.formInput path="resource.nhiNo" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "medical.detail.label.effect"/></td>
							<td>
								<@spring.formTextarea path="resource.effect" attributes='class="form-control" row="3" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "medical.detail.label.sideEffect"/></td>
							<td>
								<@spring.formTextarea path="resource.sideEffect" attributes='class="form-control" row="3" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "medical.detail.label.restrictions"/></td>
							<td>
								<@spring.formTextarea path="resource.restrictions" attributes='class="form-control" row="3" ' />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="footer-btn-list">
									<#if !isNew>
									<button class="func-btn del-btn"><i class="fa fa-trash-can"></i> <@spring.message "admin.button.delete"/></button>
									</#if>
									<#if isNew>
									<button type="submit" class="func-btn"><i class="fa fa-save"></i> <@spring.message "admin.button.add"/></button>
									<#else>
									<button type="submit" class="func-btn"><i class="fa fa-save"></i> <@spring.message "admin.button.save"/></button>
									</#if>
									<button class="goback func-btn"><i class="fa fa-circle-xmark"></i> <@spring.message "admin.button.cancel"/></button>
								</div>	
							</td>
						</tr>					
					</table>
				</form>
			</div>
		</div>	
	</div>
</body>

<script>

$(document).ready(function(){
	mlog.form.validate({
		selector : "#roleForm",
		errorLabelContainer : "#error",
		wrapper: 'li',
		onfocusout : false,
		onkeyup : false,
		onclick : false,
		success : function(){
			mlog.utils.scrollTop();
		}
	});
});

$(".goback").click(function(e){
	e.preventDefault();
	window.location = "${base}/${__lang}/division/web/admin/other/medicalMgnt";
});

$(".template-url").click(function(e){
	e.preventDefault();
	window.open("${base}/${__lang}/division/web/admin/other/medicalMgnt/defaultFile");
});

$(".del-btn").click(function(e){
	e.preventDefault();
	confirmCheck("刪除確認", "請再次確認是否要刪除此藥品/特材，刪除後即無法恢復!", "warning", "btn-info", "確認", "取消", function(confirmed){
		if(confirmed){
			var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/employee/MedicalMng/doDeleteResource?id=${resource.id!""}");
			if(result.success){
				swal({
				  	title: "刪除成功",
				  	text: "已成功刪除此藥品/特材，將導向耗材管理列表中...",
				  	type: "success",
				  	timer: 1500,
				  	showConfirmButton: false
				},function(){
				    window.location.href = "${base}/${__lang}/division/web/admin/other/medicalMgnt";
				});
			}
		}
	});	
});

$("input[name='flexRadioDefault']").change(function(){
	var itemNo = $(this).attr("data-item");
	if(itemNo == 1){
		$(".default-table tr").show();
		$(".upload-method").toggleClass("hidden");
	}else{
		$(".upload-method").toggleClass("hidden").nextAll().hide();
	}
});

$(".uploadFile").change(function() {

    var fileLeng = $(".uploadFile").get(0).files.length;
    if(fileLeng >0){
    	var fileName = $(".uploadFile").get(0).files[0].name;
    	if(fileName.indexOf(".xls") != -1 || fileName.indexOf(".xlsx") != -1){
	    	confirmCheck("批次檔上傳確認", "您確定要上傳此檔案嗎?\n( " + fileName + " )", "warning", "btn-info", "確認上傳", "取消", function(confirmed){
				if(confirmed){			
					uploadImage();
				}
				else{
					$(this).val("");
				}
			});
		}else{
			swal("上傳失敗", "檔案格式須為 .xls 或 .xlsx，請重新上傳一次!\n(建議下載耗材範例檔自行編輯並上傳)", "error");
		}
    }
});

function uploadImage(){
	var fileData = $(".uploadFile").get(0).files;
	var fileLeng = fileData.length;
	//
	if(fileLeng > 0){
		for(var i=0; i < fileLeng; i++){
			(function(i){
		        asyncTask(fileData[i]).done(function(res, status, jqXHR) {
		        	var resObj = JSON.parse(res);
		        	if(resObj.success){	
						fileLeng--;
		            	if(fileLeng === 0){
		            		swal({
							  	title: "上傳成功",
							  	text: "已成功上傳藥品/特材檔，將導向耗材管理列表中...",
							  	type: "success",
							  	timer: 1500,
							  	showConfirmButton: false
							},function(){
							    window.location.href = "${base}/${__lang}/division/web/admin/other/medicalMgnt";
							});
		            	}
		        	}
				});
			})(i);	
		}		
    }   
}

function asyncTask(obj){
	var dfd = $.Deferred();
	var formInfo = new FormData();
	formInfo.append("userId", ${currentUser.id!""});
	formInfo.append("myImg", obj);
	formInfo.append("location", "${__filed!""}");
    
    var res = $.ajax({
        url: "${base}/division/api/uploadMedicalResourceFile",
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
	
</script>

<style>
.form-check{
	display: inline-block;
	margin-right: 5px;
}

.form-check-input{
	zoom: 1.4;
}

.form-check label{
	vertical-align: bottom;
}

.template-url:hover{
	cursor: pointer;
}

</style>

<#--<#include "/skins/imas/casemgnt/socket.ftl" />-->
<#include "/imas/widget/widget.ftl" />