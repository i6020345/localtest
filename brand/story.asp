<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<html lang="ko">
<head>
<!-- #include virtual = "/include/inc_header.asp" -->
</head>
<body class="fixed">
<div id="wrap" class="wide brand">
	<!-- #include virtual = "/include/page_header.asp" -->

	<div id="container">

		<div class="contents">
			<h2 class="h2_tit">순수한면 이야기</h2><!-- 타이틀 -->

			<div id="brandWrap" class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide brandStory active story01">
						<div class="introTxt">
							<div class="scroll">
								<h3 class="js-words">순수한면,<br />순수함을 지키다</h3>
								<i class="icoScroll"></i>
							</div>
						</div>
						<div class="bg bg1"></div>
					</div>
					<div class="swiper-slide brandStory story02">
						<div class="introTxt">
							<div class="scroll">
								<div>
									<div class="js-words">
										순수하다는 건 사람을 먼저 생각한다는 것<br /><br />
										몸도 마음도 고단한 당신의 그날<br />우리는 그날의 당신을 생각합니다.<br /><br />
										자유로울 수 있었으면,<br />눈치 보지 않았으면,<br /><br />
										가뿐할 수 있었으면,<br />산뜻할 수 있었으면,
									</div>
								</div>
							</div>
						</div>
						<div class="bg bg2"></div>
					</div>
<style type="text/css">
/* ui.sub.css */
#brandWrap .story03{background: url('../images/brand/brand_bg3_a.jpg') 50% 50% no-repeat;}
</style>
					<div class="swiper-slide brandStory story03 last ">
						<div class="introTxt">
							<div class="scroll">
								<div class="">가장 편안해야 하는 그날을 위해 <br />매 순간 신중함을 더하여<br /><br />
									당신이 안전할 수 있도록<br />자연의 순수함을 더하여<br /><br />
									당신이 안심할 수 있도록 순수한 생각 하나로<br />당신의 그날을 끝까지 지키겠습니다. <br /><br />
									나의 첫 순면, 순수한면<br />순수한면, 순수함을 지키다.</div>
							</div>
						</div>
						<div class="bg bg3"></div>
					</div>
				</div>
			</div>
		</div><!-- //.contents -->
	</div>

	<!-- #include virtual = "/include/inc_footer.asp" -->
</div>
<script type="text/javascript">
$(document).ready(function() {
	$('#brandWrap').css('height', $(window).height());
	$(window).resize(function() {
		$('#brandWrap').css('height', $(window).height());
	});

	var mySwiper = new Swiper('#brandWrap', {
		direction: 'vertical',
		effect: 'fade',
		slidesPerView: 1,
		spaceBetween: 30,
		mousewheel: true,
		watchActiveIndex: true
	});

});
</script>
</body>
</html>