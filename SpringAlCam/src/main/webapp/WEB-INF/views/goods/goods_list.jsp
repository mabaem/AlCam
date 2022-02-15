<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">

     var global_page = 1;

	$(document).ready(function(){
		
		search_product('취사용품',1);
		
		//검색버튼이 눌리면
		$("#bt_find").click(function(){
			
			//검색어 값 가져오기
			var p_name = $("#p_name").val();
			
			//검색어 작성여부 체크..
			if(p_name==''){
				alert('조회할 상품명을 입력하세요');
				$("#p_name").val("");
				$("#p_name").focus();
				return;
			}
			
			search_product(p_name, 1);
		});
		
		 //취사용품 버튼이 눌리면 
		$("#kind").click(function(){
			
			search_product('취사용품',1);
		}); 
		 
		// 드랍다운 리스트가 눌리면 
	    $(".dropdown-menu li").click(function(){
	         
	    	 var p_name = $(this).find("a").html();
	    	 
	    	 search_product(p_name, 1);
	    	  
	    });

	});//end-document.ready
	
	//상품검색함수
	function search_product(p_name,page){
		
		global_page = page;
		
		//ajax로 요청 
		$.ajax({
			url:'goods/camp_list.do',					
			data: {"p_name":p_name,"page":page},
			success: function(result_data){
				$("#disp").html(result_data);
			},
			error:function(err){
				alert(err.responseText);
			}
			
		});
		
	}
		
</script>

<style type="text/css">
	#div_goods_box{
		margin: auto;
		/* padding: 20px; */
		font-family: '맑은 고딕';
		
	}
	#div_goods_menu{
		width: 20%;
		float: left;
		padding: 20px;
		
	}
	#div_goods_list{
		width: 80%;
		float: left;
		padding: 20px;
	}
	.dropdown:hover .dropdown-menu {
    	display: block;
    	margin-top: 0;
	}
	
	button{
		width: 100%;
	}
	a{
		color: black;
		text-decoration : none;
	}
	a:hover{
		color: black;
		text-decoration : none;
	}
</style>

<div id="div_goods_box">
	<div id="div_goods_menu" >
		<label style="font-size: 20px; margin-bottom: 20px;">캠핑용품검색</label>
		
		<button class="btn btn-default" type="button" id="kind" value="취사용품">
		  	취사용품
		</button>
		  
	    <div class="dropdown">
		  <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
		  	텐트, 침낭
		  <span class="caret"></span></button>
			  <ul class="dropdown-menu">
			    <li><a href="#">텐트</a></li>
			    <li><a href="#">침낭</a></li>
			    <li><a href="#">타프</a></li>
			    <li><a href="#">천막</a></li>
			    <li><a href="#">캠핑매트</a></li>
			    <li><a href="#">캠핑왜건</a></li>
			  </ul>
		</div>
		
		<div class="dropdown">
		  <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
		  	소품
		  <span class="caret"></span></button>
			  <ul class="dropdown-menu">
			    <li><a href="#">랜턴</a></li>
			    <li><a href="#">텐트/타프용품</a></li>
			    <li><a href="#">캠핑가구</a></li>
			    <li><a href="#">아이스박스</a></li>
			    <li><a href="#">감성캠핑용품</a></li>
			    <li><a href="#">차박용품</a></li>
			  </ul>
		</div>
		
		<div class="dropdown">
		  <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
		  	기타
		  <span class="caret"></span></button>
			  <ul class="dropdown-menu">
			    <li><a href="#">캠핑푸드</a></li>
			    <li><a href="#">게임/스마트기기</a></li>
			    <li><a href="#">캠핑계절가전</a></li>
			    <li><a href="#">동계캠핑필수템</a></li>
			    <li><a href="#">기타캠핑용품</a></li>
			    <li class="divider"/>
			    <li><a href="#">캠핑장예약</a></li>
			  </ul>
		  </div>
	</div>
	
	
	
	
	<!-- 캠핑용품 -->
	<div id="div_goods_list">
		<!-- 검색 -->
		<div>
			<input id= "p_name" type="text" placeholder="캠핑용품 검색" style="width: 300px; height: 40px;">
			<input id="bt_find" type="button" class="btn btn-default" value="검색" style="width: 70px; height: 40px;">
		</div>
			※상품 클릭 시 네이버쇼핑으로 연결됩니다. 
					
						<!-- 로그인 된 상태에서만  -->
						<c:if test="${not empty user }">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="즐겨찾기 이동" 
						onclick="location.href='main.do?menu=member&submenu=bookmark_goods'">
						</c:if>
		<hr>
		<div id="disp">
		</div>
	</div>
</div>