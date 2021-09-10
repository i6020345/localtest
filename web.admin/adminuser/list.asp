<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

'//메뉴 고정을 위한 고정값
menuSet01 = "0" '메뉴의 menuParentIdx 값
menuSet02 = "1" '메뉴의 menuIdx 값

'//기본검색기준
searchType = "adminName"

Set db = New DBMANAGER
WIth db

If searchKey <> "" Then 
	If searchType <> "" Then 
		.AddParam "sKey", "varchar", "in", 50, searchKey
		If searchType <> "" Then 
			.WHERE (" AND (" & searchType & " like '%' + #sKey# + '%')")
		End If 
	End If 
End If 

sql = .WithPage(.GetQuery("admin", "selecttblAdminInfoList"),page, FRONT_BOARD_LIST_COUNT)
Set lst = .GetList(sql,"text")
%>
<html>
<head>
    <!-- #include virtual = "/web.admin/include/header.asp" -->
</head>

<!-- #include virtual = "/web.admin/include/common.asp" -->

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">

                <div class="box-header with-border">
                    <form name="searchForm" method="post" action="?">
                        <input type="hidden" name="flag" value="<%=flag%>" />
                        <h3 class="box-title">&nbsp;</h3>
                        <div class="box-tools">
                            <div class="input-group" style="width: 150px;">
                                <input type="text" name="searchKey" id="searchKey" class="form-control input-sm pull-right" placeholder="Search" value="<%=searchKey%>" />
                                <div class="input-group-btn">
                                    <button class="btn btn-sm btn-default" onclick="document.searchForm.submit();"><i class="fa fa-search"> Search </i></button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- /.box-header -->

                <div class="box-body">
                    <table class="table table-bordered">
                        <tr>
                            <th style="width: 5%; text-align: center;">#</th>
                            <th style="text-align: center;">아이디(메일주소)</th>
                            <th style="width: 10%; text-align: center;">이름</th>
                            <th style="width: 15%; text-align: center;">최근접속</th>
                            <th style="width: 10%; text-align: center;">접속수</th>
                            <th style="width: 10%; text-align: center;">관리등급</th>
                            <th style="width: 10%; text-align: center;">등록일</th>
                        </tr>
                        <%
					printListNo = cfg.listNo

					For n = 0 To lst("count")
						'//idx, adminId, adminName, adminPassword, adminLastLoginDate, adminLevel, adminLoginCount, adminMenuPermission, adminIPPermission, regDate, regIP

						If lst("adminLevel")(n) = "0" Then
							adminLevelStr = "최고관리등급"
						Else
							adminLevelStr = "관리사용자"
						End If 
                        %>
                        <tr>
                            <td style="text-align: center;"><%=printListNo%></td>
                            <td><a href="form.asp?idx=<%=lst("idx")(n)%>&page=<%=page%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>"><%=lst("adminId")(n)%></a></td>
							<td style="text-align: center;"><%=lst("adminName")(n)%></td>
							<td style="text-align: center;"><%=lst("adminLastLoginDate")(n)%></td>
							<td style="text-align: center;"><%=lst("adminLoginCount")(n)%></td>
							<td style="text-align: center;"><%=adminLevelStr%></td>
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

            <div class="text-right">
                <button class="btn btn-default" onclick="location.href='form.asp?page=<%=page%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>'"><i class="fa fa-pencil"></i>관리자 등록</button>
            </div>

        </div>
        <!-- /.col -->


    </div>
    <!-- /.row -->


</section>
<!-- /.content -->

<!-- #include virtual = "/web.admin/include/footer.asp" -->

<%
End With
Set db = Nothing
%>
