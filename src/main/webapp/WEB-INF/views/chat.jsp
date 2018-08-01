<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<!--메인 페이지 세션값 설정-해당아이디 -->
	<c:if test="${sessionScope.userID!=null}">
		${sessionScope.userID}
	</c:if>

	<c:if test="${sessionScope.toID!=null}">
		${sessionScope.toID}
	</c:if>
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!--반응형 웹 적용(밑에설명O)  -->
	<!--https://developer.mozilla.org/ko/docs/Mozilla/Mobile/Viewport_meta_tag  -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!--css파일 불러올 수 있게함  -->
	<link rel="stylesheet" href="./resources/css/bootstrap.css">
	<link rel="stylesheet" href="./resources/css/custom.css">
	<link rel="stylesheet" href="./resources/css/chatBoard.css">
	
	<title>Just Say It</title>
	
	<!--ajax를 위해 공식사이트에서 제공하는 제이쿼리 링크 가져옴  -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!--부트스트랩 프레이워크에서 제공하는 js파일 가져옴  -->
	<script src="./resources/js/bootstrap.js"></script>
	
	<script type="text/javascript">
		function autoClosingAlert(selector,delay){
			var alert= $(selector).alert();
			alert.show(); //팝업처럼 보여줄 수 있게 만들어줌
			window.setTimeout(function() { alert.hide() },delay) //딜레이만큼 시간동안만 보여줌	
		}
		
		//메시지보내는 submit기능
		function submitFunction(){
			var fromID = ${sessionScope.userID};
			var toID = ${sessionScope.toID};
			var chatContent = $('#chatContent').val(); //입력한 값을 가져올 수 있게함.
			
			$.ajax({
				type: "POST",
				url: "ChatSubmit",
				data: {
					fromID : encodeURIComponent(fromID),
					toID : encodeURIComponent(toID),
					chatContent : encodeURIComponent(chatContent)
				},
				success: function(result){
					if(result==1){
						autoClosingAlert('#successMessage',2000); //성공하면  팝업알림창들 띄워줌 ex) 메시지 성공했습니다 //2초동안
						
					} else if(reuslt==0){
						autoClosingAlert('#dangerMessage',2000);
					} else{
						autoClosingAlert('#waringMessage',2000);
					}
				}
			});
			//성공적으로 값을 보냈은 아니든 
			$('#chatContent').val(''); //메시지 보냈으니 값을 비워줘.
		}
	
	</script>
</head>
<body>
	
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
			<a class="navbar-brand" href="index.jsp">실시간 토론 채팅 사이트</a>
		</div>
		<!--  -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- 1개의 리스트 -->
			<ul class="nav navbar-nav">
				<!--리스트의 항목  -->
				<li class="active"><a href="index">메인</a>
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

	
	<!--채팅창 구현 -->
	<div class="container bootstrap snippet">
		<div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-default">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h4><i class="fa fa-circle text-green"></i>실시간 채팅창</h4>
						</div>
						<div class="clearfix"></div>
					</div>
					<div id="chat" class="panel-collapse collapse in">
						<div id="chatList" class="porlet-body chat-widget" style="overflow-y: auto; width:auto; height:600px;">
						</div>
						<div class="portlet-footer">
							<!--
							필요없는 부분
							 <div class="row">
								<div class="form-group col-xs-4">
									<input style="hegiht:40px;" type="text" id="chatName" class="form-control" placeholder="이름" maxlength="8">
								</div>
							</div> -->
							<div class="row" style="height:90px;">
								<div class="form-group col-xs-10">
									<textarea style="hegiht:80px;"	id="chatContent" class="form-control" placeholder="메시지를 입력하세요" maxlength="100"></textarea>
								</div>
								<div class="form-group col-xs-2">
									<button type="button" class="btn btn-default pull-right" onclick="submitFunction();">전송</button>
									<div class="clearfix"></div>
									
								</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 알림창  -->
	<div class="alert alert-success" id="successMessage" style="display: none;">
		<strong>메시지 전송에 성공했습니다.</strong>
	</div>
	<div class="alert alert-success" id="dangerMessage" style="display: none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class="alert alert-success" id="waringMessage" style="display: none;">
		<strong>데이터베이스 오류가 발생했습니다.</strong>
	</div>
</body> 
</html>