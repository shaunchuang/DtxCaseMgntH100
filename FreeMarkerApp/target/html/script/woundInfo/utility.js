var zh_ver = {
    search:         "搜尋:&nbsp;&nbsp;",
    lengthMenu:    "每頁顯示 _MENU_ 筆",
    info:           "第 _START_ 筆 - 第 _END_ 筆 總共 _TOTAL_ 筆",
    infoEmpty:      "總共 _TOTAL_ 筆",
    loadingRecords: "載入中...",
    emptyTable:     "無資料",
    zeroRecords: "無法找到相符條件的資料",
    infoFiltered: "(搜尋共 _MAX_ 筆資料)",
    paginate: {
        first:      "首頁",
        previous:   "上頁",
        next:       "下頁",
        last:       "末頁"
    },
    aria: {
        sortAscending:  ": 升冪",
        sortDescending: ": 降冪"
    }
}

var en_ver = {
    search:         "Search:&nbsp;&nbsp;",
    lengthMenu:    "Show _MENU_ Records",
    info:           "_START_ - _END_ record, Total _TOTAL_ records",
    infoEmpty:      "Total _TOTAL_ records",
    loadingRecords: "loading...",
    emptyTable:     "No data",
    zeroRecords: "Unable to find the matching data",
    infoFiltered: "(搜尋共 _MAX_ 筆資料)",
    paginate: {
        first:      "First",
        previous:   "Prev",
        next:       "Next",
        last:       "Last"
    },
    aria: {
        sortAscending:  ": 升冪",
        sortDescending: ": 降冪"
    }
}

var zh_chart = {"chartNum":2, "dimension":['長度', '寬度', '深度'], "proportion":['上皮', '肉芽', '腐肉', '壞死'], "physicalIdx":['體溫','心跳','舒張壓','收縮壓']};
var en_chart = {"chartNum":2, "dimension":['Height', 'Width', 'Depth'], "proportion":['Epit.', 'Gran.', 'Slou.', 'Necr.'], "physicalIdx":['Temperature','BPM','DBP','SBP']};

var colors = {
	red: {
		fill : 'rgb(255, 99, 132, 0.8)',
		stroke : 'rgb(255, 99, 132)'
	},
	cherryRed: {
		fill : 'rgb(255, 0, 0, 0.8)',
		stroke : 'rgb(255, 0, 0)'
	},
	orange: {
		fill : 'rgb(255, 159, 64, 0.8)',
		stroke : 'rgb(255, 159, 64)'
	},
	pink: {
		fill : 'rgb(255, 192, 203, 0.8)',
		stroke : 'rgb(255, 192, 203)'
	},
	yellow: {
		fill : 'rgb(255, 215, 87, 0.8)',
		stroke : 'rgb(255, 215, 87)'
	},
	lightYellow: {
		fill : 'rgb(255, 224, 125, 0.8)',
		stroke : 'rgb(255, 224, 125)'
	},
	green: {
		fill: 'rgb(75, 192, 192, 0.8)',
	    stroke: 'rgb(75, 192, 192)',
  	},
  	darkBlue: {
	    fill: 'rgb(0, 0, 255, 0.8)',
	    stroke: 'rgb(0, 0, 255)',
  	},
  	blue: {
	    fill: 'rgb(54, 162, 235, 0.8)',
	    stroke: 'rgb(54, 162, 235)',
  	},
  	purple: {
	    fill: 'rgb(153, 102, 255, 0.8)',
	    stroke: 'rgb(153, 102, 255)',
  	},
  	grey: {
	    fill: 'rgb(201, 203, 207, 0.8)',
	    stroke: 'rgb(201, 203, 207)',
  	},
  	darkGrey: {
	    fill: 'rgb(115, 115, 115, 0.8)',
	    stroke: 'rgb(115, 115, 115)',
  	},
  	black:{
  		fill: 'rgb(0, 0, 0, 0.8)',
	    stroke: 'rgb(0, 0, 0)',
  	}
};

