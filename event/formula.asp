<!-- #include virtual = "/include/core/class.db.asp" -->
<%
Dim page_url
If Request.ServerVariables("QUERY_STRING") <> "" Then
	page_url = "http://www.purecotton.co.kr/event/formula.asp" & "?" &  Request.ServerVariables("QUERY_STRING")
Else
	page_url = "http://www.purecotton.co.kr/event/formula.asp"
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
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<meta name="viewport" content="width=640,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="no" />
<title>순수한면 : 나의 첫순면, 순수한면</title>

<link rel="shortcut icon" href="/images/common/favicon.ico" type="image/x-icon" />
<meta name="naver-site-verification" content="4c6a5dfe3286c0709d08565b9a3bcfd8eec3163c"/>
<!-- SNS LINK -->
<meta property="fb:app_id" content="1063882433990799">
<meta property="og:type" content="website" />
<meta property="og:url" content="<%= page_url %>" />
<meta property="og:site_name" content="건강한 순수한면" />
<%
If request.QueryString("evt") = "S2/event1" Then
%>
	<% If InStr(LCase(sUsrAgent), "http://naver.me/scrap") > 0 Then %>
<meta property="og:title" content="조보아가 선택한 건강한 순수한면! 광고 영상을 보고,  퀴즈를 풀어보아요~" />
<meta property="og:description" content="조보아가 선택한 건강한 순수한면! 광고 영상을 보고,  퀴즈를 풀어보아요~ 정답을 맞힌 분들 중 추첨을 통해 선물을 드립니다!" />
<meta property="og:image" content="http://kleannara.inuscomm.co.kr/images/formulaS2/feed/feed_event1_bg.png?v1" />
	<% Else %>
<meta property="og:title" content="조보아가 선택한 건강한 순수한면! 광고 영상을 보고,  퀴즈를 풀어보아요~" />
<meta property="og:description" content="조보아가 선택한 건강한 순수한면! 광고 영상을 보고,  퀴즈를 풀어보아요~ 정답을 맞힌 분들 중 추첨을 통해 선물을 드립니다!" />
<meta property="og:image" content="http://kleannara.inuscomm.co.kr/images/formulaS2/feed/feed_event1_fb.png?v1" />
	<% End If %>

<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:image" content="http://kleannara.inuscomm.co.kr/images/formulaS2/feed/feed_event1_tw.png?v1" />
<meta name="twitter:title" content="조보아가 선택한 건강한 순수한면! 광고 영상을 보고,  퀴즈를 풀어보아요~" />
<meta name="twitter:description" content="조보아가 선택한 건강한 순수한면! 광고 영상을 보고,  퀴즈를 풀어보아요~ 정답을 맞힌 분들 중 추첨을 통해 선물을 드립니다!" />
<%
ElseIf request.QueryString("evt") = "S2/event2" Then
%>
	<% If InStr(LCase(sUsrAgent), "http://naver.me/scrap") > 0 Then %>
<meta property="og:title" content="조보아와 함께하는 #순면공식 이벤트! 오늘의 순면공식을 확인해 보아요!" />
<meta property="og:description" content="오늘은 어떤 하루일까요? #순면공식으로 확인하고, 공유해주세요. 추첨을 통해 푸짐한 경품을 드립니다!" />
<meta property="og:image" content="http://kleannara.inuscomm.co.kr/images/formulaS2/userfeed/<%=request.QueryString("dt")%>/feed_<%=request.QueryString("key")%>_bg.png" />
	<% Else %>
