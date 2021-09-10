<%
'//공통 부분

'프레임웍에서 사용하는 쿼리파일의 물리경로
CONST CONST_XML_DEFAULT_PATH		= "D:\WylieProject\imc_kleannara\purecotton_web\include\query"
'대표메일주소
CONST CONST_PUBLIC_EMAIL		= "mailer@kleannara.com"
'공통 AES암호화 키값
CONST AES_CRYPT_KEY = ""
'공통 업로드 루트 웹경로
CONST CONST_UPLOAD_WEB_ROOT = "/upload"

'//관리자 관련
'게시판 리스트에 보여줄 기본 갯수
CONST ADMIN_BOARD_LIST_COUNT = 10

'//프론트 관련
'게시판 리스트에 보여줄 기본 갯수
CONST FRONT_BOARD_LIST_COUNT = 10
CONST FRONT_BOARD_PAGGING_COUNT = 10

' 관리자 
ADMIN_ADMINIDX = Trim(Request.Cookies("purecotton2018_adminIdx"))
ADMIN_ADMINID = Trim(Request.Cookies("purecotton2018_adminid"))
ADMIN_ADMINNAME = Trim(Request.Cookies("purecotton2018_adminName"))
ADMIN_ADMINLEVEL = Trim(Request.Cookies("purecotton2018_adminLevel"))
ADMIN_ADMINLOGINIP = Trim(Request.Cookies("purecotton2018_adminLoginIP"))

'//사용자
USER_LOGIN_NO = session("purecotton_MEM_NO")
USER_LOGIN_ID = session("purecotton_MEM_ID")
USER_LOGIN_NAME = session("purecotton_MEM_NAME")
USER_LOGIN_NICKNAME = session("purecotton_MEM_NICKNAME")
USER_LOGIN_EMAIL = session("purecotton_MEM_EMAIL")
USER_LOGIN_MOBILE = session("purecotton_MEM_MOBILE")

sUsrAgent = UCase(Request.ServerVariables("HTTP_USER_AGENT")) 
If InStr(sUsrAgent, "ANDROID") > 0 Then
    '안드로이드
	If Request.ServerVariables("QUERY_STRING") <> "" Then
		response.redirect("http://m.purecotton.co.kr" & Request.ServerVariables("SCRIPT_NAME") & "?" &  Request.ServerVariables("QUERY_STRING"))
	Else 
		response.redirect("http://m.purecotton.co.kr" & Request.ServerVariables("SCRIPT_NAME"))
	End if
ElseIf InStr(sUsrAgent, "IPAD") Or InStr(sUsrAgent, "IPHONE") Then
    'iOS
	If Request.ServerVariables("QUERY_STRING") <> "" Then
		response.redirect("http://m.purecotton.co.kr" & Request.ServerVariables("SCRIPT_NAME") & "?" &  Request.ServerVariables("QUERY_STRING"))
	Else 
		response.redirect("http://m.purecotton.co.kr" & Request.ServerVariables("SCRIPT_NAME"))
	End if
Else
    '웹 및 기타 디바이스
End If

%>