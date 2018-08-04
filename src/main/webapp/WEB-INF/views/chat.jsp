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
	
	<script>
	$(function(){
		$('#send').on('click', function(){
			submitFunction();
		});
	});

		function autoClosingAlert(selector,delay){
			var alert= $(selector).alert();
			alert.show(); //팝업처럼 보여줄 수 있게 만들어줌
			window.setTimeout(function() { alert.hide() },delay); //딜레이만큼 시간동안만 보여줌	
		}
		
		//메시지보내는 submit기능
		function submitFunction(){
			
			var fromID = $('.userId').val();
			var toID = $('.toId').val(); 
			var chatContent = $('#chatContent').val(); //입력한 값을 가져올 수 있게함.
			
			$.ajax({
				type: "POST",
				url: "ChatSubmit",
				data: {
					fromID : encodeURIComponent(fromID),
					toID : encodeURIComponent(toID),
					chatContent : encodeURIComponent(chatContent),
				},
				dataType: 'text',
				success: function(result){
					if(result==1){
						autoClosingAlert('#successMessage',2000); //성공하면  팝업알림창들 띄워줌 ex) 메시지 성공했습니다 //2초동안
						
					} else if(result==0){
						autoClosingAlert('#dangerMessage',2000);
					} else{
						autoClosingAlert('#warningMessage',2000);
					}
				},
				error : function(request,status,error){
			          alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
			//성공적으로 값을 보냈은 아니든 
			$('#chatContent').val(''); //메시지 보냈으니 값을 비워줘.
		} 
		var lastID = 0; //가장 마지막으로 대화 데이터의 chatID가 됨
		function chatListFunction(type){
			var fromID =$('.userId').val();
			var toID = $('.toId').val(); 
			$.ajax({
				
				type: "POST",
				url: "chatList",
				data: {
					fromID : encodeURIComponent(fromID),
					toID : encodeURIComponent(toID),
				}, 
				success: function(data){
					if(data=="") return;
					var parsed = JSON.parse(data); //제이슨 형태로 파싱하고
					var result = parsed.result; //result에 담아줌
					for(var i=0; i<result.length; i++){ //실제화면에 메시지 하나씩 출력
						addChat(result[i][0].value, result[i][2].value, result[i][3].value);
					}
					lastID= Number(parsed.last); //chatList컨트롤러에서 last에 해당하는 가장 마지막에 전달받은하는 chatID가져올수있게해줌.
				}
			});
		}
		

		/* 
		result : [ [{value:FromID}, {value:toId}, {value:chatcontent}, {value:chattime}]   ]
		
		[{value:Fromid},{value:toId},{value:toId},{value:toId}},
			{value:Fromid,toId,chatcontent,chattime},
			{value:Fromid,toId,chatcontent,chattime},
			{value:Fromid,toId,chatcontent,chattime},
			{value:Fromid,toId,chatcontent,chattime},
			{value:Fromid,toId,chatcontent,chattime},
			{value:Fromid,toId,chatcontent,chattime}]
		
		 */
		//채팅보낸사람,어떤내용,언제보냈는지 실제로 우리 화면에 출력하게 만들어줌
		function addChat(chatName, chatContent, chatTime){
			//chatList에 어떠한 내용을 추가적으로 넣어주는거(div에)
			$('#chatList').append('<div class="row">'+
						'<div class="col-lg-12">' +
						'<div class="media">' +
						'<a class ="pull-left" href="#">' +
						'<img class="media-object img-circle" style="width: 30px; height :30px;" src="images/icon.png" alt="">'+ 
						'</a>' +
						'<div class="media-body">' +
						'<h4 class="media-heading">' +
						chatName +
						'<span class= "small pull-right">'+
						chatTime +
						'</span>'+
						'</h4>'+
						'<p>'+
						chatContent +
						'</p>'+
						'</div>'+
						'</div>'+
						'</div>'+
						'</div>'+
						'<hr>');				
			$('#chatList').scrollTop($('#chatList')[0].scrollHeight); //스크롤 가장 아래쪽으로 내려줘서 메시지 올때마다 보여줄수있게해줌.
		}
		function getInfiniteChat(){ //몇 초 간격으로 새로운 메시지 가져오는 걸 의미
			setInterval(function(){
				chatListFunction(lastID);
			},3000); //3초에 1번씩 실행됨
		}
	</script>
</head>
<body>
	<input class="userId" type="hidden" value="${sessionScope.userID}">
	<input class="toId" type="hidden" value="${sessionScope.toID}">
	
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
						<div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width:auto; height:600px;">
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
									<button type="button" class="btn btn-default pull-right" id="send">전송</button> <!--onclick="submitFunction();"  -->
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
	<div class="alert alert-danger" id="dangerMessage" style="display: none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display: none;">
		<strong>데이터베이스 오류가 발생했습니다.</strong>
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
		<!-- session.removeAttribute("messageContent"); -->
		
		<%-- 
		<c:remove var="${sessionScope.messageContent}"/> <!-- 모달창 띄워준 다음 세션 파기해줌. 단 한번만 사용자에게 메시지 보여줄 수 있게 만듬. -->
		<c:remove var="${sessionScope.messageType}"/>
		
		오류생긴다
		 --%>
		<!-- 위 2개는 서버로 부터 받은 어떠한 세션 값   .회원가입시도시 오류가 발생하면 이 메시지가 세션값으로 설정되는 것.-->
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
	</script>
	<%-- 
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>	
	 --%>
	<script type="text/javascript">
	//함수실행하게 3초간격으로 채팅메시지 가져올수있어!
	$(document).ready(function(){
		chatListFunction('ten');
		getInfiniteChat();
	});
	
	</script>
		
</body> 
</html>