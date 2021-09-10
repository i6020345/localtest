<%
'** 사용자 정의 함수
Class CUSTOMFUNCTION

	Public Sub Class_Initialize ()

	End Sub

	Public Sub Class_Terminate ()

	End Sub
	
	Public Sub PageSet (byVal pb, ByVal lb, byVal ignore)
		Dim intTemp, intLoop, prev10, pageItem, ignores
		totalPage = util.Ceil(cfg.TotalCount,  pb)
		If ignore <> "" Then
			cfg.IgnoreParams_ = ignore
		End If
		ignores = "|page|" & Replace(LCase(cfg.IgnoreParams_),",","|") & "|"
		
		For Each item In Request.Form
			If InStr(ignores,"|" & LCase(item) & "|") < 1 Then pageitem = pageItem & "&" & item & "=" & Trim(Request.Form(item))
		Next

		For Each item In Request.QueryString
			If InStr(ignores,"|" & LCase(item) & "|") < 1 Then pageitem = pageItem & "&" & item & "=" & Trim(Request.QueryString(item))
		Next

		If Trim(page) = "" Or isEmpty(page) Or isNull(page) Then page = 1
		If Not isNumeric(page) Then page = 1
		intTemp = Int((page - 1) / lb) * lb + 1
		prev10 = intTemp - lb

		Response.Write "<div class='box-footer clearfix'>" & vbCrLf
		Response.Write "<ul class='pagination pagination-sm no-margin pull-right'>" & vbCrLf

		If page > lb Then
			Response.Write "		<li><a href=""" & thisUrl & "?page=1" & pageItem & """" & pageProp & ">&laquo;</a></li>" & vbCrLf
		End If

		If prev10 >= 1 Then
			Response.Write "		<li><a href=""" & thisUrl & "?page=" & prev10 & pageItem & """" & pageProp & ">&laquo;</a></li>" & vbCrLf
		Else
			Response.Write "		<li><a href=""javascript:void(0);"">&laquo;</a></li>" & vbCrLf
		End If
		intLoop = 1

		Do Until Int(intLoop) > lb Or Int(intTemp) > Int(totalPage)
			If intTemp = Int(page) Then
				Response.Write "	 <li><a href=""javascript:void(0);""><b>" & intTemp & "</b></a></li>" & vbCrLf
			Else
				Response.Write "	 <li><a href=""" & thisUrl & "?page=" & intTemp & pageItem & """" & pageProp & ">" & intTemp & "</a></li>" & vbCrLf
			End If
			intTemp = intTemp + 1
			intLoop = intLoop + 1
		Loop

		If Int(intTemp) <= Int(totalPage) Then
			Response.Write "	 <li><a href=""" & thisUrl & "?page=" & intTemp & pageItem & """" & pageProp & ">&raquo;</a></li>" & vbCrLf
		Else
			Response.Write "	 <li><a href=""javascript:void(0);"">&raquo;</a></li>" & vbCrLf
		End If

		If Int(page + lb) < Int(totalPage) Then
			Response.Write "		<li><a href=""" & thisUrl & "?page=" & totalPage & pageItem & """" & pageProp & ">" & totalPage & "</a></li>" & vbCrLf
		End If

		Response.Write "</ul>" & vbCrLf
		Response.Write "</div>"
	End Sub
	
	Public Sub PageSetFront (byVal pb, ByVal lb, byVal ignore)
		Dim intTemp, intLoop, prev10, pageItem, ignores
		totalPage = util.Ceil(cfg.TotalCount,  pb)
		If ignore <> "" Then
			cfg.IgnoreParams_ = ignore
		End If
		ignores = "|page|" & Replace(LCase(cfg.IgnoreParams_),",","|") & "|"
		
		For Each item In Request.Form
			If InStr(ignores,"|" & LCase(item) & "|") < 1 Then pageitem = pageItem & "&" & item & "=" & Trim(Request.Form(item))
		Next

		For Each item In Request.QueryString
			If InStr(ignores,"|" & LCase(item) & "|") < 1 Then pageitem = pageItem & "&" & item & "=" & Trim(Request.QueryString(item))
		Next

		If Trim(page) = "" Or isEmpty(page) Or isNull(page) Then page = 1
		If Not isNumeric(page) Then page = 1
		intTemp = Int((page - 1) / lb) * lb + 1
		prev10 = intTemp - lb

		Response.Write "<div class='paging'>" & vbCrLf

		If page > lb Then
			Response.Write "		<a href=""" & thisUrl & "?page=1" & pageItem & """" & pageProp & " class='first'>맨 처음</a>" & vbCrLf
		End If

		If prev10 >= 1 Then
			Response.Write "		<a href=""" & thisUrl & "?page=" & prev10 & pageItem & """" & pageProp & " class='prev'>이전</a>" & vbCrLf
		Else
			'Response.Write "		<a href=""javascript:void(0);"" class='arr prev'>이전페이지</a>" & vbCrLf
		End If
		intLoop = 1

		Response.Write "<span class='number'>" & vbCrLf

		Do Until Int(intLoop) > lb Or Int(intTemp) > Int(totalPage)
			If intTemp = Int(page) Then
				Response.Write "	 <strong>" & intTemp & "</strong>" & vbCrLf
			Else
				Response.Write "	 <a href=""" & thisUrl & "?page=" & intTemp & pageItem & """" & pageProp & ">" & intTemp & "</a>" & vbCrLf
			End If
			intTemp = intTemp + 1
			intLoop = intLoop + 1
		Loop

		Response.Write "</span>" & vbCrLf

		If Int(intTemp) <= Int(totalPage) Then
			Response.Write "	 <a href=""" & thisUrl & "?page=" & intTemp & pageItem & """" & pageProp & " class='next'>다음</a>" & vbCrLf
		Else
			'Response.Write "	 <a href=""javascript:void(0);"" class='arr next'>다음페이지</a>" & vbCrLf
		End If

		If Int(page + lb) < Int(totalPage) Then
			Response.Write "		<a href=""" & thisUrl & "?page=" & totalPage & pageItem & """" & pageProp & " class='end'>끝</a>" & vbCrLf
		End If

		Response.Write "</div>"
	End Sub

	Public Sub CPageSetFront (byVal pb, ByVal lb, byVal ignore)
		Dim intTemp, intLoop, prev10, pageItem, ignores
		totalPage = util.Ceil(cfg.TotalCount,  pb)
		If ignore <> "" Then
			cfg.IgnoreParams_ = ignore
		End If
		ignores = "|cpage|" & Replace(LCase(cfg.IgnoreParams_),",","|") & "|"
		
		For Each item In Request.Form
			If InStr(ignores,"|" & LCase(item) & "|") < 1 Then pageitem = pageItem & "&" & item & "=" & Trim(Request.Form(item))
		Next

		For Each item In Request.QueryString
			If InStr(ignores,"|" & LCase(item) & "|") < 1 Then pageitem = pageItem & "&" & item & "=" & Trim(Request.QueryString(item))
		Next

		If Trim(cpage) = "" Or isEmpty(cpage) Or isNull(cpage) Then cpage = 1
		If Not isNumeric(cpage) Then cpage = 1
		intTemp = Int((cpage - 1) / lb) * lb + 1
		prev10 = intTemp - lb

		Response.Write "<div class='paging'>" & vbCrLf

		If cpage > lb Then
			Response.Write "		<a href=""" & thisUrl & "?cpage=1" & pageItem & """" & pageProp & " class='first'>맨 처음</a>" & vbCrLf
		End If

		If prev10 >= 1 Then
			Response.Write "		<a href=""" & thisUrl & "?cpage=" & prev10 & pageItem & """" & pageProp & " class='prev'>이전</a>" & vbCrLf
		Else
			'Response.Write "		<a href=""javascript:void(0);"" class='arr prev'>이전페이지</a>" & vbCrLf
		End If
		intLoop = 1

		Response.Write "<span class='number'>" & vbCrLf

		Do Until Int(intLoop) > lb Or Int(intTemp) > Int(totalPage)
			If intTemp = Int(cpage) Then
				Response.Write "	 <strong>" & intTemp & "</strong>" & vbCrLf
			Else
				Response.Write "	 <a href=""" & thisUrl & "?cpage=" & intTemp & pageItem & """" & pageProp & ">" & intTemp & "</a>" & vbCrLf
			End If
			intTemp = intTemp + 1
			intLoop = intLoop + 1
		Loop

		Response.Write "</span>" & vbCrLf

		If Int(intTemp) <= Int(totalPage) Then
			Response.Write "	 <a href=""" & thisUrl & "?cpage=" & intTemp & pageItem & """" & pageProp & " class='next'>다음</a>" & vbCrLf
		Else
			'Response.Write "	 <a href=""javascript:void(0);"" class='arr next'>다음페이지</a>" & vbCrLf
		End If

		If Int(cpage + lb) < Int(totalPage) Then
			Response.Write "		<a href=""" & thisUrl & "?cpage=" & totalPage & pageItem & """" & pageProp & " class='end'>끝</a>" & vbCrLf
		End If

		Response.Write "</div>"
	End Sub

End Class
%>