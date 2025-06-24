<#import "/util/spring.ftl" as spring />

<div id="content">	
	<div class="therapy-cat">
		<div class="opt" data-alias="pt">物理治療</div>
		<div class="opt" data-alias="ot">職能治療</div>
		<div class="opt" data-alias="st">語言治療</div>
		<div class="opt" data-alias="ps">心理治療<span class="complete-indicator"></span></div>
	</div>
	<div id="data-container" class="card pd-10"></div>
	
	<script>
	
	$(document).ready(function(){
		
		wg.template.updateNewPageContent('data-container', 'data-content', {}, '/ftl/imas/admin/dataForm?viewer=ps');
	});
	
	//選擇治療類別觸發行為
	$(".therapy-cat .opt").click(function(){
		$(".therapy-cat .opt").removeClass("selected");
		$(this).toggleClass("selected");
		
		var alias = $(this).data("alias");
		
		wg.template.updateNewPageContent('data-container', 'data-content', {}, '/ftl/imas/admin/dataForm?viewer=' + alias);

	});
	
	</script>
	
	<style>
	
	.therapy-cat{
		display: flex;
	  	width: 100%;
	  	border: none;
	  	padding: 8px 4px;
	  	margin-bottom: 10px;
	  	background-color: #e6e6e6;
	  	border-radius: 4px;
	}
	
	.therapy-cat .opt {
	  	min-width: 100px;
	  	padding: 2px 10px;
	  	border-radius: 4px;
	  	text-align: center;
	  	position: relative;
	  	display: flex;
	  	align-items: center;
	  	justify-content: center;
	  	gap: 5px;
	  	transition: all 0.3s ease;
	}
	
	.therapy-cat .opt:not(:last-child) {
	  	border-right: 1px solid #8c8c8c;
	}
	
	.therapy-cat .opt:hover,
	.therapy-cat .opt.selected{
		background-color: #bfbfbf;
		font-weight: 600;
		cursor: pointer;		
	}
	
	.therapy-cat .opt:hover{
		transform: translateY(-2px);
	}
	
	.therapy-cat .opt.selected{
		background-color: #ffffff;
	}
	
	.therapy-cat .opt.selected {
        background-color: #ffffff;
        box-shadow: 0 2px 6px rgba(0,0,0,0.15); /* 選中時的陰影 */
        z-index: 1; /* 確保選中項在前面 */
    }
	
	.complete-indicator {
        display: inline-block; /* 預設為顯示 */
        width: 5px; /* 指示點的大小 */
        height: 5px;
        background-color: #009970;
        border-radius: 50%; /* 圓形 */
        box-shadow: 0 0 0 2px rgba(0, 203, 150, 0.3); /* 光暈效果 */
        position: relative; /* 相對於文本定位 */
        margin-left: 5px; /* 與文本的間距 */
        vertical-align: middle; /* 垂直居中文本 */
        transition: background-color 0.3s ease;
    }
	
	</style>
</div>