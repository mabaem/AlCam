<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	#place_box{
	margin: auto;
		width: 100%;
		height: 70%;
	}
	#p_input_box{
		margin:  auto;
		text-align: center;
		padding: 20px;
	}
	#text_search{
		width: 300px;
		height: 40px;
	}
	#p_btn_search{
		width: 70px;
		height: 40px;
		margin-left: 5px;
		
	}


</style>
<script type="text/javascript">
	var global_page = 1;
	var menu = "${param.menu}";
	$(document).ready(function(){
		$("#p_btn_search").click(function() {
			var text_search = $("#text_search").val();

			if(text_search==''){
				alert('검색어를 입력하세요');
				  $("#text_search").val("");
				  $("#text_search").focus();
				return;			
			}
			
			if(menu!='place'){
				
				//a();
				
				hide();
				search_place(text_search,1);
				//location_change();
				
				//location.href="${ pageContext.request.contextPath }/main.do?menu=place&text_search="+text_search;
				//location.href="${ pageContext.request.contextPath }/main.do?menu=place";
				
				
			} 
			console.log(menu);
			search_place(text_search,1);
			
		});
	}); //end-ready
	
	function hide(){
		
		document.getElementById("notice").style.display = "none";
		document.getElementById("best").style.display = "none";
		
	}
	
/* 	function a(){
		
		alert('테스트');
		
	}
	
	function location_change(){
		
		return "${ pageContext.request.contextPath }/main.do?menu=place&text_search="+text_search;
	} */
	
	function search_place(text_search,page) {
	
	global_page = page;
	//page = "${param.page}";
	$.ajax({
		url			: "place/search.do",
		data		:{"text_search":text_search,"page":page},
		success		: function(result_data) {
			$("#disp").html(result_data);
		},
		error		:function(err){
			alert(err.responseText);
		}
	});
	//location.href="${ pageContext.request.contextPath }/place/search.do?text_search=" + encodeURIComponent(text_search);
	
}

</script>

<div id="place_box">

	<!-- 장소리스트 -->

		<!-- 검색 -->
		<div id="p_search_box">
			<div class="input-group" id="p_input_box">
				<input type="text" id="text_search" placeholder="캠핑장소 검색" value="${param.text_search }">
				<input type="button" id="p_btn_search" class="btn btn-success"value="검색">
			</div>
		</div>
		
		<!-- 장소리스트 출력 -->

		<div id="disp">
			<!-- 키워드, 주소, 장소명 등으로 캠핑장소 검색 -->

		</div>


</div>
