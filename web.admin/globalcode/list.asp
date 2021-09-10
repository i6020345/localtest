<!DOCTYPE html>
<!-- #include virtual = "/include/core/class.db.asp" -->
<%
'Call util.PrintParams()

'//메뉴 고정을 위한 고정값
menuSet01 = "0" '메뉴의 menuParentIdx 값
menuSet02 = "3" '메뉴의 menuIdx 값

Set db = New DBMANAGER
WIth db

If idx <> "" Then 

	'//조회
	.AddParam "codeIdx", "bigint", "in", , idx
	.WHERE (" AND (codeIdx = #codeIdx#)")
	Call .GetRS(.GetQuery("globalcode", "selecttblCodeList"), "text")

	mode = "update"

Else

	mode = "insert"

End If 
%>
<html>
<head>
    <!-- #include virtual = "/web.admin/include/header.asp" -->
	<script type="text/javascript" src="/web.admin/plugins/dtree/bootstrap-treeview.js"></script>

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

		function askEdit(num) {
			if(confirm("정말 수정하시겠습니까?")){
				location.href = "list.asp?idx=" + num;
			}
		}
    </script>
</head>

<!-- #include virtual = "/web.admin/include/common.asp" -->

        <!-- Main content -->
        <section class="content">
          <div class="row">
            <div class="col-md-6">
              <!--<a href="compose.html" class="btn btn-primary btn-block margin-bottom">Compose</a>-->
              <div class="box box-solid">
				<div id="treeMenus" class=""></div>
              </div><!-- /. box -->
            </div><!-- /.col -->
            <div class="col-md-6">

<div class="box box-primary">
<form name="inputForm" method="post" action="data.asp" target="hiddenFrame">
<input type="hidden" name="mode" value="<%=mode%>" />
<input type="hidden" name="idx" value="<%=idx%>" />

	<div class="box-header with-border">
		<h3 class="box-title">Global Code 관리</h3>
	</div><!-- /.box-header -->
	<div class="box-body">
		<table class="table table-bordered">
			<tr>
				<th style="width: 150px">항목</th>
				<th style="width: 40px">#</th>
				<th>#</th>
			</tr>
			<tr>
				<th>상위코드</th>
				<td><span class="label label-primary">선택</span></td>
				<td>
					<select class="form-control" name="parentCodeValue" id="parentCodeValue">
						<option value="" <% If rs_parentCodeValue = "" Then %> selected<% End If %>>최상위 코드</option>
						<%
						sSql = " SELECT  codeDepth, codeValue, codeName "
						sSql = sSql & " FROM     tblCode "
						sSql = sSql & " ORDER BY parentCodeValue, codeSort "
						Set sLst = .GetList(sSql,"text")

						For sNo = 0  To sLst("count")
							vCodeName = ""
							If CInt(sLst("codeDepth")(sNo)) > 1 Then 
								vCodeName = " - " & sLst("codeName")(sNo)
							Else
								vCodeName = sLst("codeName")(sNo)
							End If 
						%>
						<option value="<%=sLst("codeValue")(sNo) %>" <% If rs_parentCodeValue = sLst("codeValue")(sNo) Then %> selected<% End If %>><%=vCodeName%></option>
						<%
						Next
						Set sLst = Nothing 
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>코드명(국문)</th>
				<td><span class="label label-danger">필수</span></td>
				<td><input type="text" class="form-control" placeholder="코드명" name="codeName" id="codeName" maxlength="50" required="required" value="<%=rs_codeName%>" /></td>
			</tr>
			<tr>
				<th>코드명(영문)</th>
				<td><span class="label label-primary">선택</span></td>
				<td><input type="text" class="form-control" placeholder="코드명" name="codeNameEn" id="codeNameEn" maxlength="50" !required="required" value="<%=rs_codeNameEn%>" /></td>
			</tr>
			<tr>
				<th>코드명(중문)</th>
				<td><span class="label label-primary">선택</span></td>
				<td><input type="text" class="form-control" placeholder="코드명" name="codeNameCh" id="codeNameCh" maxlength="50" !required="required" value="<%=rs_codeNameCh%>" /></td>
			</tr>
			<tr>
				<th>코드명(일문)</th>
				<td><span class="label label-primary">선택</span></td>
				<td><input type="text" class="form-control" placeholder="코드명" name="codeNameJp" id="codeNameJp" maxlength="50" !required="required" value="<%=rs_codeNameJp%>" /></td>
			</tr>
			<tr>
				<th>설명</th>
				<td><span class="label label-primary">선택</span></td>
				<td><input type="text" class="form-control" placeholder="설명" name="codeText" id="codeText" maxlength="100" value="<%=rs_codeText%>" /></td>
			</tr>
			
			<tr>
				<th>사용여부</th>
				<td><span class="label label-danger">필수</span></td>
				<td>
					<input type="radio" name="codeUseYn" value="Y" <% If rs_codeUseYn = "Y" Or rs_codeUseYn = "" Then %>checked<% End If %> />사용
					<input type="radio" name="codeUseYn" value="N" <% If rs_codeUseYn = "N" Then %>checked<% End If %> />사용안함
				</td>
			</tr>
		</table>
	</div><!-- /.box-body -->