function $import(src, callback){
	var scriptElem = document.createElement('script');
  	scriptElem.setAttribute('src',src);
  	scriptElem.setAttribute('type','text/javascript');
  	scriptElem.onload = callback;
  	//Internet explorer
  	scriptElem.onreadystatechange = function() {
        if (this.readyState == 'complete') {
            callback();
        }
    }
  	document.getElementsByTagName('head')[0].appendChild(scriptElem);
}

function $importCSS(src){
	var cssElem = document.createElement('link');
  	cssElem.setAttribute('src',src);
  	cssElem.setAttribute('type','text/css');
  	cssElem.setAttribute('rel','stylesheet');
  	document.getElementsByTagName('head')[0].appendChild(cssElem);
}

function getEditTime(){ //取得編輯時間
	var today = new Date();
	var yyyy = today.getFullYear();
	var mm = String(today.getMonth() + 1).padStart(2, '0');
	var dd = String(today.getDate()).padStart(2, '0');	
	var hour = String(today.getHours()).padStart(2, '0');;
	var min = String(today.getMinutes()).padStart(2, '0');;
	var sec = String(today.getSeconds()).padStart(2, '0');;
	
	return yyyy + "-" + mm + "-" + dd + " " + hour + ":" + min + ":" + sec;
	
    /*var timeNow = new Date();
    var editYear = timeNow.getFullYear();
    var editMonth = (timeNow.getMonth()+1<10 ? '0' : '') + (timeNow.getMonth()+1);
    var editDate = (timeNow.getDate()<10 ? '0' : '') + timeNow.getDate();
    var editHour = (timeNow.getHours()<10 ? '0' : '') + timeNow.getHours();
    var editMin = (timeNow.getMinutes()<10 ? '0' : '') + timeNow.getMinutes();
    var editSec = (timeNow.getSeconds()<10 ? '0' : '') + timeNow.getSeconds(); 
    var editTime = editYear +'-'+ editMonth +'-'+ editDate +' '+ editHour +':'+ editMin +':'+ editSec;
    return editTime;*/
}

/*function formatDate(date) {
	var str = date.toLocaleDateString() + " " + date.getHours() + "時" + date.getMinutes() + "分" + date.getSeconds() + "秒";
	return str;
}*/

function cleanDataTables() {
    var tables = $.fn.dataTable.fnTables(true);
    $(tables).each(function() {
        $(this).dataTable().fnClearTable();
        $(this).dataTable().fnDestroy();
    });
}

function generatePager(divclass, lang, isPaging){
	var pages = divclass === ".archive-list" ? 10 : 2 ;
	
	var selected_lang;
	
	if(lang == "zhTW"){
		selected_lang = zh_ver;
	}
	else{
		selected_lang = en_ver;
	}
    
	$(divclass).dataTable({
        responsive: true,
        sort: false,
        paging: isPaging,
        searching: false,
        info: false,
        lengthChange: false,
        pageLength: pages,
        autoWidth: false,
        destroy:true,
        
        language: selected_lang
    });
	
	/*$('.refresh').click(function() {
		customTable.ajax.reload(null, false);
	});*/
}

