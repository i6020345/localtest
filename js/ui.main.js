$(document).ready(function(){
	$('.frame > ul > li').css('height', $(window).height() );

	//배너swipe
	var mySwiper = new Swiper('.swipeWrap .swiper-container', {
		direction: 'horizontal',
		slidesPerView: 2,
		speed: 300,
		touchMoveStopPropagation:false,
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		}
	});
	//팝업swipe
	var popSwiper = new Swiper('.popupBox .swiper-container', {
		//direction: 'horizontal',
		slidesPerView: 1,
		//spaceBetween: 30,
		speed: 300,
		touchMoveStopPropagation:false,
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		}
	});

	
	$(window).scroll(function () {
		//$('h3').fadeIn(500);
	});
	$(window).resize(function() {
		$('.frame > ul > li').css('height', $(window).height() );
	});

	$('.popupBox .closeArea').click(function() {
		$(this).parent().parent().hide();
	});

	$('.movie_frame_tab1').click(function() {
		$('.movie_frame_tab').css('background-image',"url('/images/main/movie_frame_tab1.png')");
		$('.movie_frame_tab iframe').attr('src','https://www.youtube.com/embed/Z82_dAbq2RA?wmode=opaque&rel=0');
	});

	$('.movie_frame_tab2').click(function() {
		$('.movie_frame_tab').css('background-image',"url('/images/main/movie_frame_tab2.png')");
		$('.movie_frame_tab iframe').attr('src','https://www.youtube.com/embed/IDT3uaSk3TI?wmode=opaque&rel=0');
	});
});

/*global Sly */
$(function() {
	var $frame = $('#mainScroll .frame');
	var $wrap  = $frame.parent();
	var $li = $('#mainScroll .frame .clearfix > li');
	var $size = $('#mainScroll .frame .clearfix > li').size() -1;

	// Call Sly on frame
	$frame.sly({
		horizontal: true,
		itemNav: 'basic', //forceCentered basic
		smart: 1,
		//activateOn: 'click',
		mouseDragging: 1,
		touchDragging: null,
		releaseSwing: 1,
		startAt: 'activeElementPosition',
		//scrollBar: $wrap.find('.scrollbar'),
		scrollBy: 1,
		pagesBar: $wrap.find('.pages'),
		//activatePageOn: 'activeElementPosition ',
		speed: 2000,
		moveBy: 600,
		easing: 'easeOutExpo',
		dragHandle: 1,
		clickBar: 1,

		// Cycling
		cycleBy: 'pages',
		cycleInterval: 1000,
		//pauseOnHover: 1,
		startPaused: 1,

		pageBuilder : function (index) {
			var total = $('li', $($frame)).length;
			if(index == total || index == 0){
				return '<li>' + (index + 1) + '</li>';
			}else if(index == total || index == 5){
				return '<li>' + index + '</li>';
			}else{
				return '<li>' + index + '</li>';
			}
		},

		// Buttons
		prevPage: $wrap.find('.prevPage'),
		nextPage: $wrap.find('.nextPage')
	});


	// Pause button
	$wrap.find('.pause').on('click', function () {
		$frame.sly('pause');
	});

	// Resume button
	$wrap.find('.resume').on('click', function () {
		$frame.sly('resume');
	});

	// Toggle button
	$wrap.find('.toggle').on('click', function () {
		$frame.sly('toggle');
	});

	$('.pager .total').append($size);

	//main footer
	$(document).on("click", ".main .footerBtn", function () {
		$(this).toggleClass("active");
		$("#footer").slideToggle(200);
		return false;
	});

	window.onload = function () {
		$li.each(function () {
			// 개별적으로 Wheel 이벤트 적용
			$(this).on("mousewheel DOMMouseScroll", function (e) {
				e.preventDefault();
				var delta = 0;
				if (!event) event = window.event;
				if (event.wheelDelta) {
					delta = event.wheelDelta / 120;
					if (window.opera) delta = -delta;
				} else if (event.detail) delta = -event.detail / 3;
				// 마우스휠을 위에서 아래로
				if (delta < 0) {
					if ($(this).next() != undefined) {

					}
				// 마우스휠을 아래에서 위로
				}else {
					if ($(this).prev() != undefined) {
						$('.footerBtn').removeClass('active');
						$('#footer').css('display','none');
					}
				}
			});
		});
	}

});

