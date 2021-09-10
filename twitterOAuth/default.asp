<!--#include file="oauth/_inc/_base.asp"-->
<%
	Dim blnLoggedIn : blnLoggedIn = False
	Dim strScreenName : strScreenName = Session(TWITTER_SCREEN_NAME)
	
	If Not IsNull(strScreenName) And strScreenName <> "" Then
		blnLoggedIn = True
	End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<title>Classic ASP VBScript OAuth</title>
		<link href="http://yui.yahooapis.com/3.1.0/build/cssreset/reset-min.css" rel="stylesheet" type="text/css">
		<link href="css/base.css" rel="stylesheet" type="text/css">
		<meta content="This page hosts an example of a Generic Classic ASP VBScript OAuth Library in action. The example uses Twitter's OAuth Authentication Flow to illustrate usage. The project in its entirety, with full source code, is available for download." name="description">
		<script language="javascript">
			var OAUTH_VBSCRIPT = {
				loggedIn: <%=LCase(CStr(blnLoggedIn))%>,
				screenName: '<%=strScreenName%>'
			};
		</script>
	</head>
	<body>
		<div id="container">

			<a href="http://github.com/sdesapio/Classic-ASP-VBScript-OAuth"><img style="position: absolute; top: 0; right: 0; border: 0;" src="http://s3.amazonaws.com/github/ribbons/forkme_right_white_ffffff.png" alt="Fork me on GitHub" /></a>

			<h1>Classic ASP VBScript OAuth</h1>
			<h3>By <a href="http://scottdesapio.com">Scott DeSapio</a></h3>

			<!-- AddThis Follow BEGIN --> 
			<hr>
			Follow Scott:
			<div class="addthis_toolbox addthis_32x32_style addthis_default_style"> 
				<a class="addthis_button_facebook_follow" addthis:userid="sdesapio"></a> 
				<a class="addthis_button_twitter_follow" addthis:userid="sdesapio"></a> 
				<a class="addthis_button_youtube_follow" addthis:userid="scottdesapio"></a> 
				<a class="addthis_button_rss_follow" addthis:userid="http://blog.scottdesapio.com"></a> 
			</div> 
			<!-- AddThis Follow END --> 			

			<hr>
			Share this page:
			<div class="pw-widget pw-counter-horizontal">
				<a class="pw-button-facebook pw-look-native"></a>
				<a class="pw-button-twitter pw-look-native"></a>
				<a class="pw-button-linkedin pw-look-native"></a>
				<a class="pw-button-googleplus pw-look-native"></a>
				<a class="pw-button-post-share"></a>
			</div>
			<hr>
			<p>

			<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_blank" id="donate_container">
				Donate - Did you find this useful? Don't be shy, say thanks with some dough...
				<input type="hidden" name="business" value="sdesapio@gmail.com" ID="Hidden1">
				<input type="hidden" name="cmd" value="_xclick" ID="Hidden2">
				<input type="hidden" name="item_name" value="Classic ASP OAuth VBScript Donation" ID="Hidden3">
				<input type="hidden" name="currency_code" value="USD" ID="Hidden4">
				<input type="hidden" name="page_style" value="ScottDeSapio" ID="Hidden5">
				<input type="hidden" name="rm" value="1" ID="Hidden6">
				<input type="image" src="http://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!" id="buyBtn_paypal">
				<img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
			</form>

			<ul class="toc_section">
				Try it out
				<li>
					<a href="#demo">DEMO</a> (twitter sign-in)
				</li>
			</ul>
			<ul class="toc_section">
				About
				<li>
					<a href="#whatThisIs">What this is</a>
				</li>
				<li>
					<a href="#whatThisIsNot">What this is NOT</a>
				</li>
				<li>
					<a href="#quickStart">Quick Start</a>
				</li>
			</ul>
			<ul class="toc_section">
				Basics
				<li>
					<a href="#codeFlow">Basic Code Flow</a>
				</li>
				<li>
					<a href="#basicExampleCode">Basic Code Example</a>
				</li>
			</ul>
			<ul class="toc_section">
				Example Project
				<li>
					<a href="#projectInstructions">Example Project Setup Instructions</a>
				</li>
				<li>
					<a href="#exampleCode">Example Project Code</a>
				</li>
			</ul>
			<ul class="toc_section">
				Properties & Methods
				<li>
					<a href="#publicProperties">Public Properties</a>
				</li>
				<li>
					<a href="#publicMethods">Public Methods</a>
				</li>
			</ul>
			<ul class="toc_section">
				Feedback
				<li>
					<a href="#disqus_thread">Comments</a>
				</li>
			</ul>

