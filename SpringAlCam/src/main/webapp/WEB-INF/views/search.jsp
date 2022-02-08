<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
function find() {
	
	var text_search = $("#text_search").val().trim();
	console.log(text_search);
	if(text_search==''){
		alert('검색어를 입력하세요');
		  $("#text_search").val("");
		  $("#text_search").focus();
		return;
	}
	location.href="camping/search.do?text_search=" + encodeURIComponent(text_search);
	
}

</script>
</head>
<body>

<!-- 키워드검색 -->
<div id="search_box">
	<div class="input-group" id="input_box">
		<input type="text" id="text_search" placeholder="캠핑장소 검색">
		<input type="button" id="btn_search" class="btn btn-success" onclick="find()" value="검색">
	</div>
</div>


</body>
</html>