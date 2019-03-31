<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	
	TabMenuFn = {
		
		tabArr		: ["Main"],
		tabFlag		: "",
		
		tabCheckYn	: function($aTag) {
			
			var that = this;
			
			// Check if a value exists in an 'Array'
			if ($.inArray($aTag.data("code"), that.tabArr) > -1) {
				
				/* Exists - Move Selected Tab View */
				that.tabToggle($aTag.data("code"));
				that.tabActive($aTag.data("code"));
				SideMenuFn.active($aTag.data("code"));
			} else {
				/* Not Exists */
				
				// Check Maximum Number of Tabs
				if (that.tabArr.length >= 6) {
					/* Max Tab Length */
					alert("The maximum number of tabs is 6")
				} else {
					/* Add New Tab */
					that.tabAdd($aTag);
				}
			}
		},
		
		tabAdd		: function($aTag) {
			
			// Dom Init
			var tabRootLi		= document.createElement("li");
			var tabSubA			= document.createElement("a");
			var tabViewSpan1	= document.createElement("span");
			var tabViewSpan2	= document.createElement("span");
			var tabExitBtn		= document.createElement("button");
			var tabConDiv		= document.createElement("div");
			
			// Dom Add Attribute
			tabRootLi.setAttribute("class", "nav-item navbar-tab");
			tabRootLi.setAttribute("data-tab", $aTag.data("code"));
			
			tabSubA.setAttribute("class", "nav-link");
			tabSubA.setAttribute("data-toggle", "tab");
			tabSubA.setAttribute("role", "tab");
			tabSubA.setAttribute("aria-selected", false);
			
			tabViewSpan1.setAttribute("class", "hidden-sm-up");
			tabViewSpan2.setAttribute("class", "hidden-xs-down custom-tab-container");
			tabViewSpan2.textContent = $aTag.text() + "";
			
			tabExitBtn.setAttribute("type", "button");
			tabExitBtn.setAttribute("class", "tab-btn-container fas fa-times");

			tabSubA.appendChild(tabViewSpan1);
			tabSubA.appendChild(tabViewSpan2);
			tabSubA.appendChild(tabExitBtn);
			tabRootLi.appendChild(tabSubA);
			
			// Add tab Array 
			this.tabArr.push($aTag.data("code"));
			
			// Add Id = tabList
			document.getElementById("tabList").appendChild(tabRootLi);

			// Add New Content Div Area
			tabConDiv.setAttribute("id", $aTag.data("code") + "Content");
			$("#tabContentArea").append(tabConDiv);
				
			// Add New Content
			ContentFn.pageLoad($aTag);
			
			// Active Select Tab
			this.tabToggle($aTag.data("code"));
			this.tabActive($aTag.data("code"));
			SideMenuFn.active($aTag.data("code"));
		}, 
		
		tabToggle	: function(code) {
			
			// Init Data Tag 
			var $dataTab	= $("[data-tab="  + code + "]");
			var $dataCode	= $("[data-code=" + code + "]");
			
			console.log($dataCode);
			$("#tabList").find(".tab-btn-container").hide();
			$("#tabList > li").removeClass("custom-active-bold");
			
			// Hide Content
			$("#tabContentArea > div").hide();
			
			// Active Close Btn & Append Bold Texter
			$dataTab.find(".tab-btn-container").show();
			$dataTab.addClass("custom-active-bold");
			pageTitleFn.titleToggle($dataCode);
			
			// Show Content
			$("#" + code + "Content").show();
		},
		
		tabClick	: function() {
			var that = this;
			
			// Remove Btn Click
			$("#tabList").on("click", ".tab-btn-container", that.tabRemove);
			
			$("#tabList").on("click", ".navbar-tab", function() {
				
				if (that.tabFlag === "TAB_STATE_REMOVE") {
					that.tabFlag = "TAB_STATE_GOOD";
				} else {
					
					var tabCode = $(this).data("tab");
					
					that.tabToggle(tabCode);
					SideMenuFn.active(tabCode);
				}
			})
		},
		
		tabActive	: function(code) {
			
			var $dataTab = $("[data-tab=" + code + "]");
			
			$("#tabList > li > a").removeClass("active show");
			$dataTab.children().addClass("active show");
		},
		
		tabRemove	: function() {
			
			var nextIndex;
			var selectTag;
			var $this			= $(this);
			var code 			= $this.closest("li").data("tab");
			var index			= TabMenuFn.tabArr.indexOf(code);
			TabMenuFn.tabFlag 	= "TAB_STATE_REMOVE";

			TabMenuFn.tabArr.splice(index, 1);
			
			$this.closest("li").remove();
			$("#" + code + "Content").remove();
			
			if (index === TabMenuFn.tabArr.length) {
				nextIndex = index -1;
			} else {
				nextIndex = index;
			}
			
			selectTag = TabMenuFn.tabArr[nextIndex];
			
			TabMenuFn.tabToggle(selectTag);
			TabMenuFn.tabActive(selectTag);
			
			SideMenuFn.active(selectTag);
		}
	};

	
	// Document Ready
	$(function() {
		
		TabMenuFn.tabClick();
	});

