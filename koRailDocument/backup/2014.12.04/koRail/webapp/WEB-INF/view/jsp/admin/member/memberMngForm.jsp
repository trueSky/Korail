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
				$($(".menu td").get(2)).addClass("set");
				$($(".lmb tr").get(3)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual13.jpg");
				
	   			/*등록 다이알로그 */
	   			$("#addBtn").click(addStatn);
	   			
	   			/*삭제 버튼*/
	   			$("#deleteBtn").click(deleteStatn);

	   			/*엔터*/
				$("#statnNmText").keydown(function(e){
					if(e.keyCode == 13){
						$("#statnNmBtn").click();
					}
				});
	   			
	   			/*그리드 초기상태*/
				$("#gridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"역 리스트",
	   				width: 695,
	   				height: 230,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["수정", "역 코드", "지역", "역 명", "등록자", "등록일", "수정자", "수정일"],
	          		colModel : [
						{ name : "update", align:"center", width: 60, height : 200,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=8';
							}
						},
						{ name : 'statnCode', width: 70},
						{ name : 'areaName', width: 70, align:"center"},
						{ name : 'statnNm', width: 70, align:"center"},
						{ name : 'register', width: 70, align:"center"}, 
						{ name : 'rgsde', width: 110, align:"center"},
						{ name : 'updUser', width: 70, align:"center"},
						{ name : 'updde', width: 110, align:"center"}
					],
					afterInsertRow: function(rowId,rowData,rowElement){
						$("button").button();
					}
				}); /*jqGrid end*/
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").jqGrid('addRowData', 1, {update:"조회조건을 선택/입력하여 조회를 하십시오."});
	   		});
	   		
	   		/*리스트*/
			function findStatnList(mode){
				var vUrl = ""; /*url*/
				
				/*검색조건*/
	   			var area = $("#areaSelect").val().trim();	  /*지역*/
	   			var statnNm = $("#statnNmText").val().trim(); /*역 명*/
	   			
	   			/*지역으로 검색*/
				if(mode == "area"){
					if(area == "선택"){
						alert("조회조건을 선택해야 합나디다.");
						return;
					}else{
						vUrl = "/admin/statnList.do?srcType="+area;
					}
				}
				/*역 명으로 검색*/
				else{
					if(statnNm == ""){
						alert("조회조건을 입력해야 합나디다.");
						return;
					}else{
						vUrl = "/admin/statnList.do?srcText="+encodeURIComponent(statnNm);
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
							if(data.statnListSize == 0){
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
						   				caption:"역 리스트",
						   				width: 695,
						   				height: 230,
						   				scroll: 1,
						   				rowNum : 'max',
						   				pager: '#footer',
						   				colNames:["수정", "역 코드", "지역", "역 명", "등록자", "등록일", "수정자", "수정일"],
						          		colModel : [
											{ name : "update", align:"center", width: 60, height : 200},
											{ name : 'statnCode', width: 120, align:"center"},
											{ name : 'areaName', width: 70, align:"center"},
											{ name : 'statnNm', width: 70, align:"center"},
											{ name : 'register', width: 70, align:"center"}, 
											{ name : 'rgsde', width: 110, align:"center"},
											{ name : 'updUsr', width: 70, align:"center"},
											{ name : 'updde', width: 110, align:"center"}
										],
										gridComplete: function(){
											$("button").button();
										}
									}); /*jqGrid end*/
								} /*if end*/
								
								/*그리드 비우기*/
								$("#gridBody").jqGrid('clearGridData');
								
								/*데이터 삽입*/
								$.each(data.statnList, function(k,v){
									$("#gridBody").jqGrid('addRowData', k+1,
										{
										update:"<button type='button'"
													+"style='margin-top: 2px;"
													+"margin-bottom: 3px;'"
													+"onclick=updateStatn('"+v.statnCode+"','"+v.areaCode+"','"+v.statnNm+"')>수정</button>",
											statnCode:v.statnCode+"",
											areaName:v.areaName+"",
											statnNm:v.statnNm+"",
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
			} /*findStatnList end*/
			
			/*등록 다이알로그 */
   			function addStatn(){
   				var area = $("#addAreaSelect");
   				var statnNm = $("#addStatnNmText");
				
   				/*초기화*/
				area.children(":first-child").attr("selected", "selected");
				statnNm.val("");
				
				/*다이알로그*/
   				$("#addDialog").dialog({
   					modal: true,
					buttons: {
						"등록": function() {
							/*미입력 처리*/
							if(area.val() == "선택"){
								alert("역을 선택해야합니다.");
							}else if(statnNm.val().trim() == ""){
								alert("모든 항목은 필수입력 사항입니다.");
							}
							/*conForm 생성(확인 : 등록, 취소 : 상태유지)*/
							else if(confirm("이 역 정보를 등록하시겠습니까?")){
								$("#addForm").submit();
								
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
   			function updateStatn(statnCode, areaCode, vStatnNm){
   				var area = $("#updateAreaSelect");
   				var statnNm = $("#updateStatnNmText");
				
   				/*정보설정*/
				area.children("option[value='"+areaCode+"']").attr("selected", "selected");
   				statnNm.val(vStatnNm);
				
				/*다이알로그*/
   				$("#updateDialog").dialog({
   					modal: true,
					buttons: {
						"수정": function() {
							/*미입력 처리*/
							if(area.val() == "선택"){
								alert("역을 선택해야합니다.");
							}else if(statnNm.val().trim() == ""){
								alert("모든 항목은 필수입력 사항입니다.");
							}
							/*conForm 생성(확인 : 등록, 취소 : 상태유지)*/
							else if(confirm("이 역 정보를 등록하시겠습니까?")){
								/*역코드 설정*/
								$("input[name='statnCode']").val(statnCode);
								
								$("#updateForm").submit();
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
   			function deleteStatn(){
				/*체크박스로 선택된 행의 ID들*/
   				var rowIds = $("#gridBody").getGridParam('selarrrow');
   				/*삭제할 역 코드 배열*/
				var deleteCodeArray = new Array();
				
				/*select check*/
				if(rowIds == ""){
					alert("삭제할 역을 선택해야 합나디다.");
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
			* 지역을 선택한 후 조회버튼을 이용해 역정보를 조회할 수 있습니다.
			<br>
			* 역명을 입력한 후 조회버튼을 이용해 역정보를 조회할 수 있습니다.
			<br>
			* 등록버튼을 이용하여 역정보를 등록할 수 있습니다.
			<br>
			* 삭제할 역정보를 체크박스로 선택한 후 석제버튼을 이용하여 역정보를 삭제할 수 있습니다.
			<br>
			* 수정버튼을 이용하여 역정보를 수정할 수 있습니다.
   		</div>
   		
   		<!-- search -->
   		<div id="serch" >
   			<table class="search-group">
   				<tbody>
   					<tr>
   						<!-- 지역으로 검색 -->
   						<td style="width: 50px; height: 25px; text-align: center;">
   							<strong>지역</strong>
   						</td>
   						<td style="width: 100px; padding-left: 0px;">
   							<select id="areaSelect" style="width: 100%; height: 25px">
   								<option value="선택">선택</option>
   								<c:forEach var="value" items="${commonCodeList}">
	   								<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
   								</c:forEach>
   							</select>
   						</td>
   						<td style="width: 75px;">
   							<button id="areaBtn" type="button" onclick="findStatnList('area');" style="width: 100%; height: 25px;">조회</button>
   						</td>
   						
   						<!-- 역 명으로 검색 -->
   						<td style="width: 50px; padding-left: 32px; text-align: center;">
   							<strong>역 명</strong>
   						</td>
   						<td style="width: 120px;">
   							<input id="statnNmText" type="text" style="width: 100%; height: 19px;">
   						</td>
   						<td style="width: 75px;">
   							<button id="statnNmBtn" type="button" onclick="findStatnList('statnNm');" style="width: 100%; height: 25px;">조회</button>	
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
   		<div id="grid" style="margin: 0 auto; margin-top: 15px; width: 695px;">
   			<table id="gridBody"></table>
	   		<div id="footer"></div>
   		</div>
   		<!-- 등록 다이알로그 -->
   		<div id="addDialog" title="역 등록" style="display: none;">
   			<form id="addForm" action="/admin/statnProcess.do" method="post">
   				<!-- 등록으로 상태설정 -->
   				<input type="hidden" name="state" value="insert">
   				<!-- 등록자 설정 (등록자는 현재 로그인한 회원명으로 등록된다.) -->
   				<input type="hidden" name="register" value="${name}">   				
				
				<table style="margin: 0 auto;">
					<tbody>
						<!-- 지역 선택 -->
						<tr>
							<td>
								<strong>지역</strong>
							</td>
							<td>
								<select id="addAreaSelect" name="areaCode" style="width: 167px;">
	   								<option value="선택">선택</option>
	   								<c:forEach var="value" items="${commonCodeList}">
		   								<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
	   								</c:forEach>
	   							</select>
							</td>
						</tr>
						
						<!-- 역 명 입력-->
						<tr>
							<td>
								<strong>역 명</strong>
							</td>
							<td>
								<input id="addStatnNmText" name="statnNm" type="text" style="width: 163px;">
							</td>
						</tr>
					</tbody> <!-- tbody end -->
				</table> <!-- table end -->
			</form> <!-- addForm end -->
		</div> <!-- addDialog -->
		
   		<!-- 수정 다이알로그 -->
   		<div id="updateDialog" title="역 수정" style="display: none;">
   			<form id="updateForm" action="/admin/statnProcess.do" method="post">
   				<!-- 수정으로 상태설정 -->
   				<input type="hidden" name="state" value="update">
   				<!-- 수정자 설정 (수정자는 현재 로그인한 회원명으로 등록된다.) -->
   				<input type="hidden" name="updUser" value="${name}">
   				<!-- 수정할 역 코드 -->
   				<input type="hidden" name="statnCode">   				
				
				<table style="margin: 0 auto;">
					<tbody>
						<!-- 지역 선택 -->
						<tr>
							<td>
								<strong>지역</strong>
							</td>
							<td>
								<select id="updateAreaSelect" name="areaCode" style="width: 167px;">
	   								<option value="선택">선택</option>
	   								<c:forEach var="value" items="${commonCodeList}">
		   								<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
	   								</c:forEach>
	   							</select>
							</td>
						</tr>
						
						<!-- 역 명 입력-->
						<tr>
							<td>
								<strong>역 명</strong>
							</td>
							<td>
								<input id="updateStatnNmText" name="statnNm" type="text" style="width: 163px;">
							</td>
						</tr>
					</tbody> <!-- tbody end -->
				</table> <!-- table end -->
			</form> <!-- updateForm end -->
		</div> <!-- updateDialog -->
		
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