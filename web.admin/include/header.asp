<meta charset="UTF-8">
<title>local 관리자 웹사이트</title>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

<!-- Bootstrap 3.3.4 -->
<link rel="stylesheet" href="/web.admin/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Ionicons 2.0.0 -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/web.admin/dist/css/AdminLTE.min.css">
<!-- i6020345 Custom CSS -->
<link rel="stylesheet" href="/web.admin/dist/css/i6020345.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
	 folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="/web.admin/dist/css/skins/_all-skins.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="/web.admin/plugins/iCheck/flat/blue.css">

<!-- jvectormap -->
<link rel="stylesheet" href="/web.admin/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
<!-- Date Picker -->
<link rel="stylesheet" href="/web.admin/plugins/datepicker/datepicker3.css">
<!-- Daterange picker -->
<link rel="stylesheet" href="/web.admin/plugins/daterangepicker/daterangepicker-bs3.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet" href="/web.admin/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- jQuery 2.1.4 -->
<script src="/web.admin/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.4 -->
<script src="/web.admin/bootstrap/js/bootstrap.min.js"></script>
<!-- Sparkline -->
<script src="/web.admin/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="/web.admin/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/web.admin/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="/web.admin/plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="/web.admin/plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="/web.admin/plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="/web.admin/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="/web.admin/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/web.admin/plugins/fastclick/fastclick.min.js"></script>
<!-- AdminLTE App -->
<script src="/web.admin/dist/js/app.min.js"></script>
<!-- jquery-validation-1.14.0 -->
<script src="/web.admin/plugins/validation/additional-methods.min.js"></script>
<script src="/web.admin/plugins/validation/jquery.validate.min.js"></script>

<!-- Magnific Popup core CSS file -->
<link rel="stylesheet" href="/css/magnific-popup.css">
<!-- Magnific Popup core JS file -->
<script src="/js/jquery.magnific-popup.min.js"></script>
<!-- iCheck -->
<script type="text/javascript" src="/web.admin/plugins/iCheck/icheck.min.js"></script>


<%
If nonSessionCheck <> "Y" Then
	If ADMIN_ADMINID = "" Then 
%>
<script type="text/javascript">
	alert("로그인 시간이 만료되었습니다.\n다시 로그인 해 주시기 바랍니다.");
	location.href = "/web.admin/login/";
</script>
<%
		Response.End 
	End If 
End If

IsSSL = "N"

Call util.SSLPageRedirect(IsSSL)

'//슈퍼 관리자가 아니라면 현재 사용자의 메뉴 권한을 가져온다
If ADMIN_ADMINLEVEL <> "0" Then 
	mSql = " Select adminMenuPermission AS myMenuPermission From tblAdminInfo Where (adminId = '" & ADMIN_ADMINID & "') "
	Call .GetRS(mSql, "text")
End If 

PageViewPermission = "N"
If InStr(rs_myMenuPermission,"|" & menuSet02 & "|") > 0 Or ADMIN_ADMINLEVEL = "0" Or nonSessionCheck = "Y" Then '//대매뉴 권한체크 
	PageViewPermission = "Y"
End If 

If PageViewPermission = "N" Then
	Call util.MsgUrl ("조회권한이 없는 접근입니다.","/web.admin/","")
	Response.End 
End If 
%>
