<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<html lang="ko">
<head>

</head>
<body>
<%
Function DelSavedID()
	
End Function

Dim DefaultURL

DefaultURL = cfg.DomainName

'Dim DefaultURL : DefaultURL = "http://lilian.wylie.co.kr"
Dim Renewal_Member_proxyUrl : Renewal_Member_proxyUrl = "https://www.kleannara.com/include/biz/"

'********************************************************************************
'* 통신
'********************************************************************************
Public Function StreamMember (ByVal temp, ByVal param1, ByVal param2)

If temp = "L" Then
	params = "UID=" & PARAM1 & "&PWD=" & PARAM2
	URL = Renewal_Member_proxyUrl & "login.asp"
Elseif temp = "I" then
	params = "UNO=" & PARAM1 & "&UID=" & PARAM2
	URL = Renewal_Member_proxyUrl & "info.asp"
Else
	Response.End
End If
	Set xmlHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
	With xmlHTTP
		.Open "POST", URL , False
		.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
		.SetRequestHeader "AUTH_SITEPASS", "PURECOTTON"
		.Send params
	If .readyState = 4 Then
		If .status = 200 Then
			retData = .ResponseText
		Else
			StatusCode = 2
			retData = "ERROR [status : " & .status & "]"
		End If
	Else
		StatusCode = 1
		retData = "ERROR [readyState : " & .readyState & "]"
	End If

	End With
	Set xmlHTTP = Nothing
	If Left(retData,1) = "E" Then
		If Left(retData,5) = "ERROR" Then
			Call util.MsgEnd (retData)
		Else
			Select Case Mid(retData,2)
				Case "000"
					rslt = "아이디 혹은 비밀번호를 다시 확인해 주세요."
				Case "101"
					rslt = "이미 탈퇴한 아이디 입니다."
				Case "102"
					rslt = "로그인 금지된 아이디 입니다."
				Case "103"
					rslt = "14세 미만 아이디 입니다."
				Case "104"
					rslt = "아이디 혹은 비밀번호를 다시 확인해 주세요."
				Case "106"
					rslt = "휴면계정으로 전환된 계정입니다."
				Case "109"
					rslt = "탈퇴 처리중인 아이디 입니다."
			End Select

			If Mid(retData,2) = "106" Then

				session("purecotton_REST_ID") = member_id
			%>
				<script type="text/javascript">
				parent.document.location.href = "/member/login_info.asp";
				</script>
			<%
			Else

				Call util.msgBox (rslt)

			End If

%>
			<script language="javascript">
				parent.$("#btnLogin").html("<input type=\"image\" src=\"/images/common/btn/btn_login_b.gif\" alt=\"로그인\" title=\"로그인\" />");
			</script>
<%

			Response.End

		End If

	Else
		If temp = "L" Then
			StreamMember = "Y|"&retData
		Elseif temp = "I" then
			StreamMember = retData
		Else
			Response.End
		End If
	End If

End Function

Dim USERCODE , USER_ID , USER_NAME , USER_NICKNAME , USER_EMAIL , USER_MOBILE , rslt , resultParam

If request("logout") ="y" then
	Response.Cookies("PURECOTTON").expires = Date -1

	session("purecotton_MEM_NO") = ""
	session("purecotton_MEM_ID") = ""
	session("purecotton_MEM_NAME") = ""
	session("purecotton_MEM_NICKNAME") = ""
	session("purecotton_MEM_EMAIL") = ""
	session("purecotton_MEM_MOBILE") = ""
	session.abandon
%>
<script type="text/javascript">
   <% If returnUrl <> "" Then %>
	   //parent.location.href = "<%=returnUrl%>";
	   parent.location.href = "/";
   <% Else %>
	   //parent.location.href = "<%=DefaultURL%>";
	   parent.location.href = "/";
   <% End If %>
</script>
<%
Else

	Dim retUrl 		: retUrl	= DefaultURL
	Dim loginID		: loginID	= member_id
	Dim loginPW		: loginPW	= member_pwd

	If loginID	= "" Then Response.End
	If loginPW	= "" Then Response.End
	   retUrl	= replace(retUrl,"^","&")
	'if retUrl = "" then retUrl = "http://www.bosomi.co.kr/"

	isFlag = "N"
	resultParam = StreamMember ( "L", loginID, loginPW)

	'반환값 : 고유번호|이름|대화명
	rslt = Split(resultParam,"|")

	If rslt(0) = "N" Then Response.End

	isFlag 			= rslt(0)
	USERCODE 		= rslt(1)
	USER_ID 		= loginID
	USER_NAME 		= rslt(2)
	USER_NICKNAME 	= rslt(3)

	isFlag = "N"
	resultParam = StreamMember ( "I" , USERCODE, USER_ID)	

	'반환값 : 성공여부|고유번호|사용여부|아이디|이름|대화명|생년월일|이메일주소|우편번호|주소1|주소2|집전화번호|휴대폰번호|EMAIL수신여부|SNS 수신여부|직업|결혼여부|가입경로|선호제품|가입일|육아사이즈(대표)|육아성별(대표)|자녀수|유저성별|비밀번호수정일

	rslt = Split(resultParam,"|^")

	If rslt(0) = "N" Then Response.End
	If rslt(2) <> "1" Then util.MsgEnd("로그인이 가능한 상태가 아닙니다.") : Response.End

	USER_EMAIL  = rslt(7)
	USER_MOBILE = rslt(12)
	USER_PASSCHANGE = rslt(24)
	USER_JOIN_WAY = rslt(17)

	session("purecotton_MEM_NO") = USERCODE
	session("purecotton_MEM_ID") = USER_ID
	session("purecotton_MEM_NAME") = USER_NAME
	session("purecotton_MEM_NICKNAME") = USER_NICKNAME
	session("purecotton_MEM_EMAIL") = USER_EMAIL
	session("purecotton_MEM_MOBILE") = USER_MOBILE
	session("purecotton_JOIN_WAY") = USER_JOIN_WAY
	session.timeout = 30

	'// 캐쉬사용금지
	response.CacheControl = "no-cache"
	response.AddHeader "Pragma", "no-cache"
	response.expires = -1

	If saveid = "on" Then
		Call CreateCookies("purecotton_MEMBER","SAVEID",USER_ID)
	Else
		DelSavedID()
	End If

	'비밀번호 수정일자
	reg_date = CDate(Left(USER_PASSCHANGE, 10))

	'비밀번호 수정일자가 6개월 이상 됐을 때
	If reg_date < date Then

		%>
		<script type="text/javascript">
			<% If returnUrl <> "" Then %>
				parent.document.location.href = "changePw.asp?rtn=<%=returnUrl%>"
			<% Else %>
				parent.document.location.href = "changePw.asp?rtn=<%=retUrl%>"
			<% End If %>
		</script>
		<%

	'비밀번호 변경 페이지 없음
	Else

		%>
		<script type="text/javascript">
			<% If returnUrl <> "" Then 
			returnUrl = replace(returnUrl,DefaultUrl,"")
			%>
				parent.document.location.href = "<%=DefaultURL&returnUrl%>";
			<% Else %>
				parent.document.location.href = "<%=retUrl%>";
			<% End If %>
		</script>
		<%

	End If

End If
%>
</body>
</html>