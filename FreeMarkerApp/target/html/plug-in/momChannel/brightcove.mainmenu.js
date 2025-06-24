/*
**20170104 Edited by Guan-An
*/
/*
**20170720 Edited by Jian-Hong
**新增雙胞胎事件處理(on key return)
*/
(function (TVEngine) {
    var menu = new TVEngine.Navigation.Menu();
    menu.menuHandlesEvents();
    menu.currentY = 0;
    menu.currentXs = [];
    menu.currentX = 0;
    menu.name = "brightcove:mainmenu";
    menu.currentCourseY = 0;//控制Y軸
    menu.currentServicePage = 0;//紀錄快速服務當前頁面
    menu.currentService = 0;//紀錄快速服務選取項次
    menu.isEnterService = false;//判斷是否已按下進入快速服務次選單
    menu.currentServicePageItem = 0;
    menu.photoisShow = false;
    menu.currentSnapshot = 0;
    menu.currentSnapshotPage = 1;
    menu.isEnterSnapShot = false;
    menu.currentCourseEdu = 0;
    menu.currentCourseEduPage = 1;
    menu.isEnterCourseEdu = false;
    menu.isCourseShow = false;
    menu.isEnterCourse = false;
    menu.courseButtonIndex = 0;
    menu.isEnterBabyRecord = false;
    menu.PressEvent;

    //Tab 類泛型實作 利於後續程式閱讀與維護
    var enumTabPage = {
        Home: 0,
        Baby: 1,
        DailyFood: 2,
        QuickService: 3,
        Course: 4,
        Server: 5
    };
    //我的寶寶縱軸標題泛型實作
    /*var enumMyBabyTitle = { //2017.03.15 未使用
        Info: 0,
        BabyRecord: 1,
        FeedStatus:2,
        Excretion: 3,
        GrowTrend:4,
        RestStatus: 5,
        SnapShot: 6,
        Timelapse: 7
    };*/
    //鍵盤事件
    var enumKeyboardPress = {
        Up: 0,
        Down: 1,
        Left: 2,
        Right: 3
    };
    //初始化
    menu.getTabMax = function () {
        return $(".vidItem").length;
    };

    //遙控器控制事件
    menu.onUp = function () {
        this.PressEvent = enumKeyboardPress.Up;
        if (this.currentX == enumTabPage.Course) {
        	if(this.currentY == 16 && this.isEnterCourseEdu){
        		this.EnterCourseEduControl();
        	}else{
        		if (!this.isCourseShow) {
                    if (!this.isEnterCourse){
                        this.currentCourseY = 0;
                        this.currentY--;
                        if(this.currentY < 13) {
                            this.currentY = 16;
                        }
                        menu.PlaylistsNavWrapperFocused();
                    }else{
                        if(this.currentCourseY == 0){
                            this.currentCourseY = $(".Courselists li").length - 1;
                        } else {
                            this.currentCourseY--;
                        }
                    }
                    menu.CourseSwitch();
                }
                else (this.isCourseShow)
                    menu.CourseButtonSwitch();
        	}
        }
        else if (this.currentX == enumTabPage.Baby && this.currentY == 3 && this.isEnterSnapShot)
            this.EnterSnapshotControl();
		/*
        else if (this.currentX == enumTabPage.QuickService)
            this.QuickServiceControl();
		*/
        else if (this.currentX == enumTabPage.QuickService) {
                if(!this.isEnterService) {
                    if (this.currentY > 8) {
                        this.currentY--;
                    } else {
                        this.currentY = 12;
                    }
                    this.currentService = 0;
                } else {
                    this.currentService--;
                    if(this.currentService < 0) {
                        this.currentService = 2;
                    }
                }
                this.QuickServiceContentSwitch();
        }
        else if (this.currentX == enumTabPage.DailyFood) {
            if (this.currentY > 5) { //6
                this.currentY--;
                this.DailyFoodContentSwitch();
            }
        }
        else {
            if (this.currentY > 0) {
                $("#playicon").hide();
                $(".vidItem img").css({
                    borderColor: "#000"
                });
                var oldy = this.currentY;
                this.currentY--;


                $("#playlistsNav").animate({
                    top: -(this.currentY * $("#playlistsNav li:first").outerHeight(true))
                }, null, null, function () {
                    $("#playicon").fadeIn(300);
                });

            }
            this.currentXs[this.currentY] = 0;

            menu.PlaylistsNavWrapperFocused();


            $(".videoCategory:eq(" + this.currentY + ") > .vidItem:eq(" + this.currentXs[this.currentY] + ") img:first").css({
                borderColor: "#00bff3"
            });
            menu.ContentSwitch();
        }

    };
    //遙控器向下控制
    menu.onDown = function () {
        $log("currentX\t:" + this.currentX, "currentY\t" + this.currentY);
        this.PressEvent = enumKeyboardPress.Down;
        if (this.currentX == enumTabPage.Course) {
        	if(this.currentY == 16 && this.isEnterCourseEdu){
        		this.EnterCourseEduControl();
        	}else{
        		if (!this.isCourseShow) {
                    if(!this.isEnterCourse){
                        this.currentCourseY = 0;
                        this.currentY++;
                        if(this.currentY > 16) {
                            this.currentY = 13;
                        }
                        menu.PlaylistsNavWrapperFocused();

                    }else{
                        if (this.currentCourseY == $(".Courselists li").length - 1){
                            this.currentCourseY = 0;
                        } else {
                            this.currentCourseY++;
                        }
                    }
                    menu.CourseSwitch();
                }
                else (this.isCourseShow)
                    menu.CourseButtonSwitch();
        	}
        }
        else if (this.currentX == enumTabPage.Baby && this.currentY == 3 && this.isEnterSnapShot) {
            // $log("EnterSnapshotControl");
            this.EnterSnapshotControl();
        }


        else if (this.currentX == enumTabPage.QuickService) {

            if(!this.isEnterService) {
                if(this.currentY < 12) {
                    this.currentY++;
                } else {
                    this.currentY = 8;
                }
                this.currentService = 0;
                menu.ContentSwitch();
            } else {
                this.currentService++;
                if(this.currentService > 2) {
                    this.currentService = 0;
                }
                this.QuickServiceContentSwitch();
            }

        }
        else if (this.currentX == enumTabPage.DailyFood) {
            if (this.currentY < 7) {
                this.currentY++;
            } else {
                this.currentY = 5;
            }
            menu.ContentSwitch();
        }
        else if (this.currentX == enumTabPage.Baby) {

            if (this.currentY < 4) {
                this.currentY++;
            } else {
                this.currentY = 0;
            }

                $("#playlistsNav").animate({
                    top: -(this.currentY * $("#playlistsNav li:first").outerHeight(true))
                }, null, null, function () {
                    $("#playicon").fadeIn(300);
                });
                this.currentXs[this.currentY] = 0;

                menu.PlaylistsNavWrapperFocused();

                menu.ContentSwitch();
            //}
        }


    };
    //左鍵事件 控制水平頁面切換
    menu.onLeft = function () {
        this.PressEvent = enumKeyboardPress.Left;        
        if (this.currentX > 0) {
            //取消當前Tab item選取
            var picturePath = $("#playlistsWrapper").find("#TabItem").eq(this.currentX).attr("src");
            $("#playlistsWrapper").find("#TabItem").eq(this.currentX).attr("src", picturePath.replace("Focused.png", ".png"));
            //選取下一個Tab item
            picturePath = $("#playlistsWrapper").find("#TabItem").eq(--this.currentX).attr("src");
            $("#playlistsWrapper").find("#TabItem").eq(this.currentX).attr("src", picturePath.replace(".png", "Focused.png"));
        }
        menu.TabSwitch();
    };
    //右鍵事件 控制水平頁面切換
    menu.onRight = function () {
        this.PressEvent = enumKeyboardPress.Right;
        if (this.currentX < this.getTabMax() - 1) {
            //取消前一筆ITEM選取
            var picturePath = $("#playlistsWrapper").find("#TabItem").eq(this.currentX).attr("src");
            $("#playlistsWrapper").find("#TabItem").eq(this.currentX).attr("src", picturePath.replace("Focused.png", ".png"));

            picturePath = $("#playlistsWrapper").find("#TabItem").eq(++this.currentX).attr("src");
            $("#playlistsWrapper").find("#TabItem").eq(this.currentX).attr("src", picturePath.replace(".png", "Focused.png"));
        }
        menu.TabSwitch();
    };
    //確認事件
    menu.onSelect = function () {
        $log(" ON SELECT CALLED ! ");
        var video1 = document.getElementById("video1");
        if(this.currentX == enumTabPage.Course && this.currentY == 16 && !this.isEnterCourseEdu){
        	this.isEnterCourseEdu = true;
			$log("hardwareAccelerated open");
        	//this.currentCourseEdu = 0;
            $(".Courselists #ei" + this.currentCourseEdu + " img").addClass("floating-SnapShotItemfocused");
    	}else if (this.currentX == enumTabPage.Baby && this.currentY == 3 && !this.isEnterSnapShot){
            this.isEnterSnapShot = true;			
			$log("hardwareAccelerated open");
            $(".SnapShotBox #box" + this.currentSnapshot + " img").addClass("floating-SnapShotItemfocused");
        }else if (this.isEnterSnapShot && video1.paused) {
            $log("Play Select Snapshot\t" + this.currentSnapshot);
            $("#innerContent").css("display", "none");

            $("#videoContent").css("display", "").css("autoplay", "autoplay").append($("#landingNavbar"));
            //變更按鈕
            $(".buttonOptions.subButton .navbutton").filter(".playButton, .backButton").css("display", "").end().filter(".selectButton").css("display", "none");
            IndexControl.MyBaby_PlaySnapShotVideo(this.currentSnapshot, this.currentSnapshotPage); //切換及播放影片
            //video1.currentTime = 0;
            //video1.play();
        }else if(this.isEnterCourseEdu && video1.paused){
            $("#innerContent").css("display", "none");

            $("#videoContent").css("display", "").css("autoplay", "autoplay").append($("#landingNavbar"));
            //變更按鈕
            $(".buttonOptions.subButton .navbutton").filter(".playButton, .backButton").css("display", "").end().filter(".selectButton").css("display", "none");
            IndexControl.CourseEdu_PlayVideo(this.currentCourseEdu, this.currentCourseEduPage); //切換及播放影片
            //video1.currentTime = 0;
            //video1.play();
        }
        else if (this.currentX == enumTabPage.Baby && this.currentY == 1 && this.isEnterBabyRecord) {
            this.isEnterBabyRecord = false;
            var milk = prompt("請輸入寶寶奶量(若無，請輸入0):");
            var popo = prompt("請輸入寶寶便量(若無，請輸入0):");
            if (milk != "" || popo != "")
                alert("已為您紀錄");
        }
        else if (this.currentX == enumTabPage.Course) {
            if(!this.isEnterCourse) {
            	//IndexControl.Course_ChangeCourseList(this.currentY, this.currentCourseEduPage);
        		//console.log("!!###isEnterCourse---->refresh course!+this.currentCourseY="+this.currentCourseY);
   				
            	
                this.isEnterCourse = true;
                menu.CourseSwitch();
                $(".buttonOptions.subButton .navbutton").filter(".backButton").css("display", "");
            } else {
                if(!this.isCourseShow) {
                    this.isCourseShow = true;
                    IndexControl.Course_ShowCourseDetail(this.currentCourseY);
                    $(".courseContent").css("display", "");
                    $(".Courselists").css("display", "none");

                    $(".buttonOptions.subButton .navbutton").filter(".detailButton, .backButton").css("display", "none").end().filter(".signupButton").css("display", "");
                    menu.CourseSwitch();
                } else {
                    this.isCourseShow = false;
                    if (this.courseButtonIndex == 0){
                        IndexControl.Course_SignupCourse(this.currentCourseY, function(){
                        	menu.CourseSwitch();
                        });
                    }
                    $(".courseContent").css("display", "none");
                    $(".Courselists").css("display", "");

                    $(".buttonOptions.subButton .navbutton").filter(".detailButton, .backButton").css("display", "").end().filter(".signupButton").css("display", "none");
                }
            }
        }

        else if (this.currentX == enumTabPage.QuickService) {

            if (!this.isEnterService) {
                //$(".ServiceSubPageItemfocused").removeClass("ServiceSubPageItemfocused");
                this.isEnterService = true;
                this.currentService = 0;
                menu.QuickServiceContentSwitch();

            }
            else if (this.isEnterService) {
                if(this.currentService == 2) {
                    menu.onReturn(false);
                } else {
                    IndexControl.QucikService_AssistTask(this.currentService, this.currentY);
                }
                this.isEnterService = false;
                menu.QuickServiceContentSwitch();
            }
        }
    };
    //往返事件
    menu.onReturn = function (isReturnEvent) {
        $log("return!!");
        var needMenuSelect = false;
        var isAction = false;
        if (video1 && $(video1).is(':visible')) {
            $("#videoContent").css("display", "none");
            $("#innerContent").css("display", "");
            this.photoisShow = true;
            video1.pause();
            isAction = true;
            needMenuSelect = true;
        }
        if (this.isEnterSnapShot){
            this.isEnterSnapShot = false;			
			$log("hardwareAccelerated close");
            $("#innerContent").append($("#landingNavbar"));
            $(".buttonOptions.subButton .navbutton").each(function(){ $(this).css("display", "none"); }).filter(".selectButton").css("display", "");
            isAction = true;
            if(needMenuSelect){
            	menu.onSelect();
            }else{
            	$(".SnapShotBox img").removeClass("floating-SnapShotItemfocused");
            }
        }
        if (this.isEnterCourseEdu){
            this.isEnterCourseEdu = false;
			$log("hardwareAccelerated close");
            $("#innerContent").append($("#landingNavbar"));
            $(".buttonOptions.subButton .navbutton").each(function(){ $(this).css("display", "none"); }).filter(".selectButton").css("display", "");
            isAction = true;
            if(needMenuSelect){
            	menu.onSelect();
            }else{
            	$(".SnapShotBox img").removeClass("floating-SnapShotItemfocused");
            }
        }
        if (this.isEnterService) {
            this.isEnterService = false;
            this.currentService = 0;
            $(".QucikServiceBox .focused").removeClass("focused");
            isAction = true;
        }
        if(this.isEnterCourse && !this.isCourseShow) {
            this.isEnterCourse = false;
            this.curretCourseY = 0;
            $("#TabPage_Course .CourseItemfocused").removeClass("CourseItemfocused");
            $(".buttonOptions.subButton .backButton").css("display", "none");
            isAction = true;
        }
        if(isReturnEvent!=false && !isAction && TVEngine.isMutipleBaby){
        	location.href = TVEngine.selectBabyUrl;
        }
    };
    //頁面與內容切換
    //Tab切換函式 負責X軸頁面切換
    menu.TabSwitch = function () {
        //所有TabPage頁面初始化-全部隱藏
        $("#TabPage_Home").css("display", "none");
        $("#TabPage_Info").css("display", "none");
        $("#TabPage_GrowChart").css("display", "none");
        $("#TabPage_Routine").css("display", "none");
        $("#TabPage_NursingPlan").css("display", "none");
        $("#TabPage_Course").css("display", "none");
        $("#playlistsNavWrapper").css("display", "none");
        $("#TabPage_QuickService").css("display", "none");
        $(".TabPage_Server").css("display", "none");
        $("#TabPage_SnapShot").css("display", "none");
        $("#TabPage_RealTimeStream").css("display", "none");
        $("#TabPage_TimeLapse").css("display", "none");

        //隱藏所有子項目功能按鈕
        var subButton = $(".buttonOptions.subButton .navbutton").each(function(){ $(this).css("display", "none"); });
        $(".welcomeMsg").css("display", "none");

        if (this.currentX == enumTabPage.Home){
        	IndexControl.HomeBox_GetActSignUpData();
        	IndexControl.HomeBox_GetAnnNews();
        	IndexControl.HomeBox_GetTaskRequestData();
            $("#TabPage_Home").css("display", "");
            $(".welcomeMsg").css("display", "");
        }else if (this.currentX == enumTabPage.Baby) {
            $("#playlistsNavWrapper").css("display", "");
            $("#playlistsNavWrapper ul").css("display", "none");
            $("#playlistsNav_myBaby").css("display", "");

            $("#TabPage_Info").css("display", "");
            //右方控制項初始化
            this.currentY = 0;
            menu.PlaylistsNavWrapperFocused();

            subButton.filter(".selectButton").css("display", "");
        }
        else if (this.currentX == enumTabPage.DailyFood) {
            $("#playlistsNavWrapper").css("display", "");
            $("#playlistsNavWrapper ul").css("display", "none");
            $("#playlistsNav_dailyFood").css("display", "");

            $("#TabPage_NursingPlan").css("display", "");
            //右方控制項初始化
            this.currentY = 5; //6
            menu.PlaylistsNavWrapperFocused();

            menu.ContentSwitch();

            $("#ImgNursingPlane").css("display", "");
            $("#HTML_Soup").css("display", "none");
            $("#HTML_Drinking").css("display", "none");

            subButton.filter(".selectButton").css("display", "");
        }

        else if (this.currentX == enumTabPage.Course){
            $("#playlistsNavWrapper").css("display", "");
            $("#playlistsNavWrapper ul").css("display", "none");
            $("#playlistsNav_activityClass").css("display", "");

            $("#TabPage_Course").css("display", "");

            //右方控制項初始化
            this.currentY = 13;
            menu.PlaylistsNavWrapperFocused();

            this.currentCourseY = 0;
            menu.CourseSwitch();

            subButton.filter(".detailButton").css("display", "");
        }

        else if (this.currentX == enumTabPage.QuickService) {
            $("#playlistsNavWrapper").css("display", "");
            $("#playlistsNavWrapper ul").css("display", "none");
            $("#playlistsNav_quickService").css("display", "");

            $("#TabPage_QuickService").css("display", "");
            //右方控制項初始化
            this.currentY = 8;
            menu.PlaylistsNavWrapperFocused();
            menu.ContentSwitch();

            subButton.filter(".selectButton").css("display", "");
        }
        else if (this.currentX == enumTabPage.Server)
            $(".TabPage_Server").css("display", "");

        menu.onReturn(false);

    };
    //內容切換Y軸
    menu.ContentSwitch = function () {
        $log("ContentSwitch");
        //初始化 所有內容頁面隱藏
        $("#TabPage_Home").css("display", "none");
        $("#TabPage_Info").css("display", "none");
        $("#TabPage_GrowChart").css("display", "none");
        $("#TabPage_Routine").css("display", "none");
        $("#TabPage_NursingPlan").css("display", "none");
        $("#TabPage_Course").css("display", "none");
        $("#playlistsNavWrapper").css("display", "none");
        $("#TabPage_QuickService").css("display", "none");
        $(".TabPage_Server").css("display", "none");
        $("#TabPage_SnapShot").css("display", "none");
        $("#TabPage_RealTimeStream").css("display", "none");
        $("#TabPage_TimeLapse").css("display", "none");

        if (this.currentX == enumTabPage.Home) {
            $("#TabPage_Home").css("display", "");
        }
        if (this.currentX == enumTabPage.Baby) {
            $("#playlistsNavWrapper").css("display", "");
            this.babyInfoContentSwitch();
        }
        else if (this.currentX == enumTabPage.DailyFood) {
            $("#playlistsNavWrapper").css("display", "");
            $("#TabPage_NursingPlan").css("display", "");
            this.DailyFoodContentSwitch();
        }
        else if (this.currentX == enumTabPage.Course){
            $("#playlistsNavWrapper").css("display", "");
            $("#TabPage_Course").css("display", "");
        }
		/*
        else if (this.currentX == enumTabPage.QuickService)
            $("#TabPage_QuickService").css("display", "");
			*/
        else if (this.currentX == enumTabPage.QuickService) {
            $("#playlistsNavWrapper").css("display", "");
            $("#TabPage_QuickService").css("display", "");
            this.QuickServiceContentSwitch();
        }

        else if (this.currentX == enumTabPage.Server)
            $(".TabPage_Server").css("display", "");
    };
    //寶寶資訊內容切換
    menu.babyInfoContentSwitch = function () {
        if (this.currentY == 0)
            $("#TabPage_Info").css("display", "");
        /*else if (this.currentY == 1)
            this.isEnterBabyRecord = true;
		*/
        else if (this.currentY == 1){
            $("#TabPage_GrowChart").css("display", "");
            IndexControl.MyBaby_CreateGrowChart();
        }else if (this.currentY == 2){
            $("#TabPage_Routine").css("display", "");
        	IndexControl.MyBaby_CreateMilkChart();
        }else if (this.currentY == 3)
            $("#TabPage_SnapShot").css("display", "");
        else if (this.currentY == 4)
            $("#TabPage_TimeLapse").css("display", "");

    };
    //幸福剪影控制
    menu.EnterSnapshotControl = function () {
        var self = this;
        var box = $(".SnapShotBox");
        var max = 6;
        var totalPage = Math.ceil(IndexControl.MyBaby_SnapShotData.length / max);
        
        if (self.PressEvent == enumKeyboardPress.Up) {

            self.currentSnapshot--;
            if(self.currentSnapshot < 0) {
                if(self.currentSnapshotPage <= totalPage && self.currentSnapshotPage != 1 && totalPage > 1) {
                    IndexControl.MyBaby_GetSnapShotChangePage(--self.currentSnapshotPage);//換上一頁
                    self.currentSnapshot = 5;
                } else {
                    if(totalPage > 1) { //若不止一頁，則跳至最後頁
                        self.currentSnapshotPage = totalPage;
                        IndexControl.MyBaby_GetSnapShotChangePage(self.currentSnapshotPage);
                        max = box.find("div:has(img)").length;
                    }
                    self.currentSnapshot = max - 1;
                }
            }

        } else if (self.PressEvent == enumKeyboardPress.Down) {

            self.currentSnapshot++;
            if(self.currentSnapshot > max - 1) {
                if(self.currentSnapshotPage != totalPage){ //若不是在最後一頁
                    IndexControl.MyBaby_GetSnapShotChangePage(++self.currentSnapshotPage);//換下一頁
                    self.currentSnapshot = 0;
                } else {
                    //載入第一頁
                    self.currentSnapshot = -1;
                    self.currentSnapshotPage = 1;
                    IndexControl.MyBaby_GetSnapShotChangePage(self.currentSnapshotPage); //回到第一頁
                    self.isEnterSnapShot = false;
                    self.onDown();
                }
            }
        }
        // $log("currentSnapshot\t" + self.currentSnapshot + "\tcurrentSnapshotPage\t" + self.currentSnapshotPage);
        box.find(".floating-SnapShotItemfocused").removeClass("floating-SnapShotItemfocused");
        if(self.isEnterSnapShot) {
            box.find("#box" + self.currentSnapshot + " img").addClass("floating-SnapShotItemfocused");
        }

    };
    //衛教課程控制
    menu.EnterCourseEduControl = function () {
    	
        var self = this;
        var box = $(".Courselists");
        var max = box.find(".SnapShotBox div:has(img)").length;
        var totalPage = Math.ceil(IndexControl.Course_educationData.length / 6);
        if (self.PressEvent == enumKeyboardPress.Up) {

            self.currentCourseEdu--;
            if(self.currentCourseEdu < 0) {
                if(self.currentCourseEduPage <= totalPage && self.currentCourseEduPage != 1 && totalPage > 1) {
                    IndexControl.Course_education(--self.currentCourseEduPage);//換上一頁
                    self.currentCourseEdu = 5;
                } else {
                    if(totalPage > 1) { //若不止一頁，則跳至最後頁
                        self.currentCourseEduPage = totalPage;
                        IndexControl.Course_education(self.currentCourseEduPage);
                        max = box.find(".SnapShotBox div:has(img)").length;
                    }
                    self.currentCourseEdu = max - 1;
                }
            }

        } else if (self.PressEvent == enumKeyboardPress.Down) {
            self.currentCourseEdu++;
            if(self.currentCourseEdu > max - 1) {
                if(self.currentCourseEduPage != totalPage){ //若不是在最後一頁
                    IndexControl.Course_education(++self.currentCourseEduPage);//換下一頁
                    self.currentCourseEdu = 0;
                } else {
                    //載入第一頁
                    self.currentCourseEdu = -1;
                    self.currentCourseEduPage = 1;
                    IndexControl.Course_education(self.currentCourseEduPage); //回到第一頁
                    self.isEnterCourseEdu = false;
                    self.onDown();
                }
            }
        }
        // $log("currentSnapshot\t" + self.currentSnapshot + "\tcurrentSnapshotPage\t" + self.currentSnapshotPage);
        box.find(".floating-SnapShotItemfocused").removeClass("floating-SnapShotItemfocused");
        if(self.isEnterCourseEdu) {
            box.find("#ei" + self.currentCourseEdu + " img").addClass("floating-SnapShotItemfocused");
        }
    };
    //快速服務控制
    menu.QuickServiceContentSwitch = function () {
        var boxItem = $(".QucikServiceBox div");
        var backButton = $(".buttonOptions.subButton .navbutton.backButton");
        $log("QuickServiceContentSwitch\tcurrentService:\t" + this.currentService + "\tcurrentY\t" + this.currentY);

        boxItem.filter(".focused").removeClass("focused");
        if(!this.isEnterService) {
            //右側選單漸變
            menu.PlaylistsNavWrapperFocused();

            var item = boxItem.not("#ContactService, #ExitService").each(function() {
                $(this).css("display", "none");
            });

            item.eq(this.currentY - 8).css("display", "");
            backButton.css("display", "none");

        } else {
            boxItem.filter(":visible:eq(" + this.currentService + ")").addClass("focused");

            backButton.css("display", "");
        }

    };

    //課程方格選擇切換
    menu.CourseSwitch = function () {

    	//console.log("test-menu.CourseSwitch");
        //IndexControl.Course_GetCourseData(function(){
        	$(".Courselists").empty();
        	if (typeof IndexControl != 'undefined') IndexControl.Course_ChangeCourseList(menu.currentY, menu.currentCourseEduPage);
        	$(".CourseItemfocused").eq(0).removeClass("CourseItemfocused");
            if(menu.isEnterCourse) {
                $(".CourseItem").eq(menu.currentCourseY).addClass("CourseItemfocused");
            }
        //});
        
    };
    //課程內容參加、離開按鈕選擇切換
    menu.CourseButtonSwitch = function () {
        //假設僅有確認參加與離開按鈕
        if (this.courseButtonIndex == 0) {
            //"確認參加"目前被鎖定
            $("#courseConfirmFocused").attr("id", "courseConfirm");
            $("#courseExit").attr("id", "courseExitFocused");
            this.courseButtonIndex = 1;
        } else {
            //"離開"目前被鎖定
            $("#courseConfirm").attr("id", "courseConfirmFocused");
            $("#courseExitFocused").attr("id", "courseExit");
            this.courseButtonIndex = 0;
        }
    };
    //今日膳食控制
    menu.DailyFoodContentSwitch = function () {
        //右側選單漸變
        menu.PlaylistsNavWrapperFocused();

        $("#HTML_Menu").css("display", "none");
        $("#HTML_Soup").css("display", "none");
        $("#HTML_Drinking").css("display", "none");
        if (this.currentY == 5)
            $("#HTML_Menu").css("display", "");
        else if (this.currentY == 6)
            $("#HTML_Soup").css("display", "");
        else if (this.currentY == 7)
            $("#HTML_Drinking").css("display", "");
    };

	//按鈕選取樣式控制
	menu.PlaylistsNavWrapperFocused = function() {
        // $log("PlaylistsNavWrapperFocused\tcurrentY\t" + this.currentY);
		if($("#playlistsNavWrapper li.focused").length > 0){
			$("#playlistsNavWrapper li.focused img").prop("src", $("#playlistsNavWrapper li.focused img").prop("src").replace("_chk", ""));
			$("#playlistsNavWrapper li").removeClass("focused");
		}

		$("#playlistsNavWrapper li:eq(" + this.currentY + ")").addClass("focused");
		$("#playlistsNavWrapper li.focused img").prop("src", $("#playlistsNavWrapper li.focused img").prop("src").replace(/(\.(jpg|png))$/, "_chk$1"));
	};

    menu.defaultMenu = true;
    TVEngine.Navigation.addMenu(menu);
})(TVEngine);
