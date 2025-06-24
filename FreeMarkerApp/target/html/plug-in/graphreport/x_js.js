//新加些對象用來保存常用數據， 如：遊戲列表為：zyfc.gameList	(下面數據也應放入此對象，但暫時不做處理)
var zyfc = new Object();
//獲得遊戲列表
$.get("cgReportController?datagrid&configId=dynamic_game_list", function(data) {
	zyfc.gameList = {};
	for(var i = 0; i < data.rows.length; i++) {
		var game = data.rows[i];
		zyfc.gameList[game.gmid] = game;
	}
});


//擴展_導出
function x_export() {
	jQuery.ajaxSettings.traditional = true;
	
	//判斷記錄是否大於10w條
	var xjs_panel = $(".panel:visible[class='panel']").has("#x_export");
	var rowNum = xjs_panel.find(".pagination-info").text();
	if(rowNum) {
		rowNum = rowNum.match(/共\d+/)[0].replace("共", "");
	}else {
		rowNum = 0;
	}
	if(rowNum == 0) {
		alert("沒有導出的記錄！");
		return;
	}else if(rowNum  > 100000) {
		alert("導出記錄數量不能大於10w條！");
		return;
    }
	
	var e = event || x_export.caller.arguments[0];
	var target = e.target || e.srcElement;
    var configId = $(target).parents("div[id$='Listtb']:first").attr("id").replace("Listtb", "");
	var url = "exCoreController?exportExcel&configId=" + configId;
	var datagridId = configId + 'List';

	var queryParams = $('#'+datagridId).datagrid('options').queryParams;
	//獲得數組參數
	$("#" + configId + "Listtb").find(":input[id][tag='ComboGrid']").each(function() {
		queryParams[$(this).attr("id")] = $(this).combogrid('getValues');
	});
	$('#'+datagridId+'tb').find('*').each(function() {
	    queryParams[$(this).attr('name')] = $(this).val();
	});
	var params = '&' + $.param(queryParams);
	var fields = '&field=';
	$("#" + datagridId).parents(".datagrid-wrap:first").find(".datagrid-header-row td:visible").each(function() {
		var field = $(this).attr("field");
		if(field && field != "ck" && field != "opt") {
			fields+=field+',';
		}
	});
	var loc = url + params + encodeURI(fields);
	$("<iframe src='" + loc + "&p=1" + "' style='display:none;'></iframe>").appendTo("body");
	if(rowNum > 50000) {
		setTimeout(function() {
			$("<iframe src='" + loc + "&p=2' style='display:none;'></iframe>").appendTo("body");
		}, 1000 * 5);
	}
}

//擴展_克隆
function x_copy() {
	var e = event || x_export.caller.arguments[0];
	var target = e.target || e.srcElement;
    var configId = $(target).parents("div[id$='Listtb']:first").attr("id").replace("Listtb", "");
	eval(configId + "copy()");
}

//每25鐘自動連接一次服務器，防止session過期
setInterval(function() {
	$.get("loginController?login", function(data) { });
}, 1000 * 60 * 100);

//圖表配置覆制
function popMenuLinkGraph(tableName,content){
	var url = "<input type='text' style='width:380px;' disabled=\"disabled\" id='menuLink' title='graphReportController?list&id=' value='graphReportController?list&isIframe&id="+tableName+"' />";
	$.dialog({
		content: url,
		drag :false,
		lock : true,
		title:'菜單鏈接['+content+']',
		opacity : 0.3,
		width:400,
		height:50,
		cache:false,
	    cancelVal: '關閉',
	    cancel: function(){clip.destroy();},
	    button : [{
	    	id : "coptyBtn",
	    	name : "覆制",
	    	callback : function () {
	    	}
	    }],
	    init : function () {
			clip = new ZeroClipboard.Client();
			clip.setHandCursor( true );
			
			clip.addEventListener('mouseOver', function(client){
				clip.setText( document.getElementById("menuLink").value );
			});
			clip.addEventListener('complete', function(client, text){
				alert("覆制成功");
			});
			var menuLink = $("#menuLink").val();
			$($("input[type=button]")[0]).attr("id","coptyBtn");
			clip.setText(menuLink);
			clip.glue("coptyBtn");
	    }
	});  
}

//圖表配置覆制
function copy_url() {
    var e = event || x_export.caller.arguments[0];
    var target = e.target || e.srcElement;
    var configId = $(target).parents("tr:first").find("td[field='code']").text();
    popMenuLinkGraph(configId, configId);
}
//功能測試
function graph_test() {
	var e = event || x_export.caller.arguments[0];
    var target = e.target || e.srcElement;
    var configId = $(target).parents("tr:first").find("td[field='code']").text();
    var configName = $(target).parents("tr:first").find("td[field='name']").text();
	    
	addOneTab("表單數據列表 ["+configName+"]", "graphReportController?list&isIframe&id="+configId);
}

