<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

If USER_LOGIN_ID = "" Then
	Call util.MsgUrl ("로그인 후 이용 가능한 서비스입니다.","/etc/login.asp?returnUrl=/customer/onetoone_write.asp","")
End If 

'//기본검색기준
Set db = New DBMANAGER
WIth db

'//사용자
'USER_LOGIN_NO = session("purecotton_MEM_NO")
'USER_LOGIN_ID = session("purecotton_MEM_ID")
'USER_LOGIN_NAME = session("purecotton_MEM_NAME")
'USER_LOGIN_NICKNAME = session("purecotton_MEM_NICKNAME")

If idx <> "" Then

	'//조회
	.AddParam "idx", "bigint", "in", , idx
	.WHERE (" AND (idx = #idx#)")
	Call .GetRS(.GetQuery("voc", "selecttblVOCList"), "text")

	mode = "update"

	if USER_LOGIN_ID <> rs_vocID then
		Call util.MsgUrl ("본인의 작성 게시물 접근이 아닙니다.","/customer/onetoone.asp","")
	end if 

else

	mode = "insert"

End If
%>
<html lang="ko">
<head>
<!-- #include virtual = "/include/inc_header.asp" -->
<script type="text/javascript" src="/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/js/additional-methods.min.js"></script>
<script type="text/javascript" src="/js/localization/messages_ko.min.js"></script>

<script type="text/javascript">
	$(function () {
		$("inputForm").validate({
			//validation이 끝난 이후의 submit 직전 추가 작업할 부분
			submitHandler: function () {
				/*
				Codes
				*/
			}
		});
	})

	function myTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}

	function setTrim(obj) {
		//alert(obj.value);
		obj.value = myTrim(obj.value);
	}
</script>
</head>
<body>
<div id="wrap" class="sub">
	<!-- #include virtual = "/include/page_header.asp" -->

	<div id="container">
		<!-- #lnb -->
		<div id="lnb">
			<nav>
				<div class="wrap">
					<strong class="tit">고객센터</strong>
					<ul>
						<li><a href="/customer/noti_list.asp">공지사항</a></li>
						<li class="active"><a href="#">1:1 문의</a></li>
						<li><a href="javascript:goMyPage();">회원정보 수정</a></li>
					</ul>
				</div>
			</nav>
		</div>
		<!-- //#lnb -->

		<div class="contents">
			<h2 class="h2_tit">1:1 문의</h2><!-- 타이틀 -->

			<div class="onetooneWrap">
<form name="inputForm" method="post" action="/customer/onetoone_write_data.asp" target="hiddenFrame" enctype="multipart/form-data">

<input type="hidden" name="mode" value="<%=mode%>" />
<input type="hidden" name="idx" value="<%=idx%>" />
<input type="hidden" name="ori_vocFilePath01" value="<%=rs_vocFilePath01%>" />
<input type="hidden" name="ori_vocFilePath02" value="<%=rs_vocFilePath02%>" />
<input type="hidden" name="ori_vocFilePath03" value="<%=rs_vocFilePath03%>" />

<input type="hidden" name="fd" value="voc" />
<input type="hidden" name="vocFilePath01" id="vocFilePath01" value="" />
<input type="hidden" name="vocFilePath02" id="vocFilePath02" value="" />
<input type="hidden" name="vocFilePath03" id="vocFilePath03" value="" />

<input type="hidden" name="vocStatus" id="vocStatus" value="<%=rs_vocStatus%>" />

