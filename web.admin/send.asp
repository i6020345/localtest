<!-- #include virtual = "/include/core/class.db.asp" -->
<%
w_date = dateadd ("d", -335, n_date)
str_mail_date = DateAdd("m", 1, Now())
write_date = Year(str_mail_date) & "년 " & Month(str_mail_date) & "월 " & Day(str_mail_date) & "일"

from_name		= "베어크리크GC"
from_mail			= "베어크리크GC <no-reply@bearcreek.co.kr>" 
email				= "syjeong@bearcreek.co.kr"
'					email				= "redriver@naver.com"
subject			= "[베어크리크GC] 휴면계정 전환 안내"

mailContent = ""
mailContent	= mailContent & "<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.01 Transitional//EN http://www.w3.org/TR/html4/loose.dtd>"
mailContent	= mailContent & "<html> <head>  <title>휴먼계정전환안내</title></head>   <body>"


mailContent	= mailContent & "<STYLE>BODY { 	MARGIN: 0px}"
mailContent	= mailContent & "A:link {	TEXT-DECORATION: none}"
mailContent	= mailContent & "A:active {	TEXT-DECORATION: none}"
mailContent	= mailContent & "A:visited {	TEXT-DECORATION: none}"
mailContent	= mailContent & "</STYLE>"
mailContent	= mailContent & "<A href='https://www.bearcreek.co.kr/member/login.asp' border='0'>"
mailContent	= mailContent & "<TABLE height=850 width=750 background=http://bcgcweb01.bearcreek.co.kr/Mailing/bear_mail.jpg>"
mailContent	= mailContent & "<TBODY>"
mailContent	= mailContent & "<TR>"
mailContent	= mailContent & "<TD><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><FONT color=#186cac>"
mailContent	= mailContent & "<P style='FONT-SIZE: 14px; TEXT-ALIGN: center; text-decoration:none; '><B>휴면계정으로 전환을 원치 않으시면 홈페이지 또는 모바일 어플리케이션에서 <br /><FONT color=#f72211>"& write_date &"까지 로그인</FONT>하여 주시기 바랍니다. </B></P>"
mailContent	= mailContent & "<P style='FONT-SIZE: 14px; TEXT-ALIGN: center'>&nbsp;</P>"
'					mailContent	= mailContent & "<P style='FONT-SIZE: 14px; TEXT-ALIGN: center'><STRONG><SPAN style='FONT-SIZE: 16pt'><SPAN style='FONT-SIZE: 14pt; text-decoration:none; '>지금 로그인 후 개인정보 수정하시면 마일리지 3천점 적립해드립니다. </SPAN></SPAN></STRONG></P>"
'					mailContent	= mailContent & "<P style='FONT-SIZE: 14px; TEXT-ALIGN: center'><STRONG><SPAN style='FONT-SIZE: 16pt'><SPAN style='FONT-SIZE: 14pt; text-decoration:none; '><SPAN style='FONT-SIZE: 12pt; text-decoration:none; '>(마일리지 적립은 유료회원만 가능하며, 2주 단위로 일괄 적립됩니다.) </SPAN></SPAN></SPAN></STRONG><SPAN style='FONT-SIZE: 16pt'><SPAN style='FONT-SIZE: 14pt'><SPAN style='FONT-SIZE: 12pt'>&nbsp;</SPAN></SPAN></SPAN></P>"
mailContent	= mailContent & "<P></P></FONT></TD></TR></TBODY></TABLE></A></body></html>"

Call util.MailSender(from_mail,email,subject, mailContent)
%>

