$(function () {
	//GNB toggle
	$('#gnb .btn_menu').on('click', function(e) {
		e.preventDefault(); //prevent default event
		$('#gnb .menu').toggleClass('active');
	});
	$('#gnb .btn_close').on('click', function(e) {
		e.preventDefault(); //prevent default event
		$('#gnb .menu').toggleClass('active');
	});

	//GNB menu
	$('#gnb>nav>ul>li>a').on('click', function(e) {
		var $me = $(this),
			$li = $me.closest('li');
		
		if (/.*\#$/.test($me.attr('href'))) e.preventDefault();

		if ($li.hasClass('active')) {
			$li.find('ul').slideUp(200);
			setTimeout(function(){$li.removeClass('active');},200);
		} else {
			var $active =$('#gnb>nav>ul>li.active'); 
			$active.find('ul').slideUp(200);
			setTimeout(function(){$active.removeClass('active');},200);
			$li.find('ul').hide().slideDown(200).end().addClass('active');
		}
	});

	//product tab
	$('ul.tab li').click(function() {
		var activeTab = $(this).attr('data-tab');
		$('ul.tab li').removeClass('active');
		$('.tabContent').removeClass('active');
		$(this).addClass('active');
		$('#' + activeTab).addClass('active');
	})
	
	//사이트맵
	$(document).on("click", ".sitemap .layer_btn", function () {
		$(this).toggleClass("active");
		$(this).parent(".layer_menu").find(".menu").slideToggle(200);
		return false;
	});
	//패밀리사이트
	$(document).on("click", ".familysite .layer_btn", function () {
		$(this).toggleClass("active");
		$(this).parent(".layer_menu").find(".menu").slideToggle(200);
		return false;
	});
	// login mouseover 
	$('#gnb .loginArea .btn').mouseover(function() { 
		$('#gnb .loginArea .txt').addClass('active');
	}).mouseout(function(){
		$('#gnb .loginArea .txt').removeClass('active');
	});

	// 파일첨부
	var uploadFile = $('.fileBox .uploadBtn');
	uploadFile.on('change', function(){
		if(window.FileReader){
			var filename = $(this)[0].files[0].name;
		} else {
			var filename = $(this).val().split('/').pop().split('\\').pop();
		}
		$(this).siblings('.fileName').val(filename);
	});

	//magnificPopup 이메일주소무단수집거부
	$('.open-popup-link').magnificPopup({});
})

function goMyPage() {
	if (confirm("회원정보 수정은 '깨끗한나라' 사이트에서 가능합니다.\n회원정보 수정을 진행하시겠습니까?")) {
		window.open("http://www.kleannara.com/modify01.asp");
	}
}

function goIDFind() {
	if (confirm("아이디 찾기는 '깨끗한나라' 사이트에서 가능합니다.\n아이디 찾기를 진행하시겠습니까?")) {
		window.open("http://www.kleannara.com/id01.asp");
	}
}

function goPWFind() {
	if (confirm("비밀번호 찾기는 '깨끗한나라' 사이트에서 가능합니다.\n비밀번호 찾기를 진행하시겠습니까?")) {
		window.open("http://www.kleannara.com/pw01.asp");
	}
}

function goJoin() {
	if (confirm("회원가입은 '깨끗한나라' 사이트에서 가능합니다.\n회원가입을 진행하시겠습니까?")) {
		window.open("http://www.kleannara.com/join01.asp");
	}
}