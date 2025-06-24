/*
**20170104 Edited by Guan-An
*/
(function (TVEngine) {
    var menu = new TVEngine.Navigation.Menu();
    menu.menuHandlesEvents();
    menu.currentY = 0;
    menu.currentXs = [];
    menu.currentX = 0;
    menu.name = "brightcove:mainmenu";
    menu.curretCourseY = 0;//控制Y軸
    menu.currentServicePage = 0;//紀錄快速服務當前頁面
    menu.currentService = 0;//紀錄快速服務選取項次
    menu.isEnterService = false;//判斷是否已按下進入快速服務次選單
    menu.currentServicePageItem = 0;
    menu.photoisShow = false;
    menu.currentSnapshot = 0;
    menu.isEnterSnapShot = false;
    menu.isCourseShow = false;
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
    var enumMyBabyTitle = {
        Info: 0,
        BabyRecord: 1,
        FeedStatus:2,
        Excretion: 3,
        GrowTrend:4,
        RestStatus: 5,
        SnapShot: 6,
        Timelapse: 7
    };
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
    }

    //回傳縱軸功能列個數
    menu.getVerticalMax = function () {
        if (this.currentX == 1)
            return 7;
        else (this.currentX == 2)
        return 2;
    }
    //遙控器控制事件
    menu.onUp = function () {
        this.PressEvent = enumKeyboardPress.Up;
        if (this.currentX == enumTabPage.Course) {
            if (!this.isCourseShow) {
                if (this.curretCourseY == 0)
                    this.curretCourseY = $(".Courselists li").length - 1;
                else
                    this.curretCourseY--;
                menu.CourseSwitch();
            }
            else (this.isCourseShow)
                menu.CourseButtonSwitch();
        }
        else if (this.currentX == enumTabPage.Baby && this.currentY == enumMyBabyTitle.SnapShot && this.isEnterSnapShot) 
            this.EnterSnapshotControl();
		/*
        else if (this.currentX == enumTabPage.QuickService)
            this.QuickServiceControl();
		*/
        else if (this.currentX == enumTabPage.QuickService) {
            if (this.currentY > 8) { 
                this.currentY--;
                this.QuickServiceContentSwitch();
            }
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
            })
            menu.ContentSwitch();
        }

    }
    //遙控器向下控制
    menu.onDown = function () {
        this.PressEvent = enumKeyboardPress.Down;
        if (this.currentX == enumTabPage.Course) {
            if (!this.isCourseShow) {
                if (this.curretCourseY == $(".Courselists li").length - 1)
                    this.curretCourseY = 0;
                else
                    this.curretCourseY++;
                menu.CourseSwitch();
            }
            else (this.isCourseShow)
            {
                menu.CourseButtonSwitch();
            }

        }
        else if (this.currentX == enumTabPage.Baby && this.currentY == 4 && this.isEnterSnapShot) {
            this.EnterSnapshotControl();
        }
		
		
        else if (this.currentX == enumTabPage.QuickService) {
            if (this.currentY < 12) {
                this.currentY++;
                menu.ContentSwitch();
            }			
			/*2017.03.05
            if (!this.isEnterService) {
                // 五格
                $(".floating-Serviceboxfocused").addClass("floating-Servicebox");
                $(".floating-Serviceboxfocused").removeClass("floating-Serviceboxfocused");
                if (this.currentService == 3)
                    this.currentService = 1;
                else if (this.currentService == 4)
                    this.currentService = 2;
                else if (this.currentService == 2) {
                    this.currentService = 0;
                    this.isEnterService = false;
                }
                else
                    this.currentService += 3;
                $(".ServiceBox div").eq(this.currentService).addClass("floating-Serviceboxfocused");
                $(".ServiceBox div").eq(this.currentService).removeClass("floating-Servicebox");
            }
            else {
                if (this.currentServicePageItem < 6 && (this.currentServicePageItem + $(".ServiceSubPageItemHide").length) < 4) {
                    $(".ServiceSubPageItemfocused").removeClass('ServiceSubPageItemfocused');
                    this.currentServicePageItem++;
                    $(".ServiceSubPageItem").eq(this.currentServicePageItem).addClass('ServiceSubPageItemfocused');
                }
                else if (this.currentServicePageItem + $(".ServiceSubPageItemHide").length == 4) {
                    $(".ServiceSubPageItemfocused").removeClass('ServiceSubPageItemfocused');
                    this.currentServicePageItem = 5;
                    $(".ServiceSubPageItem").eq(this.currentServicePageItem).addClass('ServiceSubPageItemfocused');
                }
                else {
                    $(".ServiceSubPageItemfocused").attr('class', 'ServiceSubPageItem');
                    this.currentServicePageItem = 0;
                    $(".ServiceSubPageItem").eq(0).addClass('ServiceSubPageItemfocused');
                }

            }
			*/


            /*
                        //第二版 多格變形
                        //捲動前一頁方格			
                        $(".floating-Serviceboxfocused").addClass("floating-Servicebox");
                        $(".floating-Serviceboxfocused").removeClass("floating-Serviceboxfocused");
                        if((this.currentService-3)%6==0)
                            this.currentService=(1+6*this.currentServicePage);
                        else if((this.currentService-4)%6==0)
                            this.currentService=(2+6*this.currentServicePage);
                        else if((this.currentService-5)%6==0||(this.currentService-5)==0)
                        {
                            if(this.currentServicePage<this.ServicePage)
                            {
                                this.currentServicePage++;
                                this.currentService++;
                                for(var i=0; i<=this.currentServicePage-1;i++){
                                    for(var y=0; y<=8;y++)
                                    {
                                        $(".ServiceBox div").eq(y).css('display','none');
                                        $(".ServiceBox div").eq(this.currentServicePage*9+y).css('display','');
                                    }
                                }
                            }
                                
                            else
                                this.currentService=0;
                        }			
                        else
                            this.currentService+=3;
                        $(".ServiceBox div").eq(this.currentService).addClass("floating-Serviceboxfocused");
                        $(".ServiceBox div").eq(this.currentService).removeClass("floating-Servicebox");
                        */
        }
        else if (this.currentX == enumTabPage.DailyFood) {
            if (this.currentY < 8) {
                this.currentY++;
                menu.ContentSwitch();
            }
        }
        else if (this.currentX == enumTabPage.Baby) {
            if (this.currentY < 5) {
                this.currentY++;
                
                $("#playlistsNav").animate({
                    top: -(this.currentY * $("#playlistsNav li:first").outerHeight(true))
                }, null, null, function () {
                    $("#playicon").fadeIn(300);
                });
                this.currentXs[this.currentY] = 0;
                
                menu.PlaylistsNavWrapperFocused();
                
                menu.ContentSwitch();
            }
        }


    }
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
    }
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
    }
    //確認事件
    menu.onSelect = function () {
        $log(" ON SELECT CALLED ! ");
        var video1 = document.getElementById("video1");

        if (this.currentX == enumTabPage.Baby && this.currentY == 4 && !this.isEnterSnapShot)
            this.isEnterSnapShot = true;
        else if (this.isEnterSnapShot && video1.paused) {
            $("#videoContent").css('display', '');
            $("#videoContent").css('autoplay', 'autoplay');
            $("#innerContent").css('display', 'none');
            video1.currentTime = 0;
            video1.play();
        }
        else if (this.currentX == enumTabPage.Baby && this.currentY == 1 && this.isEnterBabyRecord) {
            this.isEnterBabyRecord = false;
            var milk = prompt("請輸入寶寶奶量(若無，請輸入0):");
            var popo = prompt("請輸入寶寶便量(若無，請輸入0):");
            if (milk != "" || popo != "")
                alert("已為您紀錄");
        }
        else if (this.currentX == enumTabPage.Course && !this.isCourseShow) {
            this.isCourseShow = true;
            $(".courseContent").css('display', '');
            $(".Courselists").css('display', 'none');
            this.courseButtonIndex = 0;
        }
        else if (this.currentX == enumTabPage.Course && this.isCourseShow) {
            this.isCourseShow = false;
            if (this.courseButtonIndex == 0)
                alert("報名成功\n已為您送出課程活動登記");
            $(".courseContent").css('display', 'none');
            $(".Courselists").css('display', '');

        }
        else if (this.currentX == enumTabPage.QuickService) {

            if (!this.isEnterService) {
                $(".ServiceSubPageItemfocused").removeClass("ServiceSubPageItemfocused");
                this.isEnterService = true;
                $(".ServiceSubPage").css('display', '');
                $(".ServiceSubPageItem").eq(0).removeClass("ServiceSubPageItemHide");
                $(".ServiceSubPageItem").eq(1).removeClass("ServiceSubPageItemHide");
                $(".ServiceSubPageItem").eq(2).removeClass("ServiceSubPageItemHide");
                $(".ServiceSubPageItem").eq(3).removeClass("ServiceSubPageItemHide");
                $(".ServiceSubPageItem").eq(4).addClass('ServiceSubPageItemHide');


                switch (this.currentService) {
                    case 0:
                        $(".ServiceSubPageItem").eq(0).text("推送寶寶");
                        $(".ServiceSubPageItem").eq(1).text("請聯絡我");
                        $(".ServiceSubPageItem").eq(2).addClass('ServiceSubPageItemHide');
                        $(".ServiceSubPageItem").eq(3).addClass('ServiceSubPageItemHide');
                        $(".ServiceSubPageItem").eq(4).addClass('ServiceSubPageItemHide');
                        break;

                    case 3:
                        $(".ServiceSubPageItem").eq(0).text("乳腺疏通");
                        $(".ServiceSubPageItem").eq(1).text("請聯絡我");
                        $(".ServiceSubPageItem").eq(2).addClass('ServiceSubPageItemHide');
                        $(".ServiceSubPageItem").eq(3).addClass('ServiceSubPageItemHide');
                        $(".ServiceSubPageItem").eq(4).addClass('ServiceSubPageItemHide');
                        break;

                    case 1:
                        $(".ServiceSubPageItem").eq(0).text("房間清潔");
                        $(".ServiceSubPageItem").eq(1).text("更換床單");
                        $(".ServiceSubPageItem").eq(2).text("補充過濾水");
                        $(".ServiceSubPageItem").eq(3).addClass('ServiceSubPageItemHide');
                        $(".ServiceSubPageItem").eq(4).addClass('ServiceSubPageItemHide');
                        break;

                    case 4:
                        $(".ServiceSubPageItem").eq(0).text("請送餐點");
                        $(".ServiceSubPageItem").eq(1).text("飲品加量");
                        $(".ServiceSubPageItem").eq(2).text("請聯絡我");
                        $(".ServiceSubPageItem").eq(3).addClass('ServiceSubPageItemHide');
                        $(".ServiceSubPageItem").eq(4).addClass('ServiceSubPageItemHide');
                        break;

                    case 2:
                        $(".ServiceSubPageItem").eq(0).text("燈不亮");
                        $(".ServiceSubPageItem").eq(1).text("空調問題");
                        $(".ServiceSubPageItem").eq(2).text("電視影像");
                        $(".ServiceSubPageItem").eq(3).text('網路問題');
                        $(".ServiceSubPageItem").eq(4).text('請聯絡我');
                        break;

                    default:
                        $(".ServiceSubPageItem").eq(0).addClass('ServiceSubPageItemHide');
                        $(".ServiceSubPageItem").eq(1).addClass('ServiceSubPageItemHide');
                        $(".ServiceSubPageItem").eq(2).addClass('ServiceSubPageItemHide');
                        $(".ServiceSubPageItem").eq(3).addClass('ServiceSubPageItemHide');
                        $(".ServiceSubPageItem").eq(4).addClass('ServiceSubPageItemHide');
                        break;
                }
                $
                this.currentServicePageItem = 0;
                $(".ServiceSubPageItem").eq(0).addClass('ServiceSubPageItemfocused');
            }
            else if (this.isEnterService) {
                if ($(".ServiceSubPageItemfocused").text() != "離開")
                    alert("填單成功\該服務已登記");
                this.isEnterService = false;
                $(".ServiceSubPage").css('display', 'none');
            }
        }



    }
    //往返事件
    menu.onReturn = function () {
        if (!video1.paused) {
            $("#videoContent").css('display', 'none');
            $("#innerContent").css('display', '');
            this.photoisShow = true;
            video1.pause();
        }
        else if (this.isEnterSnapShot)
            this.isEnterSnapShot = false;
    }
    //頁面與內容切換
    //Tab切換函式 負責X軸頁面切換
    menu.TabSwitch = function () {
        //所有TabPage頁面初始化-全部隱藏
        $("#TabPage_Home").css('display', "none");
        $("#TabPage_Info").css('display', "none");
        $("#TabPage_GrowChart").css("display", "none");
        $("#TabPage_Routine").css("display", "none");
        $("#TabPage_NursingPlan").css('display', 'none');
        $("#TabPage_Course").css('display', 'none');
        $("#playlistsNavWrapper").css('display', 'none');
        $("#TabPage_QuickService").css('display', 'none')
        $(".TabPage_Server").css('display', 'none')
        $("#TabPage_SnapShot").css('display', "none");
        $("#TabPage_RealTimeStream").css('display', "none");
        $("#TabPage_TimeLapse").css('display', "none");

        if (this.currentX == enumTabPage.Home)
            $("#TabPage_Home").css('display', "");
        else if (this.currentX == enumTabPage.Baby) {
            $("#playlistsNavWrapper").css('display', '');
            $("#playlistsNavWrapper ul").css('display', 'none');
            $("#playlistsNav_myBaby").css('display', '');

            $("#TabPage_Info").css('display', "");
            //右方控制項初始化
            this.currentY = 0;
            menu.PlaylistsNavWrapperFocused();

        }
        else if (this.currentX == enumTabPage.DailyFood) {
            $("#playlistsNavWrapper").css('display', '');
            $("#playlistsNavWrapper ul").css('display', 'none');
            $("#playlistsNav_dailyFood").css('display', '');
			
            $("#TabPage_NursingPlan").css('display', "");
            //右方控制項初始化
            this.currentY = 5; //6
            menu.PlaylistsNavWrapperFocused();
            
            $("#ImgNursingPlane").css('display', '');
            $("#HTML_Soup").css('display', 'none');
            $("#HTML_Drinking").css('display', 'none');
        }
		
        else if (this.currentX == enumTabPage.Course)
            $("#TabPage_Course").css('display', "");
		/*
        else if (this.currentX == enumTabPage.QuickService) {
            $(".floating-Serviceboxfocused").addClass('floating-Servicebox').removeClass('floating-Serviceboxfocused');
            this.currentService = 0;
            $(".floating-Servicebox").eq(0).addClass('floating-Serviceboxfocused').removeClass('floating-Servicebox');
            $(".TabPage_QuickService").css('display', '');
        }
		*/
        else if (this.currentX == enumTabPage.QuickService) {
            $("#playlistsNavWrapper").css('display', '');
            $("#playlistsNavWrapper ul").css('display', 'none');
            $("#playlistsNav_quickService").css('display', '');
           		
            $("#TabPage_NursingPlan").css('display', "");
            //右方控制項初始化
            this.currentY = 8; 
            menu.PlaylistsNavWrapperFocused();
            
            $("#HTML_Menu").css('display', 'none');
            $("#HTML_Soup").css('display', 'none');
            $("#HTML_Drinking").css('display', 'none');
      
            $("#HTML_Soup2").css('display', 'none');
            $("#HTML_Drinking2").css('display', 'none');			
        }		
        else if (this.currentX == enumTabPage.Server)
            $(".TabPage_Server").css('display', '');

    }
    //內容切換Y軸
    menu.ContentSwitch = function () {
        //初始化 所有內容頁面隱藏
        $("#TabPage_Home").css('display', "none");
        $("#TabPage_Info").css('display', "none");
        $("#TabPage_GrowChart").css("display", "none");
        $("#TabPage_Routine").css("display", "none");
        $("#TabPage_NursingPlan").css('display', 'none');
        $("#TabPage_Course").css('display', 'none');
        $("#playlistsNavWrapper").css('display', 'none');
        $("#TabPage_QuickService").css('display', 'none')
        $(".TabPage_Server").css('display', 'none')
        $("#TabPage_SnapShot").css('display', "none");
        $("#TabPage_RealTimeStream").css('display', "none");
        $("#TabPage_TimeLapse").css('display', "none");

        if (this.currentX == enumTabPage.Home) {
            $("#TabPage_Home").css('display', "");
        }
        if (this.currentX == enumTabPage.Baby) {
            $("#playlistsNavWrapper").css('display', '');
            this.babyInfoContentSwitch();
        }
        else if (this.currentX == enumTabPage.DailyFood) {
            $("#playlistsNavWrapper").css('display', '');
            $("#TabPage_NursingPlan").css('display', '');
            this.DailyFoodContentSwitch();
        }
        else if (this.currentX == enumTabPage.Course)
            $("#TabPage_Course").css('display', "");
		/*
        else if (this.currentX == enumTabPage.QuickService) 
            $(".TabPage_QuickService").css('display', '');
			*/
        else if (this.currentX == enumTabPage.QuickService) {
            $("#playlistsNavWrapper").css('display', '');
            $("#TabPage_QuickService").css('display', '');
            this.QuickServiceContentSwitch();
        }		
		
        else if (this.currentX == enumTabPage.Server) 
            $(".TabPage_Server").css('display', '');   
    }
    //寶寶資訊內容切換
    menu.babyInfoContentSwitch = function () {
        if (this.currentY == 0)
            $("#TabPage_Info").css('display', "");
        /*else if (this.currentY == 1)
            this.isEnterBabyRecord = true;
		*/
        else if (this.currentY == 1)
            $("#TabPage_GrowChart").css('display', "");
        else if (this.currentY == 2)
            $("#TabPage_Routine").css('display', "");
        else if (this.currentY == 3)
            $("#TabPage_SnapShot").css('display', "");
        else if (this.currentY == 4)
            $("#TabPage_TimeLapse").css('display', "");

    }
    //幸福剪影控制
    menu.EnterSnapshotControl = function () {
        //第一版 六格控制法
        $(".floating-SnapShotItemfocused").addClass("floating-SnapShotItem");
        $(".floating-SnapShotItemfocused").removeClass("floating-SnapShotItemfocused");
        $(".lb-image").eq(this.currentSnapshot).css('display', 'none');
        if (this.PressEvent == enumKeyboardPress.Up)
        {
            if (this.currentSnapshot == 1)
                this.currentSnapshot = 3;
            else if (this.currentSnapshot == 2)
                this.currentSnapshot = 4;
            else if (this.currentSnapshot == 0)
                this.currentSnapshot = 5;
            else
                this.currentSnapshot -= 3;
        }
        else if (this.PressEvent == enumKeyboardPress.Down)
        {
            $(".floating-SnapShotItemfocused").addClass("floating-SnapShotItem");
            $(".floating-SnapShotItemfocused").removeClass("floating-SnapShotItemfocused");
            $(".lb-image").eq(this.currentSnapshot).css('display', 'none');
            if (this.currentSnapshot == 3)
                this.currentSnapshot = 1;
            else if (this.currentSnapshot == 4)
                this.currentSnapshot = 2;
			
            else if (this.currentSnapshot == 5) {
                this.currentSnapshot = 0;
                this.isEnterSnapShot = false;
            }
            else
                this.currentSnapshot += 3;
        }
        $(".SnapShotBox img").eq(this.currentSnapshot).addClass("floating-SnapShotItemfocused");
        $(".SnapShotBox img").eq(this.currentSnapshot).removeClass("floating-SnapShotItem");
        $(".lb-image").eq(this.currentSnapshot).css('display', 'block');
    }
    //快速服務控制	   
    menu.QuickServiceContentSwitch = function () {
        //右側選單漸變
        menu.PlaylistsNavWrapperFocused();
        
        $("#SERVICE_BabyRoom").css('display', 'none');
        $("#HTML_Soup").css('display', 'none');
        $("#HTML_Drinking").css('display', 'none');
        $("#HTML_Soup2").css('display', 'none');
        $("#HTML_Drinking2").css('display', 'none');		
        if (this.currentY == 8)
            $("#SERVICE_BabyRoom").css('display', '')
        else if (this.currentY == 9)
            $("#HTML_Soup").css('display', '')
        else if (this.currentY == 10)
            $("#HTML_Drinking").css('display', '')
        else if (this.currentY == 11)
            $("#HTML_Soup2").css('display', '')
        else if (this.currentY == 12)
            $("#HTML_Drinking2").css('display', '')			
    }
	/*
    menu.QuickServiceControl = function () {
        if (!this.isEnterService) {
            $(".floating-Serviceboxfocused").addClass("floating-Servicebox");
            $(".floating-Serviceboxfocused").removeClass("floating-Serviceboxfocused");
            if (this.currentService == 1)
                this.currentService = 3;
            else if (this.currentService == 2)
                this.currentService = 4;
            else if (this.currentService == 0)
                this.currentService = 2;
            else
                this.currentService -= 3;
            $(".ServiceBox div").eq(this.currentService).addClass("floating-Serviceboxfocused");
            $(".ServiceBox div").eq(this.currentService).removeClass("floating-Servicebox");
        }
        else {
            if (this.currentServicePageItem > 0 && this.currentServicePageItem != 5) {
                $(".ServiceSubPageItemfocused").removeClass('ServiceSubPageItemfocused');
                this.currentServicePageItem--;
                $(".ServiceSubPageItem").eq(this.currentServicePageItem).addClass('ServiceSubPageItemfocused');
            }
            else if (this.currentServicePageItem == 0) {
                $(".ServiceSubPageItemfocused").removeClass('ServiceSubPageItemfocused');
                this.currentServicePageItem = 5;
                $(".ServiceSubPageItem").eq(this.currentServicePageItem).addClass('ServiceSubPageItemfocused');
            }
            else if (this.currentServicePageItem == 5) {
                $(".ServiceSubPageItemfocused").removeClass('ServiceSubPageItemfocused');
                this.currentServicePageItem -= $(".ServiceSubPageItemHide").length;
                this.currentServicePageItem--;
                $(".ServiceSubPageItem").eq(this.currentServicePageItem).addClass('ServiceSubPageItemfocused');
            }
        }

    }
	*/
	
	
    //課程方格選擇切換
    menu.CourseSwitch = function () {

        //移除所有focused items		
        $(".CourseItemfocused").eq(0).addClass("CourseItem");
        $(".CourseItemfocused").eq(0).removeClass("CourseItemfocused");

        $(".CourseItem").eq(this.curretCourseY).addClass("CourseItemfocused");
        $(".CourseItem").eq(this.curretCourseY).removeClass("CourseItem");
    }
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
    }
    //今日膳食控制
    menu.DailyFoodContentSwitch = function () {
        //右側選單漸變
        menu.PlaylistsNavWrapperFocused();
        
        $("#HTML_Menu").css('display', 'none');
        $("#HTML_Soup").css('display', 'none');
        $("#HTML_Drinking").css('display', 'none');
        if (this.currentY == 5)
            $("#HTML_Menu").css('display', '')
        else if (this.currentY == 6)
            $("#HTML_Soup").css('display', '')
        else if (this.currentY == 7)
            $("#HTML_Drinking").css('display', '')
    }
	
	//按鈕選取樣式控制
	menu.PlaylistsNavWrapperFocused = function() {
		if($("#playlistsNavWrapper li.focused").length > 0)
		{
			$("#playlistsNavWrapper li.focused img").prop('src', $("#playlistsNavWrapper li.focused img").prop('src').replace('_chk', ''));
			$("#playlistsNavWrapper li").removeClass("focused");
		}
		
		$("#playlistsNavWrapper li:eq(" + this.currentY + ")").addClass("focused");
		$("#playlistsNavWrapper li.focused img").prop('src', $("#playlistsNavWrapper li.focused img").prop('src').replace('.jpg', '_chk.jpg'));
	}

    menu.defaultMenu = true;
    TVEngine.Navigation.addMenu(menu);
})(TVEngine);