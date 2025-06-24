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

var data = [
         {
        	 "serialNo": "16511233",
        	 "participantNo": "S001",
        	 "role": "居家醫師",
        	 "institute": "台中維恩診所",
        	 "division": "02 家醫科",
        	 "name": "傅華國",
        	 "createDate": "2022-05-08"
         },
         {
        	 "serialNo": "16511234",
             "participantNo": "S002",
             "role": "專科醫師",
             "institute": "新竹馬偕醫院",
             "division": "BB 心臟科",
             "name": "陳小春",
             "createDate": "2022-05-16"
         }
    ]     


function getEditTime(){ //取得編輯時間
    var timeNow = new Date();
    var editYear = timeNow.getFullYear();
    var editMonth = (timeNow.getMonth()+1<10 ? '0' : '') + (timeNow.getMonth()+1);
    var editDate = (timeNow.getDate()<10 ? '0' : '') + timeNow.getDate();
    var editHour = (timeNow.getHours()<10 ? '0' : '') + timeNow.getHours();
    var editMin = (timeNow.getMinutes()<10 ? '0' : '') + timeNow.getMinutes();
    var editSec = (timeNow.getSeconds()<10 ? '0' : '') + timeNow.getSeconds(); 
    var editTime = editYear +'-'+ editMonth +'-'+ editDate +' '+ editHour +':'+ editMin +':'+ editSec;
    return editTime;
}

function formatDate(date) {
	var str = date.toLocaleDateString() + " " + date.getHours() + "時" + date.getMinutes() + "分" + date.getSeconds() + "秒";
	return str;
}

function cleanDataTables() {
    var tables = $.fn.dataTable.fnTables(true);
    $(tables).each(function() {
        $(this).dataTable().fnClearTable();
        $(this).dataTable().fnDestroy();
    });
}

function generateCustomPager(divclass, ajaxUrl, lang){
	var pages = 10;
	var searching = false;
	var lengthChange = true;
	var info = false;
	var selected_lang = lang == "zhTW" ? zh_ver : en_ver;
	var column;
	
	if(divclass === ".patient-table"){
		column = [
	    	{
	            className:      'details-control',
	            orderable:      false,
	            defaultContent: '',
	            data:           "keyno",
	                render: function ( data, type, row, meta ) {
	              	  	return "<span class='hidden'>" + row.keyNo + "</span>";
	                }                
	        },
	        { data: "alertContent"},
	        { data: "newRecordDate" },
	        { data: "createDate" },
	        { data: "source" },
	        { data: "charNo" },
	        { data: "name" },            
	        { data: "idNo" },
	        { data: "gender",
	        	render: function ( data, type, row, meta ) {
	          	  	return row.gender + " / " + row.age;
	            }
	        },
	        { data: "bodyparts" },
	        { data: null,
	        	render: function ( data, type, row, meta ) {
	        		var viewRef = row.charNo === "" ? row.idNo : row.charNo;
	        		return "<span class='func-icon' onclick='imgExport(\"" + row.keyNo + "\")'><i class='fa fa-file-zip-o fa-lg' title='圖檔匯出'></i></span> " +
	        			   "<span class='func-icon' onclick='viewPatient(\"" + viewRef + "\")'><i class='fa fa-arrow-circle-right fa-lg' title='查閱'></i></span>";
	        	}
	        }
	    ];
	}else if(divclass === ".appointment-table"){
		column = [
        	{ data: null,
				render: function ( data, type, row, meta ) {			
            		var statusIcon = row.status === "未總評" ? '<span class="status-tag not-finished">' + row.status + '</i> ' : '<span class="status-tag finished">' + row.status + '</i> ';
            		return statusIcon;
            	}
			 },
        	{ data: "createTime" },
        	{ data: "area" },
        	{ data: "session" },
        	{ data: "doctorNo" },
        	{ data: "charNo" },
        	{ data: "ID_NO" },
        	{ data: "name" },
        	{ data: "examItem"},
        	{ data: "DrOrder" },
        	{ data: null,
            	render: function ( data, type, row, meta ) {
            		var viewRef = row.charNo === "" ? row.ID_NO : row.charNo;
            		return "<span onclick='viewPatient(\"" + viewRef + "\")'><i class='fa fa-arrow-circle-right fa-lg' title='查閱'></i></span>";
            	}
            }
        ];
	}
    
	$(divclass).dataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST"
		},		
        responsive: true,
        sort: false,
        paging: false,
        searching: searching,
        info: info,
        stateSave: true,
        lengthChange: lengthChange,
        pageLength: pages,
        autoWidth: false,
        destroy: true,
        columns: column,
        initComplete: function( data, type, row, meta ){
        	var openRows = [];
        	
        	if(divclass === ".patient-table"){
	        	$('.patient-table tbody').off('click').on('click', 'td.details-control', function () {
	        		var table = $('.patient-table').DataTable();
	                var tr = $(this).closest('tr');
	                var row = table.row(tr);
	                var keyno = $(this).closest('tr').find("span").html();
	         
	                if (row.child.isShown()) {
	                    // close it
	                    row.child.hide();
	                    tr.removeClass('shown');
	                } else {
	                	var result = wg.evalForm.getJson({"data":JSON.stringify()}, "../../../multi/division/v1/api/qryRecordByPatient?infoId=" + keyno);
	                    // close all previously opened rows
	                    closeOpenedRows(table, tr);
	    
	                    // and open this row                       
	                    row.child(format(result)).show();
	                    tr.addClass('shown');
	         
	                    // store current selection
	                    openRows.push(tr);
	                }
	            });
        	}	
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage,data.json.num,data.json.data.length);
        	
        	function closeOpenedRows(table, selectedRow) {
        	    $.each(openRows, function (index, openRow) {
        	        // not the selected row!
        	        if ($.data(selectedRow) !== $.data(openRow)) {
        	            var rowToCollapse = table.row(openRow);
        	            rowToCollapse.child.hide();
        	            openRow.removeClass('shown');
        	            // replace icon to expand
        	            //$(openRow).find('td.details-control').html('<span class="glyphicon glyphicon-plus"></span>');
        	            // remove from list
        	            var index = $.inArray(selectedRow, openRows);
        	            openRows.splice(index, 1);
        	        }
        	    });
        	}
        	
        },
        language: selected_lang
    });	
}

