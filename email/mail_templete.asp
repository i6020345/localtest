<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
Set db = New DBMANAGER
WIth db

If idx <> "" Then

	'//조회
	.AddParam "idx", "bigint", "in", , idx
	.WHERE (" AND (idx = #idx#)")
	Call .GetRS(.GetQuery("voc", "selecttblVOCList"), "text")

Else

	response.end

End If
%>
<html>
<head>
<title>순수한면</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>

<table cellpadding="0" cellspacing="0" border="0" width="650" style="overflow:hidden; border-collapse:collapse;margin:0 auto;max-width:650px;">
	<tbody>
		<tr style="background:#103A71">
			<td colspan="3" border="0" cellpadding="0" cellspacing="0"><img src="http://www.purecotton.co.kr/images/email/logo.jpg" alt="순수한면"></td>
		</tr>
		<tr>
			<td style="padding:80px 40px;font-family:dotum;">
				<table cellpadding="0" cellspacing="0" border="0" width="100%" style="overflow:hidden; border-collapse:collapse;">
					<tbody>
						<tr>
							<td style="padding-bottom:30px;vertical-align:top;"><img src="http://www.purecotton.co.kr/images/email/tit_onetoone.png" alt="1:1문의"></td>
						</tr>
						<tr>
							<td style="padding-bottom:70px;vertical-align:top;">
								<strong style="display:inline-block;color:#103A71;font-size:16px;text-decoration:underline;vertical-align:top;"><%=rs_vocName%></strong>
								<img src="http://www.purecotton.co.kr/images/email/txt_01.png" alt="님 안녕하세요. 순수한면 입니다."><br />
								<p style="margin:0;padding:10px 0 0;">
									<img src="http://www.purecotton.co.kr/images/email/txt_02.png" alt="고객님의 1:1문의 글에 대한 답변 드립니다.">
								</p>
							</td>
						</tr>

						<tr>
							<td style="padding-bottom:20px;border-bottom:2px solid #999;vertical-align:top;"><img src="http://www.purecotton.co.kr/images/email/h2_tit_question.png" alt="문의내용"></td>
						</tr>
						<tr>
							<td style="padding:30px 0;color:#222;font-size:16px;font-weight:bold;vertical-align:top;"><%=rs_vocTitle%></td>
						</tr>
						<tr>
							<td style="padding:40px 0 50px;border-top:1px solid #D6D6D6;color:#777;font-size:15px;line-height:28px;letter-spacing:-1px;">
								<%=Replace(rs_vocContent, vbCrLf, "<br/>")%>
							</td>
						</tr>

						<tr>
							<td style="padding-bottom:20px;vertical-align:top;"><img src="http://www.purecotton.co.kr/images/email/h2_tit_addfile.png" alt="첨부파일"></td>
						</tr>
						<% If rs_vocFilePath01 <> "" Then %>
						<tr>
							<td style="padding-bottom:40px;border-bottom:1px solid #D6D6D6;">
								<div style="margin:0;padding:0;background:#E5E5E5;">
									<img src="http://www.purecotton.co.kr/upload/voc/<%=rs_vocFilePath01%>" alt="첨부파일이미지" style="width:100%;height:auto">
								</div>
							</td>
						</tr>
						<% End If %>
						<% If rs_vocFilePath02 <> "" Then %>
						<tr>
							<td style="padding-bottom:40px;border-bottom:1px solid #D6D6D6;">
								<div style="margin:0;padding:0;background:#E5E5E5;">
									<img src="http://www.purecotton.co.kr/upload/voc/<%=rs_vocFilePath02%>" alt="첨부파일이미지" style="width:100%;height:auto">
								</div>
							</td>
						</tr>
						<% End If %>
						<% If rs_vocFilePath03 <> "" Then %>
						<tr>
							<td style="padding-bottom:40px;border-bottom:1px solid #D6D6D6;">
								<div style="margin:0;padding:0;background:#E5E5E5;">
									<img src="http://www.purecotton.co.kr/upload/voc/<%=rs_vocFilePath03%>" alt="첨부파일이미지" style="width:100%;height:auto">
								</div>
							</td>
						</tr>
						<% End If %>
						
						<tr>
							<td style="padding:60px 0 20px;border-bottom:2px solid #999;vertical-align:top;"><img src="http://www.purecotton.co.kr/images/email/h2_tit_answer.png" alt="답변내용"></td>
						</tr>
						<tr>
							<td style="padding:40px 30px;background:#F9F9F9;color:#777;font-size:15px;line-height:28px;letter-spacing:-1px;">
								<%=Replace(rs_vocAdminMemo, vbCrLf, "<br/>")%>
							</td>
						</tr>

						<tr>
							<td style="padding:50px 0 0;text-align:center;vertical-align:top;">
								<a href="http://www.purecotton.co.kr/" target="_blank"><img src="http://www.purecotton.co.kr/images/email/btn_main.png" alt="순수한면 바로가기"></a>
							</td>
						</tr>

					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td style="padding:40px;border-top:1px solid #D6D6D6;color:#777;font-size:14px;letter-spacing:-1px;">
				<p style="padding:0;margin:0;margin-bottom:5px;">메일은 발신 전용 메일입니다.</p> <br />서울특별시 중구 삼일대로 6길 5 신조양빌딩 대표전화 (02) 2270-9200<br />COPYRIGHT © KLEANNARA ALL RIGHTS RESERVED 
			</td>
		</tr>
	</tbody>
</table>
<!--// content -->
</body>
</html>
<%
End With
Set db = Nothing
%>