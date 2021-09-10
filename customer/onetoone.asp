<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
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

			<div class="onetooneWrap">
				<div class="area">
					<div class="cont write">
						<h3>1:1 문의 작성</h3>
						<p>순수한면에 대한 문의사항을<br />남겨주세요.</p>
						<div class="btnArea">
							<a href="/customer/onetoone_write.asp" class="btn">작성하기</a>
						</div>
					</div>
					<div class="cont confirm">
						<h3>1:1 문의 확인</h3>
						<p>문의한 내용의 답변을<br />확인하세요.</p>
						<div class="btnArea">
							<a href="/customer/onetoone_list.asp" class="btn">확인하기</a>
						</div>
					</div>
				</div>

				<dl class="customerCenter">
					<dt><strong>소비자 상담실</strong></dt>
					<dd>
						<strong>080-082-2100</strong>
						<p>운영시간평일 AM 09:00 ~ PM 18:00</p>
					</dd>
				</dl>
			</div>

		</div><!-- //.contents -->
	</div>

	<!-- #include virtual = "/include/inc_footer.asp" -->
</div>
</body>
</html>