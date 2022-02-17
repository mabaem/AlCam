<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

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
		
		margin-bottom: 40px;
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

<script type="text/javascript"  >
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
			  
	 if("${ param.reason eq 'logout'}"=="true"){
    	  
    	  alert('로그인 세션이 만료되었습니다\n로그인 후 이용해주십시오');
    	  
      }			  

      if("${ param.reason eq 'fail_id'}"=="true"){
    	  
    	  alert('아이디가 틀렸습니다');
    	  
      }	
	  
      // /member/login_form.do?reason=fail_pwd
	  if("${ param.reason eq 'fail_pwd'}"=="true"){
    	  
    	  alert('비밀번호가 틀렸습니다');
    	  
      }	
	  
	  $(document).ready(function(){
		    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
		    var userInputId = getCookie("userInputId");
		    $("input[name='m_id']").val(userInputId); 
		     
		    if($("input[name='m_id']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
		        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
		    }
		     
		    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
		        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
		            var userInputId = $("input[name='m_id']").val();
		            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
		        }else{ // ID 저장하기 체크 해제 시,
		            deleteCookie("userInputId");
		        }
		    });
		     
		    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
		    $("input[name='m_id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
		        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
		            var userInputId = $("input[name='m_id']").val();
		            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
		        }
		    });
		});
		 
		function setCookie(cookieName, value, exdays){
		    var exdate = new Date();
		    exdate.setDate(exdate.getDate() + exdays);
		    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		    document.cookie = cookieName + "=" + cookieValue;
		}
		 
		function deleteCookie(cookieName){
		    var expireDate = new Date();
		    expireDate.setDate(expireDate.getDate() - 1);
		    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
		}
		 
		function getCookie(cookieName) {
		    cookieName = cookieName + '=';
		    var cookieData = document.cookie;
		    var start = cookieData.indexOf(cookieName);
		    var cookieValue = '';
		    if(start != -1){
		        start += cookieName.length;
		        var end = cookieData.indexOf(';', start);
		        if(end == -1)end = cookieData.length;
		        cookieValue = cookieData.substring(start, end);
		    }
		    return unescape(cookieValue);
		}
	 
      
  }
  
</script>

 

<div class="container" id="box_login">
	<div id="title_login">
		<a href="../main.do">
			<img id="img_btn_home" src="${ pageContext.request.contextPath }/resources/image/logo.png" alt="알고싶지캠핑?">
		</a>
	</div>
	
	<div id="subject_login">
		<form class="form-horizontal" action="/action_page.php">
			<!-- 읽던 페이지 url 정보 읽어오기 -->
			<input type="hidden"  name="url"  value="${ param.url }">  
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
			
		    <div class="form-group" id="btn_group_login">
		    	<div class="col-sm-offset-2 col-sm-10" style="margin-right: 60px; float: right;">
 					
 					<input type="checkbox" id="idSaveCheck"><label>&nbsp;아이디 저장</label>
		    		<button type="button" id="btn_login" class="btn btn-default" onclick="send(this.form);">로그인</button>
		    		<button type="button" id="btn_join_form" class="btn btn-default" onclick="location.href='insert_form.do'">회원가입</button>
		    		
		    	</div>
		    </div>
    	</form>
    </div>
</div>
