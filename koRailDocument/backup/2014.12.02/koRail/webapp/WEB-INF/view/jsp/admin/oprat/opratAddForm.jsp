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
   			var viewState = false;	/*viewState와 같은 역활이며 상세운행정보에 대한 상태이다*/
   			var viewState2 = false;	/*viewState와 같은 역활이며 호실정보에 대한 상태이다*/
   			var detailOpratArray;	/*상세운행정보*/
   			var roomArray;			/*호시렁보*/
   			
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(2)).addClass("set");
				$($(".lmb tr").get(2)).children("td").addClass("set");
	   			
				doGridInit("all"); /*그리드 초기화*/
	   		});
   			
	   		/*그리드 초기상태*/
   			function doGridInit(mode){
	   			var allInit = false;
	   			
	   			/*모든 그리드 초기화*/
	   			if(mode == "all"){
	   				allInit = true;
	   			}
	   			
	   			/*상세운행일정*/
	   			if(mode == "detailOprat" || allInit){
	   				viewState2 = false;
	   				
	   				/*그리드 초기화*/
					$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
	   				
					$("#gridBody").jqGrid({
						datatype: "LOCAL",
		   				caption:"상세운행일정",
		   				width: 695,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer',
		   				colNames:["출발역", "출발시각", "도착역", "도착시각", "이전역", "이전역 거리", "다음역", "다음역 거리"],
		          		colModel : [
							{ name : 'startStatnValue', width: 70, align:"center",
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=8';
								}
							},
							{ name : 'startTm', width: 70, align:"center"},
							{ name : 'arvlStatnValue', width: 70, align:"center"},
							{ name : 'arvlStatnTm', width: 70, align:"center"},
							{ name : 'prvStatnValue', width: 70, align:"center"},
							{ name : 'prvStatnDistnc', width: 70, align:"center"},
							{ name : 'nxtStatnValue', width: 70, align:"center"},
							{ name : 'nxtStatnDistnc', width: 70, align:"center"}
						]
					}); /*jqGrid end*/
					
					/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
					$("#gridBody").jqGrid('addRowData', 1, {startStatnValue:"운행일정을 선택하십시오."});
	   			}
	   			
	   			if(mode == "room" || allInit){
					viewState3 = false;
	   				
	   				/*그리드 초기화*/
					$("#grid2").html("<table id='gridBody2'></table><div id='footer2'></div>");
	   				
					$("#gridBody2").jqGrid({
						datatype: "LOCAL",
		   				caption:"호실정보",
		   				width: 320,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer2',
		   				colNames:["호실", "좌석수", "특실여부"],
		          		colModel : [
							{ name : "room", width: 70, align:"center",
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=3';
								}
							},
							{ name : "seatCo", width: 70, align:"center"},
							{ name : "prtclrRoomYN", width: 30, align:"center"}
						]
					}); /*jqGrid end*/
					
					/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
					$("#gridBody2").jqGrid('addRowData', 1, {room:"운행일정을 선택하십시오."});
	   			}
   			} /* doGridInit end */
	   		
	   		/*그리드 생성 그리드의 존재여부확인 후 존재할 경우 실행하지 않는다*/
	   		function setGrid(mode){
	   			/*상세운행정보*/
	   			if(mode == "detailOprat"){
	   				/*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
					viewState = true;
	   				
	   				/*그리드 초기화*/
	   				$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
					
					$("#gridBody2").jqGrid({
						datatype: "LOCAL",
		   				caption:"상세운행일정",
		   				width: 695,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer',
		   				colNames:["출발역", "출발시각", "도착역", "도착시각", "이전역", "이전역 거리", "다음역", "다음역 거리"],
		          		colModel : [
							{ name : 'startStatnValue', width: 70, align:"center"},
							{ name : 'startTm', width: 120, align:"center"},
							{ name : 'arvlStatnValue', width: 70, align:"center"},
							{ name : 'arvlTm', width: 120, align:"center"},
							{ name : 'prvStatnValue', width: 70, align:"center"},
							{ name : 'prvDistnc', width: 70, align:"center"},
							{ name : 'nxtStatnValue', width: 70, align:"center"},
							{ name : 'nxtDistnc', width: 70, align:"center"}
						]
					}); /*jqGrid end*/
	   			}
	   			/* 호실정보 */
	   			else{
	   				/*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
					viewState2 = true;
		   				
	   				/*그리드 초기화*/
					$("#grid2").html("<table id='gridBody2'></table><div id='footer2'></div>");
	   				
					$("#gridBody2").jqGrid({
						datatype: "LOCAL",
		   				caption:"호실정보",
		   				width: 320,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer2',
		   				colNames:["호실", "좌석수", "특실여부"],
		          		colModel : [
							{ name : "room", width: 70, align:"center"},
							{ name : "seatCo", width: 70, align:"center"},
							{ name : "prtclrRoomYN", width: 30, align:"center", formatter:"checkbox"}
						]
					}); /*jqGrid end*/
				}
	   		} /* setGrid end */
		</script>
   	</head>
   	<body>
   		<div style="font-size: 35px; padding-bottom: 15px;">
   			<strong>
   				${menuTree[3]}
   			</strong>
   		</div>
   		
   		<!-- 사용방법 -->
   		<div class="caption">
			* 운행정보는 운행에 대한 기본적인 정보를 입력합니다.
			<br>
			* 열차번호, 출발역, 도착역, 노선은 검색을 통해 입력 할 수 있습니다.
			<br>
			* 열차종류는 선택한 열차번호에 따라 자동 입력됩니다.
			<br>
			* 거리는 소숫점 첫째자리까지 입력가능합니다.
   		</div>
   		
   		<!-- 운행일정 -->
   		<div>
			<table class="d-table" style="width: 650px;">
				<colgroup>
					<col width="20%">
					<col width="15%">
					<col width="15%">
					<col width="20%">
					<col width="15%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<td colspan="6" style="text-align: center;">
							<strong>운행일정</strong>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>열차번호</td>
						<td>
							<input id="trainNo" type="text" style="width: 95%;">
						</td>
						<td>
							<button style="height: 27px;">검색</button>
						</td>
						<td>열차종류</td>
						<td id="trainKnd" colspan="2">
							<input style="width: 95%;" type="text">
						</td>
					</tr>
					<tr>
						<td>출발역</td>
						<td id="startStatn">
							<input style="width: 95%;" type="text">
						</td>
						<td>
							<button style="height: 27px;">검색</button>
						</td>
						<td>출발시각</td>
						<td id="startTm" colspan="2">
							<input style="width: 95%;" type="text">
						</td>
					</tr>
					<tr>
						<td>도착역</td>
						<td id="arvlStatn">
							<input style="width: 95%;" type="text">
						</td>
						<td>
							<button style="height: 27px;">검색</button>
						</td>
						<td>도착시각</td>
						<td id="arvlTm" colspan="2">
							<input style="width: 95%;" type="text">
						</td>
					</tr>
					<tr>
						<td>노선</td>
						<td id="route">
							<input type="text">
						</td>
						<td>
							<button style="height: 27px;">검색</button>
						</td>
						<td>거리</td>
						<td id="distnc">
							<input type="text">
						</td>
						<td>km</td>
					</tr>
					<tr>
						<td>요금</td>
						<td id="fare" colspan="4" style="text-align: right;">
							<input type="text">
						</td>
						<td>원</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<!-- 상세운행정보 -->
		<div class="buttonGroup" style="width: 700px;">
			<button>추가</button>
			<button>삭제</button>
		</div>
		<div id="grid" style="margin: 0 auto; margin-top: 5px; width: 695px;">
   			<table id="gridBody"></table>
	   		<div id="footer"></div>
   		</div>
		
		<!-- 호실정보 -->
		<div class="buttonGroup" style="width: 700px;">
			<button>추가</button>
			<button>삭제</button>
		</div>
		<div id="grid2" style="margin: 0 auto; margin-top: 5px; width: 320px;">
   			<table id="gridBody2"></table>
	   		<div id="footer2"></div>
   		</div>
   		
   		<div class="buttonGroup" style="width: 847px; margin-top: 30px; text-align: center;">
   			<button>등록</button>
			<button>취소</button>
   		</div>
	</body>
</html>