<%@ Language=VBScript %>
<%

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

Dim feed_bg_name
feed_bg = "https://ssl.inuscomm.co.kr" & request.QueryString("feed_bg")
feed_bg_name = Replace(Date(),"-","") & RandomText (24,True) &".jpg"

Path = Server.MapPath("\upload") &"\evtskin\"
set objXmlHttp = createobject("MSXML2.ServerXMLHTTP.6.0")
objXmlHttp.open "get",feed_bg,false
objXmlHttp.send()
imgData = objXmlHttp.responseBody
set objXmlHttp = nothing

set objStream = CreateObject("ADODB.Stream")
objStream.Open()
objStream.Type = 1
objStream.Write imgData
objStream.SaveToFile Path & feed_bg_name, 2
set objStream = Nothing
Session("sns_bg_img") = feed_bg_name
Response.Cookies("sns_bg_img") = feed_bg_name



Dim feed_fb_name
feed_fb = "https://ssl.inuscomm.co.kr" & request.QueryString("feed_fb")
feed_fb_name = Replace(Date(),"-","") & RandomText (24,True) &".jpg"

Path = Server.MapPath("\upload") &"\evtskin\"
set objXmlHttp = createobject("MSXML2.ServerXMLHTTP.6.0")
objXmlHttp.open "get",feed_fb,false
objXmlHttp.send()
imgData = objXmlHttp.responseBody
set objXmlHttp = nothing

set objStream = CreateObject("ADODB.Stream")
objStream.Open()
objStream.Type = 1
objStream.Write imgData
objStream.SaveToFile Path & feed_fb_name, 2
set objStream = Nothing



Dim feed_ks_name
feed_ks = "https://ssl.inuscomm.co.kr" & request.QueryString("feed_ks")
feed_ks_name	= Replace(Date(),"-","") & RandomText (24,True) &".jpg"

Path = Server.MapPath("\upload") &"\evtskin\"
set objXmlHttp = createobject("MSXML2.ServerXMLHTTP.6.0")
objXmlHttp.open "get",feed_ks,false
objXmlHttp.send()
imgData = objXmlHttp.responseBody
set objXmlHttp = nothing

set objStream = CreateObject("ADODB.Stream")
objStream.Open()
objStream.Type = 1
objStream.Write imgData
objStream.SaveToFile Path & feed_ks_name, 2
set objStream = Nothing




Dim feed_tw_name
feed_tw = "https://ssl.inuscomm.co.kr" & request.QueryString("feed_tw")
feed_tw_name	= Replace(Date(),"-","") & RandomText (24,True) &".jpg"

Path = Server.MapPath("\upload") &"\evtskin\"
set objXmlHttp = createobject("MSXML2.ServerXMLHTTP.6.0")
objXmlHttp.open "get",feed_tw,false
objXmlHttp.send()
imgData = objXmlHttp.responseBody
set objXmlHttp = nothing

set objStream = CreateObject("ADODB.Stream")
objStream.Open()
objStream.Type = 1
objStream.Write imgData
objStream.SaveToFile Path & feed_tw_name, 2
set objStream = Nothing

Dim skin_idx: skin_idx = request.QueryString("skin_idx")

Set dbPV = Server.CreateObject("ADODB.Connection")
dbPV.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
dbPV.Open

sql = "UPDATE [dbo].[tblPromotionSkin] SET [feed_bg] = '" & feed_bg_name & "', [feed_fb] = '" & feed_fb_name & "', [feed_tw] = '" & feed_tw_name & "', [feed_ks] =  '" & feed_ks_name & "' WHERE [idx] = '" & skin_idx & "'"
dbPV.execute(sql)

sql = "SELECT top 1 * FROM [dbo].[tblPromotionSkin] WHERE [idx] = '" & skin_idx & "' order by idx desc "
set rs = dbPV.execute(sql)

Dim idx
idx = ""
Dim feed_fb
feed_fb = ""
Dim feed_tw
feed_tw = ""
Dim feed_ks
feed_ks = ""

if not rs.eof then
	do until rs.eof
		idx = rs("idx")
		feed_fb = rs("feed_fb")
		feed_tw = rs("feed_tw")
		feed_ks = rs("feed_ks")
		rs.movenext
	loop
end If

dbPV.Close
Set dbPV = Nothing

Session("sns_idx") = idx
Response.Cookies("sns_idx") = idx

response.write "{""rs"":""OK"",""idx"":" & idx & ",""feed_fb"":""" & feed_fb & """,""feed_tw"":""" & feed_tw & """,""feed_ks"":""" & feed_ks & """}"
%> 