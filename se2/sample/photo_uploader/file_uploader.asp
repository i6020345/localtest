<!-- #include virtual = "/include/core/class.db.asp" -->
<!-- #include virtual = "/include/core/class.file.asp" -->
<%
'Call util.PrintParams()

Set f = New FILEMANAGER 'file class 선언

Set db = New DBMANAGER
WIth db

regDate = Now()
regIP = cfg.USER_IP

'//Filedata

'callback = callback & "?callback_func=" & callback_func
callback = "./callback.html" & "?callback_func=" & callback_func

If Filedata <> "" Then 
	f.DeleteFile "Filedata", ori_Filedata
	RETURN_FILE = f.FileUpload("Filedata", "se2")
	Filedata = Split(RETURN_FILE, "|")(0)

	If Filedata = "ERROR" Then 
		callback = callback & "&errstr=error"
	Else
		'callback = callback & "&errstr=" & Filedata
		callback = callback & "&bNewLine=true"
		callback = callback & "&sFileName=" & Filedata
		callback = callback & "&sFileURL=/upload/se2/" & Filedata
	End If 
End If 

End With
Set db = Nothing

Set f = Nothing 

Response.redirect callback
%>