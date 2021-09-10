<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

'//메뉴 고정을 위한 고정값
menuSet01 = "56" '메뉴의 menuParentIdx 값
menuSet02 = "57" '메뉴의 menuIdx 값

'//기본검색기준
searchType = "noticeTitle"

Set db = New DBMANAGER
WIth db

'//고정값
flag = 1
.WHERE (" AND (flag = " & flag & ") ")

If searchKey <> "" Then 
	.AddParam "sKey", "varchar", "in", 50, searchKey
	
	If searchType <> "" Then 
		.WHERE (" AND (" & searchType & " like '%' + #sKey# + '%')")
	Else
		.WHERE (" AND ( (noticeTitle like '%' + #sKey# + '%') OR (noticeContent like '%' + #sKey# + '%') ) ")
	End If 
End If 

If searchStartDate <> "" Then
	.WHERE (" AND  (CONVERT(CHAR(10), regDate, 23) >= '" & searchStartDate & "') ")
End If 

If searchEndDate <> "" Then
	.WHERE (" AND  (CONVERT(CHAR(10), regDate, 23) <= '" & searchEndDate & "') ")
End If 

sql = .WithPage(.GetQuery("notice", "selecttblNoticeList"),page, FRONT_BOARD_LIST_COUNT)
Set lst = .GetList(sql,"text")
%>
<html>
<head>
    <!-- #include virtual = "/web.admin/include/header.asp" -->
	<script type="text/javascript">
		$(function(){
			$("#check_all").click(function(){
				var chk = $(this).is(":checked");//.attr('checked');
				if(chk) $(".table input").prop('checked', true);
				else  $(".table input").prop('checked', false);
			});
		});

		function listProcess(mode) {
			var f = document.listForm;

			if (getListCheckValue() == false) {
				alert("선택된 항목이 없습니다.");
				return;
			} else {
				if (confirm("삭제 시 추후 복구가 불가능합니다.\n삭제 하시겠습니까?")) {
					f.mode.value = mode;
					f.submit();
				}
			}
		}

		function getListCheckValue() {
			var isChecked = false;
			
			$("input:checkbox[name=idxs]:checked").each(function () {
				isChecked = true;
			});

			return isChecked;
		}
	</script>
</head>

<!-- #include virtual = "/web.admin/include/common.asp" -->

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">


<div class="box">
	<div class="box-header with-border">
		<h3 class="box-title">검색조건</h3>
	</div><!-- /.box-header -->
	<div class="box-body">
		<table class="table table-bordered">
<form name="searchForm" method="get" action="?">
			<tr>
				<th style="vertical-align: middle;text-align:center;width:100px;">검색시작일</th>
				<td style="vertical-align: middle;text-align:center;width:150px;">
					<input type="text" class="form-control" placeholder="검색시작일" name="searchStartDate" id="searchStartDate" maxlength="10" value="<%=searchStartDate%>" />
				</td>
				<th style="vertical-align: middle;text-align:center;width:100px;">검색종료일</th>
				<td style="vertical-align: middle;text-align:center;width:150px;">
					<input type="text" class="form-control" placeholder="검색종료일" name="searchEndDate" id="searchEndDate" maxlength="10" value="<%=searchEndDate%>" />
				</td>
				<th style="vertical-align: middle;text-align:center;width:100px;">검색어</th>
				<td style="vertical-align: middle;text-align:center;">
					<div class="input-group">
						<input type="text" name="searchKey" id="searchKey" class="form-control input-sm pull-right" placeholder="제목 / 내용으로 검색됩니다." value="<%=searchKey%>" />
						<div class="input-group-btn">
							<button class="btn btn-sm btn-default" onclick="document.searchForm.submit();"><i class="fa fa-search"> Search </i></button>
						</div>
					</div>
				</td>
			</tr>
</form>
		</table>
	</div><!-- /.box-body -->
</div><!-- /.box -->

			<div class="box">
				<!-- /.box-header -->
