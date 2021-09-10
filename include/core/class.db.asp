<!-- #INCLUDE VIRTUAL = "/include/core/class.util.asp" -->
<%

'PV INSERT
Dim KIND_AGENT
KIND_AGENT = UCase(Request.ServerVariables("HTTP_USER_AGENT")) 
Dim kind
If InStr(KIND_AGENT, "ANDROID") > 0 Then
	kind = "M"
ElseIf InStr(KIND_AGENT, "IPAD") Or InStr(KIND_AGENT, "IPHONE") Then
	kind = "M"
Else
	kind = "W"
End If

Dim pvpage, page_diet
page_diet = Request.ServerVariables("SCRIPT_NAME")
pvpage = page_diet
If Request.ServerVariables("QUERY_STRING") <> "" Then
	pvpage = page_diet & "?" &  Request.ServerVariables("QUERY_STRING")
End if

Dim rfromurl
rfromurl = ""
rfromurl = request.QueryString("fromurl")
If rfromurl <> "" Then
	Response.Cookies("fromurl") = rfromurl
Else
	If Request.Cookies("fromurl") <> "" Then
		rfromurl = Request.Cookies("fromurl")
	End if
End if

Dim pvClientIP
pvClientIP = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If pvClientIP = "" Then 
pvClientIP = Request.ServerVariables("REMOTE_HOST")
End If 

'Set dbPV = Server.CreateObject("ADODB.Connection")
'dbPV.ConnectionString = "provider=SQLOLEDB;Data Source=127.0.0.1,1433;Initial Catalog=;User Id=;Password="
'dbPV.Open'
'
'sql = "INSERT INTO [dbo].[tblPv]([kind],[page],[page_diet],[ip],[referer],[fromurl],[agent],[regday],[regdate]) "
'sql = sql & "VALUES('" & kind & "','" & pvpage & "','" & page_diet & "','" & pvClientIP & "','" & Request.ServerVariables("HTTP_REFERER") & "','" & rfromurl & "','" & Request.ServerVariables("HTTP_USER_AGENT") & "', getdate(), getdate())"
'
'dbPV.Execute sql
'
'dbPV.Close
'Set dbPV = Nothing

