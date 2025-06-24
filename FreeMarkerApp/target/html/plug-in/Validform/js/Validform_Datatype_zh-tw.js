/*
    Validform datatype extension
	By sean during December 8, 2012 - February 20, 2013
	For more information, please visit http://validform.rjboy.cn
	
	擴展以下類型：
	date：匹配日期
	zh：匹配中文字符
	dword：匹配雙字節字符
	money：匹配貨幣類型
	ipv4：匹配ipv4地址
	ipv6：匹配ipv6地址
	num：匹配數值型
	qq：匹配qq號碼
	unequal：當前值不能等於被檢測的值，如可以用來檢測新密碼不能與舊密碼一樣
	notvalued：當前值不能包含指定值，如密碼不能包含用戶名等的檢測
	min：多選框最少選擇多少項
	max：多選框最多不能超過多少項
	byterange:判斷字符長度，中文算兩個字符
	numrange：判斷數值範圍，如小於100大於10之間的數
	daterange：判斷日期範圍
	idcard：對身份證號碼進行嚴格驗證
*/

(function(){
	if($.Datatype){
		$.extend($.Tipmsg.w,{
			"date":"請填寫日期！",
			"zh":"請填寫中文！",
			"dword":"請填寫雙字節字符！",
			"money":"請填寫貨幣值！",
			"ipv4":"請填寫ip地址！",
			"ipv6":"請填寫IPv6地址！",
			"num":"請填寫數值！",
			"qq":"請填寫QQ號碼！",
			"unequal":"值不能相等！",
			"notvalued":"不能含有特定值！",
			"idcard":"身份證號碼不對！"
		});
		
		$.extend($.Datatype,{
			/*
				reference http://blog.csdn.net/lxcnn/article/details/4362500;
				
				日期格式可以是：20120102 / 2012.01.02 / 2012/01/02 / 2012-01-02
				時間格式可以是：10:01:10 / 02:10
				如 2012-01-02 02:10
				   2012-01-02
			*/
			"date":/^(?:(?:1[6-9]|[2-9][0-9])[0-9]{2}([-/.]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:(?:1[6-9]|[2-9][0-9])(?:0[48]|[2468][048]|[13579][26])|(?:16|[2468][048]|[3579][26])00)([-/.]?)0?2\2(?:29))(\s+([01][0-9]:|2[0-3]:)?[0-5][0-9]:[0-5][0-9])?$/,
			
			//匹配中文字符;
			"zh":/^[\u4e00-\u9fa5]+$/,
			
			//匹配雙字節字符;
			"dword":/^[^\x00-\xff]+$/,
			
			//貨幣類型;
			"money":/^([\u0024\u00A2\u00A3\u00A4\u20AC\u00A5\u20B1\20B9\uFFE5]\s*)(\d+,?)+\.?\d*\s*$/,
			
			//匹配ipv4地址;
			"ipv4":/^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})$/,
			
			/*
				匹配ipv6地址;
				reference http://forums.intermapper.com/viewtopic.php?t=452;
			*/
			"ipv6":/^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$/,
			
			
			//數值型;
			"num":/^(\d+[\s,]*)+\.?\d*$/,
			//QQ號碼;
			"qq":/^[1-9][0-9]{4,}$/,
			
			"dns":/^[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+\.?/,
			
			
			/*
			  參數gets是獲取到的表單元素值，
			  obj為當前表單元素，
			  curform為當前驗證的表單，
			  datatype為內置的一些正則表達式的引用。
			*/
			"unequal":function(gets,obj,curform,datatype){
				/*
					當前值不能與指定表單元素的值一樣，如新密碼不能與舊密碼一樣，密碼不能設置為用戶名等
					註意需要通過綁定with屬性來指定要比較的表單元素，可以是clas，id或者是name屬性值

					eg.  <input type="text" name="name" id="name" class="name" />
					eg1. <input type="text" name="test" datatype="unequal" with="name" />
					eg2. <input type="text" name="test" datatype="unequal" with=".name" />
					eg3. <input type="text" name="test" datatype="unequal" with="#name" />
					
					也可以用來驗證不能與with指定的值相等
					當上面根據class，id和name都查找不到對象時，會直接跟with的值比較
					eg4. <input type="text" name="test" datatype="num unequal" with="100" />
					該文本框的值不能等於100
				*/
				var withele=$.trim(obj.attr("with"));
				var val=curform.find(withele+",[name='"+withele+"']").val() || withele;

				if(gets==$.trim(val)){
					return false;
				}
			},
			
			
			"notvalued":function(gets,obj,curform,datatype){
				/*
					當前文本框的值不能含有指定文本框的值，如註冊時設置的密碼裏不能包含用戶名
					註意需要給表單元素綁定with屬性來指定要比較的表單元素，可以是clas，id或者是name屬性值
					<input type="text" name="username" id="name" class="name" />
					eg. <input type="password" name="test" datatype="notvalued" with=".name" />
					
					也可以用來驗證不能包含with指定的值
					當上面根據class，id和name都查找不到對象時，會直接跟with的值比較
					eg2. <input type="password" name="test" datatype="notvalued" with="validform" />
					要求不能含有"validform"字符
				*/
				var withele=$.trim(obj.attr("with"));
				var val=curform.find(withele+",[name='"+withele+"']").val() || withele;

				if(gets.indexOf($.trim(val))!=-1){
					return false;
				}
			},
			
			
			"min":function(gets,obj,curform,datatype){
				/*
					checkbox最少選擇n項
					註意需要給表單元素綁定min屬性來指定是至少需要選擇幾項，沒有綁定的話使用默認值
					eg. <input type="checkbox" name="test" datatype="min" min="3" />
				*/
				
				var minim=~~obj.attr("min") || 2,
					numselected=curform.find("input[name='"+obj.attr("name")+"']:checked").length;
				return  numselected >= minim ? true : "請至少選擇"+minim+"項！";
			},
			
			
			"max":function(gets,obj,curform,datatype){
				/*
					checkbox最多選擇n項
					註意需要給表單元素綁定max屬性來指定是最多需要選擇幾項，沒有綁定的話使用默認值
					eg. <input type="checkbox" name="test" datatype="max" max="3" />
				*/
				
				var atmax=~~obj.attr("max") || 2,
					numselected=curform.find("input[name='"+obj.attr("name")+"']:checked").length;
					
				if(numselected==0){
					return false;
				}else if(numselected>atmax){
					return "最多只能選擇"+atmax+"項！";
				}
				return  true;
			},
			
			
			"byterange":function(gets,obj,curform,datatype){
				/*
					判斷字符長度，中文算兩個字符
					註意需要給表單元素綁定max,min屬性來指定最大或最小允許的字符長度，沒有綁定的話使用默認值
				*/
				var dregx=/[^\x00-\xff]/g;
				var maxim=~~obj.attr("max") || 100000000,
					minim=~~obj.attr("min") || 0;
					
				getslen=gets.replace(dregx,"00").length;
				
				if(getslen>maxim){
					return "輸入字符不能多於"+maxim+"個，中文算兩個字符！";
				}
				
				if(getslen<minim){
					return "輸入字符不能少於"+minim+"個，中文算兩個字符！";
				}
				
				return true;
			},
			
			
			"numrange":function(gets,obj,curform,datatype){
				/*
					判斷數值範圍
					註意需要給表單元素綁定max,min屬性來指定最大或最小可輸入的值，沒有綁定的話使用默認值
				*/
				
				var maxim=~~obj.attr("max") || 100000000,
					minim=~~obj.attr("min") || 0;
				
				gets=gets.replace(/\s*/g,"").replace(/,/g,"");
				if(!/^\d+\.?\d*$/.test(gets)){
					return "只能輸入數字！";
				}
				
				if(gets<minim){
					return "值不能小於"+minim+"！";
				}else if(gets>maxim){
					return "值不能大於"+maxim+"！";
				}
				return  true;
			},
		
			
			"daterange":function(gets,obj,curform,datatype){
				/*
					判斷日期範圍
					註意需要給表單元素綁定max或min屬性，或兩個同時綁定來指定最大或最小可輸入的日期
					日期格式：2012/12/29 或 2012-12-29 或 2012.12.29 或 2012,12,29
				*/
				var maxim=new Date(obj.attr("max").replace(/[-\.,]/g,"/")),
					minim=new Date(obj.attr("min").replace(/[-\.,]/g,"/")),
					gets=new Date(gets.replace(/[-\.,]/g,"/"));

				if(!gets.getDate()){
					return "日期格式不對！";
				}
				
				if(gets>maxim){
					return "日期不能大於"+obj.attr("max");	
				}
				
				if(gets<minim){
					return "日期不能小於"+obj.attr("min");
				}
				
				return true;
			},
			
			
			"idcard":function(gets,obj,curform,datatype){
				/*
					該方法由網友提供;
					對身份證進行嚴格驗證;
				*/
			
				var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];// 加權因子;
				var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];// 身份證驗證位值，10代表X;
			
				if (gets.length == 15) {   
					return isValidityBrithBy15IdCard(gets);   
				}else if (gets.length == 18){   
					var a_idCard = gets.split("");// 得到身份證數組   
					if (isValidityBrithBy18IdCard(gets)&&isTrueValidateCodeBy18IdCard(a_idCard)) {   
						return true;   
					}   
					return false;
				}
				return false;
				
				function isTrueValidateCodeBy18IdCard(a_idCard) {   
					var sum = 0; // 聲明加權求和變量   
					if (a_idCard[17].toLowerCase() == 'x') {   
						a_idCard[17] = 10;// 將最後位為x的驗證碼替換為10方便後續操作   
					}   
					for ( var i = 0; i < 17; i++) {   
						sum += Wi[i] * a_idCard[i];// 加權求和   
					}   
					valCodePosition = sum % 11;// 得到驗證碼所位置   
					if (a_idCard[17] == ValideCode[valCodePosition]) {   
						return true;   
					}
					return false;   
				}
				
				function isValidityBrithBy18IdCard(idCard18){   
					var year = idCard18.substring(6,10);   
					var month = idCard18.substring(10,12);   
					var day = idCard18.substring(12,14);   
					var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
					// 這裏用getFullYear()獲取年份，避免千年蟲問題   
					if(temp_date.getFullYear()!=parseFloat(year) || temp_date.getMonth()!=parseFloat(month)-1 || temp_date.getDate()!=parseFloat(day)){   
						return false;   
					}
					return true;   
				}
				
				function isValidityBrithBy15IdCard(idCard15){   
					var year =  idCard15.substring(6,8);   
					var month = idCard15.substring(8,10);   
					var day = idCard15.substring(10,12);
					var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
					// 對於老身份證中的你年齡則不需考慮千年蟲問題而使用getYear()方法   
					if(temp_date.getYear()!=parseFloat(year) || temp_date.getMonth()!=parseFloat(month)-1 || temp_date.getDate()!=parseFloat(day)){   
						return false;   
					}
					return true;
				}
				
			}
		});
	}else{
		setTimeout(arguments.callee,10);
	}
})();