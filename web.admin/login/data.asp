<!-- #include virtual = "/include/core/class.db.asp" -->
<!-- #include virtual = "/include/core/sha/sha256.asp" -->
<%
'Call util.PrintParams()

Set db = New DBMANAGER
WIth db

regDate = Now()
regIP = cfg.USER_IP
returnLocation = "/web.admin/"
'//returnUrl

If mode = "login" Then

	'.StartTran ()

	'//회원정보 조회
	.AddParam "adminId", "varchar", "in", 50, adminId
	.AddParam "adminPassword", "varchar", "in", 516, sha256(adminPassword)
	.WHERE (" AND (adminId = #adminId#) AND (adminPassword = #adminPassword#) ")
	Call .GetRS(.GetQuery("admin", "selecttblAdminInfoList"), "text")


'	Response.write "adminId = " & sadasadminId& "<br/>"
'	Response.write "adminPassword = " & sha256(adminPassword) & "<br/>"
'	Response.End 

	'//로그인 성공시
	If db.rsData = true Then
		'//idx, adminId, adminName, adminPassword, adminLastLoginDate, adminLevel, adminLoginCount, adminMenuPermission, adminIPPermission, regDate, regIP

		'//해당 아이디 최근 접속일시 업데이트
		'//해당 아이디 총 접속수 업데이트
		SQL = .GetQuery("admin", "updatetblAdminInfoLogin")
		.ExecuteSql SQL, "text"

		'//로그인 로그 등록
		call util.SetCookie("purecotton2018_adminIdx","",rs_idx)
		call util.SetCookie("purecotton2018_adminid","",rs_adminId)
		call util.SetCookie("purecotton2018_adminName","",rs_adminName)
		call util.SetCookie("purecotton2018_adminLevel","",rs_adminLevel)
		call util.SetCookie("purecotton2018_adminLoginIP","",Request.ServerVariables("REMOTE_ADDR"))

		If returnUrl <> "" Then
			returnLocation = returnUrl
		Else
			returnLocation = "/web.admin/"
		End If 
	Else
		'//아예 회원정보가 없는경우
		returnLocation = "/web.admin/login/"
		strMsg = "일치하는 정보가 없습니다."
	End If 

End If 

End With
Set db = Nothing

util.MsgUrl strMsg,returnLocation,""
%>
