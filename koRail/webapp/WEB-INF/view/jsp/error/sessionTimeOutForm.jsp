<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	
		<script type="text/javascript">
			function doLogout(){
				alert("세션이 만료되었습니다.");
				location.href = "/login.html";
			}
		</script>
	</head>
	<body onload="doLogout();">

	</body>
</html>