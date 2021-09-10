<!-- #include virtual = "/include/core/class.db.asp" -->
<!-- #include virtual = "/include/core/class.file.asp" -->
<%
'Call util.PrintParams()

Set f = New FILEMANAGER 'file class 선언

Set db = New DBMANAGER
WIth db

regDate = Now()
regIP = cfg.USER_IP

'//사용자
'USER_LOGIN_NO = session("purecotton_MEM_NO")
'USER_LOGIN_ID = session("purecotton_MEM_ID")
'USER_LOGIN_NAME = session("purecotton_MEM_NAME")
'USER_LOGIN_NICKNAME = session("purecotton_MEM_NICKNAME")

if vocFilePath01 = "" Then
	vocFilePath01 = ori_vocFilePath01
end if 

if vocFilePath02 = "" Then
	vocFilePath02 = ori_vocFilePath02
end if 

if vocFilePath03 = "" Then
	vocFilePath03 = ori_vocFilePath03
end if 

If USER_LOGIN_ID = "" Then
	USER_LOGIN_ID = vocId
End If 

If USER_LOGIN_NAME = "" Then
	USER_LOGIN_NAME = vocName
End If 

If USER_LOGIN_EMAIL = "" Then
	USER_LOGIN_EMAIL = vocEmail
End If 

If USER_LOGIN_MOBILE = "" Then
	USER_LOGIN_MOBILE = vocPhone
End If 

If mode = "delete" Then

	'//.StartTran ()
	
	'//메뉴삭제
	.AddParam "idx", "bigint", "in", , idx
	SQL = .GetQuery("voc", "deletetblVOC")
	.ExecuteSql SQL, "text"

	strMsg = "삭제되었습니다."

ElseIf mode = "insert" Then

	'//.StartTran ()

	vocPhone = ""
	vocCategoryCode = "VOC"
	vocStatus = ""
	vocType = "VOC"

	'//등록
	.AddParam "vocName", "varchar", "in", 50, USER_LOGIN_NAME
	.AddParam "vocID", "varchar", "in", 50, USER_LOGIN_ID
	.AddParam "vocPhone", "varchar", "in", 30, USER_LOGIN_MOBILE
	.AddParam "vocCategoryCode", "varchar", "in", 10, vocCategoryCode
	.AddParam "vocTitle", "varchar", "in", 150, vocTitle
	.AddParam "vocContent", "text", "in", , vocContent
	.AddParam "vocFilePath01", "varchar", "in", 250, vocFilePath01
	.AddParam "vocFilePath02", "varchar", "in", 250, vocFilePath02
	.AddParam "vocFilePath03", "varchar", "in", 250, vocFilePath03
	.AddParam "vocStatus", "varchar", "in", 10, vocStatus
	.AddParam "vocType", "varchar", "in", 10, vocType
	.AddParam "regDate", "datetime", "in", , regDate
	.AddParam "regIP", "varchar", "in", 20, regIP
	.AddParam "vocEmail", "varchar", "in", 150, USER_LOGIN_EMAIL
	
	SQL = .GetQuery("voc", "inserttblVOC")
	.ExecuteSql SQL, "text"

	'깨나라 DB INSERT 처리 - 시작
	cate = "QNAB000006" '기타

	Set db2 = Server.CreateObject("ADODB.Connection")
	
	If cfg.isDev = "Y" Then 
		db2.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
	Else 
		db2.ConnectionString = "provider=SQLOLEDB;Data Source=;Initial Catalog=;User Id=;Password="
	End If

	db2.Open

	sql = "INSERT INTO [dbo].[tblVOC]([vocName],[vocEmail],[vocPhone],[vocCategoryCode],[vocTitle],[vocContent],[vocFilePath],[vocStatus],[vocType],[vocSite],[regDate],[regIP]) "
	sql = sql & "VALUES('" & USER_LOGIN_NAME & "','" & USER_LOGIN_EMAIL & "','" & USER_LOGIN_MOBILE & "','" & cate & "','" & vocTitle & "','" & vocContent & "','" & vocFilePath01 & "','확인중','VOC','P', getdate(), '" & regIP & "')"

	db2.Execute sql

	db2.Close
	Set db2 = Nothing
	'깨나라 DB INSERT 처리 - 끝

	strMsg = "등록되었습니다."

ElseIf mode = "update" Then

	'//.StartTran ()
	'//수정
	.AddParam "idx", "bigint", "in", , idx
	.AddParam "vocTitle", "varchar", "in", 150, vocTitle
	.AddParam "vocContent", "text", "in", , vocContent
	.AddParam "vocFilePath01", "varchar", "in", 250, vocFilePath01
	.AddParam "vocFilePath02", "varchar", "in", 250, vocFilePath02
	.AddParam "vocFilePath03", "varchar", "in", 250, vocFilePath03

	SQL = .GetQuery("voc", "userUpdatetblVOC")
	.ExecuteSql SQL, "text"

	strMsg = "수정되었습니다."

End If 

End With
Set db = Nothing

Set f = Nothing 

util.MsgUrl strMsg,"onetoone_list.asp?page=" & page ,"parent"
%>
  