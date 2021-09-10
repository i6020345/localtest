<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet  = "UTF-8"
Response.AddHeader "Pragma", "no-cache"
Response.CacheControl = "no-cache"
Response.Expires = -1442

Dim fidx : fidx = request.QueryString("fidx")
Dim sns_type : sns_type = request.QueryString("sns_type")
Dim sns_etc : sns_etc = request.QueryString("sns_etc")


Set dbPV = Server.CreateObject("ADODB.Connection")
dbPV.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
dbPV.Open

sql = "UPDATE [dbo].[tblPromotionSkinSns] SET [psSns_etc] = '" & sns_etc & "' WHERE psFidx = '" & fidx & "' AND psSns_type = '" & sns_type & "'"
dbPV.execute(sql)

dbPV.Close
Set dbPV = Nothing

response.write "{""rs"":""OK"",""idx"":""" & idx & """}"
%> 