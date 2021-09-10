<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet  = "UTF-8"
Response.AddHeader "Pragma", "no-cache"
Response.CacheControl = "no-cache"
Response.Expires = -1442
Const MetaCharset = "utf-8"

Dim cfg, util, fnc, rule

Class WEBCONFIG

	Public DomainName			'// 도메인명
	Public USER_IP					'// 사용자 아이피
	Public SERVER_IP					'// 서버 아이피
	Public SSLDomain				'// 인증서 도메인명
	Private IgnoreParams			'// 기본적으로 인자값을 설정하지 않을 변수명
	Private IgnoreBlockHtml			'// BlockHtml을 테우지 않을 변수명
	Public TotalCount				'// 게시물 전체 수
	Public TotalPage					'// 전체 페이지 수
	Public ListNo				'// 게시물 번호
	Public SesNo, SesName
	Public isDev 				'// 개발서버 여부
	Public HTTP_HOST

	Private DatabaseServer, DatabaseName, DatabaseUser, DatabasePassword,Transaction
	Private FileSaveRoot

	' 생성자
	Public Sub Class_Initialize ()
		DomainName		= "http://www.purecotton.co.kr/"
		USER_IP				= Trim(Request.ServerVariables("REMOTE_ADDR"))
		SERVER_IP			= Trim(Request.ServerVariables("LOCAL_ADDR"))
		SSLDomain			= Application("real.ssl")
		
		if instr(Trim(request.servervariables("HTTP_HOST")),"purecotton.co.kr") > 0 then 
		
			DatabaseServer_		= "(local)" '실 서버
			DatabaseName_		= "localTest" 
			DatabaseUser_		= "sa" '실서버
			DatabasePassword_	= "flznltit12#$" '실서버
			FileSaveRoot_		= Server.MapPath("\upload") & "\" '실서버

		else
			'//테스트 환경
			DatabaseServer_		= "(local)" '테스트 서버
			DatabaseName_		= "localTest" 
			DatabaseUser_		= "sa" '테스트서버
			DatabasePassword_	= "flznltit12#$" '테스트서버
			FileSaveRoot_		= "\" '테스트서버

		end if 

		IgnoreParams		= "x,y"
		IgnoreBlockHtml		= "editor1,dlContent"
		Transaction			= False
		SesNo				= 0
		SesName			= "purecottonSession"
		Call DevelopmentMode ()
	End Sub

	' 소멸자
	Public Sub Class_Terminate ()
	End Sub

	'** Database Server Setter
	Public Property Let DatabaseServer_(v)
		DatabaseServer		= v
	End Property

	'** Database Server Getter
	Public Property Get DatabaseServer_()
		DatabaseServer_		= DatabaseServer
	End Property

	'** Database Name Setter
	Public Property Let DatabaseName_(v)
		DatabaseName		= v
	End Property

	'** Database Name Getter
	Public Property Get DatabaseName_()
		DatabaseName_		= DatabaseName
	End Property

	'** Login User ID Setter
	Public Property Let DatabaseUser_(v)
		DatabaseUser		= v
	End Property

	'** Login User ID Getter
	Public Property Get DatabaseUser_()
		DatabaseUser_		= DatabaseUser
	End Property

	'** Login User Password Setter
	Public Property Let DatabasePassword_(v)
		DatabasePassword	= v
	End Property

	'** Login User Password Getter
	Public Property Get DatabasePassword_()
		DatabasePassword_	= DatabasePassword
	End Property

	'** Database Transaction Setter
	Public Property Let Transaction_(v)
		Transaction	= v
	End Property

	'** Database Transaction Getter
	Public Property Get Transaction_()
		Transaction_	= Transaction
	End Property

	'** Upload Default Path Setter
	Public Property Let FileSaveRoot_(v)
		FileSaveRoot	= v
	End Property

	'** Upload Default Path Getter
	Public Property Get FileSaveRoot_()
		FileSaveRoot_	= FileSaveRoot
	End Property

	'** 자동으로 받지 않을 파라미터 세팅
	Public Property Let IgnoreParams_ (v)
		IgnoreParams = IgnoreParams & "," (v)
	End Property

	Public Property Get IgnoreParams_ ()
		IgnoreParams_ = Replace(LCase(IgnoreParams),",","|")
	End Property

	'** htmlBlock를 테우지 않을 파라미터 셋팅
	Public Property Let IgnoreBlockHtml_ (v)
		IgnoreBlockHtml = IgnoreBlockHtml & "," (v)
	End Property

	Public Property Get IgnoreBlockHtml_ ()
		IgnoreBlockHtml_ = Replace(LCase(IgnoreBlockHtml),",","|")
	End Property

	'** 개발 환경 세팅
	Private Sub DevelopmentMode ()
		HTTP_HOST = LCase(Request.ServerVariables("HTTP_HOST"))

		If instr(HTTP_HOST, "wyliedev.co.kr") > 0 Or instr(HTTP_HOST, "local.co.kr") > 0 Then
			isDev = "Y"

			If instr(HTTP_HOST, "local.co.kr") > 0 Then
				DomainName		= "http://purecotton.local.co.kr/"
			ElseIf instr(HTTP_HOST, "wyliedev.co.kr") > 0 Then
				DomainName		= "http://purecotton.wyliedev.co.kr/"
			End If 
		end If 
	End Sub
End Class

'// Global variable //
Dim page
If page = "" Then page = 1
If page <> "" Then
	If Not isNumeric(page) Then page = 1
End If
Dim thisUrl : thisUrl = Trim(LCase(Request.ServerVariables("SCRIPT_NAME")))
Dim totalRs : totalRs = 0
Dim totalPage : totalPage = 0
Dim totalCount : totalCount = 0
Dim listNo : listNo = 0
Dim GlobalBrowserTitle : GlobalBrowserTitle = "" '브라우저 타이틀
%>