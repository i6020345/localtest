<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
Set db = New DBMANAGER
WIth db

nonSessionCheck = "Y"
%>
<html>
<head>
<!-- #include virtual = "/web.admin/include/header.asp" -->
<link rel="stylesheet" href="/web.admin/plugins/iCheck/square/blue.css">
<script src="/web.admin/plugins/iCheck/icheck.min.js"></script>

<!--jquery.validate-->
<script type="text/javascript" src="/web.admin/plugins/validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="/web.admin/plugins/validation/additional-methods.min.js"></script>
<script type="text/javascript" src="/web.admin/plugins/validation/localization/messages_ko.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#inputForm").validate({
            errorElement: "div",
			//validation이 끝난 이후의 submit 직전 추가 작업할 부분
            submitHandler: function(form) {
                return true;
            },
			//규칙
            rules: {
				adminId: {
                    required : true,
                    minlength : 5,
                    email : true
                },
                adminPassword: {
                    required : true,
                    minlength : 3
                }
            },
            //규칙체크 실패시 출력될 메시지
            messages : {
                adminId: {
                    required : "필수로입력하세요",
                    minlength : "최소 {0}글자이상이어야 합니다",
                    email : "메일규칙에 어긋납니다"
                },
                adminPassword: {
                    required : "필수로입력하세요",
                    minlength : "최소 {0}글자이상이어야 합니다"
                }
            }
		});
	})
</script>
</head>
  <body class="login-page">
    <div class="login-box">
      <div class="login-logo">
        <a href="#"><b>local</b>관리자</a>
      </div><!-- /.login-logo -->
      <div class="login-box-body">
        <p class="login-box-msg">관리자 계정을 입력해주세요.</p>
<form name="inputForm" id="inputForm" method="post" action="data.asp" !target="hiddenFrame">
<input type="hidden" name="returnUrl" value="<%=returnUrl%>" />
<input type="hidden" name="mode" value="login" />
          <div class="form-group has-feedback">
            <input type="email" class="form-control" placeholder="아이디" name="adminId" id="adminId" maxlength="130" required="required" />
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <input type="password" class="form-control" placeholder="비밀번호" name="adminPassword" id="adminPassword" required="required" />
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>
          <div class="row">
            <div class="col-xs-8">
              <div class="checkbox icheck">
                <label>
                  <!--<input type="checkbox"> Remember Me-->
                </label>
              </div>
            </div><!-- /.col -->
            <div class="col-xs-4">
              <button type="submit" class="btn btn-primary btn-block btn-flat">로그인</button>
            </div><!-- /.col -->
          </div>
</form>

      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->
	<script>
      $(function () {
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%' // optional
        });
      });
    </script>

<iframe name="hiddenFrame" src="" id="hiddenFrame" frameborder="0" width="0" height="0"></iframe>
  </body>
</html>
<%
End With
Set db = Nothing
%>