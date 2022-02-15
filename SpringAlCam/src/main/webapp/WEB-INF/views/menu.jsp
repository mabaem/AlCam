<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

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

<script type="text/javascript">

	//마이페이지 클릭시 로그인 여부 체크
	function mypage() {
		if("${ empty user }" == "true"){ //로그인 안 한 경우
			
		if(confirm("로그인 하신 후 마이페이지 이용 가능합니다\n로그인 하시겠습니까?")==false) return;
		
		location.href="${ pageContext.request.contextPath }/member/login_form.do";
		return;
		
		}else{ //로그인 한 경우
			location.href="main.do?menu=member";
		}
	}

</script>

<!-- 메뉴(페이지리스트) -->
<div id="menu" class="div_menu">	
	<a href="main.do?menu=place">캠핑장소검색</a>
	<a href="main.do?menu=recommend_place">캠핑장소추천</a>
	<a href="main.do?menu=goods">캠핑용품검색</a>
	<a href="main.do?menu=notice">공지사항</a>	
	<a href="#" onclick="mypage(); return false;">마이페이지</a>
</div>
