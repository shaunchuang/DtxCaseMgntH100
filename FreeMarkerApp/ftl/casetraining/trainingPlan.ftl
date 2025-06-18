<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name">教案使用</div>
				</div>          
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
	            <div class="default-blks">
	                <div class="col-5">
	                	<div class="default-blk" style="height: 90%;">
	                	<table  class="default-table">
	                		<tbody>
	                			<tr>
	                			    <td class="sub-title">訓練計畫名稱</td>
	                			    <td class="plan-title">Mincraft 訓練計畫</td>
	                			</tr>
	                			<tr>
	                				<td class="sub-title">訓練期間</td>
	                				<td class="plan-period">2024/08/04 ~ 2024/08/06</td>
	                			</tr>
	                			<tr>
	                				<td class="sub-title">訓練治療師</td>
	                				<td class="plan-creator">程靜雯 治療師</td>
	                			</tr>
	                			<tr>
	                				<td class="sub-title">使用方法</td>
	                				<td class="plan-rule">每天2次，每次30分鐘</td>
	                			</tr>
	                			<tr>
	                			    <td class="sub-title">追蹤指標</td>
	                			    <td class="training-target" colspan="2">
	                			    	<table class="table table-striped table-bordered bootstrap-datatable table-customed main-table" id="target-table">
	                			    		<thead>
	                			    			<tr class="tablesorter-headerRow">
	                			    				<th>指標追蹤</th>
	                			    				<th>達成目標</th>
	                			    			</tr>
	                			    		</thead>
	                			    		<tbody>
	                			    			<tr>
	                			    				<td>完成時間</td>
	                			    				<td>30分鐘以內</td>
	                			    			</tr>
	                			    			<tr>
	                			    				<td>完成時間</td>
	                			    				<td>30分鐘以內</td>
	                			    			</tr>
	                			    		</tbody>
	                			    	</table>
	                			    </td>
	                			</tr>
	                			<tr>
	                				<td class="sub-title">其他備註</td>
	                				<td class="other-note">N/A</td>
	                			</tr>
	                		</tbody>
	                	</table>
	                	</div>
	                	<div class="prev-Page">
	                		<button class="btn btn-primary prev-button" onclick="prevButton()"><i class="fa-solid fa-circle-arrow-left"></i>&nbsp;&nbsp;返回</button>
	                	</div>
	                </div>
	                <div class="col-7 default-blk" style="background-color: #FAFAFA;">
	                	<div class="default-blks">
	                		<div class="col-5">
	                			<img class="trainingImg" src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1672970/header.jpg?t=1717003107">
	                			<div class="lessonTitle">
	                				<!-- 教案名稱標題 -->
	                				<h3></h3>
	                			</div>
	                			<div class="lesson-use">
	                				<a href="http://video.akamai.steamstatic.com/store_trailers/256972298/movie_max_vp9.webm?t=1696005467" data-fancybox="gallery" data-thumb="" data-width="720" data-height="480" ><button class="btn btn-primary wh-video">觀看介紹影片</button></a>
	                				<a id="useLesson"><button class="btn btn-primary use-lesson">使用教案</button></a>
	                			</div>
	                		</div>
	                		<div class="col-7">
	                			<div>
	                				<div class="info-sub-title">教案資訊</div>
	                			</div>
	                			<table class="table table-bordered table-striped lesson-table">
	                				<tbody>
	                					<tr>
	                						<td class="intro-label">教案語言：</td>
	                						<td class="lesson-language">此教案無使用語言</td>
	                					</tr>
	                					<tr>
                							<td class="intro-label">教案類型：</td>
                							<td class="lesson-type">此教案無教案類型</td>
            							</tr>
            							<tr>
                							<td class="intro-label">簡介：</td>
                							<td class="lesson-intro">此教案目前無簡介</td>
            							</tr>
            							<tr>
                							<td class="intro-label">開發者：</td>
                							<td class="lesson-developer">此教案查無開發者</td>
            							</tr>
            							<tr>
                							<td class="intro-label">使用者協作：</td>
                							<td class="lesson-coop">此教案查無使用者協作</td>
            							</tr>
            							<tr>
                							<td class="intro-label last-td">其他：</td>
                							<td class="lesson-other last-td">此教案查無其他標籤</td>
            							</tr>
	                				</tbody>
	                			</table>

	                			<div>
	                				<div class="info-sub-title">注意事項</div>
	                			</div>
	                			<table class="table table-bordered table-striped lesson-table">
	                				<tbody>
	                					<tr>
	                						<td class="intro-label">使用限制：</td>
	                						<td class="lesson-limit">此教案查無使用限制</td>
	                					</tr>
	                					<tr>
	                						<td class="intro-label last-td">建議使用<br>時間：</td>
	                						<td class="lesson-useTime last-td">此教案查無建議使用時間</td>
	                				</tbody>
	                			</table>
	                			<!--<div>
	                				<div class="info-content">
		                				<span class="intro-label">使用限制：</span>
		                				<span class="lesson-limit">不適用於75歲以上患者</span>
	                				</div>
	                				<div class="info-content">
	                					<span class="intro-label">建議使用時間</span>
	                					<span class="lesson-useTime">睡前、晚餐飯後。可能出現3D暈眩的狀況，建議使用20~30分鐘休息一次。</span>
	                				</div>
	                			</div>-->
	                			<div>
	                				<div class="info-sub-title">作業設備</div>
	                			</div>
	                			<ul class="nav nav-tabs os-nav" id="osTabs" role="tablist">
	                			</ul>
	                			<div class="tab-content" id="osTabContent">
	                				此教案無建議作業設備
	                			</div>
	                		<div>
	                	</div>
	                </div>
	            </div>
	        </div>
		</div>
	</div>
