<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- 다음 우편번호 검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">

	#box{
		width: 800px;
		margin: auto;
		margin-top: 50px;
	}

</style>

<script type="text/javascript">

	//이름 정규식
	var regular_m_name  = /^[가-힣]+$/;
	
	//아이디 정규식
	var regular_m_id    = /^[A-Za-z]{1}[A-Za-z0-9]{2,}$/;
	
	//비밀번호 정규식
	var regular_m_pwd   = /^(?=.*\d)(?=.*[a-zA-ZS]).{6,12}$/;
	
	//휴대전화 정규식
	var regular_m_tel   = /^01([0|1|6|7|8|9])?([0-9]{3,4})?([0-9]{4})$/;
	
	//이메일 정규식
	var regular_m_email = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

	$(document).ready(function(){
		
		//아이디 중복체크
		$("#m_id").keyup(function(event){
			
			var m_id = $(this).val();
			
			if(regular_m_id.test(m_id)==false){
				$("#m_id_message").html("아이디는 3자리 이상 영문자/숫자조합 이어야 합니다").css("color", "red");
				return;
			}

			$.ajax({
				url      : 'check_id.do',
				data     : {'m_id' : m_id },
				dataType : 'json',
				success  : function(result_data){
					
					if(result_data.result){
						//사용가능한 경우
						$("#m_id_message").html("사용가능한 아이디 입니다").css("color", "blue");
						//유효성 체크
						$("#m_id_ck").val("true");

					}else{
						//사용불가능한 경우
						$("#m_id_message").html("이미 사용중인 아이디 입니다").css("color", "red");
						//유효성 체크
						$("#m_id_ck").val("false");
					}

				},
				error    : function(err){
					alret(err.responseText);
				} 
				
			});//end-ajax
		});//end-m_id
		
		
		//비밀번호 정규식 조건 안내
		$("#m_pwd").keyup(function(event){
			
			var m_pwd = $(this).val();
			
			if(regular_m_pwd.test(m_pwd)==false){
				$("#m_pwd_message").html("비밀번호는 6~12자리 이내 영문자/숫자 모두 포함한 조합 이어야 합니다").css("color", "red");
				return;
			}else{
				$("#m_pwd_message").html("사용가능한 비밀번호 입니다").css("color", "blue");
				return;
			}
			
		});
		
		
		//비밀번호 중복체크
		$("#m_pwd2").blur(function(){
			if($("#m_pwd2").val() == $("#m_pwd").val()){
				$(".m_pwd_message").text("비밀번호가 일치합니다.");
				$(".m_pwd_message").css("color", "green");
				//유효성 체크
				$("#m_pwd_ck").val("true");
			}else{
				$(".m_pwd_message").text("비밀번호가 일치하지 않습니다.");
				$(".m_pwd_message").css("color", "red");
				//유효성 체크
				$("#m_pwd_ck").val("false");
			}
		});
		
				
		//이메일 인증	
		var code = "";
		$("#m_email_bt").click(function(){
			
			var m_email = $("#m_email").val();		
			
			//이메일 정규식체크
			if(regular_m_email.test(m_email)==false){
				
				alert('이메일 형식에 맞지 않습니다');
				$("#m_email").val('');
				$("#m_email").focus();

				return;
			} 
			
			//이메일 인증번호 전송요청
			$.ajax({
		        type     : "GET",
		        url      : "check_email.do",
		        data     : {"m_email":m_email},
		        cache    : false,
		        success  : function(data){
		        	if(data=="fail"){
		        		
		        		alert("이메일 주소가 올바르지 않습니다 유효한 이메일 주소를 입력해주세요");
  
						$("#m_email").attr("autofocus",true);
						$(".m_email_message").text("유효한 이메일 주소를 입력해주세요.");
						$(".m_email_message").css("color","red");
		        	}else{	  
		        		
						alert("인증번호 발송이 완료되었습니다\n입력한 이메일에서 인증번호 확인을 하세요");
						  
		        		$("#m_email2").attr("disabled",false);
		        		$("#m_email_bt2").css("display","inline-block");
		        		$(".m_email_message").text("인증번호를 입력한 뒤 이메일 인증을 눌러주십시오.");
		        		$(".m_email_message").css("color","green");
		        		code = data;
		        	}
		        },
		        error   : function(err){
		        	alert(err.responaseText);
		        }	
		        
		    });//end-ajax
		});//end-email
	
		
		//이메일 인증번호 대조
		$("#m_email_bt2").click(function(){
			if($("#m_email2").val() == code){
				$(".m_email_message").text("인증번호가 일치합니다.");
				$(".m_email_message").css("color","green");
				$("#m_email_ck").val("true");
				$("#m_email2").attr("disabled",true);
			}else{
				$(".m_email_message").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
				$(".m_email_message").css("color","red");
				$("#m_email_ck").val("false");
				$("#m_email2").attr("autofocus",true);
				
			}
		});
		
		
	});

	
	//회원가입버튼 클릭 시
	function send(f) {
		//입력값 체크
		var m_name     = f.m_name.value.trim();
		var m_id       = f.m_id.value.trim();
		var m_pwd      = f.m_pwd.value.trim();
		var m_byear    = $("#m_byear option:selected").val();
		var m_bmonth   = $("#m_bmonth option:selected").val();
		var m_bday     = $("#m_bday option:selected").val();
		var m_gender   = f.m_gender.value;
		var m_tel      = f.m_tel.value.trim();
		var m_zipcode  = f.m_zipcode.value.trim();
		var m_addr     = f.m_addr.value.trim();
		var photo      = f.photo.value;
		
		
		//유효성 체크
		if(m_name==''){
			
			alert('이름을 입력하세요');
			f.m_name.value='';
			f.m_name.focus();
			
			return;
		}
		
		//이름 정규식체크
		if(regular_m_name.test(m_name)==false){
			
			alert('이름 형식에 맞지 않습니다');
			f.m_name.value='';
			f.m_name.focus();
	  
			return;
		} 
		
		if(m_id==''){
			
			alert('아이디를 입력하세요');
			f.m_id.value='';
			f.m_id.focus();
			
			return;
		}
		
		//아이디 정규식체크
		if(regular_m_id.test(m_id)==false){
			
			alert('아이디는 3자리 이상 영문자/숫자조합 이어야 합니다');
			f.m_id.focus();

			return;
    	}
		
		//아이디 중복체크
		if($("#m_id_ck").val()!="true"){
			
			alert('이미 사용 중인 아이디 입니다');
			f.m_id.focus();

			return;
    	}
		
		if(m_pwd==''){
			
			alert('비밀번호를 입력하세요');
			f.m_pwd.value='';
			f.m_pwd.focus();
				
			return;
		}
		
		//비밀번호 정규식체크
		if(regular_m_pwd.test(m_pwd)==false){
			
			alert('비밀번호는 숫자/영문자 모두 포함하여 6~12자리 이내로 입력하세요');
			f.m_pwd.value='';
			f.m_pwd.focus();
				  
			return;
		}
		
		//비밀번호 확인란
		if($("#m_pwd2").val()==''){
			alert('비밀번호를 동일하게 입력하세요');
			$("#m_pwd2").val('');
			$("#m_pwd2").focus();
			
			return;
		}

		//비밀번호 일치여부 확인
		if($("#m_pwd_ck").val()!="true"){
			alert('비밀번호가 일치하지 않습니다');
			$("#m_pwd2").val('');
			$("#m_pwd2").focus();
			
			return;
	    }
			
		if(m_byear=='출생년도'){
			alert('출생년도를 선택하세요');
				
			return;
		}
		
		if(m_bmonth=='출생월'){
			alert('출생월을 선택하세요');
				
			return;
		}
						
		if(m_bday=='출생일'){
			alert('출생일을 선택하세요');
				
			return;
		}
		
		if(m_tel==''){
			alert('전화번호를 입력하세요');
			f.m_tel.value='';
			f.m_tel.focus();

			return;
		}
		
		//전화번호 정규식체크
		if(regular_m_tel.test(m_tel)==false){
			alert('전화번호 형식에 맞지 않습니다');
			f.m_tel.value='';
			f.m_tel.focus();
  
			return;
		} 
		
		if($("#m_email").val()==""){
			alert('이메일을 입력하세요');
			$("#m_email").val('');
			$("#m_email").focus();
			
			return;
    	}

		if($("#m_email_ck").val()!="true"){
			alert('이메일 인증을 완료해주세요');
			$("#m_email2").focus();
			
			return;
    	}
				
		if(m_zipcode==''){
			alert('우편번호를 입력하세요');
			f.m_zipcode.value='';
			f.m_zipcode.focus();
				
			return;
		}
		
		if(m_addr==''){
			alert('주소를 입력하세요');
			f.m_addr.value='';
			f.m_addr.focus();
	  
			return;
		}
				
		f.action="insert.do?m_byear=" + m_byear + "&m_bmonth=" + m_bmonth + "&m_bday=" + m_bday;  
		f.submit();
	}

	//주소찾기 함수
	function find_addr() {
		
		var width = 500;  //팝업의 너비
		var height = 600; //팝업의 높이
		
        new daum.Postcode({
        	 width: width,
        	 height: height,
             oncomplete: function(data) {
                $("#m_zipcode").val(data.zonecode);
                $("#m_addr").val(data.address);
            }
        }).open({
        	//화면정중앙에 위치
        	left: (window.screen.width / 2) - (width / 2),
            top: (window.screen.height / 2) - (height / 2)
        	
        });
    }

