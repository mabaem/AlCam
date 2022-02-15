<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	#div_member_box{
		margin: auto;
		/* padding: 20px; */
		font-family: '맑은 고딕';
		
	}
	#div_member_menu{
		width: 20%;
		float: left;
		padding: 20px;
		
	}
	#div_member_content{
		width: 80%;
		float: left;
		padding: 20px;
	}
	.dropdown:hover .dropdown-menu {
    	display: block;
    	margin-top: 0;
	}
	
	button{
		width: 100%;
	}
	a{
		color: black;
		text-decoration : none;
	}
	a:hover{
		color: black;
		text-decoration : none;
	}
	
	.if_member_index{
		border: none;
	}
	
</style>

<script type="text/javascript">

	function del_mem() {
		if(confirm("정말 탈퇴하시겠습니까?\n모든 회원정보가 삭제됩니다")==false) return;
		location.href="member/delete_mem.do?m_idx=${user.m_idx}";
	}
	
</script>

<!-- 로그인 안된 경우 -->
<c:if test="${ empty user }">
	<c:redirect url="member/login_form.do?reason=logout"/>
</c:if>

<!-- 로그인시에만 마이페이지 사용가능 -->
<c:if test="${ not empty user }">
<div id="div_member_box">

	<!-- 메뉴리스트 -->	
	<div id="div_member_menu" >
		<label style="font-size: 20px; margin-bottom: 20px;">마이페이지</label>
		
		<button class="btn btn-default" type="button" onclick="location.href='?menu=member&submenu=myprofile'">
		  	회원정보수정
		</button>
		  
	    <div class="dropdown">
		  <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
		  	즐겨찾기
		  <span class="caret"></span></button>
			  <ul class="dropdown-menu">
			    <li><a href="?menu=member&submenu=bookmark_place">캠핑장소</a></li>
			    <li><a href="?menu=member&submenu=bookmark_goods">캠핑용품</a></li>
			  </ul>
		</div>

		<!-- 회원만 회원탈퇴 출력 -->
		<c:if test="${ user.m_grade == '일반' }">
			<button class="btn btn-default" type="button" onclick="del_mem();">
		  		회원탈퇴
			</button>
		</c:if>
		
		<!-- 관리자만 관리자페이지 출력 -->
		<c:if test="${ user.m_grade == '관리자' }">
			<button class="btn btn-default" type="button" onclick="location.href='?menu=member&submenu=admin'">
		  		관리자페이지
			</button>
		</c:if>
	</div>
	
	<!-- 마이페이지 내용 출력 -->
	<div id="div_member_content">
	
		<!-- 마이페이지 기본화면(프로필사진, 환영인사) -->
		<c:if test="${ (param.menu eq 'member') and (empty param.submenu) }">
			<iframe class="if_member_index" width="800"  height="800" src="member/welcome.do?m_idx=${user.m_idx }"></iframe>
		</c:if>
		<!-- 회원정보수정 -->
		<c:if test="${ param.submenu eq 'myprofile'}">
		   <iframe class="if_member_index" width="800"  height="800" src="member/list.do?m_idx=${user.m_idx }"></iframe>
		</c:if>

		<!-- 즐겨찾기 -->
			<!-- 캠핑장소_즐겨찾기 -->
			<c:if test="${ param.submenu eq 'bookmark_place'}">
			   <iframe class="if_member_index" width="800"  height="800" src="member/bmkplace_list.do?m_idx=${user.m_idx }"></iframe>
			</c:if>
			
			<!-- 캠핑용품_즐겨찾기 -->
			<c:if test="${ param.submenu eq 'bookmark_goods'}">
			   <iframe class="if_member_index" width="800"  height="800" src="member/bmkgoods_list.do"></iframe>
			</c:if>
			
		<!-- 관리자페이지 -->
		<c:if test="${ param.submenu eq 'admin'}">
		   <iframe class="if_member_index"  width="800"  height="800" src="member/admin_list.do"></iframe>
		</c:if>
		
	</div>
	
</div>
</c:if>