//公告管理-查看區服
function x_openServerList(id) {
    //addTab('渠道收入數據(廣告)','cgAutoListController?list&id=v_rpt_day_pay_ad&clickFunctionId=2c90aa6744866c7a0144875fc92c013e','pictures')
    addlisttab('db_mnet__dbo__v_game_server_notice_jjqy&noticeid='+id,'【jjqy】區服公告','0')
}

//四合一圖表隱藏相關列
function x_groupReport() {
	return;
	
	var xjs_panel = $("#maintabs .panel.datagrid:visible");
	var isGroupReport = $("#isGroupReport", xjs_panel);
	if(isGroupReport.length == 1) {
		var datagridId = xjs_panel .find(".datagrid-toolbar").attr("id").replace("tb", "");
		var queryParams = {serverid: $(":input[name='serverid']", xjs_panel).val(), ad_channel_id: $(":input[name='ad_channel_id']", xjs_panel).val()}
		//如果已選中匯總，隱藏相關列
		if(isGroupReport.attr("checked")) {
			if($(":checked#isGroupReport", xjs_panel).val() == 1) {
				//根據數據條件隱藏相應數據列
				if(queryParams.serverid != undefined) {
					$('#' + datagridId).datagrid("hideColumn", "serverid");
				}
				if(queryParams.ad_channel_id != undefined) {
					$('#' + datagridId).datagrid("hideColumn", "ad_channel_id");
					$('#' + datagridId).datagrid("hideColumn", "ad_channel_name");
				}
				/*if(!queryParams.serverid && queryParams.serverid != undefined) {
					$('#' + datagridId).datagrid("hideColumn", "serverid");
				}
				if(!queryParams.ad_channel_id && queryParams.ad_channel_id != undefined) {
					$('#' + datagridId).datagrid("hideColumn", "ad_channel_id");
					$('#' + datagridId).datagrid("hideColumn", "ad_channel_name");
				}*/
			}
		}else {
			//否則顯示相關列
			if(queryParams.serverid != undefined) {
				$('#' + datagridId).datagrid("showColumn", "serverid");
			}
			if(queryParams.ad_channel_id != undefined) {
				$('#' + datagridId).datagrid("showColumn", "ad_channel_id");
			}
		}
	}
}

//根據遊戲顯示相應區服
function x_showOnlyServer() {
	var xjs_panel = $("#maintabs .panel.datagrid:visible");
	var serveridObj = xjs_panel.find("#serverid");
	var gmid = xjs_panel.find("#gmid").val();
	//把gmid換成csdkid
	if(gmid) {
		gmid = zyfc.gameList[gmid].csdkid || gmid;
	}
	var currServerid = serveridObj.combo("getValue");
	var data = $("option", serveridObj).map(function() {
		var serverId = $(this).val();
		var serverOption = null;
		if(serverId) {
			if(gmid == "appsg") {
				if(serverId.indexOf(".") == -1) {
					serverOption = {value: serverId, text: $(this).text()};
					if(currServerid == serverId) {
						serverOption.selected = true;
					}
				}
			}else {
				if(!gmid || serverId.indexOf(gmid + ".") != -1) {
					serverOption =  {value: serverId, text: $(this).text()};
					if(currServerid == serverId) {
						serverOption.selected = true;
					}
				}
			}
		}
		return serverOption;
	});
	serveridObj.combobox('setValue', '');
	serveridObj.combobox("loadData", x_getSCOptionOther("**全部區服**").concat(data.get()));
}



//根據遊戲顯示相應渠道
function x_showOnlyChannel() {
	var xjs_panel = $("#maintabs .panel.datagrid:visible");
	var gmidObj = xjs_panel.find("#gmid");
	var text = $("option[value='"+gmidObj.val()+"']", gmidObj).text();
	var serveridObj = xjs_panel.find("#ad_channel_id");
	var currServerid = serveridObj.combo("getValue");
	var data = $("option", serveridObj).map(function() {
		var serverOption = null;
		if(gmidObj.val() == "appsg") {
			if(new RegExp(text).test($(this).text())) {
				serverOption = {value:$(this).val(), text:$(this).text()}
				if(currServerid == $(this).val()) {
					serverOption.selected = true;
				}
			}
		}else {
			if(new RegExp("啪啪三國").test($(this).text()) == false) {
				if($(this).val()) {
					serverOption = {value:$(this).val(), text:$(this).text()}
					if(currServerid == $(this).val()) {
						serverOption.selected = true;
					}
				}
			}
		}
		return serverOption;
	});
	data = x_getSCOptionOther("**全部渠道**").concat(data.get());
	serveridObj.combobox('setValue', '');
	serveridObj.combobox("loadData", data);
}

//獲得區服和渠道附加選項
function x_getSCOptionOther(showText) {
	var optionOther = [{value:"", text:""}];
	if($("#maintabs .panel.datagrid:visible #isGroupReport:checked").length > 0) {
		optionOther.push({value:"-1", text:showText});
	}
	return optionOther;
}