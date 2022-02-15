<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">

	#bmk_goods_box{
		text-align: left;
		width: 780px;
	}

	#bmkgoods_title{
		text-align: center;
		
		font-size: 20px;
		font-weight: bold;
		
		margin-bottom: 20px;
	}

	th{
		text-align: center;
	}
	
	#bmkgoods_data_align > td{
		text-align: center;
		vertical-align: middle;
	}
	
	#page_align{
		text-align: center;
	}
	

</style>

<script type="text/javascript">

	var regular_number = /^[0-9]{1,6}$/;
	
	function bmkgoods_update(f) {
		
		var bmk_g_cnt = f.bmk_g_cnt.value;
		var bmk_g_idx = f.bmk_g_idx.value;
		
		
		if(regular_number.test(bmk_g_cnt)==false){
			alert('1~6자리 숫자만 입력하세요');
			f.bmk_g_cnt.value='';
			f.bmk_g_cnt.focus();
			return;
		}
		
		f.action = "bmkgoods_update.do";
		f.submit();
		
	}
	
	function bmkgoods_delete(f) {
		
		if(confirm('정말 삭제하시겠습니까?')==false) return;
		
		f.action = "bmkgoods_delete.do";
		f.submit();
		
	}
	
	$(document).ready(function(){
		
		//전체선택 체크박스 선택 시
		$("#check_all").click(function(){
			var checked = $(this).is(":checked");
			if(checked){
				$("input:checkbox[name='check_box']").prop("checked", true);
			}else{
				$("input:checkbox[name='check_box']").prop("checked", false);
			}
		});
		
		//아래쪽 체크박스 클릭 시
		$("input:checkbox[name='check_box']").click(function(){
			var all = true;
			
			$("input:checkbox[name='check_box']").each(function(){
				if($(this).is(":checked")==false)
					all = false;
			});
			$("#check_all").prop("checked", all);
		});
		
	});
	
	function bmkgoods_del_all(f) {
		
		if($("input:checkbox[name='check_box']:checked").length==0){
			alert("삭제할 항목을 선택하세요");
			return;
		}
		
		if(confirm('정말 삭제하시겠습니까?')==false) return;
		
		f.action="bmkgoods_del_all.do";
		f.submit();

	}

</script>


<div id="bmk_goods_box">
<h1 id="bmkgoods_title">캠핑용품 즐겨찾기</h1>

<form>

 	<table id="bmkgoods_data_align" class="table">
		<tr>
			<td colspan="8">
				<input type="checkbox" id="check_all">전체&nbsp;&nbsp;
				<input class="btn btn-danger" type="button" value="선택삭제" onclick="bmkgoods_del_all(this.form);">
			</td>
		</tr>
		<tr class="success">
			<th>선택</th>
			<th>카테고리</th>
			<th>사진</th>
			<th>캠핑용품명</th>
			<th>단가</th>
			<th>수량</th>
			<th>금액</th>
			<th>삭제</th>
		</tr>
		
		<!-- 장바구니가 비어있으면 -->
		<c:if test="${ empty list }">
			<tr>
				<td colspan="8" align="center">
					<b>즐겨찾기가 비었습니다.</b>
				</td>
			</tr>
		</c:if>	
		
		<!-- 통화단위 : 지역지정 -->
		<fmt:setLocale value="ko_kr"/>
		
		
		<!-- for(BmkGoodsVo vo : list) -->
		<c:forEach var="vo" items="${ list }">
		
			<tr id="bmkgoods_data_align">
				<td><input type="checkbox" name="check_box" value="${ vo.bmk_g_idx }"></td>
				<td>${ vo.g_category }</td>
				<td>
   		   			<img src="${ vo.g_image }" width="90" height="90">
   		   		</td>
				<td style="width:160px; "><a href = "${vo.g_link }" target = "_blank">${ vo.g_name}</a></td>
				<td><fmt:formatNumber   value = "${vo.g_price }"/>(원)</td>
				<td>
					<!-- 수량 조정 폼 -->
					<form>
						<input type="hidden" name="bmk_g_idx" value="${ vo.bmk_g_idx }">
						<input type="hidden" name="page"      value="${ param.page }">
						<input name="bmk_g_cnt" size="4"  align="center" value="${ vo.bmk_g_cnt }">
						<input class="btn btn-info" type="submit" value="수정" onclick="bmkgoods_update(this.form);">
					</form>
				</td>
				<td><fmt:formatNumber value="${ vo.amount }"/>(원)</td>
				<td>
				<form>
						<input type="hidden" name="bmk_g_idx" value="${ vo.bmk_g_idx }">
						<input type="hidden" name="page"      value="${ param.page }">
						<input type="button" value="삭제" class="btn btn-danger" 
		                       onclick="bmkgoods_delete(this.form)">
	            </form>
				</td>
				 
				
			</tr>
			
		</c:forEach>

		<tr>
			<td colspan="7" align="right">
				총 결제액 :
			</td>
			<td><fmt:formatNumber value="${ total_amount }" />(원)</td>
		</tr>
	</table>
	
	<!-- 페이징메뉴 -->
	<c:if test="${ not empty list }">
		<div id="page_align">
			${ pageMenu }
		</div>
	</c:if>
	
</form>	

</div>




