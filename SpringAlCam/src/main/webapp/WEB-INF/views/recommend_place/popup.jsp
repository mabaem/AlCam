<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

  $(document).ready(function(){
	  	$("#search_btn_rplace").click(function() {
	  			
			var search_text_rplace = $("#search_text_rplace").val();
			
			search_place(search_text_rplace);
			
	  	});
  }); //end ready


  function search_place(search_text_rplace) {
	  	
	  	$.ajax({
			url			: "recommend_place/keyword_search.do",
			data		:{ "search_text_rplace" : search_text_rplace },
			success		: function(result_data) {
								$("#disp").html(result_data);
						  },
			error		: function(err){
								alert(err.responseText);
						  }
		});
		
  }//end search_place()

</script>


</head>
<body>

	<input type="text" id="search_text_rplace" placeholder="키워드를 입력하세요" value="${param.search_text_rplace }">
	<input type="button" id="search_btn_rplace" class="btn " value="장소검색">
	
	<div id="disp">
	
	</div>
	
</body>
</html>