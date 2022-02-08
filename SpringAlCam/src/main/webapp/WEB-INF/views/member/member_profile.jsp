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

	#box{
		width: 500px;
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
				  location.href="modify_form.do?m_idx=" + m_idx;

			  }
			})
			
	}

</script>

</head>
<body>


	<div>
		<h1 id="title">프로필정보</h1>
	

	  	<div id="box">
		      <table id="data_align" class="table">
		      
		      		<tr>
		      			<th>프로필사진</th>
		      			<td>
			      		   	<img src="${ pageContext.request.contextPath }/resources/image/${ user_vo.m_filename }" width="90" height="90">
			      		</td>
			      	</tr>
			      	<tr>
		      			<th>이름</th><td>${ user_vo.m_name }</td>
		      		</tr>	
		      		<tr>
		      			<th>아이디</th><td>${ user_vo.m_id }</td>
		      		</tr>	
		      		<tr>
		      			<th>비밀번호</th><td>${ user_vo.m_pwd_hidden }</td>
		      		</tr>	
		      		<tr>
		      			<th>생년월일</th><td>${ user_vo.m_byear }/${ user_vo.m_bmonth }/${ user_vo.m_bday }</td>
		      		</tr>	
		      		<tr>
		      			<th>성별</th><td>${ user_vo.m_gender }</td>
		      		</tr>	
		      		<tr>
		      			<th>전화번호</th>
		      			<td>
	      		   			<!-- 전화번호가 10자리인 경우 -->
	      		   			<c:if test="${ fn:length(user_vo.m_tel)==10 }">
	      		   				${fn:substring(user_vo.m_tel, 0, 3)}-${fn:substring(user_vo.m_tel, 3, 6)}-${fn:substring(user_vo.m_tel, 6, 10)}
	      		   			</c:if>
	      		   			<!-- 전화번호가 11자리인 경우 -->
	      		   			<c:if test="${ fn:length(user_vo.m_tel)==11 }">
	      		   				${fn:substring(user_vo.m_tel, 0, 3)}-${fn:substring(user_vo.m_tel, 3, 7)}-${fn:substring(user_vo.m_tel, 7, 11)}
	      		   			</c:if>
			      		 </td>
		      		</tr>	
		      		<tr>
		      			<th>이메일</th><td>${ user_vo.m_email }</td>
		      		</tr>	
		      		<tr>
		      			<th>우편번호</th><td>${ user_vo.m_zipcode }</td>
		      		</tr>	
		      		<tr>
		      			<th>주소</th><td>${ user_vo.m_addr }</td>
		      		</tr>	
		      		<tr>
		      			<th>가입일자</th><td>${ fn:substring(user_vo.m_regdate,0,10) }</td>
		      		</tr>	
		      		<tr>
		      			<td colspan="2" style="text-align: center;">
		      				<input class="btn btn-info"   type="button" value="정보수정" onclick="modify_form('${ user_vo.m_idx }');">
		      			</td>
		      		</tr>
		      
		      </table>
	    </div>				

</div>

</body>
</html>