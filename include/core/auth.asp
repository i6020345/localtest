<%
'전역으로 사용 interface / preterface
'서버작업시 페이지 임시점검 사이트로 이동
Dim clientIP

clientIP = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If clientIP = "" Then 
clientIP = Request.ServerVariables("REMOTE_HOST")

End If 

'Response.Write clientIP
'Response.end
If InStr(clientIP, "61.252.139") < 1 And clientIP <> "106.251.239.202" And clientIP <> "220.230.127.79" And clientIP <> "49.236.151.65" And clientIP <> "115.95.113.67" Then 
	'Response.redirect "http://construct.bosomi.co.kr/"
	'Response.end
End If 
%>