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
   			var viewState1 = false; /* 그리드 생성싱테 : true 생성됨, false 생성되 않음 */
   			var viewState2 = false; /* 그리드 생성싱테 : true 생성됨, false 생성되 않음 */
   			var date = new Date();	/*현재 날짜*/
   			
   			$(document).ready(function(){
	   			/*Action style*/
				$(".menu td").eq(2).addClass("set");
				$(".lmb tr").eq(0).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual10.jpg");
				
				/* replace */
				$("#zipCode").text("${member.zipCode}".replace(",", "-"));
   			
				/*비밀번호 변경*/
				$("#pwUpdateBtn").click(function(){
					/*다이알로그*/
	   				$("#updateDialog").dialog({
	   					modal: true,
	   					width: 400,
	   					buttons:{
	   						"비밀번호 변경":function(){
	   							/*현재 비밀번호*/
	   							var oldPassword = $.trim($("#oldPassword").val());
	   							/*새 비밀번호*/
	   							var newPassword = $.trim($("#newPassword").val());
	   							/*비밀번호 확인*/
	   							var password = $.trim($("#password").val());
	   							
	   							/*유효성 검사*/
	   							if(oldPassword == ""){
	   								alert("현제 비밀번호를 입력해야 합니다.");
	   								$("#oldPassword").focus();
	   							}
	   							else if(oldPassword != "${password}"){
	   								alert("현재 비밀번호가 일치하지 않습니다.");
	   								$("#oldPassword").focus();
	   							}else if(newPassword == ""){
	   								alert("새 비밀번호를 입력해야 합니다.");
	   								$("#newPassword").focus();
	   							}else if(password == ""){
	   								alert("새 비밀번호 확인을 입력해야 합니다.");
	   								$("#password").focus();
	   							}else if(newPassword != password){
	   								alert("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.");
	   								$("#password").focus();
	   							}else if(oldPassword == password){
	   								alert("현재 비밀번호와 동일반 비밀번호는 사용하실 수 없습니다.");
	   								$("#newPassword").focus();
	   							}else{
	   								if(confirm("비밀번호를 변경 하시겠습니까?")){
		   		   						$.ajax({
		   		   							type:"POST",
		   		   							Type:"JSON",
		   		   							data:{state:"update", id:"${id}", password:password},
		   		   							url:"/member/memberProcess.do",
		   		   							success:function(data){
		   		   								if(data.erCode == 0){
		   		   									alert("변경이 완료되었습니다.");
		   		   									location.href = "/logout.do";
		   		   								}else{
		   		   									alert("변경실패");
		   		   								}
		   		   							},
		   		   							error : function(request, status, error){
		   		   								if(request.status == 401){
		   		   									alert("세션이 만료되었습니다.");
		   		   									location.href = "/login.html";
		   		   								}else{
		   		   									alert("서버에러입니다.");
		   		   								}
		   		   							}
		   		   						});
		   							}else{
		   								return;
		   							}
		   							
		   							$(this).dialog("close");
	   							}
	   						},
	   						"취소":function(){
	   							$(this).dialog("close");
	   						}
	   					}
	   				});
				});
				
				/*회원탈퇴*/
   				$("#deleteMemberBtn").click(function(){
   					if(confirm("회원님의 모든정보가 삭제됩니다, 회원 탈퇴 하시겠습니까?")){
   						if(confirm("정말로 회원 탈퇴 하시겠습니까?")){
	   						$.ajax({
	   							type:"POST",
	   							Type:"JSON",
	   							data:{state:"delete", id:"${id}"},
	   							url:"/member/memberProcess.do",
	   							success:function(data){
	   								if(data.erCode == 0){
	   									alert("지금까지 서비스를 이용해주셔서 감사합니다.");
	   									location.href = "/login.html";
	   								}else{
	   									alert(data.erMsg);
	   									location.href = "/member/useHstr.html";
	   								}
	   							},
	   							error : function(request, status, error){
	   								if(request.status == 401){
	   									alert("세션이 만료되었습니다.");
	   									location.href = "/login.html";
	   								}else{
	   									alert("서버에러입니다.");
	   								}
	   							}
	   						});
   						}else{
   							return;
   						}
   					}else{
   						return;
   					}
   				});
   			});
		</script>
   	</head>
   	<body>
   		<div style="font-size: 35px; padding-bottom: 15px;">
   			<strong>
   				${menuTree[2]}
   			</strong>
   		</div>
   		
   		<!-- 사용방법 -->
   		<div class="caption">
			<div>* 개인정보 수정 및 회원탈퇴, 이용내역 조히를 하실 수 있습니다.</div>
		</div>
		
		<!-- 개인정보 -->
		<div>
			<table class="d-table">
				<tbody>
					<tr>
						<td class="head">아이디</td>
						<td>${member.id}</td>
						<td class="head">성명</td>
						<td>${member.nm}</td>
					</tr>
					<tr>
						<td class="head">비밀번호</td>
						<td>
							<button id="pwUpdateBtn" type="button">비밀번호 변경</button>
						</td>
						<td class="head">성별</td>
						<td>${member.gndr}</td>
					</tr>
					<tr>
						<td class="head">전화번호</td>
						<td>${member.telNo}</td>
						<td class="head">휴대전화번호</td>
						<td>${member.mbtlnum}</td>
					</tr>
					<tr>
						<td class="head">이메일</td>
						<td colspan="3" style="text-align: left;">${member.emal}</td>
					</tr>
					<tr>
						<td class="head" rowspan="4">주소</td>
					</tr>
					<tr>
						<td id="zipCode" style="text-align: left;" colspan="3">${member.zipCode}</td>
					</tr>
					<tr>
						<td style="text-align: left;" colspan="3">${member.addrs}</td>
					</tr>
					<tr>
						<td style="text-align: left;" colspan="3">${member.detailAddrs}</td>
					</tr>
					<tr>
						<td class="head">가입일자</td>
						<td>${member.rgsde}</td>
						<td class="head">정보수정일자</td>
						<td>${member.updde}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- button group -->
		<div style="margin-top: 10px; text-align: center;">
			<button type="button" onclick="location.href = '/member/updateMember.html'">정보 수정</button>
			<button id="deleteMemberBtn" type="button">회원 탈퇴</button>
		</div>
		<div>
			<table class="d-table">
				<thead>
					<tr>
						<td colspan="3">포인트</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>적립포인트</td>
						<td>사용포인트</td>
						<td>현재포인트</td>
					</tr>
					<tr>
						<c:choose>
							<c:when test="${pint == null}">
								<td>0 P</td>
								<td>0 P</td>
								<td>0 P</td>
							</c:when>
							<c:otherwise>
								<td>${pint.svPint} P</td>
								<td>${pint.allUsePint} P</td>
								<td>${pint.tdyPint} P</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</tbody>
			</table>
		</div>
		<div style="margin-top: 10px; text-align: center;">
			<button type="button" onclick="location.href = '/member/useHstr.html'">이용 내역</button>
		</div>
		
		<!-- 비밀번호 수정 다이알로그 -->
		<div id="updateDialog" title="비밀번호 변경" style="display: none;">
			<table>
				<tbody>
					<tr>
						<td>현재 비밀번호</td>
						<td>
							<input id="oldPassword" type="password">
						</td>
					</tr>
					<tr>
						<td>새 비밀번호</td>
						<td>
							<input id="newPassword" type="password">
						</td>
					</tr>
					<tr>
						<td>새 비밀번호 확인</td>
						<td>
							<input id="password" type="password">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>