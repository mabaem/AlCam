<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	
	#btn_home{
		margin-right: 640px;
	}
	
	#btn_join_form{
		
	}
	
	#btn_login_form{
		
	}
	
	#btn_logout{
		
	}
	
</style>

</head>
<body>

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

</body>
</html>