<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<script>

	SideMenuFn	= {

	    // nav > ul > li  > ul > li		
		click : function() {
			
			var that = this;
			
			// Main-Menu-Click-Event
			$(".has-arrow").on("click", function() {
				
				var $this = $(this);
				
				$("#sidebarnav").find("a").removeClass("custom-active-bold");
				$this.addClass("custom-active-bold");
			});
			
			// Sub-Menu-Click-Event
			$("li > ul > li > a").on("click", function() {
				
				var $this = $(this);

				// that.active($this);
				
				TabMenuFn.tabCheckYn($this);
				
				
				//$this.closest("ul").closest("li").addClass("selected")
			});
		},
		
		active : function(code) {		
			
			var $dataCode 	= $("[data-code=" + code + "]");
			var selectedUl	= $dataCode.closest("ul");
			
			$("#sidebarnav").find("a").removeClass("active custom-active-bold");
			$("#sidebarnav").find("ul").removeClass("in");
			$("#sidebarnav").find("li").removeClass("selected");
			
			selectedUl.addClass("in");
			selectedUl.prev().addClass("active custom-active-bold");
			selectedUl.parent().addClass("selected");
			$dataCode.addClass("active custom-active-bold");
			
		},
	};
	
	// Document Ready
	$(function() {
		
		SideMenuFn.click();
	});
</script>


<aside class="left-sidebar">
    
    <div class="d-flex no-block nav-text-box align-items-center">
		<!-- Logo -->
		<span><img src="<c:url value='/common/eagleeye-admin/assets/images/eagleeye-white-logo-2.png '/>" class="left-sidebar-logo" alt="elegant admin template" /></span> </a>
        <a class="nav-lock waves-effect waves-dark ml-auto hidden-md-down" href="javascript:void(0)"><i class="mdi mdi-toggle-switch"></i></a>
        <a class="nav-toggler waves-effect waves-dark ml-auto hidden-sm-up" href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
    </div>
    
    <!-- Sidebar scroll-->
    <div class="scroll-sidebar">
    
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav">
            <ul id="sidebarnav"> 
             	<c:forEach items="${menuSelectList}" var="mainMenuList">
             		<c:if test="${mainMenuList.catLv eq 1}">
		             	<li>
		             		<a class="has-arrow waves-effect waves-dark side-main-menu" href="javascript:void(0)" aria-expanded="false"><i class="<c:out value='${mainMenuList.catIconNm}'/>"></i>
		             			<span class="hide-menu"><c:out value="${mainMenuList.catEngNm}"/></span>
		             		</a>
		                    <ul aria-expanded="false" class="collapse">
		                    	<c:forEach items="${menuSelectList}" var="subMenuList">
		                    		<c:if test="${subMenuList.catLv eq 2 && subMenuList.upprCatCd eq mainMenuList.catCd}">
		                    			<li id="subMenuListLiTag">
		                    				<a href="#" data-code="<c:out value='${subMenuList.catEngNm}'/>" data-url="<c:out value='${subMenuList.catEngNm}'/>"><c:out value="${subMenuList.catEngNm}"/>
		                    					<i class="fa fa-circle-o text-success"></i>
		                    				</a>
		                    			</li>
		                    		</c:if>
		                    	</c:forEach>
		                    </ul>
		                </li>             		
             		</c:if>
             	</c:forEach>
             	<li class="nav-small-cap"></li>       
             	           
                <li> <a class="has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="icon-speedometer"></i><span class="hide-menu">Dashboard <span class="badge badge-pill badge-cyan">4</span></span></a>
                    <ul aria-expanded="false" class="collapse">
                        <li><a href="index.html">Minimal <i class="fa fa-circle-o text-success"></i></a></li>
                        <li><a href="index2.html">Analytical <i class="fa fa-circle-o text-info"></i></a></li>
                        <li><a href="index3.html">Demographical <i class="fa fa-circle-o text-danger"></i></a></li>
                        <li><a href="index4.html">Modern <i class="fa fa-circle-o text-warning"></i></a></li>
                        <li><a href="index5.html">Cryptocurrency <i class="fa fa-circle-o text-primary"></i></a></li>
                    </ul>
                </li>
                <li class="nav-small-cap"></li>
                <li> <a class="waves-effect waves-dark" href="http://www.wrappixel.com/demos/admin-templates/elegant-admin/documentation/documentation.html" aria-expanded="false"><i class="fa fa-circle-o text-danger"></i><span class="hide-menu">Documentation</span></a></li>
                <li> <a class="waves-effect waves-dark" href="pages-login.html" aria-expanded="false"><i class="fa fa-circle-o text-success"></i><span class="hide-menu">Log Out</span></a></li>
                <li> <a class="waves-effect waves-dark" href="pages-faq.html" aria-expanded="false"><i class="fa fa-circle-o text-info"></i><span class="hide-menu">FAQs</span></a></li>
            </ul>
        </nav>
        <!-- End Sidebar navigation -->
    </div>
    <!-- End Sidebar scroll-->
</aside>