<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<script>

	pageTitleFn = {
		
		homeClick 	: function() {
			
			// Tab States Change  at the 'Main'
			TabMenuFn.tabToggle("Main");
			TabMenuFn.tabActive("Main");
			
			// Side State Change at the 'Main'
			SideMenuFn.active("Main");
		},
	
		titleToggle	: function($aTag) {
			
			var $dataUrl 	= $aTag.data("url")
			var $dataCode 	= $aTag.data("code")
			
			$("#mainTitle").text($dataUrl);
			$("#pathTitle").text($dataCode);
			
			
			if ($dataCode === "Main") {
				
				$("#closeTabBtn").find("i").text("  Refresh");
				$("#closeTabBtn").find("i").removeClass("fa fa-times-circle");
				$("#closeTabBtn").find("i").addClass("fas fa-registered");
				
				$("#closeTabBtn").removeClass("btn waves-effect waves-light btn-danger d-none d-lg-block m-l-15");
				$("#closeTabBtn").addClass("btn waves-effect waves-light btn-primary d-none d-lg-block m-l-15");
			} else {
				
				$("#closeTabBtn").find("i").text("  Closed");
				$("#closeTabBtn").find("i").removeClass("fas fa-registered");
				$("#closeTabBtn").find("i").addClass("fa fa-times-circle");
				
				$("#closeTabBtn").removeClass("btn waves-effect waves-light btn-primary d-none d-lg-block m-l-15")
				$("#closeTabBtn").addClass("btn waves-effect waves-light btn-danger d-none d-lg-block m-l-15");
			}
			
		}
	
	
	};
	
	$(function() {
		
		pageTitleFn.titleToggle($("[data-code=Main]"));
	});

</script>

<div class="row page-titles">
    <div class="col-md-5 align-self-center">
        <h4 class="text-themecolor active" id="mainTitle"></h4>
    </div>
    <div class="col-md-7 align-self-center text-right">
        <div class="d-flex justify-content-end align-items-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#" onclick="pageTitleFn.homeClick()">Home</a></li>
                <li class="breadcrumb-item active" id="pathTitle"></li>
            </ol>
            <button id="closeTabBtn" type="button" class="btn waves-effect waves-light btn-danger d-none d-lg-block m-l-15"><i class="fa fa-times-circle">  Closed Tab</i></button>
        </div>
    </div>
</div>