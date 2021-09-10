<!-- #include virtual = "/include/core/class.db.asp" -->
<%
call util.DelCookie("purecotton2018_adminIdx")
call util.DelCookie("purecotton2018_adminid")
call util.DelCookie("purecotton2018_adminName")
call util.DelCookie("purecotton2018_adminLevel")
call util.DelCookie("purecotton2018_adminLoginIP")

Response.Expires = -1 '캐쉬를 사용하지 않음.
Response.addheader "pragma","no-cache"
Response.addheader "cache-control","no-cache"

Response.redirect "/web.admin/"
%>
