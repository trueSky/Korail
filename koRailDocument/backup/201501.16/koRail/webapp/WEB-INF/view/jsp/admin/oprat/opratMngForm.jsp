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
   			var viewState = false;	/*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
   			var viewState2 = false;	/*viewState와 같은 역활이며 경유지에 대한 상태이다*/
   			var viewState3 = false;	/*viewState와 같은 역활이며 호실정보에 대한 상태이다*/
   			var opratArray;			/*운행정보*/
   			var detailOpratArray;	/*경유지*/
   			var roomArray;			/*호시렁보*/
   			
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(3)).addClass("set");
				$($(".lmb tr").get(2)).children("td").addClass("set");
	   			/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual05.jpg");
	   			
				/*등록 버튼*/
				$("#addBtn").click(addOprat);
				
	   			/*삭제 버튼*/
	   			$("#deleteBtn").click(deleteOprat);

	   			/*엔터*/
				$("#trainNoText").keydown(function(e){
					if(e.keyCode == 13){
						$("#trainNoBtn").click();
					}
				});
	   			
				doGridInit("all"); /*그리드 초기화*/
				
				/* 전채검색 */
				$("#trainKndBtn").click();
	   		});
   			
	   		/*그리드 초기상태*/
   			function doGridInit(mode){
	   			var allInit = false;
	   			
	   			/*모든 그리드 초기화*/
	   			if(mode == "all"){
	   				allInit = true;
	   			}
	   			
	   			/*운행일정 리스트*/
	   			if(mode == "oprat" || allInit){
	   				viewState = false;
	   				
	   				$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
	   				
	   				$("#gridBody").jqGrid({
						datatype: "LOCAL",
		   				caption:"운행일정",
		   				width: 500,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer',
		   				colNames:["번호", "열차번호", "열차종류", "출발역", "도착역"],
		          		colModel : [
							{ name : "no", align:"center", width: 40, sortable:false,
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=5';
								}
							},
							{ name : 'trainNo', width: 60, align:"center", sortable:false},
							{ name : 'trainKnd', width: 70, align:"center", sortable:false},
							{ name : 'startStatn', width: 70, align:"center", sortable:false},
							{ name : 'arvlStatn', width: 70, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
					
	   				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
					$("#gridBody").jqGrid('addRowData', 1, {no:"조회된 결과가 존재하지 않습니다."});
	   			}
	   			
	   			/*상세운행일정*/
	   			if(mode == "detailOprat" || allInit){
	   				viewState2 = false;
	   				
	   				/*그리드 초기화*/
					$("#grid2").html("<table id='gridBody2'></table><div id='footer2'></div>");
	   				
					$("#gridBody2").jqGrid({
						datatype: "LOCAL",
		   				caption:"경유지",
		   				width: 845,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer2',
		   				colNames:["번호", "출발역", "출발일시", "도착역", "도착일시", "이전역", "다음역"],
		          		colModel : [
							{ name : 'no', width: 40, align:"center", sortable:false,
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=9';
								}
							},
							{ name : 'startStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'startTm', width: 70, align:"center", sortable:false},
							{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'arvlStatnTm', width: 70, align:"center", sortable:false},
							{ name : 'prvStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'nxtStatnValue', width: 70, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
					
					/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
					$("#gridBody2").jqGrid('addRowData', 1, {no:"운행일정을 선택하십시오."});
	   			}
	   			
	   			if(mode == "room" || allInit){
					viewState3 = false;
	   				
	   				/*그리드 초기화*/
					$("#grid3").html("<table id='gridBody3'></table><div id='footer3'></div>");
	   				
					$("#gridBody3").jqGrid({
						datatype: "LOCAL",
		   				caption:"호실",
		   				width: 550,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer3',
		   				colNames:["번호", "호실", "좌석수", "특실여부"],
		          		colModel : [
							{ name : "no", width: 40, align:"center", sortable:false,
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=4';
								}
							},
							{ name : "room", width: 70, align:"center", sortable:false},
							{ name : "seatCo", width: 70, align:"center", sortable:false},
							{ name : "prtclrRoomYN", width: 30, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
					
					/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
					$("#gridBody3").jqGrid('addRowData', 1, {no:"운행일정을 선택하십시오."});
	   			}
   			} /* doGridInit end */
	   		
	   		/*그리드 생성 그리드의 존재여부확인 후 존재할 경우 실행하지 않는다*/
	   		function setGrid(mode){
	   			/*운행정보 리스트*/
	   			if(mode == "oprat"){
	   				/*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
					viewState = true;
					
					/*그리드 초기화*/
					$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
					
					$("#gridBody").jqGrid({
						datatype: "LOCAL",
		   				multiselect: true,
		   				caption:"운행일정",
		   				width: 500,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer',
		   				colNames:["번호", "code", "열차번호", "열차종류", "출발역", "도착역"],
		          		colModel : [
							{ name : "no", width: 40, align:"right", sortable:false},
							{ name : "opratCode", hidden:true},
							{ name : "trainNo", align:"center", width: 60, height : 200, sortable:false},
							{ name : 'trainKnd', width: 70, align:"center", sortable:false},
							{ name : 'startStatn', width: 70, align:"center", sortable:false},
							{ name : 'arvlStatn', width: 70, align:"center", sortable:false}
						],
						/*row click*/
						onCellSelect: function(rowId,indexColumn,cellContent,eventObject){
							/* 운행일정을 수정할 code를 선택한 opratCode로 설정한다. */
							$("#opratCode").val($(this).getRowData(rowId).opratCode);
							/*버튼 활성화*/
							$("#updateBtn").removeAttr("disabled");
							$("#updateBtn").removeClass("b-disabled");
							
							/*운행정보에 정보 설정*/
							setOpratTable(rowId);
							/*상세운행일정 정보 설정*/
							setDetailOprat(rowId);
							/*호실정보 설정*/
							setRoom(rowId);
						}
					}); /*jqGrid end*/
	   			}
	   			/*경유지*/
	   			else if(mode == "detailOprat"){
	   				/*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
					viewState2 = true;
	   				
	   				/*그리드 초기화*/
	   				$("#grid2").html("<table id='gridBody2'></table><div id='footer2'></div>");
					
					$("#gridBody2").jqGrid({
						datatype: "LOCAL",
		   				caption:"결유지",
		   				width: 845,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer2',
		   				colNames:["번호", "출발역", "출발일시", "도착역", "도착일시", "이전역", "다음역"],
		          		colModel : [
							{ name : "no", width: 40, align:"right", sortable:false},
							{ name : 'startStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'startTm', width: 120, align:"center", sortable:false},
							{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'arvlTm', width: 120, align:"center", sortable:false},
							{ name : 'prvStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'nxtStatnValue', width: 70, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
	   			}
	   			/* 호실정보 */
	   			else{
	   				/*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
					viewState3 = true;
		   				
	   				/*그리드 초기화*/
					$("#grid3").html("<table id='gridBody3'></table><div id='footer3'></div>");
	   				
					$("#gridBody3").jqGrid({
						datatype: "LOCAL",
		   				caption:"호실",
		   				width: 550,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer3',
		   				colNames:["번호", "호실", "좌석수", "특실여부"],
		          		colModel : [
							{ name : "no", width: 40, align:"right", sortable:false},
							{ name : "room", width: 70, align:"center", sortable:false},
							{ name : "seatCo", width: 70, align:"center", sortable:false},
							{ name : "prtclrRoomYN", width: 30, align:"center", formatter:"checkbox", sortable:false}
						]
					}); /*jqGrid end*/
				}
	   		} /* setGrid end */
	   		
	   		/*리스트*/
			function findOpratList(mode){
				/*초기화*/
				opratArray = new Array();
				detailOpratArray = new Array();
				roomArray = new Array();
				viewState2 = false;
				viewState3 = false;
				
				doGridInit("detailOprat");
				doGridInit("room");
				
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
				
				$("#opratCode").val("");
				
				/*버튼 비활성화*/
				$("#updateBtn").attr("disabled", "disabled");
				$("#updateBtn").removeClass("b-disabled");
				$("#updateBtn").addClass("b-disabled");
				
				/*검색조건*/
	   			var trainKnd = $.trim($("#trainKndSelect").val());	/*열차종류*/
	   			var trainNo = $.trim($("#trainNoText").val());		/*열차번호*/
	   			
	   			/*열차종류로 검색*/
				if(mode == "knd"){
					trainNo = "";
				}
				/*열차번호로 검색*/
				else{
					if(trainNo == ""){
						alert("조회조건을 입력해야 합나디다.");
						return;
					}else{
						trainKnd = "";
					}
				}
				
	   			$.ajax({
						type:"POST",
						url: "/admin/opratList.do",
						Type:"JSON",
						data:{srcType:trainKnd, srcText:trainNo},
						success : function(data) {
							if(data.opratListSize == 0){
								alert("결과가 존재하지 않습니다.");
							}else{
								/*그리드 생성 이미 생성되 있다면 생성하지 않는다.*/
								if(!viewState){
									setGrid("oprat");
								}
								
								/*그리드 비우기*/
								$("#gridBody").jqGrid('clearGridData');
								
								/*데이터 삽입*/
								$.each(data.opratList, function(k,v){
									/*운행정보들*/
									opratArray.push(
										{
											no:k+1,
											trainNo:v.trainNo+"",
											trainKnd:v.trainKndValue+"",
											startStatn:v.startStatnValue+"",
											startTm:v.startTm+"",
											arvlStatn:v.arvlStatnValue+"",
											arvlTm:v.arvlTm+"",
											route:v.routeValue+"",
											fare:v.fare+"",
											register:v.register+"",
											rgsde:v.rgsde+"",
											updUsr:v.updUsr+"",
											updde:v.updde+""
										}
									);
									
									/*경유지 데이터 삽입*/
									$.each(v.detailOpratList, function(k2,v2){
										detailOpratArray.push(
											{
												no:k2+1,
												opratCode:v2.opratCode+"",
												startStatnValue:v2.startStatnValue+"",
												startTm:v2.startTm+"",
												arvlStatnValue:v2.arvlStatnValue+"",
												arvlTm:v2.arvlTm+"",
												prvStatnValue:v2.prvStatnValue+"",
												nxtStatnValue:v2.nxtStatnValue+""
											}
										);
									}); /*$.each end*/
									
									/* 호실정보 데이터 삽입 */
									$.each(v.roomList, function(k2,v2){
										roomArray.push(
											{
												no:k2+1,
												opratCode:v2.opratCode+"",
												room:v2.room+" 호실",
												seatCo:v2.seatCo+" 석",
												prtclrRoomYN:v2.prtclrRoomYN+""
											}
										);
									}); /*$.each end*/
									
									/*운행정보 리스트에 보여질 항목*/
									$("#gridBody").addRowData(
										k+1,
										{
											no:k+1,
											opratCode:v.opratCode+"",
											trainNo:v.trainNo+"",
											trainKnd:v.trainKndValue+"",
											startStatn:v.startStatnValue+"",
											arvlStatn:v.arvlStatnValue+""
										}
									); /*addRowData end*/
								}); /*$.each end*/
							} /*else end*/
						}, /*success end*/
						error : function(request, status, error){
							if(request.status == 401){
								alert("세션이 만료되었습니다.");
								location.href = "/logout.do";
							}else{
								alert("서버에러입니다.");
							}
						}
					}); /*$.ajax end*/
			} /*findOpratList end*/
			
			/*운행정보리스트에서 선택한 항목에 대한 운행정보를 보여준다.*/
			function setOpratTable(rowId){
				$("#trainNo").html(opratArray[rowId-1].trainNo);
				$("#trainKnd").html(opratArray[rowId-1].trainKnd);
				$("#startStatn").html(opratArray[rowId-1].startStatn);
				$("#startTm").html(opratArray[rowId-1].startTm);
				$("#arvlStatn").html(opratArray[rowId-1].arvlStatn);
				$("#arvlTm").html(opratArray[rowId-1].arvlTm);
				$("#route").html(opratArray[rowId-1].route);
				$("#fare").html(opratArray[rowId-1].fare+" 원");
				$("#register").html(opratArray[rowId-1].register);
				$("#rgsde").html(opratArray[rowId-1].rgsde);
				$("#updUsr").html(opratArray[rowId-1].updUsr);
				$("#updde").html(opratArray[rowId-1].updde);
			}
			
			/*경유지*/
			function setDetailOprat(rowId){
				var exceptionCount = 0; /*선택한 운행정보의 경유지가 아닌 row 수*/
				
				if(!viewState2){
					setGrid("detailOprat");
				}
				
				/*그리드 비우기*/
				$("#gridBody2").jqGrid('clearGridData');
				
				/*경유지*/
				for(var i = 0; i< detailOpratArray.length; i++){
					/*선택한 운행정보에 대한 경유지*/
					if($("#gridBody").getRowData(rowId).opratCode == detailOpratArray[i].opratCode){
						/*운행정보 리스트에 보여질 항목*/
						$("#gridBody2").jqGrid('addRowData', i+1, detailOpratArray[i]); /*addRowData end*/
					}else{
						 exceptionCount =  exceptionCount+=1;
					}
				}
				
				/*상세운행일정이 없을 때*/
				if((detailOpratArray.length- exceptionCount) == 0){
					/*그리드 메세지*/
					doGridInit("detailOprat");
					$("#gridBody2").jqGrid('clearGridData');
					$("#gridBody2").jqGrid('addRowData', 1, {no:"등록된 경유지가 없습니다."});
				}
			}
			
			/*호실정보*/
			function setRoom(rowId){
				var exceptionCount = 0; /*선택한 운행정보의 호실정보가 아닌 row 수*/
				
				if(!viewState3){
					setGrid("room");
				}
				
				/*그리드 비우기*/
				$("#gridBody3").jqGrid('clearGridData');
				
				/*경유지*/
				for(var i = 0; i< roomArray.length; i++){
					/*선택한 운행정보에 대한 경유지*/
					if($("#gridBody").getRowData(rowId).opratCode == roomArray[i].opratCode){
						/*운행정보 리스트에 보여질 항목*/
						$("#gridBody3").jqGrid('addRowData', i+1, roomArray[i]); /*addRowData end*/
					}else{
						 exceptionCount =  exceptionCount+=1;
					}
				}
				
				/*상세운행일정이 없을 때*/
				if((roomArray.length- exceptionCount) == 0){
					/*그리드 메세지*/
					doGridInit("room");
					$("#gridBody3").jqGrid('clearGridData');
					$("#gridBody3").jqGrid('addRowData', 1, {room:"검색된 결과가 없습니다."});
				}
			}
			
			/*등록*/
			function addOprat(){
				location.href = "/admin/opratAdd.html";
			}
			
			/*수정*/
			function updateOprat(){
				$("#updateForm").submit();
			}
			
			/*삭제*/
   			function deleteOprat(){
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
							deleteCodeArray.push($("#gridBody").getRowData(rowIds[i]).opratCode);
						}
						
						/*삭제할 정보를 name(deleteCodeArray)의 값에 설정*/
						$("input[name=deleteCodeArray]").val(deleteCodeArray);
						
						$.ajax({
							type:"POST",
							url: "/admin/opratProcess.do",
							Type:"JSON",
							data:{state:"delete", deleteCodeArray:$("input[name=deleteCodeArray]").val()},
							success : function(data) {
								/* 선택된 row들 */
								var rowIds = $("#gridBody").getGridParam('selarrrow');
								
								if(data.errorCode == 0){
									/* 그리드에서 ROW 삭제 */
									for(var i = rowIds.length; i > 0; i--){
										$("#gridBody").delRowData(rowIds[i-1]);
									}
										
									/*그리드 초기화 또는 재 조회*/
									if(data.errorMsg == null){
										if($("#gridBody").getGridParam("records") == 0){
											doGridInit("all");
											
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
											
											$("#opratCode").val("");
										}else{
											findOpratList("knd");
										}
									}
									
									alert("삭제가 완료되었습니다.");
								}else{
									/* 삭제되지 않은 ROW를 보여줌 */
									for(var i = 0; i < rowIds.length; i++){
										if($("#gridBody").getRowData(rowIds[i]).opratCode == data.errorMsg){
											alert(
												$("#gridBody").getRowData(rowIds[i]).no
												+"("+$("#gridBody").getRowData(rowIds[i]).trainNo
												+"-"+$("#gridBody").getRowData(rowIds[i]).trainKnd
												+")은(는) 현재 사용중인 열차입니다."
											);
										}
									}
								}
							}, /*success end*/
							error : function(request, status, error){
								if(request.status == 401){
									alert("세션이 만료되었습니다.");
									location.href = "/logout.do";
								}else{
									alert("서버에러입니다.");
								}
							}
						}); /* ajax end */
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
   			<div>* 열차종류를 선택한 후 조회버튼을 이용해 운행일정을 조회할 수 있습니다.</div>
			<div>* 열차번호를 입력한 후 조회버튼을 이용해 운행일정을 조회할 수 있습니다.</div>
			<div>* 조회한 리스트의 특정 항목을 선택하여 상세정보들을 보실 수 있습니다.</div>
			<div>* 등록버튼을 이용하여 운행일정을 등록할 수 있습니다.</div>
			<div>* 수정할 운행일정을 선택한 후 호실목록 하단의 수정버튼을 이용하여 운행일정을 수정할 수 있습니다.</div>
			<div>* 삭제할 운행일정을 체크박스로 선택한 후 석제버튼을 이용하여 운행일정을 삭제할 수 있습니다.</div>
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
   								<option value="ALL">전채</option>
   								<c:forEach var="value" items="${commonCodeList}">
	   								<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
   								</c:forEach>
   							</select>
   						</td>
   						<td style="width: 75px;">
   							<button id="trainKndBtn" type="button" onclick="findOpratList('knd');" style="width: 95%; height: 25px;">조회</button>
   						</td>
   						
   						<!-- 열차번호로 검색 -->
   						<td style="width: 70px; padding-left: 32px; text-align: center;">
							<strong>열차번호</strong>
						</td>
   						<td style="width: 120px;">
   							<input id="trainNoText" type="text" style="width: 95%; height: 19px;">
   						</td>
   						<td style="width: 75px;">
   							<button id="trainNoBtn" type="button" onclick="findOpratList('trainNo');" style="width: 100%; height: 25px;">조회</button>	
   						</td>
   						
   						<!-- 등록버튼, 삭제버튼 -->
   						<td style="width: 75px; padding-left: 30px;">
   							<button id="addBtn" type="button" class="btn" style="width: 95%; height: 25px;">등록</button>
   						</td>
   						<td style="width: 75px; padding-right: 10px;">
   							<!-- 삭제할 시 제검색 유형 설정 -->
   							<input id="deleteType" type="hidden">
   							<button id="deleteBtn" type="button" class="btn" style="width: 95%; height: 25px;">삭제</button>
   						</td>
   					</tr>
   				</tbody>
   			</table>
   		</div>
   		<!-- 리스트 -->
   		<div id="grid" style="margin: 0 auto; margin-top: 15px; width: 500px;">
   			<table id="gridBody"></table>
	   		<div id="footer"></div>
   		</div>
   		
   		<!-- 운행일정 -->
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
						<td colspan="4" class="t-radius">
							<strong>운행일정</strong>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="head">열차번호</td>
						<td id="trainNo">--</td>
						<td class="head">열차종류</td>
						<td id="trainKnd">--</td>
					</tr>
					<tr>
						<td class="head">출발역</td>
						<td id="startStatn">--</td>
						<td class="head">출발일시</td>
						<td id="startTm">--</td>
					</tr>
					<tr>
						<td class="head">도착역</td>
						<td id="arvlStatn">--</td>
						<td class="head">도착일시</td>
						<td id="arvlTm">--</td>
					</tr>
					<tr>
						<td class="head">노선</td>
						<td id="route">--</td>
						<td class="head">요금</td>
						<td id="fare">--</td>
					</tr>
					<tr>
						<td class="head">등록자</td>
						<td id="register">--</td>
						<td class="head">등록일</td>
						<td id="rgsde">--</td>
					</tr>
					<tr>
						<td class="head b-l-radius">수정자</td>
						<td id="updUsr">--</td>
						<td class="head">수정일</td>
						<td id="updde" class="b-r-radius">--</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<!-- 경유지 -->
		<div id="grid2" style="margin: 0 auto; margin-top: 15px; width: 845px;">
   			<table id="gridBody2"></table>
	   		<div id="footer2"></div>
   		</div>
   		
   		<!-- 호실정보 -->
		<div id="grid3" style="margin: 0 auto; margin-top: 15px; width: 550px;">
   			<table id="gridBody3"></table>
	   		<div id="footer3"></div>
   		</div>
   		
   		<!-- 수정 -->
   		<div id="updateGroup" style="margin: 0 auto; margin-top: 15px; width: 90px;">
			<button id="updateBtn" class="b-disabled" onclick="updateOprat();" style="width: 90px;" disabled="disabled">수정</button>
   			
			<form id="updateForm" action="/admin/opratUpdate.html" method="post">
				<input id="opratCode" name="code" type="hidden">
			</form>
   		</div>
   		
		<!-- 삭제 -->
		<div>
			<form id="deleteForm" action="/admin/opratProcess.do" method="post">
				<!-- 삭제로 상태설정 -->
   				<input type="hidden" name="state" value="delete">
				<!-- 삭제할 운행 코드들 -->
   				<input type="hidden" name="deleteCodeArray">
			</form>
		</div>
	</body>
</html>