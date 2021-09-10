<!-- #include virtual = "/include/core/class.db.asp" -->
<!-- #include virtual = "/include/core/sha/sha256.asp" -->
<%
Call util.PrintParams()

Set db = New DBMANAGER
WIth db

regDate = Now()
regIP = cfg.USER_IP

If mode = "delete" Then

	.StartTran ()
	
	'//메뉴삭제
	.AddParam "idx", "bigint", "in", , idx
	SQL = .GetQuery("admin", "deletetblAdminInfo")
	.ExecuteSql SQL, "text"

	strMsg = "삭제되었습니다."

ElseIf mode = "insert" Then

	.StartTran ()
	
	.AddParam "adminId", "varchar", "in", 50, adminId

	.WHERE (" AND (adminId = #adminId#)")
	Call .GetRS(.GetQuery("admin", "selecttblAdminInfoList"), "text")

	If rs_adminId = "" Then
		.AddParam "adminName", "nvarchar", "in", 100, adminName
		.AddParam "adminPassword", "varchar", "in", 516, sha256(adminPassword)
'		.AddParam "adminLastLoginDate", "datetime", "in", , ""
		.AddParam "adminLevel", "int", "in", , adminLevel
		.AddParam "adminLoginCount", "int", "in", , 0
		.AddParam "adminMenuPermission", "varchar", "in", 500, ""
		.AddParam "adminIPPermission", "varchar", "in", 100, adminIPPermission
		.AddParam "regDate", "datetime", "in", , regDate
		.AddParam "regIP", "varchar", "in", 30, regIP
		
		SQL = .GetQuery("admin", "inserttblAdminInfo")
		.ExecuteSql SQL, "text"

		strMsg = "등록되었습니다."
	Else
		strMsg = "이미 등록된 아이디입니다."
	End If 
	

ElseIf mode = "update" Then

	.StartTran ()
	
	'//수정
	.AddParam "idx", "bigint", "in", , idx
	.AddParam "adminId", "varchar", "in", 50, adminId
	.AddParam "adminName", "nvarchar", "in", 100, adminName
	.AddParam "adminLevel", "int", "in", , adminLevel
	.AddParam "adminMenuPermission", "varchar", "in", 500, adminMenuPermission
	.AddParam "adminIPPermission", "varchar", "in", 100, adminIPPermission
	
	SQL = .GetQuery("admin", "updatetblAdminInfo")
	.ExecuteSql SQL, "text"

	'//비밀번호 입력시 수정
	If adminPassword <> "" Then 
		.AddParam "adminPassword", "varchar", "in", 516, sha256(adminPassword)
		SQL = .GetQuery("admin", "updatetblAdminInfoPassword")
		.ExecuteSql SQL, "text"
	End If 

	strMsg = "수정되었습니다."

End If 

End With
Set db = Nothing

util.MsgUrl strMsg,"list.asp?page=" & page & "&searchType=" & Server.URLEncode(searchType) & "&searchKey=" & Server.URLEncode(searchKey) ,"parent"
%>