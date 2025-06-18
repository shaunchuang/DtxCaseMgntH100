$(document).ready(function(){
	$("table.dtable tr").each(function(){
		$(this).mouseover(function(){
			$(this).children("td").each(function(){
				$(this).css("background-color", "#F2F4E7");
			});
		});
		
		$(this).mouseout(function(){
			$(this).children("td").each(function(){
				$(this).css("background-color", "");
			});
		});
		
		// $(this).click(function(){
			// var td1 = $(this).children("td:eq(0)");
			// var chk = $(td1).children("input:checkbox");
			// if(chk){
				// if($(chk).attr('checked')){
				// $(chk).removeAttr('checked');
				// }
				// else {
					// $(chk).attr('checked', 'checked');
				// }
			// }
		// });
	});
	
	//處理 class 動作	    
    $(".form-reset" ).click(function( event ) {
	    $(this).closest('form').find(".textinput, .dateinput, textarea").val(""); 
	    $(this).closest('form').find(".selectinput").prop('selectedIndex',0);
	    $(this).closest('form').find(".radioinput").removeAttr('checked');
	    $(this).closest('form').find(".checkboxinput").removeAttr('checked');
	  });  
  
     $(".prevent").click(function (event) {
         event.preventDefault();
     });
	
	
	$(".upper").keyup(function(evt){ 
          var vOri=$(this).val(); 
          var vNew=vOri.toUpperCase(); 
          $(this).val(vNew); 
       });
	
	$("#tabs").tabs({
    	activate: function( event, ui ) {
    		window.top.iframeAutoHeight();
    	}
    });
	
	var tables=document.getElementsByTagName("table");
	var b=false;
	for (var j = 0; j < tables.length; j++){
		var cells = tables[j].getElementsByTagName("tr");
		//cells[0].className="color3";
		b=false;
		for (var i = 0; i < cells.length; i++){
			if(b){
				cells[i].className="color2";
				b=false;
			}
			else{
				cells[i].className="color3";
				b=true;
			};
		};
};
	
	loadSorted();
	initAjaxBusy();
});

function initAjaxBusy(){
	$('body').append('<div id="ajaxBusy" style="display:none;"></div>');
    
    $("#ajaxBusy").dialog({
        autoOpen: false,    // set this to false so we can manually open it
        dialogClass: "ajaxBusyWindow",
        closeOnEscape: false,
        draggable: false,
        width: 460,
        minHeight: 50,
        modal: true,
        buttons: {},
        resizable: false,
        open: function() {
            // scrollbar fix for IE
            $('body').css('overflow','hidden');
        },
        close: function() {
            // reset overflow
            $('body').css('overflow','auto');
        }
    }); // end of dialog	
}

function showAjaxBusy(waiting) {
    $("#ajaxBusy").html('請等待...');
    $("#ajaxBusy").dialog('option', 'title', '載入資料中...');
    $("#ajaxBusy").dialog('open');
}

function hideAjaxBusy() {
    $("#ajaxBusy").dialog('close');
}

function changeFormSelect(id){
	//$(id).submit();
	wg.template.submitForm(id);
}

function changePageNumSelect(id, replaceId){
	//$(id).submit();
	wg.template.submitForm(id, replaceId);
}

function ajaxChangeFormSelect(formId, callback){ 
	mlog.form.ajaxLoadElement($("#"+formId).attr("action"), formId, callback);
}



function SingleSelectValid()
{	
	var count = $('input:checkbox[name=id]:checked').length;
	if(count>1) { custom_alert("僅能單選!","注意"); return false;}
	if(count<1) { custom_alert("請選擇一項!","注意"); return false;} 
	return true;
}

function SingleSelectValidEx(fieldId)
{	
	var count = $('input:checkbox[name='+fieldId+']:checked').length;
	if(count>1) { custom_alert("僅能單選!","注意"); return false;}
	if(count<1) { custom_alert("請選擇一項!","注意"); return false;} 
	return true;
}
function checkEdit(formName,formURL,fieldId,specialCallback){
	var n = $( "input[name='"+fieldId+"']:checked:enabled" ).length;
	if(n==0){
		alert("請選擇要修改的紀錄!");
	}else if(n==1){
		if(typeof(specialCallback)=="function"){
			if(specialCallback()){
				mlog.form.submitForm(formName, formURL);
			}
		}else{
			mlog.form.submitForm(formName, formURL);
		}
	}else{
		alert("請選擇其中一筆紀錄");
	}
}

function checkDelete(formName,formURL,fieldId,specialCallback,msg){
	var n = $( "input[name='"+fieldId+"']:checked:enabled" ).length;
	if(n==0){
		alert("請選擇要刪除的紀錄!");
	}else{
		if(typeof(specialCallback)=="function"){
			if(specialCallback()){
				if(msg){
					mlog.form.confirmSubmit(formName, formURL, msg);
				}else{
					mlog.form.submitForm(formName, formURL);
				}
				
			}
		}else{
			if(msg){
				mlog.form.confirmSubmit(formName, formURL, msg);
			}else{
				mlog.form.submitForm(formName, formURL);
			}
			
		}
	}
}

