<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<html lang="ko">
<head>
</head>
<body>
<%
Set db = New DBMANAGER
WIth db

cSql = " SELECT  COUNT(0) AS dateCount "
cSql = cSql & " FROM     tblQRClick "
cSql = cSql & " WHERE  (CLICK_DATE = CONVERT(CHAR(10), CURRENT_TIMESTAMP, 23)) "
Call .GetRS(cSql, "text")

if clng(rs_dateCount) = 0 then

    iSql = " INSERT INTO [dbo].[tblQRClick] "
    iSql = iSql & " ([CLICK_DATE],[health],[slim],[super],[zero],[health_eng],[slim_eng],[super_eng],[zero_eng]) "
    iSql = iSql & " VALUES "
    iSql = iSql& " (CONVERT(CHAR(10), CURRENT_TIMESTAMP, 23),0,0,0,0,0,0,0,0) "
    .ExecuteSql iSql, "text"

end if 

'//[health],[slim],[super],[zero],[health_eng],[slim_eng],[super_eng],[zero_eng]
uSql = " UPDATE [dbo].[tblQRClick] SET [zero_eng] = [zero_eng] + 1 WHERE CLICK_DATE = CONVERT(CHAR(10), CURRENT_TIMESTAMP, 23) "
.ExecuteSql uSql, "text"

End With
Set db = Nothing

response.redirect ("http://m.purecotton.co.kr/promise/purecotton_zero_eng.asp")
%>
</body>
</html>