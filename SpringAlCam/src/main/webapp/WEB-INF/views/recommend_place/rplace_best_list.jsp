<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>

<style type="text/css">
	
	#div_rplace_best{
		text-align: left;
	}
	
	.word{
	}
	
	#tb_rplace_best{
		
		width: 100%;
		border: 1px solid #dde6ff;
	}
	#tb_rplace_best > th{
		text-align: left;
	}
	
	#tb_rplace_best > tr:hover{
		font-weight: bold;
	}
	
		
</style>

	<div id="div_rplace_best">
	
		<div class="panel panel-success">
  	      	<h3 style="margin-left: 10px; color: #3367ff;">[인기글]</h3>
  	      
	  	      <div class="panel-body">
	  	      		<table id="tb_rplace_best">
	  	      		
	  	      			<c:if test="${ empty list }">
	  	      				<tr>
			                    <td colspan="6" rowspan="8" align="center">
			                       <font color="black">작성된 게시글이 없습니다</font>
			                    </td>
			                 </tr>
	  	      			</c:if>
	  	      			
	  	      			
	  	      			<!-- 데이터가 있는 경우 -->
	  	      		
	  	      			<c:if test="${ not empty list}">
		  	      			<tr>
		  	      				<td style="width: 50px;">
		  	      					<img src="${ pageContext.request.contextPath }/resources/image/rank_1.png" width="30" height="30">
		  	      				</td>
		  	      				<td style="width: 150px; height: 80px;  cursor:pointer;"
		  	      					 onclick="window.parent.location.href='${ pageContext.request.contextPath }/main.do?menu=recommend_place&idx=${ idx1 }&page=${ empty param.page ? 1 : param.page }'"
		  	      					onmouseover="this.style.color='#23a51d'" onmouseout="this.style.color='black'">
		  	      					<img src="${ pageContext.request.contextPath }/resources/image/${ filename1 }" width="100" height="80">
		  	      				</td> 
		  	      				
		  	      				<td style="width: 50px;">
		  	      					<img src="${ pageContext.request.contextPath }/resources/image/rank_2.png" width="30" height="30">
		  	      				</td>  				
		  	      				<td style="width: 150px; height: 80px;  cursor:pointer;"
		  	      					 onclick="window.parent.location.href='${ pageContext.request.contextPath }/main.do?menu=recommend_place&idx=${ idx2 }&page=${ empty param.page ? 1 : param.page }'"
		  	      					onmouseover="this.style.color='#23a51d'" onmouseout="this.style.color='black'">
		  	      					<img src="${ pageContext.request.contextPath }/resources/image/${ filename2 }" width="100" height="80">
		  	      				</td>   				
		  	      			</tr>
		  	      			
		  	      			<tr>
		  	      				<th>제목</th>
		  	      				<td class="word">
		  	      					<c:choose>
								        <c:when test="${fn:length(subject1) > 6}">
									        <c:out value="${fn:substring(subject1, 0, 6)}"/>...
									    </c:when>
									    <c:otherwise>
										    <c:out value="${subject1}">
										    </c:out>
									    </c:otherwise>
									</c:choose>
								</td>
			  	      				
		  	      				<th>제목</th>
		  	      				<td class="word">
			  	      				<c:choose>
								        <c:when test="${fn:length(subject2) > 6}">
									        <c:out value="${fn:substring(subject2, 0, 6)}"/>...
									    </c:when>
									    <c:otherwise>
										    <c:out value="${subject2}">
										    </c:out>
									    </c:otherwise>
									</c:choose>
								</td>
		  	      			</tr>
		  	      			
		  	      			<tr>
		  	      				<th>작성자</th>
		  	      				<td class="word">
									<c:choose>
								        <c:when test="${fn:length(m_name1) > 6}">
									        <c:out value="${fn:substring(m_name1, 0, 6)}"/>...
									    </c:when>
									    <c:otherwise>
										    <c:out value="${m_name1}">
										    </c:out>
									    </c:otherwise>
									</c:choose>
								</td>
		  	      				<th>작성자</th>
		  	      				<td class="word">
									<c:choose>
								        <c:when test="${fn:length(m_name2) > 6}">
									        <c:out value="${fn:substring(m_name2, 0, 6)}"/>...
									    </c:when>
									    <c:otherwise>
										    <c:out value="${m_name2}">
										    </c:out>
									    </c:otherwise>
									</c:choose>
								</td>
		  	      			</tr>
		  	      			
		  	      			<tr>
		  	      				<th>조회수</th>
		  	      				<td>${ readhit1 }</td>
		  	      				<th>조회수</th>
		  	      				<td>${ readhit2 }</td>
		  	      			</tr>
		  	      			
		  	      			<tr>	
		  	      				<td style="width: 50px;">
		  	      					<img src="${ pageContext.request.contextPath }/resources/image/rank_3.png" width="30" height="30">
		  	      				</td>
		  	      				<td style="width: 150px; height: 80px; cursor:pointer;"
		  	      					 onclick="window.parent.location.href='${ pageContext.request.contextPath }/main.do?menu=recommend_place&idx=${ idx3 }&page=${ empty param.page ? 1 : param.page }'"
		  	      					onmouseover="this.style.color='#23a51d'" onmouseout="this.style.color='black'">
		  	      					<img src="${ pageContext.request.contextPath }/resources/image/${ filename3 }" width="100" height="80">
		  	      				</td>   
		  	      				
		  	      				<td style="width: 50px;">
		  	      					<img src="${ pageContext.request.contextPath }/resources/image/rank_4.png" width="30" height="30">
		  	      				</td>				
		  	      				<td style="width: 150px; height: 80px; cursor:pointer;"
		  	      					 onclick="window.parent.location.href='${ pageContext.request.contextPath }/main.do?menu=recommend_place&idx=${ idx4 }&page=${ empty param.page ? 1 : param.page }'"
		  	      					onmouseover="this.style.color='#23a51d'" onmouseout="this.style.color='black'">
		  	      					<img src="${ pageContext.request.contextPath }/resources/image/${ filename4 }" width="100" height="80">
		  	      				</td>   				
		  	      			</tr>
		  	      			
		  	      			<tr>
		  	      				<th>제목</th>
		  	      				<td class="word">
									<c:choose>
								        <c:when test="${fn:length(subject3) > 6}">
									        <c:out value="${fn:substring(subject3, 0, 6)}"/>...
									    </c:when>
									    <c:otherwise>
										    <c:out value="${subject3}">
										    </c:out>
									    </c:otherwise>
									</c:choose>
								</td>
		  	      				
		  	      				<th>제목</th>
		  	      				<td class="word">
									<c:choose>
								        <c:when test="${fn:length(subject4) > 6}">
									        <c:out value="${fn:substring(subject4, 0, 6)}"/>...
									    </c:when>
									    <c:otherwise>
										    <c:out value="${subject4}">
										    </c:out>
									    </c:otherwise>
									</c:choose>
								</td>
		  	      			</tr>
		  	      			
		  	      			<tr>
		  	      				<th>작성자</th>
		  	      				<td class="word">
									<c:choose>
								        <c:when test="${fn:length(m_name3) > 6}">
									        <c:out value="${fn:substring(m_name3, 0, 6)}"/>...
									    </c:when>
									    <c:otherwise>
										    <c:out value="${m_name3}">
										    </c:out>
									    </c:otherwise>
									</c:choose>
								</td>
		  	      				<th>작성자</th>
		  	      				<td class="word">
									<c:choose>
								        <c:when test="${fn:length(m_name4) > 6}">
									        <c:out value="${fn:substring(m_name4, 0, 6)}"/>...
									    </c:when>
									    <c:otherwise>
										    <c:out value="${m_name4}">
										    </c:out>
									    </c:otherwise>
									</c:choose>
								</td>
		  	      			</tr>
		  	      			
		  	      			<tr>
		  	      				<th>조회수</th>
		  	      				<td>${ readhit3 }</td>
		  	      				<th>조회수</th>
		  	      				<td>${ readhit4 }</td>
		  	      			</tr>
	  	      			</c:if>
	  	      			
	  	      		</table>
	  	      		
				</div>
		</div>
	</div>