function setMainFrameUrl(url){
	//window.top.main.location = url;
	window.location.href = url;
}

function setRootFrameUrl(url){
	window.top.location.href = url; 
} 

/**
 * 转换高亮tab 
 * @param {Object} id
 */ 

function turnHighLight(id,id2){
	if(id){
		$(".tab a").each(function(){
			if(this.id == id || this.id == id2){
				$(this).attr("class", "here");
			}
			else {
				$(this).removeAttr("class");
			}
		});	
	}
	
	if(id){
		$(".tab button").each(function(){
			if(this.id == id || this.id == id2){
				$(this).removeAttr("class");
				$(this).attr("class", "btnactive"); 
			}
			else {
				$(this).removeAttr("class");
				$(this).attr("class", "btn");
			}
		});	
	}
	//if(window.top!=window.self)
	//	window.top.updateBreadCrumb(id);
}
 


/*
 * @description 加载 SyntaxHighlighter 
 * @param {String} SHTheme SyntaxHighLighter 样式
 * @param {String} selector SyntaxHighLighter 容器
 */
function loadSyntaxHighlighter(SHTheme, selector){
	var cssName = SHTheme ? SHTheme : "shCoreEclipse";
	// load css
    mlog.utils.loader.loadStyleSheet(mlog.variable.base + "/script/SyntaxHighlighter/styles/" + cssName + ".css");
    
    
    
    // load js
    /**
	 * 加载JavaScript文件
	 * @param setting 设置项
	 * @param setting.url JavaScript地址
	 * @param setting.async (默认: true) 默认设置下，所有请求均为异步请求
	 * @param setting.success 加载成功后的回调函数
	 */
    mlog.utils.loader.loadJavaScriptByAjax({
    	url : mlog.variable.base + "/script/SyntaxHighlighter/scripts/shCore.js",
    	success : function(){
    		// get brush settings
            var languages = [], isScrip = false;
            $(selector).each(function () {
                var name = this.className.split(";")[0];
                var language = name.substr(7, name.length - 1);
                if (this.className.indexOf("html-script: true") > -1 && (language !== "xml" && language !== "xhtml" && language !== "xslt" && language != "html")) {
                    isScrip = true;
                }
                languages.push(language);
            });
            // when html-script is true, need shBrushXml.js
            if (isScrip) {
            	mlog.utils.loader.loadJavaScriptByAjax({
            		url : mlog.variable.base + "/script/SyntaxHighlighter/scripts/shBrushXml.js",
            		success: function() {
                        initSyntaxHighlighter(languages);
                    }
            	});
            } else {
                initSyntaxHighlighter(languages);
            }
    	}
    });
}

/*
 * @description 初始化 SyantaxHighlighter
 * @param {Array} languages 需要加载的语言 
 */
function initSyntaxHighlighter(languages){
	for(var i = 0; i < languages.length; i++){
		switch(languages[i]){
    		case "groovy":
                languages[i] =  'groovy				' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushGroovy.js';
                break;
            case "java":
                languages[i] =  'java				' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushJava.js';
                break;
            case "php":
                languages[i] =  'php				' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushPhp.js';
                break;
            case "scala":
                languages[i] =  'scala				' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushScala.js';
                break;
            case "sql":
                languages[i] =  'sql				' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushSql.js';
                break;
            case "applescript":
                languages[i] =  'applescript			' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushAppleScript.js';
                break;
            case "as3": 
            case "actionscript3":
                languages[i] =  'actionscript3 as3                  ' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushAS3.js';
                break;
            case "bash":
            case "shell":
                languages[i] =  'bash shell                         ' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushBash.js';
                break;
            case "coldfusion":
            case "cf":
                languages[i] =  'coldfusion cf			' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushColdFusion.js';
                break;
            case "c#":
            case "c-sharp":
            case "csharp":
                languages[i] =  'c# c-sharp csharp                  ' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushCSharp.js';
                break;
            case "cpp":
            case "c":
                languages[i] =  'cpp c				' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushCpp.js';
                break;	
            case "css":
                languages[i] =  'css				' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushCss.js';
                break;
            case "delphi":
            case "pascal":
                languages[i] =  'delphi pascal			' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushDelphi.js';
                break;			
            case "diff":
            case "patch":
            case "pas":
                languages[i] =  'diff patch pas			' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushDiff.js';
                break;			
            case "erl":
            case "erlang":
                languages[i] =  'erl erlang                         ' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushErlang.js';
                break;			
            case "js":
            case "jscript":
            case "javascript":
                languages[i] =  'js jscript javascript              ' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushJScript.js';
                break;			
            case "jfx":
            case "javafx":
                languages[i] =  'jfx javafx                 	' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushJavaFX.js';
                break;			
            case "perl":
            case "pl":
                languages[i] =  'perl pl                    	' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushPerl.js';
                break;			
            case "plain":
            case "text":
                languages[i] =  'text plain                 	' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushPlain.js';
                break;			
            case "ps":
            case "powershell":
                languages[i] =  'ps powershell                      ' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushPowerShell.js';
                break;			
            case "py":
            case "python":
                languages[i] =  'py python                          ' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushPython.js';
                break;			
            case "rails":
            case "ror":
            case "ruby":
            case "rb":
                languages[i] =  'ruby rails ror rb          	' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushRuby.js';
                break;	
            case "sass":
            case "scss":
                languages[i] =  'sass scss                  	' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushSass.js';
                break;
            case "vb":
            case "vbnet":
                languages[i] =  'vb vbnet                   	' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushVb.js';
                break;			
            case "xml":
            case "xhtml":
            case "xslt": 
            case "html":
                languages[i] =  'xml xhtml xslt html                ' + mlog.variable.base + '/script/SyntaxHighlighter/scripts/shBrushXml.js';
                break;	
            default:
                break;
		}
	}
	// code high lighter
    SyntaxHighlighter.autoloader.apply(null, languages);
    SyntaxHighlighter.config.stripBrs = true;
    SyntaxHighlighter.all();
}


