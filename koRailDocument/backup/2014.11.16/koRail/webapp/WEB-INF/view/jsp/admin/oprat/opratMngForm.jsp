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
   			var viewState = false; /*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
   			var opratArray = new Array();	/*운행정보*/
   			
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(2)).addClass("set");
				$($(".lmb tr").get(2)).children("td").addClass("set");
	   			
	   			/*삭제 버튼*/
	   			$("#deleteBtn").click(deleteStatn);

	   			/*엔터*/
				$("#trainNoText").keydown(function(e){
					if(e.keyCode == 13){
						$("#trainNoBtn").click();
					}
				});
	   			
	   			/*그리드 초기상태*/
				$("#gridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"운행일정 리스트",
	   				width: 395,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["열차번호", "열차종류", "출발역", "도착역"],
	          		colModel : [
						{ name : "trainNo", align:"center", width: 60, height : 200,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=4';
							}
						},
						{ name : 'trainKnd', width: 70, align:"center"},
						{ name : 'startStatn', width: 70, align:"center"},
						{ name : 'arvlStatn', width: 70, align:"center"}
					],
					afterInsertRow: function(rowId,rowData,rowElement){
						$("button").button();
					}
				}); /*jqGrid end*/
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").jqGrid('addRowData', 1, {trainNo:"조회조건을 선택/입력하여 조회를 하십시오."});
	   		});
	   		
	   		/*리스트*/
			function findOpratList(mode){
				var vUrl = ""; /*url*/
				
				/*초기화*/
				opratArray = new Array();
				
				$("#trainNo").html("--");
				$("#trainKnd").html("--");
				$("#startStatn").html("--");
				$("#startTm").html("--");
				$("#arvlStatn").html("--");
				$("#arvlTm").html("--");
				$("#route").html("--");
				$("#distnc").html("--");
				$("#fare").html("--");
				$("#register").html("--");
				$("#rgsde").html("--");
				$("#updUsr").html("--");
				$("#updde").html("--");
				
				/*검색조건*/
	   			var trainKnd = $("#trainKndSelect").val().trim();	/*열차종류*/
	   			var trainNo = $("#trainNoText").val().trim();		/*열차번호*/
	   			
	   			/*열차종류로 검색*/
				if(mode == "knd"){
					if(trainKnd == "선택"){
						alert("조회조건을 선택해야 합나디다.");
						return;
					}else{
						vUrl = "/admin/opratList.do?srcType="+trainKnd;
					}
				}
				/*열차번호로 검색*/
				else{
					if(trainNo == ""){
						alert("조회조건을 입력해야 합나디다.");
						return;
					}else{
						vUrl = "/admin/opratList.do?srcText="+encodeURIComponent(trainNo);
					}
				}
				
				/* 미입력 처리 */
				if(vUrl == ""){
					return;
				}
				/*그리드 내용*/
				else{
					$.ajax({
						type:"GET",
						url: vUrl,
						Type:"JSON",
						success : function(data) {
							if(data.opratListSize == 0){
								alert("결과가 존재하지 않습니다.");
							}else{
								/*그리드 재생성*/
								if(!viewState){
									/*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
									viewState = true;
									
									/*그리드 초기화*/
									$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
									
									$("#gridBody").jqGrid({
										datatype: "LOCAL",
						   				multiselect: true,
						   				caption:"운행일정 리스트",
						   				width: 395,
						   				height: 160,
						   				scroll: 1,
						   				rowNum : 'max',
						   				pager: '#footer',
						   				colNames:["열차번호", "열차종류", "출발역", "도착역"],
						          		colModel : [
											{ name : "trainNo", align:"center", width: 60, height : 200},
											{ name : 'trainKnd', width: 70, align:"center"},
											{ name : 'startStatn', width: 70, align:"center"},
											{ name : 'arvlStatn', width: 70, align:"center"}
										],
										gridComplete: function(){
											$("button").button();
										},
										/*셀 선택시 셀에 해당하는 정보 표시*/
										onCellSelect: function(rowId,indexColumn,cellContent,eventObject){
											$("#trainNo").html(opratArray[rowId-1].trainNo);
											$("#trainKnd").html(opratArray[rowId-1].trainKnd);
											$("#startStatn").html(opratArray[rowId-1].startStatn);
											$("#startTm").html(opratArray[rowId-1].startTm);
											$("#arvlStatn").html(opratArray[rowId-1].arvlStatn);
											$("#arvlTm").html(opratArray[rowId-1].arvlTm);
											$("#route").html(opratArray[rowId-1].route);
											$("#distnc").html(opratArray[rowId-1].distnc+" km");
											$("#fare").html(opratArray[rowId-1].fare+" 원");
											$("#register").html(opratArray[rowId-1].register);
											$("#rgsde").html(opratArray[rowId-1].rgsde);
											$("#updUsr").html(opratArray[rowId-1].updUsr);
											$("#updde").html(opratArray[rowId-1].updde);
										}
									}); /*jqGrid end*/
								} /*if end*/
								
								/*그리드 비우기*/
								$("#gridBody").jqGrid('clearGridData');
								
								/*데이터 삽입*/
								$.each(data.opratList, function(k,v){
									opratArray.push(
										{
											trainNo:v.trainNo+"",
											trainKnd:v.trainKndValue+"",
											startStatn:v.startStatnValue+"",
											startTm:v.startTm+"",
											arvlStatn:v.arvlStatnValue+"",
											arvlTm:v.arvlTm+"",
											route:v.routeValue+"",
											distnc:v.distnc+"",
											fare:v.fare+"",
											register:v.register+"",
											rgsde:v.rgsde+"",
											updUsr:v.updUsr+"",
											updde:v.updde+""
										}
									);
									
									$("#gridBody").jqGrid('addRowData', k+1,
										{
											trainNo:v.trainNo+"",
											trainKnd:v.trainKndValue+"",
											startStatn:v.startStatnValue+"",
											arvlStatn:v.arvlStatnValue+""
										}
									); /*addRowData end*/
								}); /*$.each end*/
							} /*else end*/
						} /*success end*/
					}); /*$.ajax end*/
				} /*else end*/
			} /*findOpratList end*/
			
			/*삭제*/
   			function deleteStatn(){
				/*체크박스로 선택된 행의 ID들*/
   				var rowIds = $("#gridBody").getGridParam('selarrrow');
   				/*삭제할 운행일정 코드 배열*/
				var deleteCodeArray = new Array();
				
				/*select check*/
				if(rowIds == ""){
					alert("삭제할 항목을 선택해야 합니다.");
					return;
				}else{
					if(confirm("선택한 항목을 삭제하시겠습니까?")){
						/*deleteCodeArray에 역 코드 삽입*/
						for(var i = 0; i < rowIds.length; i++){
							deleteCodeArray.push($("#gridBody").getRowData(rowIds[i]).statnCode);
						}
						
						/*삭제할 정보를 name(deleteCodeArray)의 값에 설정*/
						$("input[name=deleteCodeArray]").val(deleteCodeArray);
						
						$("#deleteForm").submit();
					}
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
			* 열차종류를 선택한 후 조회버튼을 이용해 운행일정을 조회할 수 있습니다.
			<br>
			* 열차번호를 입력한 후 조회버튼을 이용해 운행일정을 조회할 수 있습니다.
			<br>
			* 조회한 리스트의 특정 항목을 선택하여 상세정보들을 보실 수 있습니다.
			<br>
			* 등록버튼을 이용하여 운행일정을 등록할 수 있습니다.
			<br>
			* 삭제할 운행일정을 체크박스로 선택한 후 석제버튼을 이용하여 운행일정을 삭제할 수 있습니다.
   		</div>
   		
   		<!-- search -->
   		<div id="serch" >
   			<table class="search-group">
   				<tbody>
   					<tr>
   						<!-- 열차번호로 검색 -->
   						<td style="width: 70px; height: 25px; text-align: center;">
							<strong>열차종류</strong>
						</td>
   						<td style="width: 100px; padding-left: 0px;">
   							<select id="trainKndSelect" style="width: 100%; height: 25px">
   								<option value="선택">선택</option>
   								<c:forEach var="value" items="${commonCodeList}">
	   								<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
   								</c:forEach>
   							</select>
   						</td>
   						<td style="width: 75px;">
   							<button id="trainKndBtn" type="button" onclick="findOpratList('knd');" style="width: 100%; height: 25px;">조회</button>
   						</td>
   						
   						<!-- 열차번호로 검색 -->
   						<td style="width: 70px; padding-left: 32px; text-align: center;">
							<strong>열차번호</strong>
						</td>
   						<td style="width: 120px;">
   							<input id="trainNoText" type="text" style="width: 100%; height: 19px;">
   						</td>
   						<td style="width: 75px;">
   							<button id="trainNoBtn" type="button" onclick="findOpratList('trainNo');" style="width: 100%; height: 25px;">조회</button>	
   						</td>
   						
   						<!-- 등록버튼, 삭제버튼 -->
   						<td style="width: 75px; padding-left: 30px;">
   							<button id="addBtn" type="button" class="btn" style="width: 100%; height: 25px;">등록</button>
   						</td>
   						<td style="width: 75px; padding-right: 10px;">
   							<button id="deleteBtn" type="button" class="btn" style="width: 100%; height: 25px;">삭제</button>
   						</td>
   					</tr>
   				</tbody>
   			</table>
   		</div>
   		<!-- 리스트 -->
   		<div id="grid" style="margin: 0 auto; margin-top: 15px; width: 395px;">
   			<table id="gridBody"></table>
	   		<div id="footer"></div>
   		</div>
   		
   		<!-- 상세정보 -->
   		<div>
			<table class="d-table">
				<colgroup>
					<col width="20%">
					<col width="30%">
					<col width="20%">
					<col width="30%">
				</colgroup>
				<thead>
					<tr>
						<td colspan="4" style="text-align: center;">
							<strong>운행일정</strong>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>열차번호</td>
						<td id="trainNo">--</td>
						<td>열차종류</td>
						<td id="trainKnd">--</td>
					</tr>
					<tr>
						<td>출발역</td>
						<td id="startStatn">--</td>
						<td>출발시각</td>
						<td id="startTm">--</td>
					</tr>
					<tr>
						<td>도착역</td>
						<td id="arvlStatn">--</td>
						<td>도착시각</td>
						<td id="arvlTm">--</td>
					</tr>
					<tr>
						<td>노선</td>
						<td id="route">--</td>
						<td>거리</td>
						<td id="distnc">--</td>
					</tr>
					<tr>
						<td>요금</td>
						<td id="fare" colspan="3">--</td>
					</tr>
					<tr>
						<td>등록자</td>
						<td id="register">--</td>
						<td>등록일</td>
						<td id="rgsde">--</td>
					</tr>
					<tr>
						<td>수정자</td>
						<td id="updUsr">--</td>
						<td>수정일</td>
						<td id="updde">--</td>
					</tr>
				</tbody>
			</table>
		</div>
   		
		<!-- 삭제 -->
		<div>
			<form id="deleteForm" action="/admin/statnProcess.do" method="post">
				<!-- 삭제로 상태설정 -->
   				<input type="hidden" name="state" value="delete">
				<!-- 삭제할 역 코드들 -->
   				<input type="hidden" name="deleteCodeArray">
			</form>
		</div>
	</body>
</html>