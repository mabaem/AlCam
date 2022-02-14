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
<script type="text/javascript">
function bmkplace_insert(f){
	
	//로그인 안된상태 체크
	if("${empty user}" == "true"){
		
		if(confirm("즐겨찾기 등록은 로그인 후에 이용가능합니다\n로그인하시겠습니까?")==false)return;
		
		//로그인폼으로 이동: 현재 위치를 넘겨주고 
		//현재주소위치: location.href
		// xxx 로그인 후 원위치로 이동 안됨 xxx
		location.href="member/login_form.do?url="+encodeURIComponent(location.href);
		return;				
	}
	
	var p_idx = f.p_idx.value;
	console.log(p_idx);
	
	//로그인이 된 경우 ajax를 이용해서 장바구니 담기 처리
	$.ajax({
		url       :"${ pageContext.request.contextPath }/member/bmkplace_insert.do",	
		data      :{"p_idx":p_idx, "m_idx":"${user.m_idx}"},
		dataType  :"json",
		success   : function(result_data){
			
			// result_data = {"result" : "success"} //장바구니 담기 성공시 
			// result_data = {"result" : "exist"} //장바구니에 이미 담겨있는 경우
			
			if(result_data.result == "success"){
				if(confirm("캠핑장을 즐겨찾기에 등록하였습니다\n즐겨찾기로 이동하시겠습니까?")==false)return;
				
				location.href="main.do?menu=member&submenu=bookmark_place";
				return;
			}
			
			if(result_data.result == "exist"){
				alert("캠핑장이 이미 즐겨찾기에 등록되어 있습니다");
			}
		},
		error     : function(err){
			alert(err.responseText);
		}	
	}); 
	
}

</script>
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
						<img src="${vo.p_filename }" onError="this.src='${ pageContext.request.contextPath }/resources/image/default_img.png'">
						</c:if>
						</td>
				
						<td>${vo.p_name} </td>
						<td>${vo.p_addr}</td>
						<td>${vo.p_tel}</td>
						<td>
						<div>
						<form>
						<input type="hidden" id="p_idx" value="${vo.p_idx }">
						<input type="button" id="bmkinsert_btn" value="장소담기" onclick="bmkplace_insert(this.form)">
						</form>
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