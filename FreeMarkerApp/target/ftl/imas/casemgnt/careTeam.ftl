<#include "/skins/imas/widget/leftnav.ftl" />
		<div class="custom-blk">
			<!-- 模組標題與功能模組放置區 -->
			<div class="col-md-12 sub-bar">
				<div class="col-md-6 item-title">
					<div class="item-name"><@spring.message "casemgnt.label.caseView.title"/></div>
					<span class="patient-hint">${patientName!""}</span>
				</div>
				<div class="col-md-12 module-list">
					<div class="module-blk" data-src="home">
						<i class="fa fa-circle-arrow-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.back"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/caseView">
						<i class="fa fa-circle-user fa-lg"></i>
						<span><@spring.message "casemgnt.menu.view"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/inspection">
						<i class="fa fa-stethoscope fa-lg"></i>
						<span><@spring.message "casemgnt.menu.cure.history"/></span>
					</div>
					<div class="module-blk" data-src="">
						<i class="fa fa-chart-simple fa-lg"></i>
						<span><@spring.message "casemgnt.menu.state"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/hcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.hcRecord"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/ltcRecord">
						<i class="fa fa-id-card fa-lg"></i>
						<span><@spring.message "casemgnt.menu.ltcRecord"/></span>
					</div>
					<div class="module-blk" data-src="">
						<i class="fa fa-file-waveform fa-lg"></i>
						<span><@spring.message "casemgnt.menu.evaluation"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/careCourse">
						<i class="fa fa-clock-rotate-left fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careCourse"/></span>
					</div>
					<div class="module-blk" data-src="${__lang}/division/web/patient/${formId!""}/carePlan">
						<i class="fa fa-clipboard-list fa-lg"></i>
						<span><@spring.message "casemgnt.menu.carePlan"/></span>
					</div>
					<div class="module-blk active" data-src="${__lang}/division/web/patient/${formId!""}/careTeam">
						<i class="fa fa-people-group fa-lg"></i>
						<span><@spring.message "casemgnt.menu.careTeam"/></span>
					</div>
				</div>           
			</div>
			<!-- 各功能模組內容放置區 -->
			<div class="clearfix"></div>
			<div class="main-content">
				<div class="careTeam col-xs-12 pd-h-0">
					<div class="team-blk col-xs-3 pd-h-0">
						<div class="team-title">
							<i class="fa fa-caret-right fa-lg"></i> <@spring.message "careTeam.label.attendingDoctor"/>
						</div>
						<div class="major-doctor">
							<#list memberInfo as info>
							<#assign role = info.roleId>
							<#if role == 3>
							<div class="member">
								<div class="img-blk">
									<img src="${base}/images/imas/role/doctor.png" />
								</div>
								<div class="member-info">
									<p>${info.divisionName!""}</p>
									<p><b>${info.name!""}</b> ${info.role!""}</p>
									<p>(${info.userNo!""})</p>
								</div>
							</div>
							</#if>
							</#list>
						</div>
					</div>
					
					<div class="team-blk col-xs-9 pd-h-0">
						<div class="team-title">
							<i class="fa fa-caret-right fa-lg"></i> <@spring.message "careTeam.label.memberlist"/>
							<button class="func-btn mg-left-5 pull-right" onclick="openGroupWindow('${formId!""}')">
								<i class="fa fa-edit"></i> <@spring.message "careTeam.button.edit"/>
							</button>
							<button class="func-btn mg-left-5 pull-right" onclick="enterChatGroup()">
								<i class="fa fa-arrow-circle-left"></i> <@spring.message "careTeam.button.chat"/>
							</button>					
						</div>
						<div class="team-list">
							<#list memberInfo as info>
							<#assign role = info.roleId>
							<#if role != 3>
							<div class="member">
								<div class="img-blk">
									<#if role == 4>
									<img src="${base}/images/imas/role/nurse.png" />
									<#elseif role == 5>
									<img src="${base}/images/imas/role/manager.png" />
									<#elseif role == 6>
									<img src="${base}/images/imas/role/doctor.png" />
									</#if>
								</div>
								<div class="member-info">
									<p>${info.divisionName!""}</p>
									<p><b>${info.name!""}</b> ${info.role!""}</p>
									<p>(${info.userNo!""})</p>
								</div>
							</div>
							</#if>
							</#list>
						</div>
					</div>		
				</div>
			</div>
		</div>	
	</div>
</body>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog " style="width:700px;">
		<div class="modal-content" >
			<div class="modal-header">
				<@spring.message "careTeam.label.recommend"/>
				<button type="button" class="close clean" data-dismiss="modal" data-form="0" aria-label="Close">
		          	<i class="fa fa-xmark" aria-hidden="true"></i>
		        </button>
			</div>
			<div class="modal-body">
				<table class="info info-style-2">
					<tr>
						<td><@spring.message "careTeam.label.ptno"/></td>
						<td>
							<input type="text" class="form-control" value="${idno!""}" readOnly />
						</td>
						<td><@spring.message "careTeam.label.name"/></td>
						<td>
							<input type="text" class="form-control" value="${patientName!""}" readOnly />
						</td>
						<td><@spring.message "careTeam.label.gender"/></td>
						<td>
							<input type="text" class="form-control" value="${gender!""}" readOnly />
						</td>
						<td><@spring.message "careTeam.label.age"/></td>
						<td>
							<input type="text" class="form-control" value="${age!""}" readOnly />
						</td>
					</tr>
				</table>
				<form class="reg" >
					<select id="recommend-list" multiple="multiple">
						<#list memberList as member>
						<optgroup label="${member.memberTitle!""}">
						<#assign itemList = member.careMember>
						<#list itemList as item>
	                        <option data-id="${item.id!""}" data-mail="${item.email!""}" <#if selectedMemberNoArr?seq_contains(item.id)>selected</#if> >${item.institution!""} ${item.divisionName!""} ${item.name!""} ${item.role!""}</option>
						</#list>
	                    </optgroup>
	                    </#list>
					</select>
				</form>               
			</div>
			<div class="modal-footer">         
				<button class="func-btn" onclick="editGroup('${formId!""}')"><@spring.message "careTeam.button.update"/></button>
				<button class="clean func-btn" data-dismiss="modal"><@spring.message "careTeam.button.cancel"/></button>
			</div>
		</div>
	</div>
</div>

<script>

$(document).ready(function(){
	//var postData = {"creatorId":${currentUser.id!""}, "userFormKeyNo": "0000000218", "items": [{"itemId": 945, "ans": "34.6", "op": "e"}]};
	//var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/multi/division/v1/api/editUserForm?");
});

function openGroupWindow(id){
	if("${verifyCode!""}" != ""){
	    
	    $("#recommend-list").multi({
	    	enable_search: true,
	        search_placeholder: '<@spring.message "careTeam.placeholder.search.hint"/>',
			non_selected_header: '<@spring.message "careTeam.label.notselected.header"/>',
			selected_header: '<@spring.message "careTeam.label.selected.header"/>'
	    });
	    
		$("#myModal").modal('show');
	}else{
		swal("<@spring.message "careTeam.save.fail.addTitle"/>", "<@spring.message "careTeam.save.fail.addText"/>", "error");
	}
}

function editGroup(id){
	var selectedArr = [];
	var selectedMailArr = [];
	$("#recommend-list").find('option:selected').each(function(){
		selectedArr.push($(this).attr("data-id"));
		selectedMailArr.push($(this).attr("data-mail"));
	});
	var postData = {"userFormKeyNo": "${formId!""}", "userIds": selectedArr};
	var result = wg.evalForm.getJson({"data":JSON.stringify(postData)}, "${base}/division/api/createCaseGroup");
	if(result.success){
		addRoomInfo(selectedMailArr);		
	}
}

//客製化確認彈跳視窗
/*function confirmCheck(title, subText, type, confirmButtonText, callback){
	swal({
		title: title,
	  	text: subText,
	  	type: type,
	  	showCancelButton: false,
	  	confirmButtonClass: "btn-success",
	  	confirmButtonText: confirmButtonText
	},function(confirmed){
		return callback(confirmed);
	});
}*/

function addRoomInfo(selectedMailArr){
	var queryData = {"ownerMail": "${currentUser.email !""}", "patient": "${patientName!""}", "verifyCode": "${verifyCode!""}", "userMails": selectedMailArr, "title": "${title!""}"};
	$.ajax({
	    type: "POST",
	    url: "http://localhost:8080/WebSocket/chatroom/addRoomInfo",
	    data: {"data":JSON.stringify(queryData)},
	    async: false,
		dataType: "json",
	    success: function(data){
	       if(data.data.success){
	       		successToDirect("<@spring.message "careTeam.save.success.addTitle"/>", "<@spring.message "careTeam.save.success.addText"/>", "success", 1500, "${base}/${__lang}/division/web/patient/${formId!""}/careTeam");
	       }                    	            	            
	    },
	    error: function(){
	    	swal("<@spring.message "careTeam.send.fail.title"/>", "<@spring.message "careTeam.send.fail.text"/>", "error");
	    }
	});
}

//進入個案群組討論
function enterChatGroup(){
	<#if sendingRoomId?exists && sendingRoomId?has_content>
	window.open("${base}/${__lang}/division/web/communication/chatroom/${sendingRoomId!""}");
	<#else>
	confirmCheck("尚無成員", "該個案群組尚無建立成員，您仍要前往嗎?", "warning", "btn-info", "<@spring.message "inspect.button.confirm"/>", "<@spring.message "inspect.button.cancel"/>", function(confirmed){
		if(confirmed){
			window.open("${base}/${__lang}/division/web/communication/chatroom");
		}
	});	
	</#if>
}	
			
</script>

<style>
.careTeam{
	height: 100%;
	background: #f2f2f2;
}

.careTeam .team-blk{
	height: 100%;
}

.careTeam .team-blk:last-child{
	border-left: 10px solid #FFF;
}

.team-title{
	font-size: 16px;
	font-weight: 600;	
	background: #cccccc;
	color: #666666;
	padding: 8px 10px;
}

.team-title button{
	/*height: 25px;*/
	line-height: 20px;
	margin-top: -5px;
	/*padding: 0 5px !important;*/
}

.major-doctor, .team-list{
	padding: 10px;
}

.major-doctor, .team-list{
	width: 100%;
}

.member{
	width: 150px;
	border-radius: 5px;
	background: #fff;
	padding: 5px;
	margin: 0 10px 10px 0;
	-webkit-box-shadow: 3px 3px #a6a6a6;
	-moz-box-shadow: 3px 3px #a6a6a6;
	box-shadow: 3px 3px #a6a6a6;
	text-align: center;
	display: inline-block;
}

.img-blk{
	width: 100%;
	height: 80px;
	margin-bottom: 5px;
}

.img-blk img{
	height: 80px;
}

.member-info p{
	display: block;
	margin: 0;
}

.member-info p b{
	color: #0073e6;
}

/* modal */
.input-group select{
	width: 150px !important;
}

.info{
	width: 100%;
}

.info > tbody > tr > td{
	text-align: left;
	font-weight: 600;
}

.info > tbody > tr > td:nth-child(odd){
	
}

.info > tbody > tr:not(:last-child) > td{
	border-bottom: 0.5px solid #eeefef;
}

.info > tbody > tr > td{
	padding: 10px 5px ;
	border: 0.5px solid #ffffff;
	font-size: 14px;
}

.info-style-2{
	margin-bottom: 20px;
}

.info-style-2 tbody tr td{
	background: #eee;
	padding: 5px;
	border: none !important;
	border-bottom: 3px solid #b3b3b3 !important;
}

.info-style-2 tbody tr td:nth-child(odd){
	width: 1%;
	white-space: nowrap;
}

.info-style-2 tbody tr td input[type="text"]{
	/*width: 120px !important;*/
	border: none !important;
	padding: 6px;
	text-align: center;
}

</style>

<#include "/skins/imas/casemgnt/socket.ftl" />
<#include "/skins/imas/widget/widget.ftl" />