<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

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
	  
	  var photo   = f.photo.value;
	  var subject = f.subject.value.trim();	 
	  var p_name = f.p_name.value;
	  var p_addr = f.p_addr.value;

	  //공백처리
	  var content = f.content.value.replaceAll("\r\n","").trim();
	               	  
	  if(subject==''){
		  alert("제목을 입력하세요");
		  f.subject.value='';
		  f.subject.focus();
		  return;
	  }
	  
	  if(content==''){
		  alert("내용을 입력하세요");
		  f.content.value='';
		  f.content.focus();
	
		  return ;
	  }
	  
	  f.action = "modify.do?page=${ empty param.page ? 1 : param.page }&search=${ param.search }&search_text=${ param.search_text }"; //전송대상
	  f.submit();//전송
	  
	  
  }
  
  
  //JQuery 초기화
  $(document).ready(function(){
	  
	  
  });


</script>


<form name="f" method="POST" action="insert.do" enctype="multipart/form-data">
  <input type="hidden"  name="idx"   value="${ vo.idx }">
  <input type="hidden"  name="page"    value="${ param.page }">
  <input type="hidden"  name="search"    value="${ param.search }">
  <input type="hidden"  name="search_text"    value="${ param.search_text }">
  
  <div id="box">
        <div class="panel panel-success">
          <h3 style="margin-left: 20px;">수정하기</h3>
	      <div class="panel-body">
	          <table class="table">
	              <tr>
	                 <th width="10%">제목</th>
	                 <td><input name="subject"  style="width: 100%;"  value="${ vo.subject }"></td>
	              </tr>
	              
	              <tr>
	                 <th>내용</th>
	                 <td>
	                     <textarea id="content" name="content" >${ vo.content }</textarea>
	                     
	                 </td>
	              </tr>
	              
	              <tr>
	                 <th>캠핑장소</th>
	                 <td>
	                 	<input type="text" id="p_name" name="p_name" placeholder="캠핑장 이름" style="width: 60%;" value="${ vo.p_name }"><br>
	                 	<input type="text" id="p_addr" name="p_addr" placeholder="캠핑장 주소" style="width: 60%;" value="${ vo.p_addr }">
	                 	<input type="button" id="btn_rplace"  value="장소검색"
	                 		onclick="window.open('popup.do','popup_rplace','top=100,left=300,width=600,height=500,location=no,status=no,scrollbars=yes');">
	                 </td>
	              		
	              </tr>
	              
	              <tr>
				 	 <th>이미지첨부</th>
					 <td><input type="file" name="photo"></td>
				 </tr>
	              
	              
	              <tr>
	                 <td colspan="2" align="center">
	                      <input class="btn  btn-info" type="button"  value="수정" onclick="send(this.form);">
	                      <input class="btn  btn-default" type="button"  value="취소" onclick="location.href='list.do?page=${ param.page }&search=${ param.search }&search_text=${ param.search_text }'">
	                 </td>
	              </tr>
	          </table>
	      
	      </div>
	    </div>
  </div>
</form>
