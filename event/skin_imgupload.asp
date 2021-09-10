<!-- #include virtual = "/include/core/class.db.asp" -->
<!-- #include virtual = "/include/core/class.file.asp" -->
<%
Set f = New FILEMANAGER 'file class 선언
If upload_img <> "" Then 
	f.RndFileName_ = True
	RETURN_FILE = f.FileUpload("upload_img", "evtskin")
	upload_img = Split(RETURN_FILE, "|")(0)
	
	If upload_img = "ERROR" Then 
		Response.write "{""result"": ""FAIL""}"
	Else
		imagePath = cfg.FileSaveRoot_ &"evtskin\"& upload_img
		'set imageSize=LoadPicture(imagePath)
		'img_width = CLng(CDbl(imageSize.Width)*24/635)
		'img_height = CLng(CDbl(imageSize.Height)*24/635) 
		'set imageSize=nothing

		'Response.write "{""result"": ""OK"", ""file_path"": ""/upload/evtskin/"", ""file_name"": """& upload_img &""", ""image_width"":"""& img_width &""", ""image_height"": """& img_height &"""}"
		Response.write "{""result"": ""OK"", ""file_path"": ""/upload/evtskin/"", ""file_name"": """& upload_img &"""}"
	End If 
Else
	Response.write "FAIL"
End If 
%>