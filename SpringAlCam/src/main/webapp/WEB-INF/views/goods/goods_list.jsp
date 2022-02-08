<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	#goods_box{
		margin: auto;
		/* padding: 20px; */
		font-family: '맑은 고딕'
	}
	#div_goods_menu{
		width: 30%;
		float: left;
		padding: 20px;
	}
	#div_goods_list{
		width: 70%;
		float: left;
		padding: 20px;
	}

</style>

</head>
<body>

<div id="goods_box">

	<!-- 메뉴리스트 -->	
	<div id="div_goods_menu" class="list-group">
		<label style="font-size: 20px; margin-bottom: 20px;">캠핑용품검색</label>		
		<!-- ###########각 리스트 클릭시 해당 아이템카테고리 리스트 출력########### -->
		<a href="#" class="list-group-item">취사용품</a>
		<a href="#" class="list-group-item">텐트, 침낭</a>
		<a href="#" class="list-group-item">소품</a>
		<a href="#" class="list-group-item">기타</a>
	</div>
	
	<!-- 캠핑용품 -->
	<div id="div_goods_list">
		<!-- 검색 -->
		<div>
			<input type="text" placeholder="캠핑용품 검색" style="width: 300px; height: 40px;">
			<input type="button" class="btn btn-default" value="검색" style="width: 70px; height: 40px;">
		</div>
		
		<!-- 네이버쇼핑리스트 출력 -->
		<div>
			캠핑용품리스트 : 카테고리별(용도별) 네이버쇼핑 링크 연결
		</div>
	</div>
</div>

</body>
</html>