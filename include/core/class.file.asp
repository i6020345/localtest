<%
Class FILEMANAGER

	Private thumbEnable				'// 썸네일 사용여부	 (Boolean)
	Private thSizeFix						'// 썸네일 크기 강제 조정 (Boolean)
	Private thWidth						'// 썸네일 가로 크기 (Integer)
	Private thHeight						'// 썸네일 세로 크기 (Integer)
	Private maxUploadSize				'// 업로드 제한 용량(MBytes단위)
	Private maxImageWidth			'// 업로드 이미지 가로 제한
	Private UploadBlackList			'// 업로드시 제한될 파일 형식
	Private UploadWhiteList			'// 업로드시 가능한 파일 형식
	Private thPrefix						'// 썸네일 접두사
	Private RndFileName				'// 파일명 랜덤하게 생성 (Boolean)
	Private UploadObj

	Private Sub Class_Initialize ()
		
		' 기본 세팅
		'thumbEnable		= True
		thumbEnable		= False
		thSizeFix				= False
		thWidth				= 351
		thHeight			= 269
		maxUploadSize	= 30 * 1024 * 1024
		maxImageWidth	= 1200
		thPrefix				= "[th]"
		RndFileName		= False
		UploadBlackList	= ",asp,jsp,php,phps,htm,html,phtml,js,phtml,vbs,vb,aspx,asa,class,eml,sql,bat,cer,cdx,php3,war"
		UploadWhiteList	= ",zip,xls,xlsx,doc,docx,jpg,jpeg,gif,png,ppt,pptx,txt,csv,pdf,psd"

		If cfg.FileSaveRoot_	= "" Then Call util.MsgEnd ("Defailt Path가 지정 되지 않았습니다.")

		' 개체 생성
		Set UploadObj		= Server.CreateObject("DEXT.FileUpload")
		With UploadObj
			.DefaultPath		= cfg.FileSaveRoot_
			.AutoMakeFolder = True
			.UploadTimeout	= 300
			.CodePage			= 65001
		End With
		
		' 파라미터 설정
		Call GetParams ()
	End Sub

	Private Sub Class_Terminate ()
		Set UploadObj	= Nothing
	End Sub
	
	' 업로드 제한 용량 (MBytes 단위)
	Public Property Let maxUploadSize_ (byVal v)
		maxUploadSize	= v
	End Property

	' 썸네일 사이즈 픽스 여부 (True, False)
	Public Property Let thSizeFix_ (byVal v)
		thSizeFix			= v
	End Property

	' 썸네일 Width 사이즈
	Public Property Let thWidth_ (byVal v)
		thWidth			= v
	End Property

	' 썸네일 Height
	Public Property Let thHeight_ (byVal v)
		thHeight			= v
	End Property
	
	' 썸네일 생성 여부 (True, False)
	Public Property Let thumbEnable_ (byVal v)
		thumbEnable		= v
	End Property
	
	' 업로드 화이트 리스트 추가
	Public Property Let UploadWhiteList_(byVal v)
		UploadWhiteList = UploadWhiteList & "," & v
	End Property
	
	' 업로드 화이트 리스트 추가
	Public Property Let UploadWhiteListReset (byVal v)
		UploadWhiteList = v
	End Property

	' 썸네일 사이즈 컨트롤러
	Public Property Let thumbSizeController (byVal v)
		v				= Split(v,"*")
		thWidth_		= Trim(v(0))
		thHeight_		= Trim(v(1))
	End Property
	
	' 업로드 width 제한
	Public Property Let maxImageWidth_ (byVal v)
		maxImageWidth	 = v
	End Property
	
	' 썸네일 접두사 변경 
	Public Property Let thPrefix_ (byVal v)
		thPrefix	 = v
	End Property

	Public Property Let RndFileName_(byVal v)
		RndFileName	 = v
	End Property
	
	' 비율 계산
	Private Function RatioCalculator (byVal orgWidth, byVal orgHeight, byVal thW, byVal thH)
		Dim x1, x2, y1, y2
		x1 = orgWidth
		y1 = orgHeight
		x2 = 0
		y2 = 0
		If Int(x1) > Int(thW) Then
			x2 = thW : y2 = thH
			If Int(x1) >= Int(y1) Then y2 = Int((y1 * x2) / x1) Else x2 = Int((x1 * y2) / y1)
		Else
			x2 = x1 : y2 = y1
		End If
		retSize = x2 & "*" & y2
		RatioCalculator = Split(retSize,"*")
	End Function
	
	' 파리미터 변수화
	Private Sub GetParams ()
		For Each item In UploadObj.Form
			tmp = item.name
			If tmp <> "" Then
				If  InStr(cfg.IgnoreParams_,LCase(tmp)) < 1 Then
					If Not isNumeric(tmp) Then Execute (tmp & " = util.strCheck(Trim(UploadObj(tmp)))")
				End If
			End If
		Next
	End Sub
	
	' 파일명 추출
	Private Function GetOnlyFileName (byVal fnm)
		GetOnlyFileName = Left(fnm, InStrRev(fnm,".") -1)
	End Function
	
	' 파일명 중복 확인
	Private Function DuplicationCheck (byVal saveDir, byVal fileNm)
		Dim fExist, fCount, onlyName, onlyExt, CompName, FileFullPath
		
		fCount			= 1
		onlyName		= GetOnlyFileName (filenm)
		onlyExt			= Replace (filenm, onlyName, "",1, -1, 1)
		fExist				= True
		FileFullPath		= cfg.FileSaveRoot_ & saveDir & fileNm
		CompName	= filenm
		
		Do While fExist
			If UploadObj.FileExists (FileFullPath) Then
				fCount		= fCount + 1
				CompName	= onlyName & "(" & fCount & ")" & onlyExt
				FileFullPath	= cfg.FileSaveRoot_ & saveDir & CompName
			Else
				fExist			= False
			End If
		Loop
		DuplicationCheck	= CompName
	End Function
	
	' 파일명 랜덤 생성
	Private Function RandomFileName ()
		RandomFileName	= Replace(Date(),"-","") & util.RandomText (24,True)
	End Function
	
	'파일 업로드
	Public Function FileUpload (byVal obj, byVal saveDir)
		Dim uploadFileName, uploadFileSize, uploadFileMime, uploadFileExt, UploadFileWidth, UploadFileHeight, SaveFileName, uploadFileSizeText, multipleCount, returnValue, UploadObject
		
		saveDir					= Replace(saveDir, "/", "\") & "\"
		multipleCount			= UploadObj(obj).Count
		For mc = 1 To multipleCount
			If UploadObj(obj)(mc).FileName <> "" Then
				uploadFileName		= UploadObj(obj)(mc).FileName			'파일명
				uploadFileSize			= UploadObj(obj)(mc).FileLen				'파일크기
				uploadFileMime		= UploadObj(obj)(mc).MimeType			'Mime-type
				uploadFileExt			= UploadObj(obj)(mc).FileExtension		'확장자
				UploadFileWidth		= UploadObj(obj)(mc).ImageWidth		'이미지 Width
				UploadFileHeight		= UploadObj(obj)(mc).ImageHeight		'이미지 Height
				
				If InStr(returnValue,uploadFileName & "|" & uploadFileSize) < 1 Then	'동일한 파일은 등록 안됨
					' 중복 파일명 체크
					SaveFileName		= DuplicationCheck (saveDir, uploadFileName)

					If RndFileName Then  SaveFileName	= RandomFileName () & "." & uploadFileExt

					uploadFileSizeText	= util.FileSizeCalculator(uploadFileSize)
					If InStr(uploadBlackList,LCase(uploadFileExt)) > 0 Then
						
						Call TempDeleteFile(returnValue, saveDir)
						FileUpload		= "ERROR|업로드를 지원하지 않는 확장자가 존재합니다. |" & uploadFileName
						Exit Function
					End If

					If InStr(uploadWhiteList,LCase(uploadFileExt)) < 1 Then
						Call TempDeleteFile(returnValue, saveDir)
						FileUpload		= "ERROR|업로드를 지원하지 않는 확장자가 존재합니다.|" & uploadFileName
						Exit Function
					End If

					If Int(uploadFileSize) > Int(maxUploadSize) Then
						Call TempDeleteFile(returnValue, saveDir)
						FileUpload		= "ERROR|업로드 가능 한 파일크기를 초과 하였습니다.(제한 용량 : " & util.FileSizeCalculator(maxUploadSize) & ")|" & uploadFileName
						Exit Function
					End If
					
					UploadObj(obj)(mc).SaveAs cfg.FileSaveRoot_ & saveDir & SaveFileName

					If thumbEnable And UploadFileWidth > 0 And InStr(uploadFileMime,"image") > 0 Then 
						If Not thSizeFix Then
							rslt			= RatioCalculator (UploadFileWidth, UploadFileHeight, thWidth, thHeight)
							thWidth_	= Trim(rslt(0))
							thHeight_	= Trim(rslt(1))
							Erase rslt
						End If

						Call ThumbnailMaker (saveDir, SaveFileName, thWidth, thHeight)
					End If
					
					If UploadFileWidth > maxImageWidth Then
						Dim orgPreFix
						rslt			= RatioCalculator (UploadFileWidth, UploadFileHeight, maxImageWidth, UploadFileHeight)
						orgPreFix	= thPrefix
						thPrefix_	= "[tmp]"
						Call ThumbnailMaker (saveDir, SaveFileName, maxImageWidth, rslt(1))
						thPrefix_	= orgPreFix
						Dim tmpStrFileName : tmpStrFileName =  cfg.FileSaveRoot_ & Replace(saveDir,"/","\") & "\" & "[tmp]" & SaveFileName

						Call DeleteFile (saveDir, SaveFileName)

						Dim objFSO : Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
						Dim objFile : Set objFile = objFSO.GetFile(tmpStrFileName)
							objFile.Name = SaveFileName
						Set objFile = Nothing
						Set objFSO = Nothing

					End If
					'//이정규 수정
					'If returnValue <> "" Then returnValue = returnValue & (";")
					If returnValue <> "" Then returnValue = returnValue & ("|X|")
					returnValue = returnValue & SaveFileName & "|" & uploadFileName & "|" & uploadFileSize & "|" & uploadFileMime & "|" & uploadFileExt & "|"
				End If
			End If
		Next
		FileUpload = returnValue

	End Function
	
	' 썸네일 생성
	Public Sub ThumbnailMaker (byVal saveDir, byVal orgName, byVal W, byVal H)
		Dim imgProc, orgFilePath, onlyName, onlyExt, saveFileName, ExtList
		Set imgProc	= Server.CreateObject("DEXT.ImageProc")
		ExtList			= ".GIF/.JPG/.PNG/.JPEG"
		orgFilePath	= cfg.FileSaveRoot_ & saveDir & orgName
		onlyName	= GetOnlyFileName (orgName)
		onlyExt		= Replace(orgName, onlyName, "", 1, -1, 1)
		
		If imgProc.SetSourceFile(orgFilePath) Then
			If inStr(ExtList, UCase(onlyExt)) > 0 Then saveFileName = onlyName & onlyExt Else saveFileName = onlyName & ".jpg"
			Call imgProc.SaveasThumbnail(cfg.FileSaveRoot_ & saveDir & thPrefix & saveFileName, W, H , False)
		End If
		
		Set imgProc	= Nothing
	End Sub
	
	' 파일 삭제
	Public Sub DeleteFile (byVal saveDir, byVal fileName)
		Dim DeleteFilePath
		DeleteFilePath = cfg.FileSaveRoot_ & saveDir & fileName
		If UploadObj.FileExists (DeleteFilePath) Then UploadObj.DeleteFile DeleteFilePath
	End Sub

	Private Sub TempDeleteFile (byVal tmpList, byVal saveDir)
		Dim arr, chd
		arr = Split(tmpList,";")
		For n_ = 0 To UBound(arr)
			chd = Split(arr(n_),"|")
			Call DeleteFile (saveDir, chd(0))
			Call DeleteFile (saveDir, thPrefix & chd(0))
		Next
		Erase arr
	End Sub

	Public Function TmpFileUpload (byVal obj)
		Dim uploadFileName, uploadFileSize, uploadFileMime, uploadFileExt, UploadFileWidth, UploadFileHeight
		returnValue = ""
		If UploadObj(obj).FileName <> "" Then
				uploadFileName		= UploadObj(obj).FileName			'파일명
				uploadFileSize			= UploadObj(obj).FileLen				'파일크기
				uploadFileMime		= UploadObj(obj).MimeType			'Mime-type
				uploadFileExt			= UploadObj(obj).FileExtension		'확장자
				returnValue = uploadFileName & "|" & uploadFileSize & "|" & uploadFileMime & "|" & uploadFileExt
		End If
		TmpFileUpload = returnValue
	End Function

End Class
%>