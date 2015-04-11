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
				
				/* 화면 로드 시 자동조회 */
				findTcktRcrdList();
	   		});
	   		
	   		/* 날짜설정1 */
	   		function setYear(){
	   			/* 현제날짜 */
	   			var date = new Date();
	   			
	   			/* 초기화 */
   				$("#startYear").html("");
   				$("#endYear").html("");
   				$("#startDate").val("");
   				$("#endDate").val("");
   				
   				/* 년도 설정 : 년도는 현재년도와 다음년도를 선택할수 있다. */
   				for(var i = (date.getFullYear()-30); i < (date.getFullYear()+60); i++){
   					$("#startYear").append('<option value="'+i+'">'+i+'</option>');
   					$("#endYear").append('<option value="'+i+'">'+i+'</option>');
   				}
   				/* 현재년도 자동선택 */
   				$("#startYear").children("option[value='"+date.getFullYear()+"']").attr("selected", "selected");
	   			$("#endYear").children("option[value='"+date.getFullYear()+"']").attr("selected", "selected");
   				
   				/* 현재 월 선택 */
   				if((date.getMonth()+1) < 10){
   					$("#startMonth").children("option[value='0"+(date.getMonth()+1)+"']").attr("selected", "selected");
   	   				$("#endMonth").children("option[value='0"+(date.getMonth()+1)+"']").attr("selected", "selected");
   				}else{
   					$("#startMonth").children("option[value='"+(date.getMonth()+1)+"']").attr("selected", "selected");
   	   				$("#endMonth").children("option[value='"+(date.getMonth()+1)+"']").attr("selected", "selected");
   				}
	   			
   				/* 날짜설정 */
   				setDate("all");
   				
   				/*현재 월의 01~마지막 일 자동선택*/
   				$("#startDate :first").attr("selected", "selected");
   				$("#endDate :last").attr("selected", "selected");
	   		}
	   		
	   		/* 날짜설정2 */
	   		function setDate(mode){
	   			/* 시작날짜 설정 */
	   			if(mode == "start" || mode == "all"){
	   				/* 년과 월에 대한 날짜 */
	   				var newStartDate = new Date($("#startYear").val(), $("#startMonth").val(), "");
	   				/*현재 선택된 날짜*/
	   				var oldStartDate = $("#startDate").val();
	   				
	   				$("#startDate").html("");
	   				
	   				for(var i = 1; i <= newStartDate.getDate(); i++){
	   					if(i < 10){
	   	   					$("#startDate").append('<option value="0'+i+'">0'+i+'</option>');   						
	   					}else{
	 	  					$("#startDate").append('<option value="'+i+'">'+i+'</option>');
	   					}
	   				}
	   				
	   				/*선택한 날짜 유지*/
	   				if(oldStartDate != null){
	   					$("#startDate").children("option[value='"+oldStartDate+"']").attr("selected", "selected");	
	   				}
	   			}
				/* 끝 날짜 설정 */
	   			if(mode == "end" || mode == "all"){
	   				/* 년과 월에 대한 날짜 */
	   				var newEndDate = new Date($("#endYear").val(), $("#endMonth").val(), "");
	   				/*현재 선택된 날짜*/
	   				var oldEndDate = $("#endDate").val();
	   				
	   				$("#endDate").html("");
	   				
	   				for(var i = 1; i <= newEndDate.getDate(); i++){
	   					if(i < 10){
	   	   					$("#endDate").append('<option value="0'+i+'">0'+i+'</option>');   						
	   					}else{
	 	  					$("#endDate").append('<option value="'+i+'">'+i+'</option>');
	   					}
	   				}
	   				
	   				/*선택한 날짜 유지*/
	   				if(oldEndDate != null){
	   					$("#endDate").children("option[value='"+oldEndDate+"']").attr("selected", "selected");
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
	   				height: 315,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["번호", "승차일자", "열차번호", "열치종류",  "출발역", "출발시각", "도착역", "도착시각", "특실발권", "일반실발권"],
	          		colModel : [
						{ name : "no", width: 70, align:"center", sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=10';
							}
						},
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
			
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").jqGrid('addRowData', 1, {no:"조회된 결과가 존재하지 않습니다."});
	   		}
	   		
	   		/* 승차권 발권 현황 조회 */
	   		function findTcktRcrdList(){
	   			/* 열차종류 */
	   			var trainKndCode = $("#trainKndSelect").val();
	   			/* 조회일자 */
	   			var startTm = $("#startYear").val()+"-"+$("#startMonth").val()+"-"+$("#startDate").val();
	   			var endTm = $("#endYear").val()+"-"+$("#endMonth").val()+"-"+$("#endDate").val();
	   			
	   			/*그리드 내용*/				
				$.ajax({
					type:"POST",
					url: "/admin/tcktRcrdList.do",
					Type:"JSON",
					data:{
						trainKndCode:trainKndCode,
						srcDate1:startTm,
						srcDate2:endTm
					},
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
					   				height: 315,
					   				scroll: 1,
					   				rowNum : 'max',
					   				pager: '#footer',
					   				colNames:["번호", "승차일자", "열차번호", "열치종류",  "출발역", "출발시각", "도착역", "도착시각", "특실발권", "일반실발권"],
					          		colModel : [
										{ name : 'no', width: 30, align:"right", sortable:false},
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
								$("#gridBody").addRowData(
									k,
									{
										no:k+1,
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
					}, /*success end*/
					error : function(request, status, error){
						if(request.status == 401){
							alert("세션이 만료되었습니다.");
							location.href = "/login.html";
						}else{
							alert("서버에러입니다.");
						}
					}
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
			<div>* 열차종류와 조회일자를 선택하여 해당하는 승차권 발권 현황을 조회할 수 있습니다.</div>
   			<div>* 특실발권, 일반실발권 표기방법 : 예약된 좌석수 / 총 좌석수</div>
   		</div>
   		
   		<!-- search-group -->
   		<div style="margin: 0 auto;">
   			<table class="date-time-table" style="color: #FFFFFF; background: #000000 url('/res/img/ui-bg_loop_25_000000_21x21.png') 50% 50% repeat;">
				<tbody>
					<tr>
						<td>
							<select id="trainKndSelect" style="width: 60px;">
								<option value="ALL">전체</option>
	   							<c:forEach var="value" items="${commonCodeList}">
		   							<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
	   							</c:forEach>
	   						</select>
							<select id="startYear" onchange="setDate('start');" style="width: 75px;">
   								<!-- script -->
   							</select>
   							<label>년</label>
   							<select id="startMonth" onchange="setDate('start');" style="width: 55px;">
   								<c:forEach var="month" begin="1" end="12">
   									<c:if test="${month < 10}">
		   								<option value="0${month}">0${month}</option>
	   								</c:if>
	   								<c:if test="${month > 9}">
		   								<option value="${month}">${month}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
   							<label>월</label>
   							<select id="startDate" style="width: 55px;">
   								<!-- script -->
   							</select>
   							<label>일</label>
							<label style="margin-left: 15px; margin-right: 15px;">~</label>
							<select id="endYear" onchange="setDate('end');" style="width: 75px;">
   								<!-- script -->
   							</select>
   							<label>년</label>
   							<select id="endMonth" onchange="setDate('end');" style="width: 55px;">
   								<c:forEach var="month" begin="1" end="12">
   									<c:if test="${month < 10}">
		   								<option value="0${month}">0${month}</option>
	   								</c:if>
	   								<c:if test="${month > 9}">
		   								<option value="${month}">${month}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
   							<label>월</label>
   							<select id="endDate" style="width: 55px;">
   								<!-- script -->
   							</select>
   							<label>일</label>
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