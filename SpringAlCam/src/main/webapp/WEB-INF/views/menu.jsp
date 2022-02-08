<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	#menu{
		text-align: center;
		margin-top: 30px;
	}
	.div_menu>a{
		width: 150px;
		height: 80px;	
		text-decoration: none;
		color: #01b301;
		font-family: '맑은 고딕';
		font-size: 18px;
		padding: 10px;
		margin: 30px;
	}
	.div_menu>a:hover{
		text-decoration: none;
		color: #006e00;
	}
	
</style>

</head>
<body>

<!-- 메뉴(페이지리스트) -->
<div id="menu" class="div_menu">	
	<a href="index.jsp?menu=place">캠핑장소검색</a>
	<a href="index.jsp?menu=recommend_place">캠핑장소추천</a>
	<a href="index.jsp?menu=goods">캠핑용품검색</a>
	<a href="index.jsp?menu=notice">고객센터</a>
	<a href="index.jsp?menu=member">마이페이지</a>
</div>


</body>
</html>