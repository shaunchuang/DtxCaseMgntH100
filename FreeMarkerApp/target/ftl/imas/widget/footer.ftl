
		<!--<button id="emergencyButton" type="button" class="btn btn-info pull-right" data-toggle="modal" data-target="#emergencyDialog">緊急按鈕測試</button>-->
		<footer class="main-footer">
			<div class="container">
				<div class="pull-right hidden-xs">
					<b><@spring.message "footer.label.version"/></b>
				</div>
				<@spring.message "footer.label.copyright"/>
			</div><!-- /.container -->
		</footer>
	
	<div style='clear:both;'></div>
	<script>
		//所有mlog-tooltip都自動使用tooltip
		$('.mlog-tooltip').tooltip({
			placement: function(tip, element) {
				return "bottom";
			}
		});
		
		$('[data-toggle="tooltip"]').tooltip({
	    	placement: function(tip, element) {
		        return "bottom";
		    }
	    });
	    //iCheck for checkbox and radio inputs
		$('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
			checkboxClass: 'icheckbox_minimal-blue',
			radioClass: 'iradio_minimal-blue'
		});
		
		/*
		********************************緊急按鈕區塊******************************
		*/
		
		/*
		// 緊急按鈕測試範例
		$('#emergencyButton').click(function(){
			$.ajax({
				type : "POST",
				url : "${base}/device/EmergencyEvent.html",
				data : {
					uid: "admin@itri.org.tw"
				},
				success : function(data) {
					alert(data);
				}
			});
		});
		*/
			
		getEmergencyEvent();
		
		
		//當關閉緊急Modal時，再重複抓到緊急事件
		$(document).on('hide.bs.modal','#emergencyDialog', function () {
			//刪除緊急事件
			$.ajax({
				type : "POST",
				url : "${base}/emergencyEvent/delete",
				data : {
					uid: "<#if currentUser??>${currentUser.id}</#if>",
					senderID: $("#senderID").val()
				},
				dataType: "json",
				success : function(data) {
					setTimeout(getEmergencyEvent, 1000);
				}
			});
		});
		
		//取得緊急按鈕事件
		function getEmergencyEvent(){
			<#if ver=='v3'>
				$.ajax({
					type : "POST",
					url : "${base}/emergencyEvent/list",
					data : {
						uid: "<#if currentUser??>${currentUser.id}</#if>"
					},
					dataType: "json",
					success : function(data) {
						if(data.name){
							$("#emergencySender").html(data.name);
							$("#senderID").val(data.senderID);
							$("#emergencyDialog").modal('show');
						}else{
							//重複request直到抓到緊急事件
							setTimeout(getEmergencyEvent, 1000);
						}
					}
				});
			</#if>
		}
	</script>
	
	<!-- add start by jg_renjie at 20151025 for:增加支持Validform插件的相關文件 -->
    <link rel="stylesheet" href="${base}/plug-in/Validform/css/style.css" type="text/css">
    <link rel="stylesheet" href="${base}/plug-in/Validform/css/tablefrom.css" type="text/css">
    <script type="text/javascript" src="${base}/plug-in/Validform/js/Validform_v5.3.1_min_zh-tw.js"></script>
    <script type="text/javascript" src="${base}/plug-in/Validform/js/Validform_Datatype_zh-tw.js"></script>
    <script type="text/javascript" src="${base}/plug-in/Validform/js/datatype_zh-tw.js"></script>
    <script type="text/javascript" src="${base}/plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
	<!-- add end by jg_renjie at 20151025 for:增加支持Validform插件的相關文件 -->
	
	<script type="text/javascript" src="${base}/plug-in/My97DatePicker/WdatePicker.js"></script>
	<link rel="stylesheet" href="${base}/plug-in/My97DatePicker/skin/WdatePicker.css" type="text/css"></link>
	
    
  </body>
  <!-- Modal -->
  <div class="modal fade" id="emergencyDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
	  <div class="modal-content">
	    <div class="modal-header">
	      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	      <h4 class="modal-title" id="myModalLabel" style='font-size:26px;'>緊急事件</h4>
	    </div>
	    <div class="modal-body" style='font-size:20px;'>
	    	<span id="emergencySender"></span>觸發了緊急按鈕！
	    	<input type="hidden" name="senderID" id="senderID" value=""/>
	    </div>
	    <div class="modal-footer">
        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		</div>
	  </div>
	</div>
  </div>
</html>