<input type="hidden" name="vocId" id="vocId" value="<%=USER_LOGIN_ID%>" />
<input type="hidden" name="vocName" id="vocName" value="<%=USER_LOGIN_NAME%>" />
<input type="hidden" name="vocEmail" id="vocEmail" value="<%=USER_LOGIN_EMAIL%>" />
<input type="hidden" name="vocPhone" id="vocPhone" value="<%=USER_LOGIN_MOBILE%>" />

			
				<ul class="dotList">
					<li>작성해 주신 1:1 문의 답변은 개인 이메일이나 <span class="point">고객센터 > 1:1 문의</span>를 통해 확인하실 수 있습니다.</li>
					<li>고객 문의가 많아 답변이 지연될 수 있는 점은 양해 바라며, 빠른 처리를 위해 노력하겠습니다.</li>
				</ul>
				<h3>1:1 문의 작성하기 </h3>
				<div class="writeBox">
					<ul>
						<li>
							<input type="text" id="vocTitle" name="vocTitle" required="required" maxlength="150" placeholder="제목을 작성해주세요. (필수)" value="<%=rs_vocTitle%>" onblur="setTrim(this);" />
						</li>
						<li>
							<div class="textarea">
								<textarea id="vocContent" name="vocContent" required="required" placeholder="내용을 입력해주세요. (필수)" onblur="setTrim(this);"><%=rs_vocContent%></textarea>
							</div>
						</li>
						<li>
							<div class="fileBox">
								<input type="text" class="fileName" id="fileName" readonly="readonly" placeholder="파일첨부" >
								<label for="uploadBtn" class="btn_file">파일찾기</label>
								<input type="file" id="uploadBtn" name="uploadBtn" class="uploadBtn">
								<span class="txt">1,000kb 이하 , 확장자 jpg/gif/png가능</span>
							</div>
							<ul class="fileList">
								<% If rs_vocFilePath01 <> "" Then %>
								<li>
									<img src="/upload/voc/<%=rs_vocFilePath01%>" alt="">
									<span class="fileName"><%=rs_vocFilePath01%></span>
									<a href="#none" class="btnDelete" onclick="fileDelete(this); return false;" data-file-name="<%=rs_vocFilePath01%>">삭제</a>
								</li>
								<% end if %>
								<% If rs_vocFilePath02 <> "" Then %>
								<li>
									<img src="/upload/voc/<%=rs_vocFilePath02%>" alt="">
									<span class="fileName"><%=rs_vocFilePath02%></span>
									<a href="#none" class="btnDelete" onclick="fileDelete(this); return false;" data-file-name="<%=rs_vocFilePath02%>">삭제</a>
								</li>
								<% end if %>
								<% If rs_vocFilePath03 <> "" Then %>
								<li>
									<img src="/upload/voc/<%=rs_vocFilePath03%>" alt="">
									<span class="fileName"><%=rs_vocFilePath03%></span>
									<a href="#none" class="btnDelete" onclick="fileDelete(this); return false;" data-file-name="<%=rs_vocFilePath03%>">삭제</a>
								</li>
								<% end if %>
							</ul>
						</li>
					</ul>
				</div>
				<div class="btnArea">
					<button type="submit" class="btn grey"><% If idx <> "" Then %>수정<% else %>등록<% end if %></button>
					<a href="/customer/onetoone.asp" class="btn">취소</a>
				</div>
			</div>
</form>
		</div><!-- //.contents -->
	</div>

	<!-- #include virtual = "/include/inc_footer.asp" -->

<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="/js/vendor/jquery.ui.widget.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="/js/jquery.fileupload.js"></script>

<script>
/*jslint unparam: true */
/*global window, $ */
$(function () {
    'use strict';
    // Change this to the location of your server-side upload handler:
	var url = '/include/jqueryUploader.asp';
	
	$('#uploadBtn').fileupload({
        url: url,
        dataType: 'json',
        done: function (e, data) {
			//alert(e + "/" + data + "/" + $(".file_area > p " ).length);
			if($(".fileList > li " ).length > 2) {
				alert("최대 3개까지 등록 가능합니다.");
				$("#fileName").val("");
			} else {
				$.each(data.result.files, function (index, file) {
					var fileHtml = "";
					//fileHtml += "<li>";
					fileHtml += "	<img src='/upload/voc/" + file.name + "'>";
					fileHtml += "	<span class='fileName'>" + file.name + "</span>";
					fileHtml += "	<a href='#none' class='btnDelete' onclick='fileDelete(this); return false;' data-file-name='" + file.name + "'>삭제</a>";
					//fileHtml += "</li>";
					
					$('<li>').html(fileHtml).appendTo('.fileList');
				
					switch($(".fileList > li " ).length) {
						case 1:
							$("#vocFilePath01").val(file.name);
							break;
						case 2:
							$("#vocFilePath02").val(file.name);
							break;
						case 3:
							$("#vocFilePath03").val(file.name);
							break;
					}

					$("#fileName").val("");
				});
			}
		}
    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');
});

function fileDelete(_this){
	//debugger;
	var num = $(_this).closest("li").index();
	switch(parseInt(num)) {
		case 1:
			$("#vocFilePath01").val("");
			break;
		case 2:
			$("#vocFilePath02").val("");
			break;
		case 3:
			$("#vocFilePath03").val("");
			break;
	}
	$(_this).parent().parent().remove();
	return false;
}
</script>

</div>
</body>
</html>
<%
End With
Set db = Nothing
%>