<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
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

	#member_box{
		width: 500px;
		margin: auto;
		margin-top: 50px;
	}
	
	#admin_box{
		width: 1500px;
		margin: auto;
		margin-top: 50px;
	}

	table{
		width: 100%;
	}
	
	th{
		text-align: center;
		font-weight: bold;
	}
	
	#title{
		text-align: center;
		
		font-size: 25px;
		font-weight: bold;
	}
	
	#empty_message{
		text-align: center;
		color: red;
		font-size: 15px;
		font-weight: 800;
	}
	
	#data_align > td {
		text-align: center; 
		vertical-align: middle;
	}

</style>


<script type="text/javascript">

	function del(m_idx) {
		
		//if(confirm("정말 삭제하시겠습니까?")==false) return;
		//location.href="delete.do?m_idx=" + m_idx ;
		
		Swal.fire({
			  title: '정말 삭제하시겠습니까?',
			  text: "선택한 회원정보를 삭제합니다",
			  icon: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '삭제',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
				  location.href="delete.do?m_idx=" + m_idx;
				  
			  }
			})
	
	}
	
	//수정폼 띄우기
	function modify_form(m_idx) {

		//if(confirm("정말 수정하시겠습니까?")==false) retrun;
		//location.href="modify_form.do?m_idx=" + m_idx;

		Swal.fire({
			  title: '정말 수정하시겠습니까?',
			  text: "선택한 회원정보를 수정합니다",
			  icon: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '수정',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
				  location.href="admin_modify_form.do?m_idx=" + m_idx;

			  }
			})
			
	}

</script>

</head>
<body>


	<div>

		<!-- 관리자 로그인 -->
		<c:if test="${ user.m_grade == '관리자' }">
		<div id="admin_box">
		      
			 <table id="data_align" class="table">
						
		      		<tr class="success">
		      			<th>번호</th>
		      			<th>프로필사진</th>
		      			<th>이름</th>
		      			<th>아이디</th>
		      			<th>비밀번호</th>
		      			<th>생년월일</th>
		      			<th>성별</th>
		      			<th>전화번호</th>
		      			<th>이메일</th>
		      			<th>우편번호</th>
		      			<th>주소</th>
		      			<th>가입일자</th>
		      			<th>회원구분</th>
		      			<th>편집</th>
		      		</tr>
		      		
		      		<!-- Data가 없는 경우 -->
		      		<c:if test="${ empty list }">
		      			<tr>
		      				<td id="empty_message" colspan="10">회원정보가 없습니다</td>
		      			</tr>
		      		</c:if>
		      		   		
		      		<!-- Data가 있는 경우 -->
		      		<c:forEach var="vo" items="${ list }">
		      			<tr id="data_align">
			      		   		<td>${ vo.m_idx }</td>
			      		   		<td>
			      		   			<img src="${ pageContext.request.contextPath }/resources/image/${ vo.m_filename }" width="90" height="90">
			      		   		</td>
			      		   		<td>${ vo.m_name }</td>
			      		   		<td>${ vo.m_id }</td>
			      		   		<td>${ vo.m_pwd_hidden }</td>
			      		   		<td>${ vo.m_byear }/${ vo.m_bmonth }/${ vo.m_bday }</td>
			      		   		<td>${ vo.m_gender }</td>
			      		   		<td>
			      		   			<!-- 전화번호가 10자리인 경우 -->
			      		   			<c:if test="${ fn:length(vo.m_tel)==10 }">
			      		   				${fn:substring(vo.m_tel, 0, 3)}-${fn:substring(vo.m_tel, 3, 6)}-${fn:substring(vo.m_tel, 6, 10)}
			      		   			</c:if>
			      		   			<!-- 전화번호가 11자리인 경우 -->
			      		   			<c:if test="${ fn:length(vo.m_tel)==11 }">
			      		   				${fn:substring(vo.m_tel, 0, 3)}-${fn:substring(vo.m_tel, 3, 7)}-${fn:substring(vo.m_tel, 7, 11)}
			      		   			</c:if>
			      		   		</td>
			      		   		<td>${ vo.m_email }</td>
			      		   		<td>${ vo.m_zipcode }</td>
			      		   		<td>${ vo.m_addr }</td>
			      		   		<td>${ fn:substring(vo.m_regdate,0,10) }</td>
			      		   		<td>${ vo.m_grade }</td>
			      		   		<td>
				      		   			<input class="btn btn-info"   type="button" value="수정" onclick="modify_form('${ vo.m_idx }');">
				      		   			<input class="btn btn-danger" type="button" value="삭제" onclick="del('${ vo.m_idx }');">
			      		   		</td>
			      	</tr>
					</c:forEach>
			 </table>
			      
		 </div>
		 </c:if>

</div>

</body>
</html>