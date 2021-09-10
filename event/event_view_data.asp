<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

Set db = New DBMANAGER
WIth db

regDate = Now()
regIP = cfg.USER_IP

goUrl = ""

'//사용자
'USER_LOGIN_NO = session("purecotton_MEM_NO")
'USER_LOGIN_ID = session("purecotton_MEM_ID")
'USER_LOGIN_NAME = session("purecotton_MEM_NAME")
'USER_LOGIN_NICKNAME = session("purecotton_MEM_NICKNAME")

If mode = "delete" Then

	'//.StartTran ()
	
	'//메뉴삭제
	.AddParam "idx", "bigint", "in", , cmd_idx
	SQL = .GetQuery("eventcomment", "deletetblEventComment")
	.ExecuteSql SQL, "text"

	strMsg = "삭제되었습니다."

ElseIf mode = "insert" Then

	'//.StartTran ()
	'//등록
	'//.AddParam "idx", "bigint", "in", , idx
	.AddParam "event_idx", "bigint", "in", , event_idx
	.AddParam "commentText", "varchar", "in", -1, commentText
	.AddParam "UserID", "varchar", "in", 50, USER_LOGIN_ID
	.AddParam "UserName", "varchar", "in", 50, USER_LOGIN_NAME
	.AddParam "regDate", "datetime", "in", , regDate
	.AddParam "regIP", "varchar", "in", 20, regIP
	
	SQL = .GetQuery("eventcomment", "inserttblEventComment")
	.ExecuteSql SQL, "text"

	strMsg = "등록되었습니다."

ElseIf mode = "update" Then

	'//.StartTran ()
	'//등록
	'//.AddParam "idx", "bigint", "in", , idx
	.AddParam "idx", "bigint", "in", , cmd_idx
	.AddParam "commentText", "varchar", "in", -1, commentText
	
	SQL = .GetQuery("eventcomment", "updatetblEventComment")
	.ExecuteSql SQL, "text"

	strMsg = "수정되었습니다."	
	goUrl = "/event/event_view.asp?idx=" & event_idx & "&page=" & page

End If 

End With
Set db = Nothing

Set f = Nothing 

'//util.MsgUrl strMsg,"onetoone.asp" ,"parent"
%>
<script type="text/javascript">
	alert("<%=strMsg%>");
	<% if goUrl <> "" then %>
	parent.location.href = "<%=goUrl%>";
	<% else %>
	parent.location.reload();
	<% end if %>
	
</script>

  