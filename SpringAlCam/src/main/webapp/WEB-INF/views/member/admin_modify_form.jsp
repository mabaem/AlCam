<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<!DOCTYPE html>
    
<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- 다음 우편번호검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">

	#box{
		width: 750px;
		margin: auto;
		margin-top: 50px;
	}
	
</style>

<script type="text/javascript">

	//비밀번호 정규식
	var regular_m_pwd   = /^(?=.*\d)(?=.*[a-zA-ZS]).{6,12}$/;

	//휴대전화 정규식
	var regular_m_tel   = /^01([0|1|6|7|8|9])?([0-9]{3,4})?([0-9]{4})$/;
	
	//이메일 정규식
	var regular_m_email = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

	function send(f) {
		var m_idx      = f.m_idx.value;
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
		var m_email    = f.m_email.value.trim();
		var m_grade    = "일반";
		
		if(${user.m_grade=="관리자"})
			var m_grade = f.m_grade.value;
		
		if(m_name==''){
			alert('이름을 입력하세요');
			f.m_name.value='';
			f.m_name.focus();
				
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
		
		//이메일 정규식체크
		if(regular_m_email.test(m_email)==false){
			alert('이메일 형식에 맞지 않습니다');
			 $("#m_email").val('');
			 $("#m_email").focus();
				  
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
			
		f.action="admin_modify.do?m_grade=" + m_grade + "&m_byear=" + m_byear + "&m_bmonth=" + m_bmonth + "&m_bday=" + m_bday + "&page=${page}";  
		f.submit();	
	}
	
	//주소찾기 함수
	function find_addr() {
		
		var width = 500; //팝업의 너비
		var height = 600; //팝업의 높이
		
        new daum.Postcode({
        	 width: width, 
        	 height: height,
             oncomplete: function(data) {
                $("#m_zipcode").val(data.zonecode);
                $("#m_addr").val(data.address);
                

            }
        }).open({
        	left: (window.screen.width / 2) - (width / 2),
            top: (window.screen.height / 2) - (height / 2)
        	
        });
    }
	
	//jQuery초기화
	$(document).ready(function(){
		
		//회원 기존값 설정
		$("select[id='m_byear']").val('${ vo.m_byear }');
		$("select[id='m_bmonth']").val('${ vo.m_bmonth }');
		$("select[id='m_bday']").val('${ vo.m_bday }');
		$("input:radio[name='m_gender']:input[value='${ vo.m_gender }']").attr("checked", true);
		$("select[id='m_grade']").val('${ vo.m_grade }');
		
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
		
	});
	
	// 업로드 버튼 클릭 시 파일찾기창 팝업
	function ajaxFileUpload() {
	       $("#ajaxFile").click();
	}
	
	// 파일이 선택 시 업로드메소드 호출
	function ajaxFileChange() {
   		 photo_upload();
	}
	   
	// 파일 업로드
	function photo_upload() {
			  
		   //파일선택->취소 시
		   if( $("#ajaxFile")[0].files[0] == undefined ) return;

		   var form = $("ajaxForm")[0];
	       var formData = new FormData(form);
	       //파라메터 정보(폼데이터로 포장해서)
	       formData.append("m_idx", '${ vo.m_idx }');
	       formData.append("photo", $("#ajaxFile")[0].files[0]); //multiple로 속성 주게 되면,,

	       $.ajax({
	             url : "photo_upload.do", 
	             type : "POST",
	             data : formData,
	             processData : false,
	             contentType : false,
	             dataType : 'json',
	             success:function(result_data) {
	                 $("#my_img").attr("src", "${ pageContext.request.contextPath }/resources/image/" + result_data.filename);
	             },
	             error : function(err){
	            	 alert(err.responseText);
	             }
	       });

	   }
	
</script>

<!--화일업로드용 폼  -->
<form enctype="multipart/form-data" id="ajaxForm" method="post">
    <input type="file" id="ajaxFile" style="display:none;"  onChange="ajaxFileChange();">
</form>

<form name="f" method="POST" action="modify.do" enctype="multipart/form-data">
   <input type="hidden" name="m_idx"   value="${ vo.m_idx }">
   <div id='box'>
   
		<table class="table">		
			<tr>
				<td colspan="2" align="center">
					<img src="${ pageContext.request.contextPath }/resources/image/${ vo.m_filename }" id="my_img" width="200" height="200">
					<br>
					<input class="btn btn-info" type="button" value="이미지편집"  onclick="ajaxFileUpload();">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input name="m_name" value="${ vo.m_name }"></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input name="m_id" value="${ vo.m_id }" readonly="readonly"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input name="m_pwd" id="m_pwd" type="password" value="${ vo.m_pwd }">
					<span id="m_pwd_message"></span>
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
					남자 <input type="radio" name="m_gender" value="남자">
					여자 <input type="radio" name="m_gender" value="여자">
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="m_tel" value="${ vo.m_tel }" placeholder="숫자만 입력하세요"></td>
			</tr>
			
			<tr>
				<th>이메일</th>
				<td>
					<input id="m_email"     type="text"   name="m_email" value="${ vo.m_email }">
				</td>
			</tr>	
			<tr>
				<th>우편번호</th>
				<td>
					<input name="m_zipcode" type="text" id="m_zipcode" placeholder="우편번호" value="${ vo.m_zipcode }">
					<input class="btn btn-success" type="button" value="주소찾기" onclick="find_addr();">
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input name="m_addr" type="text" size="70" id="m_addr" placeholder="주소" value="${ vo.m_addr }"></td>
			</tr>
							
			<!-- 관리자로 로그인 시 회원등급 수정 -->
			<c:if test="${ user.m_grade == '관리자' }">
				<tr>
					<th>회원구분</th>
					<td>
						<select name="m_grade" id="m_grade">
							<option value="일반">일반</option>
							<option value="관리자">관리자</option>
						</select>
					</td>
				</tr>
			</c:if>
			
			<tr>
				<td colspan="2" align="center">
					
					<input class="btn btn-info" type="button" value="회원수정" 
					       onclick="send(this.form);">
				    
			        <input class="btn btn-info" type="button" value="목록보기" 
					       onclick="location.href='admin_list.do?m_idx=${vo.m_idx}&page=${param.page}'">
				</td>
			</tr>
		</table>

	</div>
</form>
