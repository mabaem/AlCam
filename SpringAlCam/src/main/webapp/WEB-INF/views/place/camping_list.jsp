<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style type="text/css">

#camping_photo > img{
	width: 120px;
	height: 92px;
}


</style>

<div>
		<table>
		<c:if test="${empty list }">
			검색된 캠핑장이 없습니다.
		</c:if>
		<c:if test="${not empty list }">
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
						<td>
						<div>
						<input type="checkbox" id="toggleBtn">
							 <label for="toggleBtn" class="toggleBtn">장소 담기</label>
							 <div class="box1"></div>
						</div>
						</td>
					</tr>
			</c:forEach>
			<tr>
                <td colspan="6" align="center">
                    
                  <div id="page_menu"> 
                     ${ pageMenu }
                    </div>            
                </td>
             </tr>
           </c:if>  				
		</table>
</div>			