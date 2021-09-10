<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

Set db = New DBMANAGER
WIth db

If idx <> "" Then

	'//조회
	.AddParam "idx", "bigint", "in", , idx
	.WHERE (" AND (idx = #idx#)")
	Call .GetRS(.GetQuery("event", "selecttblEventList"), "text")

	if cmd_idx <> "" then
		csql = " SELECT  idx, commentText "
		csql = csql & " FROM     tblEventComment "
		csql = csql & " WHERE  (idx = " & cmd_idx & ") "
		Call .GetRS(csql, "text")

		mode = "update"
	else
		mode = "insert"
	end if 

Else

	Call util.MsgUrl ("잘못된 접근입니다, 목록으로 이동합니다.","/event/event_list.asp","")

End If
%>
<html lang="ko">
<head>
<!-- #include virtual = "/include/inc_header.asp" -->
<script type="text/javascript" src="/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/js/additional-methods.min.js"></script>
<script type="text/javascript" src="/js/localization/messages_ko.min.js"></script>

<script type="text/javascript">
	$(function () {
		$("inputForm").validate({
			//validation이 끝난 이후의 submit 직전 추가 작업할 부분
			submitHandler: function () {
				/*
				Codes
				*/
			}
		});
	})

	function firstLogin() {
		var r = confirm("로그인 후 작성가능합니다.\n로그인 하시겠습니까?");
		if (r == true) {
			location.href = "/etc/login.asp?returnUrl=/event/event_view.asp?idx=<%=idx%>&page=<%=page%>&cpage=<%=cpage%>";
		} 
	}

	function myTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}

	function setTrim(obj) {
		//alert(obj.value);
		obj.value = myTrim(obj.value);
	}

	function cDelete(val) {
		if (confirm("삭제 시 추후 복구가 불가능합니다.\n삭제 하시겠습니까?")) {
			var f = document.inputForm;
			f.cmd_idx.value = val;
			f.mode.value = "delete";
			f.submit();
		} else {
			return;
		}
	}
</script>
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
						<li class="active"><a href="#">이벤트</a></li>
					</ul>
				</div>
			</nav>
		</div>
		<!-- //#lnb -->

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
				<div class="viewWrap">
					<div class="boardTop">
						<strong class="title"><%=util.htmlAllow(rs_eventTitle) %></strong>
						<span class="infor">
							<em class="date"><%=rs_eventStartDate%> ~ <%=rs_eventEndDate%></em>
						</span>
					</div>
					<div class="boardCont">
						<div class="contTxt">
							<p><%=util.htmlAllow(rs_eventContent)%></p>
						</div>
					</div>
				</div>
				<div class="btnArea">
					<a href="event_list.asp?page=<%=page%>" class="btn">목록</a>
				</div>
<%
'//종료된 이벤트는 댓글을 노출하지 않음
if cstr(rs_eventEndDate) > cstr(date()) then 
%>				

				<h3 class="titComment">댓글 등록</h3>
				<div class="viewComment">
<form name="inputForm" method="post" action="/event/event_view_data.asp" target="hiddenFrame">
<input type="hidden" name="mode" value="<%=mode%>" />
<input type="hidden" name="event_idx" value="<%=idx%>" />
<input type="hidden" name="cmd_idx" value="<%=cmd_idx%>" />
					<div class="commentArea">
						<span class="textarea">
							<textarea name="commentText" id="commentText" cols="30" rows="10" placeholder="내용을 입력해주세요. (필수)" title="내용" required="required" onblur="setTrim(this);"><%=rs_commentText%></textarea>
							<%
							If USER_LOGIN_ID = "" Then
							%>
							<input type="button" value="등록" onclick="firstLogin();">
							<%
							Else
							%>
							<input type="submit" value="<% if cmd_idx <> "" then %>수정<% else %>등록<% end if %>" />
							<%
							End If
							%>
							
						</span>
					</div>
</form>					
					<ul>
						<%
						'//고정값
						if cpage = "" Then
							cpage = 1
						end if 
						
						.WHERE (" AND (event_idx = " & idx & ") ")

						sql = .WithPage(.GetQuery("eventcomment", "selecttblEventCommentList"),cpage, FRONT_BOARD_LIST_COUNT)
						Set lst = .GetList(sql,"text")

						printListNo = cfg.listNo

						For n = 0 To lst("count")
							'//idx, event_idx, commentText, UserID, UserName, regDate, regIP
						%>
						<li>
							<div class="txt"><%=lst("commentText")(n)%></div>
							<div class="btnArea">
								<% if lst("UserID")(n) = USER_LOGIN_ID then %>
								<a href="/event/event_view.asp?idx=<%=idx%>&page=<%=page%>&cmd_idx=<%=lst("idx")(n)%>" class="btnS">수정</a>
								<a href="javascript:cDelete(<%=lst("idx")(n)%>);" class="btnS">삭제</a>
								<% end if %>
							</div>
							<div class="infor">
								<em class="name"><%=util.LeftPad(lst("UserID")(n), 4, "*")%></em>
								<i></i>
								<em class="date"><%=util.DateFormat(lst("regDate")(n),"YYYY.MM.DD")%></em>
							</div>
						</li>
						<%
							printListNo = CInt(printListNo) - 1
                        Next 
                        Set lst = Nothing 

						If n = 0 Then 
                        %>
						<li>
							<div class="txt">등록된 댓글이 없습니다.</div>
						</li>
                        <%
						End If 
                        %>
					</ul>
				</div>
			</div>

			<% Call fnc.CPageSetFront(FRONT_BOARD_LIST_COUNT, FRONT_BOARD_PAGGING_COUNT, "") %>
<%
end if '// 종료된 이벤트 체크
%>
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
