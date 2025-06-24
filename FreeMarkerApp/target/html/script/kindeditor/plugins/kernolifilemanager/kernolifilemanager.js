/******************************************************************************* 
* @author Kernoli <hohsinli@gmail.com>
* @site  
* @licence  
*******************************************************************************/
  
	
	KindEditor.plugin('kernolifilemanager', function(K) {
		var self = this, name = 'kernolifilemanager',
			fileManagerJson = self.basePath + '../../admin/attachment/datatableAttachmentJson',
			imgPath = self.pluginsPath + name + '/images/',
			lang = self.lang(name + '.'); 
		self.plugin.filemanagerDialog = function(options) {
			var width = K.undef(options.width, 700),
				height = K.undef(options.height, 470), 
				clickFn = options.clickFn;
			var html = null;
			if(!options.memberOnly){
				html = ['<iframe id="kernolifilemanageriframe" style="position: relative; height: 100%; width: 100%;" frameborder="0" src="'+self.basePath + '../../admin/ppm/list">你的瀏覽器竟然不支援 iframe ?!</iframe>',].join('');
			}else{
				html = ['<iframe id="kernolifilemanageriframe" style="position: relative; height: 100%; width: 100%;" frameborder="0" src="'+self.basePath + '../../admin/ppm/root?type=socialDiscuss">你的瀏覽器竟然不支援 iframe ?!</iframe>',].join('');
			}
			//var html = ['<iframe id="kernolifilemanageriframe" style="position: relative; height: 100%; width: 100%;" frameborder="0" src="'+self.basePath + '../../admin/attachment/datatableAttachment">你的瀏覽器竟然不支援 iframe ?!</iframe>',].join('');
			var dialog = self.createDialog({
				name : name,
				width : width,
				height : height,
				title : self.lang(name),
				body : html,
				noBtn : {
					name : self.lang('no'),
					click : function(e) {  
						clickFn.call(self, "", "");  
					}
				},
				yesBtn : {
					name : self.lang('yes'),
					click : function(e) {
						var $iframe = $('#kernolifilemanageriframe'),
						$contents = $iframe.contents();
//						var url =$contents.find('#selectedUrl').val();
//						var title = $contents.find('#selectedDesc').val();
//						clickFn.call(self, url, title);
						var blogurl = $contents.find("#blogurl").val();
						var $d = $contents.find("div.doc-selected");
						if($d.size()>0){
							var storeFileName =  $d.attr("storeFileName");
							var realFileName = $d.attr("realFileName");
							var url = blogurl + "/download.action?fileName=" + storeFileName + "&realName=" + realFileName;
							clickFn.call(self, url, realFileName);
						}else{
							clickFn.call(self, "", "");
						}
						return;
					}
				}
			}),
			div = dialog.div,
			bodyDiv = K('.ke-plugin-filemanager-body', div), 
			iframe = K('iframe', div),
			selectedUrl = K('[name="selectedUrl"]', iframe); 
			selectedDesc = K('[name="selectedDesc"]', iframe); 
			 
		}

	});
 
