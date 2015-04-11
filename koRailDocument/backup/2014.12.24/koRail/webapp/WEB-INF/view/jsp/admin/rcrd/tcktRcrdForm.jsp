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
   			var viewState = false; /* 그리드 생성싱테 : true 생성됨, false 생성되 않음 */
   		
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(2)).addClass("set");
				$($(".lmb tr").get(0)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tre_c_01.jpg");
				
				/* 날짜설정 */
				setYear();
				
				/* 초기그리드 */
				doGridInit();
	   		});
	   		
	   		/* 년도 설정 : 년도는 현재년도와 다음년도를 선택할수 있다. */
	   		function setYear(dateTime){
	   			var dateTime = new Date();
	   			
	   			/* 현재년도 선택 */
	   			$("#year").children("option[value="+dateTime.getFullYear()+"]").attr("selected", "selected");
	   			
   				/* 날짜 설정 */
   				setDateTime();
   				
   				/* 현재날짜 자동선택 */
   				$("#month").children("option[value="+(dateTime.getMonth()+1)+"]").attr("selected", "selected");
   				$("#date").children("option[value="+dateTime.getDate()+"]").attr("selected", "selected");
	   		}
	   		
	   		/* 날짜 설정 */
   			function setDateTime(){
   				/* 년과 월에 대한 날짜 */
				var dateSize = new Date($("#year").val(), $("#month").val(), "");
   	   				
   				/* HTML 초기화 */
   				$("#date").html("");
   	   				   				
   				for(var i = 1; i <= dateSize.getDate(); i++){
   					if(i < 10){
   	   					$("#date").append('<option value="0'+i+'">0'+i+'</option>');   						
   					}else{
 	  					$("#date").append('<option value="'+i+'">'+i+'</option>');
   					}
   				}
   			}
	   		
	   		/* 초기그리드 */
	   		function doGridInit(){
	   			viewState = false;
	   			
	   			/*그리드 초기화*/
				$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
   				
				$("#gridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"승차권 발권 현황",
	   				width: 845,
	   				height: 323,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["승차일자", "열차번호", "열치종류",  "출발역", "출발시각", "도착역", "도착시각", "특실발권", "일반실발권"],
	          		colModel : [
						{ name : "tcktTm", width: 70, align:"center", sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=9';
							}
						},
						{ name : 'trainNo', width: 70, align:"center", sortable:false},
						{ name : 'trainKndValue', width: 90, align:"center", sortable:false},
						{ name : 'startStatnValue', width: 70, align:"center", sortable:false},
						{ name : 'startTm', width: 40, align:"center", sortable:false},
						{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
						{ name : 'arvlTm', width: 40, align:"center", sortable:false},
						{ name : 'prtclrRoomY', width: 70, align:"center", sortable:false},
						{ name : 'prtclrRoomN', width: 70, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
			
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").jqGrid('addRowData', 1, {tcktTm:"조회조건을 선택하여 조회를 하십시오."});
	   		}
	   		
	   		/* 승차권 발권 현황 조회 */
	   		function findTcktRcrdList(){
	   			/* 열차종류 */
	   			var trainKndCode = $("#trainKndSelect").val();
	   			/* 승차일자 */
	   			var tcktTm = $("#year").val()+"-"+$("#month").val()+"-"+$("#date").val();
	   			
	   			/* 검색조건 확인 */
	   			if(trainKndCode == "non"){
	   				alert("열차종류를 선택해야 합니다.");
	   				return;
	   			}
	   			
	   			/*그리드 내용*/				
				$.ajax({
					type:"POST",
					url: "/admin/tcktRcrdList.do?trainKndCode="
							+trainKndCode+"&tcktTm="+tcktTm,
					Type:"JSON",
					success : function(data) {
						if(data.tcktRcrdListSize == 0){
							alert("조회된 결과가 없습니다.");
							return;
						}else{
							/* 그리드 생성싱테에 따른 그리드 생성 */
				   			if(!viewState){
				   				viewState = true;
				   				
				   				/*그리드 초기화*/
								$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
				   				
								$("#gridBody").jqGrid({
									datatype: "LOCAL",
					   				caption:"승차권 발권 현황",
					   				width: 845,
					   				height: 323,
					   				scroll: 1,
					   				rowNum : 'max',
					   				pager: '#footer',
					   				colNames:["승차일자", "열차번호", "열치종류",  "출발역", "출발시각", "도착역", "도착시각", "특실발권", "일반실발권"],
					          		colModel : [
										{ name : 'tcktTm', width: 70, align:"center", sortable:false},
										{ name : 'trainNo', width: 70, align:"center", sortable:false},
										{ name : 'trainKndValue', width: 90, align:"center", sortable:false},
										{ name : 'startStatnValue', width: 70, align:"center", sortable:false},
										{ name : 'startTm', width: 40, align:"center", sortable:false},
										{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
										{ name : 'arvlTm', width: 40, align:"center", sortable:false},
										{ name : 'prtclrRoomY', width: 70, align:"center", sortable:false},
										{ name : 'prtclrRoomN', width: 70, align:"center", sortable:false}
									]
								}); /*jqGrid end*/
				   			} /* if end */
							
							/*그리드 비우기*/
							$("#gridBody").jqGrid('clearGridData');
							
							/* 데이터 추가 */
							$.each(data.tcktRcrdList, function(k, v){
								$("#gridBody").jqGrid('addRowData', k,
									{
										tcktTm:v.tcktTm,
										trainNo:v.trainNo,
										trainKndValue:v.trainKndValue,
										startStatnValue:v.startStatnValue,
										startTm:v.startTm,
										arvlStatnValue:v.arvlStatnValue,
										arvlTm:v.arvlTm,
										prtclrRoomY:v.prtclrRoomYCo+" / "+v.prtclrSeatYCo,
										prtclrRoomN:v.prtclrRoomNCo+" / "+v.prtclrSeatNCo
									}
								);
							}); /* each end */
						} /* else end */
					} /* success end */
				}); /* ajax end */
	   		} /* findTcktRcrdList end */
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
			* 열차종류와 승차일자를 선택하여 해당하는 승차권 발권 현황을 조회할 수 있습니다.
   			<br>
   			* 특실발권, 일반실발권 표기방법 : 예약된 좌석수 / 총 좌석수
   		</div>
   		
   		<!-- search-group -->
   		<div style="width: 650px; margin: 0 auto;">
   			<table class="date-time-table" style="color: #FFFFFF; background: #000000 url('/res/img/ui-bg_loop_25_000000_21x21.png') 50% 50% repeat;">
				<tbody>
					<tr>
						<td>열차종류</td>
						<td>
							<select id="trainKndSelect" style="width: 100%;">
								<option value="non">선택</option>
	   							<c:forEach var="value" items="${commonCodeList}">
		   							<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
	   							</c:forEach>
	   						</select>
						</td>
						<td>승차일자</td>
						<td>
							<select id="year" onchange="setDateTime();" style="width: 65px;">
   								<c:forEach var="i" begin="1980" end="2060" step="1">
   									<option value="${i}">${i}</option>
   								</c:forEach>
   							</select>
						</td>
						<td>년</td>
						<td>
							<select id="month" onchange="setDateTime();" style="width: 55px;">
   								<c:forEach var="month" begin="1" end="12">
   									<c:if test="${month < 10}">
		   								<option value="0${month}">0${month}</option>
	   								</c:if>
	   								<c:if test="${month > 9}">
		   								<option value="${month}">${month}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
						</td>
						<td>월</td>
						<td>
							<select id="date" style="width: 55px;">
   								<!-- script -->
   							</select>
						</td>
						<td>일</td>
						<td>
							<button onclick="findTcktRcrdList();" type="button">조회</button>
						</td>
					</tr>
				</tbody>
			</table>
   		</div> <!-- search-group end -->
   		
   		<!-- 그리드 -->
   		<div id="grid" style="margin-top: 7px; clear: left;">
   			<table id="gridBody"></table>
   		</div>
	</body>
</html>