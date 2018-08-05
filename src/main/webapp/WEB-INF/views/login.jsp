<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!--반응형 웹 적용(밑에설명O)  -->
	<!--https://developer.mozilla.org/ko/docs/Mozilla/Mobile/Viewport_meta_tag  -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!--css파일 불러올 수 있게함  -->
	<link rel="stylesheet" href="./resources/css/bootstrap.css">
	<link rel="stylesheet" href="./resources/css/custom.css">
<!-- 	<link rel="stylesheet" href="./resources/css/chatBoard.css"> -->
	
	<title>Just Say It</title>
	
	<!--ajax를 위해 공식사이트에서 제공하는 제이쿼리 링크 가져옴  -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!--부트스트랩 프레이워크에서 제공하는 js파일 가져옴  -->
	<script src="./resources/js/bootstrap.js"></script>
	
</head>
<body>
	<!--메인 페이지 세션값 설정-해당아이디 -->
	<c:if test="${sessionScope.userID!=null}">
		${sessionScope.userID}
	</c:if>

	
	<!--네비게이션 바 만듬  -->
	<nav class="navbar navbar-default">
		<!--헤더 부분  -->
		<div class="navbar-header"> 
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<!--아이콘 바==1개의 가로 짝대기  ,반응형웹이라 화면 줄였을 때 나오는 것-->
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<!--로고,제목  -->
			<a class="navbar-brand" href="./">실시간 토론 채팅 사이트</a>
		</div>
		<!--  -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- 1개의 리스트 -->
			<ul class="nav navbar-nav">
				<!--리스트의 항목  -->
				<li class="active"><a href="./">메인</a>
				<c:if test="${sesseionScope.userID!=null}">
				<li class="active"><a href="boardView">토론 게시판</a></li>
				</c:if>
			</ul>
			
			
			
			<c:if test="${sessionScope.userID==null}"> 
			<!--userID가 없으면 실행됨  -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"> <!-- 아래쪽으로 내려서 항목이 나올 수 있게 만들어줌 
				#:: 어떤 위치로 이동하지 않게 만들어줌  -->
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="butsk dlfton" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span>
					</a>
				
					<!--  실제 리스트로 존재할 수 있게 ul태그로 담음 ,리스트 종류는 dropdwon-menu	 -->
					<ul	class="dropdown-menu">
					<!-- 리스트 항목 추가해줌  -->
						<li><a href="login">로그인</a></li>	
						<li><a href="join">회원가입</a></li>	
					</ul>
				</li>
			</ul>
			</c:if>
			
			
			<c:if test="${sessionScope.userID!=null}">  
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"> <!--아래쪽으로 내려서 항목이 나올 수 있게 만들어줌  -->
				<!--#:: 어떤 위치로 이동하지 않게 만들어줌  -->
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"><!--caret이라는 이미지 띄워줌,아래쪽삼각형 --></span>
					</a>
			</ul>
			</c:if> 
		</div>
	</nav>
	<div class="container">
		<form method="post" action="userLogin">
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr colspan="2"><h4>로그인</h4></tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:110px;"><h5>아이디</h5></td>
						<td><input class="form-control" type="text" name="userID" maxlength="20" placeholder="아이디를 입력하세요."></td>
					</tr>
					<tr>
						<td style="width:110px;"><h5>비밀번호</h5></td>
						<td><input class="form-control" type="password" name="userPassword" maxlength="20" placeholder="비밀번호를 입력하세요."></td>
					</tr>
					<tr>
						<td style="text-align:left;" colspan="2"><input class="btn btn-primary pull-right" type="submit" value="로그인"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body> 
</html>