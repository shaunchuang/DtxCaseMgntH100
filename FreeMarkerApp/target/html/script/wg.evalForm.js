/**
 * @Author: Jian-Hong
 * @Since: 2016/09/10
 */

if(typeof(wg) === "undefined"){var wg = function(){}};
wg.evalForm = {};
$.extend(wg.evalForm, {
	getToday: function(){
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!

		var yyyy = today.getFullYear();
		if(dd<10){
		    dd='0'+dd;
		} 
		if(mm<10){
		    mm='0'+mm;
		} 
		var today = yyyy + '-' + mm + '-' + dd;
		return today;
	},
	score: function(formName, evalFormUserId){
		var result = false;
		$.ajax({
			url: BASE_URL + "/employee/evalFormUser/score",
			type: "POST",
			data: {formName: formName, evalFormUserId: evalFormUserId},
			async: false,
			dataType: "json",
			success: function (data) {
				if(data.success){
					result = data.score;
				}
			}
		});
		return result;
	},
	saveEvalForm: function(domId, ownerId, evalDate, app, maskAns, evaluatorFields, isShowMsg, keyno){
		//app->可用來限縮撈取EvalFormUser的Scope
		//maskAns->型態為EvalItemId Array。當涉及到問卷中的機密資料，像是身分證字號、姓名...等，會用****代替，他會影響是否更新EvalItem的Answer值
		//evaluatorFields->[{evaluatorId:xx,qIds:[...],itemIds:[...]},{evaluatorId:xx,qIds:[...],items:[...]}...]，一般表單的資料是顯示最新一筆的Ans，但遇到這些Fields時，則顯示evaluatorId的最新一筆
		var evalFormUserId = $("#"+domId).find(".evalFormUserId").val();
		var data = evalFormUserId?wg.utils.evalFormUser.getEvalFormSubmitData(domId, ownerId):wg.utils.evalForm.getEvalFormSubmitData(domId, ownerId);
		var objId = null;
		if(!evalDate){
			data.append("evalDate", wg.evalForm.getToday());
		}else{
			data.append("evalDate", evalDate);
		}
		data.append("app", app);
		data.append("maskAns", maskAns);
		data.append("evaluatorFields", evaluatorFields);
		data.append("keyno", keyno);
		
		// delete empty value from FormData
		var data2 = new FormData();
		for (var pair of data.entries()) {
			if(pair[1]==null || pair[1]=='undefined'){
				
			}else{
				data2.append(pair[0], pair[1]);
			}
		}
		
		$.ajax({
			url: BASE_URL + "/employee/evalFormUser/create/save",
			type: "POST",
			data: data2,
			contentType: false,
          	processData: false,
			async: false,
			dataType: "json",
			success: function (data) {
				if(data.msg){
					objId = data.objId;
					
					if(isShowMsg==="undefined" || isShowMsg==null || isShowMsg) alert(data.msg);
				}
			}
		});
		return objId;
	},
	isExistEvalFormUser: function (formName, uid, app){
		var result = false;
		$.ajax({
			url: BASE_URL + "/employee/evalFormUser/isExistEvalFormUser",
			type: "POST",
			data: {formName: formName, uid: uid, app: app},
			async: false,
			dataType: "json",
			success: function (data) {
				if(data.success){
					result = data.found;
				}
			}
		});
		return result;
	},
	fillInEvalForm: function (domId, queryObj){
		$.ajax({
			url: BASE_URL + "/employee/evalFormUser/answerEvalItem",
			type: "POST",
			data: {queryStr: JSON.stringify(queryObj)},
			async: false,
			dataType: "json",
			success: function (data){
				if(data.success){
					var idIndex = 0;
					for(var i=0; i<queryObj.questions.length; i++){
						var question = queryObj.questions[i];
						for(var j=0; j<question.items.length; j++){
							var item = question.items[j];
							var id = data.ids[idIndex++];
							if(id>0){
								if(item.type=="4"){
									//多行文字框
									var evalInput = $("#"+domId).find("textarea[data-item='"+id+"']");
									$(evalInput).val(item.ans);
								}else{
									var evalInput = $("#"+domId).find("input[data-item='"+id+"']");
									if(item.type=="1" || item.type=="2"){
										//單選、多選
										$(evalInput).prop('checked', true);
									}else{
										//單行文字框
										$(evalInput).val(item.ans);
									}
								}
							}
						}
					}
				}
			}
		});
	},
	multipleAutocomplete: function (domId, queryObj){
		var listPhraseUrl = BASE_URL+"/employee/PhraseMng/listPhrase";
		$.ajax({
			url: BASE_URL + "/employee/evalFormUser/answerEvalItem",
			type: "POST",
			data: {queryStr: JSON.stringify(queryObj)},
			async: false,
			dataType: "json",
			success: function (data){
				if(data.success){
					var idIndex = 0;
					for(var i=0; i<queryObj.questions.length; i++){
						var question = queryObj.questions[i];
						for(var j=0; j<question.items.length; j++){
							var item = question.items[j];
							var id = data.ids[idIndex++];
							if(id>0){
								if(item.type=="4"){
									//多行文字框
									mlog.autocomplete.initMultipleSelect($("#"+domId).find("textarea[data-item="+id+"]"), listPhraseUrl, 0, function (event, ui) {
										var resultData = [ui.item.label, ui.item.value];
										var currentValue = $(this).val();
										if(currentValue){
											$(this).val(currentValue + "、" + resultData[0]);
											var strLength = $(this).val().length * 2;
											$(this)[0].setSelectionRange(strLength, strLength);
										}else{
											$(this).val(resultData[0]);
										}
										//$("#"+domId).find("textarea[data-item="+id+"]").val(resultData[0]);
										mlog.autocomplete.isSelectTrigger = true;
										return false;
									}, true, item.phrase);
								}else{
									if(item.type=="1" || item.type=="2"){
										//單選、多選
									}else{
										//單行文字框
										mlog.autocomplete.initMultipleSelect($("#"+domId).find("input[data-item="+id+"]"), listPhraseUrl, 0, function (event, ui) {
											var resultData = [ui.item.label, ui.item.value];
											var currentValue = $(this).val();
											if(currentValue){
												var strLength = $(this).val().length * 2;
												$(this)[0].setSelectionRange(strLength, strLength);
												$(this).val(currentValue + "、" + resultData[0]);
											}else{
												$(this).val(resultData[0]);
											}
											mlog.autocomplete.isSelectTrigger = true;
											return false;
										}, true, item.phrase);
									}
								}
							}
						}
					}
				}
			}
		});
	},
	autocomplete: function (domId, queryObj){
		var listPhraseUrl = BASE_URL+"/employee/PhraseMng/listPhrase";
		$.ajax({
			url: BASE_URL + "/employee/evalFormUser/answerEvalItem",
			type: "POST",
			data: {queryStr: JSON.stringify(queryObj)},
			async: false,
			dataType: "json",
			success: function (data){
				if(data.success){
					var idIndex = 0;
					for(var i=0; i<queryObj.questions.length; i++){
						var question = queryObj.questions[i];
						for(var j=0; j<question.items.length; j++){
							var item = question.items[j];
							var id = data.ids[idIndex++];
							if(id>0){
								if(item.type=="4"){
									//多行文字框
									mlog.autocomplete.init($("#"+domId).find("textarea[data-item="+id+"]"), listPhraseUrl, 0, function (event, ui) {
										var resultData = [ui.item.label, ui.item.value];
										var currentValue = $(this).val();
										if(currentValue){
											$(this).val(resultData[0]);
										}else{
											$(this).val(resultData[0]);
										}
										//$("#"+domId).find("textarea[data-item="+id+"]").val(resultData[0]);
										mlog.autocomplete.isSelectTrigger = true;
										return false;
									}, true, item.phrase);
								}else{
									if(item.type=="1" || item.type=="2"){
										//單選、多選
									}else{
										//單行文字框
										mlog.autocomplete.init($("#"+domId).find("input[data-item="+id+"]"), listPhraseUrl, 0, function (event, ui) {
											var resultData = [ui.item.label, ui.item.value];
											var currentValue = $(this).val();
											if(currentValue){
												$(this).val(resultData[0]);
											}else{
												$(this).val(resultData[0]);
											}
											mlog.autocomplete.isSelectTrigger = true;
											return false;
										}, true, item.phrase);
									}
								}
							}
						}
					}
				}
			}
		});
	},
	simpleAutocompleteByURL: function(dom, url, postData){
		//單行文字框
		mlog.autocomplete.init($(dom), url, 0, function (event, ui) {
			var resultData = [ui.item.label, ui.item.value];
			var currentValue = $(this).val();
			if(currentValue){
				$(this).val(resultData[0]);
			}else{
				$(this).val(resultData[0]);
			}
			mlog.autocomplete.isSelectTrigger = true;
			return false;
		}, true, postData);
	},
	simpleAutocomplete: function(dom, phrase){
		//單行文字框
		var listPhraseUrl = BASE_URL+"/employee/PhraseMng/listPhrase";
		wg.evalForm.simpleAutocompleteByURL(dom, listPhraseUrl, phrase);
	},
	simpleMultipleAutocomplete: function(dom, phrase){
		//單行文字框
		var listPhraseUrl = BASE_URL+"/employee/PhraseMng/listPhrase";
		mlog.autocomplete.initMultipleSelect($(dom), listPhraseUrl, 0, function (event, ui) {
			var resultData = [ui.item.label, ui.item.value];
			var currentValue = $(this).val();
			if(currentValue){
				var strLength = $(this).val().length * 2;
				$(this)[0].setSelectionRange(strLength, strLength);
				$(this).val(currentValue + "、" + resultData[0]);
			}else{
				$(this).val(resultData[0]);
			}
			mlog.autocomplete.isSelectTrigger = true;
			return false;
		}, true, phrase);
	},
	getJson: function(submitData, url){
		var result = {};
		$.ajax({
			url: url,
			type: "POST",
			data: submitData,
			async: false,
			dataType: "json",
			success: function (data) {
				result = data;
			}
		});
		return result;
	},
	deviceMeasureLabel: function (obj){
		$(obj).addClass("label label-info");
		$(obj).css({"font-size":"14px"});
	},
	phraseSupply: function(domId, formName){
		switch(formName){
		case "嬰兒交班單":
			break;
		}
	},
	deleteEvalFormUser: function(idsArray){
		if(!idsArray) return;
		$.ajax({
			url: BASE_URL + "/employee/evalFormUser/delete",
			type: "POST",
			data: {id:idsArray.join(",")},
			async: false,
			dataType: "json"
		});
	}
});