</script>

<div id="box">   
<form name="f" method="POST" action="insert.do" enctype="multipart/form-data">
	<h3>회원가입</h3>
	<table class="table table-striped">
		<tr>
			<th>이름</th>
			<td><input name="m_name"></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>
				<input name="m_id" id="m_id">
				<span id="m_id_message"></span>
				<input type="hidden" id="m_id_ck"/>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<input id="m_pwd" name="m_pwd" type="password">
				<span id="m_pwd_message"></span>
			</td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td>
				<input id="m_pwd2" name="m_pwd2" type="password" placeholder="동일하게 입력하세요.">
				<span class="point m_pwd_message"></span>
				<input type="hidden" id="m_pwd_ck"/>
			</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				<!-- 출생년 -->
				<c:set var="today" value="<%=new java.util.Date()%>" />
				<c:set var="year"><fmt:formatDate value="${today}" pattern="yyyy" /></c:set> 
				<select id="m_byear">
					<c:set var="valueText" value="${year}"/>
					<option value="출생년도">출생년도</option>
					<c:forEach var="i" begin="1945" end="${year}" step="1">
						<option value="${valueText}">${valueText}</option>
						<c:set var="valueText" value="${valueText-1}"/>
					</c:forEach>
				</select>
				
				<!-- 출생월 -->
				<select id="m_bmonth">
					<option value="출생월">출생월</option>
					<c:forEach var="i" begin="1" end="12" step="1">
						<option value="${i}">${i}</option>
					</c:forEach>
				</select>
				
				<!-- 출생일 -->
				<select id="m_bday">
					<option value="출생일">출생일</option>
					<c:forEach var="i" begin="1" end="31" step="1">
						<option value="${i}">${i}</option>
					</c:forEach>
				</select> 
			</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>
				남자 <input type="radio" name="m_gender" value="남자" checked="checked">
				여자 <input type="radio" name="m_gender" value="여자">
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text" name="m_tel" placeholder="숫자만 입력하세요"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<!-- 이메일 전송 -->
				<input id="m_email"     type="text"   name="m_email">
				<input id="m_email_bt"  type="button" class="doubleChk" value="인증번호 보내기"><br>
				<!-- 인증번호 확인 -->
				<input id="m_email2"    type="text"   name="m_email2"   title="인증번호 입력" disabled required/>
				<input id="m_email_bt2" type="button" class="doubleChk" value="이메일인증">
				<span class="point m_email_message">이메일 입력후 인증번호 보내기를 하세요.</span>
				<input type="hidden" id="m_email_ck"/>
			</td>
		</tr>
		<tr>
			<th>프로필사진</th>
			<td><input type="file" name="photo"></td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td>
				<input name="m_zipcode" type="text" id="m_zipcode" placeholder="우편번호">
				<input class="btn btn-success" type="button" value="주소찾기" onclick="find_addr();">
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input name="m_addr" type="text" size="70" id="m_addr" placeholder="주소"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input class="btn btn-primary" type="button" value="회원가입"
				       onclick="send(this.form);">
		        <input class="btn btn-success" type="button" value="메인보기" 
				       onclick="location.href='${ pageContext.request.contextPath }'">
			</td>
		</tr>
	</table>
</form>
</div>
