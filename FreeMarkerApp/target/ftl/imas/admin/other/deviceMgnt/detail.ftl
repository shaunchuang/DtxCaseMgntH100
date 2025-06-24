<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "admin.menu.otherMgnt"/></div>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="/ftl/imas/admin/other/phraseMgnt">
						<i class="fa fa-quote-left fa-lg"></i>
						<span><@spring.message "admin.menu.phraseMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/scaleMgnt">
						<i class="fa fa-table-list fa-lg"></i>
						<span><@spring.message "admin.menu.scaleMgnt"/></span>
					</div>
					<div class="module-blk active" data-src="/ftl/imas/admin/other/deviceMgnt">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "admin.menu.deviceMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/lessonMgnt">
						<i class="fa fa-upload fa-lg"></i>
						<span><@spring.message "admin.menu.lessonMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/profitMgnt">
						<i class="fa fa-coins fa-lg"></i>
						<span><@spring.message "admin.menu.profitMgnt"/></span>
					</div>
					<div class="module-blk" data-src="/ftl/imas/admin/other/medicalMgnt">
						<i class="fa fa-pills fa-lg"></i>
						<span><@spring.message "admin.menu.medicalMgnt"/></span>
					</div>										
				</div>				         
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<#assign isNew = isNewForm>
				<#if isNew>
				<form class="form" id="phraseForm" action="${base}/employee/PhraseMng/doCreatePhrase" method="POST">
				<#else>
				<form class="form" id="phraseForm" action="${base}/employee/PhraseMng/doEditPhrase" method="POST">
				</#if>
					<@spring.bind "wgPhrase" />
					<#if !isNew>
					<@spring.formHiddenInput path="wgPhrase.id" />
					<@spring.formHiddenInput path="wgPhrase.createTime" />
					</#if>
					<table class="default-table">
						<#if !isNew>
						<tr>
							<td><@spring.message "phrase.detail.label.id"/></td>
							<td>
								<@spring.formInput path="wgPhrase.id" attributes='class="form-control" disabled="disabled"' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "phrase.detail.label.attribute"/></td>
							<td>
								<#assign cat = wgPhrase.phraseCat.id>
								<#if cat == 1>
								<span><@spring.message "phrase.detail.label.system"/></span>
								<#else>
								<span><@spring.message "phrase.detail.label.personal"/></span>
								</#if>
							</td>
						</tr>
						<#else>
						<tr>
							<td><@spring.message "phrase.detail.label.attribute"/></td>
							<td>
								<select id="phraseCat" name="phraseCat" class="form-control">
									<option value="2"><@spring.message "phrase.detail.label.personal"/></option>
								</select>
							</td>
						</tr>
						</#if>
						<tr>
							<td><@spring.message "phrase.detail.label.quickcode"/></td>
							<td>
								<@spring.formInput path="wgPhrase.quickNo" attributes='class="form-control" ' />
							</td>
						</tr>
						<tr>
							<td><@spring.message "phrase.detail.label.content"/></td>
							<td>
								<@spring.formTextarea path="wgPhrase.content" attributes='class="form-control" ' />
								<div class="characters">
									<span class="keyChar">°C</span>
									<span class="keyChar">c.c.</span>
									<span class="keyChar">cm</span>
									<span class="keyChar">gm</span>
									<span class="keyChar">ml</span>
									<span class="keyChar">mg/dl</span>
									<span class="keyChar">mmHg</span>
									<span class="keyChar">，</span>
									<span class="keyChar">；</span>
									<span class="keyChar">。</span>
									<span class="keyChar">、</span>
									<span class="keyChar">／</span>
									<span class="keyChar">＃</span>
									<span class="keyChar">x</span>
									<span class="keyChar">＜</span>
									<span class="keyChar">＞</span>
									<span class="keyChar">%</span>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="footer-btn-list">
									<#if !isNew>
									<button class="func-btn del-btn"><i class="fa fa-trash-can"></i> <@spring.message "admin.button.delete"/></button>
									</#if>
									<#if isNew>
									<button type="submit" class="func-btn"><i class="fa fa-save"></i> <@spring.message "admin.button.add"/></button>
									<#else>
									<button type="submit" class="func-btn"><i class="fa fa-save"></i> <@spring.message "admin.button.save"/></button>
									</#if>
									<button class="goback func-btn"><i class="fa fa-circle-xmark"></i> <@spring.message "admin.button.cancel"/></button>
								</div>	
							</td>
						</tr>					
					</table>
				</form>
			</div>
		</div>	
	</div>
