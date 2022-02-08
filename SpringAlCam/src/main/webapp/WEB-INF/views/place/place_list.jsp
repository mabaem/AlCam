<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	
	#p_input_box{
		margin: 0 auto;
		text-align: center;
		padding: 20px;
	}
	#p_text_search{
		width: 300px;
		height: 40px;
	}
	#p_btn_search{
		width: 70px;
		height: 40px;
		margin-left: 5px;
		
	}
	
</style>
<script type="text/javascript">
function find() {
	
	var text_search = $("#p_text_search").val().trim();
	console.log(p_text_search);
	if(text_search==''){
		alert('검색어를 입력하세요');
		  $("#p_text_search").val("");
		  $("#p_text_search").focus();
		return;
	}
	location.href="${ pageContext.request.contextPath }/camping/search.do?text_search=" + encodeURIComponent(text_search);
	
}

</script>
</head>
<body>

<div id="place_box">

	<!-- 장소리스트 -->
	<div id="div_place_list">
		<!-- 검색 -->
		<div id="p_search_box">
			<div class="input-group" id="p_input_box">
				<input type="text" id="p_text_search" placeholder="캠핑장소 검색">
				<input type="button" id="p_btn_search" class="btn btn-success" onclick="find()" value="검색">
			</div>
		</div>
		
		<!-- 장소리스트 출력 -->
		<div>
			<!-- 키워드, 주소, 장소명 등으로 캠핑장소 검색 -->
			<%@ include file="camping_list.jsp" %>
		</div>
	</div>
</div>

</body>
</html>