<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet  = "UTF-8"
Response.AddHeader "Pragma", "no-cache"
Response.CacheControl = "no-cache"
Response.Expires = -1442

Dim clientIP
	clientIP = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If clientIP = "" Then 
	clientIP = Request.ServerVariables("REMOTE_HOST")
End If

Set dbPV = Server.CreateObject("ADODB.Connection")
dbPV.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
dbPV.Open
	sql = "INSERT INTO [dbo].[tblPromotionActPv]([page],[server],[host],[ip],[regday],[regdate]) "
	sql = sql & "VALUES('info_act','220.230.115.246','www.purecotton.co.kr','" & clientIP & "', getdate(), getdate())"

	dbPV.Execute sql
dbPV.Close
Set dbPV = Nothing

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

Dim CanvasImg

CanvasImg = request.form("canvas_img")
Dim RandomFileName
RandomFileName	= Replace(Date(),"-","") & RandomText (24,True) &".png"

Set tmpDoc = Server.CreateObject("MSXML2.DomDocument")
Set nodeB64 = tmpDoc.CreateElement("b64")
nodeB64.DataType = "bin.base64" ' stores binary as base64 string
nodeB64.Text = Mid(CanvasImg, InStr(CanvasImg, ",") + 1) ' append data text (all data after the comma)

Set objStream = Server.CreateObject("ADODB.Stream")
objStream.Type = 1
objStream.Open
objStream.Write nodeB64.NodeTypedValue
objStream.SaveToFile Server.MapPath("\upload") &"\evtskin\"& RandomFileName, adSaveCreateOverWrite
Set objStream = Nothing
Set tmpDoc = Nothing
Set nodeB64 = Nothing



Dim name: name = request.form("name")
Dim hphone1: hphone1 = request.form("hphone1")
Dim hphone2: hphone2 = request.form("hphone2")
Dim hphone3: hphone3 = request.form("hphone3")
Dim zipcode: zipcode = request.form("zipcode")
Dim maketing: maketing = request.form("maketing")
Dim hphone: hphone = hphone1 & "-" & hphone2 & "-" & hphone3
Dim OriginImg: OriginImg = request.form("origin_img")

Dim KIND_AGENT
KIND_AGENT = UCase(Request.ServerVariables("HTTP_USER_AGENT")) 
Dim kind
If InStr(KIND_AGENT, "ANDROID") > 0 Then
	kind = "M"
ElseIf InStr(KIND_AGENT, "IPAD") Or InStr(KIND_AGENT, "IPHONE") Then
	kind = "M"
Else
	kind = "W"
End If

Dim rfromurl
rfromurl = ""
rfromurl = request.QueryString("fromurl")
If rfromurl <> "" Then
	Response.Cookies("fromurl") = rfromurl
Else
	If Request.Cookies("fromurl") <> "" Then
		rfromurl = Request.Cookies("fromurl")
	End if
End If

Dim pvClientIP
pvClientIP = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If pvClientIP = "" Then 
pvClientIP = Request.ServerVariables("REMOTE_HOST")
End If 

Set dbPV = Server.CreateObject("ADODB.Connection")
dbPV.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
dbPV.Open

sql = "INSERT INTO [dbo].[tblPromotionSkin]([psName], [psHphone], [psMarketing], [psCanvasImg], [psOriginImg], [state], [ipAddr], [fromurl], [kind], [agent] ,[regDate]) "
sql = sql & "VALUES('" & name & "','" & hphone & "','" & maketing & "','"& RandomFileName &"','"& OriginImg &"','Y','" & pvClientIP & "','" & rfromurl & "','" & kind & "','" & Request.ServerVariables("HTTP_USER_AGENT") & "', getdate())"
dbPV.execute(sql)

sql = "SELECT max(idx) insert_id FROM [purecotton2018].[dbo].[tblPromotionSkin]"
set rs = dbPV.execute(sql)

Dim insert_id
insert_id = ""
if not rs.eof then
	do until rs.eof
		insert_id = rs("insert_id")
		redim preserve column_list(column_count)
		column_list(column_count) = rs("insert_id")
		column_count = column_count + 1
		rs.movenext
	loop
end If

dbPV.Close
Set dbPV = Nothing

Session("skin_idx") = insert_id
Response.Cookies("skin_idx") = insert_id

response.write "{""rs"":""OK"",""insert_id"":" & insert_id & ", ""uploadimage"": ""evtskin/"& RandomFileName &"""}"
%>