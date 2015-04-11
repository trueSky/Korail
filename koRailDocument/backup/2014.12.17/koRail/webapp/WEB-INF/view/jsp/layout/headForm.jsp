<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 파라미터 인코딩 형식 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">

		<!-- IE 최신버전 이용 -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		
		<link href="/res/favicon.ico" rel="shortcut icon"/>
		
		<!-- css -->
		<link href="/res/css/koRail.css" rel="stylesheet">
		
		<!-- jquery -->
		<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
		
		<!-- jquery ui -->
		<link rel="stylesheet" type="text/css" media="screen" href="/res/jquery-ui-1.11.2.custom/jquery-ui.min.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="/res/jquery-ui-1.11.2.custom/jquery-ui.structure.min.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="/res/jquery-ui-1.11.2.custom/jquery-ui.theme.min.css" />
		<script src="/res/jquery-ui-1.11.2.custom/jquery-ui.min.js" type="text/javascript"></script>
		
		<!-- jqGrid -->
		<link rel="stylesheet" type="text/css" media="screen" href="/res/jqGrid_v4.6.0/css/ui.jqgrid.css" />
		<script src="/res/jqGrid_v4.6.0/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
		<script src="/res/jqGrid_v4.6.0/js/jquery.jqGrid.min.js" type="text/javascript"></script>
		
		<!-- HTML5 호환 -->
    	<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
   		<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
     	
     	<title>KOARIL</title>
     	
     	<script type="text/javascript">
     		/*페이지 시작 시 JQuery UI style 및 ETC style 적용 */
     		$(document).ready(function(){
     			$("button").button();
     			//$("select").selectmenu();
     		});
     	</script>
   	</head>
</html>