function generatePager(divclass, ajaxUrl, lang){
	var pages = 3
	var searching = false;
	var lengthChange = false;
	var info = false;
	var selected_lang = lang == "zhTW" ? zh_ver : en_ver;
	
	if(divclass === ".patient-table"){
		pages = 10;
		//searching = true;
		lengthChange = true;
		//info = true;
	}
    
	$(divclass).dataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST"
		},		
        responsive: true,
        sort: false,
        paging: false,
        searching: searching,
        info: info,
        stateSave: true,
        lengthChange: lengthChange,
        pageLength: pages,
        autoWidth: false,
        destroy: true,
        columns: [
        	{ data: null,
				render: function ( data, type, row, meta ) {			
            		var statusIcon = row.status === "未總評" ? '<span class="status-tag not-finished">' + row.status + '</i> ' : '<span class="status-tag finished">' + row.status + '</i> ';
            		return statusIcon;
            	}
			 },
        	{ data: "createTime" },
        	{ data: "area" },
        	{ data: "session" },
        	{ data: "doctorNo" },
        	{ data: "charNo" },
        	{ data: "ID_NO" },
        	{ data: "name" },
        	{ data: "examItem"},
        	{ data: "DrOrder" },
        	{ data: null,
            	render: function ( data, type, row, meta ) {
            		var viewRef = row.charNo === "" ? row.ID_NO : row.charNo;
            		return "<span onclick='viewPatient(\"" + viewRef + "\")'><i class='fa fa-arrow-circle-right fa-lg' title='查閱'></i></span>";
            	}
            }
        	/*
            {
                className:      'details-control',
                orderable:      false,
                defaultContent: '',
                data:           "keyno",
	                render: function ( data, type, row, meta ) {
	              	  	return "<span class='hidden'>" + row.keyNo + "</span>";
	                }                
            }
            */
        ],
        initComplete: function( data, type, row, meta ){
        	var openRows = [];
        	
        	$('.patient-table tbody').off('click').on('click', 'td.details-control', function () {
        		var table = $('.patient-table').DataTable();
                var tr = $(this).closest('tr');
                var row = table.row(tr);
                var keyno = $(this).closest('tr').find("span").html();
         
                if (row.child.isShown()) {
                    // close it
                    row.child.hide();
                    tr.removeClass('shown');
                } else {
                	var result = wg.evalForm.getJson({"data":JSON.stringify()}, "../../../multi/division/v1/api/qryRecordByPatient?infoId=" + keyno);
                    // close all previously opened rows
                    closeOpenedRows(table, tr);
    
                    // and open this row                       
                    row.child(format(result)).show();
                    tr.addClass('shown');
         
                    // store current selection
                    openRows.push(tr);
                }
            });
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage,data.json.num,data.json.data.length);
        	
        	function closeOpenedRows(table, selectedRow) {
        	    $.each(openRows, function (index, openRow) {
        	        // not the selected row!
        	        if ($.data(selectedRow) !== $.data(openRow)) {
        	            var rowToCollapse = table.row(openRow);
        	            rowToCollapse.child.hide();
        	            openRow.removeClass('shown');
        	            // replace icon to expand
        	            //$(openRow).find('td.details-control').html('<span class="glyphicon glyphicon-plus"></span>');
        	            // remove from list
        	            var index = $.inArray(selectedRow, openRows);
        	            openRows.splice(index, 1);
        	        }
        	    });
        	}
        	
        },
        language: selected_lang
    });	
}

