var zh_ver = {
	search: "搜尋:&nbsp;&nbsp;",
	lengthMenu: "每頁顯示 _MENU_ 筆",
	info: "第 _START_ 筆 - 第 _END_ 筆 總共 _TOTAL_ 筆",
	infoEmpty: "總共 _TOTAL_ 筆",
	loadingRecords: "載入中...",
	emptyTable: "無資料",
	zeroRecords: "無法找到相符條件的資料",
	infoFiltered: "(搜尋共 _MAX_ 筆資料)",
	paginate: {
		first: "首頁",
		previous: "上頁",
		next: "下頁",
		last: "末頁"
	},
	aria: {
		sortAscending: ": 升冪",
		sortDescending: ": 降冪"
	}
}

var en_ver = {
	search: "Search:&nbsp;&nbsp;",
	lengthMenu: "Show _MENU_ Records",
	info: "_START_ - _END_ record, Total _TOTAL_ records",
	infoEmpty: "Total _TOTAL_ records",
	loadingRecords: "loading...",
	emptyTable: "No data",
	zeroRecords: "Unable to find the matching data",
	infoFiltered: "(搜尋共 _MAX_ 筆資料)",
	paginate: {
		first: "First",
		previous: "Prev",
		next: "Next",
		last: "Last"
	},
	aria: {
		sortAscending: ": 升冪",
		sortDescending: ": 降冪"
	}
}

var zh_chart = { "chartNum": 2, "dimension": ['長度', '寬度', '深度'], "proportion": ['上皮', '肉芽', '腐肉', '壞死'], "physicalIdx": ['體溫', '心跳', '收縮壓', '舒張壓'] };
var en_chart = { "chartNum": 2, "dimension": ['Height', 'Width', 'Depth'], "proportion": ['Epit.', 'Gran.', 'Slou.', 'Necr.'], "physicalIdx": ['Temperature', 'BPM', 'DBP', 'SBP'] };

var colors = {
	red: {
		fill: 'rgb(255, 99, 132, 0.8)',
		stroke: 'rgb(255, 99, 132)'
	},
	cherryRed: {
		fill: 'rgb(255, 0, 0, 0.8)',
		stroke: 'rgb(255, 0, 0)'
	},
	orange: {
		fill: 'rgb(255, 159, 64, 0.8)',
		stroke: 'rgb(255, 159, 64)'
	},
	pink: {
		fill: 'rgb(255, 192, 203, 0.8)',
		stroke: 'rgb(255, 192, 203)'
	},
	yellow: {
		fill: 'rgb(255, 215, 87, 0.8)',
		stroke: 'rgb(255, 215, 87)'
	},
	lightYellow: {
		fill: 'rgb(255, 224, 125, 0.8)',
		stroke: 'rgb(255, 224, 125)'
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
	black: {
		fill: 'rgb(0, 0, 0, 0.8)',
		stroke: 'rgb(0, 0, 0)',
	},
	customBlue: {
		fill: 'rgb(68, 114, 196, 0.8)',
		stroke: 'rgb(68, 114, 196)'
	}
};

function $import(src, callback) {
	var scriptElem = document.createElement('script');
	scriptElem.setAttribute('src', src);
	scriptElem.setAttribute('type', 'text/javascript');
	scriptElem.onload = callback;
	//Internet explorer
	scriptElem.onreadystatechange = function () {
		if (this.readyState == 'complete') {
			callback();
		}
	}
	document.getElementsByTagName('head')[0].appendChild(scriptElem);
}

function $importCSS(src) {
	var cssElem = document.createElement('link');
	cssElem.setAttribute('src', src);
	cssElem.setAttribute('type', 'text/css');
	cssElem.setAttribute('rel', 'stylesheet');
	document.getElementsByTagName('head')[0].appendChild(cssElem);
}

function getEditTime() { //取得編輯時間
	var today = new Date();
	var yyyy = today.getFullYear();
	var mm = String(today.getMonth() + 1).padStart(2, '0');
	var dd = String(today.getDate()).padStart(2, '0');
	var hour = String(today.getHours()).padStart(2, '0');
	var min = String(today.getMinutes()).padStart(2, '0');
	var sec = String(today.getSeconds()).padStart(2, '0');

	return yyyy + "-" + mm + "-" + dd + " " + hour + ":" + min + ":" + sec;
}

function cleanDataTables() {
	var tables = $.fn.dataTable.fnTables(true);
	$(tables).each(function () {
		$(this).dataTable().fnClearTable();
		$(this).dataTable().fnDestroy();
	});
}

function generatePager(divclass, lang, isPaging) {
	var pages = divclass === ".archive-list" ? 10 : 2;

	var selected_lang;

	if (lang == "zhTW") {
		selected_lang = zh_ver;
	}
	else {
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
		destroy: true,

		language: selected_lang
	});

	/*$('.refresh').click(function() {
		customTable.ajax.reload(null, false);
	});*/
}

