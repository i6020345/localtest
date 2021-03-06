<%
If isObject(Application("GQM")) Then
	Application("GQM").Close
	Set Application("GQM") = Nothing
End If
Set appRs = Server.CreateObject("ADOR.RecordSet")
appRs.ActiveConnection = Nothing
appRs.CursorLocation = adUseClient
appRs.LockType = adLockBatchOptimistic
With appRs.Fields
	.Append "xml", adVarchar, 32
	.Append "id", adVarchar, 32
	.Append "text", adVarchar, 1024
	.Append "desc", adVarchar, 512
	.Append "exp", adVarchar, 10
End With
appRs.Open ()

CONST_XML_DEFAULT_PATH = Server.Mappath("\") & "\include\query"
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
Set objFolder = objFSO.GetFolder(CONST_XML_DEFAULT_PATH)
Set objCollection = objFolder.Files
Set objXML = Server.CreateObject("Microsoft.XMLDOM")
objXML.preserveWhiteSpace = True
objXML.async = False
errMsg = ""
On Error Resume Next
For Each objItem in objCollection
	If LCase(Right(objItem.Name,4)) = ".xml" Then
		objXML.load (CONST_XML_DEFAULT_PATH & "\" & objItem.Name)
		If objXML.parseError.errorCode <> 0 Then
			errMsg = errMsg & objItem.Name & " Load 실패\n\n"
		Else
			For Each node in objXML.SelectNodes("/root/query")
				use = "Y"
				use = node.GetAttribute("use")
				expires = node.GetAttribute("expires")
				desc = node.GetAttribute("description")
				If isNull(expires) Then expires = "2100-12-31"
				If CDate(expires) < Date() Then use = "N"
				If isNull(use) Then use = "Y"
				If isNull(desc) Then desc = "-"
				If use = "Y" And Trim(node.text) <> "" Then
					Response.Write Trim(node.text) & "<hr />"
					appRs.AddNew
					appRs("xml") = Replace(objItem.Name,".xml","",1,-1,1)
					appRs("id") = node.GetAttribute("id")
					appRs("text") = Trim(node.text)
					appRs("desc") = desc
					appRs("exp") = expires
					appRs.Update
				End If
			Next
		End If
	End If
Next
Application.Lock ()
Set Application("GQM") = appRs
Application.UnLock ()
Set objXML = Nothing
Set objCollection = Nothing
Set objFolder = Nothing
Set objFSO = Nothing
%>
<script language="javascript" type="text/javascript">
<!--
	<%
	If errMsg <> "" Then
	%>alert("<%=errMsg%>");
	<%
	End If
	%>
//-->
</script>