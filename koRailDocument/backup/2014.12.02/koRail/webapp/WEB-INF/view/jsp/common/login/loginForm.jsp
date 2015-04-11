<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
		<script>
			/*로그인*/
			$(document).ready(function(){	
				var oldEtcMenu = $("#etcMenu").html();
				
				$("#loginBtn").click(function(){
					var id = $("#idTxt").val().trim();
					var pw = $("#pwTxt").val().trim();
					var loginType = $("input[name=loginType]:checked").val().trim();
					
					if(id == "" || pw == ""){
						alert("아이디 또는 비밀번호를 입력해야 합니다.");
					}else{
						$.ajax({
							type:"POST",
							url: "/login.do?type="+loginType+"&id="+id+"&pw="+pw,
							Type:"JSON",
							success : function(data) {
								if(data.erCode == 0){
									location.href = "/main.html";
								}else{
									$("#pwTxt").val("");
									alert(data.erMsg);
								}
							}
						});
					}
				});
				
				/*권한 선택에 따른 화면전환*/
				$("input[type=radio]").click(function(){
					var mode = $(this).val().trim();
					
					if(mode == "admin"){
						$("#etcMenu").html("");
					}else{
						$("#etcMenu").html(oldEtcMenu);
					}
				});
				
				/*엔터*/
				$("#pwTxt").keydown(function(e){
					if(e.keyCode == 13){
						$("#loginBtn").click();
					}
				});
			});
		</script>
	</head>
	<body>
		<div style="width: 320px; margin: 0 auto; border-style: solid; border-color: #054D7D; padding: 10px;">
			<strong>로그인</strong>
			
			<form id="loginForm" action="/login.do" method="post" style="margin-top: 20px;">
				<table style="padding-bottom: 12px; padding-left: 12px; padding-top: 0px;">
					<thead>
						<tr style="text-align: center;">
							<td>
								<label>
									<input name="loginType" value="common" type="radio" checked="checked"> 일반
								</label>
							</td>
							<td>
								<label>
									<input name="loginType" value="admin" type="radio"> 관리자
								</label>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2">
								<input id="idTxt" type="text" name="id" class="form-control" placeholder="아이디" style="width: 200px;">
							</td>
							<td rowspan="2" style="padding-left: 5px;">
								<button id="loginBtn" type="button" class="btn" style="height: 50px; width: 80px; padding: 0px; col">로그인</button>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input id="pwTxt" type="password" name="pw" class="form-control" placeholder="비밀번호" style="width: 200px;">
							</td>
						</tr>
						<tr id="etcMenu">
							<td colspan="3" style="text-align: center;">
								<a href="/member/aadUser.html">회원가입</a>
								&nbsp;
								<a href="/member/aadUser.html">아이디/비밀번호 찾기</a>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</body>
</html>