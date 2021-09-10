<%
'내부 아이피만 접근 가능
Dim clientIP
clientIP = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If clientIP = "" Then 
	clientIP = Request.ServerVariables("REMOTE_HOST")
End If 

If InStr(clientIP, "211.232.79.") < 1 Then 
'	Response.end
End If

If Request.ServerVariables("SERVER_NAME") = "purecotton.co.kr" Then
	response.redirect("http://www.purecotton.co.kr" & Request.ServerVariables("SCRIPT_NAME") & "?" &  Request.ServerVariables("QUERY_STRING"))
End If

sUsrAgent = UCase(Request.ServerVariables("HTTP_USER_AGENT")) 
If InStr(sUsrAgent, "ANDROID") > 0 Then
    '안드로이드
	If Request.ServerVariables("QUERY_STRING") <> "" Then
		response.redirect("http://m.purecotton.co.kr" & Request.ServerVariables("SCRIPT_NAME") & "?" &  Request.ServerVariables("QUERY_STRING"))
	Else 
		response.redirect("http://m.purecotton.co.kr" & Request.ServerVariables("SCRIPT_NAME"))
	End if
ElseIf InStr(sUsrAgent, "IPAD") Or InStr(sUsrAgent, "IPHONE") Then
    'iOS
	If Request.ServerVariables("QUERY_STRING") <> "" Then
		response.redirect("http://m.purecotton.co.kr" & Request.ServerVariables("SCRIPT_NAME") & "?" &  Request.ServerVariables("QUERY_STRING"))
	Else 
		response.redirect("http://m.purecotton.co.kr" & Request.ServerVariables("SCRIPT_NAME"))
	End if
Else
    '웹 및 기타 디바이스
End If

'PV INSERT
Dim KIND_AGENT
KIND_AGENT = UCase(Request.ServerVariables("HTTP_USER_AGENT")) 
Dim kind
If InStr(KIND_AGENT, "ANDROID") > 0 Then
	kind = "M"
ElseIf InStr(KIND_AGENT, "IPAD") Or InStr(KIND_AGENT, "IPHONE") Then
	kind = "M"
Else
	kind = "W"
End If

Dim pvpage, page_diet
page_diet = Request.ServerVariables("SCRIPT_NAME")
pvpage = page_diet
If Request.ServerVariables("QUERY_STRING") <> "" Then
	pvpage = page_diet & "?" &  Request.ServerVariables("QUERY_STRING")
End if

Dim rfromurl
rfromurl = ""
rfromurl = request.QueryString("fromurl")
If rfromurl <> "" Then
	Response.Cookies("fromurl") = rfromurl
Else
	If Request.Cookies("fromurl") <> "" Then
		rfromurl = Request.Cookies("fromurl")
	End if
End if

Dim pvClientIP
pvClientIP = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If pvClientIP = "" Then 
pvClientIP = Request.ServerVariables("REMOTE_HOST")
End If 

Set dbPV = Server.CreateObject("ADODB.Connection")
dbPV.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
dbPV.Open

sql = "INSERT INTO [dbo].[tblPv]([kind],[page],[page_diet],[ip],[referer],[fromurl],[agent],[regday],[regdate]) "
sql = sql & "VALUES('" & kind & "','" & pvpage & "','" & page_diet & "','" & pvClientIP & "','" & Request.ServerVariables("HTTP_REFERER") & "','" & rfromurl & "','" & Request.ServerVariables("HTTP_USER_AGENT") & "', getdate(), getdate())"

dbPV.Execute sql

dbPV.Close
Set dbPV = Nothing

Dim snsidx
snsidx = ""
snsidx = request.QueryString("snsidx")

Dim snsFeedFb
snsFeedFb = ""
Dim snsFeedTw
snsFeedTw = ""
If snsidx <> "" Then
	Set dbPV = Server.CreateObject("ADODB.Connection")
	dbPV.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
	dbPV.Open

	sql = "SELECT top 1 * FROM [dbo].[tblPromotionSkin] where idx="& snsidx
	set rs = dbPV.execute(sql)

	if not rs.eof then
		do until rs.eof
			snsFeedFb = "/upload/evtskin/"& rs("feed_fb")
			snsFeedTw = "/upload/evtskin/"& rs("feed_tw")
			rs.movenext
		loop
	end If

	dbPV.Close
	Set dbPV = Nothing
Else
	snsFeedFb = "/images/event/skin_attachment/share_default_fb.png"
	snsFeedTw = "/images/event/skin_attachment/share_default_tw.png"
End If

Dim page_url
If Request.ServerVariables("QUERY_STRING") <> "" Then
	page_url = "http://purecotton.co.kr/event/skin_attachment.asp" & "?" &  Request.ServerVariables("QUERY_STRING")
Else
	page_url = "http://purecotton.co.kr/event/skin_attachment.asp"
End if

Session("skin_idx") = ""
Response.Cookies("skin_idx") = ""

Set db = Server.CreateObject("ADODB.Connection")
db.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
db.Open

sql = "SELECT count(1) as cnt FROM [dbo].[tblPromotionSkin]"
set rs = db.execute(sql)

if not rs.eof then
	do until rs.eof
		totalCount = rs("cnt")
		rs.movenext
	loop
end If

db.Close
Set db = Nothing
%>