Class DBMANAGER

	Private	ConnectionString, ConnectionObject,Transaction
	Private	rs, cmd, dic, arrLst, parsArr, parsDic, parsClear, AddWhere, exeQuery
	Public	rsData, listNo, queryDebug

	'** 생성자
	Public Sub Class_Initialize ()
		Set parsDic = Server.CreateObject("Scripting.Dictionary")
		parsDic.CompareMode = 1
		Transaction				= cfg.Transaction_			' 트랜잭션 여부 (true, false)
		ConnectionString_	= ""				' Database Connection String
		Call Connect ()							' Database Connection
		parsClear = True
		queryDebug = False
	End Sub

	'** 소멸자
	Public Sub Class_Terminate ()
		Set parsDic	= Nothing
		Call Commit ()

		If VarType(ConnectionObject) = vbString Then
			If ConnectionObject.state Then ConnectionObject.Close
			Set ConnectionObject = Nothing
		End If
	End Sub

	'** Transaction 실행
	Public Property Let Transaction_(v)
		Transaction			= True
	End Property

	Public Property Let parsClear_(v)
		parsClear = v
	End Property

	Private Property Let ConnectionString_(v)
		ConnectionString = "provider=SQLOLEDB;Data Source=" & cfg.DatabaseServer_ & ";Initial Catalog=" & cfg.DatabaseName_ & ";User Id=" & cfg.DatabaseUser_ & ";Password=" & cfg.DatabasePassword_
	End Property

	'** Database Connection
	Private Sub Connect ()
		If Not isObject(ConnectionObject) Then
			Set ConnectionObject = Server.CreateObject("ADODB.Connection")
			ConnectionObject.Open ConnectionString
			If Transaction Then ConnectionObject.BeginTrans ()
		End If
	End Sub

	Public Sub StartTran ()
		Transaction = True
		ConnectionObject.BeginTrans ()
	End Sub


	'** ADO DATA TYPE
	Private Function ADODataTypes (byVal typ)
		Select Case UCASE(typ)
			Case "BIGINT"
				ADODataTypes = adBigInt
			Case "BINARY","TIMESTAMP"
				ADODataTypes = adBinary
			Case "BIT"
				ADODataTypes = adBoolean
			Case "CHAR"
				ADODataTypes = adChar
			Case "MONEY","SMALLMONEY"
				ADODataTypes = adCurrency
			Case "DATETIME","SMALLDATETIME"
				ADODataTypes = adDBTimeStamp
			Case "FLOAT"
				ADODataTypes = adDouble
			Case "UNIQUEIDENTIFIER"
				ADODataTypes = adGUID
			Case "INT"
				ADODataTypes = adInteger
			Case "IMAGE"
				ADODataTypes = adLongVarBinary
			Case "TEXT"
				ADODataTypes = adLongVarChar
			Case "NTEXT"
				ADODataTypes = adLongVarWChar
			Case "DECIMAL","NUMERIC"
				ADODataTypes = adNumeric
			Case "REAL"
				ADODataTypes = adSingle
			Case "SMALLINT"
				ADODataTypes = adSmallInt
			Case "TINYINT"
				ADODataTypes = adUnsignedTinyInt
			Case "VARBINARY"
				ADODataTypes = adVarBinary
			Case "VARCHAR"
				ADODataTypes = adVarChar
			Case "SQL_VARIANT"
				ADODataTypes = adVariant
			Case "NVARCHAR"
				ADODataTypes = adVarWChar
			Case "NCHAR"
				ADODataTypes = adWChar
		End Select
	End Function

	'** 파라미터 수집
	Private Function CollectParams (byVal cmd, byVal SQL)
