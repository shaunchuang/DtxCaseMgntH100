/*******************************************************************************
* KindEditor - WYSIWYG HTML Editor for Internet
* Copyright (C) 2006-2011 kindsoft.net
*
* @author Roddy <luolonghao@gmail.com>
* @site http://www.kindsoft.net/
* @licence http://www.kindsoft.net/license.php
*******************************************************************************/

KindEditor.plugin('insertfile', function(K) {
	var self = this, name = 'insertfile',
		//allowFileUpload = K.undef(self.allowFileUpload, true),
		allowFileUpload = K.undef(self.allowFileUpload, false),
		allowFileManager = K.undef(self.allowFileManager, true),
		formatUploadUrl = K.undef(self.formatUploadUrl, true),
		uploadJson = K.undef(self.uploadJson, self.basePath + 'php/upload_json.php'),
		extraParams = K.undef(self.extraFileUploadParams, {}),
		filePostName = K.undef(self.filePostName, 'imgFile'),
		lang = self.lang(name + '.');
	var target = 'kindeditor_upload_iframe_' + new Date().getTime();
	self.plugin.fileDialog = function(options) {
		var fileUrl = K.undef(options.fileUrl, ''),
			fileTitle = K.undef(options.fileTitle, ''),
			clickFn = options.clickFn;
		var html = [
			'<div style="padding:20px;">',
			'<iframe name="' + target + '" style="display:none;"></iframe>',
			'<form class="ke-upload-area ke-form" method="post" enctype="multipart/form-data" target="' + target + '" action="' + K.addParam(uploadJson, 'dir=file&token='+mlog.variable.attachToken) + '">',
			'<div class="ke-dialog-row">',
			'<label for="keUrl" style="width:60px;">' + lang.url + '</label>',
			'<input type="text" id="keUrl" name="url" class="ke-input-text" style="width:160px;" /> &nbsp;',
			//'<input type="button" class="ke-upload-button" value="' + lang.upload + '" /> &nbsp;',
			'<span class="ke-button-common ke-button-outer">',
			'<input type="button" class="ke-button-common ke-button" name="viewServer" value="' + lang.viewServer + '" />',
			'</span>',
			'</div>',
			//title
			'<div class="ke-dialog-row">',
			'<label for="keTitle" style="width:60px;">' + lang.title + '</label>',
			'<input type="text" id="keTitle" class="ke-input-text" name="title" value="" style="width:160px;" /></div>',
			'</div>',
			//form end
			'</form>',
			'</div>'
			].join('');
		var dialog = self.createDialog({
			name : name,
			width : 450,
			title : self.lang(name),
			body : html,
			yesBtn : {
				name : self.lang('yes'),
				click : function(e) {
					var url = K.trim(urlBox.val()),
						title = titleBox.val();
//					if (url == 'http://' || K.invalidUrl(url)) {
//						alert(self.lang('invalidUrl'));
//						urlBox[0].focus();
//						return;
//					}
//					if (K.trim(title) === '') {
//						title = url;
//					}
//					clickFn.call(self, url, title); 
					if (dialog.isLoading) {
						return;
					}
					// insert local image
					if (url.indexOf('http://') == 0 ) {
						if (url == 'http://' || K.invalidUrl(url)) {
							alert(self.lang('invalidUrl'));
							urlBox[0].focus();
							return;
						}
						clickFn.call(self, url, title, title, 'doc');
					} else 	if (K.trim(url) != '') {
						if (uploadbutton.fileBox.val() == '') {
							alert(self.lang('pleaseSelectFile'));
							return;
						}
						dialog.showLoading(self.lang('uploadLoading'));
						uploadbutton.submit();
						urlBox.val('');
						return;
					}
				}
			}
		}),
		div = dialog.div;

		var urlBox = K('[name="url"]', div), 
			viewServerBtn = K('[name="viewServer"]', div),
			titleBox = K('[name="title"]', div);

		if (allowFileUpload) {
			var uploadbutton = K.uploadbutton({
				button : K('.ke-upload-button', div)[0],
				fieldName : filePostName,
				form : K('.ke-form', div),
				target : target,
//				url : K.addParam(uploadJson, 'dir=file'),
//				extraParams : extraParams,
				afterUpload : function(data) {
//					dialog.hideLoading();
//					if (data.error === 0) {
//						var url = data.url;
//						if (formatUploadUrl) {
//							url = K.formatUrl(url, 'absolute');
//						}
//						urlBox.val(url);
//						if (self.afterUpload) {
//							self.afterUpload.call(self, url, data, name);
//						}
//						alert(self.lang('uploadSuccess'));
//					} else {
//						alert(data.message);
//					}
					
					
					
					
					dialog.hideLoading();
					if (data.error === 0) {
						var url = data.url;
						if (formatUploadUrl) {
							url = K.formatUrl(url, 'absolute');
						}
						if (self.afterUpload) {
							self.afterUpload.call(self, url, data, name);
						}
						clickFn.call(self, url, data.title, data.origName, data.extName);
//						if (!fillDescAfterUploadImage) {
//							clickFn.call(self, url, data.title, data.width, data.height, data.border, data.align);
//						} else {
//							K(".ke-dialog-row #remoteUrl", div).val(url);
//							K(".ke-tabs-li", div)[0].click();
//							K(".ke-refresh-btn", div).click();
//						}
					} else {
						alert(data.message);
					}
				},
				afterError : function(html) {
					dialog.hideLoading();
					self.errorDialog(html);
				}
			});
			uploadbutton.fileBox.change(function(e) {
//				dialog.showLoading(self.lang('uploadLoading'));
//				uploadbutton.submit();
				urlBox.val(uploadbutton.fileBox.val());
			});
		} else {
			K('.ke-upload-button', div).hide();
		}
		if (allowFileManager) {
			viewServerBtn.click(function(e) {
				self.loadPlugin('kernolifilemanager', function() {
					self.plugin.filemanagerDialog({
						viewType : 'LIST',
						dirName : 'file',
						clickFn : function(url, title) {
							if (self.dialogs.length > 1  ) {
								if (url!=""){ 
									K('[name="url"]', div).val(url);
									K('[name="title"]', div).val(title);
									if (self.afterSelectFile) {
										self.afterSelectFile.call(self, url);
									}
								}
								self.hideDialog();
							}
						}
					});
				});
//				self.loadPlugin('filemanager', function() {
//					self.plugin.filemanagerDialog({
//						viewType : 'LIST',
//						dirName : 'file',
//						clickFn : function(url, title) {
//							if (self.dialogs.length > 1) {
//								K('[name="url"]', div).val(url);
//								if (self.afterSelectFile) {
//									self.afterSelectFile.call(self, url);
//								}
//								self.hideDialog();
//							}
//						}
//					});
//				}); 				
			});
		} else {
			viewServerBtn.hide();
		}
		urlBox.val(fileUrl);
		titleBox.val(fileTitle);
		urlBox[0].focus();
		urlBox[0].select();
	};
	self.clickToolbar(name, function() {
		self.plugin.fileDialog({
			clickFn : function(url, title, origName, extName) {
				var html = '&nbsp;&nbsp;<a download="'+decodeURIComponent(origName)+'" class="ke-insertfile" href="' + url + '" data-ke-src="' + url + '" target="_blank" ><!--<img src="/wgnursing/images/'+extName+'.png" width="51" height="36" />--> 附件下載: ' + decodeURIComponent(title) + '</a>&nbsp;&nbsp;';
				self.insertHtml(html).hideDialog().focus();
			}
		});
	});
});
