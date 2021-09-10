<!-- #include virtual = "/include/core/class.db.asp" -->
<!-- #include virtual = "/include/core/class.file.asp" -->
<%
'Call util.PrintParams()

Set f = New FILEMANAGER 'file class 선언

Set db = New DBMANAGER
WIth db

regDate = Now()
regIP = cfg.USER_IP

f.RndFileName_ = True

If noticeFilePath <> "" Then 
	f.DeleteFile "notice", ori_noticeFilePath
	RETURN_FILE = f.FileUpload("noticeFilePath", "notice")
	noticeFilePath = Split(RETURN_FILE, "|")(0)
	If noticeFilePath = "ERROR" Then 
		util.MsgEnd "파일업로드 실패 : " & Split(RETURN_FILE, "|")(1)
		Response.End 
	End If 
Else
	noticeFilePath = ori_noticeFilePath
	If op_del = "Y" Then 
		f.DeleteFile "notice", ori_noticeFilePath
		noticeFilePath = ""
	End If 
End If 

If topYN <> "Y" Then
	topYN = "N"
End If 

If mode = "delete" Then

	.StartTran ()
	
	'//메뉴삭제
	.AddParam "idx", "bigint", "in", , idx
	SQL = .GetQuery("notice", "deletetblNotice")
	.ExecuteSql SQL, "text"

	strMsg = "삭제되었습니다."

ElseIf mode = "listdelete" Then

	.StartTran ()
	
	If instr(idxs,",") > -1 Then 
		.AddParam "idx", "bigint", "in", , 0
		splitStr = split(idxs,",")
		For ad = 0 To ubound(splitStr)
			.EditParam "idx", "bigint", "in", , Trim(splitStr(ad))
			SQL = .GetQuery("notice", "deletetblNotice")
			.ExecuteSql SQL, "text"
		Next
	Else 
		.AddParam "idx", "bigint", "in", , Trim(idxs)
		SQL = .GetQuery("notice", "deletetblNotice")
		.ExecuteSql SQL, "text"
	End If

ElseIf mode = "insert" Then

	.StartTran ()

	'//등록
	.AddParam "flag", "int", "in", , flag
	.AddParam "topYN", "char", "in", 1, topYN
	.AddParam "noticeTitle", "varchar", "in", 150, noticeTitle
	.AddParam "noticeContent", "text", "in", , noticeContent
	.AddParam "noticeFilePath", "varchar", "in", 250, noticeFilePath
	.AddParam "noticeHead", "varchar", "in", 20, noticeHead
	.AddParam "readCount", "bigint", "in", , 0
	.AddParam "useYN", "char", "in", 1, useYN
	.AddParam "regAdminId", "varchar", "in", 30, ADMIN_ADMINID
	.AddParam "regName", "varchar", "in", 30, ADMIN_ADMINNAME
	.AddParam "regDate", "datetime", "in", , regDate
	.AddParam "regIP", "varchar", "in", 20, regIP
	
	SQL = .GetQuery("notice", "inserttblNotice")
	.ExecuteSql SQL, "text"

	strMsg = "등록되었습니다."

ElseIf mode = "update" Then

	.StartTran ()
	
	'//수정
	.AddParam "idx", "bigint", "in", , idx
	.AddParam "topYN", "char", "in", 1, topYN
	.AddParam "noticeTitle", "varchar", "in", 150, noticeTitle
	.AddParam "noticeContent", "text", "in", , noticeContent
	.AddParam "noticeFilePath", "varchar", "in", 250, noticeFilePath
	.AddParam "noticeHead", "varchar", "in", 20, noticeHead
	.AddParam "useYN", "char", "in", 1, useYN

	SQL = .GetQuery("notice", "updatetblNotice")
	.ExecuteSql SQL, "text"

	strMsg = "수정되었습니다."

End If 

End With
Set db = Nothing

Set f = Nothing 

util.MsgUrl strMsg,"list.asp?page=" & page & "&flag=" & flag & "&searchType=" & Server.URLEncode(searchType) & "&searchKey=" & Server.URLEncode(searchKey) & "&searchStartDate=" & searchStartDate & "&searchEndDate=" & searchEndDate ,"parent"
%>