<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- header Start -->

	<link rel="shortcut icon" href="/images/common/favicon.ico" type="image/x-icon" />
	<meta property="fb:app_id" content="2485751364778408">
	<meta property="og:title" content="100% 유기농 건강한 순수한면! 구매인증하고 독일가자!" />
	<meta property="og:type" content="website" />
	<meta property="og:url" content="<%= page_url %>" />
	<meta property="og:site_name" content="순수한면" />
	<meta property="og:description" content="건강한 순수한면이 피부에 착! 붙는 이유를 새로워진 패키지에 나만의 스티커로 꾸며주세요. 추첨을 통해 독일 왕복 항공권 등 푸짐한 선물을 드립니다."/>
	<meta property="og:image" content="http://www.purecotton.co.kr<%= snsFeedFb %>" />

	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:image" content="http://www.purecotton.co.kr<%= snsFeedTw %>" />
	<meta name="twitter:title" content="100% 유기농 건강한 순수한면! 구매인증하고 독일가자!" />
	<meta name="twitter:description" content="건강한 순수한면이 피부에 착! 붙는 이유를 새로워진 패키지에 나만의 스티커로 꾸며주세요. 추첨을 통해 독일 왕복 항공권 등 푸짐한 선물을 드립니다." />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>순수한면</title>

	<link rel="stylesheet" type="text/css" href="/css/jquery.mCustomScrollbar.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/magnific-popup.css" />
	<link rel="stylesheet" type="text/css" href="/css/swiper.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/ui.common.css?v1" />
	<link rel="stylesheet" type="text/css" href="/css/ui.sub.css" />

	<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/js/jquery.min.js"></script>
	<script type="text/javascript" src="/js/jquery.easing.1.3.min.js"></script>
	<script type="text/javascript" src="/js/jquery.magnific-popup.min.js"></script>
	<script type="text/javascript" src="/js/jquery.mCustomScrollbar.concat.min.js"></script>
	<script type="text/javascript" src="/js/TweenMax.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/js/ui.common.js"></script>

	<script type="text/javascript" src="/js/fabric.min.js"></script>

	<script type="text/javascript" src="/js/jquery.form.min.js?v=1"></script>

	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

	<!-- 2018.09.18 Add -->
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-120153230-1"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());

	  gtag('config', 'UA-120153230-1');
	</script>

	<!-- header End -->
	<script type="text/javascript">
	<!--
	window.fbAsyncInit = function() {
		FB.init({
			appId      : '2485751364778408',
			cookie     : true,
			version    : 'v4.0'
		});
		FB.AppEvents.logPageView();
	};

	(function(d, s, id){
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) {return;}
		js = d.createElement(s); js.id = id;
		js.src = "https://connect.facebook.net/en_US/sdk.js";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
	//-->
	</script>
</head>

<body>
<script type="text/javascript">
<!--
var canvas;
var obj;
var is_canvas_edit = false;
var is_back = true;
var is_canvas = false
$(document).ready(function() {
	Kakao.init('c496cfa2e274b61ba5e1a7e6725f85a0');

	// iframe 크기 조정
	$('.youtube_frame').css('height',($('.youtube_frame').css('width').replace('px','')*0.5625)+'px');

	$(".onlynum").keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/gi,""));

		if ($(this).val().length > $(this).attr('maxLength')){
			$(this).val($(this).val().slice(0, $(this).attr('maxLength')));
		}
	});

	$(".maxlength").keyup(function(){
		if ($(this).val().length > $(this).attr('maxLength')){
			$(this).val($(this).val().slice(0, $(this).attr('maxLength')));
		}
	});

	$(".modal_close").click(function() {
		$('.modal_sleep_phone_auth').hide();
		$('.modal_sleep_info').hide();
		$('.modal_sleep_sns').hide();
	});

	$('.select_product_item1').click(function() {
		var now = new Date();
		var end = new Date('2019','9','26');

		if (now.getTime() >= end.getTime()) {
			alert('#피부애착 프로모션이 종료되었습니다. 참여해주신 모든 분들께 감사 말씀드립니다.');
			return;
		}

		if (!is_back) {
			return;
		}
		$('.canvas_bg_img').hide();
		show_canvas('/images/event/skin_attachment/canvas_01.png?s=2', 400, 400);
		location.href="#select_product_item1";
	});

	$('.select_product_item2').click(function() {
		var now = new Date();
		var end = new Date('2019','9','26');

		if (now.getTime() >= end.getTime()) {
			alert('#피부애착 프로모션이 종료되었습니다. 참여해주신 모든 분들께 감사 말씀드립니다.');
			return;
		}

		if (!is_back) {
			return;
		}
		$('.canvas_bg_img').hide();
		show_canvas('/images/event/skin_attachment/canvas_02.png?s=2', 400, 400);
		location.href="#select_product_item1";
	});

	$('.select_product_item3').click(function() {
		var now = new Date();
		var end = new Date('2019','9','26');

		if (now.getTime() >= end.getTime()) {
			alert('#피부애착 프로모션이 종료되었습니다. 참여해주신 모든 분들께 감사 말씀드립니다.');
			return;
		}

		if (!is_back) {
			return;
		}
		$('.canvas_bg_img').hide();
		show_canvas('/images/event/skin_attachment/canvas_03.png?s=2', 400, 400);
		location.href="#select_product_item1";
	});

	$('.select_product_item4').click(function() {
		var now = new Date();
		var end = new Date('2019','9','26');

		if (now.getTime() >= end.getTime()) {
			alert('#피부애착 프로모션이 종료되었습니다. 참여해주신 모든 분들께 감사 말씀드립니다.');
			return;
		}

		if (!is_back) {
			return;
		}
		$('input[name=upload_img]').click();
	});

	var _cookie_first = getCookie('first_visit');
	if (_cookie_first == 'first') {
		var rd = Math.floor(Math.random() * (3 - 1 + 1)) + 1;
		show_canvas('/images/event/skin_attachment/canvas_0'+rd+'.png?s=2', 400, 400);
	} else {
		setCookie('first_visit', 'first', 30);
	}

	$('#canvas_bg_click').click(function() {
		var rd = Math.floor(Math.random() * (3 - 1 + 1)) + 1;
		show_canvas('/images/event/skin_attachment/canvas_0'+rd+'.png?s=2', 400, 400);
	});

	$('input[name=upload_img]').change(function(){
		var now = new Date();
		var end = new Date('2019','9','26');

		if (now.getTime() >= end.getTime()) {
			alert('#피부애착 프로모션이 종료되었습니다. 참여해주신 모든 분들께 감사 말씀드립니다.');
			return;
		}

		$("#myform").ajaxForm({
			type : "POST",
			enctype: "multipart/form-data",
			dataType : 'json',
			url : "/event/skin_imgupload.asp",
			beforeSend: function(){
			},
			success : function(rs){
				if(rs.result == "OK"){
					$('.canvas_bg_img').hide();
					$('input[name=origin_img]').val(rs.file_path+rs.file_name);

					$("#upload_image")
						.attr("src", rs.file_path+rs.file_name)
						.load(function(){
							$("#myform").show();
							rs.image_width = document.getElementById("upload_image").naturalWidth;
							rs.image_height = document.getElementById("upload_image").naturalHeight;
							show_canvas(rs.file_path + rs.file_name, rs.image_width, rs.image_height);
							$("#myform").hide();
						});;
					
				}else{
					alert("오류가 발생하였습니다. 새로고침(F5)후 다시 시도해주세요.");
					$('.greyBack').hide();
					$('.greyBackLoading').hide();
				}
			},
			error : function(er){
				alert("오류가 발생하였습니다. 새로고침(F5)후 다시 시도해주세요.");
				$('.greyBack').hide();
				$('.greyBackLoading').hide();
			}
		});

		$("#myform").submit();
	});

	$('.sticker').on('click','.skin_sticker',function() {
		var now = new Date();
		var end = new Date('2019','9','26');

		if (now.getTime() >= end.getTime()) {
			alert('#피부애착 프로모션이 종료되었습니다. 참여해주신 모든 분들께 감사 말씀드립니다.');
			return;
		}

		if (is_back) {
			if (!is_canvas) {
				alert("배경 이미지를 먼저 등록해 주세요.");
				return;
			}

			is_back = false;

			canvas.setBackgroundImage(canvas.item(0)._element.src, canvas.renderAll.bind(canvas), {
				left:canvas.item(0).left,
				top:canvas.item(0).top,
				scaleX:canvas.item(0).scaleX,
				scaleY:canvas.item(0).scaleY,
				angle:canvas.item(0).angle
			});
			canvas.remove(canvas.item(0));
		}
		is_canvas_edit = true;

		var icon_url = $(this).attr('src');

		fabric.Image.fromURL(icon_url, function(img) {
			img.set({
				left: fabric.util.getRandomInt(0, 150),
				top: fabric.util.getRandomInt(0, 150),
				angle: 0,
				scaleX:0.5,
				scaleY:0.5,
				opacity: 1
			});

			img.setControlVisible('ml',false);
			img.setControlVisible('mt',false);
			img.setControlVisible('mr',false);
			img.setControlVisible('mb',false);

			canvas.add(img);
			canvas.setActiveObject(img);
		});
	});
	
	$(".onlynum").keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/gi,""));

		if ($(this).val().length > $(this).attr('maxLength')){
			$(this).val($(this).val().slice(0, $(this).attr('maxLength')));
		}
	});

	$(".maxlength").keyup(function(){
		if ($(this).val().length > $(this).attr('maxLength')){
			$(this).val($(this).val().slice(0, $(this).attr('maxLength')));
		}
	});

	$("#btn-start").click(function(){
		var now = new Date();
		var end = new Date('2019','9','26');

		if (now.getTime() >= end.getTime()) {
			alert('#피부애착 프로모션이 종료되었습니다. 참여해주신 모든 분들께 감사 말씀드립니다.');
			return;
		}

		if (!is_canvas) {
			alert("배경 이미지를 선택해주세요.");
			return;
		}
		if (!is_canvas_edit) {
			alert("스티커로 이미지를 꾸며주세요.");
			return;
		}

		$('.grey_back').show();
		$('.modal_event').show();
		$('.modal_info').show().css('top', $(document).scrollTop() + 50);
	});

	$(".skin_attachment_gift_info").click(function(){
		$('.grey_back').show();
		$('.modal_event').show();
		$('.modal_gift_warning').show().css('top', $(document).scrollTop() + 50);
	});

	$(".footer_warning").click(function(){
		$('.grey_back').show();
		$('.modal_event').show();
		$('.modal_join_warning').show().css('top', $(document).scrollTop() + 50);
	});

	$(".modal_close").click(function(){
		$('.grey_back').hide();
		$('.modal_event').hide();
		$('.modal_container').hide();
		$('.modal_info').hide();
		$('.modal_sns').hide();
		$('.modal_gift_warning').hide();
		$('.modal_join_warning').hide();
	});
	$(".modal_agree_plus").click(function(){
		$(".modal_info_agree").show();
	});
	$(".modal_info_agree_close").click(function(){
		$(".modal_info_agree").hide();
	});
	$(".modal_maketing_plus").click(function(){
		$(".modal_info_marketing").show();
	});
	$(".modal_info_maketing_close").click(function(){
		$(".modal_info_marketing").hide();
	});

	$("#modal_info_next_btn").click(function(){
		var f = document.info_form;
		if (f.name.value == '') {
			alert('이름을 입력해 주세요.');
			f.name.focus();
			return;
		}
	
		if (f.hphone2.value == '') {
			alert('휴대전화 번호를 입력해 주세요.');
			f.hphone2.focus();
			return;
		}
	
		if (f.hphone3.value == '') {
			alert('휴대전화 번호를 입력해 주세요.');
			f.hphone3.focus();
			return;
		}
	
		if (f.agree.value != 'Y') {
			alert('개인정보 수집 및 이용에 동의하여 주세요.');
			return;
		}

		if (!fabric.Canvas.supports('toDataURL')) {
			alert('This browser doesn\'t provide means to serialize canvas to an image');
		} else {
			var data = canvas.toDataURL({ multiplier:1, format:'png' });
			$('input[name=canvas_img]').val(data);
		}

		$("#info_form").ajaxForm({
			type : "POST",
			enctype: "multipart/form-data",
			dataType : 'json',
			url : "/event/skin_info_act.asp",
			beforeSend: function(){
				$('.greyBackLoading').show();
			},
			success : function(rs){
				if (rs.rs == 'OK') {
					$('.grey_back').show();
					$('.modal_event').show();
					$('.modal_info').hide();
					$('.modal_sns').show().css('top', $(document).scrollTop() + 50);

					$("#feed_original").val(rs.uploadimage);
					//이미지 합성하기
					$.ajax({
						type : "GET",
						url: 'http://ssl.inuscomm.co.kr/imgAsp/saveImg?bg=/images/event/skin_attachment/share_bg.jpg&fb=/images/event/skin_attachment/share_fb.jpg&tw=/images/event/skin_attachment/share_tw.jpg&ks=/images/event/skin_attachment/share_ks.jpg&merge=/upload/'+ rs.uploadimage+'&name='+$("input[name='name']").val(),
						dataType: 'jsonp',
						data : {
						},
						error: function(jqXHR, textStatus, errorThrown ){
							$('.greyBackLoading').hide();
							alert("오류가 발생하였습니다. 새로고침(F5)후 다시 시도해주세요.");
						},
						beforeSend: function(){
						},
						success: function(rs, textStatus, jqXHR){
							$.ajax({
								type : "GET",
								url: '/event/skin_sns_act.asp?feed_fb='+rs.feed_fb+'&feed_tw='+rs.feed_tw+'&feed_ks='+rs.feed_ks+'&feed_bg='+rs.feed_bg,
								dataType: 'json',
								data : {
								},
								error: function(jqXHR, textStatus, errorThrown ){
									$('.greyBackLoading').hide();
									alert("오류가 발생하였습니다. 새로고침(F5)후 다시 시도해주세요.");
								},
								beforeSend: function(){
								},
								success: function(rs, textStatus, jqXHR){
									$('.greyBackLoading').hide();
									$("#snsimage").html("<img src='/upload/evtskin/"+ rs.feed_fb +"' style='width:100%;'>");
									$("#sns_idx").val(rs.idx);
									$("#feed_kt").val(rs.idx)
								}
							});

						}
					});
				} else {
					alert("오류가 발생하였습니다. 새로고침(F5)후 다시 시도해주세요.");
					//location.reload();
				}
			},
			error : function(er){
				alert("오류가 발생하였습니다. 새로고침(F5)후 다시 시도해주세요.");
				//location.reload();
			}
		});

		$("#info_form").submit();
	});

	$("#modal_sns_complete_btn").click(function(){
		if (is_share_fb) {
			if ($('input[name=sns_fb_value]').val() == '') {
				alert("참여한 페이스북 주소를 입력해 주세요.");
				return;
			}

			$.ajax({
				type : "GET",
				url: '/event/skin_sns_fb_act.asp',
				dataType: 'json',
				async: false,
				data : {
					'sns_type' : 'fb',
					'fidx' : $("#sns_idx").val(),
					'sns_etc' : $('input[name=sns_fb_value]').val()
				},
				error: function(jqXHR, textStatus, errorThrown ){
					alert("오류가 발생하였습니다. 새로고침(F5)후 다시 시도해주세요.");
				},
				beforeSend: function(){
				},
				success: function(rs, textStatus, jqXHR){
					if (rs.rs == 'OK') {
					}
				}
			});
		}
		alert("100% 유기농 건강한 순수한면! 피부애착 프로젝트에 참여해주셔서 감사합니다.");
		location.reload();
	});

	show_make_feed(1);
	$(document).on('click','.pagebtn',function() {
		show_make_feed($(this).attr('num'));
	});

	$('.agree_y').click(function() {
		$('input[name=agree]').val('Y');
		$('.agree_y').css('background-image',"url('/images/event/skin_attachment/modal_radio_on.png')");
		$('.agree_n').css('background-image',"url('/images/event/skin_attachment/modal_radio_off.png')");
	});

	$('.agree_n').click(function() {
		$('input[name=agree]').val('N');
		$('.agree_y').css('background-image',"url('/images/event/skin_attachment/modal_radio_off.png')");
		$('.agree_n').css('background-image',"url('/images/event/skin_attachment/modal_radio_on.png')");
	});

	$('.maketing_y').click(function() {
		if ($('input[name=maketing]').val() == 'Y') {
			$('input[name=maketing]').val('N');
			$('.maketing_y').css('background-image',"url('/images/event/skin_attachment/modal_radio_off.png')");
		} else {
			$('input[name=maketing]').val('Y');
			$('.maketing_y').css('background-image',"url('/images/event/skin_attachment/modal_radio_on.png')");
		}
	});
});