function createAjaxTable(divclass, pages, ajaxUrl, columnObj, lang){
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var selected_lang = lang == "zhTW" ? zh_ver : en_ver;
    
	var table =	$(divclass).DataTable({
					ajax: {
						url: ajaxUrl,
						type: "POST"
					},		
			        responsive: true,
			        sort: false,
			        paging: false,
			        searching: searching,
			        info: info,
			        lengthChange: lengthChange,
			        pageLength: pages,
			        autoWidth: false,
			        destroy:true,
			        columns: columnObj,
			        success:function(data){
			        },
			        drawCallback: function(){
			        	if(divclass == ".record-list"){
			        		$(".no-record").addClass("hidden");
			        		$(".record-table").removeClass("hidden");
			        		
			        		if($(".func-list").find(".info-btn").length == 3){
			        			$(".func-list").prepend("<a class='info-btn copy-record' title='複製'><i class='fa fa-copy' ></i> 複製</a><a class='info-btn refresh' title='重整'><i class='fa fa-refresh' ></i> 重整</a>");
			        		}
			        		
		        			$('.paginate_button:not(.disabled):not(.active)', this.api().table().container())          
				               .on('click', function(){
				            	 //刪除舊有紀錄tab
				            	 $(divclass).find(".highlight").removeClass("highlight");
				            	 refreshContent();
				        	           		   
				            });
			        	}
			        	else if(divclass == ".item-list"){
			        		/*$(".item-chk").change(function() {
			        			console.log("目前idx:" + $(this).attr('data-idx'));
			        			var checkedValue = $(this).prop('checked');
			        			if(checkedValue){
			        				$(this).closest('tr').addClass('highlight');
			        			}
			        			else{
			        				$(this).closest('tr').removeClass('highlight');
			        			}
			        		});*/
			        	}
			        },
			        
			        language: selected_lang
			    });
	
	$('.refresh').click(function() {
		refreshContent();
		table.ajax.reload(null, false);
	});
	
	$(".copy-record").click(function() {
		startDatePicker('.copy-date');
		var keyno = $(".info-card").find("input[type=hidden]").val();
		showCopyItemTable(keyno);
		$("#myModal17").modal('show');
	});
	
	$(".selectAll").change(function() {
		var checkedValue = $(this).prop('checked');
		if(checkedValue){
			table.column(0).nodes().to$().find(".item-chk").prop('checked', true).change();
			//$(".item-chk").prop('checked', true).change();
		}
		else{
			table.column(0).nodes().to$().find(".item-chk").prop('checked', false).change();
			//$(".item-chk").prop('checked', false).change();
		}
		
	});
	
	$("body").on('change', '.item-chk', function(){	
		var checkedValue = $(this).prop('checked');
		if(checkedValue){
			$(this).closest('tr').addClass('highlight');
		}
		else{
			$(this).closest('tr').removeClass('highlight');
		}
	});
}

function createDataTable(divclass, pages, data, columnObj, lang){
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var selected_lang;
	
	if(lang == "zhTW"){
		selected_lang = zh_ver;
	}
	else{
		selected_lang = en_ver;
	}
    
	var table =	$(divclass).DataTable({
					data: data,		
			        responsive: true,
			        sort: false,
			        paging: true,
			        searching: searching,
			        info: info,
			        lengthChange: lengthChange,
			        pageLength: pages,
			        autoWidth: false,
			        destroy:true,
			        columns: columnObj,
			        success:function(data){
			        },
			        drawCallback: function(){
			        	
			        },
			        
			        language: selected_lang
			    });
	
}

function getUrlParam(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
}

function refreshContent(){
	$(".left-nav li").slice(1).remove();
 	$(".tab-content").find(".tab-pane:not(.no-user):not(.no-tab)").remove();
 	$(".right-nav li").remove();
 	$(".add-tab").addClass("hidden");
 	$(".no-tab").removeClass("active");
 	$(".no-user").addClass("active");
 	$('.nav-tabs').scrollingTabs('refresh');
}

function getTodate(){ //取得今日日期
    var timeNow = new Date();
    var editYear = timeNow.getFullYear();
    var editMonth = (timeNow.getMonth()+1<10 ? '0' : '') + (timeNow.getMonth()+1);
    var editDate = (timeNow.getDate()<10 ? '0' : '') + timeNow.getDate();
    var dateTime = editYear + '-' + editMonth + '-' + editDate;
    return dateTime;
}

function getCookie(sName){
	var arr = document.cookie.match(new RegExp("(^| )" + sName + "=([^;]*)(;|$)"));
	if (arr != null) {
		return unescape(arr[2]);
	}
	return null;
}