</body>

<script>

$(document).ready(function(){
	mlog.form.validate({
		selector : "#roleForm",
		errorLabelContainer : "#error",
		wrapper: 'li',
		onfocusout : false,
		onkeyup : false,
		onclick : false,
		success : function(){
			mlog.utils.scrollTop();
		}
	});
	
	$(".keyChar").click(function(){
		insertAfterCursor($("textarea"), $(this).text());
	});
});

$(".goback").click(function(e){
	e.preventDefault();
	window.location = "${base}/${__lang}/division/web/admin/other/phraseMgnt";
});

$(".del-btn").click(function(e){
	e.preventDefault();
	confirmCheck("<@spring.message "phrase.detail.confirm.title"/>", "<@spring.message "phrase.detail.confirm.text"/>", "warning", "btn-info", "確認", "取消", function(confirmed){
		if(confirmed){
			var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/employee/PhraseMng/doDeletePhrase?id=${wgPhrase.id!""}");
			if(result.success){
				swal({
				  	title: "<@spring.message "phrase.detail.delete.success.title"/>",
				  	text: "<@spring.message "phrase.detail.delete.success.text"/>",
				  	type: "success",
				  	timer: 1500,
				  	showConfirmButton: false
				},function(){
				    window.location.href = "${base}/${__lang}/division/web/admin/other/phraseMgnt";
				});
			}
		}
	});	
});

function getCursorPosition(obj) {
	var el = $(obj).get(0);
	var pos = 0;
	if('selectionStart' in el) {
		pos = el.selectionStart;
	} else if('selection' in document) {
		el.focus();
		var Sel = document.selection.createRange();
		var SelLength = document.selection.createRange().text.length;
		Sel.moveStart('character', -el.value.length);
		pos = Sel.text.length - SelLength;
	}
	return pos;
}

function insertAfterCursor(obj, text){
	var position = getCursorPosition(obj);
	var oldValue = $(obj).val();
	var newValue = oldValue.substring(0, position) + text + oldValue.substring(position);
	$(obj).val(newValue);
	$(obj).focus();
	$(obj)[0].setSelectionRange(position+text.length, position+text.length);
}
	
</script>

<style>
.characters{
	margin-top: 10px;
	width: 100%;
	display: block;
}

.keyChar {
	-moz-box-shadow: 2px 2px 0px 0px #899599;
	-webkit-box-shadow: 2px 2px 0px 0px #899599;
	box-shadow: 2px 2px 0px 0px #899599;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #eee));
	background: -moz-linear-gradient(top, #ededed 5%, #eee 100%);
	background: -webkit-linear-gradient(top, #ededed 5%, #eee 100%);
	background: -o-linear-gradient(top, #ededed 5%, #eee 100%);
	background: -ms-linear-gradient(top, #ededed 5%, #eee 100%);
	background: linear-gradient(to bottom, #ededed 5%, #eee 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#eee',GradientType=0);
	background-color: #eee;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border-radius: 5px;
	border: 1px solid #d6bcd6;
	display: inline-block;
	cursor: pointer;
	color: #444;
	font-family: Arial;
	font-size: 16px;
	padding: 7px 15px;
	height: 
	text-decoration: none;
	text-shadow: 0px 1px 0px #e1e2ed;
	margin: 0 5px 10px 0;
}

.keyChar:hover {
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #bab1ba), color-stop(1, #ededed));
	background: -moz-linear-gradient(top, #bab1ba 5%, #ededed 100%);
	background: -webkit-linear-gradient(top, #bab1ba 5%, #ededed 100%);
	background: -o-linear-gradient(top, #bab1ba 5%, #ededed 100%);
	background: -ms-linear-gradient(top, #bab1ba 5%, #ededed 100%);
	background: linear-gradient(to bottom, #bab1ba 5%, #ededed 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#bab1ba', endColorstr='#ededed',GradientType=0);
	background-color: #bab1ba;
}

.keyChar:active {
	position: relative;
	top: 1px;
}
</style>

<#--<#include "/skins/imas/casemgnt/socket.ftl" />-->
<#include "/imas/widget/widget.ftl" />