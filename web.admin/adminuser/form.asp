<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

menuSet01 = "0" '메뉴의 menuParentIdx 값
menuSet02 = "1" '메뉴의 menuIdx 값

Set db = New DBMANAGER
WIth db

If idx <> "" Then 

	'//조회
	.AddParam "idx", "bigint", "in", , idx
	.WHERE (" AND (idx = #idx#)")
	Call .GetRS(.GetQuery("admin", "selecttblAdminInfoList"), "text")

	mode = "update"

Else

	mode = "insert"

End If 
%>
<html>
<head>
    <!-- #include virtual = "/web.admin/include/header.asp" -->
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
					}
				},
				//규칙체크 실패시 출력될 메시지
				messages : {
					adminId: {
						required : "필수로입력하세요",
						minlength : "최소 {0}글자이상이어야 합니다",
						email : "메일규칙에 어긋납니다"
					}
				}
			});
		})

		function cDelete() {
			if(confirm("삭제 시 추후 복구가 불가능합니다.\n삭제 하시겠습니까?")){
				var f = document.inputForm;
				f.mode.value = "delete";
				f.submit();
			} else {
				return;
			}
		}

		function groupCheck(obj) {
			var idxs = document.getElementsByName("adminMenuPermission");
			var idxs_length = idxs.length - 1;
			var group_num = obj.alt;
			var order = obj.title;
			var group_checked = 0;

			if (order == "1") {
				
				var checkTF;
				
				if (obj.checked) {
					checkTF = true;
				} else {
					checkTF = false;
				}

				for ( i = 0 ; i <= idxs_length ; i ++ ) {
					if (idxs[i].alt == group_num) {
						idxs[i].checked = checkTF;
					}
				}

			} else {
				
				var parentcheckTF;

				for ( i = 0 ; i <= idxs_length ; i ++ ) {
					if ( (idxs[i].alt == group_num) && (idxs[i].title != "0" )) {
						if (idxs[i].checked == true) {
							group_checked++;
						}
					}
				}

				if (group_checked > 0) {
					parentcheckTF = true;
				}  else {
					parentcheckTF = false;
				}

				for ( i = 0 ; i <= idxs_length ; i ++ ) {
					if ( (idxs[i].alt == group_num) && (idxs[i].title == "0") ) {
						idxs[i].checked = parentcheckTF;
					}
				}
			}
		}
    </script>
</head>

<!-- #include virtual = "/web.admin/include/common.asp" -->

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
<form name="inputForm" method="post" action="data.asp" target="hiddenFrame">
<input type="hidden" name="mode" value="<%=mode%>" />
<input type="hidden" name="idx" value="<%=idx%>" />

<div class="box">
	<div class="box-header with-border">
		<h3 class="box-title">관리자 정보 수정/조회</h3>
	</div><!-- /.box-header -->
	<div class="box-body">
		<table class="table table-bordered">
			<tr>
				<th style="width: 150px">항목</th>
				<th style="width: 40px">#</th>
				<th>#</th>
			</tr>
			<tr>
				<th>아이디(메일주소)</th>
				<td><span class="label label-danger">필수</span></td>
				<td><input type="text" class="form-control" placeholder="아이디" name="adminId" id="adminId" maxlength="50" required="required" value="<%=rs_adminId%>" /></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><span class="label label-danger">필수</span></td>
				<td><input type="text" class="form-control" placeholder="이름" name="adminName" id="adminName" maxlength="50" required="required" value="<%=rs_adminName%>" /></td>
			</tr>
			<tr>
				<th>비밀번호<% If idx <> "" Then %><br/>(입력시에만 변경)<% End If %></th>
				<td><span class="label label-primary">선택</span></td>
				<td><input type="password" class="form-control" placeholder="비밀번호" name="adminPassword" id="adminPassword" maxlength="50" value="" /></td>
			</tr>
			<tr>
				<th>관리자등급</th>
				<td><span class="label label-danger">필수</span></td>
				<td>
					<select class="form-control" name="adminLevel" id="adminLevel" required="required" style="width:200px;float:left;">
						<option value="" <% If rs_adminLevel = "" Then %>selected<% End If %>>등급</option>
						<option value="0" <% If rs_adminLevel = "0" Then %>selected<% End If %>>최고관리등급</option>
						<option value="1" <% If rs_adminLevel = "1" Then %>selected<% End If %>>관리사용자</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>접속가능IP<br/>(입력시 무조건 사용)</th>
				<td><span class="label label-primary">선택</span></td>
				<td>
					<span class="label label-primary">입력시에는 해당 IP만 접속가능(중복시 콤마로 구분 ex -> 1.1.1.1 , 2.2.2.2)</span><br/>
					<input type="text" class="form-control" placeholder="접속가능IP" name="adminIPPermission" id="adminIPPermission" maxlength="100" value="<%=rs_adminIPPermission%>" />
				</td>
			</tr>
		</table>
	</div><!-- /.box-body -->
