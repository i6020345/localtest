	<header id="header">
		<h1><a href="/" class="logo">순수한면</a></h1>
		<!-- #gnb -->
		<div id="gnb">
			<a href="#" class="btn_menu icon">메뉴</a>

			<nav class="menu">
				<h2><a href="/" class="logo">순수한면</a></h2>
				<ul>
					<li>
						<a href="#">순수한면 제품</a>
						<ul>
							<li><a href="/product/purecotton_tonature.asp">자연에게 순수한면</a></li>
							<li><a href="/product/purecotton_zero.asp">순수한면 ZERO제로</a></li>
							<li><a href="/product/purecotton_super.asp">순수한면 슈퍼가드</a></li>
							<li><a href="/product/purecotton_healthy.asp">건강한 순수한면</a></li>
							<li><a href="/product/purecotton_all.asp">제품 전체보기</a></li>
						</ul>
					</li>
					<li>
						<a href="/brand/story.asp">순수한면 이야기</a>
					</li>
					<li>
						<a href="#">#순수한생리학 캠페인</a>
						<ul>
							<li><a href="/event/pure_physiology.asp">#순수한 생리학 캠페인</a></li>
							<li><a href="/event/pure_physiology_edition.asp">#순수한 생리학 북에디션</a></li>
						</ul>
					</li>
					<li>
						<a href="/event/formula_is.asp">#순면공식 캠페인</a>
					</li>
					<li>
						<a href="#">#안심정착 프로젝트</a>
						<ul>
							<li><a href="/settlement/project.asp">안심 정착 프로젝트란?</a></li>
							<li><a href="/settlement/story.asp">안심 정착 스토리</a></li>
						</ul>
					</li>
					<!-- <li>
						<a href="/event/skin_attachment.asp">#피부애착 프로젝트</a>
					</li> -->
					<li>
						<a href="#">순수한면 약속코드</a>
						<ul>
							<li><a href="/promise/purecotton.asp">약속 코드란?</a></li>
							<li><a href="/promise/safety.asp">순수한면 안심 정보</a></li>
						</ul>
					</li>
					<li>
						<a href="/event/event_list.asp">이벤트</a>
					</li>
					<li>
						<a href="#">고객센터</a>
						<ul>
							<li><a href="/customer/noti_list.asp">공지사항</a></li>
							<li><a href="/customer/onetoone.asp">1: 1문의</a></li>
							<li><a href="javascript:goMyPage();">회원정보 수정</a></li>
						</ul>
					</li>
					<li>
						<a href="https://www.instagram.com/purecotton_official/" target="_blank">공식 인스타그램</a>
					</li>
				</ul>
				<a href="#" class="btn_close icon">닫기</a>
			</nav>

			<div class="loginArea">
				<div class="wrap">
					<% if USER_LOGIN_ID = "" then %>
					<span class="txt">로그인</span><!-- 로그인 | 로그아웃 -->
					<a href="/etc/login.asp" class="btn icon">로그인</a><!-- icon -->
					<% else %>
					<span class="txt">로그아웃</span><!-- 로그인 | 로그아웃 -->
					<a href="/etc/login_data.asp?logout=y" class="btn icon">로그아웃</a><!-- icon -->
					<% end if %>
				</div>
			</div>
		</div>
		<!-- //#gnb -->
	</header><!-- /#header -->