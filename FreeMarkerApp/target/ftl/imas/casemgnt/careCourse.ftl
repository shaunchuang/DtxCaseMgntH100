<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "casemgnt.label.caseView.title"/></div>
					<span class="patient-hint">${patientName!""}</span>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="home">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.back"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/caseView">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "casemgnt.menu.view"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/hcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.hcRecord"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/ltcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.ltcRecord"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/inspection">
						<i class="fa fa-stethoscope fa-lg"></i>
						<span><@spring.message "casemgnt.menu.inspection"/></span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/patient/${formId!""}/careCourse">
						<i class="fa fa-clock-rotate-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careCourse"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/carePlan">
						<i class="fa fa-clipboard-list fa-lg"></i>
						<span><@spring.message "casemgnt.menu.carePlan"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/careTeam">
						<i class="fa fa-people-group fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careTeam"/></span>
					</div>
				</div>          
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="col-xs-12 main-content">
				<div class="timeline pd-h-0">
					<#list courseList as course>
	                <div class="date-title">
	                    <span>${course.month!""}</span>
	                </div>
	                <#assign itemList = course.careCourseList>
					<#list itemList as item>
					<div class="row">
	                    <div class="col-sm-10 news-item right" data-keyno="${item.keyno!""}" data-evaldate="${item.evalDate!""}">
	                        <div class="news-content status-${item.category!""}">
	                            <div class="date">
	                                <p>${item.date!""}</p>
	                                <small>${item.week!""}</small>
	                            </div>
	                            <p><b><@spring.message "careCourse.label.content"/></b>${item.content!""}</p>
	                            <p><b><@spring.message "careCourse.label.note"/></b>${item.note!""}</p>
	                        </div>
	                    </div>                    
	                </div>
					</#list>
					</#list>	                
	            </div>
	            <div class="btn-blk">
	            	<@spring.message "careCourse.label.statusChange"/> <button class="func-btn"><i class="fa fa-plus"></i> <@spring.message "careCourse.button.addEvent"/></button>
	            </div>
			</div>
		</div>	
	</div>
</body>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:500px;">
		<div class="modal-content" >
			<div class="modal-header item-header">
				<@spring.message "careCourse.label.editEvent"/>
				<button type="button" class="close clean" data-dismiss="modal" aria-label="Close">
		          	<i class="fa fa-xmark" aria-hidden="true"></i>
		        </button>
			</div>
			<div class="modal-body">
				<form class="reg" >
					<table class="default-table">
					    <tr>
							<td><@spring.message "careCourse.label.name"/></td>
							<td>
								${patientName!""}
							</td>
							<td><span class="evalDate"></span></td>
						</tr>
						<tr>
							<td><@spring.message "careCourse.label.category"/></td>
							<td colspan="3">
								<select class="eventForm form-control category" data-item='7'>
									<option value="" ><@spring.message "careCourse.option.cat.hint"/></option>
									<option value="N" ><@spring.message "careCourse.option.newcase"/></option>
									<option value="T" ><@spring.message "careCourse.option.track"/></option>
									<option value="C" ><@spring.message "careCourse.option.caseclose"/></option>
								</select>
								<select class="eventForm form-control mg-top-10 sub-category hidden" data-item='8'>
									<option value="" ><@spring.message "careCourse.option.caseclose.hint"/></option>
									<option value="CO" ><@spring.message "careCourse.option.other"/></option>
									<option value="CM" ><@spring.message "careCourse.option.migration"/></option>
									<option value="CD" ><@spring.message "careCourse.option.death"/></option>
								</select>
							</td>
						</tr>
						<tr>
							<td><@spring.message "careCourse.label.content"/></td>
							<td colspan="3">
								<textarea rows="3" class="eventForm form-control" placeholder="<@spring.message "careCourse.placeholder.content"/>" data-item="9" ></textarea>
							</td>
						</tr>						
						<tr>
							<td><@spring.message "careCourse.label.note"/></td>
							<td colspan="3">
								<textarea rows="3" class="eventForm form-control" placeholder="<@spring.message "careCourse.placeholder.note"/>" data-item="10" ></textarea>
							</td>
						</tr>										
					</table>
				</form>                
			</div>
			<div class="modal-footer">
				<button class="default-btn func-btn edit-btn"><@spring.message "careCourse.button.save"/></button>
				<button class="default-btn func-btn add-btn" ><@spring.message "careCourse.button.add"/></button>
				<button class="clean func-btn" data-dismiss="modal"><@spring.message "careCourse.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>

<link href="${base}/style/imas/timeline.css" rel="stylesheet" type="text/css">

<style>
.evalDate{
	font-size: 14px;
	font-weight: 500;
	padding: 5px;
	color: #8c8c8c;
	background: #f5f5f5;
	border-radius: 5px;
	float: right;
}
</style>

<script>

$(document).ready(function(){
	
});

//清除訊息表格內容
$(".clean").click(function() {  
    $('.reg').trigger('reset');  
});

$(".category").change(function(){
	var target = $(".sub-category");
	
	if($(this).val() == "C"){
		target.removeClass("hidden");
	}else{
		target.addClass("hidden");
	}
	
	target.val("");
});

//開啟新增事件視窗
$(".btn-blk button").click(function() { 
	$(".default-btn").addClass("hidden");
	$(".add-btn").toggleClass("hidden");
	$(".evalDate").html(getTodate()); 
    $("#myModal").modal('show'); 
});

$(".news-item").click(function(){
	var keyno = $(this).data("keyno");
	var evalDate = $(this).data("evaldate");
	var itemArr = [];
	$(".default-table").find(".eventForm").each(function(){
		itemArr.push($(this).attr("data-item"));
	});
	var basicData = {"userFormKeyNo": keyno, "itemIds": itemArr};	
	var data = wg.evalForm.getJson({"data":JSON.stringify(basicData)}, "${base}/division/api/qryAns");
	setFormValue("eventForm", data.result);
	$(".default-btn").addClass("hidden");
	$(".edit-btn").toggleClass("hidden").attr("data-keyno", keyno);
	$(".evalDate").html(evalDate);
	$("#myModal").modal('show');
});

//新增事件
$(".add-btn").click(function() { 
	var itemNumArr = getItemNumArray("default-table", "eventForm");
	var itemArray = getItemValue("eventForm", itemNumArr);
	var postData = {"creatorId":${currentUser.id!""}, "formName": "照護歷程V2", "evalDate": getEvalDate(), "app": "${formId}", "items": itemArray};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createUserForm?");
	if(result.success){			
		swal("<@spring.message "careCourse.save.success.addTitle"/>", "<@spring.message "careCourse.save.success.addText"/>", "success");
		$("#myModal").modal('hide');
		location.reload();
	}
	else{
		swal("<@spring.message "careCourse.save.fail.addTitle"/>", "<@spring.message "careCourse.save.fail.addText"/>", "error");
	}
});

//編輯事件
$(".edit-btn").click(function() { 
	var keyno = $(this).data("keyno");
	var itemNumArr = getItemNumArray("default-table", "eventForm");
	var itemArray = getItemValue("eventForm", itemNumArr);
	var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": keyno, "items": itemArray};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/editUserForm?");
	if(result.success){			
		swal("<@spring.message "careCourse.save.success.editTitle"/>", "<@spring.message "careCourse.save.success.editText"/>", "success");
		$("#myModal").modal('hide');
		location.reload();
	}
	else{
		swal("<@spring.message "careCourse.save.fail.editTitle"/>", "<@spring.message "careCourse.save.fail.editText"/>", "error");
	}
});

</script>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />