<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">
		
		function bmkgoods_insert(f){
			
			//로그인 안된상태 체크
			if("${empty user}" == "true"){
				
				if(confirm("즐겨찾기 등록은 로그인 후에 이용가능합니다\n로그인하시겠습니까?")==false)return;
				
				//로그인폼으로 이동: 현재 위치를 넘겨주고 
				//현재주소위치: location.href
				// xxx 로그인 후 원위치로 이동 안됨 xxx
				location.href="member/login_form.do?url="+encodeURIComponent(location.href);
				return;				
			}
			
			var g_idx = f.g_idx.value;
			//alert(g_idx);
			
			
			//로그인이 된 경우 ajax를 이용해서 장바구니 담기 처리
			$.ajax({
				url       :"${ pageContext.request.contextPath }/member/bmkgoods_insert.do",	
				data      :{"g_idx":g_idx, "m_idx":"${user.m_idx}"},
				dataType  :"json",
				success   : function(result_data){
					
					// result_data = {"result" : "success"} //장바구니 담기 성공시 
					// result_data = {"result" : "exist"} //장바구니에 이미 담겨있는 경우
					
					if(result_data.result == "success"){
						if(confirm("해당 상품을 즐겨찾기에 등록하였습니다\n즐겨찾기로 이동하시겠습니까?")==false)return;
						
						location.href="main.do?menu=member&submenu=bookmark_goods";
						return;
					}
					
					if(result_data.result == "exist"){
						alert("해당상품이 이미 즐겨찾기에 등록되어 있습니다");
					}
				},
				error     : function(err){
					alert(err.responseText);
				}	
			}); 
			
		}

</script>


<style type="text/css">
	#div_goods_table{
		width: 100%;
	}
	img{
		width: 120px;
		height: 80px;
	}
</style>


	
	<fmt:setLocale value="ko"/>
	<div id = "div_goods_table">
		<table class = "table table-striped table-hover">
			<!-- title -->
			<tr>
				<th>이미지</th>
				<th>상품명</th>
				<th>가격</th>
				<th>즐겨찾기</th>
			</tr>
			
			<!-- data -->
			<!-- for(CampProductVo vo : list) -->
			
			<c:forEach var="vo" items = "${list}">
			
					
					<input type="hidden" value="${vo.g_category }">
				<tr>
					<td><img src = ${vo.g_image }></td>
					<td><a href = "${vo.g_link }" target = "_blank">${ vo.g_name}</a></td>
					<td><fmt:formatNumber   value = "${vo.g_price }"/>(원)</td>
					<td>
						<form>
						<input type="hidden" id="g_idx" value="${vo.g_idx }">
						<input type="button" value="등록" onclick="bmkgoods_insert(this.form);">
						</form>	
					</td>
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