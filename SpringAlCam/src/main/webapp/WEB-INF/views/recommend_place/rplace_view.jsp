<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>     
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
   #box{
       width: 800px;
       margin: auto;
       margin-top: 20px; 
   }
   
   #content_type{
       width: 100%;
       min-height: 100px; 
       height: auto;
       border: 1px solid #cccccc;
       padding: 5px;
   }
   
   /* 댓글입력창 CSS */   
   #comment_content{
		width: 80%;
		height: 80px;
		resize: none;
		float: left;
   }
   
   #comment_button{
   		width: 20%;
		height: 80px;
		float: left;
   }
   
   #comment_display{
   		clear: both;
   		margin-top: 50px;
   }
   
   /* page */
	.page_box{
	  	display: inline-block;
	  	width: 20px;
	  	height: 20px;
	  	border: 1px solid gray;
	  	text-align: center;
	  	
  	}
  	
  	a:hover, /* OPTIONAL*/
	a:visited,
	a:focus{
		text-decoration: none;
	} 
   
</style>


<script type="text/javascript">


  //페이지 전역변수 선언
  var comment_page = 1;

   
  
  function rplace_delete(){
	  
	  if(confirm("정말 삭제 하시겠습니까?")==false) return;
	  
	  //삭제      
	  location.href="${ pageContext.request.contextPath }/recommend_place/delete.do?idx=${ vo.idx }&page=${ param.page }&search=${ param.search }&search_text=${ param.search_text }";
	  
	  
  }//end:rplace_delete
  
  /* 
  function add_comment(){
	  
	  //로그인 여부 체크
	  if("${ empty user }" == "true"){
		   
		   if(confirm("로그인 하신후 댓글달기가 가능합니다\n로그인 하시겠습니까?")==false)return;
		   
		   //로그인 폼
		   location.href="${ pageContext.request.contextPath }/member/login_form.do?url=" + 
				                                        encodeURIComponent(location.href);
		   return;
	   }
	  
	  //입력값 체크
	  var c_content = $("#comment_content").val().trim();
	  
	  if(c_content==''){
		  
		  alert("댓글을 입력하세요");
		  $("#comment_content").val("");
		  $("#comment_content").focus();
		  
		  return;
		  
	  }
	  
	  //ajax로 입력한 정보 전송
	  $.ajax({
		  url     : "${ pageContext.request.contextPath }/comment/insert.do",
		  data    : { "c_content" : c_content,
			  	      "m_idx"	  : "${ user.m_idx }",
			  	      "m_id"	  : "${ user.m_id }",
			  	      "m_name"	  : "${ user.m_name }",
			  	      "idx"	  : "${ vo.idx }"
		  		    },
		  dataType : "json",
		  success  : function(result_data){
			  			// result_data = {"result":"success"}
			  			// result_data = {"result":"fail"}
			  			
			  			//실패한 경우
			  			if(result_data.result == 'fail'){
			  				alert("댓글쓰기 실패");
			  			}		
			  			
			  			//성공한 경우
			  			comment_list(1);	//comment_list 함수 호출(인자 : page)
			  			
			  			//입력값 지우기
			  			$("#comment_content").val("");
		 			 },
		  error	   : function(err){
			  			alert(err.responseText);
		  			 }
	  });
	  
	  
  }//end:add_comment
  
  
   
  //댓글목록 가져오기
  function comment_list(page){
	  
	  comment_page = page;
	  
	  //ajax 요청
	  $.ajax({
		  url	  : "${ pageContext.request.contextPath }/comment/list.do",
		  data	  : { "idx" : "${ vo.idx }",
			          "page"  : page },
		  success : function(result_data){
			  			$("#comment_display").html(result_data);
		  			},
		  error	  : function(err){
			  			alert(err.responseText);
		 			}
	  });
	  
  }//end:comment_list(page)
  
  
  //jQuery 초기화
  $(document).ready(function(){
	  
	  comment_list(1); 
	  
  });
  */

</script>

</head>
<body>
  <div id="box">
  	    <div class="panel panel-primary">
	      <div class="panel-heading"><h3>${ vo.m_name }님의 글</h3></div>
	      <div class="panel-body">
	          <table class="table">
	          	   <tr>
	          	   	   <!-- 이미지 -->
	                   <th rowspan="6">
	                   	  <img src="${ pageContext.request.contextPath }/resources/image/${ vo.filename }" width="100" height="100">
	                   </th>
                   
	                   <!-- 제목 -->
	          	   	   <th width="20%">제목</th>
	                   <td>${ vo.subject }</td>
	          	   </tr>
	          	   
	          	   <tr>
	                   <!-- 작성자 -->
	                   <th>작성자</th>
	                   <td>${ vo.m_name }</td>  
	               </tr>
	              
	               <tr>
	                   <!-- 내용 -->
	                   <th>내용</th>
	                   <td>
	                      <div id="content_type">${ vo.content }</div>
	                   </td>  
	               </tr>
	               
	               <!-- 작성일자 -->
	               <tr>
	                   <th>작성일자</th>
	                   <td>${ vo.regdate }</td>
	               </tr>
	               
	               <!-- 캠핑장 -->
	               <tr>
	               		<th>캠핑장</th>
	               		<td>${ vo.p_name }</td>
	               </tr>
	               
	               <!-- 주소 -->
	               <tr>
	               		<th>주소</th>
	               		<td>${ vo.p_addr }</td>
	               </tr>
	               
	               <!-- 버튼 -->
	               <tr>
	                  <td colspan="3"  align="center">
	                        
	                        <input class="btn  btn-success" type="button"  value="목록보기" 
	                               onclick="location.href='${ pageContext.request.contextPath }/recommend_place/list.do?page=${ param.page }&search=${ param.search }&search_text=${ param.search_text }'">
	                        
	                        
	                        <!-- 글쓴이 본인만 처리되도록 -->
	                        <c:if test="${ user.m_idx == vo.m_idx }">
		                        <input class="btn  btn-info"    type="button"  value="수정하기" 
		                               onclick="location.href='${ pageContext.request.contextPath }/recommend_place/modify_form.do?idx=${ vo.idx }&page=${ param.page }&search=${ param.search }&search_text=${ param.search_text }'">
		                        <input class="btn  btn-danger"  type="button"  value="삭제하기" 
		                               onclick="rplace_delete();">
	                        </c:if>
	                  
	                  </td>
	               </tr>
	               
	          </table>
	      </div>
	    </div> <!-- End Panel -->
	    
	    
	    <!-- 
	    댓글입력창
	    <div>
	    	<textarea id="comment_content" rows="" cols="" placeholder="댓글은 로그인 후에 작성가능합니다."></textarea>
	   		<input class="btn btn-info" id="comment_button" type="button" value="댓글달기" onclick="add_comment();">
	    </div>
	    
	    <hr>
	    
	    댓글출력창
	    <div id="comment_display">
	    	
	    </div> -->
	    
	    
  </div> <!-- End "box" -->
</body>
</html>