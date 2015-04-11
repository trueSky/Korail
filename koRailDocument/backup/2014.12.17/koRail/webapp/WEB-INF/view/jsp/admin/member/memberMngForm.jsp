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
   			var srcDate1 = "";   /* 시작 날짜 */
   			var srcDate2 = "";   /* 끝 날짜 */
   			
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(2)).addClass("set");
				$($(".lmb tr").get(3)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual13.jpg");
				
	   			/*엔터*/
				$("#srcText").keydown(function(e){
					if(e.keyCode == 13){
						$("#searchBtn").click();
					}
				});
	   			
	   			/*그리드 초기상태*/
				doGridInit();
	   		});
   			
	   		/*그리드 초기상태*/
   			function doGridInit(){
	   			viewState = false;
	   			
	   			/* 초기화 */
	   			$("#grid").html("<table id='gridBody'></table><div id='footer'><div>");
	   			
   				$("#gridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"회원정보",
	   				width: 500,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["state", "아이디", "성명", "가입일", "개인정보 수정일"],
	          		colModel : [
						{ name : "state", hidden:true},
						{ name : "id", align:"center", width: 60, height : 200, sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=4';
							}
						},
						{ name : "nm", width: 70, align:"center", sortable:false},
						{ name : "rgsde", width: 70, align:"center", sortable:false},
						{ name : "updde", width: 70, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
				
   				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").jqGrid('addRowData', 0, {id:"회원을 검색해야 합니다."});
	   		} /* doGridInit end */
	   		
	   		/* 그리드 생성 */
	   		function setGrid(){
	   			viewState = true;
   				
	   			/* 초기화 */
	   			$("#grid").html("<table id='gridBody'></table><div id='footer'><div>");
	   			
   				$("#gridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"회원정보",
	   				multiselect: true,
	   				width: 500,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["state", "아이디", "성명", "zipCode", "addrs",
	   				       "detailAddrs", "telNo", "mbtlnum", "email",
	   				    	"gndr", "가입일", "개인정보 수정일"
	   				],
	          		colModel : [
						{ name : "state", hidden:true},
						{ name : "id", align:"center", width: 60, height : 200, sortable:false},
						{ name : "nm", width: 70, align:"center", sortable:false},
						{ name : "zipCode", hidden:true},
						{ name : "addrs", hidden:true},
						{ name : "detailAddrs", hidden:true},
						{ name : "telNo", hidden:true},
						{ name : "mbtlnum", hidden:true},
						{ name : "emal", hidden:true},
						{ name : "gndr", hidden:true},
						{ name : "rgsde", width: 70, align:"center", sortable:false},
						{ name : "updde", width: 70, align:"center", sortable:false}
					],
					/*row click*/
					onCellSelect: function(rowId,indexColumn,cellContent,eventObject){
						$("#id").html($(this).getRowData(rowId).id);
						$("#nm").html($(this).getRowData(rowId).nm);
						$("#zipCode").html($(this).getRowData(rowId).zipCode);
						$("#addrs").html($(this).getRowData(rowId).addrs);
						$("#detailAddrs").html($(this).getRowData(rowId).detailAddrs);
						$("#telNo").html($(this).getRowData(rowId).telNo);
						$("#mbtlnum").html($(this).getRowData(rowId).mbtlnum);
						$("#email").html($(this).getRowData(rowId).emal);
						$("#gndr").html($(this).getRowData(rowId).gndr);
						$("#rgsde").html($(this).getRowData(rowId).rgsde);
						$("#pdde").html($(this).getRowData(rowId).updde);
					}
				}); /*jqGrid end*/
	   		}
	   		
	   		/* 날짜검색 다이알로그 */
	   		function setDataDialog(){
	   			/* 변수 초기화 */
	   			srcDate1 = "";
	   			srcDate2 = "";
	   			
	   			/* HTML 초기화 */
   				$("#startYear").html("");
   				$("#endYear").html("");
   				
   				/* 01월 선택 */
   				$("#startMonth :first-child").attr("selected", "selected");
   				$("#endMonth :first-child").attr("selected", "selected");
   				
   				/* 년도 설정 : 년도는 현재년도와 다음년도를 선택할수 있다. */
   				$("#startYear").append('<option value="'+new Date().getFullYear()+'">'+(new Date().getFullYear()-1)+'</option>');
   				$("#startYear").append('<option value="'+new Date().getFullYear()+'">'+new Date().getFullYear()+'</option>');
   				$("#startYear").append('<option value="'+(new Date().getFullYear()+1)+'">'+(new Date().getFullYear()+1)+'</option>');
   				$("#endYear").append('<option value="'+new Date().getFullYear()+'">'+(new Date().getFullYear()-1)+'</option>');
   				$("#endYear").append('<option value="'+new Date().getFullYear()+'">'+new Date().getFullYear()+'</option>');
   				$("#endYear").append('<option value="'+(new Date().getFullYear()+1)+'">'+(new Date().getFullYear()+1)+'</option>');
   				
   				/* 현재년도 설정 */
   				$("#startYear").children("option[value='"+new Date().getFullYear()+"']").attr("selected", "selected");
	   			$("#endYear").children("option[value='"+new Date().getFullYear()+"']").attr("selected", "selected");
	   			
   				/* 나짜설정 */
   				setDate("all");
   				
	   			/*다이알로그*/
   				$("#dateDialog").dialog({
   					modal: true,
   					width: 340,
					buttons: {
						"등록": function() {
							srcDate1 = $("#startYear").val()+"-"+$("#startMonth").val()+"-"+$("#startDate").val();
							srcDate2 = $("#endYear").val()+"-"+$("#endMonth").val()+"-"+$("#endDate").val();
							
							findMemberList($("input[name=dtype]:checked").val());
							
							$(this).dialog("close");
						},
						"취소": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
	   		}
	   		
	   		/* 날짜 설정 */
	   		function setDate(mode){
	   			/* 시작날짜 설정 */
	   			if(mode == "start" || mode == "all"){
	   				/* 년과 월에 대한 날짜 */
	   				var newStartDate = new Date($("#startYear").val(), $("#startMonth").val(), "");
	   				
	   				$("#startDate").html("");
	   				
	   				for(var i = 1; i <= newStartDate.getDate(); i++){
	   					if(i < 10){
	   	   					$("#startDate").append('<option value="0'+i+'">0'+i+'</option>');   						
	   					}else{
	 	  					$("#startDate").append('<option value="'+i+'">'+i+'</option>');
	   					}
	   				}
	   			}
				/* 끝 날짜 설정 */
	   			if(mode == "end" || mode == "all"){
	   				/* 년과 월에 대한 날짜 */
	   				var newEndDate = new Date($("#endYear").val(), $("#endMonth").val(), "");
	   				
	   				$("#endDate").html("");
	   				
	   				for(var i = 1; i <= newEndDate.getDate(); i++){
	   					if(i < 10){
	   	   					$("#endDate").append('<option value="0'+i+'">0'+i+'</option>');   						
	   					}else{
	 	  					$("#endDate").append('<option value="'+i+'">'+i+'</option>');
	   					}
	   				}	
	   			}
	   		}
	   		
	   		/*리스트*/
			function findMemberList(mode){
	   			var vURL = "";
	   			
	   			/* HTML 초기화 */
	   			$("#id").html("--");
				$("#nm").html("--");
				$("#zipCode").html("--");
				$("#addrs").html("--");
				$("#detailAddrs").html("--");
				$("#telNo").html("--");
				$("#mbtlnum").html("--");
				$("#email").html("--");
				$("#gndr").html("--");
				$("#rgsde").html("--");
				$("#pdde").html("--");
	   			
	   			/* 날짜 검색 */
	   			if(mode == "rgsde"){
	   				/* 삭제할 시 제검색 유형 설정 */
	   				$("#deleteType").val("rgsde");
	   				vURL = "/admin/memberList.do?srcType=rgsde&srcDate1="+srcDate1+"&srcDate2="+srcDate2;
	   			}else if(mode == "updde"){
	   				/* 삭제할 시 제검색 유형 설정 */
	   				$("#deleteType").val("updde");
	   				vURL = "/admin/memberList.do?srcType=updde&srcDate1="+srcDate1+"&srcDate2="+srcDate2;
	   			}
	   			/* 일반 검색 */
	   			else{
	   				/* 삭제할 시 제검색 유형 설정 */
	   				$("#deleteType").val("normal");
	   				
					/*검색조건*/
		   			var srcType = $("#srcType").val();	  			/* 검색유형 */
		   			var srcText = $("#srcText").val().replace(" ");	/* 검색어 */
		   			
		   			if(srcText == ""){
						alert("조회조건을 입력해야 합나디다.");
						return;
		   			}else{
		   				vURL = "/admin/memberList.do?srcType="+srcType+"&srcText="+srcText;
		   			}
	   			}
		   		
				/*그리드 내용*/				
				$.ajax({
					type:"POST",
					url: vURL,
					Type:"JSON",
					success : function(data) {
						if(data.memberListSize == 0){
							alert("결과가 존재하지 않습니다.");
						}else{
							/*그리드 재생성*/
							if(!viewState){
								setGrid();
							} /*if end*/
							
							/*그리드 비우기*/
							$("#gridBody").jqGrid('clearGridData');
							
							/*데이터 삽입*/
							$.each(data.memberList, function(k,v){
								$("#gridBody").jqGrid('addRowData', k,
									{
										state:v.state,
										id:v.id,
										nm:v.nm,
										zipCode:v.zipCode.replace(",", "-"),
										addrs:v.addrs,
										detailAddrs:v.detailAddrs,
										telNo:v.telNo,
										mbtlnum:v.mbtlnum,
										emal:v.emal,
										gndr:v.gndr,
										rgsde:v.rgsde,
										updde:v.updde
									}
								); /*addRowData end*/
							}); /*$.each end*/
						} /*else end*/
					} /*success end*/
				}); /*$.ajax end*/
			} /*findMemberList end*/
			
   			/*삭제*/
   			function deleteMember(){
   				/*체크박스로 선택된 행의 ID들*/
   				var rowIds = $("#gridBody").getGridParam('selarrrow');
   				/*삭제할 역 코드 배열*/
				var deleteCodeArray = new Array();
				
				/*select check*/
				if(rowIds == ""){
					alert("삭제할 회원을 선택해야 합니다.");
					return;
				}else{
					if(confirm("선택한 항목을 삭제하시겠습니까?")){
						/*deleteCodeArray에 역 코드 삽입*/
						for(var i = 0; i < rowIds.length; i++){
							deleteCodeArray.push($("#gridBody").getRowData(rowIds[i]).id);
						}
						
						/*삭제할 정보를 name(deleteCodeArray)의 값에 설정*/
						$("input[name=deleteCodeArray]").val(deleteCodeArray);
						
						$.ajax({
							type:"POST",
							url: "/admin/memberProcess.do?deleteCodeArray="
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
											
											/* HTML 초기화 */
								   			$("#id").html("--");
											$("#nm").html("--");
											$("#zipCode").html("--");
											$("#addrs").html("--");
											$("#detailAddrs").html("--");
											$("#telNo").html("--");
											$("#mbtlnum").html("--");
											$("#email").html("--");
											$("#gndr").html("--");
											$("#rgsde").html("--");
											$("#pdde").html("--");
										}else{
											findMemberList($("#deleteType").val());
										}
									}
									
									alert("삭제가 완료되었습니다.");
								}else{
									/* 삭제되지 않은 ROW를 보여줌 */
									for(var i = 0; i < rowIds.length; i++){
										if($("#gridBody").getRowData(rowIds[i]).id == data.errorMsg){
											alert(data.errorMsg+" 는(은) 현재 사용중인 아이디 입니다.");
										}
									}
								}
							} /* success end */
						}); /* ajax end */
					} /* if end */
				} /* else end */
   			} /* deleteMember end */
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
			* 아이디 또는 성명으로 회원을 회원을 조회할 수 있습니다.
			<br>
			* 날짜검색을 통해 가입일 또는 개인정보 수정일을 조회할 수 있습니다.
			<br>
			* 모곡을 선택하여 회원정보를 삭제할 수 있습니다.
			<br>
			* 특정행을 선택하면 그 행에 대한 상세 정보를 볼 수 있습니다.
   		</div>
   		
   		<!-- search -->
   		<div id="serch">
   			<table class="search-group">
   				<tbody>
   					<tr>
   						<!-- 검색 -->
   						<td style="width: 100px; padding-left: 15px;">
   							<select id="srcType" style="width: 100%; height: 25px">
   								<option value="id">아이디</option>
   								<option value="name">성명</option>
   							</select>
   						</td>
   						<td style="width: 120px;">
   							<input id="srcText" type="text" style="width: 95%; height: 19px;">
   						</td>
   						<td style="width: 75px;">
   							<button id="searchBtn" onclick="findMemberList('normal');" type="button" style="width: 100%; height: 25px;">검색</button>
   						</td>
   						<!-- 날짜검색 -->
   						<td style="width: 90px;">
   							<button onclick="setDataDialog();" type="button" class="btn" style="width: 95%; height: 25px; margin-left: 3px;">날짜검색</button>
   						</td>
   						<!-- , 삭제버튼 -->
   						<td style="width: 75px; padding-left: 30px; padding-right: 10px;">
   							<button onclick="deleteMember();" type="button" class="btn" style="width: 95%; height: 25px;">삭제</button>
   							<input id="deleteType" type="hidden">
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
   		
   		<div>
   			<table class="d-table">
   				<colgroup>
   					<col width="15%">
   					<col width="35%">
   					<col width="15%">
   					<col width="35%">
   				</colgroup>
   				<thead>
   					<tr>
   						<td colspan="6">상세정보</td>
   					</tr>
   				</thead>
   				<tbody>
   					<tr>
   						<td>아이디</td>
   						<td id="id">--</td>
   						<td>성명</td>
   						<td id="nm">--</td>
   					</tr>
   					<tr>
   						<td>가입일</td>
   						<td id="rgsde">--</td>
   						<td>개인정보 수정일</td>
   						<td id="updde">--</td>
   					</tr>
   					<tr>
   						<td>전화번호</td>
   						<td id="telNo">--</td>
   						<td>휴대전화번호</td>
   						<td id="mbtlnum">--</td>
   					</tr>
   					<tr>
   						<td>이메일</td>
   						<td id="email">--</td>
   						<td>성별</td>
   						<td id="gndr">--</td>
   					</tr>
   					<tr>
   						<td>우편번호</td>
   						<td id="zipCode">--</td>
   						<td>주소</td>
   						<td id="addrs">--</td>
   					</tr>
   					<tr>
   						<td>상세주소</td>
   						<td id="detailAddrs" colspan="5">--</td>
   					</tr>
   				</tbody>
   			</table>
   		</div>
		
		<div id="dateDialog" title="날짜검색" style="display: none;">
			<!-- 검색 형식 -->
			<div style="width: 200px; margin: 0 auto;">
				<input value="rgsde" style="vertical-align: middle;" type="radio" name="dtype" checked="checked">
					<label style="vertical-align: middle;">가입일</label>
				<input value="updde" style="vertical-align: middle;" type="radio" name="dtype">
					<label style="vertical-align: middle;">개인정보 수정일</label>
			</div>
			<!-- 날짜 -->
			<table class="date-time-table" style="margin-top: 5px;">
				<tbody>
					<!-- 시작날짜 -->
					<tr>
						<td>시작날짜</td>
						<td>
							<select id="startYear" onchange="setDate('start');" style="width: 65px;">
   								<!-- script -->
   							</select>
						</td>
						<td>년</td>
						<td>
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
						</td>
						<td>월</td>
						<td>
							<select id="startDate" style="width: 55px;">
   								<!-- script -->
   							</select>
						</td>
						<td>일</td>
					</tr>
					<!-- 끝 날짜 -->
					<tr>
						<td>끝 날짜</td>
						<td>
							<select id="endYear" onchange="setDate('end');" style="width: 65px;">
   								<!-- script -->
   							</select>
						</td>
						<td>년</td>
						<td>
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
						</td>
						<td>월</td>
						<td>
							<select id="endDate" style="width: 55px;">
   								<!-- script -->
   							</select>
						</td>
						<td>일</td>
					</tr>
				</tbody> <!-- tbody end -->
			</table> <!-- table end -->
		</div>
		
		<!-- 삭제 -->
		<div>
			<!-- 삭제할 역 코드들 -->
   			<input type="hidden" name="deleteCodeArray">			
		</div>
	</body>
</html>