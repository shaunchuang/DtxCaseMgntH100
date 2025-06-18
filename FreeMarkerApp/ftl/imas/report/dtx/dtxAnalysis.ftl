<#include "/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "leftnav.submenu.lessonIndex"/></div>
				</div>
            </div>
            <!-- 各功能模組內容放置區 -->
            <div class="clearfix"></div>
            <div class="main-content">
                <div id="dashboard-container">
                </div>
                <iframe
                  width="100%"
                  height="700"
                  seamless
                  frameBorder="0"
                  scrolling="yes"
                  locale="zh_TW"
                  src="http://localhost:8088/superset/dashboard/12/?standalone=1&height=700"
                >
                </iframe>
            </div>
        </div>
	</div>		
</body>
<script src="https://unpkg.com/@superset-ui/embedded-sdk"></script>
<script>
/*supersetEmbeddedSdk.embedDashboard({
  id: "9397c17d-8a8c-43c2-b60f-79d38c44457a", // given by the Superset embedding UI
  supersetDomain: "http://localhost:8088", // your Superset domain
  mountPoint: document.getElementById("dashboard-container"), // any html element that can contain an iframe
  //fetchGuestToken: () => fetchGuestTokenFromBackend(),
  fetchGuestToken: fetchGuestTokenFromBackend,
  dashboardUiConfig: { // dashboard UI config: hideTitle, hideTab, hideChartControls, filters.visible, filters.expanded (optional), urlParams (optional)
      hideTitle: true,
      filters: {
          expanded: true,
      },

  },
    // optional additional iframe sandbox attributes
  iframeSandboxExtras: ['allow-top-navigation', 'allow-popups-to-escape-sandbox']
});*/
</script>