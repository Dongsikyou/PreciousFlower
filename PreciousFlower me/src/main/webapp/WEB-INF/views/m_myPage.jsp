<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <title>Zay Shop - About Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});	
</script>    
    

</head>

<body>
 	<header>
	<jsp:include page="m_header.jsp"/>
	</header>

	
  	<a href="./m_modify?rid=${mb.m_id}">일반 정보 수정</a>
							
  	
  	<a class="" href="./m_dList">배송 이력</a>


   	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>

   
</body>

</html>