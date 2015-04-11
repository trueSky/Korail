<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 파라미터 인코딩 형식 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
		<style type="text/css">
			.tcktTable {
				background: #FFFFFF;
				padding: 5px;
				width: 600px;
				font-weight: bolder;
				border-collapse: collapse;
				margin: 0 auto;
				margin-top: 30px;
			}
			.tcktTable .head {
				background-color: #515151;
				color: #FFFFFF;
			}
			.tckt-group .tcktTable:FIRST-CHILD {
				margin-top: 10px;
			}
		</style>
		<script type="text/javascript">
			$(document).ready(function(){
				/*Action style*/
				$(".menu td").eq(1).addClass("set");
				$(".lmb tr").eq(0).children("td").addClass("set");
				
				/*화면에따른 img*/
				if("${requestForm}" == "setleSuccess.html"){
					/*lmb img*/
					$("#lmbImg").attr("src", "/res/img/tra_visual01.jpg");
				}else{
					/*lmb img*/
					$("#lmbImg").attr("src", "/res/img/tra_visual12.jpg");
				}
			});
			
			/*예매취소*/
			function doBtnEvent(){
				var msg = $("#train1").html()+" "
							+$("#startStatn1").html()+"▶"+$("#arvlStatn1").html()
							+"행의 예매를 취소하시겠습니까?";
				
				if(confirm(msg)){
						$.ajax({
							type:"POST",
							url: "/member/processResve.do",
							Type:"JSON",
							data: {state:"delete", code:"${resveCode}"},
							success : function(data) {
								if(data.rtCode == 0){
									alert(
										$("#train1").html()+" "
										+$("#startStatn1").html()+"▶"+$("#arvlStatn1").html()
										+"행의 예매가 취소되었습니다."
									);
									location.href = "/member/resveRcrd.html";
								}else{
									alert("서버에러");
								}
							}, /*success end*/
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
			}
		</script>
	</head>
	<body>
		<c:if test="${requestForm == 'setleSuccess.html'}">
			<div style="font-size: 35px; padding-bottom: 15px;">
	   			<strong style="float: left;">
	   				${menuTree[3]}
	   			</strong>
	   			<div style="float: right; vertical-align: bottom; background: #FFFFFF; border-radius: 7px;">
	   				<img src="/res/img/step_tck01.gif">
	   				<img src="/res/img/step_tck02.gif">
	   				<img src="/res/img/step_tck03.gif">
	   				<img src="/res/img/step_tck04_on.gif">
	   			</div>
	   		</div>
	   		
			<!-- 사용방법 -->
	   		<div style="clear: left; clear: right;">
				<div class="caption" style="margin-top: 40px; margin-bottom: 0px;">
					* 방금 결제하신 승차권에 대한 결제내역과 좌석정보 입니다.<br>
					* 승차권 현황 보기를 이용하여 다른 승차권에 대한 현황을 보실 수 있습니다.<br>
					* 승차권 예매를 취소는 승차권 현황화면에서 가능합니다.
				</div>
	   		</div>
   		
			<div style="text-align: center; margin-top: 10px;">
				<button type="button" onclick="location.href = '/member/resveRcrd.html'">승차권 현황 보기</button>
			</div>
		</c:if>
		
		<c:if test="${requestForm == 'detailResveRcrd.html'}">
			<div style="font-size: 35px;">
	   			<strong>
	   				${menuTree[3]}
	   			</strong>
	   		</div>
			
			<!-- 사용방법 -->
	   		<div class="caption" style="margin-top: 10px; margin-bottom: 0px;">
				* 승차권에 대한 결제내역과 좌석정보 입니다.<br>
				* 목록버튼을 이용하여 승차권 현황 화면으로 이동이 가능 합니다.<br>
				* 예매취소 버튼을 이용하여 승차권의 예매를 취소할 수 있습니다.
	   		</div>
	   		
	   		<!-- 버튼그룹 -->
	   		<div style="margin-top: 10px;">
	   			<button type="button" onclick="location.href = '/member/resveRcrd.html';">목록</button>
		   		<button type="button" onclick="doBtnEvent();">예매취소</button>
	   		</div>
		</c:if>
   		
   		<!-- 승차권정보 -->
   		<div class="tckt-group">
   			<c:forEach var="data" items="${tcktInfo.seatInList}" varStatus="state">
	   			<table class="tcktTable" style="border: 1px solid black; text-align: center;">
		   			<thead>
		   				<tr class="head">
			   				<td colspan="3">승차권</td>
		   				</tr>
		   			</thead>
		   			<tbody>
		   				<tr style="font-size: 30px;">
		   					<td id="startStatn${state.count}">${data.startStatn}</td>
		   					<td>▶</td>
		   					<td id="arvlStatn${state.count}">${data.arvlStatn}</td>
		   				</tr>
		   				<tr>
		   					<td>${data.startTm}</td>
		   					<td></td>
		   					<td>${data.arvlTm}</td>
		   				</tr>
		   				<tr>
		   					<td id="train${state.count}">${data.trainKnd} ${data.trainNo}</td>
							<td>${data.room} 호차 (${data.roomKnd})</td>
							<td>${data.seatNo} 석</td>
						</tr>
						<tr>
		   					<td colspan="3">승차자 ${data.psngrNm} (${data.psngrKnd})</td>
		   				</tr>
						<tr class="head">
		   					<td>운임금액 ${data.frAmount} 원</td>
		   					<td>할인금액 ${data.dscntAmount} 원</td>
		   					<td>영수금액 ${data.rcptAmount} 원</td>
		   				</tr>
						<tr>
							<td>결제자 ${tcktInfo.id}</td>
							<td>결제일 ${tcktInfo.rgsde}</td>
							<td>매 수 ${tcktInfo.resveCo} 장</td>
						</tr>
						<tr>
							<td>총 운임요금 ${tcktInfo.frAmount} 원</td>
							<td>총 할인금액 ${tcktInfo.dscntAmount} 원</td>
							<td>추가 할인금액 ${tcktInfo.usePint} 원</td>
						</tr>
						<tr class="head">
							<td colspan="3">결제금액 ${tcktInfo.setleAmount} 원</td>
						</tr>
		   			</tbody>
		   		</table>
	  	 	</c:forEach>
		</div>
   	</body>
</html>