</body>
<!-- 觀看影片的模態框 -->
<a href="http://video.akamai.steamstatic.com/store_trailers/256969690/movie_max.mp4?t=1696005491" data-fancybox="gallery" data-thumb="" data-width="720" data-height="480" ></a>
<!--<div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="videoModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="videoModalLabel">影片介紹</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <video id="videoPlayer" width="100%" height="350" controls>
          <source src="" type="video/webm">
          您的瀏覽器不支持播放該影片。
        </video>
      </div>
    </div>
  </div>
</div>-->

<!-- Loading 模態框 -->
<div class="modal fade" id="loadingModal" tabindex="-1" role="dialog" aria-labelledby="loadingModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-body text-center">
        <div class="custom-spinner" role="status">
           <span class="visually-hidden"></span>
        </div>
        <div class="mt-3 hintText"><span class="dynaText">教案啟動中</span><span class="loading-dots">.</span><span class="loading-dots">.</span><span class="loading-dots">.</span></div>
        <div class="mt-3 warningText">請勿重整或關閉瀏覽器!!</div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@fancyapps/ui@5.0/dist/fancybox/fancybox.umd.js"></script>
<script>
	var currentUserId = ${currentUser.id!""};
	var currentUserName = '${currentUser.name!""}';
	var therapistId = ${therapistId!""};
	var therapistName = '${therapistName!""}';
	var caseMgntUrl = '${caseMgntUrl!""}';
	var lessonStoreUrl = '${lessonStoreUrl!""}';
	
	var trainingPlan = JSON.parse('${trainingPlan!""}');
	
	console.log(trainingPlan);
	
	var planId = '${planId}';
	console.log('planId', planId);
	var lessonIdForPlan = ''; // 訓練教案KeyNo
	var lessonIdForStore = ''; // 教案市集KeyNo
	var lessonAch; // 教案成就
	
	
	$(document).ready(function() {
      	getTrainingPlanNew(trainingPlan);
		requestLessonApi();
		//watchVideo();
		Fancybox.bind('[data-fancybox="gallery"]', {
        
      	});
      	//test();
      	//test2();
      	startLesson();
    });
    
	// 詢問是否儲存訓練資料
	function saveSwal(trainingData) {
	    swal({
	        title: "完成訓練!!",
	        text: "是否儲存訓練資料?",
	        type: "info",
	        showCancelButton: true,
	        closeOnConfirm: false,
	        closeOnCancel: true,
	        confirmButtonText: "是",
	        cancelButtonText: "否"
	        }, function(isConfirm) {
                if (isConfirm) {
                    saveTrainingDataV2(trainingData);
                }
	    });
	}
	
	// 儲存訓練資料
	function saveTrainingDataV2(data) {
	    $.ajax({
	    	url: caseMgntUrl + "/division/api/v2/TrainingData/save",
	    	type: 'POST',
	    	dataType: 'json',
	    	data: {"data": JSON.stringify(data), "planId": planId, "lessonId": lessonIdForStore},
	    	success: function(result) {
	    		if(result.success){
	    			// 在成功後跳轉到新的頁面
        			window.location.href = "${base}/${__lang}/division/web/dtxCaseRecord/" + planId;
	    		} else {
	    			swal("儲存失敗", "請聯絡管理員", "error");
	    		}
	    	}
	    });
	}
	
	// 儲存訓練資料
	function saveTrainingData(data) {
	    $.ajax({
	    	url: caseMgntUrl + "/division/api/TrainingData/save",
	    	type: 'POST',
	    	dataType: 'json',
	    	data: {"data": JSON.stringify(data), "lessonKeyNo": lessonKeyNo},
	    	success: function(result) {
	    		if(result.success){
	    			// 在成功後跳轉到新的頁面
        			window.location.href = "${base}/${__lang}/division/web/dtxCaseRecord/" + trainingPlanKeyNo;
	    		} else {
	    			swal("儲存失敗", "請聯絡管理員", "error");
	    		}
	    	}
	    });
	}

    // 抓取教案資料
	function requestLessonApi(){
		const apiUrls = [
			lessonStoreUrl + '/division/api/Lesson/GetLessonBasic',
			lessonStoreUrl + '/division/api/Lesson/GetLessonRequirement',
			lessonStoreUrl + '/division/api/Lesson/GetLessonTag'
		];
		
		// 創建一個包含所有 fetch POST 請求的 Promise 陣列
	    const requests = apiUrls.map(url => 
	        $.ajax({
	        	url: url,
	        	type: 'POST',
	        	data: { "lessonId": lessonIdForStore },
	        	dataType: 'json',
	        	error: function(jqXHR, textStatus, errorThrown) {
	            	console.error('Error with', url, ':', textStatus, errorThrown);
	            	console.error('Response Text:', jqXHR.responseText);
	        	}
	    	})
	    );
	    
	    // 使用 Promise.all 並行處理所有請求
	    Promise.all(requests)
	        .then(responses => {
	            
	            const [lessonBasic,lessonRequirement, lessonTag] = responses;
	            
	            updateLessonBasic(lessonBasic);
	            updateLessonRequirement(lessonRequirement);
	            updateLessonTag(lessonTag);
	            
	        });
	}
	
	// 建立教案需求	
	function updateLessonRequirement(sysReq) {
	    let sysReqDTO = [];
	    try {
	        sysReqDTO = JSON.parse(sysReq.requirementsDTO);
	    } catch (error) {
	        console.error('Error parsing sysReqDTO:', error);
	        return;
	    }
	
	    if (Array.isArray(sysReqDTO) && sysReqDTO.length > 0) {
	
	        // 清空現有的需求內容
	        $('.os-nav').empty();
	        $('#osTabContent').empty();
	
	        // 使用 set 儲存已存在的 osType 和 reqType
	        const osTypes = new Set();
	        const reqTypes = ["建議配備", "最低配備"];
	        const contentMap = {};
	
	        sysReqDTO.forEach(function (sysReqData) {
	            const sysReqAnses = sysReqData['evalItemAnses'];
	            const osType = sysReqAnses["401"];
	            const reqType = sysReqAnses["402"];
	
	            // 確認 404 欄位存在才處理
	            if (osType && sysReqAnses["404"]) {
	                osTypes.add(osType);
	
	                if (!contentMap[osType]) {
	                    contentMap[osType] = {};
	                }
	                if (!contentMap[osType][reqType]) {
	                    contentMap[osType][reqType] = {};
	                }
	
	                contentMap[osType][reqType] = {
	                    os: sysReqAnses["404"],
	                    cpu: sysReqAnses["405"],
	                    ram: sysReqAnses["406"],
	                    graphic: sysReqAnses["407"],
	                    dx: sysReqAnses["408"],
	                    audio: sysReqAnses["409"],
	                    storage: sysReqAnses["410"],
	                    note: sysReqAnses["411"]
	                };
	            }
	        });
	
	        // 動態生成 Tabs 和 Tab Content
	        osTypes.forEach(function (osType) {
	            reqTypes.forEach(function (reqType) {
	                if (contentMap[osType] && contentMap[osType][reqType]) {
	
	                    const tabId = osType + '-' + (reqType === '最低配備' ? 'min' : 'rec') + '-tab';
	                    const containerId = osType + '-' + (reqType === '最低配備' ? 'min' : 'rec') + '-info';
	
	                    // 建立 OS Tabs
	                    const osTabHtml =
	                        '<li class="nav-item" role="presentation">' +
	                        '<a class="nav-link" id="' + tabId + '" href="javascript:void(0);" role="tab" data-target="#' + containerId + '">' +
	                        capitalizeFirstLetter(osType) + ' - ' + reqType +
	                        '</a>' +
	                        '</li>';
	                    $('.os-nav').append(osTabHtml);
	
	                    // 建立 OS Tab Content
	                    let osTabContentHtml = `<div class="tab-pane mt-2" id="` + containerId + `" role="tabpanel">`;
	
	                    if (contentMap[osType][reqType].os) {
	                        osTabContentHtml += `<div class="os-tag"><span>作業系統：</span><span class="os-text">` + contentMap[osType][reqType].os + `</span></div>`;
	                    }
	                    if (contentMap[osType][reqType].cpu) {
	                        osTabContentHtml += `<div class="cpu-tag"><span>處理器：</span><span class="cpu-text">` + contentMap[osType][reqType].cpu + `</span></div>`;
	                    }
	                    if (contentMap[osType][reqType].ram) {
	                        osTabContentHtml += `<div class="ram-tag"><span>記憶體：</span><span class="ram-text">` + contentMap[osType][reqType].ram + `</span></div>`;
	                    }
	                    if (contentMap[osType][reqType].graphic) {
	                        osTabContentHtml += `<div class="graphic-tag"><span>顯示卡：</span><span class="graphic-text">` + contentMap[osType][reqType].graphic + `</span></div>`;
	                    }
	                    if (contentMap[osType][reqType].dx) {
	                        osTabContentHtml += `<div class="dx-tag"><span>DirectX：</span><span class="dx-text">` + contentMap[osType][reqType].dx + `</span></div>`;
	                    }
	                    if (contentMap[osType][reqType].audio) {
	                        osTabContentHtml += `<div class="audio-tag"><span>音效卡：</span><span class="audio-text">` + contentMap[osType][reqType].audio + `</span></div>`;
	                    }
	                    if (contentMap[osType][reqType].storage) {
	                        osTabContentHtml += `<div class="storage-tag"><span>儲存空間：</span><span class="storage-text">` + contentMap[osType][reqType].storage + `</span></div>`;
	                    }
	                    if (contentMap[osType][reqType].note) {
	                        osTabContentHtml += `<div class="note-tag"><span>備註：</span><span class="note-text">` + contentMap[osType][reqType].note + `</span></div>`;
	                    }
	
	                    osTabContentHtml += `</div>`;
	
	                    $('#osTabContent').append(osTabContentHtml);
	                }
	            });
	        });
	
	        // 啟用第一個 tab
	        $('.os-nav a:first').addClass('active');
	        $('#osTabContent .tab-pane:first').addClass('show active');
	
	        // 手動切換標籤頁
	        $('.os-nav a').on('click', function (e) {
	            e.preventDefault();
	
	            // 移除所有標籤和內容的活動狀態
	            $('.os-nav a').removeClass('active');
	            $('#osTabContent .tab-pane').removeClass('show active');
	
	            // 添加當前選定標籤的活動狀態
	            $(this).addClass('active');
	            $($(this).data('target')).addClass('show active');
	        });
	    }
	}

    function updateLessonBasic(lessonBasic){
    	let basicAns = JSON.parse(lessonBasic.lessonMain);
    	let lessonName = basicAns.evalItemAnses['1'];
    	let shortDesc = basicAns.evalItemAnses['2'];
    	let lessonHeader = basicAns.evalItemAnses['4'];
    	let lessonLimit = basicAns.evalItemAnses['13'];
    	
    	
    	
    	$('.lessonTitle h3').text(lessonName);
    	$('.lesson-intro').text(shortDesc);
    	
    	lessonLink(basicAns);
    	$('.trainingImg').attr('src', lessonHeader);
    	$('.lesson-limit').text(lessonLimit);
    }
    
    function lessonLink(basicAns){
    	var linkBasic = basicAns.evalItemAnses['11']
    	if (typeof linkBasic !== 'undefined') {
		    if (linkBasic.includes('scratch/')) {
		        // 提取 scratch ID
		        const scratchId = linkBasic.split('/')[1];
		        $('.lesson-use #useLesson').attr('href', 'https://scratch.mit.edu/projects/' + scratchId)
		        .attr('target', '_blank');
		        
		    } else if (linkBasic.includes('customScratch/')) {
		    	// 自訂義scratch
		        const scratchId = linkBasic.split('/')[1];
		        $('.lesson-use #useLesson').attr('href', 'https://icare.itri.org.tw/' + scratchId)
		        .attr('target', '_blank');
		        
		    } else {
		        // 預設情況，設定為 steam://run/
		        $('.lesson-use #useLesson').attr('href', 'steam://run/' + linkBasic);
		    }
		} else {
		    console.log('ansList[\'11\'] is undefined.');
		    $('.lesson-use #useLesson').hide();
		}
    }
    
    function updateLessonTag(tagResponse){

    	let tagData = tagResponse.tags;
    	
    	// 處理類型
    	if (Array.isArray(tagData['2']) && tagData['2'].length > 0) {
        	let typeContent = '';
        	$.each(tagData['2'], function(index, tag) {
            	if (index > 0) {
                	typeContent += '、';
            	}
            	typeContent += tag;
        	});
        	$('.lesson-type').text(typeContent);
    	}
    	
    	// 處理開發者
    	if (Array.isArray(tagData['4']) && tagData['4'].length > 0) {
    		let developerContent = '';
    		$.each(tagData['4'], function(index, tag) {
    			if (index > 0) {
    				developerContent += '、';
    			}
    			developerContent += tag;
    		});
    		$('.lesson-developer').text(developerContent);
    	}
    	
    	// 處理合作
    	if (Array.isArray(tagData['8']) && tagData['8'].length > 0) {
    		let coopContent = '';
    		$.each(tagData['8'], function(index, tag) {
    			if (index > 0) {
    				coopContent += '、';
    			}
    			coopContent += tag;
    		});
    		$('.lesson-coop').text(coopContent);
    	}
    	
    	// 處理其他功能
    	if (Array.isArray(tagData['9']) && tagData['9'].length > 0) {
    		let otherContent = '';
    		$.each(tagData['9'], function(index, tag) {
    			if (index > 0) {
    				otherContent += '、';
    			}
    			otherContent += tag;
    		});
    		$('.lesson-other').text(otherContent);
    	}
            
	    // 處理語言
	    if (Array.isArray(tagData['3']) && tagData['3'].length > 0) {
	        let languageTags = tagData['3'];
	        let preferredTags = ["繁體中文", "繁體中文(語音)", "英文", "英文(語音)"];
	        let otherTags = [];
	
	        // 將優先顯示的tag移到前面
	        let sortedTags = preferredTags.filter(function(tag) {
	            return languageTags.includes(tag);
	        });
	
	        // 剩下的tag
	        otherTags = languageTags.filter(function(tag) {
	            return !preferredTags.includes(tag);
	        });
	
	        // 合併結果
	        let finalTags = sortedTags.concat(otherTags);
	        let languageContent = finalTags.join('、');
	
	        $('.lesson-language').text(languageContent);
	    }
	    
	    let maxLength = 40; // 設定初始顯示的最大字數
	    let languageContent = $('.lesson-language').text();

	    
	        if (languageContent.length > maxLength) {
		        let visibleText = languageContent.substr(0, maxLength);
		        let hiddenText = languageContent.substr(maxLength);
		
		        $('.lesson-language').html(
		            visibleText + '<span class="more-ellipsis">...</span><span class="more-content">' + hiddenText + '</span><span class="show-more-btn">顯示更多</span>'
		        );
		        $('.more-content').hide(); // 隱藏多餘的文字
		
		        $('.show-more-btn').click(function() {
		            let $this = $(this);
		            let $parentTd = $this.closest('td');
		
		            // 切換顯示與隱藏狀態
		            if ($this.text() === "顯示更多") {
		                $this.text("顯示更少");
		                $parentTd.find('.more-ellipsis').hide(); // 隱藏省略號
		                $parentTd.find('.more-content').show(); // 顯示隱藏的內容
		            } else {
		                $this.text("顯示更多");
		                $parentTd.find('.more-ellipsis').show(); // 顯示省略號
		                $parentTd.find('.more-content').hide(); // 隱藏多餘的內容
		            }
		        });
		    } else {
		        $('.show-more-btn').hide(); // 如果內容不超過設定的字數，隱藏“顯示更多”按鈕
		    }
    }
    
    // 返回總覽
    function prevButton(){
    	window.location.href = "${base}/${__lang}/division/web/review";
    }
    
    
    // 首字母大寫
	function capitalizeFirstLetter(string) {
	    if (!string) return string; // 如果字串為空，直接返回
	    return string.charAt(0).toUpperCase() + string.slice(1);
	}
	
	function startLesson(){
		$('#useLesson').click(function() {
		
			let steamLink = $(this).attr('href');
			
			if(steamLink.includes('steam')){
				// 顯示 loading 模態框
	        	showLoadingModal('Steam教案啟動中');
			    // 如果是steam 連結：
				let steamId = steamLink.split('/')[3];
				$.ajax({
				    url: '${base}/${__lang}/division/api/Monitor/MonitorPlayer',
				    type: 'POST',
				    data: { "appId": steamId },
				    dataType: 'json',
				    success: function(response) {
	
	                    // 隱藏 loading 模態框
	                	$('#loadingModal').modal('hide');
	                	if(response.success){
							saveSwal(response);
	                	} else {
							swal('教案啟動失敗','請聯絡管理員','error');                	
	                	}
	                	
	                },
				    error: function(jqXHR, textStatus, errorThrown) {
	                    console.error('Error with StartLesson:', textStatus, errorThrown);
	                    console.error('Response Text:', jqXHR.responseText);
	                    alert('監控失敗，請聯絡管理員');
	                    }
	            });
	            } else {
	            	// 如果不是steam 連結
	            	console.log('如果不是steam連結');
	            	
	            }
        });
    }
    
    function showLoadingModal(hintText){
	    $('.dynaText').text(hintText);
	    $('#loadingModal').modal({
	        backdrop: 'static',
	        keyboard: false
	    }).modal('show');
    }
    
    	  
    function test2(){
	    $.ajax({
            url: '${base}/${__lang}/division/api/Monitor/test2',
            type: 'POST',
            dataType: 'json',
            data: { "appId": appId },
            success: function(response) {
                let unlockAch = response.unlockedAchievements;
                             
                let stats = response.stats;
                
                saveTrainingData(response);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Error with StartLesson:', textStatus, errorThrown);
                console.error('Response Text:', jqXHR.responseText);
            }
        });
	}
    
    function test(){
	    $.ajax({
            url: '${base}/${__lang}/division/api/Monitor/test',
            type: 'POST',
            dataType: 'json',
            success: function(response) {
                let unlockAch = response.unlockedAchievements;
                
                saveTrainingData(response);
                
                unlockAch.forEach(function(achievement) {
                    lessonAch.forEach(function(ach){
                    	if(achievement.apiname == ach.evalItemAnses['52']){
                    		//console.log('Unlock Achievement:', ach.evalItemAnses['53']);
                    		//console.log('Description:', ach.evalItemAnses['54']);
                    	}
                    });
                    //console.log('Achieved', achievement.achieved);
                    //console.log('UnlockTime', achievement.unlocktime);
                    
                });
                
                $('#loadingModal').modal('hide');
                let stats = response.stats;
                
                Object.keys(stats).forEach(function(key) {
				    //console.log('Stat:', key);
				    //console.log('Difference:', stats[key].difference);
				    //console.log('Current Value:', stats[key].currentValue);
				});
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Error with StartLesson:', textStatus, errorThrown);
                console.error('Response Text:', jqXHR.responseText);
            }
        });
	}
	
	function getTrainingPlanNew(trainingPlan) {
		if(trainingPlan.success) {
			var planDetail = trainingPlan.trainingPlan;
			lessonIdForStore = planDetail.lessons[0].lessonId;
			
			var perWeek = planDetail.frequencyPerWeek;
			var perDay = planDetail.frequencyPerDay;
			var duration = planDetail.durationPerSession;
			var therapistName = planDetail.therapistName;
			var otherNote = planDetail.notes;
			var minutes = parseInt(duration);
			var hours = Math.floor(minutes / 60);
			var remainingMinutes = minutes % 60;
			
			var formattedTime = (hours > 0 ? hours + "小時" : "") + remainingMinutes + "分鐘";
			var ruleText = '';
			if (perWeek !== undefined) {
			    ruleText += '每週' + perWeek + '次';
			}
			if (perDay !== undefined) {
			    if (ruleText) {
			        ruleText += '; ';
			    }
			    ruleText += '每天' + perDay + '次';
			}
			
			ruleText += '; 每次' + formattedTime;
			
			var lessonMain;
			var result = wg.evalForm.getJson({"lessonId": lessonIdForStore}, lessonStoreUrl + '/division/api/Lesson/GetLessonBasic');
        	if(result.success){
        		lessonMain = JSON.parse(result.lessonMain);
        	} else {
        		swal('載入訓練計畫失敗','請聯絡管理員','error');
        	}
        	var imageUrl = lessonMain.evalItemAnses['4'];
			var lessonName = lessonMain.evalItemAnses['1'];
        	var startDateStr = formatDateNew(planDetail.startDate);
        	var endDateStr = formatDateNew(planDetail.endDate);
        	
        	//更新主表格
        	$('.plan-title').text(lessonName + " 訓練計畫");
			$('.plan-period').text(startDateStr + ' ~ ' + endDateStr);
        	$('.plan-creator').text(therapistName + ' 治療師');
        	$('.plan-rule').text(ruleText);
        	
        				// 將 \n 替換為 <br>
			if (otherNote.includes('\\n')) {
			    otherNote = otherNote.replace(/\\n/g, '<br>');
			    $('.other-note').html(otherNote);
			} else {
			    $('.other-note').text(otherNote);
			}
        	
        	//處理追蹤指標
        	var achResult = wg.evalForm.getJson({"lessonId": lessonIdForStore}, lessonStoreUrl + '/division/api/Lesson/GetLessonAchievement');
        	if(achResult.success){
	        	lessonAch = JSON.parse(achResult.achievementsDTO);
	        	$('#target-table tbody').empty();
	        	
	        	// 取得訓練教案
	        	var trainingLesson = planDetail.lessons[0];
	        	// 訓練教案的成就及統計
	        	var achievement = trainingLesson.achievements;
	        	var stats = trainingLesson.statistics;
	        	
	   			// 判斷成就與統計是否為空
			    if ((achievement.length === 0 || !achievement) && (stats.length === 0 || !stats)) {
			        // 如果都為空，移除表格並顯示提示文字
			        $('#target-table').remove();
			        $('.training-target').append('<div class="no-target-msg">此計畫無追蹤目標</div>');
			    } else {
			        // 如果有數據，生成表格內容
			        achievement.forEach(achTarget => {
			            lessonAch.forEach(ach => {
			                if (achTarget.apiName == ach.evalItemAnses['52']) {
			                    var achName = ach.evalItemAnses['53'];
			                    var achDes = ach.evalItemAnses['54'];
			                    var achImage = ach.evalItemAnses['55'];
			                    var achHtml = `
			                    <tr>
			                        <td>成就</td>
			                        <td>
			                            <div class="default-blks">
			                                <div class="col-3">
			                                    <img src="` + achImage + `" class="achievement-image">
			                                </div>
			                                <div class="col-9">
			                                    <div>` + achName + `</div>
			                                    <div>` + achDes + `</div>
			                                </div>
			                            </div>
			                        </td>
			                    </tr>`;
			                    $('#target-table tbody').append(achHtml);
			                }
			            });
			        });
			
			        stats.forEach(statsTarget => {
			            var statsHtml = `
			                <tr>
			                    <td>統計</td>
			                    <td>` + statsTarget.apiName + ` > ` + statsTarget.valueGoal + `</td>
			                </tr>`;
			            $('#target-table tbody').append(statsHtml);
			        });
			    }
        	} else {
        		swal('載入訓練計畫失敗','請聯絡管理員','error');
        	}
		} else {
    		swal('載入訓練計畫失敗','請聯絡管理員','error');
    	}
	}
	
	
    function getTrainingPlan(){
    	var result = wg.evalForm.getJson({"data": trainingPlanKeyNo}, caseMgntUrl + '/division/api/TrainingPlan/get');
    	if(result.success){
    		var trainingPlan = result.trainingPlan;
    		
    		var lessonMain = '';
        	lessonId = trainingPlan.trainingLessons[0].lessonStoreKeyNo;
        	lessonKeyNo = trainingPlan.trainingLessons[0].trainingLessonKeyNo;
        	var perWeek = trainingPlan.trainingLessons[0].perWeek;
        	var perDay = trainingPlan.trainingLessons[0].perDay;
        	
			var trainingTime = trainingPlan.trainingLessons[0].trainingTime;
			var minutes = parseInt(trainingTime);
			
			var hours = Math.floor(minutes / 60);
			var remainingMinutes = minutes % 60;
			
			var formattedTime = (hours > 0 ? hours + "小時" : "") + remainingMinutes + "分鐘";
			
        	var ruleText = '';
			if (perWeek !== undefined) {
			    ruleText += '每週' + perWeek + '次';
			}
			if (perDay !== undefined) {
			    if (ruleText) {
			        ruleText += '; ';
			    }
			    ruleText += '每天' + perDay + '次';
			}
			
			ruleText += '; 每次' + formattedTime;
        	
        	

			var otherNote = trainingPlan.trainingLessons[0].otherNote;

        	var result = wg.evalForm.getJson({"lessonId": lessonId}, lessonStoreUrl + '/division/api/Lesson/GetLessonBasic');
        	if(result.success){
        		lessonMain = JSON.parse(result.lessonMain);
        	} else {
        		swal('載入訓練計畫失敗','請聯絡管理員','error');
        	}
			
        	var imageUrl = lessonMain.evalItemAnses['4'];
			var lessonName = lessonMain.evalItemAnses['1'];
        	var startDateStr = formatDate(trainingPlan.startTime);
        	var endDateStr = formatDate(trainingPlan.endTime);
        	        	
			$('.plan-title').text(lessonName + " 訓練計畫");
			$('.plan-period').text(startDateStr + ' ~ ' + endDateStr);
        	$('.plan-creator').text(therapistName + ' 治療師');
        	$('.plan-rule').text(ruleText);
			
			// 將 \n 替換為 <br>
			if (otherNote.includes('\\n')) {
			    otherNote = otherNote.replace(/\\n/g, '<br>');
			    $('.other-note').html(otherNote);
			} else {
			    $('.other-note').text(otherNote);
			}
        	
        	//處理追蹤指標
        	var achResult = wg.evalForm.getJson({"lessonId": lessonId}, lessonStoreUrl + '/division/api/Lesson/GetLessonAchievement');
        	if(achResult.success){
	        	lessonAch = JSON.parse(achResult.achievementsDTO);
	        	$('#target-table tbody').empty();
	        	
	        	// 取得訓練教案
	        	var trainingLesson = trainingPlan.trainingLessons[0];
	        	// 訓練教案的成就及統計
	        	var achievement = trainingLesson.achievement;
	        	var stats = trainingLesson.stats;
	        	
	   			// 判斷成就與統計是否為空
			    if ((achievement.length === 0 || !achievement) && (stats.length === 0 || !stats)) {
			        // 如果都為空，移除表格並顯示提示文字
			        $('#target-table').remove();
			        $('.training-target').append('<div class="no-target-msg">此計畫無追蹤目標</div>');
			    } else {
			        // 如果有數據，生成表格內容
			        achievement.forEach(achTarget => {
			            lessonAch.forEach(ach => {
			                if (achTarget == ach.evalItemAnses['52']) {
			                    var achName = ach.evalItemAnses['53'];
			                    var achDes = ach.evalItemAnses['54'];
			                    var achImage = ach.evalItemAnses['55'];
			                    var achHtml = `
			                    <tr>
			                        <td>成就</td>
			                        <td>
			                            <div class="default-blks">
			                                <div class="col-3">
			                                    <img src="` + achImage + `" class="achievement-image">
			                                </div>
			                                <div class="col-9">
			                                    <div>` + achName + `</div>
			                                    <div>` + achDes + `</div>
			                                </div>
			                            </div>
			                        </td>
			                    </tr>`;
			                    $('#target-table tbody').append(achHtml);
			                }
			            });
			        });
			
			        stats.forEach(statsTarget => {
			            var statsHtml = `
			                <tr>
			                    <td>統計</td>
			                    <td>` + statsTarget.apiName + ` > ` + statsTarget.statsValue + `</td>
			                </tr>`;
			            $('#target-table tbody').append(statsHtml);
			        });
			    }
        	} else {
        		swal('載入訓練計畫失敗','請聯絡管理員','error');
        	}
        	
    	} else {
    		swal('載入訓練計畫失敗','請聯絡管理員','error');
    	}
    }
    
	function formatDate(dateStr){
		var dateObj = new Date(dateStr);
		var formattedDate = dateObj.getFullYear() + '/' + 
	    ('0' + (dateObj.getMonth() + 1)).slice(-2) + '/' + 
	    ('0' + dateObj.getDate()).slice(-2);
	    
	    return formattedDate;
	}
	
	function formatDateNew(input){
		const date = new Date(input);
		
		// 使用 toLocaleDateString 格式化
		const formattedDate = date.toLocaleDateString('zh-TW', {
		  year: 'numeric',
		  month: '2-digit',
		  day: '2-digit',
		}).replace(/\//g, '/'); // 確保分隔符為 "/"
		
		console.log(formattedDate);
		return formattedDate;
	}
</script>
<style>
	.trainingImg{
		width: 100%;
		border-radius: 10px;
	}
	
	.lessonTitle h3{
		margin-top: 10px;
	}
	
	.info-content {
	    margin: 0.5rem 0;
	}
	
	.show-more-btn {
        color: blue;
        cursor: pointer;
        margin-left: 5px;
	}
	
	.intro-label {
        font-weight: bold;
        padding: 3px 3px !important;
        width: 23%;
        font-size: 1.6rem;
        
    }
    
    .lesson-language, .lesson-type, .lesson-intro, .lesson-developer, .lesson-coop, .lesson-other, .lesson-limit, .lesson-useTime {
        font-size: 1.5rem;
        padding: 3px 3px !important;
    }
    
    .more-ellipsis {
	    display: inline;
	}
	
	.more-content {
	    display: none;
	}
    
	
	.wh-video{
		border-color: #074B3A;
		color: #074B3A;
		background-color: #fff;
    }
    
    .wh-video:hover{
    	color: #fff;
    	background-color: #074B3A;
    }
    
    .wh-video:focus, .wh-video:active{
    	color: #fff;
    	background-color: #074B3A;
    }
    
    .use-lesson{
    	color: #212529;
    	background-color: #00CB96;
        margin-left: 1rem;
        border-color: #00CB96;
    }
    .use-lesson:hover{
    	color: #fff;
    	background-color: #00CB96;
    }
    
    .use-lesson:focus, .use-lesson:active{
    	color: #fff;
    	background-color: #00CB96;
    }
    
    .info-sub-title{
    	font-size: 1.8rem;
    	font-weight: bold;
    	color: black;
    }
	
	.lesson-table td, .lesson-table th{
		border: none !important;
		border-bottom: 0.5px solid #f2f2f2 !important;
    }
    
    .lesson-table td.last-td{
    	border-bottom: none !important;
    }
	
	.lesson-table{
		border-collapse: collapse;
	}
    
    .table{
    	margin-bottom: 0;
    }
    
    .default-table th, .default-table td {
    	width: fit-content !important;
    }
    
    /* 上一頁按鈕 */
    .prev-Page{
    	margin-top: 1.5rem;
    }
    
    .prev-button{
    	padding: 0.8rem 2.5rem;
    	background-color: #FFFFFF;
    	color: #9E9E9E;
    	border-color: #9E9E9E;
    }
    
    .prev-button:hover{
    	background-color: #9E9E9E;
    	color: #FFFFFF;
    	border-color: #9E9E9E;
    }
    
    /* 影片播放模組 */
    .modal-header .close {
	    position: absolute;
	    top: 15px;
	    right: 15px;
	    z-index: 10;
	    padding: 0;
	    background: none;
	    border: none;
	    font-size: 1.5rem;
	    color: #000;
	    opacity: 0.5;
	}
	
	.modal-header .close:hover {
	    opacity: 1;
	    color: #000;
	}
	
	.tab-pane div{
		margin: 0.5rem 0;
	}
	
	/* 自訂的 loading 圓圈動畫 */
	.custom-spinner {
	    display: inline-block;
	    width: 6rem;
	    height: 6rem;
	    border: 0.5rem solid rgba(0, 0, 0, 0.2);
	    border-top: 0.5rem solid #00CB96; /* 修改顏色以符合你的主題 */
	    border-radius: 50%;
	    animation: spin 2s linear infinite;
	}
	
	@keyframes spin {
	    0% { transform: rotate(0deg); }
	    100% { transform: rotate(360deg); }
	}
	
	@keyframes loading {
	    0% {
	        opacity: 1;
	    }
	    25% {
	        opacity: 0;
	    }
	    50% {
	        opacity: 1;
	    }
	    75% {
	        opacity: 0;
	    }
	    100% {
	        opacity: 1;
	    }
	}
	
	.loading-dots {
	    animation: loading 1.5s infinite;
	}
	
	.loading-dots:nth-child(2) {
	    animation-delay: 0.5s;
	}
	
	.loading-dots:nth-child(3) {
	    animation-delay: 1s;
	}
	
	.hintText{
        font-size: 2rem;
        font-weight: bold;
        margin-top: 2rem;
    }
    
    .warningText{
        font-size: 1.5rem;
        font-weight: bold;
        color: #FF0000;
    }
	
	/* sweetalert 樣式 */
	.sa-confirm-button-container .btn-primary{
		color: #FFFFFF;
		background-color: #00CB96;
		margin-left: 5rem;
	}
	
	.nav-item a{
		border-radius: 10px !important;
		font-size: 1.5rem;
	}
	
	.nav-item a.active{
		border-radius: 10px !important;
		background-color: #BCE8F1 !important;
	}
	
	#osTabContent .tab-pane div{
	    font-size: 1.5rem;
    }
    
    .achievement-image {
    	height: 100%;
    	width: 100%;
    }
    
</style>
</html>