</script>

<header class="topbar">
    <nav class="navbar top-navbar navbar-expand-md navbar-dark">
        <!-- ============================================================== -->
        <!-- Logo -->
        <!-- ============================================================== -->
        <div class="navbar-header">

        </div>
        <!-- ============================================================== -->
        <!-- End Logo -->
        <!-- ============================================================== -->
        <div class="navbar-collapse nav-container">
            <!-- ============================================================== -->
            <!-- toggle and nav items -->
            <!-- ============================================================== -->
            <ul class="nav navbar-nav mr-auto navbat-tab nav-tabs customtab" role="tablist" id="tabList"> 
	            <li class="nav-item navbar-tab custom-active-bold" data-tab="Main"> <a class="nav-link active show" data-toggle="tab" href="#content" role="tab" aria-selected="true"><span class="hidden-sm-up"></span> <span class="hidden-xs-down custom-tab-container">Main</span></a> </li>
            </ul>
            <ul class="navbar-nav my-lg-0">
                <!-- ============================================================== -->
                <!-- Comment -->
                <!-- ============================================================== -->
                <li class="nav-item hidden-sm-up"> <a class="nav-link nav-toggler waves-effect waves-light" href="javascript:void(0)"><i class="ti-menu"></i></a></li>
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle waves-effect waves-dark" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="ti-email"></i>
                        <div class="notify"> <span class="heartbit"></span> <span class="point"></span> 
                        </div>
                    </a>
                    <div class="dropdown-menu mailbox animated bounceInDown">
                        <span class="with-arrow"><span class="bg-primary"></span></span>
                        <ul>
                            <li>
                                <div class="drop-title bg-primary text-white">
                                    <h4 class="m-b-0 m-t-5">4 New</h4>
                                    <span class="font-light">Notifications</span>
                                </div>
                            </li>
                            <li>
                                <div class="message-center">
                                    <!-- Message -->
                                    <a href="javascript:void(0)">
                                        <div class="btn btn-danger btn-circle"><i class="fa fa-link"></i></div>
                                        <div class="mail-contnet">
                                            <h5>Luanch Admin</h5> <span class="mail-desc">Just see the my new admin!</span> <span class="time">9:30 AM</span> </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="javascript:void(0)">
                                        <div class="btn btn-success btn-circle"><i class="ti-calendar"></i></div>
                                        <div class="mail-contnet">
                                            <h5>Event today</h5> <span class="mail-desc">Just a reminder that you have event</span> <span class="time">9:10 AM</span> </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="javascript:void(0)">
                                        <div class="btn btn-info btn-circle"><i class="ti-settings"></i></div>
                                        <div class="mail-contnet">
                                            <h5>Settings</h5> <span class="mail-desc">You can customize this template as you want</span> <span class="time">9:08 AM</span> </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="javascript:void(0)">
                                        <div class="btn btn-primary btn-circle"><i class="ti-user"></i></div>
                                        <div class="mail-contnet">
                                            <h5>Pavan kumar</h5> <span class="mail-desc">Just see the my admin!</span> <span class="time">9:02 AM</span> </div>
                                    </a>
                                </div>
                            </li>
                            <li>
                                <a class="nav-link text-center m-b-5" href="javascript:void(0);"> <strong>Check all notifications</strong> <i class="fa fa-angle-right"></i> </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- ============================================================== -->
                <!-- End Comment -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Messages -->
                <!-- ============================================================== -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle waves-effect waves-dark" href="" id="2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="icon-note"></i>
                        <div class="notify"> <span class="heartbit"></span> <span class="point"></span> </div>
                    </a>
                    <div class="dropdown-menu mailbox animated bounceInDown" aria-labelledby="2">
                        <span class="with-arrow"><span class="bg-danger"></span></span>
                        <ul>
                            <li>
                                <div class="drop-title text-white bg-danger">
                                    <h4 class="m-b-0 m-t-5">5 New</h4>
                                    <span class="font-light">Messages</span>
                                </div>
                            </li>
                            <li>
                                <div class="message-center">
                                    <!-- Message -->
                                    <a href="javascript:void(0)">
                                        <div class="user-img"> <img src="<c:url value='/common/eagleeye-admin/assets/images/users/1.jpg" alt="user" class="img-circle'/>"> <span class="profile-status online float-right"></span> </div>
                                        <div class="mail-contnet">
                                            <h5>Pavan kumar</h5> <span class="mail-desc">Just see the my admin!</span> <span class="time">9:30 AM</span> </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="javascript:void(0)">
                                        <div class="user-img"> <img src="<c:url value='/common/eagleeye-admin/assets/images/users/2.jpg" alt="user" class="img-circle'/>"> <span class="profile-status busy float-right"></span> </div>
                                        <div class="mail-contnet">
                                            <h5>Sonu Nigam</h5> <span class="mail-desc">I've sung a song! See you at</span> <span class="time">9:10 AM</span> </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="javascript:void(0)">
                                        <div class="user-img"> <img src="<c:url value='/common/eagleeye-admin/assets/images/users/3.jpg" alt="user" class="img-circle'/>"> <span class="profile-status away float-right"></span> </div>
                                        <div class="mail-contnet">
                                            <h5>Arijit Sinh</h5> <span class="mail-desc">I am a singer!</span> <span class="time">9:08 AM</span> </div>
                                    </a>
                                    <!-- Message -->
                                    <a href="javascript:void(0)">
                                        <div class="user-img"> <img src="<c:url value='/common/eagleeye-admin/assets/images/users/4.jpg" alt="user" class="img-circle'/>"> <span class="profile-status offline float-right"></span> </div>
                                        <div class="mail-contnet">
                                            <h5>Pavan kumar</h5> <span class="mail-desc">Just see the my admin!</span> <span class="time">9:02 AM</span> </div>
                                    </a>
                                </div>
                            </li>
                            <li>
                                <a class="nav-link text-center link m-b-5" href="javascript:void(0);"> <b>See all e-Mails</b> <i class="fa fa-angle-right"></i> </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- ============================================================== -->
                <!-- End Messages -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Search -->
                <!-- ============================================================== -->
                <li class="nav-item search-box"> <a class="nav-link waves-effect waves-dark" href="javascript:void(0)"><i class="ti-search"></i></a>
                    <form class="app-search">
                        <input type="text" class="form-control" placeholder="Search &amp; enter"> <a class="srh-btn"><i class="ti-close"></i></a>
                    </form>
                </li>
                <!-- ============================================================== -->
                <!-- mega menu -->
                <!-- ============================================================== -->
                <li class="nav-item dropdown mega-dropdown"> <a class="nav-link dropdown-toggle waves-effect waves-dark" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="ti-layout-width-default"></i></a>
                    <div class="dropdown-menu animated bounceInDown">
                        <ul class="mega-dropdown-menu row">
                            <li class="col-lg-3 col-xlg-2 m-b-30">
                                <h4 class="m-b-20">CAROUSEL</h4>
                                <!-- CAROUSEL -->
                                <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                                    <div class="carousel-inner" role="listbox">
                                        <div class="carousel-item active">
                                            <div class="container"> <img class="d-block img-fluid" src="<c:url value='/common/eagleeye-admin/assets/images/big/img4.jpg'/>" alt="First slide"></div>
                                        </div>
                                        <div class="carousel-item">
                                            <div class="container"><img class="d-block img-fluid" src="<c:url value='/common/eagleeye-admin/assets/images/big/img5.jpg'/>" alt="Second slide"></div>
                                        </div>
                                        <div class="carousel-item">
                                            <div class="container"><img class="d-block img-fluid" src="<c:url value='/common/eagleeye-admin/assets/images/big/img6.jpg'/>" alt="Third slide"></div>
                                        </div>
                                    </div>
                                    <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span> </a>
                                    <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span> </a>
                                </div>
                                <!-- End CAROUSEL -->
                            </li>
                            <li class="col-lg-3 m-b-30">
                                <h4 class="m-b-20">ACCORDION</h4>
                                <!-- Accordian -->
                                <div id="accordion" class="nav-accordion" role="tablist" aria-multiselectable="true">
                                    <div class="card">
                                        <div class="card-header" role="tab" id="headingOne">
                                            <h5 class="mb-0">
                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                          Collapsible Group Item #1
                                        </a>
                                      </h5> </div>
                                        <div id="collapseOne" class="collapse show" role="tabpanel" aria-labelledby="headingOne">
                                            <div class="card-body"> Anim pariatur cliche reprehenderit, enim eiusmod high. </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-header" role="tab" id="headingTwo">
                                            <h5 class="mb-0">
                                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                          Collapsible Group Item #2
                                        </a>
                                      </h5> </div>
                                        <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
                                            <div class="card-body"> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-header" role="tab" id="headingThree">
                                            <h5 class="mb-0">
                                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                          Collapsible Group Item #3
                                        </a>
                                      </h5> </div>
                                        <div id="collapseThree" class="collapse" role="tabpanel" aria-labelledby="headingThree">
                                            <div class="card-body"> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="col-lg-3  m-b-30">
                                <h4 class="m-b-20">CONTACT US</h4>
                                <!-- Contact -->
                                <form>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="exampleInputname1" placeholder="Enter Name"> </div>
                                    <div class="form-group">
                                        <input type="email" class="form-control" placeholder="Enter email"> </div>
                                    <div class="form-group">
                                        <textarea class="form-control" id="exampleTextarea" rows="3" placeholder="Message"></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-info">Submit</button>
                                </form>
                            </li>
                            <li class="col-lg-3 col-xlg-4 m-b-30">
                                <h4 class="m-b-20">List style</h4>
                                <!-- List style -->
                                <ul class="list-style-none">
                                    <li><a href="javascript:void(0)"><i class="fa fa-check text-success"></i> You can give link</a></li>
                                    <li><a href="javascript:void(0)"><i class="fa fa-check text-success"></i> Give link</a></li>
                                    <li><a href="javascript:void(0)"><i class="fa fa-check text-success"></i> Another Give link</a></li>
                                    <li><a href="javascript:void(0)"><i class="fa fa-check text-success"></i> Forth link</a></li>
                                    <li><a href="javascript:void(0)"><i class="fa fa-check text-success"></i> Another fifth link</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- ============================================================== -->
                <!-- End mega menu -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- User profile and search -->
                <!-- ============================================================== -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    	<img src="<c:url value='/common/eagleeye-admin/assets/images/users/3.jpg'/>" alt="user" class="img-circle" width="30">
                    </a>
                    <div class="dropdown-menu dropdown-menu-right user-dd animated flipInY">
                        <span class="with-arrow"><span class="bg-primary"></span></span>
                        <div class="d-flex no-block align-items-center p-15 bg-primary text-white m-b-10">
                            <div class="">
                            	<img src="<c:url value='/common/eagleeye-admin/assets/images/users/3.jpg'/>" alt="user" class="img-circle" width="60">
                           	</div>
                            <div class="m-l-10">
                                <h4 class="m-b-0">Steave Jobs</h4>
                                <p class=" m-b-0">varun@gmail.com</p>
                            </div>
                        </div>
                        <a class="dropdown-item" href="javascript:void(0)"><i class="ti-user m-r-5 m-l-5"></i> My Profile</a>
                        <a class="dropdown-item" href="javascript:void(0)"><i class="ti-wallet m-r-5 m-l-5"></i> My Balance</a>
                        <a class="dropdown-item" href="javascript:void(0)"><i class="ti-email m-r-5 m-l-5"></i> Inbox</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="javascript:void(0)"><i class="ti-settings m-r-5 m-l-5"></i> Account Setting</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="javascript:void(0)"><i class="fa fa-power-off m-r-5 m-l-5"></i> Logout</a>
                        <div class="dropdown-divider"></div>
                        <div class="p-l-30 p-10"><a href="javascript:void(0)" class="btn btn-sm btn-success btn-rounded">View Profile</a></div>
                    </div>
                </li>
                <!-- ============================================================== -->
                <!-- User profile and search -->
                <!-- ============================================================== -->
                <li class="nav-item right-side-toggle"> <a class="nav-link  waves-effect waves-light" href="javascript:void(0)"><i class="ti-settings"></i></a></li>
            </ul>
        </div>
    </nav>
</header>