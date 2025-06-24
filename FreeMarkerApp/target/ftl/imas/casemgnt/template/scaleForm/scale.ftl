<#import "/util/spring.ftl" as spring />
  
<div id="item-content">
	<#if scalesForm.items?has_content >
	<#list scalesForm.items as items>
	<div class="row ques-blk" data-ques="${items.itemNo}">
		<span class="cleanBlkBtn"><i class="fa fa-circle-xmark"></i></span>
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
	            <label class="form-label">最低分數</label>
	            <@spring.formInput path="scalesForm.items[${items_index}].scoreMin" attributes='class="form-control" placeholder="請輸入最低分數" ' fieldType="number" />
	        </div>
	        <div class="mg-b-10">
	            <label class="form-label">左側標籤文字(含意)</label>
	            <@spring.formInput path="scalesForm.items[${items_index}].labelLeft" attributes='class="form-control" placeholder="請輸入左側標籤文字" ' />
	        </div>
	    </div>
	    <div class="col-md-6">
	        <div class="mg-b-10">
	            <label class="form-label">最高分數</label>
	            <@spring.formInput path="scalesForm.items[${items_index}].scoreMax" attributes='class="form-control" placeholder="請輸入最高分數" ' fieldType="number" />
	        </div>
	        <div class="mg-b-10">
	            <label class="form-label">右側標籤文字(含意)</label>
	            <@spring.formInput path="scalesForm.items[${items_index}].labelRight" attributes='class="form-control" placeholder="請輸入右側標籤文字" ' />
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
	            <label class="form-label">最低分數</label>
	            <@spring.formInput path="scalesForm.items[0].scoreMin" attributes='class="form-control" placeholder="請輸入最低分數" ' fieldType="number" />
	        </div>
	        <div class="mg-b-10">
	            <label class="form-label">左側標籤文字(含意)</label>
	            <@spring.formInput path="scalesForm.items[0].labelLeft" attributes='class="form-control" placeholder="請輸入左側標籤文字" ' />
	        </div>
	    </div>
	    <div class="col-md-6">
	        <div class="mg-b-10">
	            <label class="form-label">最高分數</label>
	            <@spring.formInput path="scalesForm.items[0].scoreMax" attributes='class="form-control" placeholder="請輸入最高分數" ' fieldType="number" />
	        </div>
	        <div class="mg-b-10">
	            <label class="form-label">右側標籤文字(含意)</label>
	            <@spring.formInput path="scalesForm.items[0].labelRight" attributes='class="form-control" placeholder="請輸入右側標籤文字" ' />
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
