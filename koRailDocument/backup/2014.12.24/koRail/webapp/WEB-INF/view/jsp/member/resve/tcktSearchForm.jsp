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
		</style>
	
   		<script type="text/javascript">
   			var viewState = false; /* 그리드 생성싱테 : true 생성됨, false 생성되 않음 */
   		
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(1)).addClass("set");
				$($(".lmb tr").get(0)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual01.jpg");
				
				/* 날짜설정 */
				setYear();
				
				/* 초기그리드 */
				doGridInit();
	   		});
	   		
	   		/* 년도 설정 : 년도는 현재년도와 다음년도를 선택할수 있다. */
	   		function setYear(dateTime){
	   			var dateTime = new Date();
	   			
	   			$("#year").html("");
   				$("#year").append('<option value="'+dateTime.getFullYear()+'">'+new Date().getFullYear()+'</option>');
   				$("#year").append('<option value="'+(dateTime.getFullYear()+1)+'">'+(new Date().getFullYear()+1)+'</option>');
	   		
   				/* 날짜 설정 */
   				setDateTime();
   				
   				/* 현재날짜 자동선택 */
   				$("#month").children("option[value="+(dateTime.getMonth()+1)+"]").attr("selected", "selected");
   				$("#date").children("option[value="+dateTime.getDate()+"]").attr("selected", "selected");
   				$("#hh24").children("option[value="+dateTime.getHours()+"]").attr("selected", "selected");
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
	   			/*그리드 초기화*/
				$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
   				
				$("#gridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"상세운행일정 정보",
	   				width: 845,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["열차번호", "열치종류",  "출발역", "출발시각", "도착역", "도착시각", "특실", "일반실", "요금"],
	          		colModel : [
						{ name : 'trainNo', width: 70, align:"center", sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=9';
							}
						},
						{ name : 'trainKnd', width: 90, align:"center", sortable:false},
						{ name : 'startStatnValue', width: 70, align:"center", sortable:false},
						{ name : 'startTm', width: 120, align:"center", sortable:false},
						{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
						{ name : 'arvlStatnTm', width: 120, align:"center", sortable:false},
						{ name : 'prtclrRoomY', width: 70, align:"center", sortable:false},
						{ name : 'prtclrRoomN', width: 70, align:"center", sortable:false},
						{ name : 'fare', width: 70, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
			
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").jqGrid('addRowData', 1, {trainNo:"승차권을 조회하시기 바랍니다."});
	   		}
	   		
	   		/* 역 검색 다이알로그 */
   			function setStatnDialog(type){
   				/*input 초기화*/
   				$("#dStatnName").val("");
   				$("#rowData1").val("");
				$("#rowData2").val("");
   				
   				/*그리드 초기화*/
				$("#statnGrid").html("<table id='statnGridBody'></table>");
   				
				$("#statnGridBody").jqGrid({
					datatype: "LOCAL",
					caption:"역 정보",
		   			width: 320,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				colNames:["선택", "역 코드", "역 명"],
	          		colModel : [
						{ name : "select", width: 20, align:"center", sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=3';
							}
						},						
						{ name : "statnCode", hidden:true},
						{ name : "statnNm", width: 70, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
				
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#statnGridBody").jqGrid('addRowData', 1, {select:"역 명으로 역을 검색할수 있습니다."});
   				
   				/*다이알로그*/
   				$("#statnDialog").dialog({
   					modal: true,
   					width: 350,
					buttons: {
						"등록": function() {
							if($("#rowData1").val() == ""){
								alert("역을 선택해야 합니다.");
							}else{
								/* 출발역 */
								if(type == "start"){
									$("#startStatnCode").val($("#rowData1").val());
									$("#startStatnValue").val($("#rowData2").val());
								}
								/* 도착역 */
								else{
									$("#arvlStatnCode").val($("#rowData1").val());
									$("#arvlStatnValue").val($("#rowData2").val());
								}
								
								$(this).dialog("close");	
							}
						},
						"취소": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
   			}
	   		
   			/* 역 검색 */
   			function findStatnList(){
   				/* 미입력 처리 */
				if($("#dStatnName").val().replace(" ", "") == ""){
					alert("검색할 역 명을 입력헤야 합니다.");
					return;
				}
				/*그리드 내용*/
				else{
					$.ajax({
						type:"GET",
						url: "/admin/statnList.do?srcText="+encodeURIComponent($("#dStatnName").val().replace(" ", "")),
						Type:"JSON",
						success : function(data) {
							if(data.statnListSize == 0){
								alert("결과가 존재하지 않습니다.");
							}else{
								/*그리드 초기화*/
								$("#statnGrid").html("<table id='statnGridBody'></table>");
									
								$("#statnGridBody").jqGrid({
									datatype: "LOCAL",
						   			caption:"역 정보",
						   			width: 320,
					   				height: 160,
					   				scroll: 1,
					   				rowNum : 'max',
					   				colNames:["선택", "역 코드", "역 명"],
					          		colModel : [
										{ name : "select", width: 20, align:"center", sortable:false},
										{ name : "statnCode", hidden:true},
										{ name : "statnNm", width: 70, align:"center", sortable:false}
									],
									/*row click*/
									onCellSelect :function(rowId,indexColumn,cellContent,eventObject){
										/*값 설정*/
										var statnCode = $(this).getRowData(rowId).statnCode;
										var statnName = $(this).getRowData(rowId).statnNm;
										
										/*라이도 버튼 자동선택*/
										$("input[value='"+statnCode+"']").click();
										
										$("#rowData1").val(statnCode);
										$("#rowData2").val(statnName);
									}
								}); /*jqGrid end*/
								
								/*데이터 삽입*/
								$.each(data.statnList, function(k,v){
									$("#statnGridBody").jqGrid('addRowData', k+1,
										{
											select:'<input type="radio" name="statnCode" value="'+v.statnCode+'">',
											statnCode:v.statnCode+"",
											statnNm:v.statnNm+""
										}
									); /*addRowData end*/
								}); /*$.each end*/
							} /*if end*/
						} /*success end*/
					}); /*$.ajax end*/
				} /*else end*/
   			}
	   		
	   		/* 승차권 예매를 위한 운행일정 조회 */
	   		function findTcktList(){
	   			/* 열차종류 */
	   			var trainKndCode = $("#trainKndSelect").val();
	   			/* 좌석수 */
	   			var seatCo = 0;
	   			for(var i = 1; i < 6; i++){
	   				seatCo += parseFloat($("#seatCoSelect"+i).val());	
	   			}
	   			/* 출발일 */
	   			var startTm = $("#year").val()+"-"+$("#month").val()+"-"+$("#date").val()+" "+$("#hh24").val();
	   			/*출발역*/
	   			var startStatn = $("#startStatnCode").val();
	   			/*도착역*/
	   			var arvlStatn = $("#arvlStatnCode").val();
	   			
	   			/* 검색조건 확인 */
	   			if(seatCo == 0){
	   				alert("인원수는 최소 1명 이상 선택해야 합니다.");
	   				return;
	   			}else if(seatCo > 9){
	   				alert("윈원수는 최대 9명까지 선택가능 합니다.");
	   				return;
	   			}else if(startStatn == ""){
	   				alert("출발역을 입력하셔야 합니다.");
	   				return;
	   			}else if(arvlStatn == ""){
	   				alert("도착역을 입력하셔야 합니다.");
	   				return;
	   			}
	   			
	   			/* 그리드 생성싱테에 따른 그리드 생성 */
	   			if(!viewState){
	   				/*그리드 초기화*/
					$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
	   				
					$("#gridBody").jqGrid({
						datatype: "LOCAL",
		   				caption:"상세운행일정 정보",
		   				width: 845,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer',
		   				colNames:["열차번호", "열치종류",  "출발역", "출발시각", "도착역", "도착시각", "특실", "일반실", "요금"],
		          		colModel : [
							{ name : 'trainNo', width: 70, align:"center", sortable:false},
							{ name : 'trainKnd', width: 90, align:"center", sortable:false},
							{ name : 'startStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'startTm', width: 120, align:"center", sortable:false},
							{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'arvlTm', width: 120, align:"center", sortable:false},
							{ name : 'prtclrRoomY', width: 70, align:"center", sortable:false},
							{ name : 'prtclrRoomN', width: 70, align:"center", sortable:false},
							{ name : 'fare', width: 90, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
	   			} /* if end */
	   			
	   			/*그리드 내용*/				
				$.ajax({
					type:"POST",
					url: "/member/tcktList.do?trainKndCode="
							+trainKndCode+"&seatCo="
							+seatCo+"&startTm="
							+startTm+"&startStatnCode="
							+startStatn+"&arvlStatnCode="
							+arvlStatn,
					Type:"JSON",
					success : function(data) {
						if(data.tcktListSize == 0){
							alert("조회된 결과가 없습니다.");
							return;
						}else{
							$.each(data.tcktList, function(k, v){
								/* 예약 버튼 */
								var yButton = "";
								var nButton = "";
								
								/* 예약가능 확인 */
								if(v.prtclrSeatYCo == v.prtclrRoomYCo){
									yButton = "<button class='sell-out'>매진</button>";
								}else{
									yButton = "<button onclick='alert("+v.prtclrRoomYCo+");'>예약하기</button>";
								}
								
								/* 예약가능 확인 */
								if(v.prtclrSeatNCo == v.prtclrRoomNCo){
									nButton = "<button class='sell-out'>매진</button>";
								}else{
									nButton = "<button onclick='alert("+v.prtclrRoomNCo+");'>예약하기</button>";
								}
								
								$("#gridBody").jqGrid('addRowData', k,
									{
										trainNo:v.trainNo,
										trainKnd:v.trainKndValue,
										startStatnValue:v.startStatnValue,
										startTm:v.startTm,
										arvlStatnValue:v.arvlStatnValue,
										arvlTm:v.arvlTm,
										prtclrRoomY:yButton,
										prtclrRoomN:nButton,
										fare:v.fare+" 원"
									}
								);
							}); /* each end */
						} /* else end */
					} /* success end */
				}); /* ajax end */
	   		} /* findTcktList end */
   		</script>
	</head>
	<body>
		<div style="font-size: 35px; padding-bottom: 15px;">
   			<strong>
   				${menuTree[3]}
   			</strong>
   		</div>
	
		<!-- 사용방법 -->
   		<div class="caption" style="margin-bottom: 0px;">
			* 아이디 또는 성명으로 회원을 회원을 조회할 수 있습니다.
			<br>
			* 날짜검색을 통해 가입일 또는 개인정보 수정일을 조회할 수 있습니다.
			<br>
			* 모곡을 선택하여 회원정보를 삭제할 수 있습니다.
			<br>
			* 특정행을 선택하면 그 행에 대한 상세 정보를 볼 수 있습니다.
   		</div>
   		
   		<!-- search-group -->
   		<div style="width: 650px; margin: 0 auto;">
   			<!-- 인원정보 -->
   			<div style="width: 320px; margin-right: 10px; float: left;">
	   			<table class="d-table" style="width: 100%; height: 120px;">
	   				<colgroup>
	   					<col width="50%">
	   					<col width="50%">
	   				</colgroup>
	   				<thead>
	   					<tr>
	   						<td colspan="2">인원정보</td>
	   					</tr>
	   				</thead>
	   				<tbody>
	   					<tr>
	   						<td>일반</td>
	   						<td>장애인</td>
	   					</tr>
	   					<tr>
	   						<td>
	   							<select id="seatCoSelect1" style="width: 95%;">
	   								<c:forEach var="i" begin="0" end="9" step="1">
	   									<c:choose>
	   										<c:when test="${i == 1}">
	   											<option value="${i}" selected="selected">어른 ${i}명</option>
	   										</c:when>
	   										<c:otherwise>
	   											<option value="${i}">어른 ${i}명</option>
	   										</c:otherwise>
	   									</c:choose>
	   								</c:forEach>
	   							</select>
	   						</td>
	   						<td>
	   							<select id="seatCoSelect2" style="width: 95%;">
	   								<c:forEach var="i" begin="0" end="9" step="1">
	   									<option value="${i}">장애 1~3 급 ${i}명</option>
									</c:forEach>
	   							</select>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>
	   							<select id="seatCoSelect3" style="width: 95%;">
	   								<c:forEach var="i" begin="0" end="9" step="1">
	   									<option value="${i}">어린이 ${i}명</option>
	   								</c:forEach>
	   							</select>
	   						</td>
	   						<td>
	   							<select id="seatCoSelect4" style="width: 95%;">
	   								<c:forEach var="i" begin="0" end="9" step="1">
	   									<option value="${i}">장애 4-6 급 ${i}명</option>
	   								</c:forEach>
	   							</select>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>
	   							<select id="seatCoSelect5" style="width: 95%;">
	   								<c:forEach var="i" begin="0" end="9" step="1">
	   									<option value="${i}">경로 ${i}명</option>
	   								</c:forEach>
	   							</select>
	   						</td>
	   						<td></td>
	   					</tr>
	   				</tbody>
	   			</table>
	   		</div>

   			<!-- 운행정보 -->
   			<div style="width: 320px; float: left;">
	   			<table class="d-table" style="width: 100%; height: 120px;">
	   				<colgroup>
	   					<col width="50%">
	   					<col width="50%">
	   				</colgroup>
	   				<thead>
	   					<tr>
	   						<td colspan="2">운행정보</td>
	   					</tr>
	   				</thead>
	   				<tbody>
	   					<tr>
	   						<td>열차종류</td>
	   						<td>
	   							<select id="trainKndSelect" style="width: 95%;">
	   								<option value="ALL">전채</option>
	   								<c:forEach var="value" items="${commonCodeList}">
		   								<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
	   								</c:forEach>
	   							</select>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>여정경로</td>
	   						<td>
	   							<select style="width: 95%;">
	   								<option>직통</option>
	   							</select>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>출발역</td>
	   						<td>
	   							<input id="startStatnCode" type="hidden" disabled="disabled" style="width: 60%;">
	   							<input id="startStatnValue" type="text" disabled="disabled" style="width: 60%;">
	   							<button onclick="setStatnDialog('start')" style="width: 30%;">검색</button>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>도착역</td>
	   						<td>
	   							<input id="arvlStatnCode" type="hidden" disabled="disabled" style="width: 60%;">
	   							<input id="arvlStatnValue" type="text" disabled="disabled" style="width: 60%;">
	   							<button onclick="setStatnDialog('arvl')" style="width: 30%;">검색</button>
	   						</td>
	   					</tr>
	   				</tbody>
	   			</table>
   			</div>
   			
   			<!-- 날짜 -->
			<div style="clear: left; padding-top: 10px;">
	   			<table class="date-time-table" style="color: #FFFFFF; background: #000000 url('/res/img/ui-bg_loop_25_000000_21x21.png') 50% 50% repeat;">
					<tbody>
						<!-- 날짜 선택 -->
						<tr>
							<td>출발시각</td>
							<td>
								<select id="year" onchange="setDateTime();" style="width: 65px;">
	   								<!-- script -->
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
								<select id="hh24" style="width: 55px;">
	   								<c:forEach var="hh24" begin="0" end="23">
	   									<c:if test="${hh24 < 10}">
			   								<option value="0${hh24}">0${hh24}</option>
		   								</c:if>
		   								<c:if test="${hh24 > 9}">
			   								<option value="${hh24}">${hh24}</option>
		   								</c:if>
		   							</c:forEach>
	   							</select>
							</td>
							<td>시</td>
						</tr>
					</tbody>
				</table>
	   		</div>
	   		
	   		<!-- 조회 -->
	   		<div style="text-align: center; margin-top: 7px; clear: left;">
	   			<button onclick="findTcktList();" style="width: 60px;">조회</button>
	   		</div>
   		</div> <!-- search-group end -->
   		
   		<!-- 그리드 -->
   		<div id="grid" style="margin-top: 7px; clear: left;">
   			<table id="gridBody"></table>
   		</div>
   		
   		<!-- statnDialog -->
		<div id="statnDialog" title="역 검색" style="display: none;">
   			<table style=" margin: 0 auto; border-collapse: collapse;">
				<tbody>
					<tr>
						<td style="border: 1px solid #FFFFFF; padding: 5px; font-weight: bolder;">역 명</td>
						<td style="border: 1px solid #FFFFFF;">
							<input id="dStatnName" type="text" style="height: 26px;">
						</td>
						<td style="border: 1px solid #FFFFFF;">
							<button id="statnBtn" onclick="findStatnList();" type="button" style="width: 100%;">검색</button>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div id="statnGrid" style="margin-top: 10px;">
				<table id="statnGridBody" style="margin: 0 auto;"></table>
			</div>
		</div> <!-- statnDialog -->
		
		<div id="hiddenData">
			<input id="rowData1" type="hidden">
			<input id="rowData2" type="hidden">
		</div>
	</body>
</html>