function show_canvas(imgurl, ww, hh) {
	if (!is_canvas) {
		is_canvas = true;

		$('.canvas_bg_img').hide();
		$('#canvas').show();

		//canvas setting
		canvas = new fabric.Canvas('canvas', {
			width: $('.canvas_area').css('width').replace('px',''),
			height: $('.canvas_area').css('width').replace('px','')
		});
		canvas.setBackgroundColor('#ffffff');
	}

	canvas.remove(canvas.item(0));
	
	var cw = parseInt($('.canvas_area').css('width').replace('px',''));
	var ch = parseInt($('.canvas_area').css('height').replace('px',''));

	var _left = (cw - ww) / 2;
	var _top = (ch - hh) / 2;

	var _scale_y = 1;
	var _scale_x = 1;

	//가로가 세로보다 클 경우
	if(ww*1 > hh*1){
		_left = 0;
		_scale_x = cw / ww;
		_top = (ch - (hh * _scale_x)) / 2;
		_scale_y = _scale_x;
	//세로가 가로보다 클 경우
	}else if(hh*1 > ww*1){
		_top = 0;
		_scale_y = ch / hh;
		_left = (cw - (ww * _scale_y)) / 2;
		_scale_x = _scale_y;
	//정사각형 일 경우
	}else {
		_top = 0;
		_left = 0;
		_scale_y = ch / hh;
		_scale_x = _scale_y;
	}

	fabric.Image.fromURL(imgurl, function(img) {
		img.set({
			left: _left,
			top: _top,
			angle: 0,
			scaleX:_scale_x,
			scaleY:_scale_y,
			hasControls:true,
			hasRotatingPoint:true,
			borderColor: '#df3232',
			cornerColor: '#df3232',
			cornerSize:30,
			opacity: 1
		});

		img.setControlVisible('ml',false);
		img.setControlVisible('mt',false);
		img.setControlVisible('mr',false);
		img.setControlVisible('mb',false);
/*
		img.setControlVisible('tl',false);
		img.setControlVisible('tr',false);
		img.setControlVisible('bl',false);
		img.setControlVisible('br',false);
		img.setControlVisible('mtr',false);
*/

		canvas.add(img);
		canvas.setActiveObject(img);
	});

	canvas.on('mouse:down', function(options) {
		if (options.target) {
			obj = options.target;
			//console.log('an object was clicked! ', options.target);

			draw_icon(obj._element.src);
		}
	});

	canvas.on('selection:created', function(options) {
		if (options.target) {
			obj = options.target;
			//console.log('an object was clicked! ', options.target);

			draw_icon(obj._element.src);
		}
	});

	canvas.on('selection:updated', function(options) {
		if (options.target) {
			obj = options.target;
			//console.log('an object was clicked! ', options.target);

			draw_icon(obj._element.src);
		}
	});

	canvas.on('selection:cleared', function(options) {
	});
}

