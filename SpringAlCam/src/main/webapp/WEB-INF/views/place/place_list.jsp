<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	#place_box{
	margin: auto;
		width: 100%;
		height: 70%;
	}
	#div_place_list{
		margin: auto;
		width: 100%;
		height: 70%;
	}
	#p_input_box{
		margin:  auto;
		text-align: center;
		padding: 20px;
	}
	#p_text_search{
		width: 300px;
		height: 40px;
	}
	#p_btn_search{
		width: 70px;
		height: 40px;
		margin-left: 5px;
		
	}
	#camping_photo > img{
	width: 500px;
	height: 200px;
}
</style>
<script type="text/javascript">
	var global_page = 1;
	$(document).ready(function(){
		$("#p_btn_search").click(function() {
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
</head>
<body>
<div id="place_box">

	<!-- 장소리스트 -->
	<div id="div_place_list">
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
			<%-- <%@ include file="camping_list.jsp" %> --%>
			
			<%-- <table>
			<tr>
				<th>대표사진</th>
				<th>장소</th>
				<th>주소</th>
				<th>전화번호</th>
				<th>즐겨찾기</th>
			</tr>
			<c:forEach var="vo" items="${list}">
					<tr>	
					 	<td id="camping_photo">	
						<c:if test="${ empty vo.p_filename }">																			
						<img src="${ pageContext.request.contextPath }/resources/image/default_img.png">
						</c:if>
						<c:if test="${ not empty vo.p_filename }">
						<img src="${vo.p_filename }">
						</c:if>
						</td>
				
						<td>${vo.p_name} </td>
						<td>${vo.p_addr}</td>
						<td>${vo.p_tel}</td>
						<td>토글버튼 위치</td>
						<td></td>
					</tr>
			</c:forEach>
			<tr>
                <td colspan="6" align="center">
                    
                  <div id="page_menu"> 
                     ${ pageMenu }
                    </div>            
                </td>
             </tr>				
		</table> --%>
		</div>
	</div>
</div>

</body>
</html>