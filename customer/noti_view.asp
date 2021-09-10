<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

Set db = New DBMANAGER
WIth db

flag = 1

If idx <> "" Then
	
	'//조회수 증가
	SQL = " UPDATE tblNotice Set readCount = readCount + 1 WHERE  (idx = " & idx & ") "
	.ExecuteSql SQL, "text"
	
	'//조회
	.AddParam "idx", "bigint", "in", , idx
	.WHERE (" AND (idx = #idx#)")
	Call .GetRS(.GetQuery("notice", "selecttblNoticeList"), "text")

	If searchKey <> "" Then 
		If searchType <> "" Then 
			viewWhereStr = " AND (" & searchType & " like '%" & searchKey & "%')"
		Else
			viewWhereStr = " AND ( (noticeTitle like '%" & searchKey & "%') OR (noticeContent like '%" & searchKey & "%') ) "
		End If 
	End If 
	
	'이전글
	prevSql = " SELECT  TOP (1) idx AS prevIdx, noticeTitle AS prevnoticeTitle "
	prevSql = prevSql & " From tblNotice "
	prevSql = prevSql & " WHERE  (idx = (SELECT  MAX(idx) FROM tblNotice WHERE (idx < " & idx & ") AND (flag = " & flag & ") AND (useYN = 'Y') " & viewWhereStr & " )) "

	Call .GetRS(prevSql, "text")

	'다음글
	nextSql = " SELECT  TOP (1) idx AS nextIdx, noticeTitle AS nextnoticeTitle "
	nextSql = nextSql & " From tblNotice "
	nextSql = nextSql & " WHERE  (idx = (SELECT  MIN(idx) FROM tblNotice WHERE (idx > " & idx & ") AND (flag = " & flag & ") AND (useYN = 'Y') " & viewWhereStr & " )) "

	Call .GetRS(nextSql, "text")

Else

	Call util.MsgUrl ("잘못된 접근 입니다.","noti_list.asp","")


End If
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

			<div class="boardWrap">
				<div class="viewWrap">
					<div class="boardTop">
						<strong class="title"><%=util.htmlAllow(rs_noticeTitle) %></strong>
						<span class="infor"><em class="date"><%=util.DateFormat(rs_regDate,"YYYY.MM.DD")%></em></span>
					</div>
					<div class="boardCont">
						<div class="contTxt"><%=util.htmlAllow(rs_noticeContent)%></div>
					</div>
				</div>
				<div class="btnArea">
					<a href="noti_list.asp?flag=<%=flag%>&page=<%=page%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>&searchStartDate=<%=searchStartDate%>&searchEndDate=<%=searchEndDate%>" class="btn">목록 </a>
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