/**
 * 排序
 * @param th
 * @param formId
 * @param field
 * @param orderCtl
 */
function sortField(th, formId, field, orderCtl){
	var formCtl = document.getElementById(formId);
	var fieldCtl = document.getElementById('sort.field');
	var orderCtl = document.getElementById('sort.order');
	
	if(!th || !formCtl || !fieldCtl || !orderCtl){
		return; 
	}
	
	var order = 'desc';
	if($(th).attr('class') == 'down'){
		order = 'asc';
	}
	
	orderCtl.value = order;
	fieldCtl.value = field;
	//formCtl.submit();
	wg.template.submitForm(formId);
}

function ajaxSortField(th, formId, field, orderCtl, callback){
	var formCtl = document.getElementById(formId);
	var fieldCtl = document.getElementById('sort.field');
	var orderCtl = document.getElementById('sort.order');
	
	if(!th || !formCtl || !fieldCtl || !orderCtl){
		return; 
	}
	
	var order = 'desc';
	if($(th).attr('class') == 'down'){
		order = 'asc';
	}
	
	orderCtl.value = order;
	fieldCtl.value = field;
	mlog.form.ajaxLoadElement($("#"+formId).attr("action"), formId, callback);
}

/**
 * 加载排序样式
 */
function loadSorted(){
	var fieldCtl = document.getElementById('sort.field');
	var orderCtl = document.getElementById('sort.order');
	if(!fieldCtl || !orderCtl){
		return;
	}
	$(".dtable tr th").each(function(){
		var id = this.id;
		if(id && id == fieldCtl.value + '_sort'){
			if(orderCtl.value == 'desc'){
				$(this).attr('class', 'down');
			}
			else{
				$(this).attr('class', 'up');
			}
		}
	});
}

/**
 * 用于下载远程图片
 * 
 * @author Gao Youbo
 * @since 2013-07-26
 */
function downloadRemoteImages(fid, ftype, content, callback) {
	var dialog = mlog.dialog.showModelDialog({
		title: false,
		content: '图片下载中，请稍候...',
		icon: 'loading.gif'
	});
	$.post(mlog.variable.base + '/admin/attachment/remote', {
		fid : fid,
		ftype : ftype,
		content : content
	}, function(response) {
		callback(response);
		dialog.close();
	});
}

function custom_alert(output_msg, title_msg)
{
    if (!title_msg)
        title_msg = 'Alert';

    if (!output_msg)
        output_msg = 'No Message to Display.';
    
    alert(output_msg);

//    $("<div></div>").html(output_msg).dialog({
//        title: title_msg,
//        resizable: false,
//        modal: true,
//        buttons: {
//            "Ok": function() 
//            {
//                $( this ).dialog( "close" );
//            }
//        }
//    });
} 

function custom_confirm(output_msg, title_msg,callback)
{
    if (!title_msg)
        title_msg = 'Confirm';

    if (!output_msg)
        output_msg = 'No Message to Display.';
    
    if (confirm(output_msg)) {
    	callback();
	}

//    $("<div></div>").html(output_msg).dialog({
//        title: title_msg,
//        resizable: false,
//        modal: true,
//        buttons: {
//            "Ok": function() 
//            {
//                $( this ).dialog( "close" );
//                callback();
//            },
//            Cancel: function() {
//            	$( this ).dialog( "close" ); 
//            }
//        }
//    });
}


function getTime( dateStr ){
    dateStr = dateStr.replace( "-" ,  "/" );
    return  Date.parse( dateStr );
}

function onTabHeaderClick(url){
	if(typeof(onLeaveTabHandler) == "function"){
		if(onLeaveTabHandler()){
			setRootFrameUrl(url);
		}
	}else{
		setRootFrameUrl(url);
	}
}

$.fn.clearForm = function() {
  return this.each(function() {
    var type = this.type, tag = this.tagName.toLowerCase();
    if (tag == 'form')
      return $(':input',this).clearForm();
    if (type == 'text' || type == 'password' || tag == 'textarea')
      this.value = '';
    else if (type == 'checkbox' || type == 'radio')
      this.checked = false;
    else if (tag == 'select')
      this.selectedIndex = -1;
  });
};