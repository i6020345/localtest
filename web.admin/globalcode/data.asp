<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

Set db = New DBMANAGER
WIth db

regDate = Now()
regIP = cfg.USER_IP

If mode = "delete" Then

	.StartTran ()
	
	'//메뉴삭제
	.AddParam "codeIdx", "bigint", "in", , idx
	SQL = .GetQuery("globalcode", "deletetblCode")
	.ExecuteSql SQL, "text"

	strMsg = "삭제되었습니다."

ElseIf mode = "insert" Then

	.StartTran ()
	
	'//최상위코드 등록시에는 코드를 생성한다
	If parentCodeValue = "" Then 
		maxSql = " Select ISNULL(MAX(codeIdx), 1) AS maxCodeIdx From tblCode "
		Call .GetRS(maxSql, "text")
		parentCodeValue = "GCODE" & util.LeftPad(rs_maxCodeIdx, 5, "0")  '//부모코드
		codeDepth = 1
		codeValue = parentCodeValue
		codeSort = 0
	Else
		maxSql = " SELECT  codeDepth + 1 AS codeDepth, codeSort + 1 AS codeSort  "
		maxSql = maxSql & " FROM     tblCode "
		maxSql = maxSql & " WHERE  (codeValue = '" & parentCodeValue & "') "
		Call .GetRS(maxSql, "text")
		maxSql2 = " Select ISNULL(MAX(codeIdx), 1) AS maxCodeIdx From tblCode "
		Call .GetRS(maxSql2, "text")

		codeDepth = rs_codeDepth
		codeValue = "GCODE" & util.LeftPad(rs_maxCodeIdx, 5, "0")  '//코드
		codeSort = rs_codeSort
	End If 

	'//등록
	.AddParam "parentCodeValue", "varchar", "in", 20, parentCodeValue
	.AddParam "codeDepth", "int", "in", , codeDepth
	.AddParam "codeValue", "varchar", "in", 20, codeValue
	.AddParam "codeName", "nvarchar", "in", 60, codeName
	.AddParam "codeNameEn", "nvarchar", "in", 60, codeNameEn
	.AddParam "codeNameCh", "nvarchar", "in", 60, codeNameCh
	.AddParam "codeNameJp", "nvarchar", "in", 60, codeNameJp
	.AddParam "codeSort", "int", "in", , codeSort
	.AddParam "codeUseYn", "char", "in", 1, codeUseYn
	.AddParam "codeText", "varchar", "in", 500, codeText
	
	SQL = .GetQuery("globalcode", "inserttblCode")
	.ExecuteSql SQL, "text"

	strMsg = "등록되었습니다."

ElseIf mode = "update" Then

	.StartTran ()
	'//수정
	.AddParam "codeIdx", "bigint", "in", , idx
	.AddParam "codeName", "nvarchar", "in", 60, codeName
	.AddParam "codeUseYn", "char", "in", 1, codeUseYn
	.AddParam "codeText", "varchar", "in", -1, codeText	
	.AddParam "codeNameEn", "nvarchar", "in", 60, codeNameEn
	.AddParam "codeNameCh", "nvarchar", "in", 60, codeNameCh
	.AddParam "codeNameJp", "nvarchar", "in", 60, codeNameJp
	
	SQL = .GetQuery("globalcode", "updatetblCode")
	.ExecuteSql SQL, "text"

	strMsg = "수정되었습니다."

End If 

End With
Set db = Nothing

util.MsgUrl strMsg,"list.asp" ,"parent"
%>