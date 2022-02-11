<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	#input_box{
		margin: 0 auto;
		text-align: center;
		padding: 20px;
	}
	#text_search{
		width: 300px;
		height: 40px;
	}
	#btn_search{
		width: 70px;
		height: 40px;
		margin-left: 5px;
		
	}
</style>
<script type="text/javascript">
var global_page = 1;

$(document).ready(function(){
	
	$("#btn_search").click(function() {
		var text_search = $("#text_search").val();

		if(text_search==''){
			alert('검색어를 입력하세요');
			  $("#text_search").val("");
			  $("#text_search").focus();
			return;
		}			
		search_place(text_search,1);
		
	});
}); //end-ready

function search_place(text_search,page) {

global_page = page;

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

}

</script>

<!-- 키워드검색 -->
<div id="search_box">
	<div class="input-group" id="input_box">
		<input type="text" id="text_search" placeholder="캠핑장소 검색" value="${param.text_search }">
		<input type="button" id="btn_search" class="btn btn-success" value="검색">
	</div>
</div>
<div id="disp"></div>
