<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "chatroom.label.title"/></div>
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
					<#if redirectChatroomUrl?exists && redirectChatroomUrl?has_content>
					<iframe id="roomUrl" src="${redirectChatroomUrl!""}" scrolling="no" ></iframe>
					<#else>
	            	<iframe id="roomUrl" src="${chatroomUrl!""}" scrolling="no" ></iframe>
	            	</#if>
	            </div>
			</div>
		</div>	
	</div>
</body>

<script>


$(document).ready(function(){
	//showMonthLtcRecordList();
	$("iframe").css("height", parseInt($(window).height() - 30).toString() + "px");
});
	
</script>

<style>
iframe{
	width: 100%;
	height: 100%;
	border: 0.5px solid #fff;
}

.main-content div{
	padding-bottom: 10px;
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />