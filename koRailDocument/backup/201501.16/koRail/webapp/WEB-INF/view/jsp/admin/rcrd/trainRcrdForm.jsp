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
			#seatList td {
				width: 100px;
				padding: 5px;
				background-color: #FFFFFF;
				color: #FFFFFF;
				font-size: 12px;
				font-weight:bold;
				text-align: center;
				border-radius: 7px;
			}
		</style>
		<script type="text/javascript">
   			var viewState = false; 	/* 그리드 생성싱테 : true 생성됨, false 생성되 않음 */
   			var seatArray = null;	/* 좌석정보 */
   			
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(2)).addClass("set");
				$($(".lmb tr").get(1)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tre_c_02.jpg");
				
				/* 날짜설정 */
				setYear();
				
				/* 초기그리드 */
				doGridInit();
				/*자동조회*/
				findTrainRcrdList();
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
	   				caption:"열차별 승객 현황",
	   				width: 845,
	   				height: 296,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["번호", "예매일시", "열차종류", "예약자명", "좌석",  "경로/장애인/어린이", "총 인원수", "영수금액", "결제상태", "사용포인트", "할인금액", "결제금액"],
	          		colModel : [
						{ name : "rowNum", width: 50, align:"center", sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=12';
							}
						},
						{ name : "rgsde", width: 160, align:"center", sortable:false},
						{ name : "trainKnd", width: 70, align:"center", sortable:false},
						{ name : "register", width: 70, align:"center", sortable:false},
						{ name : 'seat', width: 90, align:"center", sortable:false},
						{ name : 'edcco', width: 140, align:"center", sortable:false},
						{ name : 'resveCo', width: 70, align:"center", sortable:false},
						{ name : 'allFrAmount', width: 110, align:"right", sortable:false},
						{ name : 'setelSttus', width: 65, align:"center", sortable:false},
						{ name : 'usePint', width: 80, align:"right", sortable:false},
						{ name : 'dscntAmount', width: 110, align:"right", sortable:false},
						{ name : 'setleAmount', width: 110, align:"right", sortable:false}
					]
				}); /*jqGrid end
			
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").jqGrid('addRowData', 1, {rowNum:"조회된 결과가 존재하지 않습니다."});
	   		}
	   		
	   		/* 열차벼 승객 현황 조회 */
	   		function findTrainRcrdList(){
	   			/* 초기화 */
	   			seatArray = new Array();
	   			
	   			/* 열차종류 */
	   			var trainKndCode = $("#trainKndSelect").val();
	   			/* 조회일자 */
	   			var startTm = $("#startYear").val()+"-"+$("#startMonth").val()+"-"+$("#startDate").val();
	   			var endTm = $("#endYear").val()+"-"+$("#endMonth").val()+"-"+$("#endDate").val();
	   			
	   			/*그리드 내용*/				
				$.ajax({
					type:"POST",
					url: "/admin/trainRcrdList.do",
					Type:"JSON",
					data:{srcType:trainKndCode, srcDate1:startTm, srcDate2:endTm},
					success : function(data) {
						if(data.trainRcrdListSize == 0){
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
					   				caption:"열차별 승객 현황",
					   				width: 845,
					   				height: 296,
					   				scroll: 1,
					   				rowNum : 'max',
					   				pager: '#footer',
					   				colNames:["resveCode", "번호", "예매일시", "열차종류", "예약자명", "좌석",  "경로/장애인/어린이", "총 인원수", "영수금액", "결제상태", "사용포인트", "할인금액", "결제금액"],
					          		colModel : [
										{ name : "resveCode", hidden:true},
										{ name : "rowNum", width: 50, align:"right", sortable:false},
										{ name : "rgsde", width: 160, align:"center", sortable:false},
										{ name : "trainKnd", width: 70, align:"center", sortable:false},
										{ name : "register", width: 70, align:"center", sortable:false},
										{ name : 'seat', width: 90, align:"center", sortable:false},
										{ name : 'edcco', width: 140, align:"center", sortable:false},
										{ name : 'resveCo', width: 70, align:"center", sortable:false},
										{ name : 'allFrAmount', width: 110, align:"right", sortable:false},
										{ name : 'setelSttus', width: 65, align:"center", sortable:false},
										{ name : 'usePint', width: 80, align:"right", sortable:false},
										{ name : 'dscntAmount', width: 110, align:"right", sortable:false},
										{ name : 'setleAmount', width: 110, align:"right", sortable:false}
									]
								}); /*jqGrid end*/
				   			} /* if end */
							
							/*그리드 비우기*/
							$("#gridBody").jqGrid('clearGridData');
							
							/* 데이터 추가 */
							$.each(data.trainRcrdList, function(k, v){
								var tag1 = "";
								var tag2 = "";
								var tag3 = "";
								
								if(v.usePint == null){
									tag1 = "<div style='text-align: center;'>--</div>";
								}else{
									tag1 = v.usePint+" P";
								}
								if(v.dscntAmount == null){
									tag2 = "<div style='text-align: center;'>--</div>";
								}else{
									tag2 = v.dscntAmount+" 원";
								}
								if(v.setleAmount == null){
									tag3 = "<div style='text-align: center;'>--</div>";
								}else{
									tag3 = v.setleAmount+" 원";
								}
								
								/*열차별 승객 현황*/
								$("#gridBody").addRowData(
									k,
									{
										resveCode:v.resveCode,
										rowNum:(k+1),
										rgsde:v.rgsde,
										trainKnd:v.trainKnd,
										register:v.register,
										seat:"<button onclick='setSeatDialog("+k+")'>좌석보기</button>",
										edcco:v.eldrlyCo+" 명 / "+v.dspsnCo+" 명 / "+v.chldCo+" 명",
										resveCo:v.resveCo+" 명",
										allFrAmount:v.allFrAmount+" 원",
										setelSttus:v.setelSttus,
										usePint:tag1,
										dscntAmount:tag2,
										setleAmount:tag3
									}
								);
								
								/* 좌석정보 */
								$.each(v.seatList, function(k2, v2){
									seatArray.push(
										{
											resveCode:v.resveCode,
											roomKndCode:v2.roomKndCode,
											room:v2.room+" 호실",
											seatNo:v2.seatNo+" 석"
										}		
									);
								});/* each end */
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
	   		} /* findTrainRcrdList end */
	   		
	   		/* 좌석정보 조회 */
	   		function setSeatDialog(index){
	   			/*예약코드*/
	   			var resveCode = $("#gridBody").getRowData(index).resveCode;
	   			/* 인원수 */
	   			var count = 0;

	   			/* 초기화 */
	   			$("#seatList tbody").html("<tr></tr>");
	   			
	   			for(var i = 0, i2 = 0; i < seatArray.length; i++){
	   				if(seatArray[i].resveCode == resveCode){
	   					count++;
	   					i2++;
	   					
	   					if(i2 == 6){
	   						$("#seatList tbody").append("<tr></tr>");
	   						i2 = 0;
	   					}
	   					
	   					if(seatArray[i].roomKndCode == "ROOM_Y"){
	   						$("#seatList tr:last").append(
   								"<td style='background: #65FF5E'>"+seatArray[i].room+"-"+seatArray[i].seatNo+"</td>"		
   			   				);
		   				}else{
		   					$("#seatList tr:last").append(
			   					"<td style='background: #6CC0FF'>"+seatArray[i].room+"-"+seatArray[i].seatNo+"</td>"		
			   				);
		   				}
	   				} /* if end */
	   			} /* for end */
	   			
	   			/* 값 설정 */
	   			$("#roomHead td").eq(1).html($("#gridBody").getRowData(index).rgsde);
	   			$("#roomHead td").eq(3).html($("#gridBody").getRowData(index).trainKnd);
	   			$("#roomHead td").eq(5).html($("#gridBody").getRowData(index).register);
	   			$("#roomHead td").eq(7).html(count+" 명");
	   			
	   			/*다이알로그*/
   				$("#seatDialog").dialog({
   					modal: true,
   					width: 570,
					buttons: {
						"확인": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
	   		} /* findSeatInfo end */
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
			<div>* 열차종류와 승차일자를 선택하여 해당하는 열차별 승객 현황을 조회할 수 있습니다.</div>
			<div>* 경로, 장애인 표기방법 : 경로대상자 / 장애인 / 어린이 순 입니다.</div>
   			<div>* 총 인원수는 일반인 + 장애인 + 경로대상자 + 어린이의 수를 합산한 값 입니다.</div>
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
   							<button onclick="findTrainRcrdList();" type="button">조회</button>
						</td>
					</tr>
				</tbody>
			</table>
   		</div> <!-- search-group end -->
   		
   		<!-- 그리드 -->
   		<div id="grid" style="margin-top: 7px; clear: left;">
   			<table id="gridBody"></table>
   		</div>
   		
   		<!-- 좌석정보 -->
   		<div id="seatDialog" title="좌석정보" style="display: none;">
			<!-- 기본정보 -->
			<div>
				<table class="d-table" style="width: 540px; margin-bottom: 15px;">	
					<colgroup>
						<col width="15%">
						<col width="25%">
						<col width="10%">
						<col width="12%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="8%">
					</colgroup>
					<tbody>
						<tr id="roomHead" height="25px">
							<td class="head" style="border-radius: 7px 0px 0px 7px; font-size: 12px; font-weight: bold;">예매일시</td>
							<td style="font-size: 12px; font-weight: bold;"></td>
							<td class="head" style="font-size: 12px; font-weight: bold;">열차종류</td>
							<td style="font-size: 12px; font-weight: bold;"></td>
							<td class="head" style="font-size: 12px; font-weight: bold;">예약자</td>
							<td style="font-size: 12px; font-weight: bold;"></td>
							<td class="head" style="font-size: 12px; font-weight: bold;">인원수</td>
							<td style="border-radius: 0px 7px 7px 0px; font-size: 12px; font-weight: bold;"></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 좌석 -->
			<table id="seatList">
				<tbody></tbody>
			</table>
			
			<!-- 기타 -->
			<div style="float: right; width: 150px; text-align: center; margin-top: 15px;">
				<div style="border-radius: 7px; float: left; width: 50px; margin-right: 10px; padding: 10px; background: #65FF5E; font-size: 12px; font-weight: bold;">특실</div>
				<div style="border-radius: 7px; float: left; width: 50px; background: #6CC0FF; padding: 10px; font-size: 12px; font-weight: bold;">일반실</div>
			</div>
		</div>
	</body>
</html>