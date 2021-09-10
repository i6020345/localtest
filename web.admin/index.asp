<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'//메뉴 고정을 위한 고정값
menuSet01 = "0"
menuSet02 = "0"

nonSessionCheck = "Y"

If ADMIN_ADMINID = "" Then
	Response.redirect "/web.admin/login/"
	Response.End 
End If 

Set db = New DBMANAGER
WIth db
%>
<html>
<head>
    <!-- #include virtual = "/web.admin/include/header.asp" -->
    <!-- Morris chart -->
    <link rel="stylesheet" href="/web.admin/plugins/morris/morris.css">

    <!-- Morris.js charts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="/web.admin/plugins/morris/morris.min.js"></script>

    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <script src="/web.admin/dist/js/pages/dashboard.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="/web.admin/dist/js/demo.js"></script>
</head>

<!-- #include virtual = "/web.admin/include/common.asp" -->

<!-- Main content -->
<section class="content">
    대시보드
</section>
<!-- /.content -->

<!-- #include virtual = "/web.admin/include/footer.asp" -->

<%
End With
Set db = Nothing
%>
