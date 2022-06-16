<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<title>일반 정보 수정</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet" href="resources/css/style.css">
	
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});	
</script>


<style>
display: inline-flex ;

body {
	min-height: 100vh;
	background: -webkit-gradient(linear, left bottom, right top, from(#92b5db),
		to(#1d466c));
	background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
}

.input-form {
	max-width: 680px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}
.mybtn {
	
	text-align: center;
	display: inline-block;
}
</style>
</head>
<body>

	<header>
		<jsp:include page="m_header.jsp" />
	</header>

	<br>
	<br>

	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h3 class="mb-3">일반 정보수정</h3>
				<form name="m_joinFrm" class="validation-form" action="./mmemUpdate"
					method="post" onsubmit="return check()" enctype="multipart/form-data" novalidate>
				 
				<div class="col-md-3 mb-3" >
					<label for="mid">아이디</label> 
					<input type="text" class="form-control" id="mid" 
						   placeholder="아이디" name="m_id"  value="${mb.m_id}" readonly>
				</div>
				

				<div class="col-md-5 mb-3">
					<label for="mpassword">비밀번호</label> 
					<input type="password" class="form-control" id="mpassword" value="${mb.m_pwd}"
						   placeholder="비밀번호" name="m_pwd" required>
					<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
				</div>
				
				 
				<div class="col-md-5 mb-3">
					<label for="mpasswordConfirm">비밀번호 확인</label> 
					<input type="password" class="form-control" id="rpassworCconfirm" 
						   value="${mb.m_pwd}" placeholder="비밀번호 확인" 	required>
					<div class="invalid-feedback">위와 동일한 비밀번호를 입력해주세요.</div>
				</div> 
					
				<div class="col-md-3 mb-3">
					<label for="mname">이름</label> 
					<input type="text" class="form-control" id="mname" 
						  value="${mb.m_name}" name="m_name" readonly>
				</div>
				
				<div class="col-md-3 mb-3">
					<label for="mbirth">생년월일</label> 
					<input type="text" class="form-control" id="mbirth" 
						   value="${mb.m_birth}" name="m_birth" readonly>
				</div>
				
				<div class="col-md-3 mb-3">
					<label for="mphone">전화번호</label> 
					<input type="text" class="form-control" id="mphone" 
						   value="${mb.m_phone}" name="m_phone" required>
				</div>

				<div class="mb-3">
					<label for="email">이메일</label> 
					<input type="email" class="form-control" id="memail"   
						   value="${mb.m_email}" name="m_email" required>
					<div class="invalid-feedback">이메일을 입력해주세요.</div>
				</div>
					
				<div class="row">
				 <div class="col-md-4 mb-3">
				 	<label for="postcode">우편번호 </label> 
				 	<input type="text" class="form-control" id="postcode" 
				 		   value="${mb.m_addr1}" name="m_addr1">
				 	<div class="invalid-feedback">우편번호를 입력해주세요.</div>
				</div>
					
				<div class="col-md-3 mb-3">
					<input type="button" onclick="execDaumPostcode()" value="우편번호찾기" >
				</div>
				</div>
					
				<div class="mb-3">
					<label for="extraAddress">주소</label>
					<input type="text" class="form-control" id="extraAddress" 
					name="m_addr2" value="${mb.m_addr3}">
				</div>

				<div class="mb-3">
					<label for="address">상세주소</label>
					<input type="text" class="form-control" id="address" name="m_addr3"
					 value="${mb.m_addr3}">
				</div>

										
					<div class="mb-4"></div>
					<button class="btn btn-primary btn-lg btn-block" type="submit">수정완료</button>
				</form>
			</div>
		</div>
	</div>

	<br>
	<br>

	<footer>
		<jsp:include page="footer.jsp" />
	</footer>

<script>
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  </script>
</body>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

	//주소 확인 API

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                    
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
                autoClose;
            }
        }).open();
        
    }
</script>



</html>