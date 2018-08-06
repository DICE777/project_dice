<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="./resources/css/bootstrap.css">
	<link rel="stylesheet" href="./resources/css/custom.css">
	<title>Just Say It</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="./resources/js/bootstrap.js"></script>

	<script>
	
		function passwordCheckFunction(){
			var userPassword1 = $('#userPassword').val();
			var userPassword2 = $('#userPassword2').val();
			if(userPassword1 != userPassword2){
				$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
			} else{
				$('#passwordCheckMessage').html('');
			}
		}
	</script>   
	<script>
	$(function(){
		
		$("#idck").on('click',function(){
			
			$.ajax({
				url: "idcheck",
				type: "get",
				data: {"userID":document.getElementById('userID').value},
				success: function(data){
					if(data==0) alert("회원가입이 가능합니다");
					else alert("중복된 아이디입니다");
				},
				error: function(data){
					alert("통신실패");
				}
			});
			
		});
	});
	
	</script>
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

	
	<!-- 회원가입 -->			
	<div class="container">
		<form method="post" action="userRegister">
			<table class="table table-bordered table-hover" style="text-align: center; border :1px solid #dddddd">
				<thead>
					<tr><!--제목. 3개 정도 열 차지  -->
						<th colspan="3"><h4>회원 가입</h4></th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<!--사용자가 어떤 값을 입력할 수 있도록 텍스트 박스 만듬 ,maxlenght는 ~글자가 넘어가지 않게. -->
						<td><input class="form-control" type="text" id="userID" name="userID" maxlength="20" placeholder="아이디를 입력하세요."></td>
						<td style="width: 110px;"><button class="btn btn-primary" onclick="registerCheckFunction();" type="button" id="idck">중복체크</button></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<!--사용자가 어떤 값을 입력할 수 있도록 텍스트 박스 만듬 ,maxlenght는 ~글자가 넘어가지 않게. -->
						<td colspan="2"><input onkeyup="passwordCheckFunction();" class="form-control" type="password" id="userPassword" name="userPassword" maxlength="20" placeholder="비밀번호를 입력하세요."></td>
						<!--onkeyup:: 어떤 메시지를 입력할 때마다 실행됨. 즉 비밀번호 입력할 때마다 위 함수가 실행된다.  -->
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호 확인</h5></td>
						<td colspan="2"><input onkeyup="passwordCheckFunction();" class="form-control" type="password" id="userPassword2" name="userPassword2" maxlength="20" placeholder="비밀번호 확인을 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
						<td colspan="2"><input class="form-control" type="text" id="userName" name="userName" maxlength="20" placeholder="이름을 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>나이</h5></td>
						<td colspan="2"><input class="form-control" type="number" id="userAge" name="userAge" maxlength="20" placeholder="나이을 입력하세요."></td>
					</tr>
					
					<tr>
						<td style="width: 110px;"><h5>성별</h5></td>
						<td colspan="2">
							<!--라디오 버튼  -->
							<div class="form-group" style="text-align: center; margin:0 auto;">
								<div class="btn-group" data-toggle="buttons">
									<!--각각의 라디오 버튼이 들어감  -->
									<label class="btn btn-primary active">
										<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
									</label>

									<label class="btn btn-primary">
										<input type="radio" name="userGender" autocomplete="off" value="여자">여자
									</label>
								</div>
							</div>
						</td>
					</tr>
					
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="2"><input class="form-control" type="email" id="userEmail" name="userEmail" maxlength="20" placeholder="이메일을 입력하세요."></td>
					</tr>
					<tr>
						<td style="text-align: left;" colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5><input class="btn btn-primary pull-right" type="submit" value="등록"></td>
					</tr>
				</tbody>
				
			</table>
		</form>
	</div>
	
	<!--modal창 사용.사용자 알림메시지 띄우는 것  -->
	<c:if test="${sessionScope.messageContent!=null}">
		${sessionScope.messageContent}
	</c:if>
	<c:if test="${sessionScope.messageType!=null}">
		${sessionScope.messageType}
	</c:if>
	
	<c:if test="${messageContent!=null}">
		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div class="modal-content">
						<c:choose>
							<c:when test="${sessionScope.messageType=='오류 메시지'}">
								<c:out value="panel-waring"></c:out>
							</c:when>
							<c:otherwise>
								<c:out value="panel-success"></c:out>
							</c:otherwise>
						</c:choose>
						
						<div class="modal-header panel-heading">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times</span> <!-- x버튼에 해당하는 그림문자 띄움 -->
								<span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title">
								${sessionScope.messageType}
							</h4>
						</div>	
						<!-- 메시지 내용 사용자에게 보여줄건지 -->
						<div class="modal-body">
							${sessionScope.messageContent}
						</div>
						<div class="modal-footer">
							<!--닫기버튼  -->
							<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$('#messageModal').modal("show"); //사용자에게 모달창 보여지게
		</script>
		
	</c:if>
	
	<!-- modal. 회원가입 아이디 중복체크할때 설정.중복체크할때마다 여부에 따라 이 쪽부분이 실제 사용자 화면에 띄워짐. -->
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div id="checkType" class="modal-content panel-info"><!--정보를 띄워주는 모달창  -->
						<div class="modal-header panel-heading">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times</span> <!-- x버튼에 해당하는 그림문자 띄움 -->
								<span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title">
								확인 메시지
							</h4>
						</div>	
						<!-- 메시지 내용 사용자에게 보여줄건지 -->
						<div id="checkMessage" class="modal-body">
						</div>
						<div class="modal-footer">
							<!--닫기버튼  -->
							<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModel').modal("show");
		$(document).ready(function(){
			chatListFunction('ten');
			getInfiniteChat();
		});
	</script>
	
</body>
</html>