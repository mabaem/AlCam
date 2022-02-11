<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script>

	//리스트의 값을 rplace_insert_form의 캠핑장명, 주소로 반환
	function send(p_name, p_addr){
		
	    console.log(p_name);
	    console.log(p_addr);
	    
	    //팝업창을 띄운 부모에게 값 전달
	    window.opener.document.getElementById("p_name").value = p_name;
	    window.opener.document.getElementById("p_addr").value = p_addr;
	    
	    window.close();
	}

</script>

<style type="text/css">
	#tb_popup_result{
		border: 1px;
	}
	#tb_popup_result > th{
		text-align: center;
	}
</style>



<div>
	<!-- 데이터가 없는 경우 -->
    <c:if test="${ empty list }">
        <tr>
           <td colspan="5" align="center">
              <font color="red">해당하는 결과가 없습니다.</font>
           </td>
        </tr>
    </c:if>

	<!-- 데이터가 있는 경우 -->
    <c:if test="${ not empty list }">
		<table id="tb_popup_result">
				<tr style="font-size: 15px;">
					<th style="width: 30%;">이름</th>
					<th style="width: 55%;">주소</th>
					<th style="width: 15%;">장소선택</th>
				</tr>
				<c:forEach var="vo" items="${list}">
					<tr>
						<td id="p_name">${vo.p_name} </td>
						<td id="p_addr">${vo.p_addr}</td>
						<td>
							<input type="button" class="btn btn-default" id="btn_select_popup_list" value="선택"
								onclick="send('${vo.p_name}','${vo.p_addr}')">
						</td>					
					</tr>
				</c:forEach>
		</table>
	</c:if>
</div>