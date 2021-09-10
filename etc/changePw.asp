<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
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
</script>
</head>
<body>
<div id="wrap" class="sub">
	<!-- #include virtual = "/include/page_header.asp" -->

	<div id="container" class="login">

		<div class="contents">
			<h2 class="h2_tit">비밀번호 변경 </h2><!-- 타이틀 -->

			<div class="loginArea">
				<div class="logonWrap other">
					<div class="">
						<p class="txt">
							지금 순수한면 비밀번호를<br />변경해주세요!
						</p>
						<p class="txt2">
							안녕하세요, 순수한면입니다.<br />고객님의 소중한 개인정보를  안전하게 보호하기 위해 <br />비밀번호를 변경해주시기 바랍니다.
						</p>
					</div>
					<div class="btnArea wide">
						<a href="http://www.kleannara.com/modify01.asp" class="btn grey" target="_blank">비밀번호 변경</a>
						<a href="<%=rtn%>" title="변경하기" class="btn">다음에 변경</a>
					</div>
				</div>
			</div>

		</div><!-- //.contents -->
	</div>

	<!-- #include virtual = "/include/inc_footer.asp" -->
</div>
</body>
</html>


