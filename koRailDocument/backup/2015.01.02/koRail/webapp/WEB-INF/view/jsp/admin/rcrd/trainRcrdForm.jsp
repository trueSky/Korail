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
   			var seatArray = "";		/* 좌석정보 */
   			
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
	   				caption:"열차별 승객 현황",
	   				width: 845,
	   				height: 305,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["번호", "예약자명", "좌석",  "경로/장애인/어린이", "총 인원수", "영수금액", "결제상태", "사용포인트", "할인금액", "결제금액"],
	          		colModel : [
						{ name : "rowNum", width: 60, align:"center", sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=10';
							}
						},
						{ name : "register", width: 70, align:"center", sortable:false},
						{ name : 'seat', width: 70, align:"center", sortable:false},
						{ name : 'edcco', width: 130, align:"center", sortable:false},
						{ name : 'resveCo', width: 70, align:"center", sortable:false},
						{ name : 'allRcptAmount', width: 120, align:"right", sortable:false},
						{ name : 'setelSttus', width: 60, align:"center", sortable:false},
						{ name : 'usePint', width: 120, align:"right", sortable:false},
						{ name : 'dscntAmount', width: 120, align:"right", sortable:false},
						{ name : 'setleAmount', width: 120, align:"right", sortable:false}
					]
				}); /*jqGrid end
			
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").jqGrid('addRowData', 1, {rowNum:"조회조건을 선택하여 조회를 하십시오."});
	   		}
	   		
	   		/* 열차벼 승객 현황 조회 */
	   		function findTrainRcrdList(){
	   			/* 초기화 */
	   			seatArray = new Array();
	   			
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
					url: "/admin/trainRcrdList.do?srcType="
							+trainKndCode+"&srcDate1="+tcktTm,
					Type:"JSON",
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
					   				height: 305,
					   				scroll: 1,
					   				rowNum : 'max',
					   				pager: '#footer',
					   				colNames:["번호", "예약자명", "좌석",  "경로/장애인/어린이", "총 인원수", "영수금액", "결제상태", "사용포인트", "할인금액", "결제금액"],
					          		colModel : [
										{ name : "rowNum", width: 60, align:"right", sortable:false},
										{ name : "register", width: 70, align:"center", sortable:false},
										{ name : 'seat', width: 70, align:"center", sortable:false},
										{ name : 'edcco', width: 130, align:"center", sortable:false},
										{ name : 'resveCo', width: 70, align:"center", sortable:false},
										{ name : 'allRcptAmount', width: 120, align:"right", sortable:false},
										{ name : 'setelSttus', width: 60, align:"center", sortable:false},
										{ name : 'usePint', width: 120, align:"right", sortable:false},
										{ name : 'dscntAmount', width: 120, align:"right", sortable:false},
										{ name : 'setleAmount', width: 120, align:"right", sortable:false}
									]
								}); /*jqGrid end*/
				   			} /* if end */
							
							/*그리드 비우기*/
							$("#gridBody").jqGrid('clearGridData');
							
							/* 데이터 추가 */
							$.each(data.trainRcrdList, function(k, v){
								$("#gridBody").jqGrid('addRowData', k,
									{
										rowNum:(k+1),
										register:v.register,
										seat:"<button onclick='setSeatDialog(&quot;"+v.resveCode+"&quot;, &quot;"+v.register+"&quot;)'>좌석보기</button>",
										edcco:v.eldrlyCo+" 명 / "+v.dspsnCo+" 명 / "+v.chldCo+" 명",
										resveCo:v.resveCo+" 명",
										allRcptAmount:v.allRcptAmount+" 원",
										setelSttus:v.setelSttus,
										usePint:v.usePint+" P",
										dscntAmount:v.dscntAmount+" 원",
										setleAmount:v.setleAmount+" 원"
									}
								);
								
								/* 좌석정보 추가 */
								$.each(v.seatList, function(k2, v2){
									seatArray.push(
										{
											resveCode:v.resveCode,
											roomKndCode:v2.roomKndCode,
											room:v2.room+" 호실",
											seatNo:v2.seatNo+" 석"
										}		
									);
								});
							}); /* each end */
						} /* else end */
					} /* success end */
				}); /* ajax end */
	   		} /* findTrainRcrdList end */
	   		
	   		/* 좌석정보 조회 */
	   		function setSeatDialog(resveCode, register){
	   			var count = 0; 		/* 인원수 */

	   			/* 초기화 */
	   			$($("#seatList tbody tr").get(0)).html("");
	   			$($("#seatList tbody tr").get(1)).html("");
	   			
	   			for(var i = 0, i2 = 1; i < seatArray.length; i++, i2++){
	   				if(seatArray[i].resveCode == resveCode){
	   					count++;
	   					
	   					if(i2 < 6){
	   						if(seatArray[i].roomKndCode == "ROOM_Y"){
	   							$($("#seatList tbody tr").get(0)).append(
   									"<td style='background: #65FF5E'>"+seatArray[i].room+"-"+seatArray[i].seatNo+"</td>"		
   			   					);
		   					}else{
		   						$($("#seatList tbody tr").get(0)).append(
			   						"<td style='background: #6CC0FF'>"+seatArray[i].room+"-"+seatArray[i].seatNo+"</td>"		
			   					);
		   					}
		   				}else{
		   					if($($("#seatList tbody tr").get(1)).children("td").size() == 2){
		   						$($("#seatList tbody tr").get(1)).append("<td></td>");
		   					}else{
		   						if(seatArray[i].roomKndCode == "ROOM_Y"){
		   							$($("#seatList tbody tr").get(0)).append(
	   									"<td style='background: #65FF5E'>"+seatArray[i].room+"-"+seatArray[i].seatNo+"</td>"		
	   			   					);
			   					}else{
			   						$($("#seatList tbody tr").get(0)).append(
				   						"<td style='background: #6CC0FF'>"+seatArray[i].room+"-"+seatArray[i].seatNo+"</td>"		
				   					);
			   					}
		   					}
		   				} /* else end */
	   				} /* if end */
	   			} /* for end */
	   			
	   			/* 값 설정 */
	   			$("#count").html(count);
	   			$("#register").html(register);
	   			
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
			* 열차종류와 승차일자를 선택하여 해당하는 열차별 승객 현황을 조회할 수 있습니다.
   			<br>
   			* 경로, 장애인 표기방법 : 경로대상자 / 장애인 / 어린이 순 입니다.
   			<br>
   			* 총 인원수는 일반인 + 장애인 + 경로대상자 + 어린이의 수를 합산한 값 입니다.
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
			<div style="width: 250px; margin: 0 auto;">
				<table class="d-table" style="width: 250px; margin-bottom: 15px;">	
					<colgroup>
						<col width="25%">
						<col width="25%">
						<col width="25%">
						<col width="25%">
					</colgroup>
					<tbody>
						<tr height="25px">
							<td class="head" style="font-size: 12px; font-weight: bold;">예약자</td>
							<td id="register" style="font-size: 12px; font-weight: bold;"></td>
							<td class="head" style="font-size: 12px; font-weight: bold;">인원수</td>
							<td id="count" style="font-size: 12px; font-weight: bold;"></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 좌석 -->
			<table id="seatList">
				<tbody>
					<tr></tr>
					<tr></tr>
				</tbody>
			</table>
			
			<!-- 기타 -->
			<div style="float: right; width: 150px; text-align: center; margin-top: 15px;">
				<div style="border-radius: 7px; float: left; width: 50px; margin-right: 10px; padding: 10px; background: #65FF5E; font-size: 12px; font-weight: bold;">특실</div>
				<div style="border-radius: 7px; float: left; width: 50px; background: #6CC0FF; padding: 10px; font-size: 12px; font-weight: bold;">일반실</div>
			</div>
		</div>
	</body>
</html>