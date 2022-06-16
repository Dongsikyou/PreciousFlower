<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <title>일반 메인</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" href="resources/css/style.css">
	<link rel="stylesheet" href="resources/css/adminStyle.css">
	
</head>

<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
});
</script>

<body>
   	<header>
	<jsp:include page="m_header.jsp"/>
	</header>

    <!-- Start Content Page -->
   		<div class="container">
        <div class="col-md-6 m-auto text-center">
            <h1 class="h1">배송요청</h1>
            <p>
                아래의 주소로 안전하게 전달 부탁드립니다.
            </p>
        </div>
		</div>

	<!-- 배송 요청 리스트 -->
    
	<div class="content">
		<div class="board-form">
			
			<h2 class="login-header">배송 리스트</h2>
			<div class="search-area">
				<select id="sel">
					<option value="b_title" selected>제목</option>
					<option value="b_contents">내용</option>
				</select>
				<input type="text" id="keyword">
				<button id="search">검색</button>
			</div>
			<div class="data-area">
				<div class="title-row">
					<div class="t-no p-10">주문 번호</div>
					<div class="t-title p-30">상품 이름</div>
					<div class="t-name p-10">주문 수량</div>
					<div class="t-date p-30">수령인 주소</div>
				</div>
				
				<c:forEach var="ritem" items="${rList}">
				<div class="data-row">
					<div class="t-no p-10">${ritem.o_num}</div>
					<div class="t-name p-15">${ritem.o_pcode}</div>
					<div class="t-name p-15">${ritem.o_count}</div>
					<div class="t-title p-30">
						<!-- 상세보기 화면 이동 url + 게시글번호 -->
						<a href="./contents?onum=${ritem.o_num}">
							${ritem.o_addr1}
						</a>
					</div>
					<div class="t-view p-15">${ritem.o_addr2}</div>
					<div class="t-view p-15">${ritem.o_addr3}</div>
					
					<!-- 
					<div class="t-date p-30">
						<fmt:formatDate value="${bitem.b_date}"
							pattern="yyyy-MM-dd HH:mm:ss"/>
					</div>
					<div class="t-view p-15">${bitem.b_views}</div>
				</div>  -->
				
				</c:forEach>
			</div>
			<div class="btn-area">
				<div class="paging">${paging}</div>
			</div>
		</div>
	</div>
		
	<!-- 배송 요청 리스트 close -->
    
    <!-- 카카오 맵 api -->
    
    <div id="map" style="width: 100%; height: 400px;"></div>
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2cfb9b397d35123ced4bbaaee9d33325&libraries=services,clusterer,drawing"></script>
    
    <script>
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
					center: new kakao.maps.LatLng(37.54297859999974, 127.05284909999978), //지도의 중심좌표.
					level: 3 //지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

	// 주소-좌표 변환 객체를 생성합니다	
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(storeAddress, function(result, status) {
		
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	        
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:3px 0;">' + storeName + '</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	        
	        
	        $(".storePosition").click(function(){
	        	map.panTo(coords);  
	        })
	        
	        
	    } 
			 
	});    
	
	
	var userAddress = $("#delevery_address").val();
	
	if(userAddress != "" ) {
		$(".userPosition").css("display" , "inline");
		
	  // 주소로 좌표를 검색합니다
	 	geocoder.addressSearch(userAddress, function(result, status) {
	 		
	 	    // 정상적으로 검색이 완료됐으면 
	 	     if (status === kakao.maps.services.Status.OK) {
	 	
	 	        coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	 	        
	 	        // 결과값으로 받은 위치를 마커로 표시합니다
	 	        var marker = new kakao.maps.Marker({
	 	            map: map,
	 	            position: coords
	 	        });
	 	        
	 	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	 	        var infowindow = new kakao.maps.InfoWindow({
	 	            content: '<div style="width:150px;text-align:center;padding:3px 0;">' + "배달받을위치" + '</div>'
	 	        });
	 	        infowindow.open(map, marker);
	 	        
	 	      	$(".userPosition").click(function(){
		        	map.panTo(coords);  
		        })
	 	    } 
	 	}); 
		 
	}
	
    })
	
	</script>
	
	<!-- 카카오 맵 api End -->
    

   	<footer>
	<jsp:include page="footer.jsp"/>
	</footer>

    
</body>

</html>