<!-- DEMO -->
			<p>
			<a name="demo"></a>
			<hr><a href="#" style="font-size:.75em;float:right;">top</a>
			<div id="sign_out_container">
				<b>Logged in as:</b> <span id="screen_name"></span> [<a href="sign_out.asp" target="_blank" id="sign_out">sign out</a>]
				<br>
				<textarea id="tweet_textarea" name="tweet_textarea">test tweet</textarea>
				<br>
				<input type="button" value="post to twitter" id="tweet_tools_button" NAME="tweet_tools_button">
			</div>
			<div id="sign_in_container">
				<b>DEMO</b>: Click the "Sign in with Twitter" button below.<p>
				<a href="twitter/authenticate.asp" target="_blank" id="sign_in">
					<img src="css/assets/Sign-in-with-Twitter-lighter.png" border=0></img>
				</a>
			</div>

			<div id="instructions">

<!-- What this is -->
				<p>
				<a name="whatThisIs"></a>
				<hr><a href="#" style="font-size:.75em;float:right;">top</a>
				<p>
				<b>What this is:</b>
				<br>
				This page hosts an example of a <i>Generic Classic ASP VBScript OAuth Library</i> in action. The example uses Twitter's 
				OAuth Authentication Flow (<a href="http://apiwiki.twitter.com/Sign-in-with-Twitter" target="_blank">Sign-in with Twitter</a>) 
				to illustrate usage. The project in its entirety, with full source code, is available for download here:
				<p>
				&nbsp;&nbsp;&nbsp;&nbsp;<b>PATH:</b> <a href="http://scottdesapio.com/VBScriptOAuth/oAuthASPExample.zip" title="VBScript OAuth Example Project">http://scottdesapio.com/VBScriptOAuth/oAuthASPExample.zip</a>
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;<b>MD5:</b> 0bd4293e7226f43cbdf7e66ebd863ef0
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;<b>LAST UPDATE:</b> 08.21.13
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;<b>GITHUB (OAuth Library Only):</b> <a href="http://github.com/sdesapio/Classic-ASP-VBScript-OAuth" title="View and download code at github">http://github.com/sdesapio/Classic-ASP-VBScript-OAuth</a>

<!-- What this is NOT -->
				<p>
				<a name="whatThisIsNot"></a>
				<hr><a href="#" style="font-size:.75em;float:right;">top</a>
				<p>
				<b>What this is NOT:</b>
				<br>
				Although the Twitter REST API is used, this example project is not so much a "Twitter" example as it is a "<b>VBScript OAuth</b>" 
				example.
				<br>
				<br>
				This DEMO is also NOT a CSS or JavaScript tutorial. Pay no attention to the CSS and JavaScript. The CSS and Javascript 
				used in the example project would require their own tutorials and exist only to help illustrate the implementation. 
				IGNORE all CSS and JavaScript. <b>NEITHER SHOULD BE CONSIDERED PRODUCTION READY (or remotely production usable for that matter).</b>
				<br>
				<br>
				What you REALLY want to focus on is the "<b>oauth</b>" folder inside of the example project - specifically the cLibOAuth.asp file.

<!-- Quick Start Instructions -->
				<p>
				<a name="quickStart"></a>
				<hr><a href="#" style="font-size:.75em;float:right;">top</a>
				<p>
				<b>Quick Start Instructions:</b>
				<br>
				These Quick Start instructions assume you're not interested in the example project and already have a solid grasp on 
				including external libraries. If you're not yet comfortable with including external libraries, skip this Quick Start 
				and follow the <a href="#projectInstructions">example project setup instructions</a> below.
				<p>
				<b>NOTE:</b> Use these instructions only after you've acquired a Consumer Key and Secret provided by 
				your OAuth service provider.
				<ol>
					<li>Download the <a href="http://scottdesapio.com/VBScriptOAuth/oAuthASPExample.zip" title="VBScript OAuth Example Project">VBScript Example Project</a>.</li>
					<li>Extract all of the files into a temp directory.</li>
					<li>Copy and paste the "oauth" folder from the Temp directory into the root of your project.</li>
					<li>Create a new folder in the root of your project named "OAuthTest"</li>
					<li>Create a new file in your OAuthTest folder named "default.asp"</li>
					<li>As a starting point, copy and paste the <a href="#basicExampleCode">basic code example</a> into your "OAuthTest/default.asp" file.</li>
					<li>Replace all of the {TOKENS} with valid values</li>
					<li>Browse to http://localhost/{YOUR_PROJECT_NAME}/OAuthTest/default.asp in your browser</li>
				</ol>
				<p>

				<p>
				<b>Example Project Directory</b>
				<br>
				Although the following example directory structure is used in this example project, the example project itself utilizes 
				quite a few more files. When utilising the VBScript OAuth Lib, your project should AT MINIMUM follow this structure:
				<p>
				<pre>
