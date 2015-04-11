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
	   				colNames:["객실등급", "좌석번호", "승객유형", "할인요금", "영수금액", "승차자명"],
	          		colModel : [
						{ name : 'roomKndValue', width: 70, align:"center", sortable:false},
						{ name : 'seatNo', width: 70, align:"center", sortable:false},
						{ name : 'psngrKndValue', width: 70, align:"center", sortable:false},
						{ name : 'dscntAmount', width: 70, align:"right", sortable:false},
						{ name : 'frAmount', width: 70, align:"right", sortable:false},
						{ name : 'psngrNm', width: 70, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
				
				for(var i = 0; i < 9; i++){
					$("#gridBody").addRowData(
						i,
						{
							roomKndValue:"일반실",
							seatNo:"A15",
							psngrKndValue:"장애 1 - 3 급",
							dscntAmount:"26,000 원",
							frAmount:"26,000 원",
							psngrNm:"<input type='text' value='곽선진'>"
						}
					);	
				}
	   		});
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
				* 좌석정보의 승차자명은 미입력 및 수정이 가능합니다.
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
   						<col width="25%">
   						<col width="25%">
   						<col width="25%">
   						<col width="25%">
   					</colgroup>
   					<thead>
   						<tr><td colspan="4">승차권정보</td></tr>
   					</thead>
   					<tbody>
   						<tr>
   							<td>열차번호</td>
   							<td>2274</td>
   							<td>열차종류</td>
   							<td>세마을호</td>
   						</tr>
   						<tr>
   							<td>출발역</td>
   							<td>서울</td>
   							<td>출발시각</td>
   							<td>2014-12-29 10:22</td>
   						</tr>
   						<tr>
   							<td>도착역</td>
   							<td>부산</td>
   							<td>도착시각</td>
   							<td>2014-12-29 13:22</td>
   						</tr>
   						<tr>
   							<td>예매수</td>
   							<td>2</td>
   							<td>총 영수금액</td>
   							<td>104,000 원</td>
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
			<button type="button">결제</button>
			<button type="button">예약 취소</button>
		</div>
   		
		<!-- 임시 데이터 -->
		<div id="hiddenData">
			<input id="rowData1" type="hidden">
			<input id="rowData2" type="hidden">
		</div>
		
		<!-- 등록할 데이터 -->
		<form id="resveAddForm" action="/member/resveAdd.html" method="post">
			<input type="hidden">
		</form>
	</body>
</html>