<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<script type="text/javascript">
  
  //검색버튼 눌리면 search_place()함수 호출
  $(document).ready(function(){
	  	$("#search_btn_rplace").click(function() {
	  			
			var search_text_rplace = $("#search_text_rplace").val();
			
			if(search_text_rplace == ""){
				console.log("empty");
			}
			console.log(search_text_rplace);
			
			search_place(search_text_rplace);
			
	  	});
  }); //end ready

  //검색어를 keyword_search.do에 요청하여 결과값 반환
  function search_place(search_text_rplace) {
	  	
	  	$.ajax({
			url			: "keyword_search.do",
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



	<input type="text" id="search_text_rplace" placeholder="키워드를 입력하세요" value="${param.search_text_rplace }">
	<input type="button" id="search_btn_rplace" class="btn " value="장소검색">
	
	<div id="disp">
	
	</div>