function generateMemberPager(divclass, ajaxUrl, lang){
	var pages = 10;
	var searching = false;
	var lengthChange = true;
	var info = false;
	var selected_lang = lang == "zhTW" ? zh_ver : en_ver;

	$(divclass).dataTable({
		data: data,		
        responsive: true,
        sort: false,
        paging: false,
        searching: searching,
        info: info,
        stateSave: true,
        lengthChange: lengthChange,
        pageLength: pages,
        autoWidth: false,
        destroy: true,
        columns: [
        	{ data: "participantNo"},
        	{ data: "role" },
        	{ data: "institute" },
        	{ data: "division" },
        	{ data: "name" },
        	{ data: "createDate" },
        	{ data: null,
            	render: function ( data, type, row, meta ) {
            		return "<button onclick='viewMember(\"" + row.serialNo + "\")'><i class='fa fa-search ' title='檢視資訊'></i> 檢視</button>" +
            			   "<button onclick='closeMember(\"" + row.serialNo + "\")'><i class='fa fa-comment-slash' title='取消資格'></i> 取消資格</button>" +
            			   "<button onclick='createGroup(\"" + row.serialNo + "\")'><i class='fa fa-user-group' title='群組建立'></i> 群組建立</button>";
            	}
            }

        ],
        initComplete: function( data, type, row, meta ){
        	var openRows = [];
        	       	
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage,data.json.num,data.json.data.length);	
        },
        language: selected_lang
    });	
}