//使用ajax與可排序table
function initAjaxSortTable(divclass, pages, ajaxUrl, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST"
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: columnObj,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var itemId = $(".itemId").val() == undefined ? "" : $(".itemId").val();
		var param = $(".param").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var reloadUrl = api + "page_num=1&limit=" + limit + "&sort=" + className + "&order=" + order + "&itemId=" + itemId + "&param=" + param;

		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(reloadUrl).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", "table.dataTable tbody tr td", function () {
		var parent = $(this).parent("tr");
		var data = table.row(parent).data();
		window.open(base + "/" + lang_ref + "/division/web/patient/" + data.keyNo + "/caseView");
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var itemId = $(".itemId").val() == undefined ? "" : $(".itemId").val();
		var param = $(".param").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {
			var sortStr = "";
			var oldpage = $(".paginate_button.active").find("a").html();

			if (sortClass != "" && sortOrder != "") {
				sortStr = "page_num=" + pagenum + "&limit=" + limit + "&sort=" + sortClass + "&order=" + sortOrder + "&itemId=" + itemId + "&param=" + param;
			} else {
				sortStr = "page_num=" + pagenum + "&limit=" + limit + "&itemId=" + itemId + "&param=" + param;
			}

			var reloadUrl = api + sortStr;
			table.clear().draw();
			table.ajax.url(reloadUrl).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	$(".itemId").on("change", function () {
		$(".param").val("");
		table.clear().draw();
		table.ajax.url(ajaxUrl).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	//搜尋符合特定條件之個案
	$(".param").on("input", function () {
		var param = $(this).val();
		var itemId = $(".itemId").val();
		var sortStr = "";

		if (itemId == undefined) {
			sortStr = "page_num=1&limit=" + limit + "&param=" + param;
		} else {
			sortStr = "page_num=1&limit=" + limit + "&itemId=" + itemId + "&param=" + param;
		}

		var reloadUrl = api + sortStr;

		table.clear().draw();
		table.ajax.url(reloadUrl).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

}

//使用ajax與可排序病患列表
function initPtSortTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: columnObj,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			var openRows = [];

			$('.main-table tbody').off('click').on('click', 'td.details-control', function () {
				var table = $('.main-table').DataTable();
				var tr = $(this).closest('tr');
				var row = table.row(tr);
				var keyno = $(this).closest('tr').find("span").html();

				if (row.child.isShown()) {
					// close it
					row.child.hide();
					tr.removeClass('shown');
				} else {
					var result = wg.evalForm.getJson({ "data": JSON.stringify() }, base + "/" + lang_ref + "/division/api/qryRecordByPatient?infoId=" + keyno);
					// close all previously opened rows
					closeOpenedRows(table, tr);

					// and open this row                       
					var childRow = row.child(format(result)).show();

					tr.addClass('shown');

					// store current selection
					openRows.push(tr);
				}
			});

			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);

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
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var qryBy = $(".qryBy").val();
		var param = $(".param").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "qryBy": qryBy, "param": param, "sort": className, "order": order, "page_num": 1, "limit": limit };

		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", "table.dataTable tbody tr td:not(:first-child):not(:last-child)", function () {
		var parent = $(this).parent("tr");
		var data = table.row(parent).data();
		window.open(base + "/" + lang_ref + "/division/web/patient/" + data.keyNo + "/caseView");
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var qryBy = $(".qryBy").val();
		var param = $(".param").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {
			var queryData = "";

			if (sortClass != "" && sortOrder != "") {
				queryData = { "userId": cUserId, "qryBy": qryBy, "param": param, "sort": sortClass, "order": order, "page_num": pagenum, "limit": limit };
			} else {
				queryData = { "userId": cUserId, "qryBy": qryBy, "param": param, "page_num": pagenum, "limit": limit };
			}

			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	$(".qryBy").on("change", function () {
		$(".param").val("");
		var queryData = { "userId": cUserId, "page_num": 1, "limit": limit };
		searchObj = JSON.stringify(queryData);

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	//搜尋符合特定條件之個案
	$(".param").on("input", function () {
		var param = $(this).val();
		var qryBy = $(".qryBy").val();
		var queryData = "";

		if (qryBy == "") {
			queryData = { "userId": cUserId, "param": param, "page_num": 1, "limit": limit };
		} else {
			queryData = { "userId": cUserId, "qryBy": qryBy, "param": param, "page_num": 1, "limit": limit };
		}

		searchObj = JSON.stringify(queryData);

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$.contextMenu({
		selector: '#list_cnt tr',
		callback: function (key, opt) {
			var targetLink = $(this);
			if (key == "delete") {
				var keyno = targetLink.find(".status-btn").data("keyno");
				var occasionDate = $(this).val();
				var param = $(".param").val();
				var itemId = $(".itemId").val() == "" ? null : $(".itemId").val();
				var queryData = "";
				var pagenum = $(".paginate_button.active > a").html();
				var remainRecords = $("#list_cnt tr").length;

				if (remainRecords - 1 == 0) pagenum--;

				confirmCheck("刪除確認", "您確認要刪除此筆個案所有紀錄嗎?", "warning", "btn-danger", "刪除", "取消", function (confirmed) {
					if (confirmed) {
						var postData = { "caseno": keyno, "useMark": false };
						var result = wg.evalForm.getJson({ "data": JSON.stringify(postData) }, "../division/api/delRecord?location=" + field);
						if (result.success) {
							opt.$menu.trigger('contextmenu:hide');
							swal("刪除成功", "個案相關紀錄已刪除完成!", "success");

							if (pagenum != undefined) {
								if (itemId == undefined) {
									queryData = { "userId": cUserId, "occasionDate": occasionDate, "param": param, "page_num": 1, "limit": limit };
								} else {
									queryData = { "userId": cUserId, "occasionDate": occasionDate, "itemId": itemId, "param": param, "page_num": 1, "limit": limit };
								}

								searchObj = JSON.stringify(queryData);

								table.clear().draw();
								$("table .dataTables_empty").text(zh_ver.loadingRecords);
								table.ajax.url(api).load(function (data) {
									$('.total_record').html(data.num);
									$('.pagination').html('');
									CreatePaging(pagenum, data.num, data.data.length);
								});
							}
						}
					}
				});
			}
		},
		items: {
			"delete": {
				name: "刪除個案紀錄", icon: "delete"
			},
			"sep1": "---------",
			"quit": {
				name: "離開", icon: function () {
					return 'context-menu-icon context-menu-icon-quit';
				}
			}
		}
	});
}

//使用ajax與可排序FHIR病患列表
function initFhirPtSortTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: columnObj,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var param = $(".param").val();
		var paramTxt = $(".paramTxt").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "sort": className, "order": order, "page_num": 1, "limit": limit };

		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", "table.dataTable tbody tr td", function () {
		var parent = $(this).parent("tr");
		var data = table.row(parent).data();
		window.open(base + "/" + lang_ref + "/division/web/exchange/fhir/patient/" + data.id + "/caseView");
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var param = $(".param").val();
		var paramTxt = $(".paramTxt").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {
			var queryData = "";

			if (sortClass != "" && sortOrder != "") {
				queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "sort": sortClass, "order": sortOrder, "page_num": pagenum, "limit": limit };
			} else {
				queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "page_num": pagenum, "limit": limit };
			}

			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	$(".search-btn").on("click", function () {
		var id = $(".id").val();
		var idno = $(".idno").val();
		var name = $(".name").val();
		var birthDate = $(".birthDate").val();
		var gender = $(".gender").val().toLowerCase();
		var orgnization = $(".orgnization").val();
		var queryData = { "userId": cUserId, "id": id, "idno": idno, "name": name, "birthDate": birthDate, "gender": gender, "orgnization": orgnization, "page_num": 1, "limit": limit };
		searchObj = JSON.stringify(queryData);
		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});
}

//使用ajax與可排序FHIR生理量測列表
function initFhirObSortTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: columnObj,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var param = $(".param").val();
		var paramTxt = $(".paramTxt").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "sort": className, "order": order, "page_num": 1, "limit": limit };

		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", "table.dataTable tbody tr td", function () {
		var parent = $(this).parent("tr");
		var data = table.row(parent).data();
		var subject = data.subject.reference.myStringValue.toLowerCase();
		window.open(base + "/" + lang_ref + "/division/web/exchange/fhir/" + subject + "/observation/" + data.id);
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var param = $(".param").val();
		var paramTxt = $(".paramTxt").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {
			var queryData = "";

			if (sortClass != "" && sortOrder != "") {
				queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "sort": sortClass, "order": sortOrder, "page_num": pagenum, "limit": limit };
			} else {
				queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "page_num": pagenum, "limit": limit };
			}

			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	$(".search-btn").on("click", function () {
		var id = $(".id").val();
		var code = $(".code").val();
		var patientId = $(".patientId").val() == "" ? ptId : $(".patientId").val();
		var startDate = $(".startDate").val();
		var endDate = $(".endDate").val();
		var queryData = { "userId": cUserId, "id": id, "code": code, "patientId": patientId, "startDate": startDate, "endDate": endDate, "page_num": 1, "limit": limit };
		searchObj = JSON.stringify(queryData);
		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

}

//使用ajax與可排序FHIR醫學影像列表
function initFhirImagingStudySortTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: columnObj,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var param = $(".param").val();
		var paramTxt = $(".paramTxt").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "sort": className, "order": order, "page_num": 1, "limit": limit };

		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", "table.dataTable tbody tr td", function () {
		var parent = $(this).parent("tr");
		var data = table.row(parent).data();
		var subject = data.subject.reference.myStringValue.toLowerCase();
		window.open(base + "/" + lang_ref + "/division/web/exchange/fhir/" + subject + "/imagingstudy/" + data.id);
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var param = $(".param").val();
		var paramTxt = $(".paramTxt").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {
			var queryData = "";

			if (sortClass != "" && sortOrder != "") {
				queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "sort": sortClass, "order": sortOrder, "page_num": pagenum, "limit": limit };
			} else {
				queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "page_num": pagenum, "limit": limit };
			}

			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	$(".search-btn").on("click", function () {
		var id = $(".id").val();
		var patientId = $(".patientId").val() == "" ? ptId : $(".patientId").val();

		var queryData = { "userId": cUserId, "id": id, "patientId": patientId, "page_num": 1, "limit": limit };
		searchObj = JSON.stringify(queryData);
		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

}

//使用ajax與可排序FHIR診斷報告列表
function initFhirDiagReportSortTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: columnObj,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var param = $(".param").val();
		var paramTxt = $(".paramTxt").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "sort": className, "order": order, "page_num": 1, "limit": limit };

		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", "table.dataTable tbody tr td", function () {
		var parent = $(this).parent("tr");
		var data = table.row(parent).data();
		var subject = data.subject.reference.myStringValue.toLowerCase();
		window.open(base + "/" + lang_ref + "/division/web/exchange/fhir/" + subject + "/diagnosticreport/" + data.id);
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var param = $(".param").val();
		var paramTxt = $(".paramTxt").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {
			var queryData = "";

			if (sortClass != "" && sortOrder != "") {
				queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "sort": sortClass, "order": sortOrder, "page_num": pagenum, "limit": limit };
			} else {
				queryData = { "userId": cUserId, "param": param, "paramTxt": paramTxt, "page_num": pagenum, "limit": limit };
			}

			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	$(".search-btn").on("click", function () {
		var id = $(".id").val();
		var patientId = $(".patientId").val() == "" ? ptId : $(".patientId").val();

		var queryData = { "userId": cUserId, "id": id, "patientId": patientId, "page_num": 1, "limit": limit };
		searchObj = JSON.stringify(queryData);
		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

}

function initAjaxMultiDataSortTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);
	var defs = columnObj;
	//var param = "";
	//var order = "";
	//var className = "";

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: defs,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var ptNo = $(".ptNo").val();
		var idNo = $(".idNo").val();
		var ptName = $(".ptName").val();
		var startDate = $(".startDatePicker").val();
		var endDate = $(".endDatePicker").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "ptNo": ptNo, "idNo": idNo, "ptName": ptName, "startDate": startDate, "endDate": endDate, "page_num": 1, "limit": limit, "sortBy": className, "order": order };
		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var ptNo = $(".ptNo").val();
		var idNo = $(".idNo").val();
		var ptName = $(".ptName").val();
		var startDate = $(".startDatePicker").val();
		var endDate = $(".endDatePicker").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {

			var queryData = { "userId": cUserId, "ptNo": ptNo, "idNo": idNo, "ptName": ptName, "startDate": startDate, "endDate": endDate, "page_num": pagenum, "limit": limit, "sortBy": sortClass, "order": sortOrder };
			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	//搜尋符合特定條件之個案
	$(".search").on("click", function () {
		var ptNo = $(".ptNo").val();
		var idNo = $(".idNo").val();
		var ptName = $(".ptName").val();
		var startDate = $(".startDatePicker").val();
		var endDate = $(".endDatePicker").val();
		var queryData = { "userId": cUserId, "ptNo": ptNo, "idNo": idNo, "ptName": ptName, "startDate": startDate, "endDate": endDate, "page_num": 1, "limit": limit, "sortBy": sortClass, "order": sortOrder };
		searchObj = JSON.stringify(queryData);

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

}

//使用ajax與可排序table
function initAjaxDataSortTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info, pagingRequired) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);
	var defs = columnObj;
	//var param = "";
	//var order = "";
	//var className = "";

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: defs,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			if (pagingRequired == undefined) {
				$('.total_record').html(data.json.num);
				$('.pagination').html('');
				CreatePaging(gCurPage, data.json.num, data.json.data.length);
			}
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var param = $(".param").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "param": param, "page_num": 1, "limit": limit, "sortBy": className, "order": order };
		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			if (pagingRequired == undefined) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(1, data.num, data.data.length);
			}
		});
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var param = $(".param").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {

			var queryData = { "userId": cUserId, "param": param, "page_num": pagenum, "limit": limit, "sortBy": sortClass, "order": sortOrder };
			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				if (pagingRequired == undefined) {
					$('.total_record').html(data.num);
					$('.pagination').html('');
					CreatePaging(pagenum, data.num, data.data.length);
				}
			});
		}
	});

	//搜尋符合特定條件之個案
	$(".param").on("input", function () {
		var param = $(this).val();
		var queryData = { "userId": cUserId, "param": param, "page_num": 1, "limit": limit, "sortBy": sortClass, "order": sortOrder };
		searchObj = JSON.stringify(queryData);

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			if (pagingRequired == undefined) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(1, data.num, data.data.length);
			}
		});
	});

	$(document).on('click', '.viewResult', function (e) {
		e.preventDefault();

		var parent = $(this).closest('tr');
		var data = table.row(parent).data();

		$("#myModal2").modal('show');

		shownModal(data);
	});

	$(document).on('click', '.query-eval', function (e) {
		e.preventDefault();

		var evalName = $(".evalName").val();
		var startDate = $(".startDate").val();
		var endDate = $(".endDate").val();
		var queryData = { "patientId": formId, "param": evalName, "assessmentBeginDate": formatDate(startDate), "assessmentEndDate": formatDate(endDate) };
		searchObj = JSON.stringify(queryData);

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			if (pagingRequired == undefined) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(1, data.num, data.data.length);
			}
		});
	});
}

