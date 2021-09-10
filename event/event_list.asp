<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

'//기본검색기준
searchType = "eventTitle"

Set db = New DBMANAGER
WIth db

'//고정값
flag = 1
.WHERE (" AND (flag = " & flag & ") ")

sql = .WithPage(.GetQuery("event", "selecttblEventList"),page, FRONT_BOARD_LIST_COUNT)
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
					<strong class="tit">이벤트</strong>
					<ul>
						<li class="active"><a href="/event/event_list.asp">이벤트</a></li>
					</ul>
				</div>
			</nav>
		</div>
		<!-- //#lnb -->

		<div class="contents">
			<h2 class="h2_tit">이벤트</h2><!-- 타이틀 -->

			<div class="eventWrap">
				<div class="eventList">
					<% if clng(lst("count")) < 0 then %>
					<div class="nonEvent">진행중인 이벤트가 없습니다.</div>
					<%else%>
					<ul>
						<%
						printListNo = cfg.listNo

						For n = 0 To lst("count")
							'//idx, flag, eventTitle, eventContent, eventContentMobile, eventStartDate, eventEndDate
							'//, eventThumb, eventThumbMobile, eventArea, readCount, useYN, regAdminId, regName, regDate, regIP
							hrefStr = ""
							endClassStr = ""
							if cstr(lst("eventEndDate")(n)) < cstr(date()) then 
								endClassStr = "<span class='eventState end'>종료된 이벤트</span>"
								hrefStr = "javascript:alert('해당 이벤트는 종료되었습니다.');"
							else
								endClassStr = "<span class='eventState'>진행중인 이벤트</span>"
								hrefStr = "event_view.asp?idx=" & lst("idx")(n) & "&page=" & page
							end if 
						%>
						<li>
							<div class="contArea">
								<%=endClassStr%>
								<strong class="tit"><a href="<%=hrefStr%>"><%=util.htmlAllow(lst("eventTitle")(n)) %></a></strong><!-- 제목 -->
								<div class="inforTxt">
									<span>기간 : <%=lst("eventStartDate")(n)%> ~ <%=lst("eventEndDate")(n)%></span>
									<span>당첨자 발표 : <%=lst("eventWinnerDate")(n)%></span>
								</div>
							</div>
							<% If lst("eventThumb")(n) <> "" Then %>
							<div class="imgArea">
								<a href="<%=hrefStr%>"><img src="/upload/event/<%=lst("eventThumb")(n)%>" alt="<%=util.htmlAllow(lst("eventTitle")(n))%>"></a>
							</div>
							<% End If %>
						</li>
						<%
							printListNo = CInt(printListNo) - 1
                        Next 
                        Set lst = Nothing 
                        %>
					</ul>
					<%end if%>
				</div>
			</div>

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