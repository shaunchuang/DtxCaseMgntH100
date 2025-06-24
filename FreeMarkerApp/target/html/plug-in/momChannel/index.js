var metabolismChart;
var act_show;
var annNews_show;
var task_show;

function textSlide(container, size){
	var len = $(container).children().length;
	if(len>size){
		if(len%size!=0){
			for(var i=0; i<size-(len%size); i++){
				$(container).append("<li style='list-style-type:none;'></li>");
			}
		}
		$(container).children().filter(':gt('+(size-1)+')').hide();
		return setInterval(function(){
			console.log('start');
			var tmp = $(container).children().filter(':visible').hide();
			$(container).children().slice(size, 2*size).fadeIn(1000);
			$(tmp).appendTo($(container));
			console.log('end');
		}, 5000);
	}
}

function startTime() {
    var today = new Date(); //定義日期對象
    var yyyy = today.getFullYear(); //通過日期對象的getFullYear()方法返回年
    var MM = today.getMonth() + 1; //通過日期對象的getMonth()方法返回年
    var dd = today.getDate(); //通過日期對象的getDate()方法返回年
    var hh = today.getHours(); //通過日期對象的getHours方法返回小時
    var mm = today.getMinutes(); //通過日期對象的getMinutes方法返回分钟
    var ss = today.getSeconds(); //通過日期對象的getSeconds方法返回秒
    // 如果分钟或小時的值小於10，則在其值前加0，比如如果時間是下午3點20分9秒的話，則顯示15：20：09
    MM = checkTime(MM);
    dd = checkTime(dd);
    mm = checkTime(mm);
    ss = checkTime(ss);
    var day; //用於保存星期（getDay()方法得到星期編號）
    if (today.getDay() == 0) day = "星期日 ";
    if (today.getDay() == 1) day = "星期一 ";
    if (today.getDay() == 2) day = "星期二 ";
    if (today.getDay() == 3) day = "星期三 ";
    if (today.getDay() == 4) day = "星期四 ";
    if (today.getDay() == 5) day = "星期五 ";
    if (today.getDay() == 6) day = "星期六 ";
    document.getElementById("nowDateTimeSpan").innerHTML = +hh + ":" + mm + ":" + ss + "<br>" + yyyy + "-" + MM + "-" + dd + " " + day;
    setTimeout("startTime()", 1000); //每一秒中重新加載startTime()方法
}

function checkTime(i) {
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}
//Henry  2:已通知3:進行中 5:已完成)
function getStatus(statusCode) {
	var descr=""
	switch(statusCode) {
		case '1':
			descr='提出中';
			break;
		case '2':
			descr='已通知';
			break;
		case '3':
			descr='進行中';
			break;
		case '5':
			descr='已完成';
			break;
		default:
			descr='';			
	}
	return descr;
}

function Course_CancelCourse(cCode, activityId, actStart, attendId, callbackFunc){

        $.ajax({
             url: BASE_URL + "/device/ovo/wgActivitySignup.html",
             type: "POST",
             dataType: "json",
             data: {
                 contractCode: cCode,
                 actcode: activityId,
                 mode: 0,
                 actStart: actStart,
                 attendId: attendId
             },
             success: function(data) {
                 if(data.success == "true") {
                	 //IndexControl.Channel_refresh();
                     alert("取消成功\n");
                     if(callbackFunc) callbackFunc();
                 } else {
                     alert("取消失敗，請洽服務人員\n" + data.errmsg)
                 }
             }
         });
 }

function createCourse(cCode, activityId, actStart, callbackFunc){

		$.ajax({
            url: BASE_URL + "/device/ovo/wgActivitySignup.html",
            type: "POST",
            dataType: "json",
            data: {
                contractCode: cCode,
                actcode: activityId,
				mode: 1,
				actStart:actStart
            },
            success: function(data) {
                if(data.success == "true") {		
                	if(callbackFunc) callbackFunc();
					alert("報名成功\n已為您送出課程活動登記");
                } else {
                    alert("報名失敗\n" + data.errmsg)
                }
            }
        });
}

function onVideoFinished(e) {
	/*
	setTimeout(function(){
		$("#innerContent").show();
		$("#videoContent").hide();
	}, 1000);
	*/
}

