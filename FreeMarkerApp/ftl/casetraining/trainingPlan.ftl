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
	let currentUserId = ${currentUser.id!""};
	let currentUserName = '${currentUser.name!""}';
	let therapistName = '${therapistName!""}';
	let lessonStoreUrl = '${lessonStoreUrl!""}';
	let trainingPlan = ${trainingPlan!""};

	console.log(trainingPlan);

	let planId = '${planId}';
	console.log('planId', planId);
	let lessonIdForPlan = ''; // 訓練教案KeyNo
	let lessonIdForStore = trainingPlan.lessons[0].lessonId; // 教案市集KeyNo
	let lessonAch; // 教案成就


	$(document).ready(function() {
      	getTrainingPlanNew(trainingPlan);
		requestLessonApi();
		Fancybox.bind('[data-fancybox="gallery"]', {
        
      	});
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
	    	url: "/Training/api/saveData",
	    	type: 'POST',
	    	dataType: 'json',
	    	data: {"data": JSON.stringify(data), "planId": planId, "lessonId": lessonIdForStore},
	    	success: function(result) {
	    		if(result.success){
	    			// 在成功後跳轉到新的頁面
        			window.location.href = "/ftl/casetraining/trainingRecord?planId=" + planId;
	    		} else {
	    			swal("儲存失敗", "請聯絡管理員", "error");
	    		}
	    	}
	    });
	}
	

    // 抓取教案資料
	function requestLessonApi(){
		$.ajax({
			url: lessonStoreUrl + '/LessonMainInfo/api/get/lessonId/' + lessonIdForStore,
			type: 'GET',
			dataType: 'json',
			success: function(response) {
				console.log('response: ', response);
					updateLessonBasic(response);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.error('Error with LessonMainInfo:', textStatus, errorThrown);
				console.error('Response Text:', jqXHR.responseText);
				swal('載入教案失敗','請聯絡管理員','error');
			}
		});
		const apiUrls = [
			lessonStoreUrl + '/LessonSystemRequirement/api/lesson',
			lessonStoreUrl + '/LessonTag/api/lesson'
		];
		
		// 創建一個包含所有 fetch POST 請求的 Promise 陣列
		console.log('lessonIdForStore', lessonIdForStore);
	    const requests = apiUrls.map(url => 
	        $.ajax({
	        	url: url,
	        	type: 'POST',
	        	data: JSON.stringify({"lessonId": lessonIdForStore}),
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
	            const [lessonRequirement, lessonTag] = responses;
	            updateLessonRequirement(lessonRequirement);
	            updateLessonTag(lessonTag);
	            
	        });
	}
		// 建立教案需求	
	function updateLessonRequirement(sysReq) {
	    let sysReqDTO = [];
	    
	    // 處理新的資料格式
	    if (Array.isArray(sysReq)) {
	        sysReqDTO = sysReq;
	    } else {
	        try {
	            sysReqDTO = JSON.parse(sysReq.requirementsDTO);
	        } catch (error) {
	            console.error('Error parsing sysReqDTO:', error);
	            return;
	        }
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
	            let osType, reqType, osSystem, processor, memory, graphicsCard, directxVersion, storageSpace;
	            
	            // 處理新格式的資料結構
	            if (sysReqData.platform) {
	                osType = sysReqData.platform;
	                reqType = sysReqData.requirementType === 'MINIMUM' ? '最低配備' : '建議配備';
	                osSystem = sysReqData.operatingSystem;
	                processor = sysReqData.processor;
	                memory = sysReqData.memory;
	                graphicsCard = sysReqData.graphicsCard;
	                directxVersion = sysReqData.directxVersion;
	                storageSpace = sysReqData.storageSpace;
	            } else if (sysReqData.evalItemAnses) {
	                // 處理舊格式的資料結構 (保持向後相容)
	                const sysReqAnses = sysReqData['evalItemAnses'];
	                osType = sysReqAnses["401"];
	                reqType = sysReqAnses["402"];
	                osSystem = sysReqAnses["404"];
	                processor = sysReqAnses["405"];
	                memory = sysReqAnses["406"];
	                graphicsCard = sysReqAnses["407"];
	                directxVersion = sysReqAnses["408"];
	                storageSpace = sysReqAnses["410"];
	            }

	            // 確認必要欄位存在才處理
	            if (osType && osSystem) {
	                osTypes.add(osType);

	                if (!contentMap[osType]) {
	                    contentMap[osType] = {};
	                }
	                if (!contentMap[osType][reqType]) {
	                    contentMap[osType][reqType] = {};
	                }

	                contentMap[osType][reqType] = {
	                    os: osSystem,
	                    cpu: processor,
	                    ram: memory,
	                    graphic: graphicsCard,
	                    dx: directxVersion,
	                    storage: storageSpace
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
	                    if (contentMap[osType][reqType].storage) {
	                        osTabContentHtml += `<div class="storage-tag"><span>儲存空間：</span><span class="storage-text">` + contentMap[osType][reqType].storage + `</span></div>`;
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


	/**
	* 依新版 lessonBasic 結構更新課程基本資訊
	* @param {Object} lessonBasic 由後端 API 傳回的課程資料
	*/
	function updateLessonBasic(lessonBasic) {
		console.log("lessonBasic", lessonBasic);

		/* === 1. 基本欄位 === */
		const lessonName   = lessonBasic.lessonName       || "（未命名課程）";
		const shortDesc    = lessonBasic.lessonBrief      || "";
		const headerImgUrl = lessonStoreUrl + '/File/api/file/path' + lessonBasic.headerImageUrl   || "";   // 可能是 /images/... 或完整 http 路徑
		const lessonLimit  = lessonBasic.lessonLimit      // 若新結構沒有此欄位可省略
							?? (lessonBasic.price !== undefined
								? `NT$ ` + lessonBasic.price
								: "");

		/* === 2. 寫入 DOM === */
		$(".lessonTitle h3").text(lessonName);

		// 說明文字通常包含 <br>，用 .html() 可保留格式
		$(".lesson-intro").html(shortDesc);

		if (typeof lessonLink === "function") {
			lessonLink(lessonBasic);
		}

		if (headerImgUrl) {
			$(".trainingImg").attr("src", headerImgUrl);
		}

		if (lessonLimit) {
			$(".lesson-limit").text(lessonLimit);
		}
	}

    
    function lessonLink(basic){
    	let linkBasic = basic.executionId;
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
		    console.log('executionId is undefined.');
		    $('.lesson-use #useLesson').hide();
		}
    }
    
function updateLessonTag(tagResponse) {
  console.log('tagResponse', tagResponse);

  /* ---------- 1. 依 tagType 分組 ---------- */
  const tagData = {}; // 最終會是 { "2": ["角色扮演", …], "3": ["英文", …], … }

  tagResponse.forEach(tag => {
    const key = String(tag.tagType);         // 保證 key 是字串
    if (!tagData[key]) tagData[key] = [];
    tagData[key].push(tag.tagName);
  });

  /* ---------- 2. 通用標籤處理 ---------- */
  const typeMap = {
    '2': '.lesson-type',      // 類型
    '4': '.lesson-developer', // 開發者
    '5': '.lesson-support',   // 支援功能
    '6': '.lesson-platform',  // 平台
    '8': '.lesson-coop',      // 合作模式
    '9': '.lesson-other'      // 其他功能
  };

  Object.entries(typeMap).forEach(([type, selector]) => {
    if (Array.isArray(tagData[type]) && tagData[type].length > 0) {
      $(selector).text(tagData[type].join('、'));
    }
  });

  /* ---------- 3. 語言標籤專屬處理 ---------- */
	if (Array.isArray(tagData['3']) && tagData['3'].length > 0) {
	const languageTags = tagData['3'];

	// 常用語言優先
	const preferred = ['繁體中文', '繁體中文(語音)', '英文', '英文(語音)'];
	const sorted = [
		...preferred.filter(t => languageTags.includes(t)),
		...languageTags.filter(t => !preferred.includes(t))
	];

	const languageContent = sorted.join('、');
	const $langEl = $('.lesson-language');   // ❶ 直接抓元素，不先 .text()

	/* ----- 超過字數折疊 ----- */
	const maxLength = 40;
	if (languageContent.length > maxLength) {
		const visible = languageContent.slice(0, maxLength);
		const hidden  = languageContent.slice(maxLength);

		$langEl.html(visible+`
		<span class="more-ellipsis">...</span>
		<span class="more-content" style="display:none;">` + hidden + `</span>
		<span class="show-more-btn" style="cursor:pointer;color:blue;">顯示更多</span>`
		);

		/* ★ 修正 click 切換邏輯 ★ */
		$langEl.on('click', '.show-more-btn', function () {
		const $btn   = $(this);
		const expand = $btn.text() === '顯示更多';   // true = 要展開

		// 顯示／隱藏各段文字
		$langEl.find('.more-ellipsis').toggle(!expand);
		$langEl.find('.more-content').toggle(expand);

		// 切換按鈕文字
		$btn.text(expand ? '顯示更少' : '顯示更多');
		});

	} else {
		// 不用折疊，直接呈現
		$langEl.text(languageContent);
	}
	}
}

    
    // 返回總覽
    function prevButton(){
    	window.location.href = "/ftl/casetraining/caseDashboard";
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
    console.log('getTrainingPlanNew', trainingPlan);

    /* ---------- 1. 解析計畫主體 ---------- */
    const planDetail = trainingPlan.trainingPlan || trainingPlan;

    /* ---------- 2. 取得教案 ID ---------- */
    if (!planDetail.lessons || planDetail.lessons.length === 0) {
        swal('載入訓練計畫失敗', '找不到訓練教案資料', 'error');
        return;
    }
    lessonIdForStore = planDetail.lessons[0].lessonId;

    /* ---------- 3. 基本欄位 ---------- */
    const perWeek       = planDetail.frequencyPerWeek;   // 新格式沒有，但保留向下相容
    const perDay        = planDetail.frequencyPerDay;
    const duration      = planDetail.durationPerSession;
    const therapistName = planDetail.therapistName;
    let   otherNote     = planDetail.notes || '';

    /* ---------- 4. 把分鐘換成「幾小時幾分鐘」 ---------- */
    const minutes          = parseInt(duration, 10) || 0;
    const hours            = Math.floor(minutes / 60);
    const remainingMinutes = minutes % 60;
    const formattedTime    = (hours > 0 ? hours + '小時' : '') + remainingMinutes + '分鐘';

    /* ---------- 5. 組合規則文字 ---------- */
    let ruleText = '';
    if (perWeek !== undefined && perWeek !== null)  ruleText += '每週' + perWeek + '次';
    if (perDay  !== undefined && perDay  !== null) {
        if (ruleText) ruleText += '; ';
        ruleText += '每天' + perDay + '次';
    }
    if (ruleText) ruleText += '; ';
    ruleText += '每次' + formattedTime;

    /* ---------- 6. 讀教案基本資料 ---------- */
    let lessonMain;
		$.ajax({
			url: lessonStoreUrl + '/LessonMainInfo/api/get/lessonId/' + lessonIdForStore,
			type: 'GET',
			dataType: 'json',
			async: false, // 同步請求
			success: function(response) {
				lessonMain = response;
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.error('Error with LessonMainInfo:', textStatus, errorThrown);
				console.error('Response Text:', jqXHR.responseText);
				swal('載入教案失敗','請聯絡管理員','error');
			}
		});
		console.log('lessonMain: ', lessonMain);

    const imageUrl   = lessonStoreUrl + '/File/api/file/path' + lessonMain.headerImageUrl   || "";   // 可能是 /images/... 或完整 http 路徑
    const lessonName = lessonMain.lessonName       || "（未命名課程）";
    const startDate  = formatDateNew(planDetail.startDate);
    const endDate    = formatDateNew(planDetail.endDate);

    /* ---------- 7. 更新畫面 ---------- */
    $('.plan-title').text(lessonName + ' 訓練計畫');
    $('.plan-period').text(startDate + ' ~ ' + endDate);
    $('.plan-creator').text(therapistName + ' 治療師');
    $('.plan-rule').text(ruleText);

    if (otherNote.includes('\n')) {
        otherNote = otherNote.replace(/\n/g, '<br>');
        $('.other-note').html(otherNote);
    } else {
        $('.other-note').text(otherNote);
    }

    /* ---------- 8. 追蹤指標 ---------- */
	const achRes = wg.evalForm.getJson(JSON.stringify({"lessonId": lessonIdForStore}), lessonStoreUrl + '/LessonAchievement/api/lesson');
	console.log('achRes', achRes);


    const lessonAch      = achRes;
    const trainingLesson = planDetail.lessons[0];
    const achievements   = trainingLesson.achievements || [];
    const statistics     = trainingLesson.statistics  || [];

    $('#target-table tbody').empty();

    if (achievements.length === 0 && statistics.length === 0) {
        $('#target-table').remove();
        $('.training-target').append('<div class="no-target-msg">此計畫無追蹤目標</div>');
    } else {
        /* ----- 成就目標 ----- */
        achievements.forEach(achTarget => {
            lessonAch.forEach(ach => {
                if (achTarget.apiName == ach.apiName) {
                    const achName  = ach.displayName;
                    const achDes   = ach.description;
                    const achImage = lessonStoreUrl + '/File/api/file/path' + ach.unlockedIconUrl;
                    $('#target-table tbody').append(`
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
                        </tr>
                    `);
                }
            });
        });

        /* ----- 統計目標 ----- */
        statistics.forEach(statsTarget => {
            $('#target-table tbody').append(`
                <tr>
                    <td>統計</td>
                    <td>` + statsTarget.apiName + ` &gt; ` + statsTarget.valueGoal + `</td>
                </tr>
            `);
        });
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
