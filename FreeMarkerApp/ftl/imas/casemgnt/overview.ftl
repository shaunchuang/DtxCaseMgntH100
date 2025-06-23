<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-12 item-title">
					<#if isNewForm?? >
					<div class="item-name"><@spring.message "casemgnt.label.createCase.title"/></div>
					<#else>
					<div class="patient-info">
						<div class="info-block info-title">個案總覽</div>
					    <div class="info-block">
					      <div class="info-l">姓名</div>
					      <div class="info-v">${ptInfo.name!""}</div>
					    </div>
					    <div class="info-block">
					      <div class="info-l">性別</div>
					      <div class="info-v">${ptInfo.gender!""}</div>
					    </div>
					    <div class="info-block">
					      <div class="info-l">年齡</div>
					      <div class="info-v">${ptInfo.age!""}歲</div>
					    </div>
					    <div class="info-block">
					      <div class="info-l">身分證字號</div>
					      <div class="info-v">${ptInfo.idno!""}</div>
					    </div>
					    <div class="info-block">
					      <div class="info-l">自述適應症</div>
					      <div class="info-v">${ptInfo.indication!""}</div>
					    </div>
						<div class="info-block">
					      <div class="info-l">個案狀態</div>
					      <div class="info-v">治療中</div>
					    </div>
					</div>
					</#if>
				</div>
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="control-menu-list">
					<div class="menu active" data-menu="profile">基本資料</div>
					<div class="menu" data-menu="notes">其他紀載</div>
					<div class="menu" data-menu="visits">就診歷程</div>
					<div class="menu" data-menu="assessment">評估結果</div>
					<div class="menu" data-menu="plan">訓練計畫</div>
					<div class="menu" data-menu="analysis">訓練成果分析</div>					
				</div>
				<div class="main-inner pd-h-10 pd-b-10">
					<div id="content-container"></div>
				</div>				
			</div>
		</div>	
	</div>
</body>

<script>

$(document).ready(function(){
	adjustHeight();
	
	wg.template.updateNewPageContent('content-container', 'content', {}, '/ftl/imas/patient/caseForm/profile?patientId=${formId!""}');
});

$(".control-menu-list .menu").click(function(e){
	e.preventDefault();
	var subUrl = $(this).data('menu');
	$(this).parent().find(".menu").removeClass('active');
	$(this).toggleClass('active');

	wg.template.updateNewPageContent('content-container', 'content', {}, '/ftl/imas/patient/caseForm/' + subUrl + '?patientId=${formId!""}');
});
	
</script>

<style>

.main-content{
	padding: 0 10px 10px 10px !important;
	position: relative;
	overflow-y: none !important;
}

.main-inner{
	overflow-x: hidden;
	overflow-y: auto;
	box-sizing: border-box;
}

.info-title{
	font-size: 18px;
	font-weight: 600;
	color: #666666;
	justify-content: center;
}

.item-title{
	gap: 20px;
	align-items: center;
}

.patient-info{
	margin-bottom: 0px !important;
}

</style>

<#include "/imas/widget/widget.ftl" />