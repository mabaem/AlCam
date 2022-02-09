<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style type="text/css">
	#div_goods_table{
		width: 100%;
	}
	img{
		width: 120px;
		height: 80px;
	}
</style>

</head>
<body>

	
	<fmt:setLocale value="ko"/>
	<div id = "div_goods_table">
		<table class = "table table-striped table-hover">
			<!-- title -->
			<tr>
				<th>이미지</th>
				<th>상품명</th>
				<th>가격</th>
			</tr>
			
			<!-- data -->
			<!-- for(ProductVo vo : list) -->
			
			<c:forEach var="vo" items = "${list}">
				<tr>
					<td><img src = ${vo.g_filename }></td>
					<td><a href = "${vo.g_link }" target = "_blank">${ vo.g_name}</a></td>
					<td><fmt:formatNumber   value = "${vo.g_price }"/>(원)</td>
				</tr>
			</c:forEach>
			<tr>
                <td colspan="3" align="center">
                    
                  <div id="page_menu"> 
                     ${ pageMenu }
                    </div>            
                </td>
             </tr>		
		</table>
	</div>
</body>
</html>