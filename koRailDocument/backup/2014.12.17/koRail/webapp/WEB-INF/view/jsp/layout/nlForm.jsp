<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 파라미터 인코딩 형식 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- tiles -->
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<body class="body-style">
		<div id="head">
			<tiles:insertAttribute name="head" />	
		</div>
		<header>
    		<tiles:insertAttribute name="header" />	
		</header>
		<article>
			<tiles:insertAttribute name="content" />
		</article>
		<footer>
			<tiles:insertAttribute name="footer" />
		</footer>
   	</body>
</html>