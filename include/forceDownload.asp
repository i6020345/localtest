<!-- #include virtual = "/include/core/class.db.asp" -->
<%
	'util.encode(Request("bf_dir")) 보내기
	'util.decode(Request("bf_dir")) 받기

	Response.Expires = 0
	Response.Buffer = True
	Response.Clear

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fileName = ffl
	strFileName = Mid(fileName,Cint(InStrRev(fileName,"/")+1),Cint(Len(fileName)-InStrRev(fileName,"/")))
	filepath = Server.MapPath(left(fileName,Cint(InStrRev(fileName,"/")-1)))

	'upload 폴더 제외하고 다운로드 접근 안되도록 처리 (취약점) by mandu 200319
	If InStr(filepath, "../") > 0 or InStr(filepath, "upload") < 1 Then 
		Response.write "<script>alert('잘못된 접근입니다.');history.back(-1);</script>"
		Response.End
	End If 

 If fs.FileExists(filepath &"\"& strFileName) Then
		'파일이 있을경우 파일을 스트림 형태로 열어 보낸다.
		Response.ContentType = "application/octet-stream"
		Response.CacheControl = "public"
		Response.AddHeader "Content-Disposition","attachment;filename=" & server.URLPathEncode(strFileName) 

	 Set Stream=Server.CreateObject("ADODB.Stream")
		Stream.Open
		Stream.Type=1
		Stream.LoadFromFile filepath &"\"& strFileName
		Response.BinaryWrite Stream.Read
		Stream.close
		Set Stream = nothing
	Else 
	 '파일이 없을 경우...
		Response.Write "해당 파일을 찾을 수 없습니다."
	End If
	
 Set fs = Nothing
%>
