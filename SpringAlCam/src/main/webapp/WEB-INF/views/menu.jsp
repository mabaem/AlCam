<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<a href="main.do?menu=place">캠핑장소검색</a>
	<a href="main.do?menu=recommend_place">캠핑장소추천</a>
	<a href="main.do?menu=goods">캠핑용품검색</a>
	<a href="main.do?menu=notice">고객센터</a>
	<!-- 로그인시에만 마이페이지 확인가능 -->
	<c:if test="${ not empty user }">
		<a href="main.do?menu=member">마이페이지</a>
	</c:if>
</div>


</body>
</html>