+-root/
  +-oauth/
  | +-_inc/
    | +-_base.asp
    | +-constants_oauth.asp
    | +-hex_sha1_base64.asp
  | +-cLibOAuth.asp
  | +-cLibOAuth.QS.asp
  | +-cLibOAuth.RequestURL.asp
  | +-cLibOAuth.Utils.asp
  +-default.asp
				</pre>

<!-- The Basics -->
				<p>
				<a name="codeFlow"></a>
				<hr><a href="#" style="font-size:.75em;float:right;">top</a>
				<p>
				<b>Basic Code Flow</b>
				<br>
				The following four steps outline the basic code flow of instantiaing and utilizing the VBScript OAuth Lib:
				<ol>
					<li>Instantiate an instance of the cLibOAuth object.</li>
					<li>Add proprietary request parameters.</li>
					<li>Make the call.</li>
					<li>Evaluate the response.</li>
				</ol>
				<br id="basicExampleCode">
				<b>Basic Code Example</b>
				<br>
				By referencing the cLibOAuth.asp files (<code>&lt;!--#include file="../oauth/cLibOAuth.asp"--&gt;</code>) in your project, 
				your code should end up resembling the following. Values surrounded by brackets ({...}) would of course be replaced by 
				proprietary values.
				<p>
				<textarea style="font-family:courier;font-size:.65em;height:515px;width:800px;" readonly>
&lt;!--#include file="../oauth/cLibOAuth.asp"-->
&lt;%

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 1. Instantiate an instance of the OAuth object.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim objOAuth : Set objOAuth = New cLibOAuth
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.ConsumerKey = {YOUR_CONSUMER_KEY}
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.ConsumerSecret = {YOUR_CONSUMER_SECRET}
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.EndPoint = {SERVICE_PROVIDER_ENDPOINT_URL}
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Host = {YOUR_HOST_HEADER_VALUE} ' required for twitter apps
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.RequestMethod = OAUTH_REQUEST_METHOD_POST
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.TimeoutURL = {YOUR_TIMEOUT_URL}
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.UserAgent = {YOUR_USER-AGENT_HEADER_VALUE} ' required for twitter apps


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 2. Add proprietary request parameters.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Parameters.Add {PARAM_NAME_1}, {PARAM_VALUE_1}
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Parameters.Add {PARAM_NAME_2}, {PARAM_VALUE_2}

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 3. Make the call.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Send()

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 4. Evaluate the response.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim strResponse : strResponse = _
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Get_ResponseValue({RESPONSE_PARAM_NAME})

%&gt;
				</textarea>
				<p>
				<b>NOTE:</b> The above example should not be taken literally. It is meant only to illustrate basic structure. 
				For actual working examples, check out the project files referenced below. 

<!-- Example Project Instructions -->
				<p>
				<a name="projectInstructions"></a>
				<hr><a href="#" style="font-size:.75em;float:right;">top</a>
				<p>
				<b>Example Project Setup Instructions</b>
				<br>
				As noted earlier, although the example project can be regarded as a straight up example of <b>Twitter VBScript OAuth</b>, it is meant only to  
				illustrate core library usage. None of the files existing outside of the "oauth" folder should be considered production ready. Also, please note 
				that this example project was designed as a <i>client</i> example and expects a browser. <i>Server side implementations may require some modifiction 
				to deal with Session state as reported by several users (see comments below).</i>
								
				<ol>
					<li>Log in to your twitter account and register your application. (<a href="http://twitter.com/apps" target"_blank">http://twitter.com/apps</a>)</li>
					<li><a href="oAuthASPExample.zip" title="VBScript OAuth Example Project">Download the example VBScript OAuth project.</a></li>
					<li>Extract the contents of the file to C:\Inetpub\wwwroot\oAuthASPExample</li>
					<li>In notepad, open C:\Inetpub\wwwroot\oAuthASPExample\twitter\_config.asp and add your Consumer Key and Secret as provided by twitter.</li>
					<li>Edit OAUTH_EXAMPLE_CALLBACK_URL to reflect the path to your callback.asp: "http://127.0.0.1/oAuthASPExample/twitter/callback.asp"</li>
					<li>Open up your browser and navigate to http://127.0.0.1/oAuthASPExample/</li>
				</ol>
				<p>
				<b>Example Project NOTES:</b>
				<ul>
					<li>You <b style="color:#f00;">MUST</b> start the example project from 127.0.0.1 or the callback on authenticate will fail.</li>
					<li>The JUICE <i>is</i> the "oauth" folder. The "oauth" folder contains the generic classes you'll be using in all of your 
					vbscript projects that require OAuth. Every other file in the package is just an "EXAMPLE Project" file and should be considered 
					freely editable and NOT production ready.</li>
					<li>Leave comments below if you run in to any trouble or <a href="http://twitter.com/?status=@sdesapio" target="_blank">@sdesapio</a> me.</li>
				</ul>

<!-- Example Project Code -->
				<p>
				<a name="exampleCode"></a>
				<hr><a href="#" style="font-size:.75em;float:right;">top</a>
				<p>
				<b>EXAMPLE PROJECT CODE:</b> This is the actual code, used on this page, illustrating the 
				<a href="http://apiwiki.twitter.com/Sign-in-with-Twitter" target="_blank">Sign-in with Twitter</a> workflow accompanied by 
				a status update.
				<p>
				<h3>1. Acquire "request token"</h3>
				FILE: authenticate.asp: 
				<br>
				DESC: Before doing ANYTHING, we first need to acquire a "request token" from the service provider. 
				<p>
				<textarea style="font-family:courier;font-size:.65em;height:480px;width:800px;" readonly>
&lt;!--#include file="../oauth/cLibOAuth.asp"-->
&lt;!--#include file="_config.asp"-->
&lt;%

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 1. Instantiate an instance of the OAuth object.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim objOAuth : Set objOAuth = New cLibOAuth
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.ConsumerKey = OAUTH_EXAMPLE_CONSUMER_KEY
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.ConsumerSecret = OAUTH_EXAMPLE_CONSUMER_SECRET
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.EndPoint = TWITTER_OAUTH_URL_REQUEST_TOKEN
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Host = TWITTER_API_HOST
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.RequestMethod = OAUTH_REQUEST_METHOD_GET
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.TimeoutURL = OAUTH_EXAMPLE_TIMEOUT_URL
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.UserAgent = TWITTER_APP_NAME

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 2. Add proprietary request parameters.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Parameters.Add "oauth_callback", OAUTH_EXAMPLE_CALLBACK_URL

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 3. Make the call.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Send()

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 4. Evaluate the response.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim strRequestToken : strRequestToken = objOAuth.Get_ResponseValue(OAUTH_TOKEN)

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' set the redirect url
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim strRedirectURL : If Not IsNull(objOAuth.ErrorCode) Then
&nbsp;&nbsp;&nbsp;&nbsp;' set redirect to generic error (do specific error handling here)
&nbsp;&nbsp;&nbsp;&nbsp;strRedirectURL = OAUTH_EXAMPLE_ERROR_URL
Else
&nbsp;&nbsp;&nbsp;&nbsp;' store the request token
&nbsp;&nbsp;&nbsp;&nbsp;Session(OAUTH_TOKEN_REQUEST) = strRequestToken
	
&nbsp;&nbsp;&nbsp;&nbsp;' set redirect to authenticate
&nbsp;&nbsp;&nbsp;&nbsp;strRedirectURL = TWITTER_OAUTH_URL_AUTHENTICATE & _
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"?oauth_token=" & strRequestToken & _
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"&force_login=" & LCase(CStr(OAUTH_EXAMPLE_FORCE_LOGIN))
End If

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' kill obj ref.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Set objOAuth = Nothing

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' redirect user
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Response.Redirect strRedirectURL

%&gt;
				</textarea>
				<p>
				<h3>2. Store access tokens.</h3>
				FILE: callback.asp: 
				<br>
				DESC: Upon successful request token acquisition, the service provider will issue a redirect to the 
				client (based on the callback set in "oauth_callback" parameter in step 1) where we can then acquire 
				and store our access tokens and forward to a custom complete page.
				<p>
				<textarea style="font-family:courier;font-size:.65em;height:480px;width:800px;" readonly>
&lt;!--#include file="../oauth/cLibOAuth.asp"-->
&lt;!--#include file="_config.asp"-->
&lt;%

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 1. catch the passed in qs param from twitter
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim strOAuthVerifier : strOAuthVerifier = Request.QueryString(OAUTH_VERIFIER)

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 2. Instantiate an instance of the OAuth object.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim objOAuth : Set objOAuth = New cLibOAuth
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.ConsumerKey = OAUTH_EXAMPLE_CONSUMER_KEY
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.ConsumerSecret = OAUTH_EXAMPLE_CONSUMER_SECRET
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.EndPoint = TWITTER_OAUTH_URL_ACCESS
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Host = TWITTER_API_HOST
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.RequestMethod = OAUTH_REQUEST_METHOD_GET
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.TimeoutURL = OAUTH_EXAMPLE_TIMEOUT_URL
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.UserAgent = TWITTER_APP_NAME


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 3. Add proprietary request parameters.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Parameters.Add "oauth_token", Session(OAUTH_TOKEN_REQUEST)
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Parameters.Add "oauth_verifier", strOAuthVerifier

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 4. Make the call.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Send()

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 5. check for error
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim strRedirectURL : If Not IsNull(objOAuth.ErrorCode) Then
&nbsp;&nbsp;&nbsp;&nbsp;' set redirect to failure handler (do specific error handling here)
&nbsp;&nbsp;&nbsp;&nbsp;strRedirectURL = OAUTH_EXAMPLE_LOGIN_FAILURE_URL
Else
&nbsp;&nbsp;&nbsp;&nbsp;' save session variables
&nbsp;&nbsp;&nbsp;&nbsp;Session(OAUTH_TOKEN) = objOAuth.Get_ResponseValue(OAUTH_TOKEN)
&nbsp;&nbsp;&nbsp;&nbsp;Session(OAUTH_TOKEN_SECRET) = objOAuth.Get_ResponseValue(OAUTH_TOKEN_SECRET)
&nbsp;&nbsp;&nbsp;&nbsp;Session(TWITTER_SCREEN_NAME) = objOAuth.Get_ResponseValue(TWITTER_SCREEN_NAME)
	
&nbsp;&nbsp;&nbsp;&nbsp;' set redirect to success handler
&nbsp;&nbsp;&nbsp;&nbsp;strRedirectURL = OAUTH_EXAMPLE_LOGIN_SUCCESS_URL & _
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"?" & Session(TWITTER_SCREEN_NAME)
End If

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' kill obj ref
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Set objOAuth = Nothing

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' redirect user
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Response.Redirect strRedirectURL

%&gt;
				</textarea>
				<p>
				<h3>3. Execute a status update.</h3>
				FILE: update_status.asp: 
				<br>
				DESC: Now that we've been authorized by the user and authenticated by the service provider, we can freely make calls to 
				protected resources. 
				<p>
				<textarea style="font-family:courier;font-size:.65em;height:480px;width:800px;" readonly>
&lt;!--#include file="../oauth/cLibOAuth.asp"-->
&lt;!--#include file="_config.asp"-->
&lt;%

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 1. Instantiate an instance of the OAuth object.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Dim objOAuth : Set objOAuth = New cLibOAuth

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' 2. Check if the user is logged in
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
If objOAuth.LoggedIn Then

&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;' 3. grab passed in status parameters
&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;Dim strStatus : strStatus = Request.Form("post")
&nbsp;&nbsp;&nbsp;&nbsp;Dim intReplyId : intReplyId = Request.Form("replyId")
&nbsp;&nbsp;&nbsp;&nbsp;Dim strReplyTo : strReplyTo = Request.Form("replyTo")

&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;' 4. Setup the oAuth object 
&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.ConsumerKey = OAUTH_EXAMPLE_CONSUMER_KEY
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.ConsumerSecret = OAUTH_EXAMPLE_CONSUMER_SECRET
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.EndPoint = TWITTER_OAUTH_URL_UPDATE_STATUS
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Host = TWITTER_API_HOST
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.RequestMethod = OAUTH_REQUEST_METHOD_POST
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.UserAgent = TWITTER_APP_NAME


&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;' 5. Add proprietary "status update" request parameters.
&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Parameters.Add "in_reply_to", strReplyTo
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Parameters.Add "in_reply_to_status_id", intReplyID
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Parameters.Add "oauth_token", Session(OAUTH_TOKEN)
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Parameters.Add "status", strStatus

&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;' 6. Make the call.
&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;objOAuth.Send()

&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;' 7. Evaluate the response
&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;Dim strResponseText : strResponseText = objOAuth.ResponseText

&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;' 8. Check for error code
&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;Dim strErrorCode : strErrorCode = objOAuth.ErrorCode

&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;' 9. Setup response
&nbsp;&nbsp;&nbsp;&nbsp;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
&nbsp;&nbsp;&nbsp;&nbsp;If Not IsNull(strErrorCode) Then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Response.Status = RESPONSE_STATUS_500
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Response.Write strErrorCode
&nbsp;&nbsp;&nbsp;&nbsp;Else
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Response.ContentType = "text/html"
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Response.CharSet = "utf-8"
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Response.Write strResponseText
&nbsp;&nbsp;&nbsp;&nbsp;End If

Else
&nbsp;&nbsp;&nbsp;&nbsp;' if not logged in, return forbidden
&nbsp;&nbsp;&nbsp;&nbsp;Response.Status = RESPONSE_STATUS_403
End If

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' kill object ref.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Set objOAuth = Nothing

%>
				</textarea>
				<p>

<!-- PUBLIC Properties -->
				<a name="publicProperties"></a>
				<hr><a href="#" style="font-size:.75em;float:right;">top</a>
				<p>
				<h2>Public Properties:</h2>
				<p>
				<span class="objectProp">ConsumerKey</span> (Let)
				<br> REQUIRED: Yes
				<br> TYPE: String
				<br> DESCRIPTION: Your "consumer key" as received from the Service Provider. For instance, after successfully 
				registering your app with twitter, you'll be forward to a page displaying your "consumer key."
				<br> USAGE: <span class="code">objOAuth.ConsumerKey = "123456789asdfghjkl"</span>
				<p>
				<span class="objectProp">ConsumerSecret</span> (Let)
				<br> REQUIRED: Yes
				<br> TYPE: String
				<br> DESCRIPTION: Your "consumer secret" as received from the Service Provider. 
				<br> USAGE: <span class="code">objOAuth.ConsumerSecret = "123456789asdfghjklzxcvbnm"</span>
				<p>
				<span class="objectProp">EndPoint</span> (Let)
				<br> REQUIRED: Yes
				<br> TYPE: String
				<br> DESCRIPTION: The URL of the oauth request. (e.g. http://twitter.com/statuses/update.json)
				<br> USAGE: <span class="code">objOAuth.EndPoint = "http://twitter.com/statuses/update.json"</span>
				<p>
				<span class="objectProp">ErrorCode</span> (Get)
				<br> REQUIRED: N/A
				<br> TYPE: Integer
				<br> DESCRIPTION: ASP Error code (<i>Err.number</i>) returned on error.
				<br> USAGE: <span class="code">Dim strErr : strErr = objOAuth.ErrorCode</span>
				<p>
				<span class="objectProp">Host</span> (Let)
				<br> REQUIRED: Varies (required for twitter implementation)
				<br> TYPE: String
				<br> DESCRIPTION: The "Host" request header value (required for twitter implementation) 
				<br> USAGE: <span class="code">objOAuth.Host = "api.twitter.com"</span>
				<p>
				<span class="objectProp">LoggedIn</span> (Get)
				<br> REQUIRED: N/A
				<br> TYPE: Boolean
				<br> DESCRIPTION: Convenience property that returns "logged in" state - requires you to save session variables 
				as illustrated in "twitter/callback.asp" in the example project.
				<br> USAGE: <span class="code">Dim blnLoggedIn : blnLoggedIn = objOAuth.LoggedIn</span>
				<p>
				<span class="objectProp">Parameters</span> (Set)
				<br> REQUIRED: No
				<br> TYPE: Object
				<br> DESCRIPTION: Dictionary object containing proprietary request query string pairs. For instance, twitter's 
				"statuses/update" method requires a "status" parameter and potentially an "in_reply_to" parameter. You'll add these 
				pairs as parameters (UNENCODED).
				<br> USAGE: <span class="code">objOAuth.Parameters.Add key, value</span>
				<p>
				<span class="objectProp">RequestMethod</span> (Let)
				<br> REQUIRED: No (Default is POST)
				<br> TYPE: String
				<br> DESCRIPTION: Request type (e.g. "GET", "POST")
				<br> USAGE: <span class="code">objOAuth.RequestMethod = "POST"</span>
				<p>
				<span class="objectProp">ResponseText</span> (Get)
				<br> REQUIRED: N/A
				<br> TYPE: String
				<br> DESCRIPTION: The proprietary service provider response string. (e.g. twitter will return json string on 
				"statuses/update.json" call - the json is the ResponseText)
				<br> USAGE: <span class="code">Dim strResponseText : strResponseText = objOAuth.ResponseText</span>
				<p>
				<span class="objectProp">TimeoutURL</span> (Let)
				<br> REQUIRED: No
				<br> TYPE: String
				<br> DESCRIPTION: Where to direct the user in the case of a timeout. MUST be an ABSOLUTE path (e.g. "http://mySite/Timeout.html")
				<br> USAGE: <span class="code">objOAuth.TimeoutURL = "http://www.myOAuthSite.com/Timeout.html"</span>
				<p>
				<span class="objectProp">UserAgent</span> (Let)
				<br> REQUIRED: Varies (required for twitter implementation)
				<br> TYPE: String
				<br> DESCRIPTION: The "User-Agent" request header value (required for twitter implementation) 
				<br> USAGE: <span class="code">objOAuth.UserAgent = "Your Twitter App Name"</span>


<!-- PUBLIC Methods -->
				<p>
				<a name="publicMethods"></a>
				<hr><a href="#" style="font-size:.75em;float:right;">top</a>
				<p>
				<h2>Public Methods:</h2>
				<p>
				<span class="objectProp">Get_ResponseValue(strParamName)</span>
				<br> PARAMETERS: strParamName (string)
				<br> DESCRIPTION: Convenience method used to extract a value from a key=value pair returned by service provider.
				<br> RETURNS: strParamValue (string)
				<br> USAGE: <span class="code">objOAuth.Get_ResponseValue(strParamName)</span>
				<p>
				<span class="objectProp">Send()</span>
				<br> PARAMETERS: None
				<br> DESCRIPTION: Makes the call after all properties have been set.
				<br> RETURNS: Void
				<br> USAGE: <span class="code">objOAuth.Send()</span>

			</div>
			<script src="http://yui.yahooapis.com/3.1.0/build/yui/yui-min.js"></script>
			<script src="js/base.js"></script>

<!-- Comments -->
			<!-- disqus -->
			<p>
			<hr><a href="#" style="font-size:.75em;float:right;">top</a>
			<p>
			<div id="disqus_thread"></div>
			<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript=scottdesapio">comments powered by Disqus.</a></noscript>
			<a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>

		</div>

		<!-- add this (follow) -->
		<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-50999a7e7532ba59"></script> 

		<!-- po.st -->
		<script src="http://i.po.st/static/v3/post-widget.js#publisherKey=u1cs5h2lt8st2k11ampi" type="text/javascript"></script>			<p>

		<!-- disqus -->
		<script>
			var disqus_developer = (document.domain === 'localhost') ? true : false;

			(function() {

				// Step 1. Load Disqus
				var dsq = document.createElement('script'); 
					dsq.async = true;
					dsq.src = 'http://scottdesapio.disqus.com/embed.js';

				var el = (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]);
					el.appendChild(dsq);

				// Step 2. Get Comment Count
				var href = null;
				var links = document.getElementsByTagName('a');
				var query = '?';

				var i = links.length;
				while(i--){
					href = links[i].href;
				
					if(href.indexOf('#disqus_thread') >= 0) {
						query += 'url' + i + '=' + encodeURIComponent(href) + '&';
					}
				}
				document.write('<' + 'script charset="utf-8" src="http://disqus.com/forums/scottdesapio/get_num_replies.js' + query + '"></' + 'script>');
			})();
		</script>

		<!-- analytics -->
		<script type="text/javascript">
			var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
				document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
		</script>
		<script type="text/javascript">
			try {
				var pageTracker = _gat._getTracker("UA-5552188-15");
				pageTracker._trackPageview();
			} catch(err) {}
		</script>

	</body>
</html>