'		If InStr(SQL, "#") = 0 Then 
'			Response.write "프로시저 타잎"
'		Else
'			Response.write "문자열 타잎"
'		End If 
		Set regEx = New RegExp
		regEx.IgnoreCase = True
		regEx.Global = True
		regEx.Pattern = "#[^#]*#"
		Set Matches = regEx.Execute(SQL)
		parsName = 1
		
		For Each Match in Matches
			itm = Replace(Match.Value,"#","")
			If parsDic.Exists(itm) Then
				cmd.Parameters.Append cmd.CreateParameter ("@PARAMS_" & parsName, parsDic.Item(itm)(1), parsDic.Item(itm)(2), parsDic.Item(itm)(3), parsDic.Item(itm)(4))
				SQL = Replace(SQL, Match.Value,"?",1,-1,1)

				parsName = parsName + 1
				If Err.Number <> 0 Or queryDebug Then
					Response.Write "Name : " & parsDic.Item(itm)(0) & "<br />" & vbCrLf
					Response.Write "Value : " & parsDic.Item(itm)(4) & "<br />" & vbCrLf
					Response.Write "Type : " & parsDic.Item(itm)(1) & "<br />" & vbCrLf
					Response.Write "InOut : " & parsDic.Item(itm)(2) & "<br />" & vbCrLf
					'Response.Write "Length : " & parsDic.Item(itm)(3) & "<br />" & vbCrLf
					Response.Write "Error : " & Err.Description & "<hr/>"
					'On Error Goto 0
				End If
			Else
				util.MsgBox ("\""" & Match.Value & "\"" (이)가 설정 되었으나 파라미터가 제공 되지 않았습니다.")
			End If
		Next

		On Error Goto 0
'		Response.Write SQL
		exeQuery = SQL
		Set Matches = Nothing
		Set regEx = Nothing
		Set CollectParams = cmd
	End Function

	'** CommandType 반환
	Private Function CommandType_ (byVal t)
		Select Case UCase(t)
			Case "TEXT"
				CommandType_ = adCmdText
			Case "SP"
				CommandType_ = adCmdStoredProc
		End Select
	End Function

	'** Transaction Commit
	Private Sub Commit ()
		If Transaction Then
			If ConnectionObject.Errors.Count > 0 Or Err.Number <> 0 Then
				ConnectionObject.RollbackTrans ()
			Else
				ConnectionObject.CommitTrans ()
			End If
		End If
	End Sub

	'** Transaction Rollback
	Public Sub Rollback()
		ConnectionObject.RollbackTrans ()
	End Sub

	'// 쿼리 실행
	Public Function ExecuteSQL (byVal SQL, byVal cmdType)
'		Response.write SQL & "<br/>"

		
		If Trim(SQL) = "" Then
			Response.Write "ExecuteSQL Error : 쿼리문이 전달 되지 않았습니다."
			Response.End
		End If
		'On Error Resume Next
		Set cmd = Server.CreateObject("ADODB.Command")
		With cmd
			Set cmd = CollectParams(cmd, SQL)
			.ActiveConnection	= ConnectionObject
			.CommandText		= exeQuery
			.CommandType		= CommandType_(cmdType)
			.Execute , , adExecuteNoRecords
		End With

		If Err.Number <> 0 Then
			Response.Write Err.Description & "<br />" & vbCrLf & vbCrLf & exeQuery & "<br />"
		End If
		On Error Goto 0
	    For i = 0 To cmd.Parameters.Count - 1
	      If cmd.Parameters(i).Direction = adParamOutput OR cmd.Parameters(i).Direction = adParamInputOutput OR cmd.Parameters(i).Direction = adParamReturnValue Then
	          ExecuteSQL = cmd.Parameters(i).Value
			  'If Err.Number <> 0 Then Response.Write Err.Description
	      End If
	    Next
		On Error Goto 0
		Set cmd.ActiveConnection = Nothing
		Set cmd = Nothing
	End Function

	'** 파라미터 세팅
	'* 파라미터명, 파라미터 타입(MSSQL DATA TYPE), (IN or OUT or INOUT), 데이타크기, 값)
	Public Sub AddParam (byVal name, byVal typ, byVal dir, byVal size, byVal value)
		If dir = "" Then dir = "IN"
		Select Case uCase(dir)
			Case "IN",""
				inout = adParamInput
			Case "OUT"
				inout = adParamOutput
			Case "INOUT"
				inout = adParamInOutput
		End Select

		If LCase(typ) = "text" Then size = 2147483647
		If (LCase(typ) = "int" Or LCase(typ) = "smallint" Or LCase(typ) = "tinyint") And isEmpty(value) ="" Then value = 0
		If parsDic.Exists(name) Then
			util.MsgBox "\""" & name & "\""키는 이미 할당 되어 있습니다.\n\n키값을 변경 하려면 \""DBMANAGER. EditParam\"" 함수를 이용하여 주세요."
		Else
			parsDic.Add name , Array (name, ADODataTypes(typ), inout, size, value)
		End If
	End Sub

	Public Sub EditParam (byVal name, byVal typ, byVal dir, byVal size, byVal value)
		If parsDic.Exists(name) Then parsDic.Remove(name)
		Call AddParam (name, typ, dir, size, value)
	End Sub

	Public Sub DelParam (byVal pars)
		parsArr = Split(pars,",")
		For n_ = 0 To UBound(parsArr)
			name = Trim(parsArr(n_))
			If parsDic.Exists(name) Then parsDic.Remove(name)
		Next
	End Sub

	'* 컬럼명에 접수다 "rs_"를 붙여 글로벌 변수화
	'* ※ 주위 : 컬럼명에 특수문자가 포함될시 에러 발생하므로 주의
	Private Sub DataFieldSet ()
		If Not rs.EOF Then
			rsData = True
			rsRows = rs.GetRows()
			
			For k__ = 0 To rs.Fields.Count - 1
				val = Trim(rsRows(k__,0))
				If isNull(val) Then val = ""
				'val = Replace(Replace(val,"'","&#39;"),"""","&quot;")

				'//이정규 수정 -- 시작
				'//원본 한줄 : val = util.htmlBlock(val)
				'----웹에디터에서 저장되는 필드같은경우 html의 자유도가 어느정도 필요함으로 htmlBlock를 사용하지 않게 해봄....
				'//여기서 htmlBlock를 사용하지 않을 필드를 체크해야함
				If InStr(cfg.IgnoreBlockHtml_,LCase(rs.Fields(k__).Name)) < 1 Then
					val = util.htmlBlock(val)
				End If 
				'//이정규 수정 -- 끝
				Execute ("rs_" & rs.Fields(k__).Name & " = val")
				val = Empty
			Next
		Else
			rsData = False
		End If
	End Sub

	'// 1개의 레코드를 부를 때 사용
	Public Sub GetRS (byVal SQL, byVal cmdType)
		On Error Resume Next
		Set cmd	= Server.CreateObject("ADODB.Command")
		Set rs		= Server.CreateObject("ADODB.RecordSet")
		rs.CursorLocation		= adUseClient
		With cmd
			Set cmd = CollectParams(cmd, SQL)
			.ActiveConnection	= ConnectionObject
			.CommandText		= exeQuery
			.CommandType		= CommandType_(cmdType)
		End With

		'Response.write exeQuery
		rs.Open cmd, , adOpenForwardOnly, adLockReadOnly,CommandType_(cmdType)
		If Err.Number <> 0 Then
			Response.Write "GetRS : 레코드 셋 오픈 에러<hr />"
			Response.Write Err.Description & "(" & Err.Number & ")"
			Response.Write "<br />Query : " & exeQuery & "<BR>"
		End If
		If Not rs.EOF And Not rs.BOF Then
			Call DataFieldSet ()
		End If
		rs.Close
		On Error Goto 0
		Set cmd.ActiveConnection = Nothing
		Set cmd = Nothing
		Set rs = Nothing
		exeQuery  = ""
	End Sub

	'** 리스트를 Dictionary 개체로 반환
	'** SQL : 저장프로시져명 또는 SQL문
	'** cmdType : "text" 또는 "sp"
	Public Function GetList (byVal SQL, byVal cmdType)
		Dim rsFields, Arr()
		Set rs_	= Server.CreateObject("Ador.RecordSet")
		Set cmd	= Server.CreateObject("Adodb.Command")
		Set dic	= Server.CreateObject("Scripting.Dictionary")
		dic.CompareMode = 1		'// 대소문자 구문 없이
		rs_.CursorLocation		= adUseClient
		With cmd
			Set cmd = CollectParams(cmd, SQL)
			.ActiveConnection	= ConnectionObject
			.CommandText		= exeQuery
			.CommandType		= CommandType_(cmdType)
'			.Execute , , adExecuteNoRecords
		End With
		IF queryDebug Then
			Response.Write "<pre class=""prettyprint lang-sql"">" & exeQuery & "</pre>"
		End If
		If Err.Number <> 0 Then
			Response.Write "Line 272<br />"
			Response.Write Err.Description
		End If
		rs_.Open cmd, , adOpenForwardOnly, adLockReadOnly, CommandType_(cmdType)
		On Error Goto 0
		If Not rs_.EOF And Not rs_.BOF Then
			rsRows = rs_.GetRows()
			rowCount = UBound(rsRows,2)
			dic.Add "Count",rowCount
			Set rsFields = rs_.Fields
			For cols = 0 To rsFields.Count - 1
				Set dic2	= Server.CreateObject("Scripting.Dictionary")
				For rows = 0 To rowCount
					dic2.Add rows, util.htmlBlock(rsRows(cols,rows))
				Next
				dic.Add rsFields(cols).Name, dic2
				Set dic2	= Nothing
				Erase Arr
			Next

			Dim out : out = 0
			For n_ = 0 To cmd.Parameters.Count - 1
				If cmd.Parameters(n_).Direction = adParamOutput OR cmd.Parameters(n_).Direction = adParamInputOutput OR cmd.Parameters(n_).Direction = adParamReturnValue Then
					out = out + 1
					dic.Add "output" & out, cmd.Parameters(n_).Value
				End If
			Next
			Set rsFields = Nothing
		Else
			dic.Add "Count",-1
		End If
		rs_.Close
		On Error Goto 0

		Set GetList	= dic
		Set dic		= Nothing
		Set rs_		= Nothing
		Set cmd.ActiveConnection = Nothing
		Set cmd		= Nothing
		exeQuery  = ""
	End Function

	Public Function GetQuery(byVal xml, byVal id)
		Application.Lock
		Application("GQM").Filter = "xml = '" & xml & "' AND id='" & id & "'"
		Dim query : query = "Query를 읽을수 없습니다.(" & xml & "." & id & ")"
		If Not Application("GQM").EOF Then query = Application("GQM").Fields.Item("text")
		GetQuery = query
		Application("GQM").Filter = adFilterNone
		GetQuery = Convertor(query)
		Application.UnLock
	End Function

	Private Function Convertor (byVal q)
		Dim query : query = Replace(q, "/*ADDWHERE*/", AddWhere,1,-1,1)
		AddWhere = ""
		Convertor = query
	End Function

	Public Sub WHERE (byVal w)
		AddWhere = AddWhere & (w)
	End Sub

	Public Function WithPage(byVal SQL, byVal pg, byVal vc)
		If pg = "" Then pg = 1
		IF queryDebug Then
			Response.Write "<pre class=""prettyprint lang-sql"">" & SQL & "</pre>"
		End If
		SQL = Trim(Replace((Replace(Replace(SQL,Chr(10)," "), Chr(9), "")), "  "," "))
		countSQL = "SELECT COUNT(*) cnt FROM (" &  Replace(SQL,"order by","/*order by",1, -1, 1) & "*/" & ") T "
		Call db.GetRS(countSQL,"text")
		orderByNum = inStr(uCase(SQL), "ORDER BY")
		If orderByNum < 1 Then
			Call util.MsgBox ("Order By절이 제공 되지 않았습니다.\n\n리스트형 쿼리는 반드시 Order By이 필요하며\n\n정렬 기준(ASC, DESC)도 반드시 명시 되어야 합니다.")
			Exit Function
		End If
		tmpSQL = Left(SQL, orderByNum-1)
		orderBySql = Mid(SQL,orderByNum)
		orderBySql = Replace(Replace(orderBySql,"DESC","_D_",1,-1,1),"ASC","_A_",1,-1,1)
		orderBySqlRev = Replace(Replace(orderBySql,"_D_","ASC",1,-1,1),"_A_","DESC",1,-1,1)
		orderBySql = Replace(Replace(orderBySql,"_D_","DESC",1,-1,1),"_A_","ASC",1,-1,1)

		maxPg = Int(rs_cnt / vc)
		If rs_cnt Mod vc <> 0 Then maxPg = maxPg + 1
		If CInt(pg) > maxPg Then pg = maxPg
		TopCount2 = vc * pg
		TopCount1 = vc
		If CInt(pg) = CInt(maxPg) Then
			TopCount1 = Int(rs_cnt Mod vc)
			If TopCount1 = 0 Then TopCount1 = vc
			TopCount2 = rs_cnt
		End If

		cfg.totalCount = rs_cnt
		cfg.listNo = rs_cnt - (pg-1) * vc
		listSQL = "SELECT * FROM (SELECT TOP (#TOP_COUNT_1#) * FROM (SELECT TOP(#TOP_COUNT_2#) " & Mid(tmpSQL, 7) & " " & orderBySql & ") T " & orderBySqlRev & ") T " & orderBySql
		'Response.Write listSQL

		db.AddParam "TOP_COUNT_1","INT", "", , TopCount1
		db.AddParam "TOP_COUNT_2","INT", "", , TopCount2

		WithPage = listSQL
	End Function
End Class
%>