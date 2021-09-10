  <body class="skin-black sidebar-mini">
    <div class="wrapper">

	  <header class="main-header">
        <!-- Logo -->
        <a href="/" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>순수한면</b></span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>웹사이트</b>관리자</span>
        </a>
       
		<!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a>
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- User Account: style can be found in dropdown.less -->
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img src="/web.admin/images/img_logo.png" class="user-image" alt="User Image">
                  <span class="hidden-xs"><%=ADMIN_ADMINNAME%></span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header">
                    <img src="/web.admin/images/img_logo.png" class="img-circle" alt="User Image">
                    <p>
                      <%=ADMIN_ADMINID%>
                      <small><%=ADMIN_ADMINNAME%> 님 반갑습니다.</small>
                    </p>
                  </li>
				  <li class="user-footer">
                    <div class="pull-left">
                      <a href="#" class="btn btn-default btn-flat">Profile</a>
                    </div>
                    <div class="pull-right">
                      <a href="/web.admin/login/logout.asp" class="btn btn-default btn-flat">Log out</a>
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </nav>
      </header>

	  <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
		  <!-- sidebar menu: : style can be found in sidebar.less -->
          <ul class="sidebar-menu">
            <li class="header">MAIN NAVIGATION</li>
            <!-- 1menu start -->
			<li class="<% If CInt(menuSet01) = 0 And CInt(menuSet02) = 0 Then %>active<% End If %> treeview">
              <a href="/web.admin/">
                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
              </a>
            </li>
			<!-- 1menu end -->
			<%
			If ADMIN_ADMINLEVEL = "0" Then '레벨이 0 : 시스템 관리자 외에는 노출되지 않는 메뉴입니다. - 시작
			%>
			<li class="<% If CInt(menuSet01) = 0 Then %>active <% End If %>  treeview">
              <a href="#">
                <i class="fa fa-files-o"></i>
                <span>시스템 관리</span>
              </a>
              <ul class="treeview-menu">
                <li <% If CInt(menuSet02) = 1 Then %>class='active' <% End If %>><a href="/web.admin/adminuser/list.asp"><i class="fa fa-circle-o"></i> 관리사용자 관리</a></li>
                <li <% If CInt(menuSet02) = 2 Then %>class='active' <% End If %>><a href="/web.admin/adminmenu/list.asp"><i class="fa fa-circle-o"></i> 관리자메뉴 관리</a></li>
                <li <% If CInt(menuSet02) = 3 Then %>class='active' <% End If %>><a href="/web.admin/globalcode/list.asp"><i class="fa fa-circle-o"></i> 코드관리</a></li>
              </ul>
            </li>
			<%
				Select Case CInt(menuSet02)
					Case 1
						currentMenuName01 = "시스템 관리"
						currentMenuName02 = "관리사용자 관리"
					Case 2
						currentMenuName01 = "시스템 관리"
						currentMenuName02 = "관리자메뉴 관리"
					Case 3
						currentMenuName01 = "시스템 관리"
						currentMenuName02 = "코드관리"
					Case Else
						currentMenuName01 = "-"
						currentMenuName02 = "-"
				End Select 
			End If  '레벨이 0 : 시스템 관리자 외에는 노출되지 않는 메뉴입니다. - 끝
			%>

			<%
			If CInt(menuSet01) <> 0 Then
				currentMenuName01 = "Dashboard"
				currentMenuName02 = "Dashboard"
			End If 

			'//메인 메뉴를 프린트
			mSql = " SELECT  menuIdx, menuParentIdx, menuIcon, menuIconColor, menuName, menuURL, isMenu, isBlank "
			mSql = mSql & " 	, (SELECT COUNT(0) FROM tblMenu WHERE (menuLevel > 1) AND (menuParentIdx = M.menuIdx)) AS subMenuCount "
			mSql = mSql & " FROM     tblMenu AS M WITH (nolock) "
			mSql = mSql & " WHERE  (isUse = 'Y') AND (menuLevel = 1)  "
			mSql = mSql & " ORDER BY menuSortNo "
			Set mLst = .GetList(mSql,"text")

			For mNo = 0 To mLst("count")
				If CInt(menuSet01) = CInt(mLst("menuIdx")(mNo)) Then
					activeStr01 = "active"
					currentMenuName02 = mLst("menuName")(mNo)
				Else
					activeStr01 = ""
				End If 

				If InStr(rs_myMenuPermission,"|" & mLst("menuIdx")(mNo) & "|") > 0 Or ADMIN_ADMINLEVEL = "0" Then '//대매뉴 권한체크 
			%>
			<li class='<%=activeStr01%> treeview'>
			  <a href="<%=mLst("menuURL")(mNo)%>" <% If mLst("isBlank")(mNo) = "Y" Then %> target="_blank"<% End If %>><i class="fa <%=mLst("menuIcon")(mNo)%>"></i> <span><%=mLst("menuName")(mNo)%></span></a>
			  <%
			  '//하위메뉴가 존재할때만
			  If CInt(mLst("subMenuCount")(mNo)) > 0 Then 
			  %>
			  <ul class="treeview-menu">
                <%
				'//서브 메뉴를 프린트
				sSql = " SELECT  menuIdx, menuIcon, menuIconColor, menuName, menuURL, isMenu, isBlank "
				sSql = sSql & " FROM     tblMenu WITH (nolock) "
				sSql = sSql & " WHERE  (isUse = 'Y') AND (menuParentIdx = " & mLst("menuIdx")(mNo) & ") AND (menuLevel > 1)  "
				sSql = sSql & " ORDER BY menuLevel, menuSortNo "
				Set sLst = .GetList(sSql,"text")

				For sNo = 0 To sLst("count")
					If CInt(menuSet02) = CInt(sLst("menuIdx")(sNo)) Then
						activeStr02 = "class='active'"
						currentMenuName01 = currentMenuName02
						currentMenuName02 = sLst("menuName")(sNo)
					Else
						activeStr02 = ""
					End If 

					If InStr(rs_myMenuPermission,"|" & sLst("menuIdx")(sNo) & "|") > 0 Or ADMIN_ADMINLEVEL = "0" Then '//소매뉴 권한체크 
				%>
				<li <%=activeStr02%>><a href="<%=sLst("menuURL")(sNo)%>" <% If sLst("isBlank")(sNo) = "Y" Then %> target="_blank"<% End If %>><i class="fa <%=sLst("menuIcon")(sNo)%> text-<%=sLst("menuIconColor")(sNo)%>"></i> <%=sLst("menuName")(sNo)%></a></li>
				<%
					End If  '//소매뉴 권한체크 
				Next 
				Set sLst = Nothing 
				%>
              </ul>
			  <%
			  End If 
			  %>
            </li>
			<%
				End If '//대매뉴 권한체크 
			
			Next
			Set mLst = Nothing 
			%>
          </ul>
        </section>
        <!-- /.sidebar -->
      </aside>

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <%=currentMenuName02%>
            <small><%=currentMenuName01%></small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><%=currentMenuName01%></li>
            <li class="active"><%=currentMenuName02%></li>
          </ol>
        </section>