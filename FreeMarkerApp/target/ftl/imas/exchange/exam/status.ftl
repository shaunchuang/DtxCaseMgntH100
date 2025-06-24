<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "exam.status.label.title"/></div>
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="col-md-12 pd-h-5 justify-content-between">
	            	<div class="col-md-3 pd-h-0">
	            		<div class="item-status">
	            			<div class="eq-item" data-item="1">
	            				<div class="item-t">
	            					<div class="orange"></div><@spring.message "exam.status.label.foreheadThermometer"/>
            					</div>
	            				<div class="item-c">
	            					<span class="h-color temp">---</span> <@spring.message "exam.status.label.celsius.unit"/>
	            				</div>
	            			</div>
	            			<div class="eq-item" data-item="2">
	            				<div class="item-t">
	            					<div class="orange"></div><@spring.message "exam.status.label.sphygmomanometer"/>
            					</div>
	            				<div class="item-c">
	            					<span class="item-txt"><@spring.message "exam.status.label.mmHg"/></span>
	            					<span class="h-color sbp">---</span> / <span class="h-color dbp">---</span> <@spring.message "exam.status.label.mmHg.unit"/>
	            					<span class="item-txt"><@spring.message "exam.status.label.bpm"/></span>
	            					<span class="h-color bpm">---</span> <@spring.message "exam.status.label.bpm.unit"/>
	            				</div>
	            			</div>
	            			<div class="eq-item" data-item="3">
	            				<div class="item-t">
	            					<div class="orange"></div><@spring.message "exam.status.label.ultrasound"/>
            					</div>
	            				<div class="item-c">
	            					<@spring.message "exam.status.label.uploadedImgs"/><span class="h-color u-images">---</span> <@spring.message "exam.status.label.img.unit"/>
	            				</div>
	            			</div>
	            			<div class="status-hint">
	            				<input type="hidden" class="caseno" value="${caseno!""}" />
	            				<div class="caseInfo"><@spring.message "exam.status.label.case"/><span class="h-color case">${caseName!""}</span></div>
	            				<div class="orange"><@spring.message "exam.status.label.waiting"/></div>
	            				<div class="green"><@spring.message "exam.status.label.connected"/></div>
	            			</div>
	            		</div>
	            	</div>
	            	<div class="col-md-9 pd-h-0 ultra-sound-live">
	            		<div id="capture" style="width: 50%; text-align: center" >
	            			<img id="liveImg" src="${base}/images/404.png" />
            			</div>
	            		<div class="btn-list">
	            			<div class="btn" onclick="capture()">
	            				<i class="fa fa-images" ></i> <@spring.message "exam.status.label.capture"/>
            				</div>
	            			<div class="btn" onclick="doBan()">
	            				<i class="fa fa-crosshairs" ></i> <@spring.message "exam.status.label.freeze"/>
            				</div>
	            			<div class="btn" onclick="releaseBan()">
	            				<i class="fa fa-ban" ></i> <@spring.message "exam.status.label.unfreeze"/>
            				</div>
	            			<!--<div class="btn" data-iframe="true" id="open-google-map" data-src="https://www.lightgalleryjs.com/demos/iframe/">
	            				<i class="fa fa-magnifying-glass-plus"></i> <@spring.message "exam.status.label.enlarge"/>
            				</div>-->
	            		</div>
	            	</div>
	            </div>
			</div>
		</div>	
	</div>
</body>

<script>


$(document).ready(function(){
	lightGallery(document.getElementById('open-google-map'), {
	    selector: 'this',
	    plugins:[lgVideo]
	});
	
	//var postData = {"equipNo": 2, "status": 1, "temp": 35.6, "sbp": 110, "dbp": 150, "bpm": 85, "ultraSoundImages": 2};
	//var postData = {"equipNo": 2, "status": 0};	
	//var data = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/syncConnectStatus");
	//detectConnection("http://10.0.110.2:1000");
	/*console.log("開始");
	$.ajax({
	    url: "http://10.0.110.2:1000",
	    type: "GET",
	    timeout: 3000,
	    success: function(x, t, m) {
	    	console.log("成功:" + x.statusCode);
	    	console.log("成功:" + t);
	    	console.log("成功:" + m);
	    },
	    error: function(x, t, m) {
	    	console.log("失敗:" + x.statusCode);
	    	console.log("失敗:" + t);
	    	console.log("失敗:" + m);
	        if(t === "timeout") {
	            $("#liveImg").attr("src", "${base}/images/404.png");
	        } else {
	            console.log("錯誤:" + t);
	        }
	    }
	});*/
});

function detectConnection(url) {
	console.log(url);
    $.post(url).success(function(data, status, headers, config) {
      	console.log("成功：" + status);
    }).error(function(data, status, headers, config) {
      	console.log("失敗：" + status);
    });
}

