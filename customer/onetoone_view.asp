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
	Call .GetRS(.GetQuery("voc", "selecttblVOCList"), "text")

	mode = "update"

	if rs_vocStatus = "" Then
		vocStatusStr = "확인전"
	else
		vocStatusStr = rs_vocStatus
	end if

	if USER_LOGIN_ID <> rs_vocID then
		Call util.MsgUrl ("본인의 작성 게시물 접근이 아닙니다.","/customer/onetoone.asp","")
	end if 

Else

	mode = "insert"

End If
%>
<html lang="ko">
<head>
<!-- #include virtual = "/include/inc_header.asp" -->
<script type="text/javascript">
	function cDelete() {
		if (confirm("삭제 시 추후 복구가 불가능합니다.\n삭제 하시겠습니까?")) {
			var f = document.inputForm;
			f.target = "hiddenFrame";
			f.action = "onetoone_write_data.asp";
			f.mode.value = "delete";
			f.submit();
		} else {
			return;
		}
	}

	$('.image-popup-vertical-fit').magnificPopup({
		type: 'image',
		closeOnContentClick: true,
		mainClass: 'mfp-img-mobile',
		image: {
			verticalFit: true
		}
	});
</script>
</head>
<body>
<div id="wrap" class="sub">
	<!-- #include virtual = "/include/page_header.asp" -->

	<div class="contents">
		<h2 class="h2_tit">1:1 문의</h2><!-- 타이틀 -->
<form name="inputForm" method="post" action="onetoone_write.asp" enctype="multipart/form-data">
<input type="hidden" name="idx" value="<%=idx%>" />
<input type="hidden" name="mode" value="<%=mode%>" />
		<div class="onetooneWrap">
			<div class="viewWrap">
				<div class="boardTop">
					<strong class="title"><%=rs_vocTitle%></strong>
					<span class="infor">
						<em class="state <% if vocStatusStr = "처리완료" then %> complete<% end if %>"><%=vocStatusStr%></em>
						<em class="date"><%=util.DateFormat(rs_regDate,"YYYY.MM.DD")%></em>
					</span>
				</div>
				<div class="boardCont">
					<div class="contTxt">
						<p><%=Replace(rs_vocContent, vbCrLf, "<br/>")%></p>
					</div>
					<div class="addFile">
						<strong class="addTit">첨부파일</strong>
						<div class="fileArea">
							<% If rs_vocFilePath01 <> "" Then %>
							<a class="test-popup-link" href="/upload/voc/<%=rs_vocFilePath01%>"><%=rs_vocFilePath01%></a><br/><br/>
							<% end if %>
							<% If rs_vocFilePath02 <> "" Then %>
							<a class="test-popup-link" href="/upload/voc/<%=rs_vocFilePath02%>"><%=rs_vocFilePath02%></a><br/><br/>
							<% end if %>
							<% If rs_vocFilePath03 <> "" Then %>
							<a class="test-popup-link" href="/upload/voc/<%=rs_vocFilePath03%>"><%=rs_vocFilePath03%></a>
							<% end if %>
						</div>
					</div>
				</div>
				<% if rs_vocAdminMemo <> "" then %>
				<div class="boardReply">
					<strong class="replyTit">답변내용</strong>
					<div class="contTxt">
						<p><%=Replace(rs_vocAdminMemo, vbCrLf, "<br/>")%></p>
					</div>
				</div>
				<% end if %>
			</div>
			<div class="btnArea ta_rt">
				<a href="onetoone_list.asp?page=<%=page%>" class="btn left">목록</a>
				<% if vocStatusStr <> "처리완료" then %>
				<a href="onetoone_write.asp?idx=<%=idx%>" class="btn grey">수정</a>
				<% end if %>
				<a href="javascript:cDelete();" class="btn">삭제</a>
			</div>
		</div>
</form>
	</div><!-- //.contents -->

	<!-- #include virtual = "/include/inc_footer.asp" -->
<script>
$('.test-popup-link').magnificPopup({
  type: 'image'
});
</script>
</div>
</body>
</html>
<%
End With
Set db = Nothing
%>