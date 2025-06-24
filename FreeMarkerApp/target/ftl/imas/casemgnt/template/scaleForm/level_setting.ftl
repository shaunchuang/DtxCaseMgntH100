<#import "/util/spring.ftl" as spring />
  
<div id="level-content">
	<div class="col-md-12">
		<#if scalesForm.levels?has_content >
		<div class="options">
			<#list scalesForm.levels as levels>
			<div class="opt-container">
				<input type="text" class="form-control w-50" value="${levels_index+1}" readonly />
        		<@spring.formInput path="scalesForm.levels[${levels_index}].lowScore" attributes='class="form-control w-100" placeholder="最低分" ' />
            	<@spring.formInput path="scalesForm.levels[${levels_index}].highScore" attributes='class="form-control w-100"  placeholder="最高分" ' />
            	<@spring.formInput path="scalesForm.levels[${levels_index}].level" attributes='class="form-control" placeholder="請輸入對應等級說明" ' />
        	</div>
			</#list>
		</div>
		<#else>
		<div class="options"></div>
		</#if>         
    </div>
	<script type="text/javascript" src="${base}/script/woundInfo/jquery-2.2.0.min.js"></script>
	<script type="text/javascript" src="${base}/script/woundInfo/bootstrap.min.js"></script>

	<script>

	$(document).ready(function() {

	});

	</script>
	<style>
	
	</style>
</div>
