<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>

<!-- BootStrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/main.css">

<style type="text/css">
	.if_rplace{
		border: none;
	}
	
	.if_notice{
		border: none;
	}
</style>

</head>
<body>

	<!-- 전체 박스 -->
	<div id="box">
		
		<!-- 헤더 -->
		<div id="header">
			<%@ include file="header.jsp" %>
		</div>
		
		<!-- 메뉴 -->
		<div id="nav">
			<%@ include file="menu.jsp" %>
		</div>
		
		<!-- 메인 -->
		<div id="main">
		
			<!-- 메뉴가 없거나 home인 경우 -> 메인화면 띄우기 -->
			<c:if test="${ empty param.menu }">
				<!-- 키워드검색 -->
				<div id="search">
				<%@include file="place/place_list.jsp" %>
				
				<c:if test="${ (param.menu eq 'place') and (not empty param.text_search) }">
				
					<jsp:forward page="place/search.do?text_search=${param.text_search}"></jsp:forward>
					
					<%-- <meta http-equiv="refresh" content="0;URL='place/search.do?text_search=${param.text_search}'"> --%>
					<%-- place/search.do?text_search=${param.text_search} --%>
				</c:if>
				<%-- 	<%@ include file="search.jsp" %> --%>
				</div>			
				
				<!-- 공지사항 -->	
				<div id="notice">
					<%@ include file="notice.jsp" %>
				</div>
				
				<!-- 인기글(조회수) -->
				<div id="best">
					<%@ include file="best.jsp" %>
				</div>
			</c:if>
			
			
			
			<!-- 1. 캠핑장소검색 누른 경우(menu=place) -->
			<c:if test="${ (param.menu eq 'place') }">
				<%@include file="place/place_list.jsp" %>	
			</c:if>
			
			
			<!-- 2. 캠핑장소추천 누른 경우(menu=recommend_place) -->
			<c:if test="${ (empty param.idx) and (param.menu eq 'recommend_place') }">
				<%-- <%@include file="recommend_place/rplace_list.jsp" %> --%>
				<iframe id="if_rplace" class="if_rplace" width="1000"  height="570" src="recommend_place/list.do"></iframe>	
			</c:if>
			
			<!-- 2-1. 베스트글 선택한 경우 -->
			<c:if test="${ not empty param.idx }">
				  <iframe id="if_rplace" class="if_rplace" width="1000"  height="570" src="recommend_place/view.do?idx=${param.idx} "></iframe>
			</c:if>
			
			<!-- 2-2. 캠핑장소추천 게시판에서 검색어 입력한 경우 -->
			<c:if test="${ not empty param.search }">
				  <iframe id="if_rplace" class="if_rplace" width="1000"  height="570" src="recommend_place/list.do?search=${search}&search_text=${encodeURIComponent(search_text)}"></iframe>
			</c:if>
			
			
			<!-- 3. 캠핑용품검색 누른 경우(menu=goods) -->
			<c:if test="${ (param.menu eq 'goods') }">
				<%@include file="goods/goods_list.jsp" %>	
			</c:if>
			
			<!-- 4. 공지사항 누른 경우(menu=notice) -->
			<c:if test="${ (empty param.n_idx) and (param.menu eq 'notice') }">
				<iframe id="if_notice" class="if_notice" width="1000"  height="570" src="notice/list.do"></iframe>	
			</c:if>
			
			<!-- 4-1. 공지사항글 선택한 경우 -->
			<c:if test="${ not empty param.n_idx }">
				<iframe id="if_notice" class="if_notice" width="1000"  height="570" src="notice/view.do?n_idx=${ param.n_idx }"></iframe>
			</c:if>
			
			<!-- 5. 마이페이지 누른 경우(menu=member) -->
			<c:if test="${ (param.menu eq 'member') }">
				<%@include file="member/member_index.jsp" %>	
			</c:if>
			
		
		</div>
		
		<!-- 푸터 -->			
		<div  id="footer">
			<%@ include file="footer.jsp" %>
		</div>
	
	
	</div>
</body>



</html>