function draw_icon(_element_src){
	var img_url = _element_src.replace('http://','').replace('https://','');
	var draw_big_icon_no = img_url.substring(54,55);

	if (draw_big_icon_no == '1') {
		draw_big_icon_no = img_url.substring(54,56);
		if (draw_big_icon_no != '1.' && draw_big_icon_no != '1_') {
			draw_big_icon_no = img_url.substring(54,56);
		} else {
			draw_big_icon_no = img_url.substring(54,55);
		}
	}
}

var is_share_fb = false;
function sns_share_fb() {
	var link = encodeURIComponent('http://www.purecotton.co.kr/event/skin_attachment.asp?fromurl=fb&snsidx='+$("#sns_idx").val());
	window.open('https://www.facebook.com/dialog/feed?app_id=2485751364778408&display=popup&link='+link+'&redirect_uri=http://www.purecotton.co.kr/sns_share/call_back_fb.asp', 'relation', 'toolbar=no, scrollbars=yes, resizable=yes, width=550, height=400');

	is_share_fb = true;
	$('.modal_sns_fb').show();

//	FB.ui({
//		method: 'feed',
//		link: 'http://www.purecotton.co.kr/event/skin_attachment.asp?fromurl=fb&snsidx='+$("#sns_idx").val(),
//	}, function(response){
//		if (response && !response.error_message) {
//			$.ajax({
//				type : "GET",
//				url: '/event/skin_share_act.asp',
//				dataType: 'json',
//				data : {
//					'sns_type' : 'fb'
//				},
//				error: function(jqXHR, textStatus, errorThrown ){
//					alert("오류가 발생하였습니다. 새로고침(F5)후 다시 시도해주세요.");
//				},
//				beforeSend: function(){
//				},
//				success: function(rs, textStatus, jqXHR){
//					console.log(rs);
//					if (rs.rs == 'OK') {
//						alert('공유가 완료되었습니다.');
//					}
//				}
//			});
//		}
//	});
}