//使用ajax與可排序table
function initAjaxDataSortTableV2(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info, pagingRequired) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);
	var defs = columnObj;
	//var param = "";
	//var order = "";
	//var className = "";

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return searchObj
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: defs,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			if (pagingRequired == undefined) {
				$('.total_record').html(data.json.num);
				$('.pagination').html('');
				CreatePaging(gCurPage, data.json.num, data.json.data.length);
			}
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var param = $(".param").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "param": param, "page_num": 1, "limit": limit, "sortBy": className, "order": order };
		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			if (pagingRequired == undefined) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(1, data.num, data.data.length);
			}
		});
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var param = $(".param").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {

			var queryData = { "userId": cUserId, "param": param, "page_num": pagenum, "limit": limit, "sortBy": sortClass, "order": sortOrder };
			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				if (pagingRequired == undefined) {
					$('.total_record').html(data.num);
					$('.pagination').html('');
					CreatePaging(pagenum, data.num, data.data.length);
				}
			});
		}
	});

	//搜尋符合特定條件之個案
	$(".param").on("input", function () {
		var param = $(this).val();
		var queryData = { "userId": cUserId, "param": param, "page_num": 1, "limit": limit, "sortBy": sortClass, "order": sortOrder };
		searchObj = JSON.stringify(queryData);

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			if (pagingRequired == undefined) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(1, data.num, data.data.length);
			}
		});
	});

	$(document).on('click', '.viewResult', function (e) {
		e.preventDefault();

		var parent = $(this).closest('tr');
		var data = table.row(parent).data();

		$("#myModal2").modal('show');

		shownModal(data);
	});

	$(document).on('click', '.query-eval', function (e) {
		e.preventDefault();

		var evalName = $(".evalName").val();
		var startDate = $(".startDate").val();
		var endDate = $(".endDate").val();
		var queryData = { "patientId": formId, "param": evalName, "assessmentBeginDate": formatDate(startDate), "assessmentEndDate": formatDate(endDate) };
		searchObj = JSON.stringify(queryData);

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			if (pagingRequired == undefined) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(1, data.num, data.data.length);
			}
		});
	});
}

//使用ajax與可排序、且無功能鍵之table(點擊某筆資料即可開啟)
function initAjaxDataSortWithoutBtnTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);
	var defs = columnObj;
	//var param = "";
	//var order = "";
	//var className = "";

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: defs,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var param = $(".param").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "param": param, "page_num": 1, "limit": limit, "sortBy": className, "order": order };
		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", "table.dataTable tbody tr td", function () {
		var parent = $(this).parent("tr");
		var data = table.row(parent).data();
		viewDetail(data);
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var param = $(".param").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {

			var queryData = { "userId": cUserId, "param": param, "page_num": pagenum, "limit": limit, "sortBy": sortClass, "order": sortOrder };
			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	//搜尋符合特定條件之個案
	$(".param").on("input", function () {
		var param = $(this).val();
		var queryData = { "userId": cUserId, "param": param, "page_num": 1, "limit": limit, "sortBy": sortClass, "order": sortOrder };
		searchObj = JSON.stringify(queryData);

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});
}

