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

<!-- SweetAlert2 사용설정 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style type="text/css">
	#member_index_box{
		margin: auto;
		/* padding: 20px; */
		font-family: '맑은 고딕'
	}
	#div_member_menu{
		width: 30%;
		float: left;
		padding: 20px;
	}
	#div_member_content{
		width: 70%;
		float: left;
		padding: 20px;
	}
	#member_index_name{
		font-weight: bold;
		font-size: 18px;
	}
	#member_index_hello{
		font-size: 16px;
	}
	
	.if_member_index{
		border: none;
	}
	
</style>

<script type="text/javascript">
	
	function del_mem() {
		//if(confirm("정말 탈퇴하시겠습니까?")==false) return;
		//location.href="member/delete_mem.do?m_idx=${user.m_idx}";
		
		Swal.fire({
			  title: '정말 탈퇴하시겠습니까?',
			  text: "모든 회원정보가 삭제됩니다",
			  icon: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '탈퇴',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
				  location.href="member/delete_mem.do?m_idx=${user.m_idx}";
			  }
			})
	}
	
</script>

</head>
<body>

<div id="member_index_box">

	<!-- 메뉴리스트 -->	
	<div id="div_member_menu" class="list-group">
		<label style="font-size: 20px; margin-bottom: 20px;">마이페이지</label>		
		<!-- ###########각 리스트 클릭시 해당 아이템카테고리 리스트 출력########### -->

		<a href="?menu=member&submenu=myprofile" class="list-group-item">회원정보수정</a>
	
		<a href="#" class="list-group-item">즐겨찾기</a>
		
		<!-- 회원만 회원탈퇴 출력 -->
		<c:if test="${ user.m_grade == '일반' }">
			<a class="list-group-item" onclick="del_mem();">회원탈퇴</a>
		</c:if>
		
		<!-- 관리자만 관리자페이지 출력 -->
		<c:if test="${ user.m_grade == '관리자' }">
			<a href="?menu=member&submenu=admin" class="list-group-item">관리자페이지</a>
		</c:if>
	</div>
	
	<!-- 마이페이지 내용 출력 -->
	<div id="div_member_content">
		 
		<!-- 마이페이지 기본화면(프로필사진, 환영인사) -->
		<c:if test="${ (param.menu eq 'member') and (empty param.submenu) }">
			<div style="text-align: center; margin-top: 20px;">		
				<img src="${ pageContext.request.contextPath }/resources/image/${ user.m_filename }" width="90" height="90">
				<br><br>
				<span id="member_index_name">${ user.m_name }</span><span id="member_index_hello">님 안녕하세요</span>
			</div>
		</c:if>
		
		 
		<!-- 각 리스트 눌렀을 때 div_member_content에 내용 뿌려주기 -->
		<!-- 회원정보수정 -->
		<c:if test="${ param.submenu eq 'myprofile'}">
		   <iframe class="if_member_index" width="800"  height="500" src="member/list.do?m_idx=${user.m_idx }"></iframe>
		</c:if>

		<!-- 즐겨찾기 -->
			<!-- 즐겨찾기_용품 -->
			<!-- 즐겨찾기_장소 -->
			
		<!-- 관리자페이지 -->
		<c:if test="${ param.submenu eq 'admin'}">
		   <iframe class="if_member_index"  width="800"  height="500" src="member/admin_list.do"></iframe>
		</c:if>
		
	</div>
	
</div>

</body>
</html>