function sns_share_kt() {
	$.ajax({
		type : "GET",
		url: '/event/skin_share_act.asp',
		dataType: 'json',
		data : {
			'sns_type' : 'kt'
		},
		error: function(jqXHR, textStatus, errorThrown ){
			alert("오류가 발생하였습니다. 새로고침(F5)후 다시 시도해주세요.");
		},
		beforeSend: function(){
		},
		success: function(rs, textStatus, jqXHR){
			if (rs.rs == 'OK') {
				Kakao.Link.sendCustom({
					templateId: 17447,
					templateArgs: {
						'${subject}': '100% 유기농 건강한 순수한면! 구매인증하고 독일가자!',
						'${description}': '건강한 순수한면이 피부에 착! 붙는 이유를 새로워진 패키지에 나만의 스티커로 꾸며주세요. 추첨을 통해 독일 왕복 항공권 등 푸짐한 선물을 드립니다.',
						'${image}': 'http://www.purecotton.co.kr/upload/'+$("#feed_original").val(),
						'${mlink}': 'event/skin_attachment.asp?fromurl=kt'
					},
					success: function(obj) {
					},
					serverCallbackArgs: '{"idx":"'+rs.idx+'"}'
				});
			}
		}
	});
}

function show_make_feed(_page) {
	$.ajax({
		url: '/event/skin_get_attachment.asp?page='+_page,
		type : "GET",
		dataType: 'json',
		data : {
		},
		success: function(rs){
			var append = '';
			if (rs != 'Fail') {
				for (var i=0; i<rs.list.length; i++) {
					if (rs.list[i].feed_fb == '' || rs.list[i].feed_fb == undefined) {
						break;
					}
					append += '<li class="skin_attachment_feed_item"><img src="'+rs.list[i].feed_fb+'" /></li>';

					if (i==1) {
						break;
					}
				}

				$('.skin_attachment_feed_img').html(append);

				var page_append = '';

				if (rs.page > 5) {
					page_append += '<span class="pagebtn first" num = "1">.</span> ';
					page_append += '<span class="pagebtn prev" num="'+(rs.startpage-5)+'">.</span> ';
				}

				if (rs.page <= 5) {
					var s = 1;
				} else {
					var s=rs.startpage;
				}

				for (var a=s; a<=rs.endpage*1; a++) {
					if (a == rs.page) {
						page_append += '<span num="'+a+'" class="pagebtn on">'+a+'</span> ';
					} else {
						page_append += '<span num="'+a+'" class="pagebtn number">'+a+'</span> ';
					}
				}

				if (rs.endpage*1 < rs.maxpage*1) {
					page_append += '<span class="pagebtn next" num="'+(rs.endpage*1+1)+'">.</span> ';
					page_append += '<span class="pagebtn last" num="'+rs.maxpage+'">.</span> ';
				}

				$('.skin_attachment_feed_paging').html(page_append);
			} else {
			}
		},
		error: function(e){
			console.log(e);
		}
	});
}
function youtube_change(v){
	if(v == '1'){
		$("#youtube_frame").attr("src", "https://www.youtube.com/embed/WHPV3-DsBIM");
		$("#youtube1").addClass("youtube_on");
		$("#youtube2").removeClass("youtube_on");
	}else {
		$("#youtube_frame").attr("src", "https://www.youtube.com/embed/MRmd-d6vgv4");
		$("#youtube1").removeClass("youtube_on");
		$("#youtube2").addClass("youtube_on");

	}
}

function setCookie(name, value, expiredays)
{
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);
	document.cookie = name + "=" + escape(value) + "; path=/; domain=.purecotton.co.kr; expires=" + todayDate.toGMTString() + ";"
}

function getCookie(cName)
{
	cName = cName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cName);
	var cValue = '';

	if(start != -1) {
		start += cName.length;
		var end = cookieData.indexOf(';', start);

		if(end == -1)end = cookieData.length;
		cValue = cookieData.substring(start, end);
	}
	return unescape(cValue);
}
//-->
</script>
<style type="text/css">
div {box-sizing:border-box;}
img.imgMax {position:relative; width:100%;}
.mt-10 {margin-top:10vw;}
.mt-3 {margin-top:3vw;}
.mt-2 {margin-top:2vw;}
.mb-3 {margin-bottom:3vw;}

