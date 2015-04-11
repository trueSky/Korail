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
   			$(document).ready(function(){
	   			/*Action style*/
				$(".menu td").eq(1).addClass("set");
				$(".lmb tr").eq(1).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual12.jpg");
   			
				/*그리드 서렂ㅇ*/
				if(parseInt("${resveRcrdListSize}") == 0){
					setGrid("noData");
				}else{
					setGrid("addData");
				}
   			});
   			
   			/*그리드 설정*/
   			function setGrid(type){
   				/*그리드 초기화*/
				$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
   				
   				/* No data */
   				if(type == "noData"){
   					/*grid*/
					$("#gridBody").jqGrid({
						datatype: "LOCAL",
		   				caption:"승차권 현황",
		   				width: 845,
		   				height: 299,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer',
		   				colNames:["발권현황", "열차번호", "열차종류", "출발역", "출발시각", "도착역", "도착시각", "예약매수", "결제상태", "결제금액", "예매취소"],
		          		colModel : [
							{ name : "tcktRcrd", align:"center", width: 120, height : 200, sortable:false,
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=11';
								}
							},
							{ name : "trainNo", width: 70, align:"center", sortable:false},
							{ name : 'trainKnd', width: 70, align:"center", sortable:false},
							{ name : 'startStatn', width: 110, align:"center", sortable:false},
							{ name : 'startTm', width: 150, align:"center", sortable:false},
							{ name : 'arvlStatn', width: 110, align:"center", sortable:false},
							{ name : 'arvlTm', width: 150, align:"center", sortable:false},
							{ name : 'resveCo', width: 70, align:"center", sortable:false},
							{ name : 'setleSttusValue', width: 80, align:"center", sortable:false},
							{ name : 'setelAmount', width: 110, align:"right", sortable:false},
							{ name : 'resveCancel', width: 80, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
					
					/*Data not found*/
					$("#gridBody").jqGrid('addRowData', 1, {tcktRcrd:"현재 예액된 승차권이 없습니다."});
   				}
   				/* input data */
   				else{
   					/*grid*/
					$("#gridBody").jqGrid({
						datatype: "LOCAL",
		   				caption:"승차권 현황",
		   				width: 845,
		   				height: 299,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer',
		   				colNames:["발권현황", "열차번호", "열차종류", "출발역", "출발시각", "도착역", "도착시각", "예약매수", "결제상태", "결제금액", "예매취소"],
		          		colModel : [
							{ name : "tcktRcrd", width: 120, align:"center", sortable:false},
							{ name : "trainNo", width: 50, align:"center", sortable:false},
							{ name : 'trainKnd', width: 70, align:"center", sortable:false},
							{ name : 'startStatn', width: 110, align:"center", sortable:false},
							{ name : 'startTm', width: 150, align:"center", sortable:false},
							{ name : 'arvlStatn', width: 110, align:"center", sortable:false},
							{ name : 'arvlTm', width: 150, align:"center", sortable:false},
							{ name : 'resveCo', width: 40, align:"center", sortable:false},
							{ name : 'setleSttusValue', width: 80, align:"center", sortable:false},
							{ name : 'setelAmount', width: 110, align:"right", sortable:false},
							{ name : 'resveCancel', width: 80, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
					
					for(var i = 1; i < parseInt("${resveRcrdListSize}")+1; i++){
						var form = $("#dataForm"+i); /*form tag*/
						var tag1 = "";				 /*발권현화: 겔제완료일때만 버튼 활성화*/
						var tag2 = "";				 /*결제상태: 결제완료상태라면 결제완료를 알리는 메세지를 미결제상태라면 결제하기 버튼생성*/
						var tag3 = "";				 /*결제금액: 결제완료상태라면 결제금액을 미결제상태라면 미결제를 알리는 메시지를 출력*/
						
						/* null 처리 */
						if(form.children("input").eq(8).val() == "SETLE_STTUS_Y"){
							tag1 = "<button type='button' onclick='executeBtnEvent("+i
										+", &quot;/member/detailResveRcrd.html&quot;);'>발권현황보기</button>";
							
							tag2 = form.children("input").eq(9).val();
							
							tag3 = form.children("input").eq(10).val()+" 원";
						}else{
							tag1 = "<button type='button' disabled='disabled'>발권현황보기</button>";
							
							tag2 = "<button type='button' onclick='executeBtnEvent("+i
										+", &quot;/member/resveAdd.html&quot;);'>결제하기</button>";
							
							tag3 = "<div style='text-align: center;'>"+form.children("input").eq(9).val()+"</div>";
						}
						
						$("#gridBody").addRowData(
							i,
							{
								tcktRcrd:tag1,
								trainNo:form.children("input").eq(1).val(),
								trainKnd:form.children("input").eq(2).val(),
								startStatn:form.children("input").eq(3).val(),
								startTm:form.children("input").eq(4).val(),
								arvlStatn:form.children("input").eq(5).val(),
								arvlTm:form.children("input").eq(6).val(),
								resveCo:form.children("input").eq(7).val()+" 장",
								setleSttusValue:tag2,
								setelAmount:tag3,
								resveCancel:"<button type='button' onclick='executeBtnEvent("+i+", &quot;/member/processResve.do&quot;);'>예매취소</button>"
							}
						); /* addRowData end */
					} /* for end */	
				} /* else end */
   			}
   			
   			/*버튼 이벤트*/
   			function executeBtnEvent(index, uri){
   				/*버튼이벤트가 발생한 행의 데이터가 담긴 form 테그*/
   				var form = $("#dataForm"+index);
   				
   				/*결제*/
   				if(uri == "/member/resveAdd.html"){
   					/*결제를 진행할 행*/
   					var row = $("#gridBody").getRowData(index);
   					/*confirm msg*/
   					var msg = row.trainKnd+" "+row.trainNo+" "
   								+row.startStatn+"▶"+row.arvlStatn+" 행의 결제를 진행하시겠습니까?";
   					
   					if(confirm(msg)){
   						form.attr("action", uri);
   	   	   				form.submit();
   					}else{
   						return;
   					}
   				}
   				/*예매취소*/
   				else if( uri == "/member/processResve.do"){
   					/*예매를 취소할 행*/
   					var row = $("#gridBody").getRowData(index);
   					/*confirm msg*/
   					var msg = row.trainKnd+" "+row.trainNo+" "
   								+row.startStatn+"▶"+row.arvlStatn+" 행의 예매를 취소하시겠습니까?";
   					
   					if(confirm(msg)){
   						$.ajax({
   							type:"POST",
   							url: uri,
   							Type:"JSON",
   							data: {state:"delete", code:$("#dataForm"+index+" input").eq(0).val()},
   							success : function(data) {
   								if(data.rtCode == 0){
   									/*row delete*/
   									$("#gridBody").delRowData(index);
   									/*No data found*/
   									if($("#gridBody").getGridParam("records") == 0){
   										setGrid("noData");
   									}
   									
   									alert(
   	   										form.children("input").eq(2).val()
   	   										+" "+form.children("input").eq(1).val()+" "
   	   			   							+form.children("input").eq(3).val()
   	   			   							+"▶"+form.children("input").eq(5).val()
   	   			   							+" 행의 예매가 취소되었습니다."
   	   									);
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
   				/*발권현황보기*/
   				else{
   					form.attr("action", uri);
   	   				form.submit();
   				}
   			}
   		</script>
	</head>
	<body>
		<div style="font-size: 35px;">
   			<strong>
   				${menuTree[2]}
   			</strong>
   		</div>
   		
		<!-- 사용방법 -->
		<div class="caption" style="margin-top: 10px; margin-bottom: 0px;">
			<div>* 지금까지 예매하신 승차권들의 정보입니다.</div>
			<div>* 결제가 완료된 승차권은 발권햔황보기를 이용하여 승차권의 상세정보를 보실 수 있습니다.</div>
			<div>* 결제하기를 이용하여 예매를 진행하던 승차권의 결제를 하실 수 있습니다.</div>
			<div>* 결제금액의 경유 미결제 상태라면 미결제가 결제완료 상태라면 결제한 금액이 출력됩니다.</div>
			<div>* 결제가 완료된 승차권의 예매를 취소하시는 경우 결제당시 사용하신 포인트가 존재한다면 사용하신 포인트</div>
			<div style="padding-left: 15px;">만큼 돌려빋을 수 있으며, 이 승차권에의해 정입되었던 현제포인트에서 차감됩니다.</div>
		</div>
		
		<div id="grid" style="margin-top: 10px;">
			<table id="gridBody"></table>
			<div id="footer"></div>
		</div>
		
		<div id="dataGroup">
			<c:forEach var="data" items="${resveRcrdList}" varStatus="state">
				<form id="dataForm${state.count}" method="post" onsubmit="false">
					<input type="hidden" name="resveCode" value="${data.resveCode}">
					<input type="hidden" value="${data.trainNo}">
					<input type="hidden" value="${data.trainKnd}">
					<input type="hidden" value="${data.startStatn}">
					<input type="hidden" value="${data.startTm}">
					<input type="hidden" value="${data.arvlStatn}">
					<input type="hidden" value="${data.arvlTm}">
					<input type="hidden" value="${data.resveCo}">
					<input type="hidden" value="${data.setleSttusCode}">
					<input type="hidden" value="${data.setleSttusValue}">
					<input type="hidden" value="${data.setleAmount}">
				</form>
			</c:forEach>
		</div>
	</body>
</html>