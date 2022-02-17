<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<style type="text/css">
	
	#div_notice_recent{
		
	}
	
	#tb_notice_recent{
		width: 100%;
		border: 1px solid #dde6ff;
	}
	#tb_notice_recent > th{
	}
	
	#tb_notice_recent > tr:hover{
		font-weight: bold;
	}
	
		
</style>

	<div id="div_notice_recent">
	
		<div class="panel panel-success">
  	      	<h3 style="margin-left: 10px; color: #3367ff;">[최신공지사항]</h3>
  	      
	  	      <div class="panel-body">
	  	      		<table id="tb_notice_recent">
	  	      			
	  	      			
	  	      			<!-- 데이터가 없는경우 -->
	  	      			<c:if test="${ empty list }">
	  	      				<tr>
			                    <td colspan="3" align="center">
			                       <font color="black">작성된 공지사항이 없습니다</font>
			                    </td>
			                 </tr>
	  	      			</c:if>
	  	      			
	  	      			<!-- 데이터가 있는 경우 -->
			            <c:if test="${ not empty list}">
			            	
			            	<tr style="text-align: center; font-size: 16px;">
		  	      				<th width="60%">제목</th>
		  	      				<th width="20%">작성자</th>
		  	      				<th width="20%">작성일자</th>
	  	      				</tr>
			            	
			            	<td style="font-size: 22px;">&nbsp;</td>
		  	      			<c:forEach var="vo" items="${ list }">
		  	      				<tr style = "cursor:pointer;"onclick="window.parent.location.href='${ pageContext.request.contextPath }/main.do?menu=notice&n_idx=${ vo.n_idx }&page=${ empty param.page ? 1 : param.page }'"
		  	      					onmouseover="this.style.color='#0035d1'" onmouseout="this.style.color='black'">
		  	      					<td>
		  	      						<c:choose>
									        <c:when test="${fn:length(vo.n_subject) > 16}">
										        <c:out value="${fn:substring(vo.n_subject, 0, 15)}"/>...
										    </c:when>
										    <c:otherwise>
											    <c:out value="${vo.n_subject}">
											    </c:out>
										    </c:otherwise>
										</c:choose>
		  	      					</td>
		  	      					<td>${ vo.m_name }</td>
		  	      					<td style="text-align: center; color: #0035d1;">
		  	      						
		  	      						<c:set var="n_regdate" value="${ vo.n_regdate }"/>
		  	      						${ fn:substring(n_regdate, 0, 11) }
		  	
		  	      					</td>
		  	      				</tr>
		  	      			</c:forEach>
		  	      			<td style="font-size: 10px;">&nbsp;</td>
	  	      			</c:if>
	  	      		</table>
	  	      		
				</div>
		</div>
	</div>
