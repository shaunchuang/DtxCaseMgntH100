var noReadData = [
{"keyNo":"0000230002",
"date":"09/22",
"name":"林X吉",
"idNo":"P101481324",
"charNo":"20200704",
"gender":"M",
"age":"78",
"diagnosis":"Fatty Liver",
"item":"超",
"bodypart":"腹部",
"history":"H/T",
"institute":"高揚威",
"chef":"高揚威",
"area":"澤仁里",
"nurse":"陳雅惠",
"manager":"林君汝",
"caseClose":"N",
"woundInfoList":[]},
{"keyNo":"0000230003",
"date":"09/22",
"name":"廖X賢",
"idNo":"P100139661",
"charNo":"20210807",
"gender":"M",
"age":"90",
"diagnosis":"Senile macular degeneration",
"item":"眼",
"bodypart":"雙眼",
"history":"nil",
"institute":"高揚威",
"chef":"高揚威",
"area":"澤仁里",
"nurse":"陳雅惠",
"manager":"林君汝",
"caseClose":"N",
"phone":"03-4887231",
"address":"新竹縣xxxxxx",
"helppeople1":"兒子",
"helppeople1phone":"0936056222",
"helppeople2":"女兒",
"helppeople2phone":"0958782885",
"woundInfoList":[]},

{"keyNo":"0000230007",
"date":"09/22",
"name":"王X順",
"idNo":"F126732154",
"charNo":"20225566",
"gender":"M",
"age":"82",
"diagnosis":"Liver cirrhosis,Pressure sore",
"item":"超,傷",
"bodypart":"腹部,肩部",
"history":"nil",
"institute":"高揚威",
"chef":"高揚威",
"area":"三民里",
"nurse":"陳雅惠",
"manager":"林君汝",
"caseClose":"N",
"woundInfoList":[]},
{"keyNo":"0000230004",
"date":"09/22",
"name":"張X江",
"idNo":"P200123456",
"charNo":"20210809",
"gender":"F",
"age":"80",
"diagnosis":"Retinal vein occlusion,DM foot",
"item":"眼",
"bodypart":"雙眼",
"history":"nil",
"institute":"高揚威",
"chef":"高揚威",
"area":"澤仁里",
"nurse":"陳雅惠",
"manager":"林君汝",
"caseClose":"N",
"woundInfoList":[]},
{"keyNo":"0000230001",
	"date":"09/22",
	"name":"曾X菊",
	"idNo":"P200330772",
	"charNo":"10907024",
	"gender":"F",
	"age":"76",
	"diagnosis":"Pressure sore",
	"item":"傷",
	"bodypart":"薦椎",
	"history":"DM,H/T",
	"institute":"高揚威",
	"chef":"高揚威",
	"area":"澤仁里",
	"nurse":"陳雅惠",
	"manager":"林君汝",
	"caseClose":"N",
	"woundInfoList":[]},
	{"keyNo":"0000230000",
	"date":"09/22",
	"name":"林X隨",
	"idNo":"P200153903",
	"charNo":"20200601",
	"gender":"M",
	"age":"89",
	"diagnosis":"Diabetic retinopathy",
	"item":"眼",
	"bodypart":"右眼",
	"history":"DM,H/T",
	"institute":"高揚威",
	"chef":"高揚威",
	"area":"澤仁里",
	"nurse":"陳雅惠",
	"manager":"林君汝",
	"caseClose":"N",
	"woundInfoList":[]},

{"keyNo":"0000230005",
"date":"09/22",
"name":"王X方",
"idNo":"D100132161",
"charNo":"20210707",
"gender":"F",
"age":"66",
"diagnosis":"DM Foot,Retinal vein occlusion",
"item":"傷,眼",
"bodypart":"腳,雙眼",
"history":"DM,H/T",
"institute":"高揚威",
"chef":"高揚威",
"area":"三民里",
"nurse":"陳雅惠",
"manager":"林君汝",
"caseClose":"N",
"woundInfoList":[]},
{"keyNo":"0000230006",
"date":"09/22",
"name":"劉x雄",
"idNo":"D122132154",
"charNo":"20110909",
"gender":"M",
"age":"68",
"diagnosis":"P.A.O.D",
"item":"ABI",
"bodypart":"左側",
"history":"DM,H/T",
"institute":"高揚威",
"chef":"高揚威",
"area":"三民里",
"nurse":"陳雅惠",
"manager":"林君汝",
"caseClose":"N",
"woundInfoList":[]}


];

var readData = [

];

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

function generatePager(divclass, ajaxUrl, param){
	var pages = 3
	var searching = false;
	var lengthChange = false;
	var info = false;
	var testData;
	if(param != ""){
		testData = param == "Y" ? readData : noReadData;
	}
	else{
		testData = readData.concat(noReadData);
	}
	
	if(divclass === ".patient-table"){
		pages = 10;
		searching = true;
		lengthChange = true;
		info = true;
	}
    
	$(divclass).dataTable({
		/*ajax: {
			url: ajaxUrl,
			type: "POST"
		},*/
		data: testData,
        responsive: true,
        sort: false,
        paging: true,
        searching: searching,
        info: info,
        stateSave: true,
        lengthChange: lengthChange,
        pageLength: pages,
        autoWidth: false,
        destroy: true,
        columns: [
            {
                className:      'details-control',
                orderable:      false,
                data:           null,
                defaultContent: ''
            },
            { data: "date" },
            { data: "name" },
            { data: "charNo" },
            { data: "idNo" },
            { data: "gender",
            	render: function ( data, type, row, meta ) {
              	  	return row.gender + " / " + row.age;
                }
            },
            { data: "diagnosis" },
            { data: "item" },
            { data: "bodypart" },
            { data: "history" },
            { data: "institute" },
            { data: "chef" },
            { data: "area" },
            { data: "nurse" },
            { data: "manager" },
            { data: null,
            	render: function ( data, type, row, meta ) {
            		var btns = "";
            		var viewNo = row.charNo === "" ? row.idNo : row.charNo;
            		var items = row.item.split(",");
            		for(var i=0; i<items.length; i++){
            			btns += "<div class='circle' onclick='viewPatient(\"" + viewNo + "\",\"" + items[i] + "\")'>" + items[i] + "</div> ";
            		}
            		return btns;
            	}
            }
        ],
        initComplete: function(){
        	$('.patient-table tbody').off('click').on('click', 'td.details-control', function () {
        	    var tr = $(this).closest('tr');
        	    var keyNo = tr.attr("keyNo");
        	    var table = $('.patient-table').DataTable();
        	    var row = table.row( tr );        	    
        	 
        	    if ( row.child.isShown() ) {
        	        row.child.hide();
        	        tr.removeClass('shown');
        	    }
        	    else {
        	    	if ( table.row( '.shown' ).length ) {
        	    		$('.details-control', table.row( '.shown' ).node()).click();
        	    	}
        	        row.child( format(row.data()) ).show();
        	        tr.addClass('shown');
        	    }
        	});
        	
        },
        language: {
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
    });
	
	
}