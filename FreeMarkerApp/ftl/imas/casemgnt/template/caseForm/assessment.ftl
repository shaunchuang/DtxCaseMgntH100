<#import "/util/spring.ftl" as spring />

<div id="content">

	<div class="col-md-12 pd-h-0 d-flex g-15 justify-content-between">
    	<div class="col-md-5 pd-h-0 data-blk">
    		<div class="d-flex justify-content-between align-items-center pd-b-5">
              	<h4 class="mb-0">個案評估歷程紀錄</h4>
              	<!--<button class="btn btn-outline-primary btn-sm add-ast">新增量表</button>-->
              	<button class="btn btn-outline-primary b-radius-50 view-chart">綜合評估總覽</button>             	
            </div>
            <div class="input-group search-group ">
                <select class="form-control">
                    <option value="">所有量表類型</option>
                    <option value="pt">職能治療</option>
                    <option value="ot">物理治療</option>
                    <option value="ps">心理治療</option>
                    <option value="st">語言治療</option>
                </select>
                <input type="button" class="form-control search-btn" value="篩選" />
            </div>
			<div class="list-group">
			
			</div>
		</div>
		<div class="col-md-7 pd-h-0 data-blk">
			<div id="evaluation-container" class="evaluation"></div>
		</div>
		<!--<div class="col-md-7 default-blk evaluation-blk">    			
			<div id="evaluation-container" class="evaluation"></div>
		</div>-->							
    </div>
    
    <script>
	var cUserId = ${currentUser.id!""};
	
	$(document).ready(function(){
		adjustHeight();
		triggerPatientEvalList();
		wg.template.updateNewPageContent('evaluation-container', 'data-content', {}, '/ftl/imas/patient/caseForm/assessment/charts?formId=${formId!""}');

	});

	$(".view-chart").click(function(e){
		e.preventDefault();
		wg.template.updateNewPageContent('evaluation-container', 'data-content', {}, '/ftl/imas/patient/caseForm/assessment/charts?formId=${formId!""}');
	})
	
	function triggerPatientEvalList(){
		var postData = {"therapistId": cUserId, "patientId": "${formId!""}"};
	    var result = wg.evalForm.getJson(JSON.stringify(postData), "/Assessment/api/getCaseAssessmentList");
	    if(result.success){
	    	showAssessmentList(result.data);
	    }
	}
	
	//顯示個案評估量表列表
	function showAssessmentList(data, redirectId){
	
		$(".list-group").empty();
		
		if(data.length > 0){
	 		$.each(data, function (i, item) {
	 			var subfuncList = item.subfuncList != "" ? `<div class="sub-func-list">`+ item.subfuncList + `</div>` : "";
	 			var html = `
			    <div class="list-group-item card-hover mb-2" data-id=`+ item.id + ` data-mode=`+ item.mode + `>
			    	<div class="d-flex justify-content-between">
			    		<div class="flex-grow-1 me-2">
			          		<div class="d-flex align-items-center mb-1">
			            		`+ item.cat + `
			            		<p class="form-name mg-b-0">`+ item.scaleName + `</p>
			          		</div>
			        	</div>
			        	<div class="text-end">`+ item.result + `</div>
			      	</div>
			      	<div class="sub-content">
			        	<div class="sub-content-left">
			          		<small class="text-muted">填寫日期：`+ item.assessmentDate + `</small>
			          		<small class="text-muted">前次評量：`+ item.lastAssessmentDate + `</small>
			          		<small class="text-muted">填寫者：`+ item.editor + `</small>
			        	</div>
			        	<div class="sub-content-right">
			        		`+ item.level + subfuncList + `		        		
		        		</div>
			      	</div>
			    </div>
			  	`;
	 			
	 			$(".list-group").append(html);
	 		});
	 		
	 		if(redirectId != undefined){
				$(".list-group-item[data-id='" + redirectId + "']").trigger('click');
			}
	 		
	 		wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {}, '/ftl/imas/admin/taskMgnt/evaluation/message?msg=emptyMessage');
		}else{
			$(".list-group").append("<div class='cnt-empty'>目前尚無評估記錄</div>")
			wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {}, '/ftl/imas/admin/taskMgnt/evaluation/message?msg=addMessage');
		}
	}
	
	$("body").on("click", ".list-group-item", function(e) {
		e.preventDefault();
	    
		var $item = $(this).hasClass("list-group-item") ? $(this) : $(this).closest(".list-group-item");
		var formId = $item.data("id");
		var mode = $item.data("mode");
		
		$(this).parent().find(".list-group-item").removeClass("selected");
		$(this).toggleClass("selected");
		wg.template.updateNewPageContent('evaluation-container', 'evaluation-content', {"isFromPatient": false}, '/ftl/imas/admin/taskMgnt/evaluation?formId=' + formId + '&mode=view&patientId=${formId!""}');
		$('.evaluation-blk').fadeIn(500); // 0.5秒淡入
	});
	</script>
	
	<style>
	.evaluation{
		min-height: 400px;
	}
	</style>
</div>