var _SlideshowTransitionC = {};
        var _SlideshowTransitionCodes = {};
        var _SlideshowTransitions = [];

        //---- Float Transitions -----
        {

            _SlideshowTransitionC["Float Right Random"] = { $Duration: 500, x: -1, $Delay: 40, $Cols: 10, $Rows: 5, $SlideOut: true, $Easing: { $Left: $Jease$.$InCubic, $Opacity: $Jease$.$OutQuad }, $Opacity: 2 };
            _SlideshowTransitionCodes["Float Right Random"] = "{$Duration:500,x:-1,$Delay:40,$Cols:10,$Rows:5,$SlideOut:true,$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$OutQuad},$Opacity:2}";

            _SlideshowTransitionC["Float up Random"] = { $Duration: 500, y: 1, $Delay: 40, $Cols: 10, $Rows: 5, $SlideOut: true, $Easing: { $Top: $Jease$.$InCubic, $Opacity: $Jease$.$OutQuad }, $Opacity: 2 };
            _SlideshowTransitionCodes["Float up Random"] = "{$Duration:500,y:1,$Delay:40,$Cols:10,$Rows:5,$SlideOut:true,$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$OutQuad},$Opacity:2}";

            _SlideshowTransitionC["Float up Random with Chess"] = { $Duration: 500, x: 1, y: -1, $Delay: 40, $Cols: 10, $Rows: 5, $SlideOut: true, $ChessMode: { $Column: 3, $Row: 12 }, $Easing: { $Left: $Jease$.$InCubic, $Top: $Jease$.$InCubic, $Opacity: $Jease$.$OutQuad }, $Opacity: 2 };
            _SlideshowTransitionCodes["Float up Random with Chess"] = "{$Duration:500,x:1,y:-1,$Delay:40,$Cols:10,$Rows:5,$SlideOut:true,$ChessMode:{$Column:3,$Row:12},$Easing:{$Left:$Jease$.$InCubic,$Top:$Jease$.$InCubic,$Opacity:$Jease$.$OutQuad},$Opacity:2}";

            _SlideshowTransitionC["Float Right ZigZag"] = { $Duration: 600, x: -1, $Delay: 12, $Cols: 10, $Rows: 5, $SlideOut: true, $Formation: $JssorSlideshowFormations$.$FormationZigZag, $Assembly: 513, $Easing: { $Left: $Jease$.$InCubic, $Opacity: $Jease$.$OutQuad }, $Opacity: 2 };
            _SlideshowTransitionCodes["Float Right ZigZag"] = "{$Duration:600,x:-1,$Delay:12,$Cols:10,$Rows:5,$SlideOut:true,$Formation:$JssorSlideshowFormations$.$FormationZigZag,$Assembly:513,$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$OutQuad},$Opacity:2}";

            _SlideshowTransitionC["Float up ZigZag"] = { $Duration: 600, y: 1, $Delay: 12, $Cols: 10, $Rows: 5, $SlideOut: true, $Formation: $JssorSlideshowFormations$.$FormationZigZag, $Assembly: 264, $Easing: { $Top: $Jease$.$InCubic, $Opacity: $Jease$.$OutQuad }, $Opacity: 2 };
            _SlideshowTransitionCodes["Float up ZigZag"] = "{$Duration:600,y:1,$Delay:12,$Cols:10,$Rows:5,$SlideOut:true,$Formation:$JssorSlideshowFormations$.$FormationZigZag,$Assembly:264,$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$OutQuad},$Opacity:2}";

            _SlideshowTransitionC["Float up ZigZag with Chess"] = { $Duration: 600, x: -1, y: -1, $Delay: 12, $Cols: 10, $Rows: 5, $SlideOut: true, $Formation: $JssorSlideshowFormations$.$FormationZigZag, $Assembly: 1028, $ChessMode: { $Column: 3, $Row: 12 }, $Easing: { $Left: $Jease$.$InCubic, $Top: $Jease$.$InCubic, $Opacity: $Jease$.$OutQuad }, $Opacity: 2 };
            _SlideshowTransitionCodes["Float up ZigZag with Chess"] = "{$Duration:600,x:-1,y:-1,$Delay:12,$Cols:10,$Rows:5,$SlideOut:true,$Formation:$JssorSlideshowFormations$.$FormationZigZag,$Assembly:1028,$ChessMode:{$Column:3,$Row:12},$Easing:{$Left:$Jease$.$InCubic,$Top:$Jease$.$InCubic,$Opacity:$Jease$.$OutQuad},$Opacity:2}";

            _SlideshowTransitionC["Float Right Swirl"] = { $Duration: 600, x: -1, $Delay: 12, $Cols: 10, $Rows: 5, $SlideOut: true, $Reverse: true, $Formation: $JssorSlideshowFormations$.$FormationSwirl, $Assembly: 513, $Easing: { $Left: $Jease$.$InCubic, $Opacity: $Jease$.$OutQuad }, $Opacity: 2 };
            _SlideshowTransitionCodes["Float Right Swirl"] = "{$Duration:600,x:-1,$Delay:12,$Cols:10,$Rows:5,$SlideOut:true,$Reverse:true,$Formation:$JssorSlideshowFormations$.$FormationSwirl,$Assembly:513,$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$OutQuad},$Opacity:2}";

            _SlideshowTransitionC["Float up Swirl"] = { $Duration: 600, y: 1, $Delay: 12, $Cols: 10, $Rows: 5, $SlideOut: true, $Reverse: true, $Formation: $JssorSlideshowFormations$.$FormationSwirl, $Assembly: 2049, $Easing: { $Top: $Jease$.$InCubic, $Opacity: $Jease$.$OutQuad }, $Opacity: 2 };
            _SlideshowTransitionCodes["Float up Swirl"] = "{$Duration:600,y:1,$Delay:12,$Cols:10,$Rows:5,$SlideOut:true,$Reverse:true,$Formation:$JssorSlideshowFormations$.$FormationSwirl,$Assembly:2049,$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$OutQuad},$Opacity:2}";

            _SlideshowTransitionC["Float up Swirl with Chess"] = { $Duration: 600, x: 1, y: 1, $Delay: 12, $Cols: 10, $Rows: 5, $SlideOut: true, $Reverse: true, $Formation: $JssorSlideshowFormations$.$FormationSwirl, $Assembly: 513, $ChessMode: { $Column: 3, $Row: 12 }, $Easing: { $Left: $Jease$.$InCubic, $Top: $Jease$.$InCubic, $Opacity: $Jease$.$OutQuad }, $Opacity: 2 };
            _SlideshowTransitionCodes["Float up Swirl with Chess"] = "{$Duration:600,x:1,y:1,$Delay:12,$Cols:10,$Rows:5,$SlideOut:true,$Reverse:true,$Formation:$JssorSlideshowFormations$.$FormationSwirl,$Assembly:513,$ChessMode:{$Column:3,$Row:12},$Easing:{$Left:$Jease$.$InCubic,$Top:$Jease$.$InCubic,$Opacity:$Jease$.$OutQuad},$Opacity:2}";
        }

        for (var transitionName in _SlideshowTransitionC) {
            var slideshowTransition = _SlideshowTransitionC[transitionName];
            _SlideshowTransitions.push(slideshowTransition);
        }
		
		jssor_slider1_init = function (containerId) {
            var jssor_slider1 = new $JssorSlider$(containerId, {
                $AutoPlay: 1,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
                $Idle: 400,                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
                $DragOrientation: 3,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $Cols is greater than 1, or parking position is not 0)
                $PauseOnHover: 1,                                   //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, 4 freeze for desktop, 8 freeze for touch device, 12 freeze for desktop and touch device, default value is 1

                $SlideshowOptions: {                                //[Optional] Options to specify and enable slideshow or not
                    $Class: $JssorSlideshowRunner$,                 //[Required] Class to create instance of slideshow
                    $Transitions: _SlideshowTransitions,            //[Required] An array of slideshow transitions to play slideshow
                    $TransitionsOrder: 1,                           //[Optional] The way to choose transition to play slide, 1 Sequence, 0 Random
                    $ShowLink: true                                 //[Optional] Whether to bring slide link on top of the slider when slideshow is running, default value is false
                }
            });

            function InnerText(elmt, text) {
                if (text == undefined) {
                    return elmt.textContent || elmt.innerText;
                }

                elmt.innerHTML = "";
                elmt.appendChild(document.createTextNode(text));
            }

            PlaySlideshowTransition = function (event) {
                $Jssor$.$StopEvent(event);
                $Jssor$.$CancelEvent(event);

                try {
                    var eventSrcElement = $Jssor$.$EvtSrc(event);
                    var transitionName = InnerText(eventSrcElement);
                    jssor_slider1.$Next();

                    jssor_slider1.$SetSlideshowTransitions([_SlideshowTransitionC[transitionName]]);

                    var effectStr = _SlideshowTransitionCodes[transitionName];

                    if (transitionNameTextBox) {
                        transitionNameTextBox.value = transitionName;
                    }
                    if (transitionCodeTextBox) {
                        transitionCodeTextBox.value = effectStr;
                    }
                }
                catch (e) { }
            }

            TransitionTextBoxClickEventHandler = function (event) {
                transitionCodeTextBox.select();

                $Jssor$.$CancelEvent(event);
                $Jssor$.$StopEvent(event);
            }

            var transitionCodeTextBox = document.getElementById("stTransition");
            var transitionNameTextBox = document.getElementById("stTransitionName");
            $Jssor$.$AddEvent(transitionCodeTextBox, "click", TransitionTextBoxClickEventHandler);

            //responsive code begin
            //remove responsive code if you don't want the slider scales while window resizing
            function ScaleSlider() {
                var bodyWidth = document.body.clientWidth;
                if (bodyWidth)
                    jssor_slider1.$ScaleWidth(Math.min(bodyWidth, 600));
                else
                    window.setTimeout(ScaleSlider, 30);
            }

            ScaleSlider();
            $Jssor$.$AddEvent(window, "load", ScaleSlider);

            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
            //responsive code end
        };