/* 待更新 訓練資料表格 by政煊*/
function initAjaxDataSortTrainingTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);
	var defs = columnObj;
	//var param = "";
	//var order = "";
	//var className = "";

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},

		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: defs,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	table.clear().draw();

	$("table.dataTable thead th").on("click", function () {
		var param = $(".param").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "param": param, "page_num": 1, "limit": limit, "sortBy": className, "order": order };
		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", "table.dataTable tbody tr td", function () {
		var parent = $(this).parent("tr");
		var data = table.row(parent).data();
		viewDetail(data);
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var param = $(".param").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {

			var queryData = { "userId": cUserId, "param": param, "page_num": pagenum, "limit": limit, "sortBy": sortClass, "order": sortOrder };
			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	//搜尋符合特定條件之個案
	/*	$(".param").on("input", function() { 
			var param = $(this).val();
			var queryData = {"userId": cUserId, "param": param, "page_num": 1, "limit": limit, "sortBy": sortClass, "order": sortOrder};
			searchObj = JSON.stringify(queryData);
	
			table.clear().draw();
			table.ajax.url(api).load(function(data){
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(1,data.num,data.data.length);				
			});
		});*/
}

//針對個案健保及長照紀錄客製table
function initAjaxSearchTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);
	var defs = columnObj;

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: defs,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var param = $(".param").val();
		var startDate = $(".startDatePicker").val();
		var endDate = $(".endDatePicker").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "app": app, "param": param, "startDate": startDate, "endDate": endDate, "page_num": 1, "limit": limit, "sortBy": className, "order": order };
		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var param = $(".param").val();
		var startDate = $(".startDatePicker").val();
		var endDate = $(".endDatePicker").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {

			var queryData = { "userId": cUserId, "app": app, "param": param, "startDate": startDate, "endDate": endDate, "page_num": pagenum, "limit": limit, "sortBy": sortClass, "order": sortOrder };
			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	//搜尋符合特定條件之個案
	$(".search").on("click", function () {
		var param = $(".param").val();
		var startDate = $(".startDatePicker").val();
		var endDate = $(".endDatePicker").val();
		var queryData = { "userId": cUserId, "app": app, "param": param, "startDate": startDate, "endDate": endDate, "page_num": 1, "limit": limit, "sortBy": sortClass, "order": sortOrder };
		searchObj = JSON.stringify(queryData);

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

}


function simpleAjaxTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: columnObj,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function (data) {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "app": app, "page_num": 1, "limit": limit, "sortBy": className, "order": order };
		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {

			var queryData = { "userId": cUserId, "app": app, "page_num": pagenum, "limit": limit, "sortBy": sortClass, "order": sortOrder };
			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	//搜尋符合特定條件之內容
	$(".search").on("click", function () {
		var param = $(".param").val();
		var queryData = "";
		if (param != "") {
			queryData = { "userId": cUserId, "app": app, "param": param, "page_num": 1, "limit": limit, "sortBy": sortClass, "order": sortOrder };
		} else {
			queryData = { "userId": cUserId, "app": app, "page_num": 1, "limit": limit, "sortBy": sortClass, "order": sortOrder };
		}
		searchObj = JSON.stringify(queryData);
		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});
}

function newAjaxSearchTable(divclass, pages, ajaxUrl, params, columnObj, columnDefs, lang_info) {
	var searching = false;
	var lengthChange = false;
	var info = false;
	var searchObj = JSON.stringify(params);

	var table = $(divclass).DataTable({
		ajax: {
			url: ajaxUrl,
			type: "POST",
			data: function (d) {
				return { "data": searchObj }
			}
		},
		responsive: true,
		sort: true,
		sorting: [],
		paging: false,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: columnObj,
		columnDefs: columnDefs,
		success: function (data) {
		},
		drawCallback: function () {

		},
		initComplete: function (data, type, row, meta) {
			$('.total_record').html(data.json.num);
			$('.pagination').html('');
			CreatePaging(gCurPage, data.json.num, data.json.data.length);
		},
		language: lang_info
	});

	$("table.dataTable thead th").on("click", function () {
		var year = $(".year").val();
		var month = $(".month").val();
		var className = $(this).attr("class").split(" ")[0];
		var orderStr = $(this).attr("aria-sort");
		var order = orderStr === "ascending" || orderStr === undefined ? "asc" : "desc";

		var queryData = { "userId": cUserId, "year": year, "month": month, "page_num": 1, "limit": limit, "sortBy": className, "order": order };
		searchObj = JSON.stringify(queryData);
		sortClass = className;
		sortOrder = order;

		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});

	$(document).on("click", ".paginate_button:not(.active)", function () {
		var year = $(".year").val();
		var month = $(".month").val();
		var pagenum = $(this).attr("data-paging");
		if (pagenum != undefined) {

			var queryData = { "userId": cUserId, "year": year, "month": month, "page_num": pagenum, "limit": limit, "sortBy": sortClass, "order": sortOrder };
			searchObj = JSON.stringify(queryData);

			table.clear().draw();
			table.ajax.url(api).load(function (data) {
				$('.total_record').html(data.num);
				$('.pagination').html('');
				CreatePaging(pagenum, data.num, data.data.length);
			});
		}
	});

	//搜尋符合特定條件之個案
	$(".search").on("click", function () {
		var year = $(".year").val();
		var month = $(".month").val();
		var queryData = { "userId": cUserId, "year": year, "month": month, "page_num": 1, "limit": limit, "sortBy": sortClass, "order": sortOrder };
		searchObj = JSON.stringify(queryData);
		table.clear().draw();
		table.ajax.url(api).load(function (data) {
			$('.total_record').html(data.num);
			$('.pagination').html('');
			CreatePaging(1, data.num, data.data.length);
		});
	});
}

function createDataTable(divclass, pages, data, columnObj, lang_info) {

	//var pages = divclass == ".record-list" ? 2: 10;
	var searching = false;
	var lengthChange = false;
	var info = false;
	var selected_lang;

	var table = $(divclass).DataTable({
		data: data,
		responsive: true,
		sort: false,
		paging: true,
		searching: searching,
		info: info,
		lengthChange: lengthChange,
		pageLength: pages,
		autoWidth: false,
		destroy: true,
		columns: columnObj,
		success: function (data) {
		},
		drawCallback: function () {

		},

		language: lang_info
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

function refreshContent() {
	$(".left-nav li").slice(1).remove();
	$(".tab-content").find(".tab-pane:not(.no-user):not(.no-tab)").remove();
	$(".right-nav li").remove();
	$(".add-tab").addClass("hidden");
	$(".no-tab").removeClass("active");
	$(".no-user").addClass("active");
	$('.nav-tabs').scrollingTabs('refresh');
}

function getTodate() { //取得今日日期
	var timeNow = new Date();
	var editYear = timeNow.getFullYear();
	var editMonth = (timeNow.getMonth() + 1 < 10 ? '0' : '') + (timeNow.getMonth() + 1);
	var editDate = (timeNow.getDate() < 10 ? '0' : '') + timeNow.getDate();
	var dateTime = editYear + '-' + editMonth + '-' + editDate;
	return dateTime;
}

function imgFormateDate(onlyDateFormat) {	//影像檔名時間格式
	var timeNow = new Date();
	var editYear = timeNow.getFullYear();
	var editMonth = (timeNow.getMonth() + 1 < 10 ? '0' : '') + (timeNow.getMonth() + 1);
	var editDate = (timeNow.getDate() < 10 ? '0' : '') + timeNow.getDate();
	var hour = String(timeNow.getHours()).padStart(2, '0');
	var min = String(timeNow.getMinutes()).padStart(2, '0');
	var sec = String(timeNow.getSeconds()).padStart(2, '0');
	var dateTime = "";

	if (onlyDateFormat) {
		dateTime = editYear + editMonth + editDate;
	}
	else {
		dateTime = editYear + editMonth + editDate + hour + min + sec;
	}
	return dateTime;

}

function formatDate(assignDate) {
	var dateStr = assignDate + " 00:00:00";
	return dateStr;
}

function getEvalDate() {  //取得今日日期(符合表單內_eval_date欄位格式)
	var timeNow = new Date();
	var editYear = timeNow.getFullYear();
	var editMonth = (timeNow.getMonth() + 1 < 10 ? '0' : '') + (timeNow.getMonth() + 1);
	var editDate = (timeNow.getDate() < 10 ? '0' : '') + timeNow.getDate();
	var dateTime = editYear + '-' + editMonth + '-' + editDate + " 00:00:00";
	return dateTime;
}

/* 擷取google行事曆時間專用 */
function formatTime(assignDateTime, cat) {
	var timeNow = new Date(assignDateTime);
	var hour;
	var min;

	if (cat != undefined) {
		hour = String(timeNow.getHours()).padStart(2, '0');
		min = String(timeNow.getMinutes()).padStart(2, '0');
	} else {
		hour = String(timeNow.getUTCHours()).padStart(2, '0');
		min = String(timeNow.getUTCMinutes()).padStart(2, '0');
	}

	return hour + ":" + min;

}

/* 將日期字串格式轉化為標準化日期(yyyy-MM-dd)格式  */
function formatGMTDate(assignDateTime) {
	var date = new Date(assignDateTime);
	var year = date.getFullYear();
	var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 確保月份是兩位數
	var day = date.getDate().toString().padStart(2, '0'); // 確保日期是兩位數

	return `${year}-${month}-${day}`;
}

function getCookie(sName) {
	var arr = document.cookie.match(new RegExp("(^| )" + sName + "=([^;]*)(;|$)"));
	if (arr != null) {
		return unescape(arr[2]);
	}
	return null;
}

/*新增共同函式庫 20220704*/

//功能名稱為 getEditFormValue 之進化版調整
function getItemValue(classNames, itemArr) {
	var newArray = [];
	var obj, ans;

	var classes = classNames.split(",");

	classes.forEach(function (className) {
		className = className.trim();

		for (var i = 0; i <= itemArr.length; i++) {
			var target = $("." + className + "[data-item='" + itemArr[i] + "']");

			if (target && target.length > 0) {
				if (target.is("input[type='checkbox']")) {
					if (target.prop('checked')) {
						obj = { "itemId": itemArr[i], "ans": target.next("span").html(), "op": "e" };
					}
					else {
						obj = { "itemId": itemArr[i], "ans": "", "op": "r" };
					}
				}
				else if (target.is("div")) {
					if (target.hasClass("selected")) {
						ans = target.html();
						obj = { "itemId": itemArr[i], "ans": ans, "op": "e" };
					} else {
						obj = { "itemId": itemArr[i], "ans": "", "op": "r" };
					}
				}
				else {
					ans = target.val();

					if (ans != "") {
						//console.log("進入item為:" + itemArr[i]);
						ans = ans.replace(/\n/g, '\\n').replace(/'/g, "&apos;").replace(/"/g, "&quot;");
						obj = { "itemId": itemArr[i], "ans": ans, "op": "e" };
					}
					else {
						obj = { "itemId": itemArr[i], "ans": "", "op": "r" };
					}
				}

				newArray.push(obj);
			}
		}
	});
	return newArray;
}


//取得編輯表單欄位值
function getEditFormValue(className, start, end) {
	var newArray = [];
	var obj, ans;
	for (var i = start; i <= end; i++) {
		var target = $("." + className + "[data-item='" + i + "']");

		if (target.length > 0) {
			if (target.is("input[type='checkbox']")) {
				if (target.prop('checked')) {
					obj = { "itemId": i, "ans": target.next("span").html(), "op": "e" };
				}
				else {
					obj = { "itemId": i, "ans": "", "op": "r" };
				}
			}
			else {
				ans = target.val();

				if (ans != "") {
					ans = ans.replace(/\n/g, '\\n').replace(/'/g, "&apos;").replace(/"/g, "&quot;");
					obj = { "itemId": i, "ans": ans, "op": "e" };
				}
				else {
					obj = { "itemId": i, "ans": "", "op": "r" };
				}
			}

			newArray.push(obj);
		}
	}
	return newArray;
}

//設定表單欄位值
function setFormValue(className, obj) {
	var inputLength = obj.length;
	$("." + className).each(function () {
		for (var i = 0; i < inputLength; i++) {
			if ($(this).data('item') == obj[i].itemId) {
				if ($(this).is("select")) {
					if ($("." + className + " option[value='" + obj[i].ans + "']").length == 0) {
						var target = $(this).find("optgroup[label='其他部位'] > option:eq(0)").val();
						$(this).val(target).trigger('change');
						$(this).closest("tr").next("tr").find("input").val(obj[i].ans).trigger("keyup");
					}
					else if ($(this).data('item') == 9) {
						$(this).val(obj[i].ans).trigger('change');
					}
					else {
						$(this).val(obj[i].ans);
					}
				}
				else if ($(this).is("input[type='checkbox']") && obj[i].ans != "") {
					$(this).prop('checked', true).trigger('change');
				}
				else if ($(this).is("div")) {
					$(this).toggleClass("selected");
				}
				else {
					if ($(this).data('item') == 5) {
						$(this).val(obj[i].ans).trigger('change');
					}
					else if ($(this).parent().hasClass("single-option")) {
						$(".single-option").find(".option[data-id='" + obj[i].ans + "']").toggleClass("selected");
					}
					else {
						obj[i].ans = obj[i].ans.replace(/\\n/g, '\n').replace(/&apos;/g, "'").replace(/&quot;/g, '"');
						$(this).val(obj[i].ans);
					}
				}
			}
		}
	});
}

//取得新增傷口評估表單欄位值(20200219更新)
function createEvalFormValue(className, tabNum, start, end) {
	var newArray = [];
	var obj;
	for (var i = start; i <= end; i++) {
		var target = $("#tabInfo" + tabNum).find("." + className + "[data-item='" + i + "']");
		if (target.length > 0) {
			if (target.is("input[type='checkbox']")) {
				if (target.prop('checked') == true) {
					obj = { "itemId": i, "ans": target.next("span").html(), "op": "e" };
					newArray.push(obj);
				}
			}
			else {
				if (target.val() != "") {
					obj = { "itemId": i, "ans": target.val(), "op": "e" };
					newArray.push(obj);
				}
			}
		}
	}
	return newArray;
}

//設定欲取值之對應data-item
function getItemNumArray(tableName, classNames) {
	var itemArr = [];
	var classes = classNames.split(",");

	classes.forEach(function (className) {
		className = className.trim();

		$("." + tableName).find("." + className).each(function () {
			itemArr.push($(this).attr("data-item"));
			itemArr.sort(function (a, b) {
				return a - b;
			});
		});
	});
	return itemArr;
}

//取得Eval表單有值或勾選的data-item(20200219更新)
function getEvalItemArray(className, tabNum, start, end) {
	var checkArray = [357, 358, 363, 364, 494, 495, 496, 497]; //針對有其他選項的item
	var newArray = [];
	for (var i = start; i <= end; i++) {
		var target = $("#tabInfo" + tabNum).find("." + className + "[data-item='" + i + "']");
		if (target.length > 0) {
			if (checkArray.indexOf(i) != -1) {
				if (target.prop('checked') == true && target.parent().find("input[type='text']").val() != "") {
					newArray.push(i);
					newArray.push(i + 1);
				}
			}
			else {
				if (target.is("input[type='checkbox']")) {
					if (target.prop('checked') == true) {
						newArray.push(i);
					}
				}
				else {
					if (target.val() != "") {
						newArray.push(i);
					}
				}
			}
		}
	}
	return newArray;
}

//查詢對應表單號之item內容
function getItemAns(obj, itemNo) {
	var ans = "";
	for (var i = 0; i < obj.result.length; i++) {
		if (obj.result[i].itemId == itemNo) {
			ans = obj.result[i].ans;
			break;
		}
	}
	return ans;
}

//查詢對應表單號之item數值(尺寸、組織數據)
function getVal(obj, itemNo) {
	var ans = 0;
	for (var i = 0; i < obj.result.length; i++) {
		if (obj.result[i].itemId == itemNo) {
			ans = obj.result[i].ans;
			break;
		}
	}
	return ans;
}

//啟動datePicker日期選擇器套件
function startDatePicker(className) {
	var date = new Date();
	date.setDate(date.getDate() + 1);
	var param = className == '.copy-date' ? date : "";

	$(className).datepicker('destroy');
	$(className).datepicker({
		language: "zh-TW",
		format: "yyyy-mm-dd",
		autoclose: true,
		todayHighlight: true,
		startDate: param
	}).on('changeDate', function (e) {
		if ($(this).attr("class").indexOf("birth") != -1) {
			var today = new Date();
			var selectedDay = new Date(e.format());
			var age = today.getFullYear() - selectedDay.getFullYear();
			var monthDiff = today.getMonth() - selectedDay.getMonth();
			var dayDiff = today.getDate() - selectedDay.getDate();
			if (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) {
				age--;
			}
			$(".calAge").val(age);
		}
	});

}

//設置inline datePicker日期選擇器套件
function setInlineDatePicker(className, appoDates){
	var dateObjects = appoDates.map(dateStr => new Date(dateStr + "T00:00:00"));
	
	$(className).datepicker('destroy');
	$(className).datepicker({
        language: "zh-TW",       
        todayHighlight: true,
        multidate: true,
	    beforeShowDay: function (date) {
            // Check if the current date is in the appoDates array
            var isDateActive = dateObjects.some(d =>
                d.getFullYear() === date.getFullYear() &&
                d.getMonth() === date.getMonth() &&
                d.getDate() === date.getDate()
            );
            
            if(isDateActive) return { classes: 'active' };
        }
    })
}

function getMaxTimeStamp() {
	return Math.floor(Date.now());
}

function getMinTimeStamp() {
	return Math.floor(Date.now()) - 2592000000;
}



function setMaxTimeStamp(dateArr) {
	if (dateArr.length <= 4) {
		var date = new Date(dateArr[dateArr.length - 1]);
		return date.toUTCString();
	}
	else {

	}
}

//客製化確認彈跳視窗
function confirmCheck(title, subText, type, confirmButtonClass, confirmBtnText, cancelBtnText, callback) {
	swal({
		title: title,
		text: subText,
		type: type,
		showCancelButton: true,
		confirmButtonClass: confirmButtonClass,
		confirmButtonText: confirmBtnText,
		cancelButtonText: cancelBtnText,
		closeOnConfirm: false
	}, function (confirmed) {
		return callback(confirmed);
	});
}

//客製化成功轉址提示
function successToDirect(title, text, type, timer, directUrl) {
	swal({
		title: title,
		text: text,
		type: type,
		timer: timer,
		showConfirmButton: false
	}, function () {
		window.location.href = directUrl;
	});
}

//顯示提醒視窗(不顯示按鈕)
function showHintSwal(subText) {
	swal({
		title: "",
		text: subText,
		showConfirmButton: false
	})
}

function showTimerHintSwal(subText, timer) {
	swal({
		title: "",
		text: subText,
		timer: timer,
		showConfirmButton: false
	})

}

function customSwal(title, text, icon, width) {
	swal({
		title: title,
		text: text,
		type: icon,
		className: "custom-width",
		onOpen: function () {
			// 当 SweetAlert 弹窗打开时执行以下代码
			// 使用 JavaScript 来动态调整对话框的位置
			var modal = this.modal;
			var windowWidth = window.innerWidth;
			var modalWidth = modal.offsetWidth;

			// 计算水平居中位置
			var leftPosition = (windowWidth - modalWidth) / 2;

			// 设置 SweetAlert 对话框的左偏移量
			modal.style.left = leftPosition + "px";

			// 垂直居中位置可以根据需要进行类似的计算和调整
			// 这里只示范了水平居中的示例
		},
	});
}

//顯示分頁數
function CreatePaging(gCurPage, total_record, length) {
	var total_page = 1;
	var display_count = parseInt($('.displaynum').val());

	gCurPage = parseInt(gCurPage);

	if (length == 0)
		$('.startRecordNum').text('0');
	else
		$('.startRecordNum').text(((gCurPage - 1) * display_count) + 1);
	$('.endRecordNum').text(((gCurPage - 1) * display_count) + length);
	if (display_count == "all")
		total_page = 2;
	else
		total_page = Math.ceil(total_record / display_count) + 1;

	var li, a;
	var current_page;
	var pagination = document.getElementsByClassName("pagination")[0];

	if (gCurPage < 0)
		gCurPage = 0;

	if (gCurPage >= total_page - 1)
		gCurPage = total_page - 1;

	li = document.createElement("li");                     // Pre
	li.setAttribute("class", "paginate_button previous");
	li.setAttribute("aria-controls", "DataTables_Table_0");
	li.setAttribute("id", "DataTables_Table_0_previous");
	li.setAttribute("data-paging", (gCurPage - 1));
	a = document.createElement("a");
	a.setAttribute("href", "#");
	a.innerHTML = "<";
	li.appendChild(a);
	pagination.appendChild(li);

	if (gCurPage <= 1) {
		$('#DataTables_Table_0_previous').addClass('disabled');
		li.removeAttribute("data-paging");
	}

	if (total_page <= 7) {
		for (var i = 1; i < total_page; i++) {
			li = document.createElement("li");                     // page
			li.setAttribute("class", "paginate_button");
			li.setAttribute("aria-controls", "DataTables_Table_0");
			li.setAttribute("id", "page_" + i);
			li.setAttribute("data-paging", i);
			a = document.createElement("a");
			a.setAttribute("href", "#");
			a.innerHTML = i;
			li.appendChild(a);
			pagination.appendChild(li);
		}

	}
	else {
		li = document.createElement("li");                     // page 1
		li.setAttribute("class", "paginate_button");
		li.setAttribute("aria-controls", "DataTables_Table_0");
		li.setAttribute("id", "page_1");
		li.setAttribute("data-paging", 1);
		a = document.createElement("a");
		a.setAttribute("href", "#");
		a.innerHTML = "1";
		li.appendChild(a);
		pagination.appendChild(li);

		if (gCurPage <= 4) {
			for (var i = 2; i <= 5; i++) {
				li = document.createElement("li");                     // page 2~5
				li.setAttribute("class", "paginate_button");
				li.setAttribute("aria-controls", "DataTables_Table_0");
				li.setAttribute("id", "page_" + i);
				li.setAttribute("data-paging", i);
				a = document.createElement("a");
				a.setAttribute("href", "#");
				a.innerHTML = i;
				li.appendChild(a);
				pagination.appendChild(li);
			}

			li = document.createElement("li");                     // page ...
			li.setAttribute("class", "paginate_button disabled");
			li.setAttribute("aria-controls", "DataTables_Table_0");
			li.setAttribute("id", "page_dot");
			a = document.createElement("a");
			a.setAttribute("href", "#");
			a.innerHTML = "...";
			li.appendChild(a);
			pagination.appendChild(li);
		}

		else if (gCurPage >= total_page - 3) {
			li = document.createElement("li");                     // page ...
			li.setAttribute("class", "paginate_button disabled");
			li.setAttribute("aria-controls", "DataTables_Table_0");
			li.setAttribute("id", "page_dot");
			a = document.createElement("a");
			a.setAttribute("href", "#");
			a.innerHTML = "...";
			li.appendChild(a);
			pagination.appendChild(li);

			for (var i = total_page - 5; i < total_page - 1; i++) {
				li = document.createElement("li");                     // page total_page-5 ~ total-1
				li.setAttribute("class", "paginate_button");
				li.setAttribute("aria-controls", "DataTables_Table_0");
				li.setAttribute("id", "page_" + i);
				li.setAttribute("data-paging", i);
				a = document.createElement("a");
				a.setAttribute("href", "#");
				a.innerHTML = i;
				li.appendChild(a);
				pagination.appendChild(li);
			}
		}

		else {
			li = document.createElement("li");                     // page ...
			li.setAttribute("class", "paginate_button disabled");
			li.setAttribute("aria-controls", "DataTables_Table_0");
			li.setAttribute("id", "page_dot");
			a = document.createElement("a");
			a.setAttribute("href", "#");
			a.innerHTML = "...";
			li.appendChild(a);
			pagination.appendChild(li);

			for (var i = gCurPage - 1; i <= gCurPage + 1; i++) {
				li = document.createElement("li");                     // page gCurPage-1 ~ gCurPage+1
				li.setAttribute("class", "paginate_button");
				li.setAttribute("aria-controls", "DataTables_Table_0");
				li.setAttribute("id", "page_" + i);
				li.setAttribute("data-paging", i);
				a = document.createElement("a");
				a.setAttribute("href", "#");
				a.innerHTML = i;
				li.appendChild(a);
				pagination.appendChild(li);
			}

			li = document.createElement("li");                     // page ...
			li.setAttribute("class", "paginate_button disabled");
			li.setAttribute("aria-controls", "DataTables_Table_0");
			li.setAttribute("id", "page_dot");
			a = document.createElement("a");
			a.setAttribute("href", "#");
			a.innerHTML = "...";
			li.appendChild(a);
			pagination.appendChild(li);
		}

		li = document.createElement("li");                     // page total
		li.setAttribute("class", "paginate_button");
		li.setAttribute("aria-controls", "DataTables_Table_0");
		li.setAttribute("id", "page_" + (total_page - 1));
		li.setAttribute("data-paging", (total_page - 1));
		a = document.createElement("a");
		a.setAttribute("href", "#");
		a.innerHTML = total_page - 1;
		li.appendChild(a);
		pagination.appendChild(li);

	}

	$('#page_' + gCurPage).addClass('active').removeAttr("data-paging");

	li = document.createElement("li");                     // next
	li.setAttribute("class", "paginate_button next");
	li.setAttribute("aria-controls", "DataTables_Table_0");
	li.setAttribute("id", "DataTables_Table_0_next");
	li.setAttribute("data-paging", (gCurPage + 1));
	a = document.createElement("a");
	a.setAttribute("href", "#");
	a.innerHTML = ">";
	li.appendChild(a);
	pagination.appendChild(li);

	if (gCurPage == total_page - 1) {
		$('#DataTables_Table_0_next').addClass('disabled');
		li.removeAttribute("data-paging");
	}
}

//選項多選adapter
function multiSelectAdapter(selectName, inputName, placeholder) {

	$(selectName).multiselect({
		placeholder: placeholder,
		onOptionClick: function (element, option) {
			var values = $(inputName).val();
			var maxSelect = 3;
			var thisOpt = $(option);
			if ($(element).val() != null) {
				if ($(element).val().length > maxSelect) {
					if (thisOpt.is(':checked')) {
						var thisVals = $(element).val();
						thisVals.splice(
							thisVals.indexOf(thisOpt.val()), 1
						);

						$(element).val(thisVals);
						thisOpt.prop('checked', false).closest('li').toggleClass('selected');
					}
				}
				else if ($(element).val().length == maxSelect) {
					$(element).next('.ms-options-wrap').find('li:not(.selected)').addClass('disabled')
						.find('input[type="checkbox"]').attr('disabled', 'disabled');
				}
				else {
					$(element).next('.ms-options-wrap').find('li.disabled').removeClass('disabled')
						.find('input[type="checkbox"]').removeAttr('disabled');
				}
			}

			if (thisOpt.prop('checked')) {
				values += thisOpt.val() + ',';
			}
			else {
				values = values.replace(thisOpt.val() + ',', '');
			}

			$(inputName).val(values);
		}
	});
}

//設置多選項adpater被選中的項目
function setSelectedOption(target, value) {
	if (value.length > 0) {
		var executors = value.substring(0, value.length - 1).split(",");
		for (var i = 0; i < executors.length; i++) {
			$(target).find("option[value='" + executors[i] + "']").attr("selected", "selected");
		}
	}
}

//時間選擇器
function timeAdapter(target, beginClassName, endClassName) {
	$(target).timepicker({
		timeFormat: 'HH:mm',
		interval: 5,
		minTime: '5',
		maxTime: '22',
		startTime: '08:00',
		dynamic: false,
		dropdown: true,
		scrollbar: true,
		zindex: 9999999,
		change: function (time) {
			var element = $(this), text;
			var timepicker = element.timepicker();
			var timeParse = Date.parse(time);
			var realTime = new Date(timeParse);
			var timeSetter = getGMTTime(realTime);
			if ($(this).hasClass(beginClassName)) {
				$(this).closest("tr").find("input." + endClassName).val(timeSetter);
			}
			else {
				if ($(this).val() < $("." + beginClassName).val()) {
					$(this).closest("tr").find("input." + beginClassName).val(timeSetter);
				}
			}
		}
	});
}

//取得GMT時間
function getGMTTime(date) {
	return [
		padTo2Digits(date.getHours()),
		padTo2Digits(date.getMinutes())
	].join(':');
}

//取得當天日期
function getNowDate(date) {
	return [
		date.getFullYear(),
		padTo2Digits(date.getMonth() + 1),
		padTo2Digits(date.getDate())
	].join('-');
}

//轉化時間為2碼
function padTo2Digits(num) {
	return num.toString().padStart(2, '0');
}

//選擇器(select2)
function selectAdapter(targetName, minInputLength, placeholder, apiUrl, lang) {
	$(targetName).select2({
		language: lang,
		width: 'element',
		maximumInputLength: 10,
		minimumInputLength: minInputLength,
		placeholder: placeholder,
		allowClear: true,
		ajax: {
			url: apiUrl,
			type: 'POST',
			data: function (params) {
				// 將查詢參數包裝成 JSON 格式
				return JSON.stringify({
					code: params.term
				});
			},
			processResults: function (data, params) {
				if (data.message) {
					return {
						results: [{ id: 'no-results', text: data.message }],
						pagination: {
							more: false
						}
					}
				} else {
					return {
						results: data.paymentItems,
						pagination: {
							more: false
						}
					}

				}
			}
		}
	}).on("select2:unselecting", function (e) {
		$(this).find("option").remove();
		//健保-處置代碼額外處理事項
		if (targetName == ".paymentItemCode") {
			$(this).closest("tr").find(".amount, .points").val("");
			$(".copaymentCode").trigger('change');
		}
	});
}

//驗證身分證格式
/*function checkPid( pid ) {
	if ( pid.length !== 10 ) return '身份證號長度不正確';
	
	pid = pid.toUpperCase();  // 即使輸入小寫字元，也將它轉成大寫字元
	//if ( !/(^[A-Za-z][12][\d]{8}$)|([A-Za-z][A-Da-d][\d]{8}$/.test(pid)) return '身分證字號含不合法字元，請檢查';   // PREG 驗證
	if (pid.match(/^[A-Z][0-9]{9}$/)) {     // 此為身分證字號
						 
		var codes = '0123456789ABCDEFGHJKLMNPQRSTUVXYWZIO';        // 注意英文字母順序
		var pidCodes = {};
		$(codes.split('')).each( function( index, elem) {
			pidCodes[elem] = index;                                  // 建立字母vs數字對照表
		});
		// 依據前9碼權重總合與最後檢核碼比較
		var sum = 0;
		for ( var i=8; i>0; i--) {
		  sum += parseInt(pidCodes[pid.charAt(i)]) * (9-i);
		  //console.log( sum + '- ' + pid.charAt(i) + '= ' + parseInt(pidCodes[pid.charAt(i)]) * (9-i));
		}
		var checkDigit = 10 - (sum + parseInt(pidCodes[pid.charAt(0)])%10*9 + parseInt(parseInt(pidCodes[pid.charAt(0)]/10)))%10;
		return checkDigit === parseInt(pid.slice(-1)) ? '' : '身分證號檢核不正確';
	}
}*/

//驗證身分證格式(正確版)
function checkPid(id) {
	var tab = "ABCDEFGHJKLMNPQRSTUVXYWZIO"
	var A1 = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3);
	var A2 = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5);
	var Mx = new Array(9, 8, 7, 6, 5, 4, 3, 2, 1, 1);

	if (id.length != 10) return '身份證號長度不正確';

	var i = tab.indexOf(id.charAt(0));
	if (i == -1) return '身份證號第一碼不是英文字母';

	var gender = parseInt(id.charAt(1));
	if (gender !== 1 && gender !== 2) return '身份證號第二碼須為1或2';

	for (var j = 1; j < 10; j++) {
		var charCode = id.charCodeAt(j);
		if (charCode < 48 || charCode > 57) { // ASCII code for 0-9 is 48-57
			return '身份證號格式須為第一碼英文字+9碼數字，且不能夾雜其他字符';
		}
	}

	var sum = A1[i] + A2[i] * 9;
	for (i = 1; i < 10; i++) {
		var v = parseInt(id.charAt(i));
		if (isNaN(v)) return '身份證號格式須為第一碼英文字+9碼數字';
		sum = sum + v * Mx[i];
		//console.log("總計:" + sum);
	}

	if (sum % 10 != 0) {
		//console.log("身分證字號錯誤");
		return '身分證號檢核不正確';
	}
	else {
		//console.log("身分證字號正確");
		return '';
	}
	//if ( sum % 10 != 0 ) return false;
	//return true;
}

//驗證是否有中文字符
function checkChineseTxt(str) {
	var chineseCharPattern = /[\u4e00-\u9fff]/;
	return chineseCharPattern.test(str);
}

// 共用的表單驗證函數
function validateForm(formId, className, elements) {
	var missingFields = [];

	// 前置處理：去除空白值
	$("#" + formId).find(elements).each(function () {
		var value = $(this).val();
		$(this).val($.trim(value));
	});

	// 遍歷帶有star class的td元素
	$("#" + formId).find(className).each(function () {
		// 找到相鄰td內的input及select元素
		var input = $(this).next().find(elements);

		// 如果input是disabled狀態，跳過
		if (input.prop('disabled')) {
			return true;
		}

		// 檢查input是否為text、hidden或password類型，且值是否為空
		if (input.is("input[type='text'], input[type='hidden'], input[type='password']") && !input.val()) {
			var fieldLabel = $(this).text().replace("：", ""); // 獲取字段名稱
			missingFields.push(fieldLabel); // 將未填寫的字段加入陣列
		}

		// 檢查radio類型是否有選值
		if (input.is("input[type='radio']") && !$("input[name='" + input.attr('name') + "']:checked").val()) {
			var fieldLabel = $(this).text().replace("：", ""); // 獲取字段名稱
			missingFields.push(fieldLabel); // 將未填寫的字段加入陣列
		}

		// 檢查select是否為空
		if (input.is("select") && input.val() === "") {
			var fieldLabel = $(this).text().replace("：", ""); // 獲取字段名稱
			missingFields.push(fieldLabel); // 將未填寫的字段加入陣列
		}
	});

	// 如果有未填寫的字段，顯示提示
	if (missingFields.length > 0) {
		swal("新增/儲存失敗", "您尚未填寫以下必填欄位：\n" + missingFields.join("、"), "error");
		return false; // 驗證失敗
	} else {
		return true; // 驗證通過
	}
}

//產生UUID
function generateUUID() {
	var d = new Date().getTime();
	if (typeof performance !== 'undefined' && typeof performance.now === 'function') {
		d += performance.now(); // 使用性能计时器提高唯一性
	}
	return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
		var r = (d + Math.random() * 16) % 16 | 0;
		d = Math.floor(d / 16);
		return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
	});
}

//個案細項資訊展開
function format(d) {
	var obj = d.data;
	var content = "";

	if (obj.length > 0) {
		/*for(var i=0; i<obj.length; i++){
			content += '<tr class="sub">'+
					   '<td>來源:</td>'+
					   '<td>' + obj[i].source + '</td>'+
					   '<td>部位:</td>'+
							   '<td>' + obj[i].bodyPart + '</td>'+
					   '<td>敷藥:</td>'+
					   '<td>' + obj[i].method + '</td>'+
					   '<td>頻率:</td>'+
					   '<td>' + obj[i].frequency + '</td>'+
					   '<td>最新F/U:</td>'+
					   '<td>' + obj[i].evalDate + '</td>'+
					   '<td>處置者:</td>'+
					   '<td>' + obj[i].nurse + '</td>'+
					   '<td>經理人:</td>'+
					   '<td>' + obj[i].manager + '</td>'+
					   '</tr>';
		}*/
	}
	else {
		content += '<tr class="sub"><td style="text-align:center">無細項內容</td></tr>';
	}

	return '<table class="detail" cellpadding="5" cellspacing="0" border="0">' + content + '</table>';

}

//啟用可編輯文字
function initEditable(clzName) {
	$(clzName).each(function () {
		var editableOption = $(this);
		var originalText = editableOption.text();

		editableOption.on('click', function () {
			editableOption.removeClass("selected");
			selectAllText(this);
		});

		editableOption.on('focusout', function () {
			if ($.trim(editableOption.text()) === '') {
				editableOption.text(originalText);
			} else {
				if ($.trim(editableOption.text()) !== originalText) {
					editableOption.toggleClass("selected");
				}
			}
		});
	});

	function selectAllText(element) {
		var range = document.createRange();
		var selection = window.getSelection();
		range.selectNodeContents(element);
		selection.removeAllRanges();
		selection.addRange(range);
	}
}

//計算年紀歲數
function countAge(clzName, birthDate, isTaiwanese = false) {
    var today = new Date();

    // 如果是民國年，將其轉換為西元年
    var selectedDay;
    if (isTaiwanese) {
        // 如果是民國年，假設傳入格式為 YYYY/MM/DD 的字符串
        var parts = birthDate.split('-');
        var taiwaneseYear = parseInt(parts[0]);
        // 將民國年轉換為西元年
        var gregorianYear = taiwaneseYear + 1911; // 1911 是民國的元年，所以加上1911年
        selectedDay = new Date(gregorianYear, parseInt(parts[1]) - 1, parseInt(parts[2])); // 注意月是從 0 開始
    } else {
        selectedDay = new Date(birthDate);
    }
    
    var age = today.getFullYear() - selectedDay.getFullYear();
    var monthDiff = today.getMonth() - selectedDay.getMonth();
    var dayDiff = today.getDate() - selectedDay.getDate();

    if (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) {
        age--;
    }

    $(clzName).val(age);
}