<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

If USER_LOGIN_ID = "" Then
	Call util.MsgUrl ("로그인 후 이용 가능한 서비스입니다.","/etc/login.asp?returnUrl=/customer/onetoone_list.asp","")
End If 

Set db = New DBMANAGER
WIth db

.WHERE (" AND (vocType = 'VOC') AND (vocID = '" & USER_LOGIN_ID & "')")

sql = .WithPage(.GetQuery("voc", "selecttblVOCList"),page, FRONT_BOARD_LIST_COUNT)
Set lst = .GetList(sql,"text")
%>
<html lang="ko">
<head>
<!-- #include virtual = "/include/inc_header.asp" -->
</head>
<body>
<div id="wrap" class="sub">
	<!-- #include virtual = "/include/page_header.asp" -->

	<div id="container">
		<!-- #lnb -->
		<div id="lnb">
			<nav>
				<div class="wrap">
					<strong class="tit">고객센터</strong>
					<ul>
						<li><a href="/customer/noti_list.asp">공지사항</a></li>
						<li class="active"><a href="#">1:1 문의</a></li>
						<li><a href="javascript:goMyPage();">회원정보 수정</a></li>
					</ul>
				</div>
			</nav>
		</div>
		<!-- //#lnb -->

		<div class="contents">
			<h2 class="h2_tit">1:1 문의</h2><!-- 타이틀 -->

			<ul class="dotList">
				<li>작성해 주신 1:1 문의 답변은 개인 이메일이나 <span class="point">고객센터 > 1:1 문의</span>를 통해 확인하실 수 있습니다.</li>
				<li>고객 문의가 많아 답변이 지연될 수 있는 점은 양해 바라며, 빠른 처리를 위해 노력하겠습니다.</li>
			</ul>

			<div class="onetooneWrap list">
				<h3>1:1 문의 확인하기</h3>

				<table class="tb_list">
					<caption>공지사항 리스트</caption>
					<colgroup>
						<col width="100px">
						<col width="*">
						<col width="100px">
						<col width="140px">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">등록일</th>
							<th scope="col">진행상태 </th>
						</tr>
					</thead>
					<tbody>
						<%
						printListNo = cfg.listNo

						For n = 0 To lst("count")
							'//idx, vocName, vocID, vocPhone, vocCategoryCode, vocTitle, vocContent, vocFilePath, vocStatus, vocAdminMemo, regAdminId, regName, regDate, regIP, vocSite
							if lst("vocStatus")(n) = "" Then
								vocStatusStr = "확인전"
							else
								vocStatusStr = lst("vocStatus")(n)
							end if 
						%>
						<tr>
							<td><%=printListNo%></td>
							<td class="al_le"><a href="onetoone_view.asp?idx=<%=lst("idx")(n)%>&page=<%=page%>"><%=util.htmlAllow(lst("vocTitle")(n)) %></a></td>
							<td><%=util.DateFormat(lst("regDate")(n),"YYYY.MM.DD")%></td>
							<td><span><%=vocStatusStr%></span></td>
						</tr>
						<%
							printListNo = CInt(printListNo) - 1
                        Next 
                        Set lst = Nothing 

						If n = 0 Then 
                        %>
						<tr>
							<td colspan="4" class="no">등록된 1:1 문의가 없습니다.</td>
						</tr>
                        <%
						End If 
                        %>
					</tbody>
				</table>
				
				<% Call fnc.PageSetFront(FRONT_BOARD_LIST_COUNT, FRONT_BOARD_PAGGING_COUNT, "") %>
				<div class="btnArea">
					<a href="/customer/onetoone_write.asp" class="btn grey">문의하기</a>
				</div>
			</div>

		</div><!-- //.contents -->
	</div>

	<!-- #include virtual = "/include/inc_footer.asp" -->
</div>
</body>
</html>
<%
End With
Set db = Nothing
%>