IndexControl = {
    //首頁住房公告
    HomeBox_GetAnnNews: function() {
    	//clear
    	if(annNews_show) {
    		clearInterval(annNews_show);
    		annNews_show = null;
    	}
    	$("#annData").find("li").remove();
    	
        $.ajax({
            url: BASE_URL + "/device/ovo/wgGetData.html",
            type: "POST",
            dataType: "json",
            data: {
                contractCode: TVEngine.CONTRACT_CODE,
                dtype: "DATA_ANN"
            },
            success: function(data) {
            	
            	//clear
            	$("#annData").find("li").remove();
            	
            	var annobj = JSON.parse(data.annData);
                var annData = $("#annData ul");

                //附加資料
                _.chain(annobj).sortBy(function(v){return v.status == "Y" ? 0 : 1;}).each(function(data) {
                    annData.append("<li>" + data.name + "</li>");
                });

                //檢測高度
//                var checkHeight = function(contentNode, parentHeight) {
//                    var child = contentNode.children();
//                    if(contentNode.height() > parentHeight && child.length > 1) {
//                        child.last().remove();
//                        checkHeight(contentNode, parentHeight);
//                    } else {
//                        return;
//                    }
//                };
//                checkHeight(annData, $("#room_ann_content").height());
                
                //使用輪播
                if(annNews_show) {
            		clearInterval(annNews_show);
            		annNews_show = null;
            	}
                annNews_show = textSlide($(".annDataContainer"), 2);
            }
        });

    },

	//Henry
    HomeBox_GetActSignUpData: function() {
    	//clear
    	if(act_show){
    		clearInterval(act_show);
    		act_show = null;
    	}
    	$("#actData").find("li").remove();
	
        $.ajax({
            url: BASE_URL + "/device/ovo/wgGetData.html",
            type: "POST",
            dataType: "json",
            data: {
                contractCode: TVEngine.CONTRACT_CODE,
                dtype: "DATA_ACT_SIGNUP"
            },
            success: function(data) {
            	
            	//clear
            	$("#actData").find("li").remove();
            	
            	var actobj = JSON.parse(data.actSignUpData);
                var actData = $("#actData ul");

                //附加資料
               // _.chain(actobj).sortBy(function(v){return v.status == "Y" ? 0 : 1;}).each(function(data) {
                _.chain(actobj).each(function(data) {
                    //var time = new Date(data.activityStart.replace(/-/g, "/"));
					actData.append("<li>【" + data.typename + "】" + data.name + "</li>");
                });

                //檢測高度
//                var checkHeight = function(contentNode, parentHeight) {
//                    var child = contentNode.children();
//                    if(contentNode.height() > parentHeight && child.length > 1) {
//                        child.last().remove();
//                        checkHeight(contentNode, parentHeight);
//                    } else {
//                        return;
//                    }
//                };
//                checkHeight(actData, $("#room_ann_act_content").height() - 10);
                
                //使用輪播
                if(act_show){
            		clearInterval(act_show);
            		act_show = null;
            	}
                act_show = textSlide($(".actDataContainer"), 3);
            }
        });

    },
	
	//Henry
    HomeBox_GetTaskRequestData: function() {
    	//clear
    	if(task_show){
    		clearInterval(task_show);
    		task_show = null;
    	}
    	$("#assistTaskDataContainer").find("li").remove();
    	
        $.ajax({
            url: BASE_URL + "/device/ovo/wgGetData.html",
            type: "POST",
            dataType: "json",
            data: {
                contractCode: TVEngine.CONTRACT_CODE,
                dtype: "DATA_SERVICE_REQUEST"
            },
            success: function(data) {
            	
            	//clear
            	$("#assistTaskData").find("li").remove();
            	
                var actobj = JSON.parse(data.assistRquestData);
                //var actData = $("#actData ul");
                var actData = $("#assistTaskData ul");
                //附加資料
                _.chain(actobj).sortBy(function(v){return v.status == "Y" ? 0 : 1;}).each(function(data) {
                    //var time = new Date(data.activityStart.replace(/-/g, "/"));
					actData.append("<li>【" + data.typename + "】" + data.name + "  "+getStatus(data.taskStatus) +"</li>");
                });

//                //檢測高度
//                var checkHeight = function(contentNode, parentHeight) {
//                    var child = contentNode.children();
//                    if(contentNode.height() > parentHeight && child.length > 1) {
//                        child.last().remove();
//                        checkHeight(contentNode, parentHeight);
//                    } else {
//                        return;
//                    }
//                };
//                checkHeight(actData, $("#room_ann_act_content").height() - 10);
                
                //使用輪播
                if(task_show){
            		clearInterval(task_show);
            		task_show = null;
            	}
                task_show = textSlide($(".assistTaskDataContainer"), 4);
            }
        });

    },	
 

    //我的寶寶排泄統計圖
    HomeBox_CreateMyBabyChart: function() {
    	metabolismChart = new Chart($("#mybaby_chart canvas")[0], {
            type: "bar",
            data: {
                labels: ["0~4", "4~8", "8~12", "12~16", "16~20", "20~24"],
                datasets: [{
                    label: "便便",
                    data: TVEngine.pooArr,
                    backgroundColor: "rgba(255, 202, 12, 1)"
                },{
                    label: "尿尿",
                    data: TVEngine.peeArr,
                    backgroundColor: "rgba(66, 185, 244, 1)"
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true,
                            stepSize: 2,
                            max:8
                        },
                        scaleLabel: {
                            display: true,
                            labelString: "次"
                        }
                    }],
                    xAxes: [{
                        ticks: {
                            beginAtZero: true
                        },
                        scaleLabel: {
                            display: true,
                            labelString: "時間"
                        }
                    }]
                },
                tooltips: {
                    enabled: true,
                    mode: "label",
                    callbacks: {
                        title: function(tooltipItem, data) {
                            return data.labels[tooltipItem[0].index];
                        },
                        label: function(tooltipItems, data) {
                            return tooltipItems.yLabel + "";
                        }
                    }
                },
                labelsFilter: function (value, index) {
                    return (index + 1) % 5 !== 0;
                }
            }
        });
    },
    
    /*
    //產婦護理
    HomeBox_CreateNurseChart: function() {
        new Chart($("#nurse_chart canvas")[0], {
            type: "line",
            data: {
                labels: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
                datasets: [{
                    label: "泌乳量",
                    fill: false,
                    lineTension: 0.1,
                    backgroundColor: "rgba(75,192,192,0.4)",
                    borderColor: "rgba(75,192,192,1)",
                    borderCapStyle: "butt",
                    borderDash: [],
                    borderDashOffset: 0.0,
                    borderJoinStyle: "miter",
                    pointBorderColor: "rgba(75,192,192,1)",
                    pointBackgroundColor: "#fff",
                    pointBorderWidth: 1,
                    pointHoverRadius: 5,
                    pointHoverBackgroundColor: "rgba(75,192,192,1)",
                    pointHoverBorderColor: "rgba(220,220,220,1)",
                    pointHoverBorderWidth: 2,
                    pointRadius: 5,
                    pointHitRadius: 10,
                    data: [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000],
                    spanGaps: true,
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true,
                            callback: function(label, index, labels) {
                                return Math.round(label * 10) / 10 + "";
                            }
                        },
                        scaleLabel: {
                            display: true,
                            labelString: "cc"
                        }
                    }],
                    xAxes: [{
                        ticks: {
                            beginAtZero: true,
                            callback: function(label, index, labels) {
                                return Math.round(label * 10) / 10 + "";
                            }
                        },
                        scaleLabel: {
                            display: true,
                            labelString: "weeks"
                        }
                    }]
                },
                tooltips: {
                    enabled: true,
                    mode: "label",
                    callbacks: {
                        title: function(tooltipItem, data) {
                            return data.labels[tooltipItem[0].index];
                        },
                        label: function(tooltipItems, data) {
                            return tooltipItems.yLabel + "";
                        }
                    }
                }
            }
        });
    },
     */
    
    //我的寶寶 - 生長趨勢
    MyBaby_CreateGrowChart: function() {
        var target = $("#ImgGrowChart");
        var labels = [];
        if(!target.data("created")) {
        	for(var i=0; i<TVEngine.arr3rd.length; i++){
        		labels.push(i);
        	}
        	console.log(TVEngine.babyWeights);
            new Chart(target[0], {
                type: "line",
                data: {
                    labels: labels,
                    datasets: [{
                            label: "3rd",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(255, 101, 0, 0.2)",
                            borderColor: "rgba(255, 101, 0, 0.2)",
                            borderCapStyle: "butt",
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: "miter",
                            pointBorderColor: "rgba(255, 101, 0)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 0,
                            pointHoverBackgroundColor: "rgba(255, 101, 0, 1)",
                            pointHoverBorderColor: "rgba(220,220,220,1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 0,
                            pointHitRadius: 10,
                            data: TVEngine.arr3rd,
                            spanGaps: true,
                        },
                        {
                            label: "15th",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(255, 204, 0, 0.2)",
                            borderColor: "rgba(255, 204, 0, 0.2)",
                            borderCapStyle: "butt",
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: "miter",
                            pointBorderColor: "rgba(255, 0, 0)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 0,
                            pointHoverBackgroundColor: "rgba(255, 204, 0, 1)",
                            pointHoverBorderColor: "rgba(220,220,220,1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 0,
                            pointHitRadius: 10,
                            data: TVEngine.arr15th,
                            spanGaps: true,
                        },
                        {
                            label: "Median",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(154, 204, 0, 0.2)",
                            borderColor: "rgba(154, 204, 0, 0.2)",
                            borderCapStyle: "butt",
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: "miter",
                            pointBorderColor: "rgb(154, 204, 0)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 0,
                            pointHoverBackgroundColor: "rgba(154, 204, 0, 1)",
                            pointHoverBorderColor: "rgba(220,220,220,1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 0,
                            pointHitRadius: 10,
                            data: TVEngine.arrMedian,
                            spanGaps: true,
                        },
                        {
                            label: "85th",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(255, 204, 0, 0.2)",
                            borderColor: "rgba(255, 204, 0, 0.2)",
                            borderCapStyle: "butt",
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: "miter",
                            pointBorderColor: "rgb(255, 204, 0)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 0,
                            pointHoverBackgroundColor: "rgba(255, 204, 0, 1)",
                            pointHoverBorderColor: "rgba(220,220,220,1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 0,
                            pointHitRadius: 10,
                            data: TVEngine.arr85th,
                            spanGaps: true,
                        },
                        {
                            label: "97th",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(255, 101, 0, 0.2)",
                            borderColor: "rgba(255, 101, 0, 0.2)",
                            borderCapStyle: "butt",
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: "miter",
                            pointBorderColor: "rgb(255, 101, 0)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 0,
                            pointHoverBackgroundColor: "rgba(255, 101, 0, 1)",
                            pointHoverBorderColor: "rgba(220,220,220,1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 0,
                            pointHitRadius: 10,
                            data: TVEngine.arr97th,
                            spanGaps: true,
                        },
                        {
                            label: "體重",
                            fill: false,
                            lineTension: 0.1,
                            backgroundColor: "rgba(0, 0, 255, 0.4)",
                            borderColor: "rgba(0, 0, 255, 1)",
                            borderCapStyle: "butt",
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: "miter",
                            pointBorderColor: "rgb(0, 0, 255)",
                            pointBackgroundColor: "#fff",
                            pointBorderWidth: 1,
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgba(0, 0, 255, 1)",
                            pointHoverBorderColor: "rgba(220,220,220,1)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 5,
                            pointHitRadius: 10,
                            data: TVEngine.babyWeights,
                            spanGaps: true,
                        }
                    ]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                                callback: function(label, index, labels) {
                                    return Math.round(label * 10) / 10 + "";
                                }
                            },
                            scaleLabel: {
                                display: true,
                                labelString: "g"
                            }
                        }],
                        xAxes: [{
                            ticks: {
                                beginAtZero: true,
                                callback: function(label, index, labels) {
                                    return Math.round(label * 10) / 10 + "";
                                }
                            },
                            scaleLabel: {
                                display: true,
                                labelString: "天"
                            }
                        }]
                    },
                    tooltips: {
                        enabled: true,
                        mode: "label",
                        callbacks: {
                            title: function(tooltipItem, data) {
                                return data.labels[tooltipItem[0].index];
                            },
                            label: function(tooltipItems, data) {
                                return tooltipItems.yLabel + "";
                            }
                        }
                    }
                }
            });
            //標記已產生
            target.data("created", true);
        }

    },

    //我的寶寶 - 攝取情況
    MyBaby_CreateMilkChart: function() {
    	
    	// 攝取情況 - 瓶餵
    	var target = $("#ImgMilkChart");
        if(!target.data("created")) {
        	$(target)[0].height=225;
        	tmpObj = {
                    type: "line",
                    data: {
                        labels: TVEngine.milkTrendDayArr,
                        datasets: [{
                                label: "瓶餵",
                                fill: true,
                                lineTension: 0.1,
                                backgroundColor: "rgba(255,0,0,0.2)",
                                borderColor: "rgba(255,0,0,1)",
                                borderCapStyle: "butt",
                                borderDash: [],
                                borderDashOffset: 0.0,
                                borderJoinStyle: "miter",
                                pointBorderColor: "rgba(75,192,192,1)",
                                pointBackgroundColor: "#fff",
                                pointBorderWidth: 1,
                                pointHoverRadius: 0,
                                pointHoverBackgroundColor: "rgba(255,0,0,1)",
                                pointHoverBorderColor: "rgba(220,220,220,1)",
                                pointHoverBorderWidth: 2,
                                pointRadius: 0,
                                pointHitRadius: 10,
                                data: TVEngine.milkTrendValueArr,
                                spanGaps: true,
                            }
                        ]
                    },
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    callback: function(label, index, labels) {
                                        return Math.round(label * 10) / 10 + "";
                                    }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: "cc"
                                }
                            }],
                            xAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    callback: function(label, index, labels) {
                                        return Math.round(label * 10) / 10 + "";
                                    }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: "天"
                                }
                            }]
                        },
                        tooltips: {
                            enabled: true,
                            mode: "label",
                            callbacks: {
                                title: function(tooltipItem, data) {
                                    return data.labels[tooltipItem[0].index];
                                },
                                label: function(tooltipItems, data) {
                                    return tooltipItems.yLabel + "";
                                }
                            }
                        }
                    }
                };
        	if(TVEngine.milkTrendValueArr.length==1){
        		tmpObj.options.scales.yAxes[0].ticks.stepSize=200;
        		tmpObj.options.scales.yAxes[0].ticks.max=1000;
        	}
            new Chart(target[0], tmpObj);
            //標記已產生
            target.data("created", true);
        }
        
        // 攝取情況 - 親餵
        target = $("#ImgFeedingChart");
        if(!target.data("created")) {
        	$(target)[0].height=225;
        	tmpObj = {
                    type: "line",
                    data: {
                        labels: TVEngine.feedingTrendDaysArr,
                        datasets: [{
                                label: "親餵",
                                fill: true,
                                lineTension: 0.1,
                                backgroundColor: "rgba(255,0,0,0.2)",
                                borderColor: "rgba(255,0,0,1)",
                                borderCapStyle: "butt",
                                borderDash: [],
                                borderDashOffset: 0.0,
                                borderJoinStyle: "miter",
                                pointBorderColor: "rgba(75,192,192,1)",
                                pointBackgroundColor: "#fff",
                                pointBorderWidth: 1,
                                pointHoverRadius: 0,
                                pointHoverBackgroundColor: "rgba(255,0,0,1)",
                                pointHoverBorderColor: "rgba(220,220,220,1)",
                                pointHoverBorderWidth: 2,
                                pointRadius: 0,
                                pointHitRadius: 10,
                                data: TVEngine.feedingTrendValueArr,
                                spanGaps: true,
                            }
                        ]
                    },
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    callback: function(label, index, labels) {
                                        return Math.round(label * 10) / 10 + "";
                                    }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: "min"
                                }
                            }],
                            xAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    callback: function(label, index, labels) {
                                        return Math.round(label * 10) / 10 + "";
                                    }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: "天"
                                }
                            }]
                        },
                        tooltips: {
                            enabled: true,
                            mode: "label",
                            callbacks: {
                                title: function(tooltipItem, data) {
                                    return data.labels[tooltipItem[0].index];
                                },
                                label: function(tooltipItems, data) {
                                    return tooltipItems.yLabel + "";
                                }
                            }
                        }
                    }
                };
        	if(TVEngine.feedingTrendValueArr.length==1){
        		tmpObj.options.scales.yAxes[0].ticks.stepSize=200;
        		tmpObj.options.scales.yAxes[0].ticks.max=1000;
        	}
            new Chart(target[0], tmpObj);
            //標記已產生
            target.data("created", true);
        }
    },
    
    //我的寶寶 - 幸福剪影資料
    MyBaby_SnapShotData : [],

    //我的寶寶 - 取得幸福剪影資料
    MyBaby_GetSnapShotData : GetSnapShotDataFunc,

    //我的寶寶 - 幸福剪影頁面切換
    MyBaby_GetSnapShotChangePage : function(page) {
        var self = this;
        var box = $(".SnapShotBox");
        
        box.find("img").remove();
        box.find("span").remove();
        if(self.MyBaby_SnapShotData.slice((page - 1) * 6, page * 6).length==0 && page>1){
        	TVEngine.Navigation.menus["brightcove:mainmenu"].currentSnapshotPage--;
        	self.MyBaby_GetSnapShotChangePage(page-1);
        	//TVEngine.Navigation.menus["brightcove:mainmenu"].onSelect();
        }
        $.each(self.MyBaby_SnapShotData.slice((page - 1) * 6, page * 6), function (index, data) {
        	var videoDate = data.src;
        	if(!videoDate) videoDate= "";
			if(videoDate.split("_").length>3){
				box.find("#box" + index).append("<img class=\"floating-SnapShotItem\" src=\""+data.src+"\" onclick='IndexControl.removeVideo(this, "+data.id+", "+page+", "+((page - 1) * 6+index)+");'> <span class='img-font' style='font-size: 16px;'>"+(videoDate.split("_")[3]).split("T")[0]+"</span>");
			}else{
				box.find("#box" + index).append("<img class=\"floating-SnapShotItem\" src=\""+data.src+"\" onclick='IndexControl.removeVideo(this, "+data.id+", "+page+", "+((page - 1) * 6+index)+");'> <span class='img-font' style='font-size: 16px;'>"+(videoDate.split("_")[1]).split("T")[0]+"</span>");
			}
        });
    },

    //我的寶寶 - 播放選擇影片
    MyBaby_PlaySnapShotVideo : function (currentSnapshot, currentSnapshotPage) {
        var self = this;
        var video = $("#video1");
        var source = video.find("source");
        var index = (currentSnapshotPage - 1) * 6 + currentSnapshot;

        //改變qrcode
        $("#video1Container").removeClass("video1ContainerClass");
        $("#videoNoteContainer").removeClass("videoNoteContainerClass");
        $("#videoNote").show();
        $("#videoContentQrcode").show();
        $("#videoQrcode").html("");
        $('#videoQrcode').qrcode({ text : self.MyBaby_SnapShotData[index].video + "?t=" + Date.now() + "&location=" + TVEngine.location});
        
        if(!source.length) {
            video.append("<source src=\"" + self.MyBaby_SnapShotData[index].video + "\" type=\"video/mp4\">");
        } else {
            video[0].pause();
            source.attr("src", self.MyBaby_SnapShotData[index].video).attr("type", "video/mp4");
        }
        video[0].currentTime = 0;
        video[0].load();
        video[0].play();
        video[0].addEventListener('ended', onVideoFinished, false);
        
        //$(video).attr("onclick", "IndexControl.removeVideo(this, "+self.MyBaby_SnapShotData[index].id+", "+currentSnapshotPage+", "+index+");");
    },

    //快速服務 - 服務狀態 (預設)
    QucikService_TaskItem : {
        8 : {actcode: "WG_20170214152258_9658", name : "推送寶寶", assisted: false},
        9 : {actcode: "WG_20170321152028_8223", name : "護理協助", assisted: false},
        10 : {actcode: "WG_20170320143710_1144", name : "住房清潔", assisted: false},
        11 : {actcode: "WG_20170321152112_9072 ", name : "立即送餐", assisted: false},
        12 : {actcode: "WG_20170118115400_4186", name : "設備維修", assisted: false},
        0 : {actcode: "WG_20170321171032_8880", name : "請聯絡我", assisted: false}
    },

    //Henry:
	//取得Server端快速服務 以便更新actcode代碼
	//assisted : 快速服務 新增(1)與取消(0)之toggle控制flag
    //注意: 須定期更新已取得目前的派工狀態
    HomeBox_GetTaskItems: function() {
		var self = this;
        $.ajax({
            url: BASE_URL + "/device/ovo/wgGetData.html",
            type: "POST",
            dataType: "json",
            data: {
                contractCode: TVEngine.CONTRACT_CODE,
                dtype: "DATA_SERVICE"
            },
            success: function(data) {				
                var assistobj = JSON.parse(data.assistData);				
				if (assistobj.length > 0) {
					for (i = 0; i < assistobj.length; i++) {				
						_.each(self.QucikService_TaskItem, function(task) {
							if(task.name === assistobj[i].name){
								//console.log("before code="+task.actcode);
								task.actcode=assistobj[i].assistId.trim();							
								if(assistobj[i].taskStatus ===  "1") task.assisted=true;  //表示尚未受理，才可取消
								else  task.assisted=false; //表示進行中了								
								//console.log("after code="+task.actcode);
								//console.log("name ="+ task.name + "status="+task.assisted );
							}						
						});								
					}								
				}
			}
		});

    },	
		
    //快速服務 - 取得目前服務狀態
    QucikService_GetTaskStatus: function () {
        var self = this;
        _.each(self.QucikService_TaskItem, function(task) {
            task.assisted = false;
        });
    },

    //快速服務 - 送出/取消服務
    QucikService_AssistTask : function (currentService, currentY) {
        var self = this;
        
        //取得最新狀況
        IndexControl.HomeBox_GetTaskItems(); 
        
        var task = self.QucikService_TaskItem[currentService == 0 ? currentY : 0];

    	var currDate = new Date();
		today_year = currDate.getFullYear(); //西元年份
		today_month = currDate.getMonth()+1; //一年中的第幾月
		today_date = currDate.getDate(); //一月份中的第幾天
		var CurrentDatePrifx = today_year+"/"+today_month+"/"+today_date+" ";
		var roomServiceStart = CurrentDatePrifx+"08:00:00";
		var roomServiceEnd = CurrentDatePrifx+"16:00:00";

		if(task.name === "住房清潔"){				
			roomServiceStart = CurrentDatePrifx+"08:00:00";
			roomServiceEnd = CurrentDatePrifx+"16:00:00";												
			if ( ( (Date.parse(currDate)).valueOf() < (Date.parse(roomServiceStart)).valueOf() ) ||  ( (Date.parse(currDate)).valueOf() > (Date.parse(roomServiceEnd)).valueOf() )  )
			{
			   alert("下班時間，如有需求，請改以電話聯絡嬰兒室服務人員。");
			   return false;
			}						
		}
		if(task.name === "立即送餐"){				
			roomServiceStart = CurrentDatePrifx+"07:00:00";
			roomServiceEnd = CurrentDatePrifx+"22:00:00";												
			if ( ( (Date.parse(currDate)).valueOf() < (Date.parse(roomServiceStart)).valueOf() ) ||  ( (Date.parse(currDate)).valueOf() > (Date.parse(roomServiceEnd)).valueOf() )  )
			{
			   alert("下班時間，如有需求，請改以電話聯絡嬰兒室服務人員。");
			   return false;
			}						
		}									
		if(task.name === "護理協助" || task.name === "請聯絡我"){				
			roomServiceStart = CurrentDatePrifx+"09:00:00";
			roomServiceEnd = CurrentDatePrifx+"21:00:00";												
			if ( ( (Date.parse(currDate)).valueOf() < (Date.parse(roomServiceStart)).valueOf() ) ||  ( (Date.parse(currDate)).valueOf() > (Date.parse(roomServiceEnd)).valueOf() )  )
			{
			   alert("下班時間，如有需求，請改以電話聯絡嬰兒室服務人員。");
			   return false;
			}						
		}
		
		//延遲一下，再檢查狀態
	    if(task.assisted) {
			if(!confirm('服務已設定，確定刪除嗎？')){
				return false;
			}			
		}
		
    //////////////////////	    
        $.ajax({
            url: BASE_URL + "/device/ovo/" + (task.assisted ? "wgCancelAssistTask.html" : "wgCallAssistTask.html"),
            type: "POST",
            dataType: "json",
            data: {
                contractCode: TVEngine.CONTRACT_CODE,
                actcode: task.actcode,
                mode: task.assisted ? 0 : 1
            },
            success: function(data) {
                if(data.success == "true") {
                	IndexControl.Channel_refresh();
                    if(!task.assisted){
                        alert("填單成功，" + task.name + "已登記");
                    } else {
                        alert("取消成功，" + task.name + "已取消");
                    }
                    //task.assisted = !task.assisted;
                    //task status refreshed !!!
                    //IndexControl.HomeBox_GetTaskItems();
                    //IndexControl.HomeBox_GetTaskRequestData(); //取得媽媽目前的派工項目，不用等到refresh
                } else {
                    alert(data.errmsg);
                }
                IndexControl.HomeBox_GetTaskItems();
                IndexControl.HomeBox_GetTaskRequestData(); //取得媽媽目前的派工項目，不用等到refresh                
                
            }
        });
    },

    //課程活動 - 課程活動內容
    Course_CourseItem : [],

    Course_CourseTypeItem : {
        13 : "媽媽教室",
        14 : "舒壓課程",
        15 : "衛教課程一對一",
        16 : "衛教影片"
    },

    //課程活動 - 取得課程活動資料
    Course_GetCourseData : function(callBackFunc) {
        var self = this;
        $.ajax({
            url: BASE_URL + "/device/ovo/wgGetData.html",
            type: "POST",
            dataType: "json",
            data: {
                contractCode: TVEngine.CONTRACT_CODE,
                dtype: "DATA_ACT",
                limitdays: "7"
            },
            success: function(data) {
                if(data.success == "true") {
                    self.Course_CourseItem = JSON.parse(data.actData.replace(/[+]/g, " "));
                    //console.log("reget Course_CourseItem done!")
                    if(callBackFunc) callBackFunc();
                }
            }
        });
    },

    //課程活動 - 目前課程清單
    Course_CurrentCourseList : [],

    //課程活動 - 變更課程清單
    Course_ChangeCourseList : function(currentY, currentCourseEduPage) {
    	
    	//重抓以獲得最新的課程
    	IndexControl.Course_GetCourseData();
    	//console.log("done --1");
    	//IndexControl.Course_GetCourseData();
    	//console.log("done -2");
    	//console.log("test-Course_ChangeCourseList Course_GetCourseData");
    	
        var self = this;
        var listNode = $(".Courselists");
        
        //暫存當時css狀態
        var topCSS = null;
        var widthCSS = null;
        
        console.log("currentY="+currentY);
        if(currentY!=16){
        	//console.log("test---self.Course_CurrentCourseList creating ....");
        	//衛教課程：媽媽教室、舒壓課程、衛教課程一對一
        	$('#TabPage_Course').css('background-image', "");
        	$(listNode).css('top', '');
        	$(listNode).css('width', '');
	        self.Course_CurrentCourseList = _.chain(IndexControl.Course_CourseItem)
	            .where({typename : self.Course_CourseTypeItem[currentY]})
	            //.sortBy(function(v) { return v.status == "Y" ? 0 : 1 })
	            .each(function(v, i){
	            	/*
	                var time = new Date(v.activityStart.replace(/-/g, "/"));
					
	                listNode.append("<li class=\"CourseItem\"><span>"
	                + (String(100 + time.getMonth() + 1).slice(1)) + "/" + (String(100 + time.getDate()).slice(1)) + " (" + "日一二三四五六"[time.getDay()] + ") " + v.name
	                + "</span></li>")
					*/
	                //console.log("name="+v.name+":"+v.status+" selected="+v.selected);
	                var CourseLogo="activityCourseIcon1empty.png";  //default: empty
	                if(v.status == "Y") CourseLogo="activityCourseIcon1.png";
	                if(v.selected == "Y") CourseLogo="activityCourseIcon1selected.png";
	                	               
	                var fulltag="[額滿]";
	                
	                if(v.attendNum < v.limitnum)
	                	fulltag="";

	                listNode.append("<li class=\"CourseItem\"><span> <img style=\"width: 8%; height: 8%\" src=\"/wgnursing/plug-in/momChannel/" +CourseLogo+"\" >"+fulltag+v.name + "</span></li>")
	            })
	            .value();
	        //console.log("test--self.Course_CurrentCourseList creating done");
	        
        }else{
        	//衛教影片
        	topCSS = $(listNode).css('top'); 
        	widthCSS = $(listNode).css('width');
        	$('#TabPage_Course').css('background-image', 'none');
        	$(listNode).css('top', '0px');
        	$(listNode).css('width', '750px');
        	self.Course_education(currentCourseEduPage);
        }
    },

    //課程活動 - 顯示課程詳細資料
    Course_ShowCourseDetail : function (curretCourseY) {
        var self = this;
        /*
    	IndexControl.Course_GetCourseData();
		console.log("Course_ShowCourseDetail---->refresh course!")
        */
        
        
        var course = self.Course_CurrentCourseList[curretCourseY];
        $("#courseDetail").empty().append("<h1>" + course.name + "</h1><br><br>" + decodeURIComponent(course.descr));
    },

    Course_SignupCourse : function(curretCourseY, callbackFunc){

    	//IndexControl.Course_GetCourseData();
    	//IndexControl.Course_ChangeCourseList(14,1);
    	var self = this;
    	var course = self.Course_CurrentCourseList[curretCourseY];		
		//console.log("Course_SignupCourse ------> course="+course);
    	
		
		/*
    	IndexControl.Course_GetCourseData();
		console.log("$$$$$$$refresh course!")
		
		setTimeout(function(){				
				course = self.Course_CurrentCourseList[curretCourseY];
				console.log("------> recatch course!"+course);
			}, 800);
		*/
		       
        $.ajax({
            url: BASE_URL + "/device/ovo/wgActivitySignupCheck.html",
            type: "POST",
            dataType: "json",
            data: {
                contractCode: TVEngine.CONTRACT_CODE,
                actcode: course.activityId,
                actStart: course.activityStart,
            },            
            success: function(data) {
                if(data.success == "true") {
                	if(data.exist == "true") {
                		if(confirm('活動已報名，您想取消報名嗎？')){
                			Course_CancelCourse(TVEngine.CONTRACT_CODE, course.activityId, course.activityStart, course.attendId, callbackFunc);
                			return false;
                		}else  return false;
                	}else{     
                		//增加報名人數限制 
                	    if(course.attendNum >= course.limitnum)
                	    {
                	        alert("很抱歉，此活動 報名人數限制"+course.limitnum+"，目前已額滿，無法報名。");
                	        return false;
                	    }    
						//新增報名 
						createCourse(TVEngine.CONTRACT_CODE, course.activityId, course.activityStart, callbackFunc);
						//alert("報名成功\n已為您送出課程活動登記");
					}
                 } else {
                	 alert("活動狀態讀取失敗，請洽服務人員\n" + data.errmsg)
                 }
             }
        });
    },
	//Henry:
	//取得產婦提醒
    HomeBox_GetNotifyItems: function() {
		var self = this;
        $.ajax({
            url: BASE_URL +"/device/ovo/wgGetData.html",
            type: "POST",
            dataType: "json",
            data: {
                contractCode: TVEngine.CONTRACT_CODE,
                dtype: "DATA_ANN_PERSON"
            },
            success: function(data) {				
                var annobj = JSON.parse(data.annData);				
				if (annobj.length > 0) {				
					var anntext="";
					for (i = 0; i < annobj.length; i++) {	
						anntext+= (annobj[i].name);	
						if( (i+1)!=annobj.length ) anntext+='，';
					}					
					$("#notify").text(anntext);	
				}else 
					$("#notify").text(""); 
			}
		});
    },
    
    // 課程活動 - 衛教影片資料
    Course_educationData: [],
    
    // 衛教影片 - 取得衛教影片資料
    Course_GetEducationData : GetCourseVideoDataFunc,
    
    // 衛教影片 - 播放選擇影片
	CourseEdu_PlayVideo : function (currentCourseEdu, currentCourseEduPage) {
		var self = this;
		var video = $("#video1");
		var source = video.find("source");
		var index = (currentCourseEduPage - 1) * 6 + currentCourseEdu;
		
		//改變qrcode
		$("#video1Container").addClass("video1ContainerClass");
        $("#videoNoteContainer").addClass("videoNoteContainerClass");
		$("#videoNote").hide();
		$("#videoContentQrcode").hide();
		$("#videoQrcode").html("");
		$('#videoQrcode').qrcode({ text : QRCODE_ROOT_URL + self.Course_educationData[index].video});
		
		if(!source.length) {
			video.append("<source src=\"" + self.Course_educationData[index].video + "\" type=\"video/mp4\">");
		} else {
			video[0].pause();
			source.attr("src", self.Course_educationData[index].video).attr("type", "video/mp4");
		}
		video[0].currentTime = 0;
		video[0].load();
		video[0].play();
		video[0].addEventListener('ended', onVideoFinished, false);
	},
                           
    //課程活動 - 衛教影片
    Course_education : function(page) {
        var self = this;
        var box = $(".Courselists");
        
        box.find("li").remove();
        if(self.Course_educationData.slice((page - 1) * 6, page * 6).length==0 && page>1){
        	TVEngine.Navigation.menus["brightcove:mainmenu"].currentCourseEduPage--;
        	self.Course_education(page-1);
        	//TVEngine.Navigation.menus["brightcove:mainmenu"].onSelect();
        }
        box.append('<li><div class="SnapShotBox"><div id="ei0"></div><div id="ei2"></div><div id="ei4"></div><div id="ei1"></div><div id="ei3"></div><div id="ei5"></div></div></li>');
        $.each(self.Course_educationData.slice((page - 1) * 6, page * 6), function (index, data) {
        	box.find("#ei"+index).append("<img class=\"floating-SnapShotItem\" src=\""+data.src+"\">");
        });
    },
    
    Employee_refresh: function(){
    	var self = this;
    	var opt = { momId: TVEngine.momId };
    	if(TVEngine.babyId) opt["babyId"]=TVEngine.babyId;
	    $.ajax({
	    	url: BASE_URL +"/baby/employee/list",
	    	type: "POST",
	        data: opt,
	        success: function(data) {				
	        	$("div.TabPage_Server").html(data);
	        }
	    });
	    setTimeout(function(){ IndexControl.Employee_refresh(); }, 300000); //五分鐘
    },
    
    Channel_refresh: function(){
    	
    	$("#assistTaskData").find("li").remove();
    	$("#actData").find("li").remove();
   
        IndexControl.HomeBox_GetActSignUpData();
        IndexControl.Course_GetCourseData();
        IndexControl.HomeBox_GetNotifyItems(); //Henry : 取得個人通知
        
        IndexControl.mealPost();
        IndexControl.soupPost();
        IndexControl.drinkPost();
        IndexControl.HomeBox_GetTaskItems();
     	IndexControl.HomeBox_GetTaskRequestData();
     	IndexControl.HomeBox_GetAnnNews();//Henry : 取得公告
        setTimeout(function(){ IndexControl.Channel_refresh(); }, 60000); //一分鐘
    },
    
    babyHome_refresh: function(){
    	var self = this;
    	if(TVEngine.babyId){
	        $.ajax({
	            url: BASE_URL +"/baby/babyHome",
	            type: "POST",
	            data: {
	            	momId: TVEngine.momId,
	            	babyId: TVEngine.babyId
	            },
	            dataType: "json",
	            success: function(data) {
	                if(data.success){
	                	for(var i=0; i<data.items.length; i++){
	                		switch((data.items)[i].type){
	                		case "feeding": //奶量更新
	                			$("#milkFeedingContent").text((data.items)[i].value);
	                			break;
	                		case "weight": //體重
	                			$("#babyWeightContent").text((data.items)[i].value);
	                			break;
	                		case "poo": //大便
	                			metabolismChart.data.datasets[0].data = JSON.parse((data.items)[i].value);
	                			metabolismChart.update();
	                			break;
	                		case "pee": //小便
	                			metabolismChart.data.datasets[1].data = JSON.parse((data.items)[i].value);
	                			metabolismChart.update();
	                			break;
	                    	}
	                	}
	                }
				}
			});
	    	setTimeout(function(){ IndexControl.babyHome_refresh(); }, 60000); //一分鐘
    	}
    },
    
    mealPost: function() {
		var self = this;
        $.ajax({
            url: BASE_URL+"/baby/getMealPost",
            type: "POST",
            data: {},
            success: function(data) {
            	var mealMenu = $('<div></div>').html(data).find("#postContent");
            	
            	//早餐
            	$("#HTML_Menu .todayMealBox:eq(0) .mealFoodList:eq(0) li").html($(mealMenu).find("table:eq(0) tr:eq(1) td:eq(1)").html());
            	$("#HTML_Menu .todayMealBox:eq(0) .mealFoodList:eq(1) li").html($(mealMenu).find("table:eq(0) tr:eq(1) td:eq(2)").html());
            	$("#HTML_Menu .todayMealBox:eq(0) .mealFoodList:eq(2) li").html($(mealMenu).find("table:eq(0) tr:eq(1) td:eq(3)").html());
            	$("#HTML_Menu .todayMealBox:eq(0) .mealFoodList:eq(3) li").html($(mealMenu).find("table:eq(0) tr:eq(1) td:eq(4)").html());
            	
            	//午餐
            	$("#HTML_Menu .todayMealBox:eq(1) .mealFoodList:eq(0) li").html($(mealMenu).find("table:eq(0) tr:eq(2) td:eq(1)").html());
            	$("#HTML_Menu .todayMealBox:eq(1) .mealFoodList:eq(1) li").html($(mealMenu).find("table:eq(0) tr:eq(2) td:eq(2)").html());
            	$("#HTML_Menu .todayMealBox:eq(1) .mealFoodList:eq(2) li").html($(mealMenu).find("table:eq(0) tr:eq(2) td:eq(3)").html());
            	$("#HTML_Menu .todayMealBox:eq(1) .mealFoodList:eq(3) li").html($(mealMenu).find("table:eq(0) tr:eq(2) td:eq(5)").html());
            	
            	//午點
            	$("#HTML_Menu .todayMealBox:eq(2) .mealFoodList:eq(0) li").html($(mealMenu).find("table:eq(0) tr:eq(3) td:eq(3)").html());
            	
            	//晚餐
            	$("#HTML_Menu .todayMealBox:eq(3) .mealFoodList:eq(0) li").html($(mealMenu).find("table:eq(0) tr:eq(4) td:eq(1)").html());
            	$("#HTML_Menu .todayMealBox:eq(3) .mealFoodList:eq(1) li").html($(mealMenu).find("table:eq(0) tr:eq(4) td:eq(2)").html());
            	$("#HTML_Menu .todayMealBox:eq(3) .mealFoodList:eq(2) li").html($(mealMenu).find("table:eq(0) tr:eq(4) td:eq(3)").html());
            	$("#HTML_Menu .todayMealBox:eq(3) .mealFoodList:eq(3) li").html($(mealMenu).find("table:eq(0) tr:eq(4) td:eq(5)").html());
            	
            	//晚點
            	$("#HTML_Menu .todayMealBox:eq(4) .mealFoodList:eq(0) li").html($(mealMenu).find("table:eq(0) tr:eq(5) td:eq(3)").html());
            	
            	//總表
            	$("#todayMeal_kcal").html($(mealMenu).find("table:eq(1) tr:eq(1) td:eq(0)").html());
            	$("#todayMeal_co2").html($(mealMenu).find("table:eq(1) tr:eq(1) td:eq(1)").html());
            	$("#todayMeal_egg").html($(mealMenu).find("table:eq(1) tr:eq(1) td:eq(2)").html());
            	$("#todayMeal_oil").html($(mealMenu).find("table:eq(1) tr:eq(1) td:eq(3)").html());
            	$("#todayMeal_fo").html($(mealMenu).find("table:eq(1) tr:eq(1) td:eq(4)").html());
            	$("#todayMeal_la").html($(mealMenu).find("table:eq(1) tr:eq(1) td:eq(5)").html());
            	$("#todayMeal_c").html($(mealMenu).find("table:eq(1) tr:eq(1) td:eq(6)").html());
            	$("#todayMeal_ca").html($(mealMenu).find("table:eq(1) tr:eq(1) td:eq(7)").html());
			}
		});
    },
    
    soupPost: function(){
    	var self = this;
        $.ajax({
            url: BASE_URL+"/baby/getSoupPost",
            type: "POST",
            data: {},
            success: function(data) {
            	var soupMenu = $('<div></div>').html(data).find("#postContent");
            	
            	$("#HTML_Soup .todaySoupBox:eq(0) .soupImg").html($(soupMenu).find("table tr:eq(0) td:eq(1)").html());
            	$("#HTML_Soup .todaySoupBox:eq(0) .soupTitle").html('<span>'+$(soupMenu).find("table tr:eq(1) td:eq(1)").html()+'</span>'+$(soupMenu).find("table tr:eq(0) td:eq(1)").html());
            	$("#HTML_Soup .todaySoupBox:eq(0) .soupIngredientContent").html($(soupMenu).find("table tr:eq(2) td:eq(1)").html());
            	$("#HTML_Soup .todaySoupBox:eq(0) .soupEffectContent").html($(soupMenu).find("table tr:eq(3) td:eq(1)").html());
            	
            	$("#HTML_Soup .todaySoupBox:eq(1) .soupImg").html($(soupMenu).find("table tr:eq(0) td:eq(2)").html());
            	$("#HTML_Soup .todaySoupBox:eq(1) .soupTitle").html('<span>'+$(soupMenu).find("table tr:eq(1) td:eq(2)").html()+'</span>'+$(soupMenu).find("table tr:eq(0) td:eq(2)").html());
            	$("#HTML_Soup .todaySoupBox:eq(1) .soupIngredientContent").html($(soupMenu).find("table tr:eq(2) td:eq(2)").html());
            	$("#HTML_Soup .todaySoupBox:eq(1) .soupEffectContent").html($(soupMenu).find("table tr:eq(3) td:eq(2)").html());
            	
            	$("#HTML_Soup .todaySoupBox:eq(2) .soupImg").html($(soupMenu).find("table tr:eq(0) td:eq(3)").html());
            	$("#HTML_Soup .todaySoupBox:eq(2) .soupTitle").html('<span>'+$(soupMenu).find("table tr:eq(1) td:eq(3)").html()+'</span>'+$(soupMenu).find("table tr:eq(0) td:eq(3)").html());
            	$("#HTML_Soup .todaySoupBox:eq(2) .soupIngredientContent").html($(soupMenu).find("table tr:eq(2) td:eq(3)").html());
            	$("#HTML_Soup .todaySoupBox:eq(2) .soupEffectContent").html($(soupMenu).find("table tr:eq(3) td:eq(3)").html());

			}
		});
    },
    
    drinkPost: function(){
    	var self = this;
        $.ajax({
            url: BASE_URL+"/baby/getDrinkPost",
            type: "POST",
            data: {},
            success: function(data) {
            	var drinkMenu = $('<div></div>').html(data).find("#postContent");
            	
            	for(var i=1; i<=3; i++){
            		if($(drinkMenu).find("table tr:eq(0) td:eq("+i+")").text().trim()=="是"){
            			$("#HTML_Drinking .todaySoupBox:eq(2) .soupImg").html($(drinkMenu).find("table tr:eq(1) td:eq("+i+")").html());
                    	$("#HTML_Drinking .todaySoupBox:eq(2) .soupTitle").html('<span>'+$(drinkMenu).find("table tr:eq(2) td:eq("+i+")").html()+'</span>'+$(drinkMenu).find("table tr:eq(1) td:eq(1)").html());
                    	$("#HTML_Drinking .todaySoupBox:eq(2) .soupIngredientContent").html($(drinkMenu).find("table tr:eq(3) td:eq("+i+")").html());
                    	$("#HTML_Drinking .todaySoupBox:eq(2) .soupEffectContent").html($(drinkMenu).find("table tr:eq(4) td:eq("+i+")").html());
                    	break;
            		}
            	}
            	
            	if(i>3){
            		$("#HTML_Drinking .todaySoupBox:eq(2)").hide();
            	}
			}
		});
    },
    
    removeVideo: function(obj, videoId, page, itemIndex){
    	var self = this;
    	if(confirm("確定刪除嗎？")){
    		$.ajax({
                url: BASE_URL+"/baby/rmBabySnapshot",
                type: "POST",
                data: {id: videoId},
                dataType: "json",
                success: function(data) {
                	if(data.success){
                		var boxId = $(".SnapShotBox img.floating-SnapShotItemfocused").parent().attr("id");
                		var boxIndex = parseInt(boxId.substring(3));
                		if($(".SnapShotBox img").length==1) boxIndex = 5;
                		
                		self.MyBaby_SnapShotData.splice(itemIndex, 1);
                		self.MyBaby_GetSnapShotChangePage(page);
                		
                		if($(".SnapShotBox #box" + boxIndex + " img").length!=0){
                			$(".SnapShotBox #box" + boxIndex + " img").addClass("floating-SnapShotItemfocused");
                			TVEngine.Navigation.menus["brightcove:mainmenu"].currentSnapshot = boxIndex;
                		}else if(boxIndex>0){
                			$(".SnapShotBox #box" + (boxIndex-1) + " img").addClass("floating-SnapShotItemfocused");
                			TVEngine.Navigation.menus["brightcove:mainmenu"].currentSnapshot = boxIndex-1;
                		}
                		
                		alert("刪除成功!");
                	}
    			}
    		});
    	}
    }
};

