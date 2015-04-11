<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 파라미터 인코딩 형식 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- tiles -->
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html class="html-style">
	<body class="body-style">
		<div id="head">
			<tiles:insertAttribute name="head" />	
		</div>
		<header style="width: 100%; height: auto;">
    		<tiles:insertAttribute name="header" />	
		</header>
		<nav style="width: 167px; height: auto; float: left;">
			<tiles:insertAttribute name="lmb" />
		</nav>	
		<article style="width: 847px; height: auto; margin-left: 10px; float: left;">
			<!-- 메뉴트리 -->
			<strong id="menuTree" style="font-size: 20px;">
	   			<c:forEach var="menu" varStatus="state" items="${menuTree}">
	   				<c:choose>
	   					<c:when test="${state.count == menuTree.size()}">
	   						<span style="color: #6799FF">${menu}</span>
	   					</c:when>
	   					<c:otherwise>
	   						<span>${menu}&nbsp;&gt;</span>		
	   					</c:otherwise>
	   				</c:choose>
	   			</c:forEach>
			</strong>
			
			<div style="margin-top: 10px;">
				<tiles:insertAttribute name="content" />
			</div>
		</article>
		<footer style="width: 100%; height: auto;">
			<tiles:insertAttribute name="footer" />
		</footer>
   	</body>
</html>