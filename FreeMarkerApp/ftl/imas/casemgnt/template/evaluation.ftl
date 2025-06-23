<#import "/util/spring.ftl" as spring />
  
<div id="evaluation-content">
	<#if scale?exists>
		<div class="evaluation-top-bar mg-b-10">
			<div class="evaluation-title">${scale.name!""}</div>
			<span class="case-abbr">${scale.patientInfo.name!""} / ${scale.patientInfo.gender!""} / ${scale.patientInfo.age!""}</span>			
		</div>
		<div class="evaluation-info mg-b-5">${scale.desc!""}</div>
		<#if scale.type == "scale">
		<div class="slider-ques-container overflowY">
			<#list scale.items as item>
				<#if item.labelLeft?has_content && item.labelRight?has_content>
					<div class="slider-ques mg-b-5">
				        <div class="ques-title <#if item.hasParentQues>sub-ques</#if>">
				        	<#if item.itemNo?? && item.itemNo?has_content>
				        		<#if item.hasParentQues>(${item.itemNo})<#else>${item.itemNo!""}.</#if>
				        	</#if>	
			        		${item.question}
			        	</div>
				        <div class="slider-container">
				            <input type="text" id="slider-${item.id}" class="slider" data-item-id="${item.id}" data-score="<#if item.score?has_content>${item.score}<#else>${item.scoreMin}</#if>" data-score-min="${item.scoreMin}" data-score-max="${item.scoreMax}" data-label-left="${item.labelLeft}" data-label-right="${item.labelRight}" />
				        </div>
				    </div>
			    <#else>
			    <div class="sub-ques-blk w-99">
			    	<div class="ques-title">
			        	<#if item.itemNo?? && item.itemNo?has_content>
			        		${item.itemNo!""}.
			        	</#if>	
		        		${item.question}
		        	</div>
		        	<#if (item.opts?size >0)>
			        	<div class="h-option-list" data-ques-no="${item.itemNo!""}">
			        		<#list item.opts as option>
			        		<div class="option <#if option.checked>selected</#if> <#if mode == "view">option--disabled</#if>" name="question_${item.id}" data-item-id="${item.id}" data-item-no="${item.itemNo!""}" data-option-id="${option.id}" data-score="${option.score}">
			        			${option.optionText}
		        			</div>
			        		</#list>
			        	</div>
		        	</#if>
			    </div>
			    </#if>
			</#list>
			<#if mode == "edit">
			<div class="btn form-send">完成送出</div>
			</#if>
		</div>
		<#elseif scale.type == "binary" || scale.type == "multiple_choice">
		<div class="slider-ques-container overflowY">
			<#if (scale.sections??) && (scale.sections?size >0 ) >
				<#list scale.sections as section>
				<div class="section-blk" data-section="${section.id}">
					<div class="section-title">測驗項目 ${section.sectionNo}.${section.title!""}</div>
					<#if section.note?has_content>
					<div class="section-note">${section.note!""}</div>
					</#if>
					<table class="default-table auto-layout with-border">
						<#list section.items as item>
							<#if (item.opts?size >0)>
								<#if item.horizontalView?? && item.horizontalView>
									<tr>
										<td class="h-question-cell">
											<div class="ques-title <#if item.hasParentQues>sub-ques</#if>">
									        	<#if item.itemNo?? && item.itemNo?has_content>
									        		<#if item.hasParentQues>${item.parentItemNo}-${item.itemNo}.<#else>${item.itemNo!""}.</#if>
									        	</#if>	
								        		${item.question}
								        	</div>
										</td>
									</tr>
									<tr class="border-b-2">
					            		<td>
					            			<div class="h-option-list" data-multiselect="<#if item.isSingleChoice>false<#else>true</#if>" data-ques-no="<#if item.hasParentQues>${item.parentItemNo}-${item.itemNo}<#else>${item.itemNo!""}</#if>">
								        		<#list item.opts as option>
								        		<div class="option <#if option.checked>selected</#if> <#if mode == "view">option--disabled</#if>" name="question_${item.id}" data-item-id="${item.id}" data-option-id="${option.id}" data-score="${option.score}">
								        			${option.optionText}
							        			</div>
								        		</#list>
								        	</div>
					            		</td>
					            	</tr>
								<#else>
						            <#list item.opts as option>
						                <tr class="<#if option_index == (item.opts?size - 1) && item_index != (scale.items?size -1) > border-b-2</#if>">
						                    <#if option_index == 0>
						                        <td rowspan="${item.opts?size}" class="question-cell">
						                        	<#if item.itemNo?? && item.itemNo?has_content>
													  	<#if item.hasParentQues>(${item.itemNo})<#else>${item.itemNo}.</#if>
													</#if>
													${item.question}
					                        	</td>
						                    </#if>
						                    <td>${option.optionText}</td>
						                    <td class="radio-cell" data-ques-no="${item.itemNo!""}">
						                        <input type="radio" name="question_${item.id}" data-item-id="${item.id}" data-item-no="${item.itemNo!""}" data-option-id="${option.id}" data-score="${option.score}" <#if option.checked>checked</#if> <#if mode == "view">disabled</#if> >
						                    </td>
						                </tr>
						            </#list>
					            </#if>
				            <#else>
				            	<tr class="<#if item_index != (scale.items?size -1) > border-b-2</#if>">
			                        <td colspan="3" class="question-cell">
			                        	<#if item.itemNo?? && item.itemNo?has_content>
										  	<#if item.hasParentQues>(${item.itemNo})<#else>${item.itemNo}.</#if>
										</#if>
										${item.question}
		                        	</td>
				                </tr>
				            </#if>
				        </#list>
					</table>
				</div>
				</#list>
			<#else> <#-- 量表為二元或多選項且沒有section時 -->
			<table class="default-table with-border w-99">
				<#list scale.items as item>
					<#if (item.opts?size >0)>
						<#if item.horizontalView?? && item.horizontalView>
							<tr>
								<td class="h-question-cell">
									<div class="ques-title <#if item.hasParentQues>sub-ques</#if>">
							        	<#if item.itemNo?? && item.itemNo?has_content>
							        		<#if item.hasParentQues>${item.parentItemNo}-${item.itemNo}.<#else>${item.itemNo!""}.</#if>
							        	</#if>	
						        		${item.question}
						        	</div>
								</td>
							</tr>
			            	<tr class="border-b-2">
			            		<td>
			            			<div class="h-option-list" data-multiselect="<#if item.isSingleChoice>false<#else>true</#if>" data-ques-no="<#if item.hasParentQues>${item.parentItemNo}-${item.itemNo}<#else>${item.itemNo}</#if>">
						        		<#list item.opts as option>
						        		<div class="option <#if option.checked>selected</#if> <#if mode == "view">option--disabled</#if>" name="question_${item.id}" data-item-id="${item.id}" data-option-id="${option.id}" data-score="${option.score}">
						        			${option.optionText}
					        			</div>
						        		</#list>
						        	</div>
			            		</td>
			            	</tr>
			            <#else>
				            <#list item.opts as option>
				                <tr class="<#if option_index == (item.opts?size - 1) && item_index != (scale.items?size -1) > border-b-2</#if>">
				                    <#if option_index == 0>
				                        <td rowspan="${item.opts?size}" class="question-cell">
				                        	<#if item.itemNo?? && item.itemNo?has_content>
											  	<#if item.hasParentQues>(${item.itemNo})<#else>${item.itemNo!""}.</#if>
											</#if>
											${item.question}
			                        	</td>
				                    </#if>
				                    <td>${option.optionText}</td>
				                    <td class="radio-cell" data-ques-no="${item.itemNo!""}">
				                        <input type="radio" name="question_${item.id}" data-item-id="${item.id}" data-item-no="${item.itemNo!""}" data-option-id="${option.id}" data-score="${option.score}" <#if option.checked>checked</#if> <#if mode == "view">disabled</#if> >
				                    </td>
				                </tr>
				            </#list>
			            </#if>
	            	<#else>
		            	<tr class="<#if item_index != (scale.items?size -1) > border-b-2</#if>">
	                        <td colspan="3" class="question-cell">
	                        	<#if item.itemNo?? && item.itemNo?has_content>
								  	<#if item.hasParentQues>(${item.itemNo})<#else>${item.itemNo}.</#if>
								</#if>
								${item.question}
                        	</td>
		                </tr>
		            </#if>
		        </#list>
			</table>
			</#if>
			<#if mode == "edit">
			<div class="btn form-send">完成送出</div>
			</#if>
		</div>
		<#else> <#-- 為混和量表時 -->
		<div class="slider-ques-container overflowY">
			<#list scale.sections as section>
			<div class="section-blk" data-section="${section.id}">
				<div class="section-title">測驗項目 ${section.sectionNo}.${section.title!""}</div>
				<#if section.note?has_content>
				<div class="section-note">${section.note!""}</div>
				</#if>
				<table class="default-table auto-layout with-border">
					<tr class="t-title">
						<td>評量項目</td>
						<#if (section.evaluationTypes?size > 0)>
							<#list section.evaluationTypes as evaluationType>
								<td>${evaluationType!""}</td>
							</#list>
						</#if>
					</tr>
					<#list section.items as item>
						<#assign col = item.questionEvaluationTypes?size + 2>
						<#if item.note?has_content>
							<tr class="note">							
								<td colspan="${col}">提醒：${item.note}</td>
							</tr>
						</#if>
						<tr>
							<td <#if (item.questionEvaluationTypes?size == 0 )>colspan="${col}"</#if>>
								<div class="ques-flex d-flex" >
								    <span>
								    	<#if item.itemNo?? && item.itemNo?has_content>
										  	<#if item.hasParentQues>(${item.itemNo})<#else>${item.itemNo}.</#if>
										</#if>
							    	</span>
								    <div>${item.question}</div>
							  	</div>
							</td>
							
							<#if item.questionEvaluationTypes?? && (item.questionEvaluationTypes?size > 0)>
								<#list item.questionEvaluationTypes as 	qeType>
								<td class="radio-cell" data-ques-no="${item.itemNo!""}">
									<#list qeType.opts as opt>
									<label class="radio-option">
			                    		<input type="radio" name="question_${item.id}" data-item-no="${item.itemNo!""}" data-item-id="${item.id}" data-option-id="${opt.id}" data-score="${opt.score}" <#if opt.checked>checked</#if> <#if mode == "view">disabled</#if> >
			                    		<span>${opt.optionText}</span>
			                    	</label>
									</#list>
								</td>
								</#list>
							</#if>
						</tr>
					</#list>
				</table>
			</div>
			</#list>
			<#if mode == "edit">
			<div class="btn form-send">完成送出</div>
			</#if>
		</div>
		</#if>		
	<#else>
	<#if message?exists >
		<#if message == "nextStepMessage">
			<div class="info-message">
				<i class="fa fa-hand-point-right"></i>
				<span>無需填寫評估量表，可點選【下一步】跳過</span>
			</div>
			<#elseif message == "emptyMessage">
			<div class="info-message">
				<i class="fa fa-eye-slash"></i>
				<span>如需填寫/檢視評估量表，請點選左側紀錄</span>
			</div>
			<#elseif message == "addMessage">
			<div class="info-message">
				<i class="fa fa-file-circle-plus"></i>
				<span>如需填寫/檢視評估量表，請點選【新增量表】</span>
			</div>
			</#if>
		</#if>
	</#if>
	<link href="${base}/style/imas/widget/rSlider.min.css" rel="stylesheet" type="text/css">
	<script>
	var $ = jQuery.noConflict();
	var loaded = false;
	
	$(document).ready(function() {
		<#if scale?exists && scale.type == "scale">
		$.when(
			$.Deferred(function (deferred) {
				if (typeof rSlider !== 'undefined') {
					deferred.resolve();
				} else {
					var checkPlugin = setInterval(function () {
						if (typeof rSlider !== 'undefined') {
							clearInterval(checkPlugin);
							deferred.resolve();
						} else {
							$import("${base}/script/imas/widget/rSlider.min.js");
						}
					}, 100); // 每 100 毫秒檢查一次
				}
			})
		).done(function () {
			if (!loaded) {
				initRSliders();
				loaded = true;
			}
		});
		
		function initRSliders() {
			var sliders = document.querySelectorAll('.slider');
	
			sliders.forEach(function(element) {
			    new rSlider({
			        target: element,
			        values: {
			        	min: parseInt(element.dataset.scoreMin), 
	            		max: parseInt(element.dataset.scoreMax)
			        },
			        step: 1,
			        scale: true,
			        range: false,
			        <#if mode == "view">
			        width: '100%',
			        disabled: true,
			        <#else>
			        width: '80%',
			        disabled: false,
			        </#if>
			        leftText: element.dataset.labelLeft,
					rightText: element.dataset.labelRight,
			        set: [parseInt(element.dataset.score)],
			        tooltip: false,	        
			        onChange: function (vals) {
			        	$(element).attr("data-score", vals);
			        }
			    });
			});
		}
		
		</#if>
		
		$(".h-option-list .option:not(.option--disabled)").click(function(){
			var option = $(this);
			var list = option.closest(".h-option-list");
		  	var isMulti = list.data("multiselect");
		  	
		  	if (isMulti) {
			    // 複選邏輯：點擊已選的就取消選取
			    option.toggleClass("selected");
	   		} else {
			    if (option.hasClass("selected")) {
			      	// 單選題，點擊已選的選項 → 取消選取
			      	option.removeClass("selected");
			    } else {
			      	// 單選題，清除其他選取，選取目前的
			      	list.find(".option").removeClass("selected");
			      	option.addClass("selected");
			    }
		  	}
		});
	});
	
	<#if mode?? && mode == "edit">
	$(".form-send").click(function(e){
		e.preventDefault();
		
		<#if scale?exists>
			<#if scale.type != "multi_evaluation">
				var missingNos = [];
			    var itemNoMap = {};
				
			    $('input[type="radio"]:not(.ques-radio), .h-option-list .option').each(function () {
			        var itemId = $(this).data('item-id');
			        var quesNo = $(this).parent().data('ques-no');
					
			        if (itemId && !itemNoMap[itemId]) {
			          	itemNoMap[itemId] = quesNo;
			        }
		      	});
		
		      	$.each(itemNoMap, function (itemId, quesNo) {
		      		var radioObj = $('input[type="radio"][data-item-id="' + itemId + '"]');
		      		var optObj = $('.option[data-item-id="' + itemId + '"].selected');
		        	var isChecked = radioObj.is(':checked');
		        	var isSelected = optObj.length > 0;
			        
			        if(radioObj.length > 0){
			        	if(!isChecked) missingNos.push(itemId);
			        }else{
			        	if(!isSelected) missingNos.push(itemId);
			        }
			        
			        //if(radioObj.length > 0 && !isChecked) missingNos.push(itemId);
			        //if(!isSelected) missingNos.push(itemId);
		      	});
		      	
		      	if (missingNos.length > 0) {
		      		var groupedMissing = {};
		      		
		      		missingNos.forEach(function (itemId) {
					    // 找出 section（如果有）
					    var quesNo = $('input[type="radio"][data-item-id="' + itemId + '"], .option[data-item-id="' + itemId + '"]').parent().data("ques-no");
					    var sectionBlock = $('input[type="radio"][data-item-id="' + itemId + '"], .option[data-item-id="' + itemId + '"]').closest('.section-blk');
					    var sectionTitle = sectionBlock.length > 0? sectionBlock.find('.section-title').text().trim() : "未分類";
					    // 歸類進群組
					    if (!groupedMissing[sectionTitle]) {
					      	groupedMissing[sectionTitle] = [];
					    }
					    groupedMissing[sectionTitle].push(quesNo);
				  	});
		      				      	
			      	var message = "您有 " + missingNos.length + " 題尚未作答，請確認所有題目皆已填寫。請填答以下題號：\n";
			      	
			      	if (Object.keys(groupedMissing).length === 1 && groupedMissing["未分類"]) {
					    message += groupedMissing["未分類"].join(", ");
				  	} else {
					    $.each(groupedMissing, function (section, quesNos) {
					      message += "【" + section + "】\n題號：" + quesNos.join(", ") + "\n";
					    });
				  	}
			      	
			      	//message += missingNos.join(", ");
			      	//message += "第 " + missingNos.join(" 題、第 ") + " 題";
			      	swal("送出失敗", message, "error");
			      	return;
			    }
		    </#if>
		</#if>
		
		confirmCheck("送出確認", "您確認要送出此評估量表嗎?\n送出前請再次確認每道問題是否有填寫完畢\n送出後即無法修改!", "warning", "btn-info", "送出", "取消", function(confirmed){
			if(confirmed){
				var resultArr = [];
				var totalScore = 0;
				<#if scale?exists>
					<#if scale.type == "binary" || scale.type == "multiple_choice">
						<#if (scale.sections?exists) && (scale.sections?size >0 ) >
							$('.slider-ques-container .section-blk').each(function() {
							    var sectionId = $(this).data('section');
							    var sectionResults = [];
							    var sectionScore = 0;
							
							    $(this).find('input[type="radio"]:checked, .h-option-list .option.selected').each(function() {
							      	var score = parseFloat($(this).data('score')) || 0;
							      	var result = {"item": $(this).data('itemId'), "option": $(this).data('optionId'), "score": score};
							      	sectionResults.push(result);
							      	sectionScore += score;
							    });
							
							    // Push 每個 section 的結果到總結果陣列（可依需求調整格式）
							    resultArr.push({
							      	"section": sectionId,
							      	"sectionResults": sectionResults,
							      	"sectionScore": sectionScore
							    });
							
							    totalScore += sectionScore;
						  	});
						<#else>
							$('.slider-ques-container input[type="radio"]:checked, .h-option-list .option.selected').each(function() {
								var score = parseFloat($(this).data('score')) || 0 ;
								var result = {"item": $(this).data('itemId'), "option": $(this).data('optionId'), "score": score};
								resultArr.push(result);
							    totalScore += score;	    
							});
						</#if>
					
					<#elseif scale.type == "scale">
						$('.slider').each(function() {
							var score = parseFloat($(this).data('score')) || 0 ;
							var result = {"item": $(this).data('itemId'), "option": null, "score": score};
							resultArr.push(result);
						    totalScore += score;
						});
						
						$('.h-option-list .option.selected').each(function() {
							var score = parseFloat($(this).data('score')) || 0 ;
							var result = {"item": $(this).data('itemId'), "option": $(this).data('optionId'), "score": score};
							resultArr.push(result);
						    totalScore += score;	    
						});
					</#if>
				
				var postData = {"assessmentId": ${assessmentId!""}, "patientId": "${formId!""}", "therapistId": <#if isFromPatient?? && isFromPatient >null<#else>${currentUser.id!""}</#if>, <#if (scale.sections?exists) && (scale.sections?size >0 ) >"sectionItemResults"<#else>"itemResults"</#if>: resultArr, "totalScore": totalScore, "showList": true};
				console.log("create Assessment postData: ", postData);
				var result = wg.evalForm.getJson(JSON.stringify(postData), "/Assessment/api/createAssessmentResult");
				if(result.success){
					showAssessmentList(result.data, result.assessmentId);
					swal.close();
				}
				</#if>
			}
		});	
	});
	</#if>
	
	</script>
	
	<style>
	.w-99{
		width: 99.5% !important;
	}

	.auto-layout{
		table-layout: auto;
		border-collapse: collapse;
	}
	
	.auto-layout tr td:nth-child(odd){
		width: auto !important;
	}

	.case-abbr{
		font-size: 1.6rem;
		color: #4d4d4d;
		background-color: #f2f2f2;
		border-radius: 5px;
		padding: 2px 15px;
	}
	
	.case-abbr:before{
		font-family: 'FontAwesome';
		margin-right: 5px;
		content: '\f4ff';
	}
	
	.evaluation-top-bar{
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.evaluation-title{
		display: inline;
		font-size: 18px;
		font-weight: 600;
	}
	
	.evaluation-hint{
		width: 100%;
		margin-top: 5px;
	}
	
	.evaluation-info{
		color: #664400;
		font-weight: 600;
		font-size: 16px;
	}
	
	.slider-ques-container{
		width: 100%;
		padding: 5px 0px;
		margin-bottom: 10px;
		max-height: 350px;
	}
	
	.modal-body .slider-ques-container{
		max-height: 320px;
	}
	
	.ques-title{
		display: block;
		font-size: 1.5rem;
		font-weight: 600;
		margin-bottom: 5px;
	}

	.sub-info{
		display: flex;
		justify-content: space-between;
		align-items: center;
		gap: 5px;
	}
	
	/* rSlider擴充css屬性修正 */
	.slider-container {
		display: flex;
		align-items: center;
		justify-content: space-between;
		width: 99.5%;
	}

	.slider-left-text,
	.slider-right-text {
		white-space: nowrap;
		/*margin: 0 15px;*/
	}
	
	.slider-left-text{
		margin-right: 20px;
	}
	
	.slider-right-text {
		margin-left: 20px;
	}

	.rs-container {
		flex-grow: 1;
		position: relative;
		display: flex;
		align-items: center;
	}
	
	.rs-scale {
	    width: 100%; 
	}
	
	.rs-container .rs-scale span{
		float: none;
		display: inline-block;
	}
	
	/* 其餘設定調整 */
	.sub-info > .badge-tag{
		white-space: nowrap !important;
		display: inline-table !important;
	}
	
	.with-border tr td{
		border: 0.5px solid #b3b3b3 !important;
	}
	
	.with-border tr td:not(.question-cell){
		font-weight: normal !important;
	}
	
	.default-table tr td.question-cell{
		font-weight: bold;
        background-color: #f2f2f2;
        min-width: 15%;
        max-width: 23%;
	}
	
	.default-table tr td.radio-cell{
		text-align: left;
		/*width: 18%;*/
		width: 1px;
		white-space: nowrap;
		position: relative;
	}
    
    .radio-cell input[type="radio"]:checked::before {
        background-color: #666;
    }
    
    .radio-cell input[type="radio"]:checked::after {
        content: '';
        display: inline-block;
        width: 15px;
        height: 15px;
        background-color: #009E75;
        border-radius: 50%;
        position: absolute;
        top: 50%;
    	left: 50%;
    	transform: translate(-50%, -50%);
    }
	
	.radio-cell .radio-option {
		display: flex;
		align-items: center;
		justify-content: flex-start;
		margin-bottom: 8px;
		position: relative;
	}
	
	.radio-cell .radio-option:last-child {
		margin-bottom: 0px;
	}
	
	.radio-cell input[type="radio"] {
		width: 20px;
		height: 20px;
		margin: 0 8px 0 0;
		position: relative;    
	}
	
	/* section 內容調整 */
	.section-blk{
		width: 99.5%;
		margin-bottom: 15px;
	}
	
	.section-blk .section-title,
	.section-blk .section-note{
		display: block;
		font-size: 1.5rem;
		font-weight: bold;
		color: #666666;
		margin-bottom: 5px;
	}
	
	.t-title td{
		text-align: center;
	}
	
	.q-no{
		width: 5% !important;
	}
	
	tr.note td{
		color: #005cb3;
		background: #e6f4ff;
	}
	
	.ques-flex span{
		flex-shrink: 0;
		width: 1.5em;
	}
	
	/* 橫向選項樣式設定 */
	.h-question-cell .ques-title {
		margin-bottom: 0px !important;
	}
	
	.sub-ques {
  		text-indent: 0.5em;  		
	}

	.h-question-cell{
		background-color: #f2f2f2;
	}
	
	.h-option-list {
  		display: flex;
  		width: 100%;
  		gap: 3px;
	}

	.h-option-list .option {
		display: flex !important;
		font-size: 1.5rem;
  		flex: 1;
  		text-align: center;
  		border: 1px solid #ccc;
  		padding: 5px;
  		box-sizing: border-box;
  		white-space: normal;
  		word-wrap: break-word;
  		align-items: center;
  		justify-content: center;
	}

	.form-send{
		width: 100%;
		padding: 5px 0;
		margin-top: 10px;
		background-color: #d9d9d9;
	}
	
	.form-send:before{
		font-family: 'FontAwesome';
		content:"\f058";
		margin-right: 5px;
	}
	</style>
</div>
