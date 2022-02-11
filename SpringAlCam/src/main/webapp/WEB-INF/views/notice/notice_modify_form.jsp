<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      width: 700px;
      margin: auto;
      margin-top: 50px;
  }
  
  textarea {
	  width: 100%;
	  height: 150px;
	  resize: none;
  }

</style>

<script type="text/javascript">

  

  function send(f){
	  
	  if(confirm("정말 수정 하시겠습니까?")==false) return;
	  
	  var n_subject = f.n_subject.value.trim();
	 
	  //공백처리
	  var n_content = f.n_content.value.replaceAll("\r\n","").trim();
	                	  
	  if(n_subject==''){
		  alert("제목을 입력하세요");
		  f.n_subject.value='';
		  f.n_subject.focus();
		  return;
	  }
	  
	  if(n_content==''){
		  alert("내용을 입력하세요");
		  f.n_content.value='';
		  f.n_content.focus();
	
		  return ;
	  }
	  
	  f.action = "modify.do?page=${ empty param.page ? 1 : param.page }&search=${ param.search }&search_text=${ param.search_text }"; //전송대상
	  f.submit();//전송
	  
	  
  }
  
  
  //JQuery 초기화
  $(document).ready(function(){
	  
	  
  });


</script>


</head>
<body>

<form>
  <input type="hidden"  name="n_idx"   value="${ vo.n_idx }">
  <input type="hidden"  name="page"    value="${ param.page }">
  <input type="hidden"  name="search"    value="${ param.search }">
  <input type="hidden"  name="search_text"    value="${ param.search_text }">
  
  <div id="box">
        <div class="panel panel-primary">
	      <div class="panel-heading"><h3>공지사항 수정하기</h3></div>
	      <div class="panel-body">
	          <table class="table">
	              <tr>
	                 <th width="10%">제목</th>
	                 <td><input name="n_subject"  style="width: 100%;"  value="${ vo.n_subject }"></td>
	              </tr>
	              
	              <tr>
	                 <th>내용</th>
	                 <td>
	                     <textarea id="n_content" name="n_content" >${ vo.n_content }</textarea>
	                     
	                 </td>
	              </tr>
	              
	              <tr>
	                 <td colspan="2" align="center">
	                      <input class="btn  btn-primary" type="button"  value="수정하기" onclick="send(this.form);">
	                      <input class="btn  btn-success" type="button"  value="목록보기" onclick="location.href='list.do?page=${ param.page }&search=${ param.search }&search_text=${ param.search_text }'">
	                 </td>
	              </tr>
	          </table>
	      
	      </div>
	    </div>
  </div>
</form>
  
</body>
</html>