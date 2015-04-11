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
			.sell-out {
				background-color: #ED4C00;
			}
			
			.sell-out:HOVER {
				color: #FFFFFF;
				background-color: #FF8224;
			}
			
			.sell-out:ACTIVE {
				background-color: #FFFFFF;
				color: #000000;
			}
			#roomList td{
				font-weight: bold;
				padding-left: 15px;
				padding-right: 15px;
				padding-top: 5px;
				padding-bottom: 5px;
				border: 1px solid #FFFFFF;
				border-radius: 7px;
				text-align: center;
				cursor:pointer;
				cursor:hand;
			}
			#roomList td:HOVER{
				background: #515151;
			}
			#roomList .action{
				background: #515151;
			}
			#seatList p {
				font-weight: bold;
				padding-left: 7px;
				padding-right: 7px;
				padding-top: 5px;
				padding-bottom: 5px;
				margin: 5px;
				border-radius: 7px;
				text-align: center;
				cursor:pointer;
				cursor:hand;
			}
			#seatList .def {
				background: #65FF5E;
			}
			#seatList .slt {
				background: #6CC0FF;
			}
			#seatList .non {
				background: #515151;
				cursor:default;
			}
		</style>
	
   		<script type="text/javascript">
   			var viewState = false;	/* 그리드 생성싱테 : true 생성됨, false 생성되 않음 */
   			var seatNoArray = "";	/* 좌석정보 */
   			
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(1)).addClass("set");
				$($(".lmb tr").get(0)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual01.jpg");
				
				
				/*그리드 초기화*/
				$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
   				
				$("#gridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"좌석정보",
	   				width: 845,
	   				height: 202,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["번호", "객실등급", "호실", "좌석번호", "승객유형", "운임요금", "할인요금", "영수금액", "승차자명"],
	          		colModel : [
						{ name : 'no', width: 20, align:"center", sortable:false},
						{ name : 'roomKnd', width: 70, align:"center", sortable:false},
						{ name : 'room', width: 70, align:"center", sortable:false},
						{ name : 'seatNo', width: 70, align:"center", sortable:false},
						{ name : 'psngrKnd', width: 70, align:"center", sortable:false},
						{ name : 'frAmount', width: 70, align:"right", sortable:false},
						{ name : 'dscntAmount', width: 70, align:"right", sortable:false},
						{ name : 'rcptAmount', width: 70, align:"right", sortable:false},
						{ name : 'psngrNm', width: 70, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
				
				for(var i = 1; i < ($("#setleAddForm div").size()+1); i++){
					var psngrNm = $("#dataGroup"+i+" .psngrNm").val();
					
					$("#gridBody").addRowData(
						i,
						{
							no:i,
							roomKnd:$("#dataGroup"+i+" .roomKnd").val(),
							room:$("#dataGroup"+i+" .room").val()+" 호실",
							seatNo:$("#dataGroup"+i+" .seatNo").val(),
							psngrKnd:$("#dataGroup"+i+" .psngrKnd").val(),
							frAmount:$("#dataGroup"+i+" .frAmount").val()+" 원",
							dscntAmount:$("#dataGroup"+i+" .dscntAmount").val()+" 원",
							rcptAmount:$("#dataGroup"+i+" .rcptAmount").val()+" 원",
							psngrNm:"<input id='gridPsngrNm"+i+"' type='text' value='"+psngrNm+"'>"
						}
					);
				} /* for end */
				
				/* 첫 행의 승차자명 자동입력 */
				$("#gridPsngrNm1").val("${name}");
	   		});
   			
   			/* 결제 */
   			function findSetleForm(){
   				if(confirm("이 내용으로 결제를 진행 하시겠습니까?")){
   					$("#setleAddForm").submit();
   				}else{
   					return;
   				}
   			}
   			
   			/* 예약취소 */
   			function doResveDelete(){
   				if(confirm("예약을 취소하시겠습니까?")){
   					$("#deleteResveForm").submit();
   				}else{
   					return;
   				}
   			}
   		</script>
	</head>
	<body>
		<div style="font-size: 35px; padding-bottom: 15px;">
   			<strong style="float: left;">
   				${menuTree[3]}
   			</strong>
   			<div style="float: right; vertical-align: bottom; background: #FFFFFF; border-radius: 7px;">
   				<img src="/res/img/step_tck01.gif">
   				<img src="/res/img/step_tck02_on.gif">
   				<img src="/res/img/step_tck03.gif">
   				<img src="/res/img/step_tck04.gif">
   			</div>
   		</div>
	
		<!-- 사용방법 -->
   		<div style="clear: left; clear:  right;">
			<div class="caption" style="margin-top: 40px; margin-bottom: 0px;">
				* 죄회화면에서 선택한 정보들 입니다.
				<br>
				* 좌석정보의 승차자명은 변경이 가능하며 첫 좌석은 예약을 진행한 계정의 성명으로 자동입력 됩니다.
				<br>
				* 결제를 진행하지 않으시면 일정기간 경과 후 예약이 취소됩니다.
			</div>
   		</div>
   		
   		<!-- table -->
   		<div>
   			<!-- 승차권 정보 -->
   			<div>
   				<table class="d-table">
   					<colgroup>
   						<col width="20%">
   						<col width="30%">
   						<col width="20%">
   						<col width="30%">
   					</colgroup>
   					<thead>
   						<tr><td colspan="4">승차권정보</td></tr>
   					</thead>
   					<tbody>
   						<tr>
   							<td class="head">열차번호</td>
   							<td>${resve.trainNo}</td>
   							<td class="head">열차종류</td>
   							<td>${resve.trainKnd}</td>
   						</tr>
   						<tr>
   							<td class="head">출발역</td>
   							<td>${resve.startStatn}</td>
   							<td class="head">출발시각</td>
   							<td>${resve.startTm}</td>
   						</tr>
   						<tr>
   							<td class="head">도착역</td>
   							<td>${resve.arvlStatn}</td>
   							<td class="head">도착시각</td>
   							<td>${resve.arvlTm}</td>
   						</tr>
   						<tr>
   							<td class="head">예매수</td>
   							<td>${resve.resveCo} 매</td>
   							<td class="head">총 운임금액</td>
   							<td>${resve.allFrAmount} 원</td>
   						</tr>
   						<tr>
   							<td class="head">총 할인금액</td>
   							<td>${resve.allDscntAmount} 원</td>
   							<td class="head">총 영수금액</td>
   							<td>${resve.allRcptAmount} 원</td>
   						</tr>
   					</tbody>
   				</table>
   			</div>
   			<!-- 승객 및 좌석정보 -->
   			<div id="grid" style="margin-top: 7px;">
   				<table id="gridBody"></table>
   			</div>
   			
   			<!-- Read me -->
   			<div style="color: red; margin-top: 10px;">
   				<strong>※ 결제를 진행하지 않으시면 일정기간 경과 후 예약이 취소됩니다.</strong>
   			</div>
   		</div>
   		
		<div style="text-align: center; margin-top: 15px;">
			<button type="button" onclick="findSetleForm();">결제</button>
			<button type="button" onclick="doResveDelete();">예약 취소</button>
		</div>
   		
		<!-- 좌석정보 그리드 데이터 및 파라미터 -->
		<form id="setleAddForm" action="/member/setle.html" method="post">
			<input name="resveCode" type="hidden" value="${resveCode}">
			<input name="allFrAmount" type="hidden" value="${resve.allFrAmount}">
			<input name="allDscntAmount" type="hidden" value="${resve.allDscntAmount}">
			<input name="allRcptAmount" type="hidden" value="${resve.allRcptAmount}">
			<c:forEach var="data" items="${resve.detailResveList}" varStatus="state">
				<div id="dataGroup${state.count}">
					<input class="detailResveCode" name="detailResveCode" type="hidden" value="${data.detailResveCode}">
					<input class="roomKnd" type="hidden" value="${data.roomKndValue}">
					<input class="room" type="hidden" value="${data.room}">
					<input class="seatNo" type="hidden" value="${data.seatNo}">
					<input class="psngrKnd" type="hidden" value="${data.psngrKndValue}">
					<input class="frAmount" type="hidden" value="${data.frAmount}">
					<input class="dscntAmount" type="hidden" value="${data.dscntAmount}">
					<input class="rcptAmount" type="hidden" value="${data.rcptAmount}">
					<input class="psngrNm" name="psngrNm" type="hidden" value="${data.psngrNm}">
				</div>
			</c:forEach>
		</form>
		
		<!-- 예약취소 -->
		<form id="deleteResveForm" action="/member/processResve.do" method="post">
			<input name="state" type="hidden" value="delete">
			<input name="resveCode" type="hidden" value="${resveCode}">
		</form>
	</body>
</html>