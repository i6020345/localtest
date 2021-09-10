<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
IsSSL = "Y"
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
</script>
</head>
<body>
<div id="wrap" class="sub">
	<!-- #include virtual = "/include/page_header.asp" -->

	<div id="container" class="login">

		<div class="contents">
			<h2 class="h2_tit">로그인</h2><!-- 타이틀 -->

			<div class="loginArea">
				<div class="logonWrap">
<form name="inputForm" method="post" action="login_data.asp" target="hiddenFrame">
<input type="hidden" name="returnUrl" value="<%=returnUrl%>" />
						<fieldset>
							<legend>로그인</legend>

							<div class="loginInput"><input type="text" class="txt" name="member_id" id="member_id" title="아이디" placeholder="아이디" required="required" /></div>
							<div class="loginInput"><input type="password" class="txt" name="member_pwd" id="member_pwd" title="비밀번호" placeholder="비밀번호" required="required" /></div>
							<div class="idSave"><input type="checkbox" name="idSave" id="idSave"><label for="idSave">아이디 저장</label></div>
							<div class="btnArea">
								<button type="submit" class="btn grey"><span>로그인</span></button>
								<a href="javascript:goJoin();" class="btn">회원가입</a>
							</div>
							<div class="searchArea">
								<a href="javascript:goIDFind();">아이디 찾기</a>
								<i></i>
								<a href="javascript:goPWFind();">비밀번호 찾기</a>
							</div>
						</fieldset>
</form>
				</div>
				<p class="txt">순수한면은 깨끗한나라(주)의 통합 회원가입제를 적용하고 있습니다. <br />기존의 보솜이 또는 비야비야 회원이시라면 이용 중이신 ID로 로그인 하신 뒤 <br />순수한면 사이트 통합회원 동의에 체크하시면, 순수한면 사이트를 이용하실 수 있습니다.</p>
			</div>

		</div><!-- //.contents -->
	</div>

	<!-- #include virtual = "/include/inc_footer.asp" -->
</div>
</body>
</html>