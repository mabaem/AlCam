<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<style type="text/css">
	
	#div_notice_recent{
	
	}
	
	#tb_notice_recent{
		padding: 10px;
	}
	#tb_notice_recent > th{
		font-size: 18px;
	}
	
	#tb_notice_recent > tr:hover{
		font-weight: bold;
	}
	
		
</style>

	<div id="div_notice_recent">
	
		<div class="panel panel-success">
  	      	<h3 style="margin-left: 10px;">[최신공지사항]</h3>
  	      
	  	      <div class="panel-body">
	  	      		<table id="tb_notice_recent">
	  	      			<tr style="text-align: left;">
	  	      				<th width="60%">제목</th>
	  	      				<th width="20%">작성자</th>
	  	      				<th width="20%">작성일자</th>
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
		  	      				<tr style = "cursor:pointer;"onclick="window.parent.location.href='${ pageContext.request.contextPath }/main.do?menu=notice&n_idx=${ vo.n_idx }&page=${ empty param.page ? 1 : param.page }'"
		  	      					onmouseover="this.style.color='#0035d1'" onmouseout="this.style.color='black'">
		  	      					<td>${ vo.n_subject }</td>
		  	      					<td>${ vo.m_name }</td>
		  	      					<td style="text-align: center; color: #0035d1;">
		  	      						
		  	      						<c:set var="n_regdate" value="${ vo.n_regdate }"/>
		  	      						${ fn:substring(n_regdate, 0, 11) }
		  	
		  	      					</td>
		  	      				</tr>
		  	      			</c:forEach>
	  	      			</c:if>
	  	      		</table>
	  	      		
				</div>
		</div>
	</div>
