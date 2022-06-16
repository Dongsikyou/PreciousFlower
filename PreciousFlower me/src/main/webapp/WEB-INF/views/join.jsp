<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 선택</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/style.css">
<script type="text/javascript">
	
</script>
</head>
<body>
	<div class="wrap">
		<header>
			<jsp:include page="header.jsp" />
		</header>
		<section>
			<div class="content">
				<form name="joinFrm" class="login-form" action="./memInsert"
					method="post" onsubmit="return check()">
					<br> <br>
					<h2 class="login-header">회원 가입</h2>

					<br> <br>
					<h5>일반</h5>
					<a class="navbar-brand  text-successh1 align-self-center"
						href="./m_joinFrm"> <img src="./resources/images/member.png"
						width="130px">
					</a>
					<h5>라이더</h5>
					<a class="navbar-brand  text-successh1 align-self-center"
						href="./r_joinFrm"> <img src="./resources/images/rider.png"
						width="150px">
					</a>
				</form>
			</div>
		</section>
		<footer>
			<jsp:include page="footer.jsp" />
		</footer>
	</div>
</body>
<script type="text/javascript">
	
</script>
</html>



