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
   		
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(3)).addClass("set");
				$($(".lmb tr").get(1)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual04.jpg");
				
	   			/*등록 다이알로그 */
	   			$("#addBtn").click(addTrain);
	   			
	   			/*삭제 버튼*/
	   			$("#deleteBtn").click(deleteTrain);

	   			/*엔터*/
				$("#trainNoText").keydown(function(e){
					if(e.keyCode == 13){
						$("#trainNoBtn").click();
					}
				});
	   			
	   			/* 그리드 초기화 */
				doGridInit();
	   		});
	   		
	   		/*그리드 초기화*/
   			function doGridInit(){
   				viewState = false;
	   			
   				/*그리드 초기화*/
				$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
	   			
	   			/*그리드 초기상태*/
				$("#gridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"열차정보",
	   				width: 845,
	   				height: 230,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["수정", "열차코드", "열차종류", "열차번호", "등록자", "등록일", "수정자", "수정일"],
	          		colModel : [
						{ name : "update", align:"center", width: 60, height : 200, sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=8';
							}
						},
						{ name : 'trainCode', width: 70, sortable:false},
						{ name : 'trainKnd', width: 70, align:"center", sortable:false},
						{ name : 'trainNo', width: 70, align:"center", sortable:false},
						{ name : 'register', width: 70, align:"center", sortable:false}, 
						{ name : 'rgsde', width: 110, align:"center", sortable:false},
						{ name : 'updUser', width: 70, align:"center", sortable:false},
						{ name : 'updde', width: 110, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").jqGrid('addRowData', 1, {update:"조회조건을 선택/입력하여 조회를 하십시오."});
   			}
   			
	   		/*리스트*/
			function findTrainList(mode){
				var vUrl = ""; /*url*/
				
				/*검색조건*/
	   			var trainKnd = $("#trainKndSelect").val().trim();	/*열차종류*/
	   			var trainNo = $("#trainNoText").val().trim();		/*열차번호*/
	   			
	   			/*열차종류로 검색*/
				if(mode == "knd"){
					if(trainKnd == "선택"){
						alert("조회조건을 선택해야 합나디다.");
						return;
					}else{
						/* 삭제할 시 제검색 유형 설정 */
		   				$("#deleteType").val("knd");
						vUrl = "/admin/trainList.do?srcType="+trainKnd;
					}
				}
				/*열차번호로 검색*/
				else{
					if(trainNo == ""){
						alert("조회조건을 입력해야 합나디다.");
						return;
					}else{
						/* 삭제할 시 제검색 유형 설정 */
		   				$("#deleteType").val("trinNo");
						vUrl = "/admin/trainList.do?srcText="+encodeURIComponent(trainNo);
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
							if(data.trainListSize == 0){
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
						   				caption:"열차정보",
						   				width: 845,
						   				height: 230,
						   				scroll: 1,
						   				rowNum : 'max',
						   				pager: '#footer',
						   				colNames:["수정", "열차코드", "열차종류", "열차번호", "등록자", "등록일", "수정자", "수정일"],
						          		colModel : [
											{ name : "update", align:"center", width: 60, height : 200, sortable:false},
											{ name : 'trainCode', width: 120, sortable:false},
											{ name : 'trainKnd', width: 70, align:"center", sortable:false},
											{ name : 'trainNo', width: 70, align:"center", sortable:false},
											{ name : 'register', width: 70, align:"center", sortable:false}, 
											{ name : 'rgsde', width: 110, align:"center", sortable:false},
											{ name : 'updUsr', width: 70, align:"center", sortable:false},
											{ name : 'updde', width: 110, align:"center", sortable:false}
										]
									}); /*jqGrid end*/
								} /*if end*/
								
								/*그리드 비우기*/
								$("#gridBody").jqGrid('clearGridData');
								
								/*데이터 삽입*/
								$.each(data.trainList, function(k,v){
									$("#gridBody").jqGrid('addRowData', k+1,
										{
											update:"<button type='button'"
													+"style='margin-top: 2px;"
													+"margin-bottom: 3px;'"
													+"onclick=updateTrain('"+v.trainCode+"','"+v.trainKndCode+"','"+v.trainNo+"')>수정</button>",
											trainCode:v.trainCode+"",
											trainKnd:v.trainKndValue+"",
											trainNo:v.trainNo+"",
											register:v.register+"",
											rgsde:v.rgsde+"",
											updUsr:v.updUsr+"",
											updde:v.updde+""
										}
									); /*addRowData end*/
								}); /*$.each end*/
							} /*else end*/
						} /*success end*/
					}); /*$.ajax end*/
				} /*else end*/
			} /*findTrainList end*/
			
			/*등록 다이알로그 */
   			function addTrain(){
   				var trainKnd = $("#addTrainKndSelect");
   				var trainNo = $("#addTrainNoText");
				
   				/*초기화*/
				trainKnd.children(":first-child").attr("selected", "selected");
				trainNo.val("");
				
				/*다이알로그*/
   				$("#addDialog").dialog({
   					modal: true,
					buttons: {
						"등록": function() {
							/*미입력 처리*/
							if(trainKnd.val() == "선택"){
								alert("열차를 선택해야합니다.");
							}else if(trainNo.val().replace(" ") == ""){
								alert("모든 항목은 필수입력 사항입니다.");
							}
							/*conForm 생성(확인 : 등록, 취소 : 상태유지)*/
							else if(confirm("이 열차정보를 등록하시겠습니까?")){
								$.ajax({
									type:"POST",
									url: "/admin/trainProcess.do?state=insert&trainKndCode="
											+encodeURIComponent(trainKnd.val())+"&trainNo="
											+encodeURIComponent(trainNo.val().replace(" "))+"&register="
											+encodeURIComponent("${name}"),
									Type:"JSON",
									success : function(data) {
										if(data.errorCode == 0){
											/* 재검색 */
											if($("#deleteType").val() != ""){
												findTrainList($("#deleteType").val());
											}
											
											alert("등록이 완료되었습니다.");
										}else{
											alert("등록실패");
										}
									}
								}); /* ajax end */
								
								$(this).dialog("close");
							}
						},
						"취소": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
   			} /*등록 end */
			
			/*수정 다이알로그 */
   			function updateTrain(trainCode, vTrainKnd, vTrainNo){
   				var trainKnd = $("#updateTrainKndSelect");
   				var trainNo = $("#updateTrainNoText");
   				/*정보설정*/
				trainKnd.children("option[value='"+vTrainKnd+"']").attr("selected", "selected");
   				trainNo.val(vTrainNo);
				
				/*다이알로그*/
   				$("#updateDialog").dialog({
   					modal: true,
					buttons: {
						"수정": function() {
							/*미입력 처리*/
							if(trainKnd.val() == "선택" || trainNo.val().replace(" ") == ""){
								alert("모든 항목은 필수입력 사항입니다.");
							}
							/*conForm 생성(확인 : 등록, 취소 : 상태유지)*/
							else if(confirm("이 열차정보를 등록시겠습니까?")){
								$.ajax({
									type:"POST",
									url: "/admin/trainProcess.do?state=update&trainCode="
											+encodeURIComponent(trainCode)+"&trainKndCode="
											+encodeURIComponent(trainKnd.val())+"&trainNo="
											+encodeURIComponent(trainNo.val().replace(" "))+"&updUsr="
											+encodeURIComponent("${name}"),
									Type:"JSON",
									success : function(data) {
										if(data.errorCode == 0){
											/* 재검색 */
											if($("#deleteType").val() != ""){
												findTrainList($("#deleteType").val());
											}
											alert("수정이 완료되었습니다.");
										}else{
											alert("수정실패");
										}
									}
								}); /* ajax end */
								
								$(this).dialog("close");
							}
						},
						"취소": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
   			} /* 수정 end */
   			
   			/*삭제*/
   			function deleteTrain(){
				/*체크박스로 선택된 행의 ID들*/
   				var rowIds = $("#gridBody").getGridParam('selarrrow');
   				/*삭제할 역 코드 배열*/
				var deleteCodeArray = new Array();
				
				/*select check*/
				if(rowIds == ""){
					alert("삭제할 열차를 선택해야 합나디다.");
					return;
				}else{
					if(confirm("선택한 항목을 삭제하시겠습니까?")){
						/*deleteCodeArray에 역 코드 삽입*/
						for(var i = 0; i < rowIds.length; i++){
							deleteCodeArray.push($("#gridBody").getRowData(rowIds[i]).trainCode);
						}
						
						/*삭제할 정보를 name(deleteCodeArray)의 값에 설정*/
						$("input[name=deleteCodeArray]").val(deleteCodeArray);
						
						$.ajax({
							type:"POST",
							url: "/admin/trainProcess.do?state=delete&deleteCodeArray="
									+$("input[name=deleteCodeArray]").val(),
							Type:"JSON",
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
											doGridInit();
										}else{
											findTrainList($("#deleteType").val());
										}
									}
									
									alert("삭제가 완료되었습니다.");
								}else{
									/* 삭제되지 않은 ROW를 보여줌 */
									for(var i = 0; i < rowIds.length; i++){
										if($("#gridBody").getRowData(rowIds[i]).trainCode == data.errorMsg){
											alert(data.errorMsg+": "+$("#gridBody").getRowData(rowIds[i]).trainNo+"는 현재 사용중인 열차입니다.");
										}
									}
								}
							} /* success end */
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
			* 열차종류를 선택한 후 조회버튼을 이용해 열차정보를 조회할 수 있습니다.
			<br>
			* 열차번호를 입력한 후 조회버튼을 이용해 열차정보를 조회할 수 있습니다.
			<br>
			* 등록버튼을 이용하여 열차를 등록할 수 있습니다.
			<br>
			* 삭제할 열차정보를 체크박스로 선택한 후 석제버튼을 이용하여 열차정보를 삭제할 수 있습니다.
			<br>
			* 수정버튼을 이용하여 열차정보를 수정할 수 있습니다.
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
   							<button id="trainKndBtn" type="button" onclick="findTrainList('knd');" style="width: 95%; height: 25px;">조회</button>
   						</td>
   						
   						<!-- 열차번호로 검색 -->
   						<td style="width: 70px; padding-left: 32px; text-align: center;">
							<strong>열차번호</strong>
						</td>
   						<td style="width: 120px;">
   							<input id="trainNoText" type="text" style="width: 100%; height: 19px;">
   						</td>
   						<td style="width: 75px;">
   							<button id="trainNoBtn" type="button" onclick="findTrainList('trainNo');" style="width: 95%; height: 25px; margin-left: 5px;">조회</button>	
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
   		<div id="grid" style="margin: 0 auto; margin-top: 15px; width: 845px;">
   			<table id="gridBody"></table>
	   		<div id="footer"></div>
   		</div>
   		<!-- 등록 다이알로그 -->
   		<div id="addDialog" title="열차 등록" style="display: none;">
   			<table style="margin: 0 auto;">
				<tbody>
					<!-- 열차종류 선택 -->
					<tr>
						<td>
							<strong>열차종류</strong>
						</td>
						<td>
							<select id="addTrainKndSelect" name="trainKndCode" style="width: 167px;">
   								<option value="선택">선택</option>
   								<c:forEach var="value" items="${commonCodeList}">
	   								<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
   								</c:forEach>
   							</select>
						</td>
					</tr>
					
					<!-- 열차번호 입력-->
					<tr>
						<td>
							<strong>열차번호</strong>
						</td>
						<td>
							<input id="addTrainNoText" name="trainNo" type="text" style="width: 163px;">
						</td>
					</tr>
				</tbody> <!-- tbody end -->
			</table> <!-- table end -->
		</div> <!-- addDialog -->
		
   		<!-- 수정 다이알로그 -->
   		<div id="updateDialog" title="열차 수정" style="display: none;">
   			<table style="margin: 0 auto;">
				<tbody>
					<!-- 열차종류 선택 -->
					<tr>
						<td>
							<strong>열차종류</strong>
						</td>
						<td>
							<select id="updateTrainKndSelect" name="trainKndCode" style="width: 167px;">
   								<option value="선택">선택</option>
   								<c:forEach var="value" items="${commonCodeList}">
	   								<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
   								</c:forEach>
   							</select>
						</td>
					</tr>
					
					<!-- 열차번호 입력-->
					<tr>
						<td>
							<strong>열차번호</strong>
						</td>
						<td>
							<input id="updateTrainNoText" name="trainNo" type="text" style="width: 163px;">
						</td>
					</tr>
				</tbody> <!-- tbody end -->
			</table> <!-- table end -->
		</div> <!-- updateDialog -->
		
		<!-- 삭제 -->
		<div>
			<!-- 삭제로 상태설정 -->
  			<input type="hidden" name="state" value="delete">
			<!-- 삭제할 열차 코드들 -->
  			<input type="hidden" name="deleteCodeArray">
		</div>
	</body>
</html>