.skin_attach {position:relative; max-width:640px; width:100%; height:auto; margin:0 auto; text-align:center; background:url('/images/event/skin_attachment/skin_attachment_top_bg.jpg?s=1') top center no-repeat #eeebdf; background-size:100% auto; box-sizing:border-box;}
.youtube_frame {position:relative; width:80%; min-height:200px; margin:-370px auto 0; border:3px solid #fff; display:block;}
.select_product {position:relative;}
.select_product_item1 {position:absolute; bottom:0; left:8%; width:18%; height:30%; cursor:pointer;}
.select_product_item2 {position:absolute; bottom:0; left:26%; width:19%; height:30%; cursor:pointer;}
.select_product_item3 {position:absolute; bottom:0; left:45%; width:19%; height:30%; cursor:pointer;}
.select_product_item4 {position:absolute; bottom:0; left:67%; width:27%; height:30%; cursor:pointer;}

.canvas_sticker {position:relative; width:88%; height:auto; margin:0 auto; background:#f8f8f6;}
.canvas_area {position:relative; width:100%; overflow:hidden;}
#canvas_bg_click {position:absolute; bottom:0; left:0; width:100%; height:20%; cursor:pointer;}

#canvas {display:none;}
.sticker_area {padding:0; background:url('/images/event/skin_attachment/skin_attachment_sticker_bg.jpg?s=1') top center no-repeat; background-size:100% auto;}
.sticker_area .sticker_title {}
.sticker_area .sticker {width:90%; margin:1.5vw auto; padding-bottom:10vw;}
.sticker_area .sticker:after {content:''; display:block; clear:both;}
.sticker_area .sticker li {width:23%; margin-left:1%; display:inline-block;}
.sticker_area .sticker li img {cursor:pointer;}

.skin_attachment_bottom {position:relative;;}
.skin_attachment_bottom .skin_attachment_gift_info {position:absolute; top:18.7%; left:20%; width:33%; height:5%; cursor:pointer;}

.skin_attachment_feed {position:relative; width:100%; padding-top:9vw; background:url('/images/event/skin_attachment/skin_attachment_feed_bg.jpg?s=1') top center no-repeat; background-size:100% auto;}
.skin_attachment_feed .skin_attachment_feed_count {position:relative; width:100%; height:10vw; padding-left:26%; line-height:5vw; font-size:5vw; font-weight:bold; color:#564539; text-align:center;}

.skin_attachment_feed_img {width:100%; margin-top:20%; padding:0 5%; box-sizing:border-box;}
.skin_attachment_feed_img li {width:100%; margin-top:20px; text-align:center;}
.skin_attachment_feed_img li img {width:100%;}
.skin_attachment_feed_paging {position:relative; width:100%; margin-top:7vw; text-align:center;}
.skin_attachment_feed_paging .pagebtn {min-width:7vw; height:7vw; margin-right:4px; padding:5px; font-size:4vw; display:inline-block; line-height:5vw; cursor:pointer; box-sizing:border-box;}
.skin_attachment_feed_paging .pagebtn.first {background:url('/images/event/skin_attachment/paging_first.png') 0 0 no-repeat; text-indent:-9999px; background-size:100% auto;}
.skin_attachment_feed_paging .pagebtn.prev {background:url('/images/event/skin_attachment/paging_prev.png') 0 0 no-repeat; text-indent:-9999px; background-size:100% auto;}
.skin_attachment_feed_paging .pagebtn.next {background:url('/images/event/skin_attachment/paging_next.png') 0 0 no-repeat; text-indent:-9999px; background-size:100% auto;}
.skin_attachment_feed_paging .pagebtn.last {background:url('/images/event/skin_attachment/paging_last.png') 0 0 no-repeat; text-indent:-9999px; background-size:100% auto;}
.skin_attachment_feed_paging .pagebtn.on {border-radius:5px; font-size:4vw; font-weight:bold; color:#fff; text-align:center; background:#818181; text-decoration:underline;}
.skin_attachment_feed_paging .pagebtn.number {border-radius:5px; font-size:4vw; font-weight:bold; color:#fff; text-align:center; background:#818181;}

.footer {position:relative; margin-top:50px;}
.footer .footer_agree {position:absolute; bottom:10%; left:4%; width:29%; height:30%; cursor:pointer;}
.footer .footer_warning {position:absolute; bottom:10%; left:35%; width:29%; height:30%; cursor:pointer;}
.footer .footer_winner {position:absolute; bottom:10%; left:67%; width:29%; height:30%; cursor:pointer;}

.greyBackLoading {position:fixed; top:0;left:0;width:100%;height:100%;overflow:auto;z-index:9999;display:none;}
.greyBackLoading .loading_gif { position:absolute; top:50%; left:50%; margin:-64px 0 0 -64px;}

.grey_back { position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.4); z-index:997; display:none;}
.modal_event { position:absolute; top:0; left:0; width:100%; height:100%; z-index:999; display:none;}
.modal_event .modal_container { position:absolute; top:50px; width:95%; left:50%; transform:translateX(-50%); max-width:600px; margin:0 auto; display:none;}
.modal_event .modal_container .modal_close { position:absolute; top:0; right:0;  width:7%;}
.modal_event .modal_container .modal_contents { position:relative; margin-top:10%; background:#f7f7f7;}
.modal_event .modal_container .modal_form {margin-top:-1px; background:url('/images/event/skin_attachment/skin_info_back_bg.png?s=1') top center no-repeat; background-size:100% auto;}

.modal_event .modal_container .modal_name_area { position:relative; width:100%; height:9.3vw; margin:0; padding-left:30%; padding-right:5%; background:url('/images/event/skin_attachment/skin_info_02.png?s=1') top center no-repeat; background-size:100% auto; }
.modal_event .modal_container .modal_name_area input {position:relative; width:100%; height:100%; padding:0; padding-left:5%; text-align:left; color:#000; font-size:3.7vw; vertical-align:top; border:1px solid #acacac; background:#fff;}
.modal_event .modal_container .modal_phone_area {position:relative; width:100%; height:9.3vw; margin:0; padding-left:30%; padding-right:5%; background:url('/images/event/skin_attachment/skin_info_04.png?s=1') top center no-repeat; background-size:100% auto;}
.modal_event .modal_container .modal_phone_area select {position:relative; width:32%; height:100%; padding:0; line-height:normal; text-align-last:center; color:#000; font-size:3.7vw; border:1px solid #acacac; background-size:10%; background:#fff; vertical-align:top;}
.modal_event .modal_container .modal_phone_area select option {padding:0 10px;}
.modal_event .modal_container .modal_phone_area input {position:relative; width:32%; height:100%; padding:0; text-align:center; color:#000; font-size:3.7vw; border:1px solid #acacac; background:#fff;}
.modal_event .modal_container .modal_agree_area {position:relative; width:100%; height:auto; margin:0;}
.modal_event .modal_container .modal_agree_area .labels {position:absolute; top:15%; left:10%; width:90%; z-index:2;}
.modal_event .modal_container .modal_agree_area label {position:relative; width:auto; height:3.7vw; margin-right:10%; padding-left:4.5vw; line-height:3.7vw; font-size:3.7vw; color:#5b5b5b; background:url('/images/event/skin_attachment/modal_radio_off.png') top left no-repeat; background-size:auto 100%; display:inline-block; cursor:pointer;}
.modal_event .modal_container .modal_agree_area .modal_info_agree {position:absolute; top:0; left:0; width:100%; text-align:center; display:none; z-index:99999}
.modal_event .modal_container .modal_agree_area .modal_info_agree img {width:100%;}
.modal_event .modal_container .modal_agree_area .modal_info_agree .modal_info_agree_close {position:absolute; top:10px; right:10px; width:50px; height:50px; cursor:pointer;}
.modal_event .modal_container .modal_agree_area .modal_info_marketing {position:absolute; top:0; left:0; width:100%; text-align:center; display:none; z-index:99999}
.modal_event .modal_container .modal_agree_area .modal_info_marketing img {width:100%;}
.modal_event .modal_container .modal_agree_area .modal_info_marketing .modal_info_maketing_close {position:absolute; top:10px; right:10px; width:50px; height:50px; cursor:pointer;}
.modal_event .modal_container .modal_agree_plus {position:absolute; bottom:5%; right:7%; width:7%; height:40%; cursor:pointer;}
.modal_event .modal_container .modal_maketing_plus {position:absolute; bottom:5%; right:7%; width:7%; height:40%; cursor:pointer;}
.modal_event .modal_container .modal_btn_center {margin:8vw 0 0 0; text-align:center;}
#modal_info_next_btn {cursor:pointer;}

.modal_event .modal_container .sns_img {position:absolute; bottom:0; left:0; width:100%; height:auto; margin:0; padding:0 10%;}
.modal_event .modal_container .modal_sns_area {position:relative; width:100%; height:auto; margin:0; padding:0;}
.modal_event .modal_container .modal_sns_area .modal_sns_btns {position:absolute; top:0; left:10%; width:80%;}
.modal_event .modal_container .modal_sns_area .modal_sns_btns img {position:relative; width:17%; margin:0 1%; display:inline-block; cursor:pointer;}
.modal_event .modal_container .modal_sns_fb {position:relative; background:#e9eae0; display:none;}
.modal_event .modal_container .modal_sns_fb input {position:relative; width:90%; margin:0 auto; padding:1vw 3vw; font-size:3.7vw; color:#5c4f42; border:2px solid #5c4f42; border-radius:3vw; background:none; display:block;}

#modal_sns_complete_btn {cursor:pointer;}

@media screen and (min-width: 640px) {
	.modal_event .modal_container .modal_name_area { height:60px; }
	.modal_event .modal_container .modal_name_area input { height:60px; font-size:24px;}
	.modal_event .modal_container .modal_phone_area { height:60px; }
	.modal_event .modal_container .modal_phone_area select { height:60px; font-size:24px;}
	.modal_event .modal_container .modal_phone_area input { height:60px; font-size:24px;}
	.modal_event .modal_container .modal_agree_area {}
	.modal_event .modal_container .modal_agree_area label {height:24px; line-height:24px; font-size:24px;}
	.modal_event .modal_container .modal_btn_center {margin:40px 0 0 0;}
	.modal_event .modal_container .modal_sns_fb input {font-size:20px; padding:10px 30px; border-radius:30px;}

	.sticker_area .sticker {margin:25px auto; padding-bottom:30px;}

	.skin_attachment_feed {padding-top:55px;}
	.skin_attachment_feed .skin_attachment_feed_count {height:70px; line-height:30px; font-size:33px;}

	.skin_attachment_feed_paging {margin-top:50px;}
	.skin_attachment_feed_paging .pagebtn {min-width:50px; height:50px; margin-right:4px; padding:5px; font-size:25px; line-height:40px;}
	.skin_attachment_feed_paging .pagebtn.on {border-radius:5px; font-size:25px;}
	.skin_attachment_feed_paging .pagebtn.number {border-radius:5px; font-size:25px;}
}

.youtube_btns { text-align:center; padding:10px 0; position:relative; }
.youtube_btns .youtube_btn { display:inline-block; width:20px; height:20px; margin-left:5px; background:#ffffff; cursor:pointer; border-radius:50%; }
.youtube_btns .youtube_btn.youtube_on { background:#5c4f42; }
.youtube_btns .youtube_btn:first-child { margin-left:0; }
</style>

<div id="skipNav">
	<a href="#contents">본문 바로가기</a>
</div>

<div id="wrapper" class="fullpage_wrap">
	<div id="wrap">
		<!-- #include virtual = "/include/page_header.asp" -->

		<!-- container -->
		<div id="container">
			<!-- contents -->
			<div id="contents">
				<div style="position:relative;width:100%; max-width:640px; margin:0 auto;z-index:2;">
					<div style="position:absolute;top:0;left:0;width:100%; height:109px;background:url('http://www.womantable.com/_asset/img/purecotton/sample/sample_tab1.png') top center no-repeat; background-size:100% auto;">
						<a href="/event/skin_attachment.asp" target="_parent"><div style="position:absolute; top:0; left:0; width:33%; height:109px; box-sizing:border-box;"></div></a>
						<a href="/healthy.asp?page=sample"><div style="position:absolute; top:0; left:33%; width:33%; height:109px; box-sizing:border-box;"></div></a>
						<a href="/healthy.asp?page=review"><div style="position:absolute; top:0; left:66%; width:33%; height:109px; box-sizing:border-box;"></div></a>
					</div>
				</div>
				<div class="skin_attach">
					<img src="/images/event/skin_attachment/skin_attachment_top_img_b.jpg?s=1" class="imgMax" />
					<iframe id="youtube_frame" src="https://www.youtube.com/embed/WHPV3-DsBIM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" class="youtube_frame" allowfullscreen></iframe>
					<div class="youtube_btns">
						<span id="youtube1" class="youtube_btn youtube_on" onclick="javascript:youtube_change('1');"></span>
						<span id="youtube2" class="youtube_btn" onclick="javascript:youtube_change('2');"></span>
					</div>
					<img src="/images/event/skin_attachment/skin_attachment_top_text_b.png?s=1" class="imgMax mt-3" />
					<div class="select_product">
						<img src="/images/event/skin_attachment/skin_attachment_upload_photo_a.jpg?s=1" class="imgMax mt-2" />
						<div class="select_product_item1" id="select_product_item1"></div>
						<div class="select_product_item2"></div>
						<div class="select_product_item3"></div>
						<div class="select_product_item4"></div>
					</div>
					<div class="canvas_sticker">
						<div class="canvas_area">
							<div class="canvas_bg_img" style="background-color:#f8f8f6;">
								<img src="/images/event/skin_attachment/skin_attachment_canvas_bg_a.png?s=1" class="imgMax" />
								<div id="canvas_bg_click"></div>
							</div>
							<canvas id="canvas" class="canvas"></canvas>
						</div>
					</div>
					<div class="sticker_area">
						<div class="sticker_title">
							<img src="/images/event/skin_attachment/skin_attachment_sticker_top_img.jpg?s=1" class="imgMax" style="" />
						</div>
						<ul class="sticker">
							<li><img src="/images/event/skin_attachment/skin_sticker1.png?s=1" class="skin_sticker skin_sticker1 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker2.png?s=1" class="skin_sticker skin_sticker2 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker3.png?s=1" class="skin_sticker skin_sticker3 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker4.png?s=1" class="skin_sticker skin_sticker4 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker5.png?s=1" class="skin_sticker skin_sticker5 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker6.png?s=1" class="skin_sticker skin_sticker6 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker7.png?s=1" class="skin_sticker skin_sticker7 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker8.png?s=1" class="skin_sticker skin_sticker8 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker9.png?s=1" class="skin_sticker skin_sticker9 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker10.png?s=1" class="skin_sticker skin_sticker10 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker11.png?s=1" class="skin_sticker skin_sticker11 imgMax" /></li>
							<li><img src="/images/event/skin_attachment/skin_sticker12.png?s=1" class="skin_sticker skin_sticker12 imgMax" /></li>
						</ul>
					</div>

					<img src="/images/event/skin_attachment/skin_attachment_share_btn_a.jpg?s=2" class="imgMax" id="btn-start" style="cursor:pointer;" />
					<div class="skin_attachment_bottom">
						<img src="/images/event/skin_attachment/skin_attachment_bottom_bg_a.jpg?s=3" class="imgMax" />
						<div class="skin_attachment_gift_info"></div>
					</div>
					<div class="skin_attachment_feed">
						<div class="skin_attachment_feed_count"><%=totalCount%>명이</div>
						<ul class="skin_attachment_feed_img">
							<li class="skin_attachment_feed_item"></li>
							<li class="skin_attachment_feed_item"></li>
						</ul>
						<div class="skin_attachment_feed_paging"></div>
					</div>

					<div class="footer">
						<img src="/images/event/skin_attachment/skin_attachment_footer_bg.jpg?s=1" class="imgMax" />
						<div class="footer_agree" onClick="window.open('https://www.kleannara.com/privacy.asp');"></div>
						<div class="footer_warning"></div>
						<div class="footer_winner" onClick="window.open('http://www.purecotton.co.kr/event/skin_winner.asp');"></div>
					</div>
				</div>
			</div>
			<!--// contents -->
		</div>
		<!--// container -->
	</div>
</div>


<div class="greyBackLoading"><img src="/images/event/skin_attachment/loading.gif" class="loading_gif" /></div>
<div class="grey_back"></div>
<div class="modal_event">
	<input type="hidden" name="sns_idx" id="sns_idx" value="">
	<input type="hidden" name="feed_original" id="feed_original" value="">
	<div class="modal_container modal_info">
		<div class="modal_close">
			<img src="/images/event/skin_attachment/close.png" />
		</div>
		<div class="modal_contents">
			<img src="/images/event/skin_attachment/skin_info_01.png?s=1" class="imgMax" />
			<div class="modal_form">
				<form name="info_form" id="info_form" method="post" action="/event/skin_info_act.asp">
					<input type="hidden" name="canvas_img" value="">
					<input type="hidden" name="origin_img" value="">
					<input type="hidden" name="agree" value="" />
					<input type="hidden" name="maketing" value="N" />
					<div class="modal_name_area">
						<input type="text" name="name" value="" class="maxlength" maxlength="10" />
					</div>
					<img src="/images/event/skin_attachment/skin_info_03.png?s=1" class="imgMax" />
					<div class="modal_phone_area">
						<select name="hphone1" class="">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select>
						<input type="tel" name="hphone2" value="" class="onlynum maxlength" maxlength="4" />
						<input type="tel" name="hphone3" value="" class="onlynum maxlength" maxlength="4" />
					</div>
					<div class="modal_agree_area">
						<img src="/images/event/skin_attachment/skin_info_05.png?s=1" class="imgMax" />
						<div class="modal_agree_plus" /></div>
						<div class="modal_info_agree">
							<div class="modal_info_agree_close"></div>
							<img src="/images/event/skin_attachment/skin_info_agree_img.png" />
						</div>
					</div>
					<div class="modal_agree_area">
						<img src="/images/event/skin_attachment/skin_info_06.png?s=1" class="imgMax" />
						<div class="labels">
							<label for="agree_y" class="agree_y">동의</label>
							<label for="agree_n" class="agree_n">비동의</label>
						</div>
						<div class="modal_maketing_plus" /></div>
						<div class="modal_info_marketing">
							<div class="modal_info_maketing_close"></div>
							<img src="/images/event/skin_attachment/skin_info_maketing_img.png" />
						</div>
					</div>
					<div class="modal_agree_area">
						<img src="/images/event/skin_attachment/skin_info_07.png?s=1" class="imgMax" />
						<div class="labels">
							<label for="maketing_y" class="maketing_y">동의</label>
						</div>
					</div>
				</form>
				<img src="/images/event/skin_attachment/skin_info_08.png?s=1" id="modal_info_next_btn" class="imgMax" />
				<img src="/images/event/skin_attachment/skin_info_09.png?s=1" class="imgMax" />
			</div>
		</div>
	</div>

	<div class="modal_container modal_sns">
		<div class="modal_close">
			<img src="/images/event/skin_attachment/close.png" />
		</div>
		<div class="modal_contents">
			<div style="position:relative;">
				<img src="/images/event/skin_attachment/skin_sns_01.png?s=2" class="imgMax" />
				<div class="sns_img" id="snsimage"></div>
			</div>
			<div class="modal_form">
				<img src="/images/event/skin_attachment/skin_sns_02.png?s=1" class="imgMax" />
				<div class="modal_sns_area">
					<img src="/images/event/skin_attachment/skin_sns_03.png?s=1" class="imgMax" />
					<div class="modal_sns_btns">
						<img src="/images/event/skin_attachment/skin_sns_fb.png?s=1" class="sns_btn_fb" onClick="sns_share_fb();" />
						<img src="/images/event/skin_attachment/skin_sns_bg.png?s=1" class="sns_btn_bg" onClick="window.open('/sns_share/share.asp?sns_type=bg', 'relation', 'toolbar=no, scrollbars=yes, resizable=yes, width=550, height=400');" />
	<%
	If Session("OAUTH_TOKEN") = "" Then
	%>
						<img src="/images/event/skin_attachment/skin_sns_tw.png?s=1" class="sns_btn_tw" onClick="window.open('/twitterOAuth/twitter/authenticate.asp', 'relation', 'toolbar=no, scrollbars=yes, resizable=yes, width=550, height=400');" />
	<%
	Else 
	%>
						<img src="/images/event/skin_attachment/skin_sns_tw.png?s=1" class="sns_btn_tw" onClick="window.open('/sns_share/call_back_tw.asp', 'relation', 'toolbar=no, scrollbars=yes, resizable=yes, width=550, height=400');" />
	<%
	End If
	%>
						<img src="/images/event/skin_attachment/skin_sns_kt.png?s=1" class="sns_btn_kt" onClick="sns_share_kt();" />
						<img src="/images/event/skin_attachment/skin_sns_ks.png?s=1" class="sns_btn_ks" onClick="window.open('/sns_share/share.asp?sns_type=ks&redirect_uri=http://www.purecotton.co.kr/sns_share/call_back_ks.asp', 'relation', 'toolbar=no, scrollbars=yes, resizable=yes, width=550, height=400');" />
					</div>
				</div>
				<img src="/images/event/skin_attachment/skin_sns_04.png?s=1" class="imgMax" />
				<div class="modal_sns_fb">
					<img src="/images/event/skin_attachment/skin_sns_fb_01.png?s=1" class="imgMax" />
					<input type="text" name="sns_fb_value" value="" placeholder="https://www.facebook.com/" />
					<img src="/images/event/skin_attachment/skin_sns_fb_02.png?s=1" class="imgMax" />
				</div>
				<img src="/images/event/skin_attachment/skin_sns_05.png?s=1" id="modal_sns_complete_btn" class="imgMax" />
			</div>
			<img src="/images/event/skin_attachment/skin_sns_06.png?s=1" />
		</div>
	</div>
	<div class="modal_container modal_gift_warning">
		<div class="modal_close">
			<img src="/images/event/skin_attachment/close.png" />
		</div>
		<div class="modal_contents">
			<img src="/images/event/skin_attachment/skin_gift_warning.png?s=1" />
		</div>
	</div>
	<div class="modal_container modal_join_warning">
		<div class="modal_close">
			<img src="/images/event/skin_attachment/close.png" />
		</div>
		<div class="modal_contents">
			<img src="/images/event/skin_attachment/skin_join_warning_a.png?s=1" />
		</div>
	</div>
</div>

<form name="myform" id="myform" method="post" action="/event/skin_imgupload.asp" enctype="multipart/form-data" style="display:none; width:1px; height:1px; overflow:hidden;"">
	<input type="file" name="upload_img" value="" style="width:0;height:0;"/>
	<img id="upload_image" src="">
</form>


</body>
</html>