<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<style type="text/css">
	
	#btn_home{
		margin-right: 640px;
		width: 180px;
		height: 60px;
	}
	
	#btn_join_form{
		width: 80px;
		height: 40px;
	}
	
	#btn_login_form{
		width: 80px;
		height: 40px;
	}
	
	#btn_logout{
		margin-left: 80px;
		width: 80px;
		height: 40px;
	}
	
</style>

<!-- 헤더 -->
<div>
	<a href="main.do"><img id="btn_home" src="resources/image/logo.png" alt="알고싶지캠핑?"></a>
	
	<!-- 로그인 안 된 상태 : 로그인,회원가입버튼 -->
	<c:if test="${ empty user }">
		<a href="member/insert_form.do"><img id="btn_join_form" src="resources/image/btn_join.png" alt="회원가입"></a>
		<a href="member/login_form.do"><img id="btn_login_form" src="resources/image/btn_login.png" alt="로그인"></a>
	</c:if>
	<!-- 로그인 된 상태 : 로그아웃버튼 -->
	<c:if test="${ not empty user }">
		<a href="member/logout.do"><img id="btn_logout" src="resources/image/btn_logout.png" alt="로그아웃"></a>
	</c:if>
</div>
