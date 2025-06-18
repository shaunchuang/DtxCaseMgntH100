<#import "/util/spring.ftl" as spring />
  
<div id="item-content">
	<#if scalesForm.items?has_content >
	<#list scalesForm.items as items>
	<div class="row ques-blk" data-ques="${items.itemNo}">
		<div class="col-md-12">
			<div class="mg-b-10">
				<@spring.formHiddenInput path="scalesForm.items[${items_index}].id" />
				<@spring.formHiddenInput path="scalesForm.items[${items_index}].itemNo" />
                <label class="form-label h-color">題目${items.itemNo}</label>
                <div class="ques-container">
                	<@spring.formInput path="scalesForm.items[${items_index}].itemType" attributes='class="form-control w-200" placeholder="問題類型(非必要)" ' />
                	<@spring.formInput path="scalesForm.items[${items_index}].question" attributes='class="form-control" placeholder="請輸入問題內容" ' />
            	</div>
            </div>
		</div>
		<div class="col-md-12">
		    <div class="mg-b-10">
	            <div class="opt-t">
	            	<label class="form-label">請列舉選項</label>
	            	<span class="addopt"><i class="fa fa-circle-plus"></i> 新增選項</span>
            	</div>
            	<#if items.opts?has_content >
	            <div class="options">
	            	<#list items.opts as options>
	            	<div class="opt-container">
	            		<@spring.formInput path="scalesForm.items[${items_index}].opts[${options_index}].optionNo" attributes='class="form-control w-50" readonly ' />
		            	<@spring.formInput path="scalesForm.items[${items_index}].opts[${options_index}].optionText" attributes='class="form-control"  placeholder="請輸入選項文字" ' />
		            	<@spring.formInput path="scalesForm.items[${items_index}].opts[${options_index}].score" attributes='class="form-control w-150" placeholder="請輸入對應分數" min="0" max="20"' fieldType="number" />
	            	</div>
	            	</#list>            	
	            </div>
	            <#else>
	            <div class="options"></div>
	            </#if>
	        </div>
        </div>
	</div>
	</#list>
	<#else>
	<div class="row ques-blk" data-ques="1">
		<div class="col-md-12">
			<div class="mg-b-10">
				<@spring.formHiddenInput path="scalesForm.items[0].itemNo" defaultValue="1" />
                <label class="form-label h-color">題目1</label>
                <div class="ques-container">
                	<@spring.formInput path="scalesForm.items[0].itemType" attributes='class="form-control w-200" placeholder="問題類型(非必要)" ' />
                	<@spring.formInput path="scalesForm.items[0].question" attributes='class="form-control" placeholder="請輸入問題內容" ' />
            	</div>
            </div>
		</div>
		<div class="col-md-12">
		    <div class="mg-b-10">
	            <div class="opt-t">
	            	<label class="form-label">請列舉選項</label>
	            	<span class="addopt"><i class="fa fa-circle-plus"></i> 新增選項</span>
            	</div>
	            <div class="options"></div>
	        </div>
        </div>
	</div>
	</#if>
	<script type="text/javascript" src="${base}/script/woundInfo/jquery-2.2.0.min.js"></script>
	<script type="text/javascript" src="${base}/script/woundInfo/bootstrap.min.js"></script>

	<script>

	$(document).ready(function() {
		$(".ques-blk").find(".addopt").on( 'click', function () {
			var quesNo = $(this).closest(".ques-blk").attr("data-ques");
			if(parseInt(quesNo) === 1){
				var optNo = $(this).closest(".ques-blk").find(".options > .opt-container").length;
				var cnt = '<div class="opt-container">																																				' +
						  '		<input type="text" class="form-control w-50" name="items[' + (quesNo-1) + '].opts[' + optNo + '].optionNo" value="' + (optNo+1) + '" readonly />					' +
						  '		<input type="text" class="form-control" name="items[' + (quesNo-1) + '].opts[' + optNo + '].optionText" placeholder="請輸入選項文字" />									' +
						  '		<input type="number" class="form-control w-150" name="items[' + (quesNo-1) + '].opts[' + optNo + '].score" placeholder="請輸入對應分數" value="0" min="0" max="20" />	' +
						  '</div>																																									' ;	
				$(this).closest(".ques-blk").find(".options").append(cnt);
			}
		});
	});

	</script>
	<style>
	
	</style>
</div>
