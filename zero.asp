<!-- #include virtual = "/include/core/class.db.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="description" content="순수한면 제로">
<meta name="keywords" content="순수한면 제로">
<meta name="viewport" content="width=640, target-densitydpi=device-dpi, user-scalable=no">
<title>순수한면 제로</title>
<%
page = request.QueryString("page")
img_no = request.QueryString("img_no")

If img_no = "" Then
	img_no = 1
End If

If page = "spread" Then
%>
<meta property="fb:app_id" content="1256370561191886">
<meta property="og:title" content="어떤 생리대를 써야할지 고민하고 있나요?" />
<meta property="og:type" content="website" />
<meta property="og:url" content="http://www.purecotton.co.kr/zero.asp?page=spread&img_no=<%=img_no%>" />
<meta property="og:site_name" content="어떤 생리대를 써야할지 고민하고 있나요?" />
<meta property="og:description" content="100% 순면커버, 100% 천연흡수층! 안심생리대~! 순수한면 제로로 정착한 소비자의 리얼스토리 공유하고, 선물도 받아가세요!" />
<meta property="og:image" content="http://www.womantable.com/_asset/img/purecotton/spread/purecotton_spread_feed_fb_<%=img_no%>.png?v1" />

<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:image" content="http://www.womantable.com/_asset/img/purecotton/spread/purecotton_spread_feed_tw_<%=img_no%>.png?v1" />
<meta name="twitter:title" content="어떤 생리대를 써야할지 고민하고 있나요?" />
<meta name="twitter:description" content="100% 순면커버, 100% 천연흡수층! 안심생리대~! 순수한면 제로로 정착한 소비자의 리얼스토리 공유하고, 선물도 받아가세요!" />
<%
End If
%>
<!-- Global site tag (gtag.js) - Google Analytics --> 
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-120153230-1"></script>
<script>
window.dataLayer = window.dataLayer || [];
function gtag()

{dataLayer.push(arguments);}
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
<!-- End Facebook Pixel Code -->

</head>
<frameset rows="100%,*" border="0">
	<frame name="noframe" src="/event/zero_spread.asp"></frame>
	<noframes>
		<body>
		<p>This page uses frames. The current browser you are using does not support frames.</p>
		</body>
	</noframes>
</frameset>
</html>

