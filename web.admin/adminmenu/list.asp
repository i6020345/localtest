<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

'//메뉴 고정을 위한 고정값
menuSet01 = "0" '메뉴의 menuParentIdx 값
menuSet02 = "2" '메뉴의 menuIdx 값

Set db = New DBMANAGER
WIth db

'sql = .WithPage(.GetQuery("adminmenu", "selecttblMenuList"),page, FRONT_BOARD_LIST_COUNT)
sql = .GetQuery("adminmenu", "selecttblMenuList")
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

                <div class="box-body">
                    <table class="table table-bordered">
                        <tr>
                            <th style="width: 5%; text-align: center;">menuNo</th>
                            <th style="text-align: center;">메뉴명</th>
                            <th style="width: 30%; text-align: center;">경로</th>
                            <th style="width: 10%; text-align: center;">새창</th>
                            <th style="width: 10%; text-align: center;">사용</th>
                        </tr>
                        <%
					printListNo = cfg.listNo

					For n = 0 To lst("count")
						'//menuIdx, menuParentIdx, menuIcon, menuIconColor, menuName, menuURL, menuGroupNo, menuLevel, menuSortNo, isMenu, isBlank, isUse

						If CInt(lst("menuLevel")(n)) = 1 Then
							trBgColor = "#b8c7ce"
						Else
							trBgColor = "#ffffff"
						End If 

						levelStr = ""
						For i = 2 To CInt(lst("menuLevel")(n))
							levelStr = levelStr & "&nbsp;└&nbsp;"
						Next 
                        %>
                        <tr style="background-color:<%=trBgColor%>;">
                            <td style="text-align: center;"><%=lst("menuIdx")(n)%></td>
                            <td><%=levelStr%><a href="form.asp?idx=<%=lst("menuIdx")(n)%>&page=<%=page%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>"><%=lst("menuName")(n)%></a></td>
							<td style="text-align: center;"><%=lst("menuURL")(n)%></td>
							<td style="text-align: center;"><%=lst("isBlank")(n)%></td>
							<td style="text-align: center;"><%=lst("isUse")(n)%></td>
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

                <%' Call fnc.PageSet(FRONT_BOARD_LIST_COUNT, FRONT_BOARD_PAGGING_COUNT, "") %>
            </div>
            <!-- /.box -->

            <div class="text-right">
                <button class="btn btn-default" onclick="location.href='form.asp?page=<%=page%>&searchType=<%=Server.URLEncode(searchType)%>&searchKey=<%=Server.URLEncode(searchKey)%>'"><i class="fa fa-pencil"></i>메뉴 등록</button>
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
