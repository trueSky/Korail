<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 파라미터 인코딩 형식 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
		<style>
			.ui-menu { width: 150px; }
		</style>
	
   		<script type="text/javascript">
	   		$(document).ready(function(){
	 			/*JQuery UI*/
	 			$("#menu").menu();
	 			
	 			/*관리자 메뉴 */
	 			$("#menu").mouseout(function(){
	 				$(this).hide();
	 			});
	 			$("#adminMenu").mouseover(function(){
	 				$("#menu").show();
	 			});
 			});
   		
			function findForm(url){	
				location.href = url;
			}
		</script>
   	</head>
   	<body>
   		<!-- 로그인에 따른 동적 화면 -->
    	<div id="buttonGroup" style="text-align: right;">
    		<c:choose>
    			<c:when test="${id == null}">
    				<button style="width: 95px; height: 28px;" type="button" onclick="findForm('/member/memberAdd.html')">회원가입</button>
    				<button style="width: 95px; height: 28px;" type="button" onclick="findForm('/login.html')">로그인</button>    		
    			</c:when>
	    		<c:otherwise>
	   				<strong>${id}님 환영합니다.</strong>
	   				<button style="width: 95px; height: 28px;" type="button" onclick="findForm('/logout.do')">로그아웃</button>
	    		</c:otherwise>
    		</c:choose>
    	</div>
    	<!-- 로그인에 따른 동적 메뉴 -->
    	<nav class="menu" style="margin-top: 5px;">
    		<table>
    			<tbody>
    				<tr>
    					<td onclick="findForm('/main.html')" style="background-image: url('/res/img/logo2.gif');
							height: 50px; width:163px; background-position: -17px;">
    					<!-- 기본 -->
    					<c:if test="${type == null}">
    						<td onclick="findForm('/login.html');">
	    						<strong>승차권</strong>
	    					</td>
    					</c:if>
    					<!-- 관리자 -->
		    			<c:if test="${type == 'admin'}">
		    				<td onclick="alert('관리자 모드에서는 승차권 예약을 하실 수 없습니다.');">
	    						<strong>승차권</strong>
	    					</td>
		    				<td id="adminMenu">
		    					<strong>관리자</strong>
		    					<ul id="menu" style="display: none; position: fixed;">
									<li onclick="findForm('/admin/tcktRcrd.html');">현황</li>
									<li onclick="findForm('/admin/statnMng.html');">관리</li>
								</ul>
		    				</td>
		    			</c:if>
		    			<!-- 일반 사용자 -->
			    		<c:if test="${type == 'common'}">
			   				<td onclick="findForm('/member/tcktSearch.html');">
	    						<strong>승차권</strong>
	    					</td>
			   				<td>
			   					<strong>내 정보</strong>
			   				</td>
			   			</c:if>
    				</tr>
    			</tbody>
    		</table>
    	</nav>
	</body>
</html>