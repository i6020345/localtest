<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<html lang="ko">
<head>
<!-- #include virtual = "/include/inc_header.asp" -->
</head>
<body>
<div id="wrap" class="wide promise">
	<!-- #include virtual = "/include/page_header.asp" -->

	<div id="container">
		<!-- #lnb -->
		<div id="lnb">
			<nav>
				<div class="wrap">
					<strong class="tit">순수한면 약속 코드</strong>
					<ul>
						<li class="active"><a href="/promise/purecotton.asp">약속 코드란?</a></li>
						<li><a href="/promise/safety.asp">순수한면 안심 정보</a></li>
					</ul>
				</div>
			</nav>
		</div>
		<!-- //#lnb -->

		<div class="contents">
			<h2 class="h2_tit">약속 코드란?</h2><!-- 타이틀 -->

			<div id="purecottenCode" class="swiper-container">
				<div class="swiper-wrapper">
					<div id="codeBox1" class=" sectionBox swiper-slide">
						<div class="bs_title">
							<div class="title small">감추는 모든 건 다 잊고<br />순수한 그날에 집중할 시간,</div>
							<i class="icoScroll"></i>
						</div>
					</div>
					<div id="codeBox2" class=" sectionBox swiper-slide">
						<div class="bs_title">
							<div class="title small">숨김없이 다 보여주고,<br />변함없이 더 지켜주는</div>
							<!-- <i class="icoScroll"></i> -->
						</div>
					</div>
					<div id="codeBox3" class=" sectionBox swiper-slide">
						<div class="bs_title">
							<div class="title">당신을 위한 순수한 약속,<br /><strong>약속 코드 캠페인</strong></div>
							<!-- <i class="icoScroll"></i> -->
						</div>
					</div>
					<div id="codeBox4" class=" sectionBox swiper-slide">
						<div class="bs_title ">
							<div class="scroll">순수한면, 오늘 부터 약속합니다.<br />
								한 걸음 다가와 약속 코드를 찍어 주세요<br /><br />
								
								복잡한 성분을 보기 쉽게 정리하여<br />
								어렵지않게, 더 가까워질 수 있도록<br /><br />
								
								 100% 자연 순면 커버부터<br />
								100% 전성분 공개까지<br />
								숨김없이 다 보여드립니다.<br /><br />
								
								당신의 더 나은 그날을 위해<br />
								숨김 없이 순수한 면<br /><br />
								
								순수하게, 너를 보여줘<br />
								우리들의 순수 코드<br />
								숨김없는 약속 코드</div>
						</div>
					</div>
<style type="text/css">
/* ui.sub.css */
#purecottenCode .qrcode {position:relative; width:850px; margin:50px auto 0;}
#purecottenCode .qrcode .promise_health {position:absolute;top: 226px;left: 43px;width: 180px;height: 30px;cursor:pointer;}
#purecottenCode .qrcode .promise_zero {position:absolute; top: 226px; left: 335px; width: 180px; height: 30px; cursor:pointer;}
#purecottenCode .qrcode .promise_super {position:absolute; top: 226px; left: 627px; width: 180px; height: 30px;cursor:pointer;}
</style>
					<div id="codeBox5" class="last sectionBox swiper-slide">
						<div class="bs_title">
							<div class="wrap">
								<h3 class="titBdline">숨김없는 약속 코드</h3>
								<div class="contBox qrcode">
									<img src="../images/promise/purecotten_code_200806.png" alt="" style="width:100%;">
									<div class="promise_zero" onClick="promise_winopen('zero');"></div>
									<div class="promise_super" onClick="promise_winopen('super');"></div>
									<div class="promise_health" onClick="promise_winopen('health');"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Add Pagination -->
				<div class="swiper-pagination" style="display:none;"></div>
			</div>
		</div><!-- //.contents -->
	</div>

	<!-- #include virtual = "/include/inc_footer.asp" -->
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$('#purecottenCode').css('height', $(window).height());
		$(window).resize(function() {
			$('#purecottenCode').css('height', $(window).height());
		});

		var mySwiper = new Swiper('#purecottenCode', {
			direction: 'vertical',
			slidesPerView: 1,
			spaceBetween: 30,
			mousewheel: true
		});

	});

	function promise_winopen(_type) {
		if (_type == 'zero') {
			var _uri = 'http://m.purecotton.co.kr/promise/purecotton_zero.asp';
		} else if (_type == 'super') {
			var _uri = 'http://m.purecotton.co.kr/promise/purecotton_super.asp';
		} else if (_type == 'slim') {
			var _uri = 'http://m.purecotton.co.kr/promise/purecotton_slim.asp';
		} else if (_type == 'health') {
			var _uri = 'http://m.purecotton.co.kr/promise/purecotton_health.asp';
		}
		window.open(_uri,'new_win','toolbar=no, scrollbars=yes, resizable=yes, width=640, height=600');
	}
</script>
</body>
</html>