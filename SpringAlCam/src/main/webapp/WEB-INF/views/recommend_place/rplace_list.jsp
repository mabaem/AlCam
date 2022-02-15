<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
  
	#rplace_title{
	    font-size: 20px;
	    font-family: '맑은 고딕';
	    font-weight: bold;
	      
	}
	
	#rplace_box{
		width: 100%;
		margin: auto;
		margin-top: 20px;
	}
	
	#rplace_search_menu{
		text-align: center;
		margin-top: 2px;
		margin-bottom: 2px;
	}  
	
	#btn_rplace_insert{
		float: right;
	}
	 
	 
	/* page */
	#page_menu{
	}
	
	/* Paging.java CSS */
	.page_box{
  	}
  	a:hover, /* OPTIONAL*/
	a:visited,
	a:focus
  {text-decoration: none;}  

</style>


<script type="text/javascript">
   
   //글쓰기
   function insert_form(){
	   
	   //로그인 여부 체크
	   if("${ empty user }" == "true"){
		   
		   if(confirm("로그인 하신후 글쓰기가 가능합니다\n로그인 하시겠습니까?")==false)return;
		   
		   //로그인 폼
		   //location.href="${ pageContext.request.contextPath }/member/login_form.do";
		   window.parent.location.href="${ pageContext.request.contextPath }/member/login_form.do";
		   return;
	   }
	   
	   //글쓰기 폼으로 이동:
	   location.href="${ pageContext.request.contextPath }/recommend_place/insert_form.do?page= ${ empty param.page ? 1 : param.page }"

   }//end insert_form()

   
/*    //검색메뉴
   function search_condition(){
	   
	   var search 		= $("#search").val();	
	   var search_text	= $("#search_text").val().trim();
	   var page = ${ param.page};
	   
	   //전체검색이 아닌데 검색어가 비어있는 경우
	   if(search != 'all' && search_text==''){
		   
		   alert("검색어를 입력하세요");
		   $("#search_text").val("");
		   $("#search_text").focus();
		   return;  
	   }
	   
	   //검색요청
	   location.href="list.do?search=" + search + "&search_text=" + encodeURIComponent(search_text);
	   
	   
   }//end search() */
   
   
   //function search_condition_rplace
   $(document).ready(function(){
		$("#search_condition_rplace").click(function() {
			
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
			   location.href="list.do?search=" + search + "&search_text=" + encodeURIComponent(search_text);
			   
		});
   });
   

</script>


<script type="text/javascript">

   $(document).ready(function(){
	   
	   setTimeout(show_message,200);
	   
	   //검색메뉴	   
	   //검색어가 있는 경우
	   if("${ not empty param.search }" == "true"){
		   
		   $("#search").val("${ param.search }");
			
		   //전체보기 -> 검색어 지우기
		   if("${ param.search eq 'all' }" == "true"){
			   
			   $("#search_text").val("");
			   
		   }
		   
	   }
	   
   });
   
   function show_message(){
	   
	   if("${ param.reason eq 'session_timeout'}" == "true"){
		   
		   alert("로그아웃되었습니다\n로그인 하신후 이용하세요");
		   
	   }
   }
   


</script>

  <div style="margin-bottom: 10px; margin-right: 10px;">
  	
  	 <font id="rplace_title">캠핑장소추천</font>
  	 
  	 <!-- 글쓰기 버튼 -->
 	 <input class="btn" id="btn_rplace_insert" type="button"  value="글쓰기" 
            onclick="insert_form();">
  </div>
   
  <div id="rplace_box">
       <!-- 게시글 리스트 -->
       <table class="table  table-striped table-hover ">
             
             <!-- 제목 -->
             <tr>
                 <th width="10%">번호</th>
                 <th width="45%">제목</th>
                 <th width="13%">작성자</th>
                 <th width="20%">작성일</th>
                 <th width="12%">조회수</th>
                 
             </tr>
             
             <!-- 데이터가 없는 경우 -->
             <c:if test="${ empty list }">
                 <tr>
                    <td colspan="5" align="center">
                       <font color="black">작성된 게시글이 없습니다</font>
                    </td>
                 </tr>
             </c:if>
        
             <!-- 데이터가 있는 경우 -->
             <c:if test="${ not empty list }">
	             <c:forEach var="vo"  items="${ list }">
	                <tr>
	                    <td>${ vo.idx }</td>
	                    <td style="text-align: left; text-indent: 10px;">
	                         <!-- 삭제되지 않은 게시물이면 -->
	                         <c:if test="${ vo.use_yn eq 'y' }">
	                         	 <a href="view.do?idx=${ vo.idx }&page=${ empty param.page ? 1 : param.page }&search=${ empty param.search? 'all' : param.search }&search_text=${ param.search_text }">
	                         	 	${ vo.subject }
	                         	 </a>
	                         </c:if>
	                         
	                         <!-- 삭제된 게시물이면 -->
	                         <c:if test="${ vo.use_yn eq 'n' }">
	                             <font color=red>(삭제된 게시물) ${ vo.subject }</font>
	                         </c:if>
	                    </td>
	                    <td>${ vo.m_name }</td>
	                    <td>${ fn:substring(vo.regdate,0,10) }</td>
	                    <td>${ vo.readhit }</td>
	                </tr>
	             </c:forEach>
          	 </c:if>
             
             <!-- 페이지 메뉴 -->
             <tr>
                <td colspan="5" align="center">
                    
                    <div id="page_menu"> 
                     ${ pageMenu }
                    </div>
                                        
                     
                </td>
             </tr>
             
             
       
       </table>
       
      <!-- 검색메뉴 -->
    <div id="rplace_search_menu" style="margin-top: 15px">
     	<select id="search">
     		<option value="all">전체보기</option>
     		<option value="name">이름</option>
     		<option value="subject">제목</option>
     		<option value="content">내용</option>
     		<option value="name_subject_content">이름+제목+내용</option>
          </select>
          <input id="search_text" value="${ param.search_text }">
          <input  class="btn-default" type="button" value="검색" id="search_condition_rplace">
     </div>
       
      
       
  </div>  
