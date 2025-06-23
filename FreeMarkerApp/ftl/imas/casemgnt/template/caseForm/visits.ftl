<#import "/util/spring.ftl" as spring />

<div id="content">
	<div class="summary-card">
	    <div class="row">
	        <!-- 項目 1: 前次醫師看診時間 -->
	        <div class="col-md-2 summary-item">
	            <h6 class="summary-label">前次醫師看診時間</h6>
	            <p class="summary-value"><#if lastDoctorVisit??>${lastDoctorVisit}<#else>---</#if></p>
	        </div>
	        <!-- 項目 2: 前次治療師看診時間 -->
	        <div class="col-md-2 summary-item">
	            <h6 class="summary-label">前次治療師看診時間</h6>
	            <p class="summary-value"><#if lastTherapistVisit??>${lastTherapistVisit}<#else>---</#if></p>
	        </div>
	        <!-- 項目 3: 治療週數 -->
	        <div class="col-md-2 summary-item">
	            <h6 class="summary-label">治療週數</h6>
	            <p class="summary-value"><#if treatmentWeeks??>${treatmentWeeks} 週<#else>---</#if></p>
	        </div>
	    </div>
	</div>
	<#if hcRecords?? && (hcRecords?size>0) >
	<div class="col-md-12 pd-h-0 d-flex g-10">
		<div class="col-md-5 pd-h-0 timeline-card">
			<ul class="timeline">
				<#list hcRecords as hcRecord>
				<li data-keyno="${hcRecord.id}">
					<div class="visit-tag-block <#if hcRecord.isFirstDiag>tag-first<#else>tag-follow-up</#if>">
                        <span class="type"><#if hcRecord.isFirstDiag>初診<#else>複診</#if></span>
                        <#if !hcRecord.isFirstDiag>
                        <span class="count">第 ${hcRecord.diagTimes} 次</span>
                        </#if>
                    </div>
                    <!-- 主要內容區塊 -->
                    <div class="visit-content">
                        <div class="visit-time">${hcRecord.diagDateTime}</div>
                        <div class="visit-details">
                            <p><span class="label">診斷人員：</span>${hcRecord.doctorName} ${hcRecord.doctorAlias}</p>
                            <p><span class="label">診斷(ICD-10)：</span><span class="icd-code">${hcRecord.icdCode}</span></p>
                        </div>
                    </div>
				</li>
				</#list>
			</ul>
		</div>
		<div class="col-md-7 pd-h-0 visit-card">
			<div id="report-container" class="report"></div>
		</div>
	</div>
	<#else>
	<!-- 無資料呈現 -->
	<div class="cnt-empty">目前尚無就診歷程</div>
	</#if>
	
	<script>
	$(".timeline li").click(function(e){
		e.preventDefault();
		
		var block = $(this);
		var keyno = block.attr("data-keyno");
		
		if (block.hasClass("selected")) {
			block.removeClass("selected");
			wg.template.updateNewPageContent('report-container', 'report-content', {}, '/ftl/imas/diagnosisReport/msg/emptyMessage');
		}else{
			$(".timeline li").removeClass("selected");
			block.toggleClass("selected");
			console.log("keyno: " + keyno);
			wg.template.updateNewPageContent('report-container', 'report-content', {}, '/ftl/imas/diagnosisReport?id=' + keyno);
		}
	
	});
	</script>
	
	<style>
    
    /* 摘要資訊卡片 */
    .summary-card {
        background-color: #f8f9fa; /* Bootstrap 淺灰色背景 */
        border: 1px solid #dee2e6;
        border-radius: 8px; /* 更圓潤的邊角 */
        padding: 10px;
        text-align: center; /* 讓內容置中 */
        margin-bottom: 0.5rem;
    }
    
    .summary-item h6{
    	margin-top: 0px;
    	margin-bottom: 5px;
    }
    
    .summary-item .summary-value{
    	font-size: 1.6rem;
    	font-weight: 600;
    	margin-bottom: 0px;
    }
    
    .timeline-card ul.timeline {
	    list-style-type: none !important;
	    position: relative !important;
	}
	
	ul.timeline:before {
	    content: ' ';
	    background: #d4d9df;
	    display: inline-block;
	    position: absolute;
	    left: 29px;
	    width: 2px;
	    height: 100%;
	    z-index: 1;
	}
	
	ul.timeline > li {
	    margin: 10px 0;
	    margin-left: 20px;
	    padding: 10px;
	    border: 1px solid #d9d9d9;
	    border-radius: 5px;
	    display: flex;
	    align-items: center;
	    gap: 15px;
	    transition: all 0.3s ease;
	}
	
	ul.timeline > li:hover{
		cursor: pointer;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
	}
	
	ul.timeline > li:before {
	    content: ' ';
	    background: white;
	    display: inline-block;
	    position: absolute;
	    border-radius: 50%;
	    border: 3px solid #22c0e8;
	    left: 20px;
	    width: 20px;
	    height: 20px;
	    z-index: 2;
	    box-sizing: border-box;
	}
	
	ul.timeline > li.selected{
		border-left: 6px solid #cc6600;
	}
	
	/* 初複診與次數的卡片風格區塊 */
    .visit-tag-block {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 10px 15px; /* 內部填充 */
        color: #fff;
        text-align: center;
        border-radius: 5px; /* 圓角 */
        flex-shrink: 0; /* 防止此塊被壓縮 */
        min-width: 65px; /* 最小寬度確保內容不換行 */
    }
    
    .tag-first {
        background-color: #16a085; /* 樣式二的綠松石色 */
    }
    
    .tag-follow-up {
        background-color: #2980b9; /* 樣式二的藍色 */
    }
    
    .visit-tag-block .type {
        font-size: 1.1em; /* 較大的字體表示初診/複診 */
        font-weight: bold;
        line-height: 1.1;
    }
    
    .visit-tag-block .count {
        font-size: 0.85em; /* 較小的字體表示次數 */
        margin-top: 4px;
        opacity: 0.9;
    }

    /* 主要內容區塊 */
    .visit-content {
        flex-grow: 1; /* 佔據剩餘空間 */
        padding-top: 5px; /* 與左側標籤塊頂部對齊 */
    }

    .visit-time {
        font-weight: bold;
        color: #2c3e50;
        font-size: 1.1em;
        margin-bottom: 5px;
    }

    .visit-details p {
        margin: 4px 0;
        line-height: 1.6;
        color: #555;
    }

    .visit-details .label {
        font-weight: bold;
        color: #333;
        padding: 0 !important;
        font-size: inherit;
    }
    
    .visit-details .therapist-type {
        font-style: italic;
        color: #777;
    }

    .visit-details .icd-code {
        background-color: #ecf0f1;
        padding: 3px 6px;
        border-radius: 4px;
        color: #555;
    }
    
    .report{
    	padding: 5px 10px;
    }

	.visit-card{
		border: 0.5px solid #e6e6e6;
		margin: 10px 0 10px 10px;
		min-height: 300px;
		max-height: 450px;
	}
	
	</style>
</div>