<form name="listForm" method="post" action="data.asp" target="hiddenFrame"  enctype="multipart/form-data" >
<input type="hidden" name="mode" value="listdelete" />
<input type="hidden" name="flag" value="<%=flag%>" />
<input type="hidden" name="searchStartDate" value="<%=searchStartDate%>" />
<input type="hidden" name="searchEndDate" value="<%=searchEndDate%>" />
<input type="hidden" name="searchType" value="<%=searchType%>" />
<input type="hidden" name="searchKey" value="<%=searchKey%>" />
                <div class="box-body">
                    <table class="table table-bordered">
                        <tr>
                            <th style="width: 5%; text-align: center;"><input type='checkbox' id='check_all' class='input_check' /></th>
							<th style="width: 5%; text-align: center;">No</th>
                            <th style="width: 10%; text-align: center;">상위노출</th>
							<th style="text-align: center;">제목</th>
                            <th style="width: 10%; text-align: center;">첨부유무</th>
							<th style="width: 10%; text-align: center;">작성자</th>
							<th style="width: 10%; text-align: center;">조회수</th>
							<th style="width: 10%; text-align: center;">등록일</th>
                        </tr>
                        <%
						printListNo = cfg.listNo

						For n = 0 To lst("count")
							'//idx, flag, topYN, noticeTitle, noticeContent, noticeFilePath, noticeHead, readCount, useYN, regAdminId, regName, regDate, regIP, dateDiffCnt
							If lst("noticeHead")(n) <> "" Then
								noticeHeadStr = " [" & lst("noticeHead")(n) & "]"
							Else
								noticeHeadStr = ""
							End If 

							If lst("noticeFilePath")(n) <> "" Then
								noticeFilePathStr = "<i class='fa fa-fw fa-file'></i>"
							Else
								noticeFilePathStr = ""
							End If 

							If CInt(lst("dateDiffCnt")(n)) <= 3 Then
								newStr = " [N]"
							Else
								newStr = ""
							End If 
						%>
                        <tr>
                            <td style="text-align: center;"><input type="checkbox" name="idxs" value="<%=lst("idx")(n)%>" /></td>
							<td style="text-align: center;"><%=printListNo%></td>
                            <td style="text-align: center;"><%=lst("topYN")(n)%></td>
							<td><a href="form.asp?idx=<%=lst("idx")(n)%>&flag=<%=flag%>&page=<%=page%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>&searchStartDate=<%=searchStartDate%>&searchEndDate=<%=searchEndDate%>"><%=util.htmlAllow(lst("noticeTitle")(n)) %></a><%=noticeHeadStr%><%=newStr%></td>
							<td style="text-align: center;"><%=noticeFilePathStr%></td>
							<td style="text-align: center;"><%=lst("regName")(n)%></td>
							<td style="text-align: center;"><%=lst("readCount")(n)%></td>
							<td style="text-align: center;"><%=util.DateFormat(lst("regDate")(n),"YYYY.MM.DD")%></td> 
                        </tr>
                        <%
							printListNo = CInt(printListNo) - 1
                        Next 
                        Set lst = Nothing 

						If n = 0 Then 
                        %>
							<tr>
								<td style="text-align: center;" colspan="100">등록(검색) 된 결과가 없습니다.</td>
							</tr>
                        <%
						End If 
                        %>
                    </table>
                </div>
                <!-- /.box-body -->

                <% Call fnc.PageSet(FRONT_BOARD_LIST_COUNT, FRONT_BOARD_PAGGING_COUNT, "") %>
            </div>
            <!-- /.box -->
</form>
            <div class="text-right">
                <button class="btn btn-default" onclick="location.href='form.asp?flag=<%=flag%>&page=<%=page%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>&searchStartDate=<%=searchStartDate%>&searchEndDate=<%=searchEndDate%>'"><i class="fa fa-pencil"></i>공지사항 등록</button>

				<button class="btn btn-default" onclick="listProcess('listdelete');"><i class="fa fa-trash-o"></i>선택삭제</button>
            </div>

        </div>
        <!-- /.col -->


    </div>
    <!-- /.row -->


</section>
<!-- /.content -->
<script type="text/javascript">
    $('#searchStartDate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });

	$('#searchEndDate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
</script>


<!-- #include virtual = "/web.admin/include/footer.asp" -->

<%
End With
Set db = Nothing
%>
