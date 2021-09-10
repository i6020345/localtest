<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<html lang="ko">
<head>
<!-- #include virtual = "/include/inc_header.asp" -->
<style>
#contents img { width:100%; }
.settle_project_tab { width:90%; position:relative; margin:0 auto; }
.settle_project_tab img  { width:100%; }
.settle_project_tab .tab_cf { display: block; }
.settle_project_tab .tab_iv { display: none; }
.settle_project_tab .btn_cf { position:absolute; top:0; left:0; width:50%; height:100%; text-indent:-9999999px; }
.settle_project_tab .btn_iv { position:absolute; top:0; right:0; width:50%; height:100%; text-indent:-9999999px; }

.settle_project_movie { width:90%; position:relative; margin:0 auto; }
.settle_project_movie .movie_cf { border:5px solid #ccdcf3; box-sizing:0; display:block; }
.settle_project_movie .movie_iv { border:5px solid #fecdd0; box-sizing:0; display:none; }

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

.project_over_s1 {cursor:pointer;}
.settle_project_over_s1 { display:none; }
.project_over_s2 {cursor:pointer;}
.settle_project_over_s2 { display:none; }
.settle_project_over_s2_tab {position:relative;}
.settle_project_over_s2_tab1 {position:absolute; top:0; left:0; width:33.5%; height:100%; cursor:pointer;}
.settle_project_over_s2_tab2 {position:absolute; top:0; left:33.5%; width:33%; height:100%; cursor:pointer;}
.settle_project_over_s2_tab3 {position:absolute; top:0; left:66.5%; width:33.5%; height:100%; cursor:pointer;}
</style>

<script>
$(document).ready(function(){
	$(".btn_cf").click(function(){
		$(".tab_cf").show();
		$(".tab_iv").hide();
		$(".movie_cf").html('<iframe width="100%" height="305" src="https://www.youtube.com/embed/Z82_dAbq2RA?wmode=opaque&amp;rel=0" frameborder="0" allowfullscreen=""></iframe>').show();
		$(".movie_iv").html('').hide();
	});
	$(".btn_iv").click(function(){
		$(".tab_cf").hide();
		$(".tab_iv").show();
		$(".movie_cf").html('').hide();
		$(".movie_iv").html('<iframe width="100%" height="305" src="https://www.youtube.com/embed/IDT3uaSk3TI?wmode=opaque&amp;rel=0" frameborder="0" allowfullscreen=""></iframe>').show();
	});

	$(".project_over_s1").click(function(){
		$(".settle_project_over_s1").slideToggle("fast", function(){
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
	});

	$(".project_over_s2").click(function(){
		$(".settle_project_over_s2").slideToggle("fast", function(){});
	});

	$(".settle_project_over_s2_tab1").click(function(){
		$(".settle_project_over_s2_tab img").attr('src','/images/settlement/settle_over_s2_tab1.png?v1');
		$(".settle_project_over_s2_content img").attr('src','/images/settlement/settle_over_s2_content1.png');
	});
	$(".settle_project_over_s2_tab2").click(function(){
		$(".settle_project_over_s2_tab img").attr('src','/images/settlement/settle_over_s2_tab2.png?v1');
		$(".settle_project_over_s2_content img").attr('src','/images/settlement/settle_over_s2_content2.png');
	});
	$(".settle_project_over_s2_tab3").click(function(){
		$(".settle_project_over_s2_tab img").attr('src','/images/settlement/settle_over_s2_tab3.png?v1');
		$(".settle_project_over_s2_content img").attr('src','/images/settlement/settle_over_s2_content3.png');
	});
});
</script>
</head>
<body>
<div id="wrap" class="wide promise">
	<!-- #include virtual = "/include/page_header.asp" -->

	<div id="container">
		<!-- #lnb -->
		<div id="lnb">
			<nav>
				<div class="wrap">
					<strong class="tit" style="letter-spacing:-1px;">#안심정착 프로젝트</strong>
					<ul>
						<li class="active"><a href="/settlement/project.asp">안심 정착 프로젝트란?</a></li>
						<li><a href="/settlement/story.asp">안심 정착 스토리</a></li>
					</ul>
				</div>
			</nav>
		</div>
		<!-- //#lnb -->

		<div class="contents" style="width:640px; margin:0 auto; padding-bottom:200px;">
			<h2 class="h2_tit">안심 정착 프로젝트란?</h2><!-- 타이틀 -->

			<div><img src="/images/settlement/settle_s2_01.png"></div>
			<div class="settle_project_tab">
				<div class="tab_iv"><img src="/images/settlement/settle_movie_01.png"></div>
				<div class="tab_cf"><img src="/images/settlement/settle_movie_02.png"></div>
				<a class="btn_iv">안심정착 인터뷰</a>
				<a class="btn_cf">안심정착 CF</a>
			</div>
			<div class="settle_project_movie">
				<div class="movie_iv"></div>
				<div class="movie_cf"><iframe width="100%" height="305" src="https://www.youtube.com/embed/Z82_dAbq2RA?wmode=opaque&amp;rel=0" frameborder="0" allowfullscreen=""></iframe></div>
				
			</div>
			<div><img src="/images/settlement/settle_s2_02.png"></div>
			<div class="project_over_s1"><img src="/images/settlement/settle_s2_03.png"></div>
			<div class="settle_project_over_s1">
				<div><img src="/images/settlement/settle_over_01.png"></div>
				<div><img src="/images/settlement/settle_over_02.png"></div>
				<div class="swiper02 swiper-container">
					<ul class="swiper-wrapper">
						<li class="swiper-slide"><img src="/images/settlement/settle_over_02_slide_01.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_02_slide_02.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_02_slide_03.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_02_slide_04.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_02_slide_05.png" alt=""></li>
					</ul>
					<a class="btn-02-prev"><img src="/images/settlement/slide_btn_left.png"></a>
					<a class="btn-02-next"><img src="/images/settlement/slide_btn_right.png"></a>
				</div>
				<div><img src="/images/settlement/settle_over_03.png"></div>
				<div class="swiper03 swiper-container">
					<ul class="swiper-wrapper">
						<li class="swiper-slide"><img src="/images/settlement/settle_over_03_slide_01.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_03_slide_02.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_03_slide_03.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_03_slide_04.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_03_slide_05.png" alt=""></li>
					</ul>
					<a class="btn-03-prev"><img src="/images/settlement/slide_btn_left.png"></a>
					<a class="btn-03-next"><img src="/images/settlement/slide_btn_right.png"></a>
				</div>
				<div><img src="/images/settlement/settle_over_04.png"></div>
				<div class="swiper04 swiper-container">
					<ul class="swiper-wrapper">
						<li class="swiper-slide"><img src="/images/settlement/settle_over_04_slide_01.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_04_slide_02.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_04_slide_03.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_04_slide_04.png" alt=""></li>
						<li class="swiper-slide"><img src="/images/settlement/settle_over_04_slide_05.png" alt=""></li>
					</ul>
					<a class="btn-04-prev"><img src="/images/settlement/slide_btn_left.png"></a>
					<a class="btn-04-next"><img src="/images/settlement/slide_btn_right.png"></a>
				</div>
			</div>

			<div class="project_over_s2"><img src="/images/settlement/settle_s2_04.png"></div>
			<div class="settle_project_over_s2">
				<div><img src="/images/settlement/settle_over_s2_01.png"></div>
				<div class="settle_project_over_s2_tab">
					<img src="/images/settlement/settle_over_s2_tab1.png?v1">
					<div class="settle_project_over_s2_tab1"></div>
					<div class="settle_project_over_s2_tab2"></div>
					<div class="settle_project_over_s2_tab3"></div>
				</div>
				<div class="settle_project_over_s2_content">
					<img src="/images/settlement/settle_over_s2_content1.png">
				</div>
			</div>
			<div><img src="/images/settlement/settle_s2_05.png"></div>
			<div><a href="/zero.asp"><img src="/images/settlement/settle_s2_06.png"></a></div>
		</div><!-- //.contents -->
	</div>

	<!-- #include virtual = "/include/inc_footer.asp" -->
</div>

</body>
</html>