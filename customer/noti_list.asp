<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

'//기본검색기준
searchType = "noticeTitle"

Set db = New DBMANAGER
WIth db

'//고정값
flag = 1
.WHERE (" AND (flag = " & flag & ") AND (useYN = 'Y') AND (topYN = 'N') ")

If searchKey <> "" Then 
	.AddParam "sKey", "varchar", "in", 50, searchKey
	
	If searchType <> "" Then 
		.WHERE (" AND (" & searchType & " like '%' + #sKey# + '%')")
	Else
		.WHERE (" AND ( (noticeTitle like '%' + #sKey# + '%') OR (noticeContent like '%' + #sKey# + '%') ) ")
	End If 
End If 

If searchStartDate <> "" Then
	.WHERE (" AND  (CONVERT(CHAR(10), regDate, 23) >= '" & searchStartDate & "') ")
End If 

If searchEndDate <> "" Then
	.WHERE (" AND  (CONVERT(CHAR(10), regDate, 23) <= '" & searchEndDate & "') ")
End If 

sql = .WithPage(.GetQuery("notice", "selecttblNoticeList"),page, FRONT_BOARD_LIST_COUNT)
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
						<li class="active"><a href="#">공지사항</a></li>
						<li><a href="/customer/onetoone.asp">1:1 문의</a></li>
						<li><a href="javascript:goMyPage();">회원정보 수정</a></li>
					</ul>
				</div>
			</nav>
		</div>
		<!-- //#lnb -->

		<div class="contents">
			<h2 class="h2_tit">공지사항</h2><!-- 타이틀 -->

			<div class="listWrap">
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
							<th scope="col">조회수</th>
							<th scope="col">등록일</th>
						</tr>
					</thead>
					<tbody>
						<!-- 공지 -->
						<%
						topSql = "SELECT  idx, noticeTitle, noticeFilePath, noticeHead, readCount, useYN, regDate "
						topSql = topSql & " FROM     tblNotice "
						topSql = topSql & " WHERE  (topYN = 'Y') AND (useYN = 'Y') AND (flag = " & flag & ") "
						topSql = topSql & " ORDER BY idx DESC "
						Set toplst = .GetList(topSql,"text")

						For tn = 0 To toplst("count")
						%>
						<tr>
							<td><em class="icon">공지</em></td>
							<td class="al_le"><a href="noti_view.asp?idx=<%=toplst("idx")(tn)%>&flag=<%=flag%>&page=<%=page%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>&searchStartDate=<%=searchStartDate%>&searchEndDate=<%=searchEndDate%>"><%=util.htmlAllow(toplst("noticeTitle")(tn)) %></a></td>
							<td><%=toplst("readCount")(tn)%></td>
							<td><%=util.DateFormat(toplst("regDate")(tn),"YYYY.MM.DD")%></td>
						</tr>
						<%
						Next
						Set toplst = Nothing 
						%>
						<!-- //공지 -->
						<%
						printListNo = cfg.listNo

						For n = 0 To lst("count")
							'// idx, flag, topYN, noticeTitle, noticeContent, noticeFilePath, noticeHead, readCount, useYN, regAdminId, regName, regDate, regIP
						%>
						<tr>
							<td><%=printListNo%></td>
							<td class="al_le"><a href="noti_view.asp?idx=<%=lst("idx")(n)%>&flag=<%=flag%>&page=<%=page%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>&searchStartDate=<%=searchStartDate%>&searchEndDate=<%=searchEndDate%>"><%=util.htmlAllow(lst("noticeTitle")(n)) %></a></td>
							<td><%=lst("readCount")(n)%></td>
							<td><%=util.DateFormat(lst("regDate")(n),"YYYY.MM.DD")%></td>
						</tr>
						<%
							printListNo = CInt(printListNo) - 1
                        Next 
                        Set lst = Nothing 

						If n = 0 Then 
                        %>
							<tr>
								<td style="text-align: center;" colspan="100">등록(검색) 된 결과가 없습니다.</td>
							</tr>
                        <%
						End If 
                        %>
					</tbody>
				</table>
			</div><!-- 공지사항 리스트 -->

			<% Call fnc.PageSetFront(FRONT_BOARD_LIST_COUNT, FRONT_BOARD_PAGGING_COUNT, "") %>
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