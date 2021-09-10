<!-- #INCLUDE VIRTUAL = "/include/core/class.config.asp" -->
<!-- #INCLUDE VIRTUAL = "/include/core/class.function.asp" -->
<!-- #INCLUDE VIRTUAL = "/include/core/const.asp" -->
<!-- #INCLUDE VIRTUAL = "/include/core/auth.asp" -->
<%
Class UTILITY

	Private Sub Class_Initialize ()
		Set cfg	= New WEBCONFIG
		Set fnc	= New CUSTOMFUNCTION
		Call GetParams()
	End Sub

	Private Sub Class_Terminate ()
		Set cfg	= Nothing
		Set fnc	= Nothing
	End Sub

	'********************************************************************************
	'* Request값 자동으로 받기
	'********************************************************************************
	Private Sub GetParams ()
		Dim item,tmp,hct
		hct = getVar("HTTP_CONTENT_TYPE")
		If hct = "" Then hct = "application/x-www-form-urlencoded"
		If LCase(Trim(Split(hct,";")(0))) <> "multipart/form-data" Then
			If UCase(getVar("REQUEST_METHOD")) = "POST" Then
				For Each item In Request.Form
					If InStr(cfg.IgnoreParams_,LCase(item)) < 1 And Not isNumeric(item) Then
						Execute (item & " = strCheck(Trim(Request.Form(item)))")
					End If
				Next
			Else
				For Each item In Request.QueryString
					If isEng(Left(item,1)) And InStr(cfg.IgnoreParams_,LCase(item)) < 1 And Not isNumeric(item) Then
						Execute (item & " = strCheck(Trim(Request.QueryString(item)))")
					End If
				Next
			End If
		End If
	End Sub

	'********************************************************************************
	'* Request값 링크용 파라미터 변수에 추가
	'********************************************************************************
	Public Function LinkPars (byVal p)
		Dim item,tmp,hct
		hct = getVar("HTTP_CONTENT_TYPE")
		If hct = "" Then hct = "application/x-www-form-urlencoded"
		tmp = ""
		If LCase(Trim(Split(hct,";")(0))) <> "multipart/form-data" Then
			If UCase(getVar("REQUEST_METHOD")) = "POST" Then
				For Each item In Request.Form
					If InStr(LCase(p),LCase(item)) < 1 Then
						If tmp <> "" Then tmp = tmp & ("&")
						tmp = tmp & (item & "=" & strCheck(Trim(Request.Form(item))))
					End If
				Next
			Else
				For Each item In Request.QueryString
					If InStr(LCase(p),LCase(item)) < 1 Then
						If tmp <> "" Then tmp = tmp & ("&")
						tmp = tmp & (item & "=" & strCheck(Trim(Request.QueryString(item))))
					End If
				Next
			End If
			LinkPars = tmp
		End If
	End Function

	'********************************************************************************
	'* 영문,숫자 조합 난문자 발생기 (첫글자는 영문)
	'* length : 난문자 길이
	'* Num		: 숫자 사용 (True : 사용)
	'********************************************************************************
	Public Function RandomText (ByVal length, ByVal num)
		'rantext 변수에 값 저장
		'length : 문자열 길이
		Randomize
		Dim r, ran, ranText
		r			= 1
		ran		= Int((90 - 65 + 1) * Rnd + 65)
		rantext	= Chr(ran)
		Do While r < length
			ran	= Int((90 - 48 + 1) * Rnd + 48)
			If num Then
				If (ran >= 48 And ran <= 57) Or (ran >= 65 And ran <= 90) Then
					rantext = rantext & Chr(ran)
					r = r + 1
				End If
			Else
				If ran >= 65 And ran <= 90 Then
					rantext = rantext & Chr(ran)
					r = r + 1
				End If
			End If
		Loop
		RandomText = rantext
	End Function

	'********************************************************************************
	'* 메일 보내기
	'* fromuser	: 보내는일 메일주소
	'* takeuser	: 받는이 메일주소
	'* mtitle	: 메일 제목
	'* URL		: 메일 BODY 내용 URL 주소
	'********************************************************************************
	Public Sub MailSender(byVal fromuser,byVal takeuser,byVal mtitle, byVal mbody)
		If Trim(mbody) <> "" Then
			Dim objMessage : Set objMessage = Server.CreateObject("CDO.Message")
			Dim iConf : Set iConf = objMessage.Configuration
			With iConf.Fields
				.item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1
				.item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "C:\inetpub\mailroot\pickup"
				.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
				.item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
				.item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 1
				.update
			End With
			Dim mailChar : mailChar = "utf-8"
				With objMessage
					.To = takeuser
					.From = fromuser
					.Subject = mtitle
					.BodyPart.Charset=mailChar
	'				.HTMLBodyPart.Charset=mailChar
					.HTMLBody = mbody
					.Send
				End With
			If Err.Number <> 0 Then
				Set objMessage = Nothing
				Exit Sub
			End If
			Set objMessage = Nothing
		End If
	End Sub

	Public Function GetMailBody (byVal URL)
		Set xh = Server.CreateObject("Microsoft.XMLHTTP")
		With xh
			.Open "GET", URL , False
			.Send()
		End With
		GetMailBody = xh.ResponseText
		Set xh = Nothing
	End Function


	'********************************************************************************
	'* 이미지 태그만 추출시 -> 배열로 반환
	'* html		: html 문장
	'* patrn	: 가져올 타입
	'* patrn.1	: 이미지 태그만 가져오기
	'* patrn.2	: 이미지 경로와 이미지명 가져오기
	'* patrn.3	: 이미지명만 가져오기
	'********************************************************************************
	Public Function GetImageTag(ByVal html, ByVal patrn)
		Dim regEx,RetStr,Matches
		Select Case patrn
			Case "1"
				patrn = "<img [^<>]*>"
			Case "2"
				patrn = "[^= ']*\.(gif|jpg|bmp|png)"
			Case "3"
				patrn = "[^= '/]*\.(gif|jpg|bmp)"
		End Select
		Set regEx = New RegExp
		With regEx
			.IgnoreCase = True
			.Global = True
			.Pattern =  patrn
		End With
		Set Matches = regEx.Execute(html)
		RetStr = ""
		For Each Match in Matches
			RetStr = RetStr & vblf & Match.Value
		Next
		Set Matches = Nothing
		Set regEx = Nothing
		GetImageTag = Split(RetStr,vblf)
	End Function

	'********************************************************************************
	'* 문자열 추출
	'* str		: str 문장
	'* patrn	: 가져올 타입
	'* typ.1	: 한글만
	'* typ.2	: 숫자만
	'* typ.3	: 영어만
	'* typ.4	: 숫자와 영어 한글만
	'* typ.5	: 태그만
	'* typ.6	: 영어 숫자만
	'* typ.7	: 이미지 태그만
	'* typ.8	: 이미지명만 가져오기
	'* typ.9	: 이미지 경로와 이미지명 가져오기
	'********************************************************************************
	Public Function strPattern (ByVal str, ByVal patrn)

		Select Case patrn
			Case "1"
				patrn = "[ㄱ-ㅎ가-힣ㅏ-ㅣ]"
			Case "2"
				patrn = "[0-9]"
			Case "3"
				patrn = "[-a-zA-Z]"
			Case "4"
				patrn = "[-가-힣a-zA-Z0-9/]"
			Case "5"
				patrn = "<[^>]*>"
			Case "6"
				patrn = "[-a-zA-Z0-9/]"
			Case "7"
				patrn = "<img [^<>]*>"
			Case "8"
				patrn = "[^= ']*\.(gif|jpg|bmp|png)"
		End Select

		Dim regEx, match, matches,RetStr

		Set regEx = New RegExp
			regEx.IgnoreCase = True
			regEx.Global = True
			regEx.Pattern = patrn

		Set Matches = regEx.Execute(str)

		For Each Match in Matches
			RetStr = RetStr & Match.Value
		Next

		Set regEx = Nothing
		Set Matches = Nothing

		strPattern = RetStr

	End Function

	Public Function getImage(ByVal url)
		Dim Http,ret
		Set Http = CreateObject("MSXML2.ServerXMLHTTP")
		Http.Open "GET", url, False
		Http.Send
		ret = Http.ResponseBody
		Set Http = Nothing
		getImage = ret
	End Function

	'********************************************************************************
	'* 통화량으로 변환
	'* num	: 변환할 숫자
	'********************************************************************************
	Public Function FN(ByVal num)
		If isNumeric(Trim(num)) Then FN = FormatNumber(num,0) Else FN = num
	End Function

	'********************************************************************************
	'* URLEncode
	'* pars	: 파라미터명
	'********************************************************************************
	Public Function parsEncode (ByVal pars)
		If isNull(pars) Then pars = ""
		parsEncode = Server.UrlEncode(pars)
	End Function

	'********************************************************************************
	'* Ceil 함수 (올림함수)
	'********************************************************************************
	Public Function Ceil (ByVal n1,ByVal n2)
		If Int(n1 / n2) < (n1 / n2) Then Ceil = Int(n1 / n2) + 1 Else Ceil = n1 / n2
	End Function

	'********************************************************************************
	'* 해당월 마지막 날짜 구하기
	'* ym	: yyyy-mm
	'********************************************************************************
	Public Function GetLastDay(ByVal ym)
		If Not isDate(ym & "-01") Then
			Exit Function
		Else
			GetLastDay = DateAdd("D",-1,DateAdd("M",1,CDate(ym & "-01")))
		End if
	End Function


	'********************************************************************************
	'* 서버 환경변수
	'********************************************************************************
	Public Function getVar(ByVal key)
		getVar = Request.ServerVariables(key)
	End Function

	'********************************************************************************
	'* 일반 경고 메세지
	'********************************************************************************
	Public Sub MsgBox(ByVal msg)
		Response.Write "<script type=""text/javascript"">alert(""" & msg & """);</script>"
	End Sub

	'********************************************************************************
	'* 경고 메시지 후 스크립트 종료
	'********************************************************************************
	Public Sub MsgEnd(ByVal msg)
		Response.Write "<script type=""text/javascript"">alert(""" & msg & """);</script>"
		Response.End
	End Sub

	'********************************************************************************
	'* 스크립트 사용
	'********************************************************************************
	Public Sub MsgAction(byVal ActionScript, byVal bool)
		Response.Write "<script type=""text/javascript"">"& ActionScript & "</script>"
		If bool Then
			Response.End
		End If
	End Sub

	'********************************************************************************
	'* 경고 메세지후 뒤로 이동
	'********************************************************************************
	Public Sub MsgBack(ByVal msg)
		Response.Write "<script type=""text/javascript"">alert(""" & msg & """); history.go(-1);</script>"
		Response.End
	End Sub

	'********************************************************************************
	'* 경고 메세지후 해당 URL로 이동
	'********************************************************************************
	Public Sub MsgUrl(ByVal msg,ByVal url,ByVal target)
		If target <> "" Then target = target & "."
		Response.Write "<script type=""text/javascript"">" & vblf
		If msg <> "" Then Response.Write "	 alert(""" & msg & """); " & vblf
		Response.Write target & "	 location.replace('" & url & "');" & vblf
		If LCase(target) = "	opener." Then Response.Write "self.close();" & vblf
		Response.Write "</script>"
		Response.End
	End Sub

	'********************************************************************************
	'* 경고 메세지후 해당 컨펌 후 URL로 이동
	'********************************************************************************
	Public Sub MsgConfirm(ByVal msg, ByVal url,ByVal target)
		If target <> "" Then target = target & "."
		Response.Write "<script type=""text/javascript"">if(confirm(""" & msg & """)){ " & target & "location.replace('" & url & "');}</script>"
		Response.End
	End Sub

	'********************************************************************************
	'* 경고 메세지후 팝업 닫기
	'********************************************************************************
	Public Sub MsgClose(ByVal msg)
		Response.Write "<script type=""text/javascript"">alert(""" & msg & """); self.opener = self; self.close();</script>"
		Response.End
	End Sub

	'********************************************************************************
	'* 문자열의 치환
	'* 용도 : DB입력시 따옴표 처리
	'********************************************************************************
	Public Function strCheck(ByVal str)
		If Trim(str) <> "" AND Not isNull(str) AND Not isEmpty(str) Then
			str = Replace(str,"'","'")
			str = Replace(str,"--","")
			str = Replace(str,"union","union",1,-1,1)
	'		str = Replace(str,"""","&quot;")
	'		str = Replace(str,";","&#59;")
		End If
		strCheck = str
	End Function

	'********************************************************************************
	'* 문자열의 치환
	'* 용도 : DB입력시 따옴표 처리
	'********************************************************************************
	Public Function inputText(ByVal str)
		If Trim(str) <> "" AND Not isNull(str) AND Not isEmpty(str) Then
			str = Replace(str,"""","&quot;")
			str = Replace(str,";","&#59;")
		End If
		inputText = str
	End Function


	'********************************************************************************
	'* HTML사용 금지
	'********************************************************************************
	Public Function htmlBlock(ByVal str)
		If str <> "" And Not isNull(str) Then
			
			str = Replace(str,"'","&#39;")
			str = Replace(str,"""","&quot;")
			str = Replace(str,"&","&amp;")
			str = Replace(str,"<","&lt;")
			str = Replace(str,">","&gt;")
			
			htmlBlock = Replace(Replace(Replace(Replace(str,"&","&"),"<","&lt;"),"""","&quot;"),"'","&#39;")
			'htmlBlock = str
		Else
			htmlBlock = ""
		End If
	End Function


	'********************************************************************************
	'* HTML사용 허용
	'********************************************************************************
	Public Function htmlAllow(byVal str)
		If str <> "" And Not isNull(str) Then
			
			str = Replace(str,"&#39;","'")
			str = Replace(str,"&quot;","""")
			str = Replace(str,"&amp;","&")
			str = Replace(str,"&lt;","<")
			str = Replace(str,"&gt;",">")
			
			htmlAllow = Replace(Replace(Replace(Replace(str,"&lt;","<"),"&amp;","&"),"&quot;",""""),"&#39;","'")
			'htmlAllow = str
		Else
			htmlAllow = ""
		End If
	End Function


	'********************************************************************************
	'* 문자열의 치환
	'* 용도 : 수정시 text에 넣기 위해 문자 치환
	'********************************************************************************
	Public Function StringForInputBox(ByVal str)
		If isNull(str) Then str = ""
		StringForInputBox = Replace(Replace(Replace(str,"''","&#39;"),"'","&#39;"),"""","&quot;")
	End Function

	'********************************************************************************
	'* 내용에 태그 부분 모두 삭제
	'********************************************************************************
	Public Function htmlClear(ByVal str)
		If isNull(str) Then str = ""
		Dim ObjRegExp
		Set ObjRegExp = New RegExp
		With ObjRegExp
			.Global = True
			.IgnoreCase = True
			.Pattern = "<[\?\a-zA-Z\/\s][^>]*>"
			str = .Replace(str, "")
		End With
		Set ObjRegExp = Nothing
		htmlClear = str
	End Function

	'********************************************************************************
	'* 말줄임
	'* str		: 텍스트
	'* length	: bytes
	'* tail		: 말줄임 텍스트(..)
	'********************************************************************************
	Public Function cutString(ByVal str, ByVal length, byVal tail)
		'** 문자열 길이 추출
		Dim SpecialText	: SpecialText	= "`~!@#$%^&*()_+-=[]{}\|'"";:/?.>,<"
		Dim bytes			: bytes			= 0
		Dim retStr			: retStr			= ""
		Dim Char
		Dim strLen
		str = htmlAllow(str)
		If isEmpty(str) Or isNull(str) Then strLen = -1 Else strLen = Len(str)

		For nn = 1 To strLen
			Char = Mid(str,nn,1)
			If (Char >= "a" And Char <= "z") Or (Char >= "A" And Char <= "Z") Or (Char >= "1" And Char <= "9") Or inStr(SpecialText,Char) > 0 Or Char = " " Or Char = "	 " Then bytes = bytes + 1 Else bytes = bytes + 2
			retStr = retStr & Char
			If CInt(bytes) >= CInt(length) Then
				retStr = retStr & tail
				Exit For
			End If
		Next
		cutString = htmlBlock(retStr)
	End Function

	'********************************************************************************
	'* 바이트 체크
	'* str		: 텍스트
	'********************************************************************************
	Public Function byteCheck(ByVal str)
		Dim sLen, tLen, hLen, retBytes
		sLen = Len(str)
		hLen = Len(strPattern(str,1))
		sLen = sLen - hLen
		retBytes = sLen + (hLen * 2)
		byteCheck = retBytes
	End Function

	'********************************************************************************
	'* Response.Write 하기 귀찮아서
	'* str : 화면에 찍어볼 String
	'********************************************************************************
	Public Sub Echo (ByVal str)
		Response.Write str
	End Sub

	'********************************************************************************
	'* 쿠키값 설정 : 배열로 선언
	'* cookname  : 쿠키명
	'* subname   : 배열명
	'* cookvalue : 세팅값
	'********************************************************************************
	Public Sub SetCookie(byVal cookname, byVal subname, byVal cookvalue)
		If subname = "" OR Trim(subname) = "" OR isEmpty(subname) OR isNull(subname) Then
			Response.Cookies(cookname) = cookvalue
		Else
			Response.Cookies(cookname)(subname) = cookvalue
		End If
	End Sub

	'********************************************************************************
	'* 쿠키값 읽기
	'* cookname  : 쿠키명
	'* subname   : 배열명
	'********************************************************************************
	Public Function GetCookie(ByVal cookname, ByVal subname)
		If subname = "" OR Trim(subname) = "" OR isEmpty(subname) OR isNull(subname) Then
			GetCookie = Trim(Request.Cookies(cookname))
		Else
			GetCookie = Trim(Request.Cookies(cookname)(subname))
		End If
	End Function

	'********************************************************************************
	'* 쿠키값 삭제
	'* cookname  : 쿠키명
	'********************************************************************************
	Public Sub DelCookie(ByVal cookname)
		Response.Cookies(cookname) = ""
		Response.Cookies(cookname).Expires = Now() - 1000
	End Sub

	'********************************************************************************
	'* Request 값 hidden으로 Print
	'********************************************************************************
	Public Sub EchoHidden(byVal ignoreHidden)
		ignoreHidden = "|" & Replace(ignoreHidden,",","|") & "|" & Replace(cfg.IgnoreParams_,",","|")
		If UCase(getVar("REQUEST_METHOD")) = "POST" Then
			For Each reqItem In Request.Form
				If InStr(LCase(ignoreHidden),"|" & LCase(reqItem) & "|") < 1 Then
					Response.Write "<input type=""hidden"" id=""" & reqItem & """ name=""" & reqItem & """ value=""" & Replace(Trim(Request.Form(reqItem)),"""","&quot;") & """ />"  & vblf
				End If
			Next
		Else
			For Each reqItem In Request.QueryString
				If InStr(LCase(ignoreHidden),"|" & LCase(reqItem) & "|") < 1 Then
					Response.Write "<input type=""hidden"" id=""" & reqItem & """ name=""" & reqItem & """ value=""" & Replace(Trim(Request.QueryString(reqItem)),"""","&quot;") & """ />"  & vblf
				End If
			Next
		End If
	End Sub

	'********************************************************************************
	'* Request값 찍기
	'********************************************************************************
	Public Sub PrintParams ()
		Dim item,tmp,hct
		hct = getVar("HTTP_CONTENT_TYPE")
		If hct = "" Then hct = "application/x-www-form-urlencoded"
		Response.Write "<table border='0' cellpadding='0' cellspacing='1' bgcolor='black' width='100%'>" & vblf
		Response.Write "<tr style='padding: 3px;background-color: white;'><td style='width: 200px;' nowrap>변수명</td><td>데이타</td></tr>" & vblf
		Response.Write "<tr style='padding: 3px;background-color: white;'><td style='width: 200px;' nowrap>전송 페이지</td><td>" & getVar("HTTP_REFERER") & "</td></tr>" & vblf
		For Each item In Request.Form
			Response.Write "<tr style='padding: 3px;background-color: white;' onmouseover=""this.style.backgroundColor='#ebebeb'"" onmouseout=""this.style.backgroundColor='#ffffff'""><td>" & item & "</td><td>" & Trim(Request.Form(item)) & "</td></tr>" & vblf
		Next

		For Each item In Request.QueryString
			Response.Write "<tr style='padding: 3px;background-color: white;' onmouseover=""this.style.backgroundColor='#ebebeb'"" onmouseout=""this.style.backgroundColor='#ffffff'""><td>" & item & "</td><td>" & Trim(Request.QueryString(item)) & "</td></tr>" & vblf
		Next
		Response.Write "</table>" & vblf
	End Sub

	'********************************************************************************
	'* 이메일 유효성 검사
	'********************************************************************************
	Public Function isEmail(ByVal myEmail)
		Dim isValidE, regEx
		isValidE = True
		Set regEx = New RegExp
		With regEx
			.IgnoreCase = False
			.Pattern = "^[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
			isValidE = .Test(myEmail)
		End With
		Set regEx = Nothing
		isEmail = isValidE
	End Function

	'********************************************************************************
	'* 우편번호 유효성 검사
	'********************************************************************************
	Public Function isZipCode(ByVal myZipCode)
		Dim isValidE, regEx
		isValidE = True
		Set regEx = New RegExp
		With regEx
			.IgnoreCase = False
			.Pattern = "^[0-9]{3}-[0-9]{3}$"
			isValidE = .Test(myZipCode)
		End With
		Set regEx = Nothing
		isZipCode = isValidE
	End Function

	'********************************************************************************
	'* 전화번호 유효성 검사
	'********************************************************************************
	Public Function isTel(ByVal myTel)
		Dim isValidE, regEx
		isValidE = True
		Set regEx = New RegExp
		With regEx
			.IgnoreCase = False
			.Pattern = "^0[1-9]{1,2}-[0-9]{3,4}-[0-9]{4}$"
			isValidE = .Test(myTel)
		End With
		Set regEx = Nothing
		isTel = isValidE
	End Function

	'********************************************************************************
	'* 핸드폰 유효성 검사
	'********************************************************************************
	Public Function isHp(ByVal myHp)
		Dim isValidE, regEx
		isValidE = True
		Set regEx = New RegExp
		With regEx
			.IgnoreCase = False
			.Pattern = "^01[0-9]-[0-9]{3,4}-[0-9]{4}$"
			isValidE = .Test(myHp)
		End With
		Set regEx = Nothing
		isHp = isValidE
	End Function

	'********************************************************************************
	'* 배열 비교
	'* arr : 배열
	'* var : 비교값
	'********************************************************************************
	Public Function inArray(ByVal arr, ByVal var)
		Dim bool, i
		bool = False
		For i = 0 to UBound(arr)
			If (Lcase(Cstr(arr(i))) = Lcase(Cstr(var))) Then bool = True : Exit For
		Next
		inArray = bool
	End Function

	'********************************************************************************
	'* 날짜로 요일 받아오기
	'* dt	: 날짜형식 (yyyy-mm-dd)
	'********************************************************************************
	Public Function getDayName (ByVal dt)
		If Not isDate(dt) Then
			getDayName = ""
		Else
			getDayName	 = WeekDayName(WeekDay(dt))
		End If
	End Function


	'********************************************************************************
	'* 텍스트 패턴 비교 (영문 또는 숫자)
	'* str	: 텍스트
	'*봔환 : boolean
	'********************************************************************************
	Public Function isEngNum(byVal str)
		Dim regEx, match, matches, patrn, bool
		patrn = "[^a-zA-Z0-9/ ]"
		Set regEx = new RegExp
		With regEx
			.pattern = patrn
			.ignoreCase = True
			.Global = True
			Set Matches = .Execute(str)
		End With
		bool = True
		If 0 < Matches.count Then bool = False
		Set Matches = Nothing
		Set regEx = Nothing
		isEngNum = bool
	End Function

	'********************************************************************************
	'* 텍스트 패턴 비교 (숫자)
	'* str	: 텍스트
	'*봔환 : boolean
	'********************************************************************************
	Public Function isNum(byVal str)
		Dim regEx, match, matches, patrn, bool
		patrn = "[^0-9/ ]"
		Set regEx = new RegExp
		With regEx
			.pattern = patrn
			.ignoreCase = True
			.Global = True
			Set Matches = .Execute(str)
		End With
		bool = True
		If 0 < Matches.count Then bool = False
		Set regEx = Nothing
		Set Matches = Nothing
		isNum = bool
	End Function

	'********************************************************************************
	'* 텍스트 패턴 비교 (영어)
	'* str	: 텍스트
	'*봔환 : boolean
	'********************************************************************************
	Public Function isEng(byVal str)
		Dim regEx, match, matches, patrn, bool
		patrn = "[^a-zA-Z/ ]"
		Set regEx = new RegExp
		With regEx
			.pattern = patrn
			.ignoreCase = True
			.Global = True
			Set Matches = .Execute(str)
		End With
		bool = True
		If 0 < Matches.count Then bool = False
		Set regEx = Nothing
		Set Matches = Nothing
		isEng = bool
	End Function

	'********************************************************************************
	'* 문자열 비교
	'* 봔환 : boolean
	'********************************************************************************
	Public Function Compare (byVal txt1, byVal txt2)
		If isNull(txt1) Then txt1 = ""
		If isNull(txt2) Then txt2 = ""
		If Trim(txt1) = "" And Trim(txt2) <> "" Then Compare = False : Exit Function
		If Replace(Trim(txt1),Trim(txt2),"",1,-1,1) = "" Then Compare = True Else Compare = False
	End Function

	'** 자동 링크
	Public Function AutoLink (byVal content)
		Dim lnk
		If isNull(content) Then content = ""
		Set lnk = New RegExp
		lnk.Pattern = "(\w+):\/\/([^/:]+)(:\d*\b)?([^# \n<]*).*\n"
		lnk.Pattern = "([0-9a-zA-Z./@:~?&=_-]+)"
		lnk.Pattern = "http://([0-9a-zA-Z./@:~?&=_-]+)"
		lnk.Global = True
		lnk.IgnoreCase = True
		content = lnk.Replace(content,"<a target=_blank href='http://$1' class='link'>http://$1</a>")
		lnk.Pattern = "([_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+)*)@([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*)"
		AutoLink = lnk.Replace(content,"<a href='mailto:$1@$3'>$1@$3</a>")
		Set lnk= Nothing
	End Function

	' 날짜 형식 반환
	'
	Public Function DateFormat (byVal dateVal, byVal vmode)
		vmode = UCASE(vmode)
		Dim y,m,d,h,mi,s
		If isDate(dateVal) Then
			dateVal = CDate(dateVal)
			y	= Year(dateVal)
			m	= Right("0" & Month(dateVal),2)
			d	= Right("0" & Day(dateVal),2)
			h	= Right("0" & Hour(dateVal),2)
			mi	= Right("0" & Minute(dateVal),2)
			s	= Right("0" & Second(dateVal),2)

			If Left(vmode,4) = "YYYY" Then vmode = Replace(vmode,"YYYY",y)
			If InStr(vmode,"YY") > 0 Then vmode = Replace(vmode,"YY",Right(y,2))
			If InStr(vmode,"MM") > 0 Then vmode = Replace(vmode,"MM",m)
			If InStr(vmode,"DD") > 0 Then vmode = Replace(vmode,"DD",d)
			If InStr(vmode,"HH") > 0 Then vmode = Replace(vmode,"HH",h)
			If InStr(vmode,"MI") > 0 Then vmode = Replace(vmode,"MI",mi)
			If InStr(vmode,"SS") > 0 Then vmode = Replace(vmode,"SS",s)
			DateFormat = vmode
		Else
			DateFormat = dateVal
		End If
	End Function

	'현재 페이지 절대 경로
	Public Function GetMyUrl ()
		GetMyUrl = getVar("SCRIPT_NAME")
	End Function

	' 파일 사이즈 계산
	Public Function FileSizeCalculator (byVal orgSize)
		If Int(orgSize) > (1024 * 1024 * 1024) Then
			FileSizeCalculator	= Replace(FormatNumber(orgSize / (1024 * 1024),1) & "G",".0G","G")
		ElseIf Int(orgSize) > (1024 * 1024) Then
			FileSizeCalculator	= Replace(FormatNumber(orgSize / (1024 * 1024),1) & "M",".0M","M")
		ElseIf Int(orgSize) > 1024 Then
			FileSizeCalculator	= Replace(FormatNumber(orgSize / 1024,1) & "K",".0K","K")
		Else
			FileSizeCalculator	= orgSize & "B"
		End If
	End Function

	Public Sub SqlDebug(byVal sql)
		Response.Write Replace(Replace(sql, Chr(13) & Chr(10), "<br />"),Chr(9),"&nbsp;&nbsp;&nbsp;&nbsp;")
	End Sub

	'//bootstrap css치환 관련
	'//첨부파일 확장자에 따른 아이콘명 리턴
	Public Function getBootstrapFileIcon(ByVal ext)
		If ext = "" Then
			getBootstrapFileIcon = ""
		Else
			If ext = "jpg" Or ext = "png" Or ext = "bmp" Or ext = "jpeg" Or ext = "gif" Or ext = "ico" Then 
				getBootstrapFileIcon = "image"
			ElseIf ext = "avi" Or ext = "mpg" Or ext = "mp4" Or ext = "wmv" Then 
				getBootstrapFileIcon = "video"
			ElseIf ext = "wma" Or ext = "mp3" Or ext = "midi" Then 
				getBootstrapFileIcon = "audio"
			ElseIf ext = "zip" Then 
				getBootstrapFileIcon = "zip"
			ElseIf ext = "ppt" Or ext = "pptx" Then 
				getBootstrapFileIcon = "powerpoint"
			ElseIf ext = "xls" Or ext = "xlsx" Then 
				getBootstrapFileIcon = "excel"
			ElseIf ext = "doc" Or ext = "docx" Or ext = "hwp" Then 
				getBootstrapFileIcon = "word"
			ElseIf ext = "pdf" Then 
				getBootstrapFileIcon = "pdf"
			Else
				getBootstrapFileIcon = "archive"
			End If 
		End If 
	End Function 

	Public Function LeftPad(ByVal inVal, ByVal tLength, ByVal STR)
		Dim inValCnt
		Dim LoopCnt
		Dim resultVal : resultVal = ""
		inValCnt = Len(Cstr(inVal))
		LoopCnt = tLength - inValCnt
		For i = 1 to LoopCnt
			resultVal = resultVal & STR
		Next
		resultVal = resultVal & inVal
		LeftPad = resultVal
	End Function

	'랜던문자 만들기
	Function random()
		Dim str, strlen, r, i, ds, serialCode '변수 선언
		str = "0123456789" '랜덤으로 선택된 문자or 숫자
		strlen = 6 '출력될 값의 자릿수 ex)해당 구문에서 10자리의 랜덤 값 출력
		Randomize '랜덤 초기화
		For i = 1 To strlen
			r = Int(len(str) * Rnd + 1)
			serialCode = serialCode + Mid(str,r,1)
		Next 
		random = serialCode
	End Function 
	
	Public Function getReqNum()
		curDate = year(now) & right("0" & Month(now),2) & right("0" & day(now),2) & right("0" & hour(now),2) & right("0" & minute(now),2) & right("0" & second(now),2)
		reqNum = curDate & random()

		getReqNum = reqNum
	End Function 

	'//SSL페이지의 경우 URL을 리다이렉트 처리
	Function SSLPageRedirect(ByVal IsSSL)

		Dim resultURL : resultURL = ""
		Dim SSLPort : SSLPort = "443"

		If returnUrl <> "" Then
			return_url = "?returnUrl=" & returnUrl
		End If

		If cfg.isDev <> "Y" And IsSSL = "Y" Then '// 개발서일 경우 SSL pass by mandu 210427
			If Request.ServerVariables("HTTPS") = "off" Then
				Response.Redirect("https://www." & Replace(Request.ServerVariables("HTTP_HOST"),"www.","") & ":" & SSLPort & Request.ServerVariables("URL") & "?" & Request.ServerVariables ("QUERY_STRING"))' & return_url
				'Response.write "SSL적용되야하는 페이지입니다."
			ElseIf Request.ServerVariables("HTTPS") = "on" Then ' https가 적용 되어 있는 상태에서 www를 붙이지 않았을 때 예외 처리
				If Left(Request.ServerVariables("HTTP_HOST"),4) <> "www." Then
					Response.Redirect("https://www." & Replace(Request.ServerVariables("HTTP_HOST"),"www.","") & ":" & SSLPort & Request.ServerVariables("URL") & "?" & Request.ServerVariables ("QUERY_STRING"))' & return_url
				End If
			End If
		Else
			If Request.ServerVariables("HTTPS") = "on" Then
				Response.Redirect(Replace("http://www." & Replace(Request.ServerVariables("HTTP_HOST"),"www.","") & Request.ServerVariables("URL") & "?" & Request.ServerVariables ("QUERY_STRING"),":" & SSLPort,"")) '& return_url
			End If
		End If
	End Function

	Public Function isMobile()
		Dim user_agent, mobile_browser, Regex, match, mobile_agents, mobile_ua, i, size
 
		user_agent = Request.ServerVariables("HTTP_USER_AGENT")
		 
		mobile_browser = 0
		 
		Set Regex = New RegExp
		With Regex
		   .Pattern = "(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|windows ce|pda|mobile|mini|palm)"
		   .IgnoreCase = True
		   .Global = True
		End With
		 
		match = Regex.Test(user_agent)
		 
		If match Then mobile_browser = mobile_browser+1
		 
		If InStr(Request.ServerVariables("HTTP_ACCEPT"), "application/vnd.wap.xhtml+xml") Or Not IsEmpty(Request.ServerVariables("HTTP_X_PROFILE")) Or Not IsEmpty(Request.ServerVariables("HTTP_PROFILE")) Then
		   mobile_browser = mobile_browser+1
		end If
		 
		mobile_agents = Array("w3c ", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq", "bird", "blac", "blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco", "eric", "hipt", "inno", "ipaq", "java", "jigs", "kddi", "keji", "leno", "lg-c", "lg-d", "lg-g", "lge-", "maui", "maxo", "midp", "mits", "mmef", "mobi", "mot-", "moto", "mwbp", "nec-", "newt", "noki", "oper", "palm", "pana", "pant", "phil", "play", "port", "prox", "qwap", "sage", "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-", "siem", "smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-", "tosh", "tsm-", "upg1", "upsi", "vk-v", "voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw", "xda", "xda-")
		size = Ubound(mobile_agents)
		mobile_ua = LCase(Left(user_agent, 4))
		 
		For i=0 To size
		   If mobile_agents(i) = mobile_ua Then
			  mobile_browser = mobile_browser+1
			  Exit For
		   End If
		Next
		 
		If mobile_browser>0 Then
		   isMobile = "M"
		   'Response.Write("Mobile!")
		Else
			isMobile = "P"
		   'Response.Write("Not mobile!")
		End If
	End Function 

	Public Function getBannerFirstPositionNameName(ByVal num)
		
		Dim resultStr

		Select Case "A" & num
			Case "A1"
				resultStr = "상단띠배너"
			Case "A2"
				resultStr = "GNB배너"
			Case "A3"
				resultStr = "메인슬라이드"
			Case "A4"
				resultStr = "후원캠페인"
			Case "A5"
				resultStr = "중앙띠배너"
			Case "A6"
				resultStr = "함께하는기업"
			Case "A7"
				resultStr = "맞춤후원_좌"
			Case "A8"
				resultStr = "맞춤후원_우(상)"
			Case "A9"
				resultStr = "맞춤후원_우(하)"
			Case "A10"
				resultStr = "메인스토리배너"
		End Select 

		getBannerFirstPositionNameName = resultStr

	End Function 

End Class

Set util = New UTILITY
%>