</div><!-- /.box -->

                <div class="box-footer no-padding">
                  <div class="mailbox-controls pull-right">
                    
					<button type="submit" class="btn btn-primary"><i class="fa fa-pencil"></i><% if idx <> "" then %>수정(Update)<% Else %>등록(Submit)<% End If %></button>

                  </div>


                </div>
</form>
              </div><!-- /. box -->




            </div><!-- /.col -->
          </div><!-- /.row -->
        </section><!-- /.content -->
<%
menuJsonData = ""

sqler = ""
sqler = sqler & " SELECT codeIdx, parentCodeValue, codeDepth, codeValue, codeName, codeSort, codeUseYn, codeText,  (SELECT COUNT(0) FROM tblCode WHERE (parentCodeValue = C.codeValue)) AS childCount "
sqler = sqler & " FROM tblCode AS C WITH (NOLOCK) "
sqler = sqler & " WHERE (codeDepth = 1) "
sqler = sqler & " ORDER BY parentCodeValue, codeSort "
Set tLst = .GetList(sqler,"text")

loopCodeValue = ""

For tNo = 0  To tLst("count")

	If loopCodeValue <> tLst("parentCodeValue")(tNo) Then
		'//코드가 변한거임
		If CInt(tNo) = 0 Then 
			menuJsonData = menuJsonData & "{"
		Else
			menuJsonData = menuJsonData & "},{"
		End If 

	Else
		
		menuJsonData = menuJsonData & ", "
		
	End If 

	menuJsonData = menuJsonData & "text: '" & tLst("codeName")(tNo) & "',href: 'javascript:askEdit(" & tLst("codeIdx")(tNo) & ")' "

	'//하위메뉴가 존재한다면
	If CInt(tLst("childCount")(tNo)) > 0 Then

		sqlerSub = ""
		sqlerSub = sqlerSub & " SELECT codeIdx, parentCodeValue, codeDepth, codeValue, codeName, codeSort, codeUseYn, codeText,  (SELECT COUNT(0) FROM tblCode WHERE (parentCodeValue = C.codeValue)) AS childCount "
		sqlerSub = sqlerSub & " FROM tblCode AS C WITH (NOLOCK) "
		sqlerSub = sqlerSub & " WHERE (parentCodeValue = '" & tLst("parentCodeValue")(tNo) & "') AND (codeDepth = 2) "
		sqlerSub = sqlerSub & " ORDER BY parentCodeValue, codeSort "
		Set sLst = .GetList(sqlerSub,"text")

		For sNo = 0  To sLst("count")
			
			If CInt(sNo) = 0 Then 
				menuJsonData = menuJsonData & ", nodes: ["
			End If 

			If  CInt(sNo) < CInt(tLst("childCount")(tNo)) And CInt(sNo) > 0 Then
				menuJsonData = menuJsonData & ","	
			End If 
			
			menuJsonData = menuJsonData & "{text: '" & sLst("codeName")(sNo) & "',href: 'javascript:askEdit(" & sLst("codeIdx")(sNo) & ")'}"

			If CInt(sNo) + 2 = CInt(tLst("childCount")(tNo)) Then 
				menuJsonData = menuJsonData & "]"
			End If 

		Next 

		Set sLst = Nothing 

		
		
	End If 

	loopCodeValue = tLst("parentCodeValue")(tNo)

Next 

menuJsonData = menuJsonData & "}"

Set tLst = Nothing 
%>

  	<script type="text/javascript">
		$(function() {

        var menusData = [
		  <%=menuJsonData%>
		  /*
		  {
            text: 'Parent 1',
            nodes: [
              {
                text: 'Child 1',
                nodes: [
                  {
                    text: 'Grandchild 1',
                  },
                  {
                    text: 'Grandchild 2',
                  }
                ]
              },
              {
                text: 'Child 2',
              }
            ]
          }
		  ,
          {
            text: 'Parent 2'
          },
          {
            text: 'Parent 3'
          },
          {
            text: 'Parent 4'
          },
          {
            text: 'Parent 5'
          }
		  */
        ];

        $('#treeMenus').treeview({
          color: "#428bca",
          showBorder: false,
		  enableLinks: true,
          data: menusData
        });

	});
</script>

<!-- #include virtual = "/web.admin/include/footer.asp" -->

<%
End With
Set db = Nothing
%>