function releaseBan(){

	$.ajax({
	    url: "http://10.0.110.2:1000/?action=command&command=freeze&plugin=0&id=90003&value=0",
	    type: "GET",
	    dataType: "json",
	    success: function(response) { console.log(response); },
	    error: function(x, t, m) {
	    	console.log(x.statusCode);
	    	console.log(t);
	    	console.log(m);
	    	$("#liveImg").attr('src', "http://10.0.110.2:1000/?action=stream");
			$(".eq-item[data-item='3']").find(".item-t div").removeClass().addClass("green");
	    	/*
	    	if(t != 'error'){
				$("#liveImg").attr('src', "http://10.0.110.2:1000/?action=stream");
				$(".eq-item[data-item='3']").find(".item-t div").removeClass().addClass("green");
	    	}else{
	    		swal("<@spring.message "exam.status.capture.success.title"/>", "<@spring.message "exam.status.capture.success.text"/>", "error" );
	    	}*/
	    }
	});
}

function doBan(){

	$.ajax({
	    url: "http://10.0.110.2:1000/?action=command&command=freeze&plugin=0&id=90003&value=1",
	    type: "GET",
	    dataType: "json",
	    success: function(response) { console.log(response); },
	    error: function(x, t, m) {
	    	console.log(x.statusCode);
	    	console.log(t);
	    	console.log(m);
	    	$(".eq-item[data-item='3']").find(".item-t div").removeClass().addClass("green");
	    	/*
	    	if(t != 'error'){
				//$("#liveImg").attr('src', "${base}/images/404.png");
				$(".eq-item[data-item='3']").find(".item-t div").removeClass().addClass("green");
	    	}else{
	    		swal("<@spring.message "exam.status.capture.success.title"/>", "<@spring.message "exam.status.capture.success.text"/>", "error" );
	    	}*/
	    }
	});
}

function capture(){
	var caseName = $(".case").html();
	if(caseName != ""){
		showHintSwal("<@spring.message "exam.status.capture.saving.text"/>");
		
		var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/localSaveUltrasoundFile?location=${__field}");
		if(result.success){
			//swal.close();
			console.log(result.existImgNum);
			$(".u-images").html(result.existImgNum);
			swal("<@spring.message "exam.status.capture.success.title"/>", "<@spring.message "exam.status.capture.success.text"/> [ " + caseName + " ] ", "success" );
		}
	}	
}
	
			
</script>

<style>
iframe, .item-status{
	width: 100%;
	height: calc(100% - 90px);
	border: 0.5px solid #cccccc;
}

.ultra-sound-live{
	position: relative;
	display: flex;
	justify-content: center;
	background-color: #737373;
	height: calc(100% - 90px);
}

.ultra-sound-live .btn-list{
	position: absolute;
	right: 30px;
	top: 10px;
    background-color: #737373;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    padding: 10px 5px;
    border-radius: 5px;
}

.btn-list .btn{
	width: 130px;
	background: #fff;
	padding: 5px;
	font-size: 16px;
	margin-bottom: 5px;
}

.btn-list .btn:hover{
	background: #e6e6e6;
}

.item-status{
	padding: 5px 10px;
	text-align: center;
	position: relative;		
}

.item-t, .item-c{
	width: 100%;
}

.item-c{
	font-size: 18px;
	word-break: keep-all;
	padding: 10px 0;
}

.item-c span.h-color{
	font-size: 26px;
}

span.item-txt{
	font-size: 18px;
	display: block;
}

.item-t{	
	font-size: 20px;
	font-weight: 600;
	background: #e6e6e6;
	padding: 5px 0;	
}

.item-t > div {
    width: 20px;
    height: 20px;
    display: inline-block;
    margin-right: 10px;
    border-radius: 100%;
    background-color: gray;
    animation-duration: 2s;
    animation-iteration-count: infinite;
    animation-timing-function: linear;
    vertical-align: text-bottom;
}
  
.item-t .orange {
    animation-name: orange;
}

.item-t .green {
    animation-name: green;
}

.item-t .pink {
    animation-name: pink;
}

@keyframes orange {
    0%,
    66% {
      background-color: gray;
    }
    67%,
    100% {
      background-color: orange;
    }
}

@keyframes green {
    0%,
    66% {
      background-color: gray;
    }
    67%,
    100% {
      background-color: green;
    }
}

@keyframes pink {
    0%,
    66% {
      background-color: gray;
    }
    67%,
    100% {
      background-color: #ff8080;
    }
}

.status-hint{
	left: 0;
  	right: 0;
	position: absolute;
	font-size: 16px;
	bottom: 10px;
	text-align: center;
}

.status-hint div{
	display: inline-block;
}

.status-hint .caseInfo{
	display: block;
}

.status-hint .orange:before,
.status-hint .green:before,
.status-hint .pink:before{
	font-family: 'FontAwesome';
	content: '\f111';
	margin-right: 5px;
}

.status-hint .orange:before{	
	color: orange;
}

.status-hint .green:before{
	color: green;
}

.status-hint .pink:before{
	color: #ff8080;
}

#liveImg{
	width: 100%;
	height: 100%;	
}
</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />