<script>
$(document).ready(function(){
	//getCurrentArchivePatientId();
});

$('#breadcrumbs').breadcrumbsGenerator({
  	sitemaps  : '#sitemaps',
  	index_type: '${base}/home'
});


//拖曳左方清單導覽列
$("#btn").click(function(){
	$(".sidebar").toggleClass("active");		
	
});

//切換功能模組
$(".module-blk, .tab-name").click(function(){
	var srcName = $(this).data('src');
	//window.location = "${base}/" + srcName;
	window.location = srcName;

});


$(".nav_list li a").click(function(){
	var length = $(".nav_list").find(".arrow-rotate").length;
	var actived = $(this).is(".active");

	if(length > 0 && !actived){
		toggle("active");
		toggle("arrow-rotate");
		toggle("show");
	}
	$(this).toggleClass("active");
	$(this).parent("li").find(".sub-menu").toggleClass("show");
	$(this).find("span").next("i").toggleClass("arrow-rotate");
});

$(".upper").keyup(function(evt){ 
	var vOri = $(this).val(); 
    var vNew = vOri.toUpperCase(); 
    $(this).val(vNew); 
});
       
$(".lower").keyup(function(evt){ 
    var vOri = $(this).val(); 
    var vNew = vOri.toLowerCase(); 
    $(this).val(vNew); 
});

function toggle(className){
	$(".nav_list").find("." + className).toggleClass(className);
}

//使用者登出
function logout(){
	confirmCheck("<@spring.message "widget.label.logout.title"/>", "<@spring.message "widget.label.logout.text"/>", "warning", "btn-info", "<@spring.message "widget.button.confirm"/>", "<@spring.message "widget.button.cancel"/>", function(confirmed){
		if(confirmed){
			window.location.href = "/ftl/imas/logout";
		}
	});
}

//讀取健保卡
function readCard(){

	var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/readHealthIDCard?userId=" + ${currentUser.id!""});
	
	if(result.success){	
		if(result.patientId != ""){
			if(result.exist){
				swal({
				  	title: "<@spring.message "widget.label.readcard.success.title"/>",
				  	text: "<@spring.message "widget.label.readcard.success.text"/>",
				  	type: "success",
				  	timer: 2000,
				  	showConfirmButton: false
				},function(){
					$("#myModal").modal('hide');
				    window.location = "${base}/${__lang}/division/web/patient/" + result.keyno + "/inspection";
				});				
			}
	    }
	    else{
	    	swal("<@spring.message "widget.label.readcard.fail.title"/>", "<@spring.message "widget.label.readcard.fail.text"/>", "error");
	    }
	}
	else{
		swal("<@spring.message "widget.label.readcard.fail.title"/>", "<@spring.message "widget.label.readcard.fail.text"/>", "error");
	}
}

//定期顯示目前歸檔資訊
setInterval(function(){
	//getCurrentArchivePatientId();
},8000);

//顯示目前歸檔資訊
function getCurrentArchivePatientId(){
	var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/getCurrentPatientId");
	if(result.success){
		$(".archive-info").find("span").html(result.patientName);
	}
}

function setArchivePatient(){
	$(".patient-code").select2({
        language: '${__lang}',
        width: '100%',
        maximumInputLength: 10,
        minimumInputLength: 1,
        placeholder: '<@spring.message "widget.placeholder.search"/>',
        dropdownParent: $('#archiveModal'),
        allowClear: true,
        ajax: {
            url: '${base}/division/api/getAllArchivePatientInfo',
            type: 'POST',
            data: function (params){
                return {
                    queryParam: params.term 
                };
            },
            processResults: function (data, params){

 				var obj = JSON.parse(data);

                return {
                    results: obj.data,
                    pagination: {
                        more: false
                    }
                }
            }
        }
    });
	$("#archiveModal").modal('show');
}

function updateArchiveInfo(){
	var keyno = $(".patient-code").find("option").last().val();
	var result = wg.evalForm.getJson({"data":JSON.stringify()}, "${base}/division/api/setArchivePatientInfo?keyno=" + keyno);
	if(result.success){
		$("#archiveModal").modal('hide');
		swal("<@spring.message "widget.label.settings.success.title"/>", "<@spring.message "widget.label.settings.success.text"/>", "success");
		//getCurrentArchivePatientId();
	}
	else{
		swal("<@spring.message "widget.label.settings.fail.title"/>", "<@spring.message "widget.label.settings.fail.text"/>", "error");
	}
}

//展示隱藏重要個資用
function replaceTxt(txt) {
    if(txt.length > 4){
    	if(txt.length === 10) {
	        return txt.substring(0, 3) + 'OOOO' + txt.substring(7, 10);
	    }else if(txt.length < 10 && txt.length > 0) {
	        return txt.substring(0, txt.length-2) + 'OO';
	    }else{
    		return txt.substring(0, txt.length-2) + 'OO';
		}
    }else{
    	if(txt.length === 2){
    		return txt[0] + 'O';
    	}else if (txt.length === 3) {
	        return txt[0] + 'O' + txt[2];
	    }else if (txt.length === 4) {
	        return txt[0] + 'OO' + txt[3];
	    }else {
	        return txt;
	    }
    }  
}

</script>
