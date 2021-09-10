<%
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
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-122305070-1"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());

	  gtag('config', 'UA-122305070-1');
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
$(document).ready(function() {
	Kakao.init('c496cfa2e274b61ba5e1a7e6725f85a0');

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

//-->
</script>
<style type="text/css">
div {box-sizing:border-box;}
img.imgMax {position:relative; width:100%;}
.mt-10 {margin-top:10vw;}
.mt-3 {margin-top:3vw;}
.mt-2 {margin-top:2vw;}
.mb-3 {margin-bottom:3vw;}
.tc {text-align:center;}

.winner {max-width:640px; width:100%; height:auto; margin:0 auto;}
.winner table {width:100%; margin-top:30px; border:1px solid grey;}
.winner table th {padding:10px; border:1px solid grey; color:#000; font-weight:bold;}
.winner table td {padding:7px 10px; border:1px solid grey;}

.greyBackLoading {position:fixed; top:0;left:0;width:100%;height:100%;overflow:auto;z-index:9999;display:none;}
.greyBackLoading .loading_gif { position:absolute; top:50%; left:50%; margin:-64px 0 0 -64px;}

.grey_back { position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.4); z-index:997; display:none;}
.modal_event { position:absolute; top:0; left:0; width:100%; height:100%; z-index:999; display:none;}
.modal_event .modal_container { position:absolute; top:50px; width:95%; left:50%; transform:translateX(-50%); max-width:600px; margin:0 auto; display:none;}
.modal_event .modal_container .modal_close { position:absolute; top:0; right:0;  width:7%; cursor:pointer;}
.modal_event .modal_container .modal_contents { position:relative; margin-top:10%; background:#f7f7f7;}

.modal_contents {padding:20px; color:#000; line-height:23px; text-align:center;}
.modal_contents .sub_title {font-size:18px; margin-top:40px; margin-bottom:20px; line-height:25px; font-weight:bold;}
.modal_contents table {width:70%; margin:0 auto; border:1px solid grey;}
.modal_contents table th {padding:5px 10px; border:1px solid grey;}
.modal_contents table td {padding:5px 10px; text-align:center; border:1px solid grey;}
</style>
<script type="text/javascript">
<!--
function open_view(_no) {
	$('.grey_back').show();
	$('.modal_event').show();
	$('.modal_view_'+_no).show().css('top', $(document).scrollTop() + 50);
}

function close_view() {
	$('.grey_back').hide();
	$('.modal_event').hide();
	$('.modal_view').hide();
}
//-->
</script>
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
				<div class="winner">
					<img src="/images/event/skin_attachment/winner_top_banner.png" class="imgMax" />

					<table>
						<colgroup>
							<col width="10%" />
							<col width="" />
							<col width="20%" />
						</colgroup>
						<tr>
							<th>No.</th>
							<th>제목</th>
							<th>작성일</th>
						</tr>
						<tr>
							<td class="tc">5</td>
							<td><div onClick="open_view(5);" style="cursor:pointer;">건강한 순수한면 사용후기 당첨자 발표</div></td>
							<td class="tc">2020.03.06</td>
						</tr>
						<tr>
							<td class="tc">4</td>
							<td><div onClick="open_view(4);" style="cursor:pointer;">건강한 순수한면 1만명 샘플링 2차 설문 피드백 당첨자 발표</div></td>
							<td class="tc">2020.03.06</td>
						</tr>
						<tr>
							<td class="tc">3</td>
							<td><div onClick="open_view(3);" style="cursor:pointer;">건강한 순수한면 1만명 샘플링 1차 설문 피드백 당첨자 발표</div></td>
							<td class="tc">2020.02.17</td>
						</tr>
						<tr>
							<td class="tc">2</td>
							<td><div onClick="open_view(2);" style="cursor:pointer;">건강한 순수한면 피부애착 프로젝트 2차 당첨자 발표</div></td>
							<td class="tc">2019.10.31</td>
						</tr>
						<tr>
							<td class="tc">1</td>
							<td><div onClick="open_view(1);" style="cursor:pointer;">건강한 순수한면 피부애착 프로젝트 1차 당첨자 발표</div></td>
							<td class="tc">2019.09.29</td>
						</tr>
					</table>
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
	<div class="modal_container modal_view modal_view_1">
		<div class="modal_close" onClick="close_view();">
			<img src="/images/event/skin_attachment/close.png" />
		</div>
		<div class="modal_contents">
			<div class="sub_title">건강한 순수한면 피부애착 프로젝트 1차 당첨자 발표</div>
			[건강한 순수한면 피부애착 프로젝트]에<br />
			참여해주신 모든 분들께 감사 드립니다.<br /><br />
			나만의 스티커로 100% 유기농 생리대를 표현 해주신 50명<br />
			100% 유기농 생리대를 표현하고 SNS에 공유해주신 10명<br />
			총 60명이 추첨을 통해 선정되었습니다.<br /><br />
			앞으로도 여러분의 많은 관심과 참여 부탁 드리며,<br />
			건강한 순수한면 피부애착 프로젝트 1차 당첨자를 발표하겠습니다.<br /><br />
			선정되신 당첨자 모두 진심으로 축하 드립니다.<br /><br />
			<div class="sub_title">[100% 유기농상 : 건강한 순수한면 1년치 사용분 (대형/중형/소형)]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr>
					<td>1</td><td>구*화</td><td>010-****-6436</td>
				</tr>
				<tr>
					<td>2</td><td>김*순</td><td>010-****-2617</td>
				</tr>
				<tr>
					<td>3</td><td>김*진</td><td>010-****-0867</td>
				</tr>
				<tr>
					<td>4</td><td>박*실</td><td>010-****-0378</td>
				</tr>
				<tr>
					<td>5</td><td>손*옥</td><td>010-****-3452</td>
				</tr>
				<tr>
					<td>6</td><td>이*선</td><td>010-****-9299</td>
				</tr>
				<tr>
					<td>7</td><td>이*연</td><td>010-****-9239</td>
				</tr>
				<tr>
					<td>8</td><td>이*미</td><td>010-****-1003</td>
				</tr>
				<tr>
					<td>9</td><td>임*미</td><td>010-****-2486</td>
				</tr>
				<tr>
					<td>10</td><td>한*수</td><td>010-****-8827</td>
				</tr>
			</table>
			<div class="sub_title">[건강한 순수한면 상 : 건강한 순수한면 모바일 교환권 중형 2팩 ]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr>
					<td>1</td><td>권*은</td><td>010-****-7017</td>
				</tr>
				<tr>
					<td>2</td><td>금*슬</td><td>010-****-1197</td>
				</tr>
				<tr>
					<td>3</td><td>김*자</td><td>010-****-4023</td>
				</tr>
				<tr>
					<td>4</td><td>김*진</td><td>010-****-7298</td>
				</tr>
				<tr>
					<td>5</td><td>김*나</td><td>010-****-6378</td>
				</tr>
				<tr>
					<td>6</td><td>김*경</td><td>010-****-7736</td>
				</tr>
				<tr>
					<td>7</td><td>김*선</td><td>010-****-8880</td>
				</tr>
				<tr>
					<td>8</td><td>김*은</td><td>010-****-0548</td>
				</tr>
				<tr>
					<td>9</td><td>김*연</td><td>010-****-3330</td>
				</tr>
				<tr>
					<td>10</td><td>김*미</td><td>010-****-9922</td>
				</tr>
				<tr>
					<td>11</td><td>김*은</td><td>010-****-3912</td>
				</tr>
				<tr>
					<td>12</td><td>김*정</td><td>010-****-6667</td>
				</tr>
				<tr>
					<td>13</td><td>문*민</td><td>010-****-2871</td>
				</tr>
				<tr>
					<td>14</td><td>민*림</td><td>010-****-3452</td>
				</tr>
				<tr>
					<td>15</td><td>박*름</td><td>010-****-5389</td>
				</tr>
				<tr>
					<td>16</td><td>박*희</td><td>010-****-1478</td>
				</tr>
				<tr>
					<td>17</td><td>박*진</td><td>010-****-4587</td>
				</tr>
				<tr>
					<td>18</td><td>박*연</td><td>010-****-0134</td>
				</tr>
				<tr>
					<td>19</td><td>백*경</td><td>010-****-7350</td>
				</tr>
				<tr>
					<td>20</td><td>변*희</td><td>010-****-1518</td>
				</tr>
				<tr>
					<td>21</td><td>서*성</td><td>010-****-7496</td>
				</tr>
				<tr>
					<td>22</td><td>서*연</td><td>010-****-8302</td>
				</tr>
				<tr>
					<td>23</td><td>성*린</td><td>010-****-4087</td>
				</tr>
				<tr>
					<td>24</td><td>신*남</td><td>010-****-7619</td>
				</tr>
				<tr>
					<td>25</td><td>신*희</td><td>010-****-0399</td>
				</tr>
				<tr>
					<td>26</td><td>양*천</td><td>010-****-8408</td>
				</tr>
				<tr>
					<td>27</td><td>오*경</td><td>010-****-4766</td>
				</tr>
				<tr>
					<td>28</td><td>윤*미</td><td>010-****-4109</td>
				</tr>
				<tr>
					<td>29</td><td>이*진</td><td>010-****-0466</td>
				</tr>
				<tr>
					<td>30</td><td>이*현</td><td>010-****-0164</td>
				</tr>
				<tr>
					<td>31</td><td>이*영</td><td>010-****-8283</td>
				</tr>
				<tr>
					<td>32</td><td>이*아</td><td>010-****-0718</td>
				</tr>
				<tr>
					<td>33</td><td>이*미</td><td>010-****-0841</td>
				</tr>
				<tr>
					<td>34</td><td>이*은</td><td>010-****-6387</td>
				</tr>
				<tr>
					<td>35</td><td>이*진</td><td>010-****-8826</td>
				</tr>
				<tr>
					<td>36</td><td>임*성</td><td>010-****-6123</td>
				</tr>
				<tr>
					<td>37</td><td>임*주</td><td>010-****-9230</td>
				</tr>
				<tr>
					<td>38</td><td>장*영</td><td>010-****-4528</td>
				</tr>
				<tr>
					<td>39</td><td>정*주</td><td>010-****-2169</td>
				</tr>
				<tr>
					<td>40</td><td>정*영</td><td>010-****-0058</td>
				</tr>
				<tr>
					<td>41</td><td>정*영</td><td>010-****-7666</td>
				</tr>
				<tr>
					<td>42</td><td>차*숙</td><td>010-****-3581</td>
				</tr>
				<tr>
					<td>43</td><td>채*주</td><td>010-****-7238</td>
				</tr>
				<tr>
					<td>44</td><td>최*자</td><td>010-****-8072</td>
				</tr>
				<tr>
					<td>45</td><td>최*선</td><td>010-****-9371</td>
				</tr>
				<tr>
					<td>46</td><td>최*선</td><td>010-****-6661</td>
				</tr>
				<tr>
					<td>47</td><td>하*경</td><td>010-****-6752</td>
				</tr>
				<tr>
					<td>48</td><td>한*규</td><td>010-****-0444</td>
				</tr>
				<tr>
					<td>49</td><td>현*정</td><td>010-****-9285</td>
				</tr>
				<tr>
					<td>50</td><td>홍*주</td><td>010-****-8629</td>
				</tr>
			</table>
			<div class="sub_title">감사합니다.</div>
		</div>
	</div>
	<div class="modal_container modal_view modal_view_2">
		<div class="modal_close" onClick="close_view();">
			<img src="/images/event/skin_attachment/close.png" />
		</div>
		<div class="modal_contents">
			<div class="sub_title">건강한 순수한면 피부애착 프로젝트 2차 당첨자 발표</div>
			안녕하세요.<br />
			건강한 순수한면 피부애착 프로젝트 담당자입니다.<br /><br />
			여러분의 많은 관심과 참여에 감사드리며,<br />
			건강한 순수한면 피부애착 프로젝트 최종 당첨자를 발표하겠습니다.<br /><br />
			아래에서 당첨정보를 확인해주시기 바랍니다<br />
			(PC이용시, Ctrl+F를 누르고 휴대폰 뒷번호를 검색하면 편리합니다.)<br /><br />
			선정되신 분들 모두 진심으로 축하 드립니다.<br /><br />
			<div class="sub_title">[피부애착상 : 독일 왕복 항공권]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr>
					<td>1</td><td>권*경</td><td>010-****-4084</td>
				</tr>
			</table>
			<div class="sub_title">[100% 유기농상 : 건강한 순수한면 1년치 사용분 (대형/중형/소형)]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr><td>1</td><td>권*소</td><td>010-****-3122</td></tr>
				<tr><td>2</td><td>금*연</td><td>010-****-9973</td></tr>
				<tr><td>3</td><td>김*율</td><td>010-****-9077</td></tr>
				<tr><td>4</td><td>김*정</td><td>010-****-5566</td></tr>
				<tr><td>5</td><td>김*혜</td><td>010-****-4342</td></tr>
				<tr><td>6</td><td>안*임</td><td>010-****-6567</td></tr>
				<tr><td>7</td><td>원*순</td><td>010-****-3745</td></tr>
				<tr><td>8</td><td>이*성</td><td>010-****-0460</td></tr>
				<tr><td>9</td><td>정*정</td><td>010-****-2932</td></tr>
				<tr><td>10</td><td>한*경</td><td>010-****-1193</td></tr>
			</table>
			<div class="sub_title">[건강한 순수한면 상 : 건강한 순수한면 모바일 교환권 중형 2팩 ]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr><td>1</td><td>강*연</td><td>010-****-4724</td></tr>
				<tr><td>2</td><td>김*미</td><td>010-****-2142</td></tr>
				<tr><td>3</td><td>김*중</td><td>010-****-8493</td></tr>
				<tr><td>4</td><td>김*주</td><td>010-****-0242</td></tr>
				<tr><td>5</td><td>김*은</td><td>010-****-0548</td></tr>
				<tr><td>6</td><td>김*연</td><td>010-****-4432</td></tr>
				<tr><td>7</td><td>김*희</td><td>010-****-9585</td></tr>
				<tr><td>8</td><td>김*인</td><td>010-****-2535</td></tr>
				<tr><td>9</td><td>김*자</td><td>010-****-4433</td></tr>
				<tr><td>10</td><td>김*미</td><td>010-****-4280</td></tr>
				<tr><td>11</td><td>김*숙</td><td>010-****-0152</td></tr>
				<tr><td>12</td><td>김*혜</td><td>010-****-3778</td></tr>
				<tr><td>13</td><td>김*현</td><td>010-****-4432</td></tr>
				<tr><td>14</td><td>김*원</td><td>010-****-2479</td></tr>
				<tr><td>15</td><td>김*미</td><td>010-****-4661</td></tr>
				<tr><td>16</td><td>김*경</td><td>010-****-4776</td></tr>
				<tr><td>17</td><td>김*란</td><td>010-****-5946</td></tr>
				<tr><td>18</td><td>김*진</td><td>010-****-5902</td></tr>
				<tr><td>19</td><td>김*정</td><td>010-****-8493</td></tr>
				<tr><td>20</td><td>김*진</td><td>010-****-0926</td></tr>
				<tr><td>21</td><td>노*희</td><td>010-****-1365</td></tr>
				<tr><td>22</td><td>라*린</td><td>010-****-4150</td></tr>
				<tr><td>23</td><td>마*진</td><td>010-****-3375</td></tr>
				<tr><td>24</td><td>문*수</td><td>010-****-0339</td></tr>
				<tr><td>25</td><td>박*란</td><td>010-****-5909</td></tr>
				<tr><td>26</td><td>박*리</td><td>010-****-0548</td></tr>
				<tr><td>27</td><td>박*순</td><td>010-****-4268</td></tr>
				<tr><td>28</td><td>박*미</td><td>010-****-3546</td></tr>
				<tr><td>29</td><td>박*영</td><td>010-****-0312</td></tr>
				<tr><td>30</td><td>배*은</td><td>010-****-0953</td></tr>
				<tr><td>31</td><td>백*숙</td><td>010-****-0222</td></tr>
				<tr><td>32</td><td>백*선</td><td>010-****-0288</td></tr>
				<tr><td>33</td><td>신*영</td><td>010-****-9371</td></tr>
				<tr><td>34</td><td>안*영</td><td>010-****-9669</td></tr>
				<tr><td>35</td><td>오*아</td><td>010-****-8105</td></tr>
				<tr><td>36</td><td>유*화</td><td>010-****-2191</td></tr>
				<tr><td>37</td><td>이*성</td><td>010-****-7384</td></tr>
				<tr><td>38</td><td>이*영</td><td>010-****-4412</td></tr>
				<tr><td>39</td><td>이*선</td><td>010-****-1860</td></tr>
				<tr><td>40</td><td>이*경</td><td>010-****-1476</td></tr>
				<tr><td>41</td><td>이*애</td><td>010-****-9335</td></tr>
				<tr><td>42</td><td>이*숙</td><td>010-****-2300</td></tr>
				<tr><td>43</td><td>임*정</td><td>010-****-1249</td></tr>
				<tr><td>44</td><td>장*희</td><td>010-****-3560</td></tr>
				<tr><td>45</td><td>장*숙</td><td>010-****-9753</td></tr>
				<tr><td>46</td><td>조*화</td><td>010-****-0189</td></tr>
				<tr><td>47</td><td>조*정</td><td>010-****-0363</td></tr>
				<tr><td>48</td><td>채*우</td><td>010-****-0905</td></tr>
				<tr><td>49</td><td>최*미</td><td>010-****-8338</td></tr>
				<tr><td>50</td><td>홍*수</td><td>010-****-8237</td></tr>
			</table>
			<div class="sub_title">감사합니다.</div>
		</div>
	</div>
	<div class="modal_container modal_view modal_view_3">
		<div class="modal_close" onClick="close_view();">
			<img src="/images/event/skin_attachment/close.png" />
		</div>
		<div class="modal_contents">
			<div class="sub_title">건강한 순수한면 1만명 샘플링 1차 설문 피드백 당첨자 발표</div>
			안녕하세요.<br />
			건강한 순수한면 1만명 샘플링 담당자입니다.<br /><br />
			건강한 순수한면에 대한 생각을 들려주신 모든 분들께 감사합니다.<br /><br />
			설문피드백 참여자 100명<br />
			우수스토리를 들려준 참여자 10명<br />
			총 110명이 추첨을 통해 선정되었습니다.<br /><br />
			앞으로도 여러분의 많은 관심과 참여 부탁드리며,<br />
			건강한 순수한면 설문 피드백 당첨자를 발표하겠습니다.<br /><br />
			아래에서 당첨정보를 확인해주시기 바랍니다<br />
			(PC이용시, Ctrl+F를 누르고 휴대폰 뒷번호를 검색하면 편리합니다.)<br /><br />
			선정되신 분들 모두 진심으로 축하 드립니다.
			<div class="sub_title">[우수스토리 경품 : 건강한 순수한면 선물세트(대형1팩/중형3팩)]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr>
					<td>1</td><td>김*영</td><td>010-****-5341</td>
				</tr>
				<tr>
					<td>2</td><td>김*지</td><td>010-****-9440</td>
				</tr>
				<tr>
					<td>3</td><td>김*원</td><td>010-****-8993</td>
				</tr>
				<tr>
					<td>4</td><td>성*아</td><td>010-****-2628</td>
				</tr>
				<tr>
					<td>5</td><td>손*희</td><td>010-****-0187</td>
				</tr>
				<tr>
					<td>6</td><td>오*주</td><td>010-****-6368</td>
				</tr>
				<tr>
					<td>7</td><td>이*아</td><td>010-****-9298</td>
				</tr>
				<tr>
					<td>8</td><td>이*현</td><td>010-****-4687</td>
				</tr>
				<tr>
					<td>9</td><td>정*옥</td><td>010-****-0154</td>
				</tr>
				<tr>
					<td>10</td><td>최*숙</td><td>010-****-5720</td>
				</tr>
			</table>
			<div class="sub_title">[설문피드백 경품 : 스타벅스 아메리카노 모바일 교환권]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr><td>1</td><td>가*</td><td>010-****-7073</td></tr>
				<tr><td>2</td><td>강*운</td><td>010-****-8041</td></tr>
				<tr><td>3</td><td>김*은</td><td>010-****-3168</td></tr>
				<tr><td>4</td><td>김*희</td><td>010-****-0055</td></tr>
				<tr><td>5</td><td>김*희</td><td>010-****-7397</td></tr>
				<tr><td>6</td><td>김*미</td><td>010-****-2339</td></tr>
				<tr><td>7</td><td>김*영</td><td>010-****-2137</td></tr>
				<tr><td>8</td><td>김*진</td><td>010-****-8930</td></tr>
				<tr><td>9</td><td>김*경</td><td>010-****-0239</td></tr>
				<tr><td>10</td><td>김*솔</td><td>010-****-1949</td></tr>
				<tr><td>11</td><td>김*정</td><td>010-****-3821</td></tr>
				<tr><td>12</td><td>김*지</td><td>010-****-0123</td></tr>
				<tr><td>13</td><td>김*이</td><td>010-****-4998</td></tr>
				<tr><td>14</td><td>김*희</td><td>010-****-1146</td></tr>
				<tr><td>15</td><td>김*정</td><td>010-****-3777</td></tr>
				<tr><td>16</td><td>김*라</td><td>010-****-0401</td></tr>
				<tr><td>17</td><td>김*순</td><td>010-****-8145</td></tr>
				<tr><td>18</td><td>김*정</td><td>010-****-5332</td></tr>
				<tr><td>19</td><td>김*연</td><td>010-****-8703</td></tr>
				<tr><td>20</td><td>김*인</td><td>010-****-9502</td></tr>
				<tr><td>21</td><td>김*현</td><td>010-****-2899</td></tr>
				<tr><td>22</td><td>김*혜</td><td>010-****-1549</td></tr>
				<tr><td>23</td><td>김*희</td><td>010-****-2335</td></tr>
				<tr><td>24</td><td>김*빈</td><td>010-****-9389</td></tr>
				<tr><td>25</td><td>나*경</td><td>010-****-9922</td></tr>
				<tr><td>26</td><td>노*진</td><td>010-****-4263</td></tr>
				<tr><td>27</td><td>류*라</td><td>010-****-2569</td></tr>
				<tr><td>28</td><td>문*영</td><td>010-****-9566</td></tr>
				<tr><td>29</td><td>문*선</td><td>010-****-0491</td></tr>
				<tr><td>30</td><td>박*란</td><td>010-****-7259</td></tr>
				<tr><td>31</td><td>박*연</td><td>010-****-5079</td></tr>
				<tr><td>32</td><td>박*현</td><td>010-****-0968</td></tr>
				<tr><td>33</td><td>박*현</td><td>010-****-0823</td></tr>
				<tr><td>34</td><td>박*순</td><td>010-****-5632</td></tr>
				<tr><td>35</td><td>박*은</td><td>010-****-6307</td></tr>
				<tr><td>36</td><td>박*영</td><td>010-****-9022</td></tr>
				<tr><td>37</td><td>박*민</td><td>010-****-8821</td></tr>
				<tr><td>38</td><td>박*영</td><td>010-****-3764</td></tr>
				<tr><td>39</td><td>박*윤</td><td>010-****-9025</td></tr>
				<tr><td>40</td><td>박*미</td><td>010-****-5078</td></tr>
				<tr><td>41</td><td>박*경</td><td>010-****-4747</td></tr>
				<tr><td>42</td><td>배*미</td><td>010-****-2847</td></tr>
				<tr><td>43</td><td>배*석</td><td>010-****-5258</td></tr>
				<tr><td>44</td><td>백*희</td><td>010-****-1583</td></tr>
				<tr><td>45</td><td>설*미</td><td>010-****-0985</td></tr>
				<tr><td>46</td><td>손*아</td><td>010-****-5055</td></tr>
				<tr><td>47</td><td>신*영</td><td>010-****-0528</td></tr>
				<tr><td>48</td><td>신*희</td><td>010-****-2219</td></tr>
				<tr><td>49</td><td>안*리</td><td>010-****-5572</td></tr>
				<tr><td>50</td><td>안*경</td><td>010-****-5721</td></tr>
				<tr><td>51</td><td>안*란</td><td>010-****-1450</td></tr>
				<tr><td>52</td><td>양*혜</td><td>010-****-4929</td></tr>
				<tr><td>53</td><td>엄*정</td><td>010-****-0070</td></tr>
				<tr><td>54</td><td>오*예</td><td>010-****-9907</td></tr>
				<tr><td>55</td><td>유*숙</td><td>010-****-0847</td></tr>
				<tr><td>56</td><td>유*나</td><td>010-****-9727</td></tr>
				<tr><td>57</td><td>육*숙</td><td>010-****-7682</td></tr>
				<tr><td>58</td><td>윤*영</td><td>010-****-7376</td></tr>
				<tr><td>59</td><td>윤*원</td><td>010-****-5225</td></tr>
				<tr><td>60</td><td>이*나</td><td>010-****-2314</td></tr>
				<tr><td>61</td><td>이*정</td><td>010-****-8433</td></tr>
				<tr><td>62</td><td>이*경</td><td>010-****-1353</td></tr>
				<tr><td>63</td><td>이*은</td><td>010-****-4819</td></tr>
				<tr><td>64</td><td>이*은</td><td>010-****-1886</td></tr>
				<tr><td>65</td><td>이*혜</td><td>010-****-1405</td></tr>
				<tr><td>66</td><td>이*지</td><td>010-****-2300</td></tr>
				<tr><td>67</td><td>이*주</td><td>010-****-3162</td></tr>
				<tr><td>68</td><td>이*은</td><td>010-****-6654</td></tr>
				<tr><td>69</td><td>이*은</td><td>010-****-1383</td></tr>
				<tr><td>70</td><td>이*리</td><td>010-****-7703</td></tr>
				<tr><td>71</td><td>임*애</td><td>010-****-6676</td></tr>
				<tr><td>72</td><td>장*영</td><td>010-****-6854</td></tr>
				<tr><td>73</td><td>전*주</td><td>010-****-3321</td></tr>
				<tr><td>74</td><td>전*령</td><td>010-****-5175</td></tr>
				<tr><td>75</td><td>전*재</td><td>010-****-0631</td></tr>
				<tr><td>76</td><td>정*선</td><td>010-****-2434</td></tr>
				<tr><td>77</td><td>정*진</td><td>010-****-1494</td></tr>
				<tr><td>78</td><td>정*진</td><td>010-****-2793</td></tr>
				<tr><td>79</td><td>조*민</td><td>010-****-0331</td></tr>
				<tr><td>80</td><td>조*영</td><td>010-****-9514</td></tr>
				<tr><td>81</td><td>조*연</td><td>010-****-8469</td></tr>
				<tr><td>82</td><td>조*성</td><td>010-****-6696</td></tr>
				<tr><td>83</td><td>조*정</td><td>010-****-0105</td></tr>
				<tr><td>84</td><td>주*정</td><td>010-****-5235</td></tr>
				<tr><td>85</td><td>지*성</td><td>010-****-5693</td></tr>
				<tr><td>86</td><td>지*진</td><td>010-****-8491</td></tr>
				<tr><td>87</td><td>진*정</td><td>010-****-7845</td></tr>
				<tr><td>88</td><td>진*원</td><td>010-****-2239</td></tr>
				<tr><td>89</td><td>채*진</td><td>010-****-9161</td></tr>
				<tr><td>90</td><td>최*영</td><td>010-****-4534</td></tr>
				<tr><td>91</td><td>최*실</td><td>010-****-1443</td></tr>
				<tr><td>92</td><td>최*정</td><td>010-****-3693</td></tr>
				<tr><td>93</td><td>최*혜</td><td>010-****-2837</td></tr>
				<tr><td>94</td><td>최*현</td><td>010-****-0628</td></tr>
				<tr><td>95</td><td>한*연</td><td>010-****-0838</td></tr>
				<tr><td>96</td><td>허*예</td><td>010-****-5096</td></tr>
				<tr><td>97</td><td>홍*연</td><td>010-****-8713</td></tr>
				<tr><td>98</td><td>홍*순</td><td>010-****-7784</td></tr>
				<tr><td>99</td><td>황*량</td><td>010-****-6945</td></tr>
				<tr><td>100</td><td>황*리</td><td>010-****-8458</td></tr>
			</table>
			<div class="sub_title">감사합니다.</div>
		</div>
	</div>
	<div class="modal_container modal_view modal_view_4">
		<div class="modal_close" onClick="close_view();">
			<img src="/images/event/skin_attachment/close.png" />
		</div>
		<div class="modal_contents">
			<div class="sub_title">건강한 순수한면 1만명 샘플링 2차 설문 피드백 당첨자 발표</div>
			안녕하세요.<br />
			건강한 순수한면 1만명 샘플링 담당자입니다.<br /><br />
			건강한 순수한면에 대한 생각을 들려주신 모든 분들께 감사합니다.<br /><br />
			설문피드백 참여자 100명<br />
			우수스토리를 들려준 참여자 10명<br />
			총 110명이 추첨을 통해 선정되었습니다.<br /><br />
			앞으로도 여러분의 많은 관심과 참여 부탁드리며,<br />
			건강한 순수한면 설문 피드백 당첨자를 발표하겠습니다.<br /><br />
			아래에서 당첨정보를 확인해주시기 바랍니다<br />
			(PC이용시, Ctrl+F를 누르고 휴대폰 뒷번호를 검색하면 편리합니다.)<br /><br />
			선정되신 분들 모두 진심으로 축하 드립니다.
			<div class="sub_title">[우수스토리 경품 : 건강한 순수한면 선물세트(대형1팩/중형3팩)]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr><td>1</td><td>김*지</td><td>010-****-4682</td></tr>
				<tr><td>2</td><td>김*재</td><td>010-****-1217</td></tr>
				<tr><td>3</td><td>김*지</td><td>010-****-9064</td></tr>
				<tr><td>4</td><td>배*숙</td><td>010-****-8515</td></tr>
				<tr><td>5</td><td>변*연</td><td>010-****-8087</td></tr>
				<tr><td>6</td><td>연*</td><td>010-****-2581</td></tr>
				<tr><td>7</td><td>장*주</td><td>010-****-5686</td></tr>
				<tr><td>8</td><td>정*규</td><td>010-****-3566</td></tr>
				<tr><td>9</td><td>조*민</td><td>010-****-1090</td></tr>
				<tr><td>10</td><td>채*하</td><td>010-****-2081</td></tr>
			</table>
			<div class="sub_title">[설문피드백 경품 : 스타벅스 아메리카노 모바일 교환권]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr><td>1</td><td>강*정</td><td>010-****-0001</td></tr>
				<tr><td>2</td><td>고*지</td><td>010-****-7561</td></tr>
				<tr><td>3</td><td>곽*리</td><td>010-****-1486</td></tr>
				<tr><td>4</td><td>권*우</td><td>010-****-2858</td></tr>
				<tr><td>5</td><td>기*화</td><td>010-****-7846</td></tr>
				<tr><td>6</td><td>김*주</td><td>010-****-7833</td></tr>
				<tr><td>7</td><td>김*운</td><td>010-****-1935</td></tr>
				<tr><td>8</td><td>김*애</td><td>010-****-4460</td></tr>
				<tr><td>9</td><td>김*영</td><td>010-****-4050</td></tr>
				<tr><td>10</td><td>김*연</td><td>010-****-3010</td></tr>
				<tr><td>11</td><td>김*희</td><td>010-****-6628</td></tr>
				<tr><td>12</td><td>김*경</td><td>010-****-3686</td></tr>
				<tr><td>13</td><td>김*</td><td>010-****-5536</td></tr>
				<tr><td>14</td><td>김*주</td><td>010-****-3731</td></tr>
				<tr><td>15</td><td>김*지</td><td>010-****-5523</td></tr>
				<tr><td>16</td><td>김*하</td><td>010-****-9250</td></tr>
				<tr><td>17</td><td>김*형</td><td>010-****-8478</td></tr>
				<tr><td>18</td><td>김*혜</td><td>010-****-8689</td></tr>
				<tr><td>19</td><td>김*희</td><td>010-****-0690</td></tr>
				<tr><td>20</td><td>김*경</td><td>010-****-0304</td></tr>
				<tr><td>21</td><td>김*진</td><td>010-****-1367</td></tr>
				<tr><td>22</td><td>김*진</td><td>010-****-1751</td></tr>
				<tr><td>23</td><td>노*연</td><td>010-****-0617</td></tr>
				<tr><td>24</td><td>류*영</td><td>010-****-0224</td></tr>
				<tr><td>25</td><td>목*선</td><td>010-****-3512</td></tr>
				<tr><td>26</td><td>박*영</td><td>010-****-7254</td></tr>
				<tr><td>27</td><td>박*난</td><td>010-****-0544</td></tr>
				<tr><td>28</td><td>박*혜</td><td>010-****-1596</td></tr>
				<tr><td>29</td><td>박*애</td><td>010-****-0627</td></tr>
				<tr><td>30</td><td>박*령</td><td>010-****-8638</td></tr>
				<tr><td>31</td><td>박*영</td><td>010-****-6921</td></tr>
				<tr><td>32</td><td>박*현</td><td>010-****-0113</td></tr>
				<tr><td>33</td><td>박*아</td><td>010-****-2574</td></tr>
				<tr><td>34</td><td>박*미</td><td>010-****-9798</td></tr>
				<tr><td>35</td><td>박*지</td><td>010-****-0899</td></tr>
				<tr><td>36</td><td>박*은</td><td>010-****-1151</td></tr>
				<tr><td>37</td><td>박*애</td><td>010-****-7363</td></tr>
				<tr><td>38</td><td>박*주</td><td>010-****-6612</td></tr>
				<tr><td>39</td><td>박*현</td><td>010-****-4382</td></tr>
				<tr><td>40</td><td>박*정</td><td>010-****-1460</td></tr>
				<tr><td>41</td><td>박*정</td><td>010-****-0146</td></tr>
				<tr><td>42</td><td>박*정</td><td>010-****-3641</td></tr>
				<tr><td>43</td><td>백*연</td><td>010-****-6142</td></tr>
				<tr><td>44</td><td>복*선</td><td>010-****-7110</td></tr>
				<tr><td>45</td><td>사*연</td><td>010-****-7145</td></tr>
				<tr><td>46</td><td>서*림</td><td>010-****-8220</td></tr>
				<tr><td>47</td><td>서*</td><td>010-****-1458</td></tr>
				<tr><td>48</td><td>송*경</td><td>010-****-2442</td></tr>
				<tr><td>49</td><td>송*민</td><td>010-****-4567</td></tr>
				<tr><td>50</td><td>송*은</td><td>010-****-0718</td></tr>
				<tr><td>51</td><td>신*미</td><td>010-****-7935</td></tr>
				<tr><td>52</td><td>안*현</td><td>010-****-3994</td></tr>
				<tr><td>53</td><td>오*경</td><td>010-****-0331</td></tr>
				<tr><td>54</td><td>오*미</td><td>010-****-2790</td></tr>
				<tr><td>55</td><td>오*규</td><td>010-****-2790</td></tr>
				<tr><td>56</td><td>오*주</td><td>010-****-2703</td></tr>
				<tr><td>57</td><td>우*연</td><td>010-****-8359</td></tr>
				<tr><td>58</td><td>육*정</td><td>010-****-0123</td></tr>
				<tr><td>59</td><td>윤*선</td><td>010-****-4584</td></tr>
				<tr><td>60</td><td>윤*경</td><td>010-****-2206</td></tr>
				<tr><td>61</td><td>이*현</td><td>010-****-0385</td></tr>
				<tr><td>62</td><td>이*지</td><td>010-****-3711</td></tr>
				<tr><td>63</td><td>이*윤</td><td>010-****-4945</td></tr>
				<tr><td>64</td><td>이*진</td><td>010-****-5005</td></tr>
				<tr><td>65</td><td>이*련</td><td>010-****-9228</td></tr>
				<tr><td>66</td><td>이*비</td><td>010-****-0140</td></tr>
				<tr><td>67</td><td>이*혜</td><td>010-****-3257</td></tr>
				<tr><td>68</td><td>이*은</td><td>010-****-0572</td></tr>
				<tr><td>69</td><td>이*민</td><td>010-****-2726</td></tr>
				<tr><td>70</td><td>이*연</td><td>010-****-0246</td></tr>
				<tr><td>71</td><td>이*은</td><td>010-****-1002</td></tr>
				<tr><td>72</td><td>이*혜</td><td>010-****-5709</td></tr>
				<tr><td>73</td><td>이*아</td><td>010-****-8838</td></tr>
				<tr><td>74</td><td>이*원</td><td>010-****-7875</td></tr>
				<tr><td>75</td><td>이*자</td><td>010-****-1090</td></tr>
				<tr><td>76</td><td>임*영</td><td>010-****-8323</td></tr>
				<tr><td>77</td><td>임*미</td><td>010-****-6123</td></tr>
				<tr><td>78</td><td>임*희</td><td>010-****-2836</td></tr>
				<tr><td>79</td><td>전*원</td><td>010-****-9932</td></tr>
				<tr><td>80</td><td>정*영</td><td>010-****-9534</td></tr>
				<tr><td>81</td><td>정*윤</td><td>010-****-8669</td></tr>
				<tr><td>82</td><td>정*미</td><td>010-****-9164</td></tr>
				<tr><td>83</td><td>정*영</td><td>010-****-7666</td></tr>
				<tr><td>84</td><td>정*아</td><td>010-****-7432</td></tr>
				<tr><td>85</td><td>정*경</td><td>010-****-3476</td></tr>
				<tr><td>86</td><td>정*영</td><td>010-****-5279</td></tr>
				<tr><td>87</td><td>조*영</td><td>010-****-6269</td></tr>
				<tr><td>88</td><td>조*희</td><td>010-****-5141</td></tr>
				<tr><td>89</td><td>조*원</td><td>010-****-8765</td></tr>
				<tr><td>90</td><td>조*은</td><td>010-****-7759</td></tr>
				<tr><td>91</td><td>지*</td><td>010-****-3834</td></tr>
				<tr><td>92</td><td>진*림</td><td>010-****-0095</td></tr>
				<tr><td>93</td><td>채*림</td><td>010-****-4915</td></tr>
				<tr><td>94</td><td>천*원</td><td>010-****-9502</td></tr>
				<tr><td>95</td><td>최*현</td><td>010-****-7811</td></tr>
				<tr><td>96</td><td>하*정</td><td>010-****-8912</td></tr>
				<tr><td>97</td><td>허*연</td><td>010-****-2084</td></tr>
				<tr><td>98</td><td>홍*연</td><td>010-****-8638</td></tr>
				<tr><td>99</td><td>황*영</td><td>010-****-2198</td></tr>
				<tr><td>100</td><td>희*</td><td>010-****-2399</td></tr>
			</table>
			<div class="sub_title">감사합니다.</div>
		</div>
	</div>
	<div class="modal_container modal_view modal_view_5">
		<div class="modal_close" onClick="close_view();">
			<img src="/images/event/skin_attachment/close.png" />
		</div>
		<div class="modal_contents">
			<div class="sub_title">건강한 순수한면 사용후기 당첨자 발표</div>
			안녕하세요.<br />
			건강한 순수한면 담당자입니다.<br /><br />
			건강한 순수한면 사용후기를 작성해주신 모든 분들께 감사합니다.<br /><br />
			작성해주신 후기가 SNS에 업로드 되어 있는 분들 중<br />
			추첨을 통해 당첨자 133명이 선정되었습니다.<br /><br />
			앞으로도 여러분의 많은 관심과 참여 부탁 드리며,<br />
			건강한 순수한면 사용 후기 당첨자를 발표하겠습니다.<br /><br />
			아래에서 당첨정보를 확인해주시기 바랍니다<br />
			(PC이용시, Ctrl+F를 누르고 휴대폰 뒷번호를 검색하면 편리합니다.)<br /><br />
			선정되신 분들 모두 진심으로 축하 드립니다.
			<div class="sub_title">[다이슨 슈퍼소닉 헤어드라이어 (1명)]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr><td>1</td><td>임*민</td><td>010-****-8008</td></tr>
			</table>
			<div class="sub_title">[신세계 백화점 10만원 상품권 (2명)]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr><td>1</td><td>박*양</td><td>010-****-0236</td></tr>
				<tr><td>2</td><td>신*옥</td><td>010-****-1306</td></tr>
			</table>
			<div class="sub_title">[건강한 순수한면 선물세트 (30명)]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr><td>1</td><td>강*윤</td><td>010-****-8428</td></tr>
				<tr><td>2</td><td>권*원</td><td>011-****-6769</td></tr>
				<tr><td>3</td><td>김*정</td><td>010-****-1826</td></tr>
				<tr><td>4</td><td>김*정</td><td>010-****-9299</td></tr>
				<tr><td>5</td><td>김*영</td><td>010-****-1378</td></tr>
				<tr><td>6</td><td>김*희</td><td>010-****-6628</td></tr>
				<tr><td>7</td><td>김*주</td><td>010-****-0611</td></tr>
				<tr><td>8</td><td>김*영</td><td>010-****-6947</td></tr>
				<tr><td>9</td><td>김*원</td><td>010-****-8992</td></tr>
				<tr><td>10</td><td>김*실</td><td>010-****-2296</td></tr>
				<tr><td>11</td><td>김*희</td><td>010-****-7458</td></tr>
				<tr><td>12</td><td>김*정</td><td>010-****-6626</td></tr>
				<tr><td>13</td><td>박*영</td><td>010-****-4248</td></tr>
				<tr><td>14</td><td>오*정</td><td>010-****-2435</td></tr>
				<tr><td>15</td><td>유*지</td><td>010-****-9080</td></tr>
				<tr><td>16</td><td>윤*희</td><td>010-****-3441</td></tr>
				<tr><td>17</td><td>이*진</td><td>010-****-3848</td></tr>
				<tr><td>18</td><td>이*성</td><td>010-****-0460</td></tr>
				<tr><td>19</td><td>이*주</td><td>010-****-1365</td></tr>
				<tr><td>20</td><td>이*민</td><td>010-****-2726</td></tr>
				<tr><td>21</td><td>이*선</td><td>010-****-6791</td></tr>
				<tr><td>22</td><td>이*록</td><td>010-****-0513</td></tr>
				<tr><td>23</td><td>이*원</td><td>010-****-5095</td></tr>
				<tr><td>24</td><td>장*진</td><td>010-****-8265</td></tr>
				<tr><td>25</td><td>정*혜</td><td>010-****-0575</td></tr>
				<tr><td>26</td><td>정*혜</td><td>010-****-9485</td></tr>
				<tr><td>27</td><td>조*성</td><td>010-****-6696</td></tr>
				<tr><td>28</td><td>최*우</td><td>010-****-2486</td></tr>
				<tr><td>29</td><td>최*서</td><td>010-****-0602</td></tr>
				<tr><td>30</td><td>황*미</td><td>010-****-7214</td></tr>
			</table>
			<div class="sub_title">[비타 500 모바일 교환권 (100명)]</div>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="35%" />
					<col width="55%" />
				</colgroup>
				<tr>
					<th>NO</th><th>이름</th><th>연락처</th>
				</tr>
				<tr><td>1</td><td>강*연</td><td>010-****-1128</td></tr>
				<tr><td>2</td><td>강*원</td><td>010-****-3806</td></tr>
				<tr><td>3</td><td>강*별</td><td>010-****-7543</td></tr>
				<tr><td>4</td><td>강*혜</td><td>010-****-9862</td></tr>
				<tr><td>5</td><td>공*연</td><td>010-****-8335</td></tr>
				<tr><td>6</td><td>길*</td><td>010-****-0225</td></tr>
				<tr><td>7</td><td>길*은</td><td>010-****-6769</td></tr>
				<tr><td>8</td><td>김*래</td><td>010-****-8983</td></tr>
				<tr><td>9</td><td>김*숙</td><td>010-****-2135</td></tr>
				<tr><td>10</td><td>김*연</td><td>010-****-3104</td></tr>
				<tr><td>11</td><td>김*견</td><td>010-****-5907</td></tr>
				<tr><td>12</td><td>김*경</td><td>010-****-7827</td></tr>
				<tr><td>13</td><td>김*희</td><td>010-****-7704</td></tr>
				<tr><td>14</td><td>김*라</td><td>010-****-0401</td></tr>
				<tr><td>15</td><td>김*백</td><td>010-****-6169</td></tr>
				<tr><td>16</td><td>김*선</td><td>010-****-8526</td></tr>
				<tr><td>17</td><td>김*영</td><td>010-****-1052</td></tr>
				<tr><td>18</td><td>김*희</td><td>010-****-7486</td></tr>
				<tr><td>19</td><td>김*연</td><td>010-****-6780</td></tr>
				<tr><td>20</td><td>김**솔</td><td>010-****-0843</td></tr>
				<tr><td>21</td><td>김*리</td><td>010-****-8665</td></tr>
				<tr><td>22</td><td>김*주</td><td>010-****-2997</td></tr>
				<tr><td>23</td><td>김*원</td><td>010-****-0808</td></tr>
				<tr><td>24</td><td>나*영</td><td>010-****-7971</td></tr>
				<tr><td>25</td><td>도*진</td><td>010-****-7128</td></tr>
				<tr><td>26</td><td>도*경</td><td>010-****-8576</td></tr>
				<tr><td>27</td><td>류*영</td><td>010-****-0224</td></tr>
				<tr><td>28</td><td>박*혜</td><td>010-****-8955</td></tr>
				<tr><td>29</td><td>박*령</td><td>010-****-8638</td></tr>
				<tr><td>30</td><td>박*린</td><td>010-****-2751</td></tr>
				<tr><td>31</td><td>박*선</td><td>010-****-1077</td></tr>
				<tr><td>32</td><td>박*선</td><td>010-****-8912</td></tr>
				<tr><td>33</td><td>박*근</td><td>010-****-4737</td></tr>
				<tr><td>34</td><td>박*은</td><td>010-****-9426</td></tr>
				<tr><td>35</td><td>박*숙</td><td>010-****-3658</td></tr>
				<tr><td>36</td><td>박*림</td><td>010-****-9287</td></tr>
				<tr><td>37</td><td>박*정</td><td>010-****-6533</td></tr>
				<tr><td>38</td><td>박*아</td><td>010-****-8360</td></tr>
				<tr><td>39</td><td>박*정</td><td>010-****-0146</td></tr>
				<tr><td>40</td><td>백*숙</td><td>010-****-0222</td></tr>
				<tr><td>41</td><td>서*롱</td><td>010-****-0002</td></tr>
				<tr><td>42</td><td>서*아</td><td>010-****-6208</td></tr>
				<tr><td>43</td><td>서*</td><td>010-****-7103</td></tr>
				<tr><td>44</td><td>석*희</td><td>010-****-4837</td></tr>
				<tr><td>45</td><td>설*미</td><td>010-****-9836</td></tr>
				<tr><td>46</td><td>송*진</td><td>010-****-6279</td></tr>
				<tr><td>47</td><td>송*리</td><td>010-****-6156</td></tr>
				<tr><td>48</td><td>신*정</td><td>010-****-7067</td></tr>
				<tr><td>49</td><td>신*영</td><td>010-****-1378</td></tr>
				<tr><td>50</td><td>안*미</td><td>010-****-7437</td></tr>
				<tr><td>51</td><td>엄*영</td><td>010-****-7060</td></tr>
				<tr><td>52</td><td>오*은</td><td>010-****-2115</td></tr>
				<tr><td>53</td><td>윤*섭</td><td>010-****-5468</td></tr>
				<tr><td>54</td><td>윤*혜</td><td>010-****-0419</td></tr>
				<tr><td>55</td><td>이*숙</td><td>010-****-7773</td></tr>
				<tr><td>56</td><td>이*아</td><td>010-****-5395</td></tr>
				<tr><td>57</td><td>이*옥</td><td>010-****-4659</td></tr>
				<tr><td>58</td><td>이*옥</td><td>010-****-4813</td></tr>
				<tr><td>59</td><td>이*희</td><td>010-****-0930</td></tr>
				<tr><td>60</td><td>이*미</td><td>010-****-0250</td></tr>
				<tr><td>61</td><td>이*은</td><td>010-****-0851</td></tr>
				<tr><td>62</td><td>이*란</td><td>010-****-9515</td></tr>
				<tr><td>63</td><td>이*경</td><td>010-****-7307</td></tr>
				<tr><td>64</td><td>이*경</td><td>010-****-7094</td></tr>
				<tr><td>65</td><td>이*숙</td><td>010-****-3869</td></tr>
				<tr><td>66</td><td>이*미</td><td>010-****-6352</td></tr>
				<tr><td>67</td><td>이*하</td><td>010-****-0104</td></tr>
				<tr><td>68</td><td>이*선</td><td>010-****-7560</td></tr>
				<tr><td>69</td><td>이*윤</td><td>010-****-6738</td></tr>
				<tr><td>70</td><td>이*미</td><td>010-****-7688</td></tr>
				<tr><td>71</td><td>이*정</td><td>010-****-4580</td></tr>
				<tr><td>72</td><td>이*정</td><td>010-****-4028</td></tr>
				<tr><td>73</td><td>임*리</td><td>010-****-1031</td></tr>
				<tr><td>74</td><td>임*순</td><td>010-****-3130</td></tr>
				<tr><td>75</td><td>장*진</td><td>010-****-1830</td></tr>
				<tr><td>76</td><td>전*영</td><td>010-****-4164</td></tr>
				<tr><td>77</td><td>전*연</td><td>010-****-2314</td></tr>
				<tr><td>78</td><td>정*령</td><td>010-****-3808</td></tr>
				<tr><td>79</td><td>정*이</td><td>010-****-6105</td></tr>
				<tr><td>80</td><td>정*영</td><td>010-****-1426</td></tr>
				<tr><td>81</td><td>정*경</td><td>010-****-7388</td></tr>
				<tr><td>82</td><td>정*주</td><td>010-****-1261</td></tr>
				<tr><td>83</td><td>정*주</td><td>010-****-7667</td></tr>
				<tr><td>84</td><td>정*현</td><td>010-****-3760</td></tr>
				<tr><td>85</td><td>정*순</td><td>010-****-7027</td></tr>
				<tr><td>86</td><td>조*희</td><td>010-****-5610</td></tr>
				<tr><td>87</td><td>조*경</td><td>010-****-4009</td></tr>
				<tr><td>88</td><td>조*미</td><td>010-****-0732</td></tr>
				<tr><td>89</td><td>채*지</td><td>010-****-5092</td></tr>
				<tr><td>90</td><td>최*주</td><td>010-****-4882</td></tr>
				<tr><td>91</td><td>최*영</td><td>010-****-9721</td></tr>
				<tr><td>92</td><td>최*</td><td>010-****-7463</td></tr>
				<tr><td>93</td><td>한*란</td><td>010-****-3998</td></tr>
				<tr><td>94</td><td>한*정</td><td>010-****-8806</td></tr>
				<tr><td>95</td><td>한*선</td><td>010-****-0922</td></tr>
				<tr><td>96</td><td>한*현</td><td>010-****-6030</td></tr>
				<tr><td>97</td><td>한*홍</td><td>010-****-6307</td></tr>
				<tr><td>98</td><td>홍*자</td><td>010-****-1210</td></tr>
				<tr><td>99</td><td>홍*림</td><td>010-****-9880</td></tr>
				<tr><td>100</td><td>황*연</td><td>010-****-3678</td></tr>
			</table>
			<div class="sub_title">감사합니다.</div>
		</div>
	</div>
</div>
</body>
</html>