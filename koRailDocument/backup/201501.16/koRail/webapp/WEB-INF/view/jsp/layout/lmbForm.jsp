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
   			/*세션 체크*/
   			function doSessionCheck(){
   				if("${type}" == "" || "${type2}" == ""){
	   				alert("잘못된 접근입니다.");
   					location.href = "/main.html";
   				}
   			}
   		</script>
   	</head>
   	<body onload="doSessionCheck();">
   		<div style="margin-bottom: 10px;">
   			<img id="lmbImg" style="width: 165px; height: 140px; border: 1px solid black; border-radius: 7px;">
   		</div>
   	
   		<nav class="lmb">
   			<table>
   				<tbody>
	   				<!-- 관리자 -->
   					<c:if test="${type == 'admin'}">
   						<!-- 현황 -->
    					<c:if test="${type2 == 'rcrd'}">
    						<tr>
								<td onclick="findForm('/admin/tcktRcrd.html')" style="border-radius: 7px 7px 0px 0px;">승차권 발권 현황</td>
							</tr>
							<tr>
								<td onclick="findForm('/admin/trainRcrd.html')">열차별 승객 현황</td>
							</tr>
    					</c:if>
    					<!-- 관리 -->
    					<c:if test="${type2 == 'mng'}">
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
   					</c:if>
   					<!-- 일반 사용자 -->
   					<c:if test="${type == 'common'}">
   						<c:if test="${type2 == 'tckt'}">
   							<tr>
								<td onclick="findForm('/member/tcktSearch.html')" style="border-radius: 7px 7px 0px 0px;">승차권 예약</td>
							</tr>
							<tr>
								<td onclick="findForm('/member/resveRcrd.html');">승차권 현황</td>
							</tr>
   						</c:if>
   						<c:if test="${type2 == 'myInfo'}">
   							<tr>
								<td style="border-radius: 7px 7px 0px 0px;" onclick="findForm('/member/myInfo.html');">개인정보 관리</td>
							</tr>
							<tr>
								<td onclick="findForm('/member/useHstr.html');">이용 내역</td>
							</tr>
   						</c:if>
   					</c:if>
				</tbody>
			</table>
   		</nav>
	</body>
</html>