function CreatePaging(gCurPage,total_record,length) {
	var total_page = 1 ;
	var display_count = parseInt($('.displaynum').val());
	
	if ( length == 0 )
	  $('.startRecordNum').text('0');
	else
	  $('.startRecordNum').text( ((gCurPage-1)*display_count)+1 );
	$('.endRecordNum').text( ( (gCurPage-1) * display_count ) + length );
	if ( display_count == "all" )
	  total_page = 2;
    else
	  total_page = Math.ceil(total_record / display_count) + 1 ;
  
    var li, a ;
	var current_page ;
	var pagination = document.getElementsByClassName("pagination")[0];
	
	if ( gCurPage < 0 )
	  gCurPage = 0;
	
	if ( gCurPage >= total_page-1 )
	  gCurPage = total_page-1;
  
	li = document.createElement("li");                     // Pre
	li.setAttribute("class","paginate_button previous");
	li.setAttribute("aria-controls","DataTables_Table_0");
	li.setAttribute("id","DataTables_Table_0_previous");
	li.setAttribute("onclick","click_page("+(gCurPage-1)+")");
	a = document.createElement("a");
	a.setAttribute("href","#");
	a.innerHTML = "<";
	li.appendChild(a);
	pagination.appendChild(li);
	
	if ( gCurPage <= 1 ) {
	  $('#DataTables_Table_0_previous').addClass('disabled');
      li.removeAttribute("onclick");
	}
	
	if ( total_page <= 7 ) {
	  for ( var i = 1 ; i < total_page ; i++ ) {
	    li = document.createElement("li");                     // page
	    li.setAttribute("class","paginate_button");
	    li.setAttribute("aria-controls","DataTables_Table_0");
	    li.setAttribute("id","page_"+i);
	    li.setAttribute("onclick","click_page("+i+")");
	    a = document.createElement("a");
	    a.setAttribute("href","#");
	    a.innerHTML = i;
	    li.appendChild(a);
	    pagination.appendChild(li);
	  }
		
	}
	else {
	  li = document.createElement("li");                     // page 1
	  li.setAttribute("class","paginate_button");
	  li.setAttribute("aria-controls","DataTables_Table_0");
	  li.setAttribute("id","page_1");
	    li.setAttribute("onclick","click_page(1)");
	  a = document.createElement("a");
	  a.setAttribute("href","#");
	  a.innerHTML = "1";
	  li.appendChild(a);
	  pagination.appendChild(li);
	  
	  if ( gCurPage <= 4 ) {
	    for ( var i = 2 ; i <= 5 ; i++ ) {
	      li = document.createElement("li");                     // page 2~5
	      li.setAttribute("class","paginate_button");
	      li.setAttribute("aria-controls","DataTables_Table_0");
	      li.setAttribute("id","page_"+i);
	      li.setAttribute("onclick","click_page("+i+")");
	      a = document.createElement("a");
	      a.setAttribute("href","#");
	      a.innerHTML = i;
	      li.appendChild(a);
	      pagination.appendChild(li);
	    }
		
	    li = document.createElement("li");                     // page ...
	    li.setAttribute("class","paginate_button disabled");
	    li.setAttribute("aria-controls","DataTables_Table_0");
	    li.setAttribute("id","page_dot");
	    a = document.createElement("a");
	    a.setAttribute("href","#");
	    a.innerHTML = "...";
	    li.appendChild(a);
	    pagination.appendChild(li);
	  }
	  
	  else if ( gCurPage >= total_page - 3 ) {
	    li = document.createElement("li");                     // page ...
	    li.setAttribute("class","paginate_button disabled");
	    li.setAttribute("aria-controls","DataTables_Table_0");
	    li.setAttribute("id","page_dot");
	    a = document.createElement("a");
	    a.setAttribute("href","#");
	    a.innerHTML = "...";
	    li.appendChild(a);
	    pagination.appendChild(li);
		  
	    for ( var i = total_page-5 ; i < total_page-1 ; i++ ) {
	      li = document.createElement("li");                     // page total_page-5 ~ total-1
	      li.setAttribute("class","paginate_button");
	      li.setAttribute("aria-controls","DataTables_Table_0");
	      li.setAttribute("id","page_"+i);
	      li.setAttribute("onclick","click_page("+i+")");
	      a = document.createElement("a");
	      a.setAttribute("href","#");
	      a.innerHTML = i;
	      li.appendChild(a);
	      pagination.appendChild(li);
	    }
	  }
	  
	  else {
	    li = document.createElement("li");                     // page ...
	    li.setAttribute("class","paginate_button disabled");
	    li.setAttribute("aria-controls","DataTables_Table_0");
	    li.setAttribute("id","page_dot");
	    a = document.createElement("a");
	    a.setAttribute("href","#");
	    a.innerHTML = "...";
	    li.appendChild(a);
	    pagination.appendChild(li);
		
	    for ( var i = gCurPage-1 ; i <= gCurPage+1 ; i++ ) {
	      li = document.createElement("li");                     // page gCurPage-1 ~ gCurPage+1
	      li.setAttribute("class","paginate_button");
	      li.setAttribute("aria-controls","DataTables_Table_0");
	      li.setAttribute("id","page_"+i);
	      li.setAttribute("onclick","click_page("+i+")");
	      a = document.createElement("a");
	      a.setAttribute("href","#");
	      a.innerHTML = i;
	      li.appendChild(a);
	      pagination.appendChild(li);
	    }
		
	    li = document.createElement("li");                     // page ...
	    li.setAttribute("class","paginate_button disabled");
	    li.setAttribute("aria-controls","DataTables_Table_0");
	    li.setAttribute("id","page_dot");
	    a = document.createElement("a");
	    a.setAttribute("href","#");
	    a.innerHTML = "...";
	    li.appendChild(a);
	    pagination.appendChild(li);
	  }
	  
	  li = document.createElement("li");                     // page total
	  li.setAttribute("class","paginate_button");
	  li.setAttribute("aria-controls","DataTables_Table_0");
	  li.setAttribute("id","page_"+(total_page-1));
	  li.setAttribute("onclick","click_page("+(total_page-1)+")");
	  a = document.createElement("a");
	  a.setAttribute("href","#");
	  a.innerHTML = total_page-1;
	  li.appendChild(a);
	  pagination.appendChild(li);
		
	}
	
	$('#page_'+gCurPage).addClass('active').removeAttr("onclick");
	
	li = document.createElement("li");                     // next
	li.setAttribute("class","paginate_button next");
	li.setAttribute("aria-controls","DataTables_Table_0");
	li.setAttribute("id","DataTables_Table_0_next");
	li.setAttribute("onclick","click_page("+(gCurPage+1)+")");
	a = document.createElement("a");
	a.setAttribute("href","#");
	a.innerHTML = ">";
	li.appendChild(a);
	pagination.appendChild(li);
	  
	if ( gCurPage == total_page-1 ) {
	  $('#DataTables_Table_0_next').addClass('disabled');
	  li.removeAttribute("onclick");
	}
}
