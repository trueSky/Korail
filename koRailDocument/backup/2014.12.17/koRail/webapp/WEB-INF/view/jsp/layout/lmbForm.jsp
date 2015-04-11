<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 파라미터 인코딩 형식 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
   		<script type="text/javascript">
   			/*화면전환*/
   			function findForm(url){
   				location.href = url;
   			}
   		</script>
   	</head>
   	<body>
   		<div style="margin-bottom: 10px;">
   			<img id="lmbImg" style="width: 165px; height: 140px; border: 1px solid black; border-radius: 7px;">
   		</div>
   	
   		<nav class="lmb">
   			<table>
   				<tbody>
	   				<!-- 관리자 -->
    				<c:if test="${type == 'admin'}">
    					<tr>
							<td onclick="findForm('/admin/statnMng.html')" style="border-radius: 7px 7px 0px 0px;">역 관리</td>
						</tr>
						<tr>
							<td onclick="findForm('/admin/trainMng.html')">열차 관리</td>
						</tr>
						<tr>
							<td onclick="findForm('/admin/opratMng.html')">운행일정 관리</td>
						</tr>
						<tr>
							<td onclick="findForm('/admin/memberMng.html')">회원 관리</td>
						</tr>
    				</c:if>
    				<!-- 일반 사용자 -->
	    			<c:if test="${type == 'common'}">
	    				<tr>
							<td onclick="findForm('/member/tcktSearch.html')" style="border-radius: 7px 7px 0px 0px;">승차권 예약</td>
						</tr>
						<tr>
							<td>승차권 현황</td>
						</tr>
					</c:if>
				</tbody>
			</table>
   		</nav>
	</body>
</html>