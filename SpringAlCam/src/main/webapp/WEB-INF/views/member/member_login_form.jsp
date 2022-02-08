<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알캠 로그인</title>

<!-- BootStrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	#box_login{
		width: 600px;
		height: 600px;
		margin-left: auto;
		margin-right: auto;
		margin-top: 150px;
		
		font-family: '맑은 고딕';
	}
	#title_login{
		text-align: center;			
		margin-top: 30px;
		margin-bottom: 30px;
	}
	#img_btn_home{
		width: 250px;
		height: 110px;
	}
	#input_id, #input_pwd{
		margin: 10px auto;
	}
	#m_id, #m_pwd{
		width: 400px;
	}
	#subject_login{	
		margin-top: 30px;
	}
	#btn_group_login{
		text-align: center;
	}
	
</style>

<script type="text/javascript">
  function  send(f){
	  
	  var m_id  = f.m_id.value.trim();
	  var m_pwd = f.m_pwd.value.trim();
	  
	  if(m_id == ''){
		  alert('아이디를 입력하세요');
		  f.m_id.value='';
		  f.m_id.focus();
		  return;
	  }
	  
	  if(m_pwd == ''){
		  alert('비밀번호를 입력하세요');
		  f.m_pwd.value='';
		  f.m_pwd.focus();
		  return;
	  }
	  
	  f.action = "login.do"; // MemberLoginAction
	  f.submit();//전송
	  
  }

  
  $(document).ready(function(){
	 
	  setTimeout(show_message,100);
	  
  });
  
  
  function show_message(){
	  // /member/login_form.do?reason=fail_id

      if("${ param.reason eq 'fail_id'}"=="true"){
    	  
    	  alert('아이디가 틀렸습니다');
    	  
      }	
	  
      // /member/login_form.do?reason=fail_pwd
	  if("${ param.reason eq 'fail_pwd'}"=="true"){
    	  
    	  alert('비밀번호가 틀렸습니다');
    	  
      }	
	  
  }
  
</script>

</head>
<body>

<!-- 읽던 페이지 url 정보 읽어오기 -->
<input type="hidden"  name="url"  value="${ param.url }">   

<div class="container" id="box_login">
	<div id="title_login">
		<a href="../main.do">
			<img id="img_btn_home" src="${ pageContext.request.contextPath }/resources/image/logo.png" alt="알고싶지캠핑?">
		</a>
	</div>
	
	<div id="subject_login">
		<form class="form-horizontal" action="/action_page.php">
			<div id="input_id" class="form-group">
				<label class="control-label col-sm-2">아이디:</label>
			    <div class="col-sm-10">
			    	<input type="text" class="form-control" id="m_id" name="m_id" placeholder="아이디를 입력하세요">
			    </div>
			</div>
			
			<div class="form-group" id="input_pwd">
				<label class="control-label col-sm-2">패스워드:</label>
				<div class="col-sm-10">
					<input type="password" class="form-control" id="m_pwd" name="m_pwd" placeholder="비밀번호를 입력하세요">
				</div>
			</div>
			
			<!-- <div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="checkbox">
						<label><input type="checkbox" name="remember">로그인 정보 저장</label>
					</div>
				</div>
			</div> -->
			
		    <div class="form-group" id="btn_group_login">
		    	<div class="col-sm-offset-2 col-sm-10">
		    		<button type="button" id="btn_login" class="btn btn-default" onclick="send(this.form);">로그인</button>
		    		<button type="button" id="btn_join_form" class="btn btn-default" onclick="location.href='insert_form.do'">회원가입</button>
		    	</div>
		    </div>
    	</form>
    </div>
</div>


</body>
</html>