$(window).load(function(){
    //初始化
	
	//我的寶寶
    IndexControl.babyHome_refresh(); //奶量、體重、排泄物統計更新
	
    //IndexControl.HomeBox_GetActNews();  //Henry : 停用
	IndexControl.HomeBox_GetActSignUpData();  //Henry : 取得媽媽報名活動
    IndexControl.HomeBox_GetAnnNews();
    IndexControl.HomeBox_CreateMyBabyChart();
    //IndexControl.HomeBox_CreateNurseChart();
    IndexControl.MyBaby_GetSnapShotData();
    IndexControl.Course_GetEducationData();
    
	IndexControl.HomeBox_GetTaskItems();
	IndexControl.HomeBox_GetTaskRequestData();  //Henry : 取得媽媽指定的快速服務資料		
	
    IndexControl.QucikService_GetTaskStatus();
    IndexControl.Course_GetCourseData();
    IndexControl.HomeBox_GetNotifyItems(); //Henry : 取得個人通知
    IndexControl.Channel_refresh();
    IndexControl.Employee_refresh();
    
    //今日膳食
    IndexControl.mealPost();
    IndexControl.soupPost();
    IndexControl.drinkPost();
    
    //縮時回憶QR Code
    if(TVEngine.babyId){
    	$('#mybaby_timelapse_qrcode').qrcode({ text : QRCODE_ROOT_URL + BASE_URL + "/baby/files/" + TVEngine.babyId + ".gif"});
    }else{
    	$('#mybaby_timelapse_qrcode').qrcode({ text : ""});
    }
});