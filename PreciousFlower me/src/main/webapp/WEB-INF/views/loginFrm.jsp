<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <title>로그인</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="resources/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="resources/img/favicon.ico">


    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/templatemo.css">
    <link rel="stylesheet" href="resources/css/custom.css">
    <link rel="stylesheet" href="resources/css/style.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="resources/css/fontawesome.min.css">
<!--
    
TemplateMo 559 Zay Shop

https://templatemo.com/tm-559-zay-shop

-->
<style>
form { display : inline-block; }

#N_logIn {  margin-right: 30%;  }

</style>

<script type="text/javascript">

//메시지 출력 부분
$(function() {
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}
// 로그인한 회원 정보 및 로그아웃 출력
var lname="${mb.m_name}";
$("#name").html(lname + "님");
$(".suc").css("display" , "block");
$(".bef").css("display" , "none");
});
</script>

</head>



<body>
 	<header>
	<jsp:include page="header.jsp"/>
	</header>

    <section>
    <br><br><br><br>
			<!-- 같은 div안에 form두개  각각 id를 N_logIn R_logIn 으로 나눔-->
			<div class="content">

				<form class="login-form" action="./m_loginProc" method="post" id="logIn">
					<h2 class="login-header">일반로그인</h2>
					<input type="text" class="login-input" 
						name="m_id" autofocus required 
						placeholder="아이디"><br>
					<input type="password" class="login-input" 
						name="m_pwd" placeholder="비밀번호" required>
					<input type="submit" class="login-btn" href="m_main" value="로그인">
				</form>

<!--			구분선				-->

				<form class="login-form" action="./r_loginProc" method="post" id="logIn">
					<h2 class="login-header">라이더로그인</h2>
					<input type="text" class="login-input" 
						name="r_id" autofocus required 
						placeholder="아이디"><br>
					<input type="password" class="login-input" 
						name="r_pwd" placeholder="비밀번호" required>
					<input type="submit" class="login-btn" href="./" value="로그인">
				</form>

			</div>
		</section>
	<br><br>
	
	<section>
    <br><br>
			<div class="content">

				

			</div>
		</section>
	<br><br><br><br>

   	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>

    <!-- Start Script -->
    <script src="resources/js/jquery-1.11.0.min.js"></script>
    <script src="resources/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.bundle.min.js"></script>
    <script src="resources/js/templatemo.js"></script>
    <script src="resources/js/custom.js"></script>
    <!-- End Script -->
</body>

</html>