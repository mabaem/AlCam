<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	
	#admin_box{
		width: 700px;
		margin: auto;
	}

	#admin_data_align{
		width: 100%;
	}
	
	#admin_title{
		text-align: center;
		
		font-size: 20px;
		font-weight: bold;
		
		margin-bottom: 20px;
	}
	
	#admin_search_menu{
		text-align: center;
		
		margin-bottom: 10px;
	}
	
	#admin_empty_message{
		text-align: center;
		color: red;
		font-size: 15px;
		font-weight: 800;
	}
	
	th{
		text-align: center;
		font-weight: bold;
	}
	
	#admin_align > td {
		text-align: center; 
		vertical-align: middle;
	}
	
	#page_align{
		text-align: center;
	}

</style>


<script type="text/javascript">

	function del(m_idx) {
		
		if(confirm("정말 삭제하시겠습니까?\n모든 회원정보가 삭제됩니다")==false) return;
		location.href="delete.do?m_idx=" + m_idx + "&page=${ empty param.page ? 1 : param.page }";
	
	}
	
	//수정폼 띄우기
	function modify_form(m_idx) {

		if(confirm("정말 수정하시겠습니까?")==false) retrun;
		location.href="admin_modify_form.do?m_idx=" + m_idx + "&page=${ empty param.page ? 1 : param.page }";
			
	}
	
	
	$(document).ready(function(){
		
		//검색
		$("#search_condition_admin").click(function() {
			
			   var search 		= $("#search").val();	
			   var search_text	= $("#search_text").val().trim();
			   
			   //전체검색이 아닌데 검색어가 비어있는 경우
			   if(search != 'all' && search_text==''){   
				   alert("검색어를 입력하세요");
				   $("#search_text").val("");
				   $("#search_text").focus();
				   return;  
			   }
			   
			   //검색요청
			   location.href="admin_list.do?search=" + search + "&search_text=" + encodeURIComponent(search_text);
			   
		});
		
	});
	   

</script>

	<div>

		<!-- 관리자 로그인 -->
		<c:if test="${ user.m_grade == '관리자' }">
		<h1 id="admin_title">관리자페이지</h1>
		<div id="admin_box">
		
			<!-- 검색메뉴 -->
		    <div id="admin_search_menu">
		     	<select id="search">
		     		<option value="all">전체보기</option>
		     		<option value="id">아이디</option>
		     		<option value="name">이름</option>
		     		<option value="id_name">아이디+이름</option>
		          </select>
		          <input id="search_text" value="${ param.search_text }">
		          <input class="btn-default" type="button" value="검색" id="search_condition_admin">
		     </div>
		      
			 <table class="table" id="admin_data_align">
						
		      		<tr class="success">
		      			<th>번호</th>
		      			<th>이름</th>
		      			<th>아이디</th>
		      			<th>가입일자</th>
		      			<th>회원구분</th>
		      			<th>편집</th>
		      		</tr>
		      		
		      		<!-- Data가 없는 경우 -->
		      		<c:if test="${ empty list }">
		      			<tr>
		      				<td id="admin_empty_message" colspan="10">회원정보가 없습니다</td>
		      			</tr>
		      		</c:if>
		      		   		
		      		<!-- Data가 있는 경우 -->
		      		<c:forEach var="vo" items="${ list }">
		      			<tr id="admin_align">
		      		   		<td>${ vo.m_idx }</td>
		      		   		<td>${ vo.m_name }</td>
		      		   		<td>${ vo.m_id }</td>
		      		   		<td>${ fn:substring(vo.m_regdate,0,10) }</td>
		      		   		<td>${ vo.m_grade }</td>
		      		   		<td>
		      		   			<input class="btn btn-info"   type="button" value="수정" onclick="modify_form('${ vo.m_idx }');">
		      		   			<input class="btn btn-danger" type="button" value="삭제" onclick="del('${ vo.m_idx }');">
		      		   		</td>
			      		</tr>
					</c:forEach>
					
			 </table>
			 
			 <!-- 페이징메뉴 -->
			 <c:if test="${ not empty list }">
				<div id="page_align">
					${ pageMenu }
				</div>
			 </c:if>
			      
		 </div>
		 </c:if>

</div>
