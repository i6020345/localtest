<!-- #include virtual = "/include/core/class.db.asp" -->
<!-- #include virtual = "/include/core/class.file.asp" -->
<%
'Call util.PrintParams()

Set f = New FILEMANAGER 'file class 선언

f.RndFileName_ = True 

regDate = Now()
regIP = cfg.USER_IP

If uploadBtn <> "" Then 
	RETURN_FILE = f.FileUpload("uploadBtn", fd)
	files = Split(RETURN_FILE, "|")(0)
    filesize = Split(RETURN_FILE, "|")(2)

	fileOriName = Split(RETURN_FILE, "|")(1)
	'fileMime = Split(RETURN_FILE, "|")(3)
	'fileExt = Split(RETURN_FILE, "|")(4)

	If files = "ERROR" Then 
		util.MsgEnd "파일업로드 실패 : " & Split(RETURN_FILE, "|")(1)
		Response.End
	End If 
End If 

Set f = Nothing 

'response.write files
%>
{"files": [
  {
    "name": "<%=files%>",
    "size": <%=filesize%>,
    "oriName": "<%=fileOriName%>",
	"mime": "image",
	"ext": "ext",
    "url": "\/upload\/<%=fd%>\/<%=files%>",
    "thumbnailUrl": "\/upload\/<%=fd%>\/<%=files%>",
    "deleteUrl": "\/upload\/<%=fd%>\/<%=files%>",
    "deleteType": "DELETE"
  }
]}
