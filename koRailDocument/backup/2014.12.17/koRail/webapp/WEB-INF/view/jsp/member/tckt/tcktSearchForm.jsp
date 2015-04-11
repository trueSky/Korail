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
				$($(".menu td").get(1)).addClass("set");
				$($(".lmb tr").get(0)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual01.jpg");
				
				
				
				
				
				
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
							/* { name : 'startStatnValue', width: 70, align:"center", sortable:false,
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=8';
								}
							}, */
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
				$("#gridBody").jqGrid('addRowData', 1,
					{
						//trainNo:"승차권을 조회하시기 바랍니다."
						trainNo:"141",
						trainKnd:"무궁화호",
						startStatnValue:"서울",
						startTm:"2014-10-31 13:10",
						arvlStatnValue:"부산",
						arvlStatnTm:"2014-10-31 15:58",
						prtclrRoomY:"<button>예약하기</button>",
						prtclrRoomN:"<button>매진</button>",
						fare:"76,300 원"
					}
				);
				
				
				
	   		});
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
	   							<select style="width: 90%;">
	   								<option>어른 0명</option>
	   								<option>어른 1명</option>
	   							</select>
	   						</td>
	   						<td>
	   							<select style="width: 90%;">
	   								<option>장애 1~3 급 0명</option>
									<option>장애 1~3 급 1명</option>
	   							</select>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>
	   							<select style="width: 90%;">
	   								<option>어린이 0명</option>
	   								<option>어린이 1명</option>
	   							</select>
	   						</td>
	   						<td>
	   							<select style="width: 90%;">
	   								<option>장애 4-6 급 0명</option>
	   								<option>장애 4-6 급 1명</option>
	   							</select>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>
	   							<select style="width: 90%;">
	   								<option>경로 0명</option>
	   								<option>경로 1명</option>
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
	   				<thead>
	   					<tr>
	   						<td colspan="2">운행정보</td>
	   					</tr>
	   				</thead>
	   				<tbody>
	   					<tr>
	   						<td>열차종류</td>
	   						<td>
	   							<select style="width: 90%;">
	   								<option>전채</option>
	   								<option>KTX</option>
	   							</select>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>여정경로</td>
	   						<td>
	   							<select style="width: 90%;">
	   								<option>직통</option>
	   							</select>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>출발역</td>
	   						<td>
	   							<button style="height: 20px; float: right;">검색</button>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>도착역</td>
	   						<td>
	   							<button style="height: 20px; float: right;">검색</button>
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
	   			<button>조회</button>
	   		</div>
   		</div> <!-- search-group end -->
   		
   		<!-- 그리드 -->
   		<div id="grid" style="margin-top: 7px; clear: left;">
   			<table id="gridBody"></table>
   		</div>
	</body>
</html>