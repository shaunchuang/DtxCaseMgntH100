<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "admin.menu.otherMgnt"/></div>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="/ftl/imas/admin/other/phraseMgnt">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "admin.menu.phraseMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/medicalMgnt">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "admin.menu.medicalMgnt"/></span>
					</div>
					<div class="module-blk active" data-src="/ftl/imas/admin/other/deviceMgnt">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "admin.menu.deviceMgnt"/></span>
					</div>					
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="input-group search-group">																		
					<span class="input-group-addon"><@spring.message "device.label.ip.change"/></span>
					<select class="form-control ipCat" aria-describedby="basic-addon1" >
						<option value="" ><@spring.message "device.option.change.hint"/></option>
						<option value="1" ><@spring.message "device.option.ip.local"/></option>
						<option value="2" ><@spring.message "device.option.ip.cloud"/></option>
					</select>
					
					<span class="input-group-addon divide"></span>
					<input type="text" class="form-control sendFrom" aria-describedby="basic-addon1" placeholder="<@spring.message "device.placeholder.ipAddress"/>">	
	
					<span class="input-group-addon btn" onclick="changeQrcode()">
						<i class="fa fa-refresh fa-lg" ></i>
					</span>
				</div>
				<div class="clearfix"></div>
				<div class="col-ms-12 col-md-12 text-center qrcode-blks">
					<div class="qrcode-blk col-xs-12 col-md-3">
						<ul class="qrcode">
							<a class='default-link'>
								<div id="local_ip"></div>
								<h3><@spring.message "device.label.ip.localAddress"/></h3>
								<p></p>
							</a>
						</ul>
					</div>
					<div class="qrcode-blk col-sm-12 col-md-3">
						<ul class="qrcode">
							<a class='default-link'>
								<div id="cloud_ip"></div>
								<h3><@spring.message "device.label.ip.cloudAddress"/></h3>
								<p></p>
							</a>
						</ul>
					</div>     
				</div>
				<div class="clearfix"></div>
				<div class="col-xs-12 pd-h-0 hint">
					<b><@spring.message "device.label.illustrate"/></b>
					<ul>
						<li><@spring.message "device.label.illustrate.text1"/></li>
						<li><@spring.message "device.label.illustrate.text2"/></li>						
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>

<script>

$(document).ready(function(){
	readQrcode();
});

$(".ipCat").change(function(){
	var obj = $(".sendFrom");
	if($(this).val() == 1){
		obj.val("http://");
	}
	else if($(this).val() == 2){
		obj.val("https://");
	}
});

function readQrcode(){
	var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getIPAddress");
	if(result.success){		
		setURI('local_ip', result.ipAddress);
	}	
	setURI('cloud_ip', '${cloudAddress}');
}

function setURI(id, ipAddress){
	var uri = ipAddress + "?location=${__field}";
	$('#'+id).find("canvas").remove();
	$('#'+id).qrcode({ text : uri });
	$('#'+id).parent().attr('href', uri);
	$('#'+id).parent("a").find("p").html(ipAddress);
}

function changeQrcode(){
	var cat = $(".ipCat").val();
	var sendFrom = $(".sendFrom").val();
	if(cat == 1){
		setURI('local_ip', sendFrom);
	}
	else if(cat == 2){
		setURI('cloud_ip', sendFrom);
	}
}

</script>	

<style>
.qrcode-blks{
	padding: 3rem 0;
	display: flex;
    justify-content: center;
}

.qrcode-blk ul{
	list-style: none outside none;
	padding: 0;
	margin-bottom: 0;
	width: 100%;
	height: 250px;
	text-align: center;	
	margin-bottom: 10px;
	border-radius: 10px;
	background: #fff;
	border: 1.5px solid grey;
	box-shadow: 0 6px 2px -2px grey;
}

.qrcode-blk ul:hover{
	background: #f2f2f2;
}

.qrcode{
	display: table;
}

.qrcode-blk ul a{
	display: table-cell;
	vertical-align: middle;
}

.qrcode-blk ul a:hover{
	cursor: pointer;
	text-decoration: none;
}

.qrcode-blk ul a img{
	width: 100px;
	height: 100px;	
}

.qrcode-blk ul a h3{
	margin-top: 20px;
	font-weight: 600;
}

.default-link{
	color: currentColor;
	cursor: default;
	text-decoration: none;
	opacity: 0.8;
}

.hint{
	background: #e6e6e6;
	padding: 10px;
	font-size: 16px;
}

.hint b, .hint ul{
	display: block;
}

.hint ul{
	margin: 0;
}

.default-link p{
	font-size: 16px ;
	margin: 0;
}
</style>

<#--<#include "/skins/imas/casemgnt/socket.ftl" />-->
<#include "/imas/widget/widget.ftl" />