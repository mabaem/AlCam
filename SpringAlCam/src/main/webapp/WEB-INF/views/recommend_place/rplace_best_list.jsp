<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	
	#div_rplace_best{
		border: 1px solid black;
	}
	
	a{
		text-decoration: none;
	}
	
	ul{
		list-style: none;
	}
	
	.span_title{
		color: black;
		width: 230px;
		display: inline-block;
	}
	
	.span_writer{
		color: black;
		width: 100px;
		display: inline-block;
		text-align: center;
	}
	
	.span_readhit{
		color: red;
		width: 60px;
		display: inline-block;
		text-align: center;
	}
		
</style>

</head>
<body>

	<div id="div_rplace_best">
		<ul>
			<p>[인기글]</p>
			<li>
				<span class="span_title">&nbsp;&nbsp;제목</span>
				<span class="span_writer">&nbsp;&nbsp;작성자</span>
				<span class="span_readhit">&nbsp;조회수</span>
			</li>
			<c:forEach var="vo" items="${ list }">
				<li>
					<a href="#" onclick="window.parent.location.href='${ pageContext.request.contextPath }/main.do?menu=recommend_place&idx=${ vo.idx }&page=${ empty param.page ? 1 : param.page }'">
						·
						<span class="span_title">${ vo.subject }</span>
						<span class="span_writer">${ vo.m_name }</span>
						<span class="span_readhit">${ vo.readhit }</span>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>