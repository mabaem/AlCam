<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<style type="text/css">
	
	#div_rplace_best{
	
	}
	
	#tb_rplace_best{
		padding: 10px;
	}
	#tb_rplace_best > th{
		font-size: 18px;
	}
	
	#tb_rplace_best > tr:hover{
		font-weight: bold;
	}
	
		
</style>

	<div id="div_rplace_best">
	
		<div class="panel panel-success">
  	      	<h3 style="margin-left: 10px;">[인기글]</h3>
  	      
	  	      <div class="panel-body">
	  	      		<table id="tb_rplace_best">
	  	      			<tr style="text-align: left;">
	  	      				<th width="65%">제목</th>
	  	      				<th width="20%">작성자</th>
	  	      				<th width="15%" style="color: #23a51d;">조회수</th>
	  	      			</tr>
	  	      			
	  	      			<!-- 데이터가 없는경우 -->
	  	      			<c:if test="${ empty list }">
	  	      				<tr>
			                    <td colspan="5" align="center">
			                       <font color="black">작성된 게시글이 없습니다</font>
			                    </td>
			                 </tr>
	  	      			</c:if>
	  	      			
	  	      			<!-- 데이터가 있는 경우 -->
			            <c:if test="${ not empty list}">
		  	      			<c:forEach var="vo" items="${ list }">
		  	      				<tr style = "cursor:pointer;" onclick="window.parent.location.href='${ pageContext.request.contextPath }/main.do?menu=recommend_place&idx=${ vo.idx }&page=${ empty param.page ? 1 : param.page }'"
		  	      					onmouseover="this.style.color='#23a51d'" onmouseout="this.style.color='black'">
		  	      					<td>${ vo.subject }</td>
		  	      					<td>${ vo.m_name }</td>
		  	      					<td style="text-align: center; color: #23a51d;">${ vo.readhit }</td>
		  	      				</tr>
		  	      			</c:forEach>
	  	      			</c:if>
	  	      		</table>
	  	      		
				</div>
		</div>
	</div>
