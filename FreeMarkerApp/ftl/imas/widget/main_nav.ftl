
					<!-- Navbar Right Menu -->
              		<div class="navbar-custom-menu">
                		<ul class="nav navbar-nav">
                  			<!-- Notifications Menu -->
                  			<li class="dropdown"><a data-toggle="tooltip" title="內頁縮放" onclick='tooglePageContent();'><i id="tooglePageContent" class="" aria-hidden="true" style="font-size:22px; position:relative; top:3px;"></i></a></li>
    						<#--<#if !testPageUrl??>
    						<li class="dropdown"><a data-toggle="tooltip" title="APP下載" href="${base}/baby/apk"><i class="fa fa-android" style="font-size:26px;"></i></a></li>
    						</#if>-->		                	
		                	<#--<li class="dropdown"><a data-toggle="tooltip" title="站內搜索" href="${base}/search/site"><i class="fa fa-fw fa-search"></i></a></li>-->
		                	<#if employee?exists && employee=="true" && employeeNavItems?exists>
		                		<#if foodAlertUser?? && foodAlertCount??>
			                		<li class="dropdown tasks-menu">
				                		<a href="#" class="dropdown-toggle dropdown mlog-tooltip" data-toggle="dropdown" data-original-title="待辦事項">
						                  <i class="fa fa-flag-o"></i>
						                  <span class="label label-danger">${foodAlertUser?size}</span>
						                </a>
						                <ul class="dropdown-menu">
						                	<#if foodAlertUser?size==0>
						                		<li class="header" style="height:inherit;">飲食評估皆已完成!</li>
						                	<#else>
	                  							<li class="header" style="height:inherit;">尚有${foodAlertUser?size}位用戶需要您的關心!</li>
	                  						</#if>
		                  					<li>
		                    					<!-- inner menu: contains the actual data -->
		                    					<ul class="menu">
		                    						<#list foodAlertUser as item>
								                    	<li><!-- Task item -->
								                      		<a href="${base}/employee/redirect?id=62&amp;uid=${item.id}" onclick="openWindow(this); return false;">
								                      			${item.name!""}(${foodAlertCount[item_index]!""}則)
								                      		</a>
								                      	</li><!-- end task item -->
													</#list>
		                						</ul>
											</li>
										</ul>
									</li>
								</#if>
			                	<li class="dropdown" data-toggle="modal" data-target="#globalModal" onclick="openCertDialog();">
			                		<a data-toggle="tooltip" title="證照提醒" id="animated-bell"> 
										<i class="fa fa-bell" aria-hidden="true" style="font-size:20px; position:relative; top:4px;"></i><span id="animated-bell-count" class="">(${unreadDiscussMsg!""})</span>
									</a>
								</li>
							<#else>

							</#if>
		                	<#if currentUser?exists >
			                	<!-- User Account Menu -->
				                <li class="dropdown user user-menu">
				                	<!-- Menu Toggle Button -->
				                	<a href="#" class="dropdown-toggle" data-toggle="dropdown">
			    	            		<#--<i class="fa fa-gears"></i>-->
			    	            		<i class="fa fa-user" aria-hidden="true"></i>
			        	         		<!-- hidden-xs hides the username on small devices so only the image appears. -->
			            	        	<span class="hidden-xs">${currentUser.name}</span>
			                	  	</a>
				                  	<ul class="dropdown-menu">
				                    	<!-- The user image in the menu -->
				                    	<li class="user-header" >
				                    		<div class="user-avatar">
					                    		<#if currentUser.userData.avatar??>
					                    			<img style="height:90px;width:90px" src="${base}${currentUser.userData.avatar}">
					                    		<#else>
					                    			<i class="fa fa-fw fa-user" style="font-size:70px; color:white; margin-top:10px;"></i>
					                    		</#if>
				                    		</div>
			    	                		<p>${currentUser.name}<small><#if currentUser.userData.birthday?exists> ${currentUser.userData.birthday?string("yyyy/MM/dd")}</#if></small></p>
			        	            	</li>
			            	        	<!-- Menu Body -->
			                	    	<@tldwidget.placeholder path="/widget/subHeaderForRole2" cache=false idle=10 live=10/>
			                    		<!-- Menu Footer-->
			                      		<li class="user-footer">
				                      		<div class="pull-left">
					                        	<a href="${base}/user/maintain/mustdata2" class="btn btn-default btn-flat" style="background: white; border: 1px solid #ccc; height: inherit; padding: 6px 12px;">基本資料</a>
				                        	</div>
				                        	<div class="pull-right">
					                        	<a href="${base}/logout" class="btn btn-default btn-flat" style="background: white; border: 1px solid #ccc; height: inherit; padding: 6px 12px;">登出</a>
				                        	</div>
				                      	</li>
			                    	</ul>
			                	</li>
							<#else>
								<!--<li class="dropdown"><a href="${base}/user/maintain/mustdata2" title="會員中心">會員中心</a></li>-->
								<!--<li class="dropdown">
									<a href="${base}/zh_TW/login" onclick="setLanguage('zh_TW')" title="<@spring.message "mainnav.label.lang.zhTW"/>"><@spring.message "mainnav.label.lang.zhTW"/></a>
								</li>
								<li class="dropdown">
									<a onclick="setLanguage('en_US')" title="<@spring.message "mainnav.label.lang.enUS"/>"><@spring.message "mainnav.label.lang.enUS"/></a>
								</li>
								<li class="dropdown">
									<a onclick="setLanguage('th_TH')" title="<@spring.message "mainnav.label.lang.thTH"/>"><@spring.message "mainnav.label.lang.thTH"/></a>
								</li>-->
						   </#if>	
						</ul>
					</div><!-- /.navbar-custom-menu -->

					<script>
						$(document).ready(function(){
							
						});
					
						function setLanguage(obj){
							console.log('language:', obj);
							var lang = $(obj).val();
							document.cookie = "_freemarker_lang=" + lang + "; path=/;"
							window.location = "/ftl/imas/login";
						}

						// 取得 Cookie 值的工具函式
						function getCookie(name) {
						const match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
						return match ? decodeURIComponent(match[2]) : null;
						}

						// 根據 cookie 設定語言下拉選單的預設值
						(function setLangFromCookie() {
						const lang = getCookie('_freemarker_lang');
						const langSelect = document.getElementById('langSelect');
						if (lang && langSelect) {
							langSelect.value = lang;
						}
						})();
						
						/*function setLanguage(lang){
							var postData = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/setLanguage?lang=" + lang);
						    if(postData.success){
						    	window.location = "${base}/" + lang + "/login";
					    	}
						}*/
					</script>