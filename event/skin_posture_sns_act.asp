<%@ Language=VBScript %>
<%
Dim idx : idx = request.QueryString("idx")
Dim CHAT_TYPE : CHAT_TYPE = request.QueryString("CHAT_TYPE")


Set dbPV = Server.CreateObject("ADODB.Connection")
dbPV.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
dbPV.Open

sql = "UPDATE [dbo].[tblPromotionSkinSns] SET [psSns_etc] = '" & CHAT_TYPE & "' WHERE idx = '" & idx & "'"
dbPV.execute(sql)

dbPV.Close
Set dbPV = Nothing

response.write "{""rs"":""OK"",""idx"":""" & idx & """}"
%> 