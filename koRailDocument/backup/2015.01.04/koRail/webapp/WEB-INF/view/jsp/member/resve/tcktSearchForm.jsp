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
			.sell-out {
				background-color: #ED4C00;
			}
			
			.sell-out:HOVER {
				color: #FFFFFF;
				background-color: #FF8224;
			}
			
			.sell-out:ACTIVE {
				background-color: #FFFFFF;
				color: #000000;
			}
			#roomList td{
				font-weight: bold;
				padding-left: 15px;
				padding-right: 15px;
				padding-top: 5px;
				padding-bottom: 5px;
				border: 1px solid #FFFFFF;
				border-radius: 7px;
				text-align: center;
				cursor:pointer;
				cursor:hand;
			}
			#roomList td:HOVER{
				background: #515151;
			}
			#roomList .action{
				background: #515151;
			}
			#seatList p {
				font-weight: bold;
				padding-left: 7px;
				padding-right: 7px;
				padding-top: 5px;
				padding-bottom: 5px;
				margin: 5px;
				border-radius: 7px;
				text-align: center;
				cursor:pointer;
				cursor:hand;
			}
			#seatList .def {
				background: #65FF5E;
			}
			#seatList .slt {
				background: #6CC0FF;
			}
			#seatList .non {
				background: #515151;
				cursor:default;
			}
		</style>
	
   		<script type="text/javascript">
   			var viewState = false;		/* 그리드 생성싱테 : true 생성됨, false 생성되 않음 */
   			var seatNoArray = "";		/* 좌석정보 */
   			var psngrKndArray = null;	/* 승객유형별 인원수만큼의 코드 */
   			
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(1)).addClass("set");
				$($(".lmb tr").get(0)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual01.jpg");
				
				/* 날짜설정 */
				setYear();
				
				/* 초기그리드 */
				doGridInit();
	   		});
	   		
	   		/* 년도 설정 : 년도는 현재년도와 다음년도를 선택할수 있다. */
	   		function setYear(dateTime){
	   			var dateTime = new Date();
	   			
	   			$("#year").html("");
   				$("#year").append('<option value="'+(dateTime.getFullYear()-1)+'">'+(new Date().getFullYear()-1)+'</option>');
   				$("#year").append('<option value="'+dateTime.getFullYear()+'">'+new Date().getFullYear()+'</option>');
   				$("#year").append('<option value="'+(dateTime.getFullYear()+1)+'">'+(new Date().getFullYear()+1)+'</option>');
	   		
   				/* 날짜 설정 */
   				setDateTime();
   				
   				/* 현재날짜 자동선택 */
   				$("#month").children("option[value="+(dateTime.getMonth()+1)+"]").attr("selected", "selected");
   				$("#date").children("option[value="+dateTime.getDate()+"]").attr("selected", "selected");
   				$("#hh24").children("option[value="+dateTime.getHours()+"]").attr("selected", "selected");
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
						{ name : 'trainNo', width: 70, align:"center", sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=9';
							}
						},
						{ name : 'trainKnd', width: 90, align:"center", sortable:false},
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
				$("#gridBody").jqGrid('addRowData', 1, {trainNo:"승차권을 조회하시기 바랍니다."});
	   		}
	   		
	   		/* 역 검색 다이알로그 */
   			function setStatnDialog(type){
   				/*input 초기화*/
   				$("#dStatnName").val("");
   				$("#rowData1").val("");
				$("#rowData2").val("");
   				
   				/*그리드 초기화*/
				$("#statnGrid").html("<table id='statnGridBody'></table>");
   				
				$("#statnGridBody").jqGrid({
					datatype: "LOCAL",
					caption:"역 정보",
		   			width: 320,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				colNames:["선택", "역 코드", "역 명"],
	          		colModel : [
						{ name : "select", width: 20, align:"center", sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=3';
							}
						},						
						{ name : "statnCode", hidden:true},
						{ name : "statnNm", width: 70, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
				
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#statnGridBody").jqGrid('addRowData', 1, {select:"역 명으로 역을 검색할수 있습니다."});
   				
   				/*다이알로그*/
   				$("#statnDialog").dialog({
   					modal: true,
   					width: 350,
					buttons: {
						"등록": function() {
							if($("#rowData1").val() == ""){
								alert("역을 선택해야 합니다.");
							}else{
								/* 출발역 */
								if(type == "start"){
									$("#startStatnCode").val($("#rowData1").val());
									$("#startStatnValue").val($("#rowData2").val());
								}
								/* 도착역 */
								else{
									$("#arvlStatnCode").val($("#rowData1").val());
									$("#arvlStatnValue").val($("#rowData2").val());
								}
								
								$(this).dialog("close");	
							}
						},
						"취소": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
   			}
	   		
   			/* 역 검색 */
   			function findStatnList(){
   				/* 미입력 처리 */
				if($("#dStatnName").val().replace(" ", "") == ""){
					alert("검색할 역 명을 입력헤야 합니다.");
					return;
				}
				/*그리드 내용*/
				else{
					$.ajax({
						type:"GET",
						url: "/admin/statnList.do?srcText="+encodeURIComponent($("#dStatnName").val().replace(" ", "")),
						Type:"JSON",
						success : function(data) {
							if(data.statnListSize == 0){
								alert("결과가 존재하지 않습니다.");
							}else{
								/*그리드 초기화*/
								$("#statnGrid").html("<table id='statnGridBody'></table>");
									
								$("#statnGridBody").jqGrid({
									datatype: "LOCAL",
						   			caption:"역 정보",
						   			width: 320,
					   				height: 160,
					   				scroll: 1,
					   				rowNum : 'max',
					   				colNames:["선택", "역 코드", "역 명"],
					          		colModel : [
										{ name : "select", width: 20, align:"center", sortable:false},
										{ name : "statnCode", hidden:true},
										{ name : "statnNm", width: 70, align:"center", sortable:false}
									],
									/*row click*/
									onCellSelect :function(rowId,indexColumn,cellContent,eventObject){
										/*값 설정*/
										var statnCode = $(this).getRowData(rowId).statnCode;
										var statnName = $(this).getRowData(rowId).statnNm;
										
										/*라이도 버튼 자동선택*/
										$("input[value='"+statnCode+"']").click();
										
										$("#rowData1").val(statnCode);
										$("#rowData2").val(statnName);
									}
								}); /*jqGrid end*/
								
								/*데이터 삽입*/
								$.each(data.statnList, function(k,v){
									$("#statnGridBody").jqGrid('addRowData', k+1,
										{
											select:'<input type="radio" name="statnCode" value="'+v.statnCode+'">',
											statnCode:v.statnCode+"",
											statnNm:v.statnNm+""
										}
									); /*addRowData end*/
								}); /*$.each end*/
							} /*if end*/
						} /*success end*/
					}); /*$.ajax end*/
				} /*else end*/
   			}
	   		
	   		/* 승차권 예매를 위한 운행일정 조회 */
	   		function findTcktList(){
	   			/* 열차종류 */
	   			var trainKndCode = $("#trainKndSelect").val();
	   			/* 좌석수 */
	   			var seatCo = 0;
	   			
	   			/* 승객유형별 인원수만큼의 코드 */
	   			psngrKndArray = new Array();
	   			
	   			for(var i = 1; i < 6; i++){
	   				/* 승객유형별 인원수만큼의 코드 */
	   				for(var x = 0; x < parseInt($("#seatCoSelect"+i).val()); x++){
	   					/* 승객유형 및 장애인 등급 */
	   					var value = $("#seatCoSelect"+i).next().val().split(",");
	   					psngrKndArray.push(
	   						{
	   							psngrKndCode:value[0],
	   							dspsnGradCode:value[1]
	   						}		
	   					);
	   				}
	   				/* 총 인원수 */
	   				seatCo += parseInt($("#seatCoSelect"+i).val());	
	   			}
	   			/* 출발일 */
	   			var startTm = $("#year").val()+"-"+$("#month").val()+"-"+$("#date").val()+" "+$("#hh24").val();
	   			/*출발역*/
	   			var startStatn = $("#startStatnCode").val();
	   			/*도착역*/
	   			var arvlStatn = $("#arvlStatnCode").val();
	   			
	   			/* 검색조건 확인 */
	   			if(seatCo == 0){
	   				alert("인원수는 최소 1명 이상 선택해야 합니다.");
	   				return;
	   			}else if(seatCo > 9){
	   				alert("윈원수는 최대 9명까지 선택가능 합니다.");
	   				return;
	   			}else if(startStatn == ""){
	   				alert("출발역을 입력하셔야 합니다.");
	   				return;
	   			}else if(arvlStatn == ""){
	   				alert("도착역을 입력하셔야 합니다.");
	   				return;
	   			}
	   			
	   			/*그리드 내용*/				
				$.ajax({
					type:"POST",
					url: "/member/tcktList.do?trainKndCode="
							+trainKndCode+"&seatCo="
							+seatCo+"&startTm="
							+startTm+"&startStatnCode="
							+startStatn+"&arvlStatnCode="
							+arvlStatn,
					Type:"JSON",
					success : function(data) {
						if(data.tcktListSize == 0){
							alert("조회된 결과가 없습니다.");
							return;
						}else{
							/* 그리드 생성싱테에 따른 그리드 생성 */
				   			if(!viewState){
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
										{ name : 'startStatnValue', width: 70, align:"center", sortable:false},
										{ name : 'startTm', width: 120, align:"center", sortable:false},
										{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
										{ name : 'arvlTm', width: 120, align:"center", sortable:false},
										{ name : 'prtclrRoomY', width: 70, align:"center", sortable:false},
										{ name : 'prtclrRoomN', width: 70, align:"center", sortable:false},
										{ name : 'fare', width: 90, align:"right", sortable:false}
									]
								}); /*jqGrid end*/
				   			} /* if end */
							
							$.each(data.tcktList, function(k, v){
								/* 예약 버튼 */
								var yButton = "";
								var nButton = "";
								
								/* 예약가능 확인 */
								if(v.prtclrSeatYCo == v.prtclrRoomYCo){
									yButton = "<button class='sell-out'>매진</button>";
								}else{
									yButton = "<button onclick='setSeatInfoDialog(&quot;"+v.opratCode+"&quot;, &quot;Y&quot;, &quot;"+seatCo+"&quot;, &quot;"+k+"&quot;);'>예약하기</button>";
								}
								
								/* 예약가능 확인 */
								if(v.prtclrSeatNCo == v.prtclrRoomNCo){
									nButton = "<button class='sell-out'>매진</button>";
								}else{
									nButton = "<button onclick='setSeatInfoDialog(&quot;"+v.opratCode+"&quot;, &quot;N&quot;, &quot;"+seatCo+"&quot;, &quot;"+k+"&quot;);'>예약하기</button>";
								}
								
								$("#gridBody").jqGrid('addRowData', k,
									{
										trainNo:v.trainNo,
										trainKnd:v.trainKndValue,
										startStatnValue:v.startStatnValue,
										startTm:v.startTm,
										arvlStatnValue:v.arvlStatnValue,
										arvlTm:v.arvlTm,
										prtclrRoomY:yButton,
										prtclrRoomN:nButton,
										fare:v.fare.replace(" ", "")+" 원"
									}
								);
								
								/* 
								$.each(v.roomList, function(k2, v2){
									roomArray.push({
										roomCode:v2.roomCode,
										opratCode:v2.opratCode,
										room:v2.room+" 호실",
										seatCo:v2.seatCo,
										prtclrRoomYN:v2.prtclrRoomYN
									});
								}); 
								*/
							}); /* each end */
						} /* else end */
					} /* success end */
				}); /* ajax end */
	   		} /* findTcktList end */
	   		
	   		/* 좌석선택 다이알로그 */
	   		function setSeatInfoDialog(opratCode, prtclrRoomYN, searchCount, rowId){
	   			var data = $("#gridBody").getRowData(rowId); /* 선택한 예약정보 */
	   			seatNoArray = new Array(); 					 /* 좌석정보 */
	   			
	   			/* 초기화 */
	   			$("#roomList tbody").html("");
	   			
	   			/* 선택한 승차권의 기본정보 */
	   			if("Y" == prtclrRoomYN){
	   				$("#tcktInfo").html(
   		   				"열차정보:&nbsp;&nbsp;"+data.startStatnValue+"("+data.startTm+")&nbsp;&nbsp;▶&nbsp;&nbsp;"
   		   				+data.arvlStatnValue+"("+data.arvlTm+")&nbsp;&nbsp;"+data.trainNo+"&nbsp;&nbsp;"+data.trainKnd+"&nbsp;&nbsp;특실"
   		   			);
	   			}else{
	   				$("#tcktInfo").html(
   		   				"열차정보:&nbsp;&nbsp;"+data.startStatnValue+"("+data.startTm+")&nbsp;&nbsp;▶&nbsp;&nbsp;"
   		   				+data.arvlStatnValue+"("+data.arvlTm+")&nbsp;&nbsp;"+data.trainNo+"&nbsp;&nbsp;"+data.trainKnd+"&nbsp;&nbsp;일반실"
   		   			);
	   			}
	   			
	   			/*그리드 내용*/				
				$.ajax({
					type:"POST",
					url: "/member/tcktRoomInfo.do?opratCode="
						+opratCode+"&prtclrRoomYN="+prtclrRoomYN,
					Type:"JSON",
					success : function(data) {
						var i = 0; /* tr생성여부 */
						$.each(data.tcktRoomInfoList, function(k, v){
							if(i == 0){
			   					$("#roomList tbody").append("<tr></tr>");
			   				}
							
							/* 호실 생성 */
							$($("#roomList tbody tr").get(($("#roomList tbody tr").size()-1))).append(
								"<td onclick='setSeatNo(this, &quot;"+v.seatCo+"&quot;, &quot;"+searchCount+"&quot;);'>"+v.room+" 호실</td>"
							);
							
							i++;
							
							if(i == 5){
		   						i = 0; /* 호실이 5개이면 세로운 tr을 생성하기 위해 변수를 초기화 */
		   					}
						});
						
						$.each(data.seatNoList, function(k, v){
							seatNoArray.push({
								room:v.room+" 호실",
								seatNo:v.seatNo
							});
						});
						
						/* 첫번째 호실 클릭 */
						$("#roomList tbody :first-child :first").click();
					}
				});
	   			
	   			/*다이알로그*/
   				$("#seatInfoDialog").dialog({
   					modal: true,
   					width: 890,
					buttons: {
						"예약": function() {
							if($("#seatList .slt").size() < searchCount){
								alert("모든 좌석을 선택하셔야 합니다.\n선택가능한 좌석수는 최대"+searchCount+"자리까지 선택가능합니다.");
							}else{
								var sltSeatNoList = new Array(); /* 선택된 좌석들 */
								var jsonArray = new Array();	 /* json으로 변환할 배열 */
								
								for(var i = 0; i < $("#seatList .slt").size(); i++){
									sltSeatNoList.push($($("#seatList .slt").get(i)).text());
								}
								
								if(confirm("선택한 좌석("+sltSeatNoList+")으로 진행 하시겠습니까?")){
									/* 금액 ex) 원본형식: ......999,999 원, replace: ......999999 */
									var fare = data.fare.replace(",", "").split(" ")[0];
									
									/* 총 영수금액 */
									$("#allFrAmount").val((fare*sltSeatNoList.length));
									/* 예약매수 */
									$("#resveCo").val(sltSeatNoList.length);
									/* 운행코드 */
									$("#opratCode").val(opratCode);
									
									/* json */
									for(var i = 0; i < sltSeatNoList.length; i++){
										jsonArray.push({
											opratCode:opratCode,
											seatNo:sltSeatNoList[i],
											roomKndCode:"ROOM_"+prtclrRoomYN,
											psngrKndCode:psngrKndArray[i].psngrKndCode,
											dspsnGradCode:psngrKndArray[i].dspsnGradCode,
											room:$("#roomList .action").html().split(" ")[0],
											frAmount:fare
										});
									}
									$("#json").val(JSON.stringify({"detailResveList":jsonArray}));
									
									//$(this).dialog("close");
									$("#resveAddForm").submit();
								}
							}
						}
					}	
				});
	   		}
	   		
	   		/* 선택한 호실의 좌석설정 */
	   		function setSeatNo(obj, seatCo, searchCount){
	   			var charCode = 65; /* 좌석번호에 들어갈 문자 현재문자: A */
	   			
	   			/* 스타일 */
	   			$("#roomList td").removeClass("action");
	   			$(obj).addClass("action");
	   			
	   			$("#seatList tbody").html(""); /* 초기화 */
	   			
	   			/* 좌석생성 */
	   			for(var i = 0, x = 0; i < seatCo; i++, x++){
	   				var tag = ""; /* 테그 */
	   				
	   				if(seatCo == 60 && x == 15){
						x = 0;
						charCode++;

						if($("#seatList tbody tr").size() == 2){
							$("#seatList tbody").append(
								"<tr>"
									+"<td colspan='15'><p class='non' style='color: #000000; background:#FFFFFF;'>통로</p></td>"
								+"</tr>"
							);
						}
					}else if(seatCo == 56 && x == 14){
						x = 0;
						charCode++;

						if($("#seatList tbody tr").size() == 2){
							$("#seatList tbody").append(
								"<tr>"
									+"<td colspan='14'><p class='non' style='color: #000000; background:#FFFFFF;'>통로</p></td>"
								+"</tr>"
							);
						}
					}else if(seatCo == 35 && x == 12){
						x = 0;
 						charCode++;
 						
 						if($("#seatList tbody tr").size() == 1){
							$("#seatList tbody").append(
								"<tr>"
									+"<td colspan='12'><p class='non' style='color: #000000; background:#FFFFFF;'>통로</p></td>"
								+"</tr>"
							);
						}
 					}else if(seatCo == 26 && x == 9){
 						x = 0;
 						charCode++;	
 						
 						if($("#seatList tbody tr").size() == 1){
							$("#seatList tbody").append(
								"<tr>"
									+"<td colspan='9'><p class='non' style='color: #000000; background:#FFFFFF;'>통로</p></td>"
								+"</tr>"
							);
						}
 					}
	   				
	   				/* 구분선(통로) */
	   				if(seatCo == 26 && $("#seatList tbody tr").size() == 3 && x == 8){
	   					x = 0;
 						charCode++;
 						
 						$($("#seatList tbody tr").get($("#seatList tbody tr").size()-1)).append(
 								"<td style='bacground:non'></td>"
		   				);
					}else if(seatCo == 35 && $("#seatList tbody tr").size() == 3 && x == 11){
						x = 0;
 						charCode++;
 						
 						$($("#seatList tbody tr").get($("#seatList tbody tr").size()-1)).append(
		   					"<td style='bacground:non'></td>"
		   				);
					}
	   				
	   				if(x == 0){
						$("#seatList tbody").append("<tr></tr>");
					}
	   				
	   				/* 좌석생성 및 예약된 좌석 확인 */
	   				if(x < 9){
	   					tag = "<td onclick='setSeatNoSelect(this, &quot;"+searchCount+"&quot;);'>"
	   								+"<input type='hidden' value='0'>"
	   								+"<p class='def'>"+String.fromCharCode(charCode)+"0"+(x+1)+"</p>"
	   							+"</td>";
	   					
	   					for(var i2 = 0; i2 < seatNoArray.length; i2++){
	   						if(seatNoArray[i2].room == $(obj).html()){
	   							if(seatNoArray[i2].seatNo == String.fromCharCode(charCode)+"0"+(x+1)){
	   								tag = "<td>"
	   										+"<p class='non'>"+String.fromCharCode(charCode)+"0"+(x+1)+"</p>"
			   							+"</td>";
		   							break;
		   						}
	   						}
	   					}
	   				}else{
	   					tag = "<td onclick='setSeatNoSelect(this, &quot;"+searchCount+"&quot;);'>"
	   								+"<input type='hidden' value='0'>"
									+"<p class='def'>"+String.fromCharCode(charCode)+(x+1)+"</p>"
								+"</td>";
	   					
	   					for(var i2 = 0; i2 < seatNoArray.length; i2++){
	   						if(seatNoArray[i2].room == $(obj).html()){
	   							if(seatNoArray[i2].seatNo == String.fromCharCode(charCode)+(x+1)){
	   								tag = "<td>"
	   										+"<p class='non'>"+String.fromCharCode(charCode)+(x+1)+"</p>"
		   								+"</td>";
		   							break;
		   						}
	   						} /* if end */
	   					} /* for end */
	   				} /* else end */

	   				$($("#seatList tbody tr").get($("#seatList tbody tr").size()-1)).append(tag);
	   			} /* for end */
	   		}
	   		
	   		/* 좌석선택 여부 */
	   		function setSeatNoSelect(obj, searchCount){
	   			/* 좌석선택 여부 첫번째 클릭 : 좌석선택, 두번째 클릭 : 좌석선택 취소 */
	   			if($(obj).children(":hidden").val() == 0){
	   				if($("#seatList .slt").size() == searchCount){
	   					alert("선택가능한 좌석수는 최대 "+searchCount+"자리까지만 선택가능합니다.");
	   					return;
	   				}else{
	   					$(obj).children(":hidden").val(1);
		   				/* 스타일 */
		   				$(obj).children("p").removeClass("def");
		   				$(obj).children("p").addClass("slt");
	   				}
	   			}else{
	   				$(obj).children(":hidden").val(0);
	   				/* 스타일 */
	   				$(obj).children("p").removeClass("slt");
	   				$(obj).children("p").addClass("def");
	   			}
	   		}
   		</script>
	</head>
	<body>
		<div style="font-size: 35px; padding-bottom: 15px;">
   			<strong style="float: left;">
   				${menuTree[3]}
   			</strong>
   			<div style="float: right; vertical-align: bottom; background: #FFFFFF; border-radius: 7px;">
   				<img src="/res/img/step_tck01_on.gif">
   				<img src="/res/img/step_tck02.gif">
   				<img src="/res/img/step_tck03.gif">
   				<img src="/res/img/step_tck04.gif">
   			</div>
   		</div>
	
		<!-- 사용방법 -->
   		<div style="clear: left; clear:  right;">
			<div class="caption" style="margin-top: 40px; margin-bottom: 0px;">
				* 아이디 또는 성명으로 회원을 회원을 조회할 수 있습니다.
				<br>
				* 날짜검색을 통해 가입일 또는 개인정보 수정일을 조회할 수 있습니다.
				<br>
				* 모곡을 선택하여 회원정보를 삭제할 수 있습니다.
				<br>
				* 특정행을 선택하면 그 행에 대한 상세 정보를 볼 수 있습니다.
			</div>
   		</div>
   		
   		<!-- search-group -->
   		<div style="width: 650px; margin: 0 auto;">
   			<!-- 인원정보 -->
   			<div style="width: 320px; margin-right: 10px; float: left;">
	   			<table class="d-table" style="width: 100%; height: 120px;">
	   				<colgroup>
	   					<col width="50%">
	   					<col width="50%">
	   				</colgroup>
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
	   							<select id="seatCoSelect1" style="width: 95%;">
	   								<c:forEach var="i" begin="0" end="9" step="1">
	   									<c:choose>
	   										<c:when test="${i == 1}">
	   											<option value="${i}" selected="selected">어른 ${i}명</option>
	   										</c:when>
	   										<c:otherwise>
	   											<option value="${i}">어른 ${i}명</option>
	   										</c:otherwise>
	   									</c:choose>
	   								</c:forEach>
	   							</select>
	   							<input type="hidden" value="PSNGR_2,null">
	   						</td>
	   						<td>
	   							<select id="seatCoSelect2" style="width: 95%;">
	   								<c:forEach var="i" begin="0" end="9" step="1">
	   									<option value="${i}">장애 1~3 급 ${i}명</option>
									</c:forEach>
	   							</select>
	   							<input type="hidden" value="PSNGR_3,DSPSN_GRAD_1">
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>
	   							<select id="seatCoSelect3" style="width: 95%;">
	   								<c:forEach var="i" begin="0" end="9" step="1">
	   									<option value="${i}">어린이 ${i}명</option>
	   								</c:forEach>
	   							</select>
	   							<input type="hidden" value="PSNGR_4,null">
	   						</td>
	   						<td>
	   							<select id="seatCoSelect4" style="width: 95%;">
	   								<c:forEach var="i" begin="0" end="9" step="1">
	   									<option value="${i}">장애 4-6 급 ${i}명</option>
	   								</c:forEach>
	   							</select>
	   							<input type="hidden" value="PSNGR_3,DSPSN_GRAD_2">
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>
	   							<select id="seatCoSelect5" style="width: 95%;">
	   								<c:forEach var="i" begin="0" end="9" step="1">
	   									<option value="${i}">경로 ${i}명</option>
	   								</c:forEach>
	   							</select>
	   							<input type="hidden" value="PSNGR_1,null">
	   						</td>
	   						<td></td>
	   					</tr>
	   				</tbody>
	   			</table>
	   		</div>

   			<!-- 운행정보 -->
   			<div style="width: 320px; float: left;">
	   			<table class="d-table" style="width: 100%; height: 120px;">
	   				<colgroup>
	   					<col width="50%">
	   					<col width="50%">
	   				</colgroup>
	   				<thead>
	   					<tr>
	   						<td colspan="2">운행정보</td>
	   					</tr>
	   				</thead>
	   				<tbody>
	   					<tr>
	   						<td>열차종류</td>
	   						<td>
	   							<select id="trainKndSelect" style="width: 95%;">
	   								<option value="ALL">전채</option>
	   								<c:forEach var="value" items="${commonCodeList}">
		   								<option value="${value.cmmnCode}">${value.cmmnCodeValue}</option>
	   								</c:forEach>
	   							</select>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>여정경로</td>
	   						<td>
	   							<select style="width: 95%;">
	   								<option>직통</option>
	   							</select>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>출발역</td>
	   						<td>
	   							<input id="startStatnCode" type="hidden" disabled="disabled" style="width: 60%;">
	   							<input id="startStatnValue" type="text" disabled="disabled" style="width: 60%;">
	   							<button onclick="setStatnDialog('start')" style="width: 30%;">검색</button>
	   						</td>
	   					</tr>
	   					<tr>
	   						<td>도착역</td>
	   						<td>
	   							<input id="arvlStatnCode" type="hidden" disabled="disabled" style="width: 60%;">
	   							<input id="arvlStatnValue" type="text" disabled="disabled" style="width: 60%;">
	   							<button onclick="setStatnDialog('arvl')" style="width: 30%;">검색</button>
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
	   			<button onclick="findTcktList();" style="width: 60px;">조회</button>
	   		</div>
   		</div> <!-- search-group end -->
   		
   		<!-- 그리드 -->
   		<div id="grid" style="margin-top: 7px; clear: left;">
   			<table id="gridBody"></table>
   		</div>
   		
   		<!-- statnDialog -->
		<div id="statnDialog" title="역 검색" style="display: none;">
   			<table style=" margin: 0 auto; border-collapse: collapse;">
				<tbody>
					<tr>
						<td style="border: 1px solid #FFFFFF; padding: 5px; font-weight: bolder;">역 명</td>
						<td style="border: 1px solid #FFFFFF;">
							<input id="dStatnName" type="text" style="height: 26px;">
						</td>
						<td style="border: 1px solid #FFFFFF;">
							<button id="statnBtn" onclick="findStatnList();" type="button" style="width: 100%;">검색</button>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div id="statnGrid" style="margin-top: 10px;">
				<table id="statnGridBody" style="margin: 0 auto;"></table>
			</div>
		</div> <!-- statnDialog -->
		
		<div id="seatInfoDialog" title="좌석선택" style="display: none;">
   			<!-- 선택한 승차권 정보 -->
   			<strong id="tcktInfo"></strong>
		
			<!-- 호실 -->
			<table id="roomList" style="margin: 0 auto; margin-top: 15px; margin-bottom: 15px;">
				<tbody></tbody>
			</table>
			
			<!-- 좌석 -->
			<table id="seatList" style="margin: 0 auto;">
				<tbody></tbody>
			</table>
			
			<!-- 기타 -->
			<div style="float: right; width: 320px; text-align: center; margin-top: 15px;">
				<div style="border-radius: 7px; float: left; width: 80px; margin-right: 10px; padding: 10px; background: #65FF5E; font-size: 12px; font-weight: bold;">예약가능좌석</div>
				<div style="border-radius: 7px; float: left; width: 80px; margin-right: 10px; padding: 10px; background: #515151; font-size: 12px; font-weight: bold;">예약된좌석</div>
				<div style="border-radius: 7px; float: left; width: 80px; background: #6CC0FF; padding: 10px; font-size: 12px; font-weight: bold;">선택된좌석</div>
			</div>
		</div>
		
		<!-- 임시 데이터 -->
		<div id="hiddenData">
			<input id="rowData1" type="hidden">
			<input id="rowData2" type="hidden">
		</div>
		
		<!-- 등록할 데이터 -->
		<form id="resveAddForm" action="/member/processResve.do" method="post">			
			<input name="state" type="text" value="insert">
			<input id="id" name="id" type="hidden" value="${id}">
			<input id="opratCode" name="opratCode" type="hidden">
			<input id="routetype" name="routeType" type="hidden" value="ROUTE_1">
			<input id="resveCo" name="resveCo" type="hidden">
			<input id="allFrAmount" name="allFrAmount" type="hidden">
			<input id="register" name="register" type="hidden" value="${name}">
			<input id="json" name="json" type="hidden">
		</form>
	</body>
</html>