<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

'//메뉴 고정을 위한 고정값
menuSet01 = "56" '메뉴의 menuParentIdx 값
menuSet02 = "57" '메뉴의 menuIdx 값

Set db = New DBMANAGER
WIth db

If idx <> "" Then

	'//조회
	.AddParam "idx", "bigint", "in", , idx
	.WHERE (" AND (idx = #idx#)")
	Call .GetRS(.GetQuery("notice", "selecttblNoticeList"), "text")

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

	<script type="text/javascript" src="/se2/js/HuskyEZCreator.js" charset="utf-8"></script>

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
            if (confirm("삭제 시 추후 복구가 불가능합니다.\n삭제 하시겠습니까?")) {
                var f = document.inputForm;
                f.mode.value = "delete";
                f.submit();
            } else {
				return;
			}
        }

		function setContent() {
			oEditors.getById["noticeContent"].exec("UPDATE_CONTENTS_FIELD", []);
		}

		function myTrim(x) {
			return x.replace(/^\s+|\s+$/gm,'');
		}

		function setTrim(obj) {
			//alert(obj.value);
			obj.value = myTrim(obj.value);
		}
    </script>
</head>

<!-- #include virtual = "/web.admin/include/common.asp" -->
<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
<form name="inputForm" method="post" action="data.asp" target="hiddenFrame" enctype="multipart/form-data" onsubmit="setContent();">
<input type="hidden" name="mode" value="<%=mode%>" />
<input type="hidden" name="flag" value="<%=flag%>" />
<input type="hidden" name="idx" value="<%=idx%>" />
<input type="hidden" name="ori_noticeFilePath" value="<%=rs_noticeFilePath%>" />

<div class="box">
	<div class="box-header with-border">
		<h3 class="box-title">공지사항 등록/수정</h3>
	</div><!-- /.box-header -->
	<div class="box-body">
		<table class="table table-bordered">
			<tr>
				<th style="width: 150px">제목</th>
				<td><span class="label label-danger">필수</span></td>
				<td><input type="text" class="form-control" placeholder="제목" name="noticeTitle" id="noticeTitle" maxlength="150" required="required" value="<%=util.htmlAllow(rs_noticeTitle) %>" onblur="setTrim(this);"/></td>
			</tr>
			<!--
			<tr>
				<th>구분</th>
				<td><span class="label label-primary">선택</span></td>
				<td>
					<select class="form-control" name="noticeHead" id="noticeHead" style="width:200px;">
						<option value="" <% If rs_noticeHead = "" Then %> selected<% End If %>>해당없음</option>
						<option value="공시" <% If rs_noticeHead = "공시" Then %> selected<% End If %>>공시</option>
					</select>
				</td>
			</tr>
			-->
			<input type="hidden" name="noticeHead" value="" />
			<tr>
				<th>상단여부</th>
				<td><span class="label label-primary">선택</span></td>
				<td><input type="checkbox" name="topYN" id="topYN" value="Y" <% If rs_topYN = "Y" Then %> checked<% End If %>>체크시에는 상단에 고정 공지됩니다.</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><span class="label label-danger">필수</span></td>
				<td>
					<textarea id="noticeContent" name="noticeContent" !required="required" style="width:100%; height:600px;"><%=util.htmlAllow(rs_noticeContent)%></textarea>
				</td>
			</tr>
			<!--
			<% If rs_noticeFilePath <> "" Then %>
			<tr>
				<th>기존 첨부파일</th>
				<td><span class="label label-primary">선택</span></td>
				<td>
					<input type="checkbox" name="op_del" id="op_del" value="Y" /><%=rs_noticeFilePath%> : 체크시 파일 삭제
				</td>
			</tr>
			<% End If %>
			<tr>
				<th>첨부파일</th>
				<td><span class="label label-primary">선택</span></td>
				<td>
					<input type="file" class="form-control" placeholder="첨부파일" name="noticeFilePath" id="noticeFilePath"  />
				</td>
			</tr>
			-->
			<tr>
				<th>사용여부</th>
				<td><span class="label label-danger">필수</span></td>
				<td>
					<input type="radio" name="useYN" value="Y" <% If rs_useYN = "Y" Or rs_useYN = "" Then %>checked<% End If %> />사용
					<input type="radio" name="useYN" value="N" <% If rs_useYN = "N" Then %>checked<% End If %> />사용하지 않음
				</td>
			</tr>
		</table>
	</div><!-- /.box-body -->
</div><!-- /.box -->

 <% if idx <> "" then %>
<div class="box">
	<div class="box-header with-border">
		<h3 class="box-title">기타정보</h3>
	</div><!-- /.box-header -->
	<div class="box-body">
		<table class="table table-bordered">
			<tr>
				<th style="width: 150px">구분</th>
				<td>공지사항</td>
				<th style="width: 150px">조회수</th>
				<td><%=rs_readCount%></td>
			</tr>
			<tr>
				<th>등록아이디</th>
				<td><%=rs_regAdminId%></td>
				<th>등록자명</th>
				<td><%=rs_regName%></td>
			</tr>
			<tr>
				<th>등록일시</th>
				<td><%=rs_regDate%></td>
				<th>등록시 IP</th>
				<td><%=rs_regIP%></td>
			</tr>
		</table>
	</div><!-- /.box-body -->
</div><!-- /.box -->
<% End If %>

                    <!-- /.box-body -->
                    <div class="box-footer">
                        <div class="pull-right">
                            <% if idx <> "" then %>
                            <button type="button" class="btn btn-danger" onclick="cDelete();"><i class="fa fa-trash-o"></i> Delete</button>
                            <% End If %>
							<button type="submit" class="btn btn-primary"><i class="fa fa-pencil"></i><% if idx <> "" then %>수정(Update)<% Else %>등록(Submit)<% End If %></button>
                            <a href="list.asp?page=<%=page%>&flag=<%=flag%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>&searchStartDate=<%=searchStartDate%>&searchEndDate=<%=searchEndDate%>" class="btn btn-default"><i class="fa fa-list"></i>목록이동(List)</a>
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

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "noticeContent",
    sSkinURI: "/se2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});
</script>

<!-- #include virtual = "/web.admin/include/footer.asp" -->
<%
End With
Set db = Nothing
%>
