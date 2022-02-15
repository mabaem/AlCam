<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>


<style type="text/css">

    #welcome_box{
 
 		text-align: center;
 		margin-top: 50px;
    }

	#member_index_name{
		font-weight: bold;
		font-size: 18px;
	}
	
	#member_index_hello{
		font-size: 16px;
	}


</style>

<div  id="welcome_box">
	<img src="${ pageContext.request.contextPath }/resources/image/${ vo.m_filename }" width="100" height="100">
	<br><br>
	<span id="member_index_name">${ vo.m_name }</span><span id="member_index_hello">님 안녕하세요</span>
</div>
