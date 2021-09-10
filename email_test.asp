<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
Set db = New DBMANAGER
WIth db

'회원가입 메일발송
takeuser = "jklee@wylie.co.kr"

userName = "테스터"

idx = 13

'메일전송 - S
emailTitle =  "[순수한면] 고객님의 문의사항에 답변드립니다."
EmailHtml = "http://" & LCase(Request.ServerVariables("HTTP_HOST")) & "/email/mail_templete.asp?idx=" & idx
EmailContentResult = util.GetMailBody(EmailHtml)
'EmailContentResult = Replace(EmailContentResult,"[[name]]",userName)

Call util.MailSender(CONST_PUBLIC_EMAIL,takeuser,emailTitle,EmailContentResult)
'메일전송 - E

End With
Set db = Nothing
%>