</div><!-- /.box -->

<div class="box">
	<div class="box-header with-border">
		<h3 class="box-title">기타정보</h3>
	</div><!-- /.box-header -->
	<div class="box-body">
		<table class="table table-bordered">
			<tr>
				<th style="width: 150px">최근접속</th>
				<td><%=rs_adminLastLoginDate%></td>
			</tr>
			<tr>
				<th>등급</th>
				<td><%=rs_adminLevel%></td>
			</tr>
			<tr>
				<th>접속횟수</th>
				<td><%=rs_adminLoginCount%></td>
			</tr>
			<tr>
				<th>가입일시/IP</th>
				<td><%=rs_regDate%>/<%=rs_regIP%></td>
			</tr>
		</table>
	</div><!-- /.box-body -->
</div><!-- /.box -->

<div class="box">
	<div class="box-header with-border">
		<h3 class="box-title">메뉴 권한</h3>
	</div><!-- /.box-header -->
	<div class="box-body">
		<table class="table table-bordered">
			<tr>
				<th style="width:50px;text-align:center;">체크</th>
				<th>메뉴명</th>
			</tr>
			<%
			mSql = " SELECT menuIdx, menuName, menuURL, menuGroupNo, menuLevel "
			mSql = mSql & " FROM     tblMenu "
			mSql = mSql & " WHERE  (isUse = 'Y') "
			mSql = mSql & " ORDER BY menuGroupNo, menuLevel, menuSortNo "

			Set lst = .GetList(mSql,"text")

			For n = 0  To lst("count")
				If CInt(lst("menuLevel")(n)) = 1 Then
					trBgColor = "style='background-color:#b8c7ce;'"
				Else
					trBgColor = ""
				End If 

				If InStr(rs_adminMenuPermission, "|" & lst("menuIdx")(n) & "|") > 0 Then 
					PerTF = " checked"
				Else
					PerTF = ""
				End If 
			%>
			<tr <%=trBgColor%>>
				<th style="text-align:center;"><input type="checkbox" name="adminMenuPermission" value="|<%=lst("menuIdx")(n) %>|" <%=PerTF%> alt="<%=lst("menuGroupNo")(n)%>" title="<%=lst("menuLevel")(n)%>" onclick="groupCheck(this);" /></th>
				<td><%=lst("menuName")(n)%></td>
			</tr>
			<%
			Next
			Set lst = Nothing
			%>
		</table>
	</div><!-- /.box-body -->
</div><!-- /.box -->


                    <!-- /.box-body -->
                    <div class="box-footer">
                        <div class="pull-right">
                            <% if idx <> "" then %>
							<button class="btn btn-danger" onclick="cDelete();"><i class="fa fa-trash-o"></i> 삭제(Delete)</button>
							<% End If %>
							<button type="submit" class="btn btn-primary"><i class="fa fa-pencil"></i><% if idx <> "" then %>수정(Update)<% Else %>등록(Submit)<% End If %></button>
							<a href="list.asp?page=<%=page%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>&flag=<%=flag%>" class="btn btn-default"><i class="fa fa-list"></i>목록이동(List)</a>
                        </div>
                        <!--<button class="btn btn-default"><i class="fa fa-times"></i> Discard</button>-->
                    </div>
                    <!-- /.box-footer -->
                </div>
                <!-- /. box -->
        </div>
        <!-- /.col -->
</form>
    </div>

<!-- #include virtual = "/web.admin/include/footer.asp" -->


<%
End With
Set db = Nothing
%>