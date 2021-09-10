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
	.AddParam "menuIdx", "bigint", "in", , idx
	SQL = .GetQuery("adminmenu", "deletetblMenu")
	.ExecuteSql SQL, "text"

	strMsg = "삭제되었습니다."

ElseIf mode = "insert" Then

	.StartTran ()
	
	'//최상위메뉴 등록시에는 값을
	If menuParentIdx = "" Then 
		menuParentIdx = 0 '//부모코드
		menuLevel = 1 '//메뉴레벨
		'//GroupNo셋팅
		maxSql = " SELECT  ISNULL(MAX(menuGroupNo), 0) + 1 AS maxMenuGroupNo, ISNULL(MAX(menuSortNo), 0) + 1 AS menuSortNo "
		maxSql = maxSql & " FROM     tblMenu "
		Call .GetRS(maxSql, "text")
		menuGroupNo = rs_maxMenuGroupNo '//그룹번호
		menuSortNo = rs_menuSortNo '//정렬순서
	Else
		menuLevel = 2 '//메뉴레벨
		'//GroupNo셋팅
		maxSql = " SELECT  menuGroupNo, menuSortNo + 1 AS menuSortNo  "
		maxSql = maxSql & " FROM     tblMenu "
		maxSql = maxSql & " WHERE  (menuIdx = " & menuParentIdx & ") "
		Call .GetRS(maxSql, "text")
		menuGroupNo = rs_menuGroupNo '//그룹번호
		menuSortNo = rs_menuSortNo '//정렬순서
	End If 

	menuIconColor = "" '//메뉴 표현색상
	isMenu = "Y" '//혹시몰라서 미리 셋팅

	'//등록
	.AddParam "menuParentIdx", "bigint", "in", , menuParentIdx
	.AddParam "menuIcon", "varchar", "in", 30, menuIcon
	.AddParam "menuIconColor", "varchar", "in", 20, menuIconColor
	.AddParam "menuName", "varchar", "in", 50, menuName
	.AddParam "menuURL", "varchar", "in", 100, menuURL
	.AddParam "menuGroupNo", "int", "in", , menuGroupNo
	.AddParam "menuLevel", "smallint", "in", , menuLevel
	.AddParam "menuSortNo", "smallint", "in", , menuSortNo
	.AddParam "isMenu", "char", "in", 1, isMenu
	.AddParam "isBlank", "char", "in", 1, isBlank
	.AddParam "isUse", "char", "in", 1, isUse
	
	SQL = .GetQuery("adminmenu", "inserttblMenu")
	.ExecuteSql SQL, "text"

	strMsg = "등록되었습니다."

ElseIf mode = "update" Then

	.StartTran ()
	
	'//수정
	.AddParam "menuIdx", "bigint", "in", , idx
	.AddParam "menuIcon", "varchar", "in", 30, menuIcon
	.AddParam "menuName", "varchar", "in", 50, menuName
	.AddParam "menuURL", "varchar", "in", 100, menuURL
	.AddParam "isBlank", "char", "in", 1, isBlank
	.AddParam "isUse", "char", "in", 1, isUse
	
	SQL = .GetQuery("adminmenu", "updatetblMenu")
	.ExecuteSql SQL, "text"

	strMsg = "수정되었습니다."

End If 

End With
Set db = Nothing

util.MsgUrl strMsg,"list.asp?page=" & page & "&searchType=" & Server.URLEncode(searchType) & "&searchKey=" & Server.URLEncode(searchKey) ,"parent"
%>