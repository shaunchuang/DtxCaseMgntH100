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
	    <div class="col-md-6">
			<div class="mg-b-10">
		        <label class="form-label">選項1</label>
		        <@spring.formInput path="scalesForm.items[${items_index}].opts[0].optionText" attributes='class="form-control" placeholder="請輸入選項1文字" ' />
		    </div>
		    <div class="mg-b-10">
		        <label class="form-label">對應分數</label>
		        <@spring.formInput path="scalesForm.items[${items_index}].opts[0].score" attributes='class="form-control" placeholder="請輸入對應分數" min="0" max="20" ' fieldType="number" />
		    </div>
	    </div>
	    <div class="col-md-6">
			<div class="mg-b-10">
		        <label class="form-label">選項2</label>
		        <@spring.formInput path="scalesForm.items[${items_index}].opts[1].optionText" attributes='class="form-control" placeholder="請輸入選項2文字" ' />
		    </div>
		    <div class="mg-b-10">
		        <label class="form-label">對應分數</label>
		        <@spring.formInput path="scalesForm.items[${items_index}].opts[1].score" attributes='class="form-control" placeholder="請輸入對應分數" min="0" max="20" ' fieldType="number" />
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
	    <div class="col-md-6">
			<div class="mg-b-10">
		        <label class="form-label">選項1</label>
		        <@spring.formInput path="scalesForm.items[0].opts[0].optionText" attributes='class="form-control" placeholder="請輸入選項1文字" ' />
		    </div>
		    <div class="mg-b-10">
		        <label class="form-label">對應分數</label>
		        <@spring.formInput path="scalesForm.items[0].opts[0].score" attributes='class="form-control" placeholder="請輸入對應分數" value="0" min="0" max="20" ' fieldType="number" />
		    </div>
	    </div>
	    <div class="col-md-6">
			<div class="mg-b-10">
		        <label class="form-label">選項2</label>
		        <@spring.formInput path="scalesForm.items[0].opts[1].optionText" attributes='class="form-control" placeholder="請輸入選項2文字" ' />
		    </div>
		    <div class="mg-b-10">
		        <label class="form-label">對應分數</label>
		        <@spring.formInput path="scalesForm.items[0].opts[1].score" attributes='class="form-control" placeholder="請輸入對應分數" value="0" min="0" max="20" ' fieldType="number" />
		    </div>
	    </div>
    </div>
    </#if>
	<script type="text/javascript" src="${base}/script/woundInfo/jquery-2.2.0.min.js"></script>
	<script type="text/javascript" src="${base}/script/woundInfo/bootstrap.min.js"></script>

	<script>

	$(document).ready(function() {

	});
	
	
	
	</script>
	<style>
	
	</style>
</div>
