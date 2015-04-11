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
				$(".lmb tr").eq(1).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual10.jpg");
				
				/*날짜생성*/
				for(var i = (date.getFullYear()-50); i <= (date.getFullYear()+50); i++){
					$("#year").append("<option value='"+i+"'>"+i+"</option>");
				}
				/*자동선택*/
				$("#year").children("option[value='"+date.getFullYear()+"']").attr("selected", "selected");
				if((date.getMonth()+1) < 10){
					$("#month").children("option[value='0"+(date.getMonth()+1)+"']").attr("selected", "selected");
				}else{
		   			$("#month").children("option[value='"+(date.getMonth()+1)+"']").attr("selected", "selected");
				}
				
	   			/*검색*/
				$("#searchBtn").click(function(){
					doSearch();
				});
				
				/*현재 날짜로 자동검색*/
				$("#searchBtn").click();
   			});
   			
   			/* No data found */
	   		function doGridInit(type){
   				/*승차권 예매 내역*/
	   			if(type == "resveRcrd"){
	   				viewState1 = false;
		   			
		   			/*그리드 초기화*/
					$("#grid1").html("<table id='gridBody1'></table><div id='footer1'></div>");
	   				
					$("#gridBody1").jqGrid({
						datatype: "LOCAL",
		   				caption:"승차권 예매 내역",
		   				width: 845,
		   				height: 112,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer1',
		   				colNames:["번호", "열차번호", "열치종류", "출발역", "출발시각", "도착역", "도착시각", "예약매수", "결제상태"],
		          		colModel : [
							{ name : 'no', width: 30, align:"center", sortable:false,
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=10';
								}
							},
   							{ name : 'trainNo', width: 60, align:"center", sortable:false},
   							{ name : 'trainKnd', width: 50, align:"center", sortable:false},
   							{ name : 'startStatn', width: 60, align:"center", sortable:false},
   							{ name : 'startTm', width: 80, align:"center", sortable:false},
   							{ name : 'arvlStatn', width: 60, align:"center", sortable:false},
   							{ name : 'arvlTm', width: 80, align:"center", sortable:false},
   							{ name : 'resveCo', width: 40, align:"center", sortable:false},
   							{ name : 'setleSttus', width: 40, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
				
					/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
					$("#gridBody1").jqGrid('addRowData', 1, {no:"조회된 결과가 없습니다."});
	   			}
	   			
	   			/*포인트 사용 내역*/
   				if(type == "pint"){
					viewState2 = true;
   		   			
   		   			/*그리드 초기화*/
   					$("#grid2").html("<table id='gridBody2'></table><div id='footer2'></div>");
   	   				
   					$("#gridBody2").jqGrid({
   						datatype: "LOCAL",
   		   				caption:"포인트 사용 내역",
   		   				width: 845,
   		   				height: 112,
   		   				scroll: 1,
   		   				rowNum : 'max',
   		   				pager: '#footer2',
   		   				colNames:["번호", "거레일자", "유형", "승차내역", "결제금액", "사용포인트", "적립포인트"],
   		          		colModel : [
   							{ name : 'no', width: 40, align:"center", sortable:false,
   								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=7';
								}
   							},
   							{ name : 'useDe', width: 50, align:"center", sortable:false},
							{ name : 'pintUseYn', width: 30, align:"center", sortable:false},
   							{ name : 'useHistry', width: 100, align:"center", sortable:false},
   							{ name : 'setleAmount', width: 60, align:"right", sortable:false},
   							{ name : 'usePint', width: 50, align:"right", sortable:false},
   							{ name : 'svPint', width: 50, align:"right", sortable:false}
   						]
   					}); /*jqGrid end*/
   					
   					/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
					$("#gridBody2").jqGrid('addRowData', 1, {no:"조회된 결과가 없습니다."});
   				}
	   		}
   			
   			/*data input*/
   			function setGrid(type){
   				/*승차권 예매 내역*/
   				if(type == "resveRcrd"){
   					viewState1 = true;
   		   			
   		   			/*그리드 초기화*/
   					$("#grid1").html("<table id='gridBody1'></table><div id='footer1'></div>");
   	   				
   					$("#gridBody1").jqGrid({
   						datatype: "LOCAL",
   		   				caption:"승차권 예매 내역",
   		   				width: 845,
   		   				height: 112,
   		   				scroll: 1,
   		   				rowNum : 'max',
   		   				pager: '#footer1',
   		   				colNames:["번호", "열차번호", "열치종류", "출발역", "출발일시", "도착역", "도착일시", "예약매수", "결제상태"],
   		          		colModel : [
   							{ name : 'no', width: 30, align:"right", sortable:false},
   							{ name : 'trainNo', width: 60, align:"center", sortable:false},
   							{ name : 'trainKnd', width: 50, align:"center", sortable:false},
   							{ name : 'startStatn', width: 60, align:"center", sortable:false},
   							{ name : 'startTm', width: 80, align:"center", sortable:false},
   							{ name : 'arvlStatn', width: 60, align:"center", sortable:false},
   							{ name : 'arvlTm', width: 80, align:"center", sortable:false},
   							{ name : 'resveCo', width: 40, align:"center", sortable:false},
   							{ name : 'setleSttus', width: 40, align:"center", sortable:false}
   						]
   					}); /*jqGrid end*/
   				}
   				/*포인트 사용 내역*/
   				if(type == "pint"){
					viewState2 = true;
   		   			
   		   			/*그리드 초기화*/
   					$("#grid2").html("<table id='gridBody2'></table><div id='footer2'></div>");
   	   				
   					$("#gridBody2").jqGrid({
   						datatype: "LOCAL",
   		   				caption:"포인트 사용 내역",
   		   				width: 845,
   		   				height: 112,
   		   				scroll: 1,
   		   				rowNum : 'max',
   		   				pager: '#footer2',
   		   				colNames:["번호", "거레일자", "유형", "승차내역", "결제금액", "사용포인트", "적립포인트"],
   		          		colModel : [
   							{ name : 'no', width: 40, align:"right", sortable:false},
   							{ name : 'useDe', width: 50, align:"center", sortable:false},
							{ name : 'pintUseYn', width: 30, align:"center", sortable:false},
   							{ name : 'useHistry', width: 100, align:"center", sortable:false},
   							{ name : 'setleAmount', width: 60, align:"right", sortable:false},
   							{ name : 'usePint', width: 50, align:"right", sortable:false},
   							{ name : 'svPint', width: 50, align:"right", sortable:false}
   						]
   					}); /*jqGrid end*/
   				}
   			}
   			
   			/*검색*/
   			function doSearch(){
   				/* 검색일자 */
	   			var srcDate = $("#year").val()+"-"+$("#month").val();
   			
   				if($("#year1").val() == "non" || $("#year2").val() == "non"){
   					alert("조회할 기간을 선택하셔야 합니다.");
   				}else{
   					/*그리드 내용*/
   					$.ajax({
   						type:"POST",
   						url: "/member/useHstrList.do",
   						data: {formType:"hstr", srcType:"${id}", srcDate1:srcDate},
   						Type:"JSON",
   						success : function(data) {
   							/* 승차권 예매 내역 */
   							if(data.resveRcrdListSize == 0){
   								doGridInit("resveRcrd");
   							}else{
   								/* 그리드 생성 */
   								setGrid("resveRcrd");
   	   							/* 데이터 삽입 */
   								$.each(data.resveRcrdList, function(k, v){
   	   								$("#gridBody1").addRowData(
   	   									k,
										{
   	   										no:k+1,
   	   										trainNo:v.trainNo,
   	   										trainKnd:v.trainKnd,
   	   										startStatn:v.startStatn,
   	   										startTm:v.startTm,
   	   										arvlStatn:v.arvlStatn,
   	   										arvlTm:v.arvlTm,
   	   										resveCo:v.resveCo+" 장",
   	   										setleSttus:v.setleSttusValue
										}
   	   								);
   	   							}); /* $.each end */
   							}
   							
   							/* 포인트 사용 내역 */
   							if(data.pintListSize == 0){
   								doGridInit("pint");
   							}else{
   								/*그리드 생성*/
   								setGrid("pint");
   								/*데이터 삽입*/
   								$.each(data.pintList, function(k, v){
   									$("#gridBody2").addRowData(k,
   										{
   											no:k+1,
											useDe:v.useDe,
											pintUseYn:v.pintUseYn,
											useHistry:v.useHistry,
											setleAmount:v.setleAmount+" 원",
	   	   									usePint:v.usePint+" P",
	   	   									svPint:v.svPint+" P"
										}
   	   	   							);
   								});
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
   					}); /* $.ajax end */
   				}
   			}
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
			<div>* 조회기간을 입력하여 승차권 예매 내역, 포인트 사용 내역을 조회할 수 있습니다.</div>
		</div>
		
		<!-- search-group -->
   		<div style="width: 650px; margin: 0 auto;">
   			<table class="date-time-table" style="color: #FFFFFF; background: #000000 url('/res/img/ui-bg_loop_25_000000_21x21.png') 50% 50% repeat;">
				<tbody>
					<tr>
						<td>
							<select id="year" style="width: 65px;">
   								<option value="non">선택</option>
   								<!-- script -->
   							</select>
						</td>
						<td>년</td>
						<td>
							<select id="month" style="width: 55px;">
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
							<button id="searchBtn" type="button">조회</button>
						</td>
					</tr>
				</tbody>
			</table>
   		</div> <!-- search-group end -->
   		
   		<!-- 사용내역 그리드 -->
   		<div id="grid1" style="margin-top: 15px;">
   			<table id="gridBody1"></table>
   			<div id="footer1"></div>
   		</div>
   		
   		<!-- 포인트 -->
   		<div>
   			<table class="d-table">
   				<thead>
   					<tr>
   						<td colspan="3">포인트</td>
   					</tr>
   				</thead>
   				<tbody>
   					<tr>
   						<td class="head">총 정립포인트</td>
   						<td class="head">총 사용포인트</td>
   						<td class="head">현재포인트</td>
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
   		
   		<!-- 포인트 이용내역 -->
   		<div id="grid2" style="margin-top: 15px;">
   			<table id="gridBody2"></table>
   			<div id="footer2"></div>
   		</div>
	</body>
</html>