<%@ Language=VBScript %>
<%
Dim fidx : fidx = Session("skin_idx")
Dim sns_type : sns_type = request.QueryString("sns_type")

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

sql = "INSERT INTO [dbo].[tblPromotionSkinSns]([psFidx] ,[psSns_type] ,[psSns_value] ,[psSns_etc] ,[ipAddr] ,[fromurl] ,[kind] ,[agent] ,[regDate]) "
sql = sql & "VALUES('" & fidx & "','" & sns_type & "','','','" & pvClientIP & "','" & rfromurl & "','" & kind & "','" & Request.ServerVariables("HTTP_USER_AGENT") & "', getdate())"
dbPV.execute(sql)

sql = "SELECT max(idx) insert_id FROM [dbo].[tblPromotionSkinSns]"
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

Session("sns_fb_idx") = insert_id
response.write "{""rs"":""OK"",""idx"":""" & insert_id & """}"
%> 