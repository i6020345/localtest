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
	.AddParam "menuIdx", "bigint", "in", , idx
	.WHERE (" AND (menuIdx = #menuIdx#)")
	Call .GetRS(.GetQuery("adminmenu", "selecttblMenuList"), "text")

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

		function cDelete() {
			if(confirm("삭제 시 추후 복구가 불가능합니다.\n삭제 하시겠습니까?")){
				var f = document.inputForm;
				f.mode.value = "delete";
				f.submit();
			} else {
				return;
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
		<h3 class="box-title">관리자 메뉴 수정/조회</h3>
	</div><!-- /.box-header -->
	<div class="box-body">
		<table class="table table-bordered">
			<tr>
				<th style="width: 150px">항목</th>
				<th style="width: 40px">#</th>
				<th>#</th>
			</tr>
			<tr>
				<th>상위메뉴</th>
				<td><span class="label label-primary">선택</span></td>
				<td>
					<select class="form-control" name="menuParentIdx" id="menuParentIdx">
						<option value="<%=idx%>" <% If rs_menuParentIdx = "" Then %> selected<% End If %>>최상위메뉴</option>
						<%
						sSql = " SELECT  menuIdx, menuName "
						sSql = sSql & " FROM     tblMenu "
						sSql = sSql & " WHERE  (menuLevel = 1) "
						sSql = sSql & " ORDER BY menuSortNo "
						Set sLst = .GetList(sSql,"text")

						For sNo = 0  To sLst("count")
						%>
						<option value="<%=sLst("menuIdx")(sNo) %>" <% If CInt(rs_menuParentIdx) = CInt(sLst("menuIdx")(sNo)) Then %> selected<% End If %>><%=sLst("menuName")(sNo) %></option>
						<%
						Next
						Set sLst = Nothing 
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>메뉴명</th>
				<td><span class="label label-danger">필수</span></td>
				<td><input type="text" class="form-control" placeholder="메뉴명" name="menuName" id="menuName" maxlength="100" required="required" value="<%=rs_menuName%>" /></td>
			</tr>
			<tr>
				<th>경로</th>
				<td><span class="label label-danger">필수</span></td>
				<td><input type="text" class="form-control" placeholder="경로" name="menuURL" id="menuURL" maxlength="150" required="required" value="<%=rs_menuURL%>" /></td>
			</tr>
			<tr>
				<th>아이콘</th>
				<td><span class="label label-primary">선택</span></td>
				<td>
					<input type="radio" name="menuIcon" value="fa-desktop" <% If rs_menuIcon = "fa-desktop" Then %>checked<% End If %> /><i class="fa fa-desktop"></i>
					<input type="radio" name="menuIcon" value="fa-folder-o" <% If rs_menuIcon = "fa-folder-o" Then %>checked<% End If %> /><i class="fa fa-folder-o"></i>
					<input type="radio" name="menuIcon" value="fa-plus" <% If rs_menuIcon = "fa-plus" Then %>checked<% End If %> /><i class="fa fa-plus"></i>
					<input type="radio" name="menuIcon" value="fa-minus" <% If rs_menuIcon = "fa-minus" Then %>checked<% End If %> /><i class="fa fa-minus"></i>
					<input type="radio" name="menuIcon" value="fa-ellipsis-h" <% If rs_menuIcon = "fa-ellipsis-h" Then %>checked<% End If %> /><i class="fa fa-ellipsis-h"></i>
					<input type="radio" name="menuIcon" value="fa-star" <% If rs_menuIcon = "fa-star" Then %>checked<% End If %> /><i class="fa fa-star"></i>
				</td>
			</tr>
			<tr>
				<th>새창여부</th>
				<td><span class="label label-danger">필수</span></td>
				<td>
					<input type="radio" name="isBlank" value="Y" <% If rs_isBlank = "Y" Then %>checked<% End If %> />새창
					<input type="radio" name="isBlank" value="N" <% If rs_isBlank = "N" Or rs_isBlank = "" Then %>checked<% End If %> />새창아님
				</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td><span class="label label-danger">필수</span></td>
				<td>
					<input type="radio" name="isUse" value="Y" <% If rs_isUse = "Y" Or rs_isUse = "" Then %>checked<% End If %> />사용
					<input type="radio" name="isUse" value="N" <% If rs_isUse = "N" Then %>checked<% End If %> />사용안함
				</td>
			</tr>
		</table>
	</div><!-- /.box-body -->
</div><!-- /.box -->

                    <!-- /.box-body -->
                    <div class="box-footer">
                        <div class="pull-right">
                            <% if idx <> "" then %>
							<button type="button" class="btn btn-danger" onclick="cDelete();"><i class="fa fa-trash-o"></i> Delete</button>
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
    <!-- /.row -->
	 
</section>
<!-- /.content -->
<!-- #include virtual = "/web.admin/include/footer.asp" -->


<%
End With
Set db = Nothing
%>