<%@ Language=VBScript %>
<%

Dim page : page = request.QueryString("page")
Dim row : row = 2


Set dbPV = Server.CreateObject("ADODB.Connection")
dbPV.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
dbPV.Open

sql = "SELECT * FROM [dbo].[tblPromotionSkin] WHERE [state] = 'Y' ORDER BY [idx] DESC OFFSET " & (page-1)*row & " ROWS FETCH NEXT " & row & " ROWS ONLY"
set rs = dbPV.execute(sql)

response.write "{""rs"":""OK"",""list"": ["
if not rs.eof then
	do until rs.eof
		response.write "{""feed_fb"":""/upload/evtskin/" & rs("feed_fb") & """},"
		rs.movenext
	loop
end If

sql = "SELECT count(1) as cnt FROM [dbo].[tblPromotionSkin] WHERE [state] = 'Y'"
set rs = dbPV.execute(sql)

Dim totalcnt
if not rs.eof then
	do until rs.eof
		totalcnt = rs("cnt")
		rs.movenext
	loop
end If

dbPV.Close
Set dbPV = Nothing

Dim maxpage : maxpage = Int(totalcnt/row+0.95)
Dim startpage : startpage = (Int(page/5+0.9) - 1) * 5 +1
Dim endpage : endpage = maxpage
If endpage > startpage+5-1 Then endpage = startpage+5-1 End If

response.write "{}],""page"":""" & page & """,""totalcnt"":""" & totalcnt & """,""startpage"":""" & startpage & """,""endpage"":""" & endpage & """,""maxpage"":""" & maxpage & """,""limit"":""" & row & """}"
%> 