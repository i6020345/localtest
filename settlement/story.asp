<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<html lang="ko">
<head>
<!-- #include virtual = "/include/inc_header.asp" -->
<style>
#contents img { width:100%; }
.swiper-container { position:relative; }
.swiper-container a.btn-02-prev { position:absolute; display:block; top:0; left:0; width:40px; height:100%; text-align:center; vertical-align:middle; z-index:2; }
.swiper-container a.btn-02-next { position:absolute; display:block; top:0; right:0; width:40px; height:100%; text-align:center; vertical-align:middle; z-index:2; }
.swiper-container a.btn-02-prev img { position:absolute; top:50%; left:5px; margin-top:-8px; max-width:16px; }
.swiper-container a.btn-02-next img { position:absolute; top:50%; right:5px; margin-top:-8px; max-width:16px; }
.swiper-container a.btn-03-prev { position:absolute; display:block; top:0; left:0; width:40px; height:100%; text-align:center; vertical-align:middle; z-index:2; }
.swiper-container a.btn-03-next { position:absolute; display:block; top:0; right:0; width:40px; height:100%; text-align:center; vertical-align:middle; z-index:2; }
.swiper-container a.btn-03-prev img { position:absolute; top:50%; left:5px; margin-top:-8px; max-width:16px; }
.swiper-container a.btn-03-next img { position:absolute; top:50%; right:5px; margin-top:-8px; max-width:16px; }
.swiper-container a.btn-04-prev { position:absolute; display:block; top:0; left:0; width:40px; height:100%; text-align:center; vertical-align:middle; z-index:2; }
.swiper-container a.btn-04-next { position:absolute; display:block; top:0; right:0; width:40px; height:100%; text-align:center; vertical-align:middle; z-index:2; }
.swiper-container a.btn-04-prev img { position:absolute; top:50%; left:5px; margin-top:-8px; max-width:16px; }
.swiper-container a.btn-04-next img { position:absolute; top:50%; right:5px; margin-top:-8px; max-width:16px; }

.settle_project_over { display:none; }
</style>

<script>
$(document).ready(function(){
	swiper02 = new Swiper('.swiper02', {
		autoplay: false,
		loop: true
	});
	$(".btn-02-prev").click(function(){ swiper02.slidePrev(); });
	$(".btn-02-next").click(function(){ swiper02.slideNext(); });

	swiper03 = new Swiper('.swiper03', {
		autoplay: false,
		loop: true
	});
	$(".btn-03-prev").click(function(){ swiper03.slidePrev(); });
	$(".btn-03-next").click(function(){ swiper03.slideNext(); });

	swiper04 = new Swiper('.swiper04', {
		autoplay: false,
		loop: true
	});
	$(".btn-04-prev").click(function(){ swiper04.slidePrev(); });
	$(".btn-04-next").click(function(){ swiper04.slideNext(); });
});
</script>
</head>
<body>
<div id="wrap" class="wide promise">
	<!-- #include virtual = "/include/page_header.asp" -->

	<div id="container" style="background:#f5faff;">
		<!-- #lnb -->
		<div id="lnb">
			<nav>
				<div class="wrap">
					<strong class="tit" style="letter-spacing:-1px;">#안심정착 프로젝트</strong>
					<ul>
						<li><a href="/settlement/project.asp">안심 정착 프로젝트란?</a></li>
						<li class="active"><a href="/settlement/story.asp">안심 정착 스토리</a></li>
					</ul>
				</div>
			</nav>
		</div>
		<!-- //#lnb -->

		<div class="contents" style="width:640px; margin:0 auto; padding-bottom:200px;">
			<h2 class="h2_tit">안심 정착 스토리</h2><!-- 타이틀 -->

			<div><img src="/images/settlement/story_01.png"></div>
			<div class="swiper02 swiper-container">
				<ul class="swiper-wrapper">
					<li class="swiper-slide"><img src="/images/settlement/story_01_slide_04.png" alt=""></li>
					<li class="swiper-slide"><img src="/images/settlement/story_01_slide_03.png" alt=""></li>
					<li class="swiper-slide"><img src="/images/settlement/story_01_slide_02.png" alt=""></li>
					<li class="swiper-slide"><img src="/images/settlement/story_01_slide_01.png" alt=""></li>
				</ul>
				<a class="btn-02-prev"><img src="/images/settlement/slide_btn_left.png"></a>
				<a class="btn-02-next"><img src="/images/settlement/slide_btn_right.png"></a>
			</div>
			<div><img src="/images/settlement/story_02.png"></div>
			<div class="swiper03 swiper-container">
				<ul class="swiper-wrapper">
					<li class="swiper-slide"><img src="/images/settlement/story_02_slide_04.png" alt=""></li>
					<li class="swiper-slide"><img src="/images/settlement/story_02_slide_03.png" alt=""></li>
					<li class="swiper-slide"><img src="/images/settlement/story_02_slide_02.png" alt=""></li>
					<li class="swiper-slide"><img src="/images/settlement/story_02_slide_01.png" alt=""></li>
				</ul>
				<a class="btn-03-prev"><img src="/images/settlement/slide_btn_left.png"></a>
				<a class="btn-03-next"><img src="/images/settlement/slide_btn_right.png"></a>
			</div>
			<div><img src="/images/settlement/story_03.png"></div>
			<div class="swiper04 swiper-container">
				<ul class="swiper-wrapper">
					<li class="swiper-slide"><img src="/images/settlement/story_03_slide_04.png" alt=""></li>
					<li class="swiper-slide"><img src="/images/settlement/story_03_slide_03.png" alt=""></li>
					<li class="swiper-slide"><img src="/images/settlement/story_03_slide_02.png" alt=""></li>
					<li class="swiper-slide"><img src="/images/settlement/story_03_slide_01.png" alt=""></li>
				</ul>
				<a class="btn-04-prev"><img src="/images/settlement/slide_btn_left.png"></a>
				<a class="btn-04-next"><img src="/images/settlement/slide_btn_right.png"></a>
			</div>
		</div><!-- //.contents -->
	</div>

	<!-- #include virtual = "/include/inc_footer.asp" -->
</div>

</body>
</html>