<meta property="og:title" content="조보아와 함께하는 #순면공식 이벤트! 오늘의 순면공식을 확인해 보아요!" />
<meta property="og:description" content="오늘은 어떤 하루일까요? #순면공식으로 확인하고, 공유해주세요. 추첨을 통해 푸짐한 경품을 드립니다!" />
<meta property="og:image" content="http://kleannara.inuscomm.co.kr/images/formulaS2/userfeed/<%=request.QueryString("dt")%>/feed_<%=request.QueryString("key")%>_fb.png" />
	<% End If %>
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:image" content="http://kleannara.inuscomm.co.kr/images/formulaS2/userfeed/<%=request.QueryString("dt")%>/feed_<%=request.QueryString("key")%>_tw.png" />
<meta name="twitter:title" content="조보아와 함께하는 #순면공식 이벤트! 오늘의 순면공식을 확인해 보아요!" />
<meta name="twitter:description" content="오늘은 어떤 하루일까요? #순면공식으로 확인하고, 공유해주세요. 추첨을 통해 푸짐한 경품을 드립니다!" />
<%
ElseIf request.QueryString("evt") = 3 Then
%>
<meta property="og:title" content="조보아가 선택한 건강한 순수한면을 체험해보아요!" />
<meta property="og:description" content="10,000명 체험자 중 94%가 만족한 건강한 순수한면을 체험해보아요!" />
<meta property="og:image" content="http://kleannara.inuscomm.co.kr/images/formula/feed/feed_event3_fb.png?v1" />

<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:image" content="http://kleannara.inuscomm.co.kr/images/formula/feed/feed_event3_tw.png?v1" />
<meta name="twitter:title" content="조보아가 선택한 건강한 순수한면을 체험해보아요!" />
<meta name="twitter:description" content="10,000명 체험자 중 94%가 만족한 건강한 순수한면을 체험해보아요!" />
<%
Else
%>
<meta property="og:title" content="건강한 순수한면 순면커버 프로모션" />
<meta property="og:description" content="" />
<meta property="og:image" content="http://kleannara.inuscomm.co.kr/images/formula/feed/feed_event3_fb.png?v1" />

<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:image" content="http://kleannara.inuscomm.co.kr/images/formula/feed/feed_event3_tw.png?v1" />
<meta name="twitter:title" content="건강한 순수한면 순면커버 프로모션" />
<meta name="twitter:description" content="" />
<%
End If
%>
<!--// SNS LINK -->
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-120153230-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-120153230-1');
</script>

<!-- Facebook Pixel Code -->
<script>
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window,document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', '380110632715365');
fbq('track', 'PageView');
</script>
<noscript>
<img height="1" width="1"
src="https://www.facebook.com/tr?id=380110632715365&ev=PageView
&noscript=1"/>
</noscript>
</head>
<div style="-webkit-overflow-scrolling: touch;">
<frameset rows="100%,*" border="0">
	<% If request.QueryString("evt") = "S2/event1" Or request.QueryString("evt") = "S2/event2" Then %>
		<frame name="noframe" id="myIframe" src="https://kleannara.inuscomm.co.kr/formula<%=request.QueryString("evt")%>/?referer=<%= Server.URLEncode(Request.ServerVariables("HTTP_REFERER")) %>&fromurl=<%= request.QueryString("fromurl") %>&page=<%= request.QueryString("page") %>&event=<%= request.QueryString("evt") %>&bz_tracking_id=<%= request.QueryString("bz_tracking_id") %>"></frame>
	<% Else %>
		<% If request.QueryString("evt") <> "" Then %>
			<frame name="noframe" id="myIframe" src="https://kleannara.inuscomm.co.kr/formulaS2/event<%= request.QueryString("evt") %>/?referer=<%= Server.URLEncode(Request.ServerVariables("HTTP_REFERER")) %>&fromurl=<%= request.QueryString("fromurl") %>&page=<%= request.QueryString("page") %>&event=<%= request.QueryString("evt") %>&bz_tracking_id=<%= request.QueryString("bz_tracking_id") %>"></frame>
		<% Else %>
			<frame name="noframe" id="myIframe" src="https://kleannara.inuscomm.co.kr/formulaS2/?referer=<%= Server.URLEncode(Request.ServerVariables("HTTP_REFERER")) %>&fromurl=<%= request.QueryString("fromurl") %>&page=<%= request.QueryString("page") %>&event=<%= request.QueryString("evt") %>&bz_tracking_id=<%= request.QueryString("bz_tracking_id") %>"></frame>
		<% End If %>
	<% End If %>
	<noframes>
		<body>
		<p>This page uses frames. The current browser you are using does not support frames.</p>
		</body>
	</noframes>
</frameset>
</div>
</html>

