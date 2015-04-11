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
   			var viewState = false;		 		/*viewState와 같은 역활이며 상세운행정보에 대한 상태이다*/
   			var viewState2 = false;				/*viewState와 같은 역활이며 호실정보에 대한 상태이다*/
   			var detailOpratArray = new Array();	/* 상세운행일정 */
   			var roomArray = new Array();		/*호시렁보*/
   			
	   		$(document).ready(function(){
				/*Action style*/
				$($(".menu td").get(3)).addClass("set");
				$($(".lmb tr").get(2)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual05.jpg");
	   			
				/* Set grid data */
				doGridInit("all", true);
	   		
				/*엔터*/
				$("#dTrainNo").keydown(function(e){
					if(e.keyCode == 13){
						$("#trainNoBtn").click();
					}
				});
				$("#dStatnName").keydown(function(e){
					if(e.keyCode == 13){
						$("#statnBtn").click();
					}
				});
	   		});
   			
   			/************************************************
   								Grid setting
   			*************************************************/
   			
	   		/*그리드 초기상태*/
   			function doGridInit(mode, dataSet){
	   			var allInit = false;
	   			
	   			/*모든 그리드 초기화*/
	   			if(mode == "all"){
	   				allInit = true;
	   			}
	   			
	   			/*상세운행일정*/
	   			if(mode == "detailOprat" || allInit){
	   				viewState = false;
	   				
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
		   				colNames:["state", "출발역", "출발시각", "도착역", "도착시각", "이전역", "이전역 거리", "다음역", "다음역 거리"],
		          		colModel : [
							{ name : "state", hidden:true},
							{ name : 'startStatnValue', width: 70, align:"center", sortable:false,
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=8';
								}
							},
							{ name : 'startTm', width: 70, align:"center", sortable:false},
							{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'arvlStatnTm', width: 70, align:"center", sortable:false},
							{ name : 'prvStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'prvStatnDistnc', width: 70, align:"center", sortable:false},
							{ name : 'nxtStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'nxtStatnDistnc', width: 70, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
					
					/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
					$("#gridBody").jqGrid('addRowData', 0, {state:"non", startStatnValue:"상세운행정보를 등록하지 않았습니다."});
	   			} /* 상세운행정보 end */
	   			
	   			/* 호실정보 */
	   			if(mode == "room" || allInit){
	   				viewState2 = false;
		   				
	   				/*그리드 초기화*/
					$("#grid2").html("<table id='gridBody2'></table><div id='footer2'></div>");
	   				
					$("#gridBody2").jqGrid({
						datatype: "LOCAL",
		   				caption:"호실정보",
		   				width: 550,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer2',
		   				colNames:["state", "호실", "좌석수", "특실여부"],
		          		colModel : [
							{ name : "state", hidden:true},
							{ name : "room", width: 70, align:"center", sortable:false,
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=3';
								}
							},
							{ name : "seatCo", width: 70, align:"center", sortable:false},
							{ name : "prtclrRoomYN", width: 30, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
					
					/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
					$("#gridBody2").jqGrid('addRowData', 0, {state:"non", room:"호실을 등록하지 않았습니다."});
		   		} /* 호실정보 */
	   		} /* doGridInit end */
	   		
	   		/*그리드 생성 그리드의 존재여부확인 후 존재할 경우 실행하지 않는다*/
	   		function setGrid(mode){
	   			/*상세운행정보*/
	   			if(mode == "detailOprat"){
	   				/*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
					viewState = true;
	   				
	   				/*그리드 초기화*/
	   				$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
					
					$("#gridBody").jqGrid({
						datatype: "LOCAL",
		   				caption:"상세운행일정 정보",
		   				multiselect: true,
		   				width: 845,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer',
		   				colNames:[
		   					"state", "startStatnCode", "출발역", "출발시각", 
							"arvlStatnCode", "도착역", "도착시각", "prvStatnCode", "이전역",
							"이전역 거리", "nxtStatnCode", "다음역", "다음역 거리"
						],
		          		colModel : [
							{ name : 'state', hidden:true},
							{ name : 'startStatnCode', hidden:true},
							{ name : 'startStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'startTm', width: 120, align:"center", sortable:false},
							{ name : 'arvlStatnCode', hidden:true},
							{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'arvlTm', width: 120, align:"center", sortable:false},
							{ name : 'prvStatnCode', hidden:true},
							{ name : 'prvStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'prvDistnc', width: 70, align:"center", sortable:false},
							{ name : 'nxtStatnCode', hidden:true},
							{ name : 'nxtStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'nxtDistnc', width: 70, align:"center", sortable:false}
						]
					}); /*jqGrid end*/
	   			}
	   			/* 호실정보 */
	   			else{
	   				/*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
					viewState2 = true;
		   				
	   				/*그리드 초기화*/
					$("#grid2").html("<table id='gridBody2'></table><div id='footer2'></div>");
	   				
					$("#gridBody2").jqGrid({
						datatype: "LOCAL",
		   				caption:"호실정보",
		   				multiselect: true,
		   				width: 550,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer2',
		   				colNames:["state", "호실", "좌석수", "특실여부"],
		          		colModel : [
							{ name : "state", hidden:true},
							{ name : "room", width: 70, align:"center", sortable:false},
							{ name : "seatCo", width: 70, align:"center", sortable:false},
							{ name : "prtclrRoomYN", width: 30, align:"center", formatter:"checkbox", sortable:false}
						]
					}); /*jqGrid end*/
				} /* else end */
	   		} /* setGrid end */
   			
	   		/************************************************
	   						Dialog and search
	   		*************************************************/
	   		
   			/* 열차 검색 다이알로그 */
   			function setTrainDialog(){
   				/*input 초기화*/
   				$("#dTrainNo").val("");
   				$("#rowData1").val("");
				$("#rowData2").val("");
				$("#rowData3").val("");
   				
   				/*그리드 초기화*/
				$("#trainGrid").html("<table id='trainGridBody'></table>");
   				
				$("#trainGridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"열차정보",
	   				width: 320,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				colNames:["선택", "열차번호", "열차종류 코드", "열차종류"],
	          		colModel : [
						{ name : "select", width: 20, align:"center", sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=3';
							}
						},						
						{ name : "trainNo", hidden:true, sortable:false},
						{ name : "trainKndCode", width: 70, sortable:false},
						{ name : "trainKndValue", width: 70, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
				
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#trainGridBody").jqGrid('addRowData', 1, {select:"열차번호를 이용하여 열차를 검색할 수 있습니다."});
   				
   				/*다이알로그*/
   				$("#trainDialog").dialog({
   					modal: true,
   					width: 350,
					buttons: {
						"등록": function() {
							if($("#rowData1").val() == ""){
								alert("열차를 선택해야 합니다.");
							}else{
								$("#trainCode").val($("#rowData1").val());
								$("#trainNo").val($("#rowData2").val());
								$("#trainKnd").val($("#rowData3").val());
								
								$(this).dialog("close");	
							}
						},
						"취소": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
   			}
   			
   			/* 열차 검색 */
   			function findTrainList(){
   				/* 미입력 처리 */
				if($("#dTrainNo").val().replace(" ") == ""){
					alert("검색할 열차번호를 입력헤야 합니다.");
					return;
				}
				/*그리드 내용*/
				else{
					$.ajax({
						type:"GET",
						url: "/admin/trainList.do?srcText="+encodeURIComponent($("#dTrainNo").val().replace(" ")),
						Type:"JSON",
						success : function(data) {
							if(data.trainListSize == 0){
								alert("결과가 존재하지 않습니다.");
							}else{
								/*그리드 초기화*/
								$("#trainGrid").html("<table id='trainGridBody'></table>");
									
								$("#trainGridBody").jqGrid({
									datatype: "LOCAL",
						   			caption:"열차정보",
						   			width: 320,
					   				height: 160,
					   				scroll: 1,
					   				rowNum : 'max',
					   				colNames:["선택", "열차코드", "열차번호", "열차종류"],
					          		colModel : [
										{ name : "select", width: 20, align:"center", sortable:false},
										{ name : "trainCode", hidden:true},
										{ name : "trainNo", width: 70, align:"center", sortable:false},
										{ name : "trainKnd", width: 70, align:"center", sortable:false}
									],
									/*row click*/
									onCellSelect :function(rowId,indexColumn,cellContent,eventObject){
										/*값 설정*/
										var trainCode = $(this).getRowData(rowId).trainCode;
										var trainNo = $(this).getRowData(rowId).trainNo;
										var trainKnd = $(this).getRowData(rowId).trainKnd;
										
										/*라이도 버튼 자동선택*/
										$("input[value='"+trainCode+"']").click();
										
										$("#rowData1").val(trainCode);
										$("#rowData2").val(trainNo);
										$("#rowData3").val(trainKnd);
									}
								}); /*jqGrid end*/
								
								/*데이터 삽입*/
								$.each(data.trainList, function(k,v){
									$("#trainGridBody").jqGrid('addRowData', k+1,
										{
											select:'<input type="radio" name="trainCode" value="'+v.trainCode+'">',
											trainCode:v.trainCode+"",
											trainNo:v.trainNo+"",
											trainKnd:v.trainKndValue+""
										}
									); /*addRowData end*/
								}); /*$.each end*/
							} /*if end*/
						} /*success end*/
					}); /*$.ajax end*/
				} /*else end*/
   			}
   			
   			/* 역 검색 다이알로그 */
   			function setStatnDialog(type1, type2){
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
								if(type1 == "text"){
									/* 출발역 */
									if(type2 == "start"){
										$("#startStatnCode").val($("#rowData1").val());
										$("#startStatnValue").val($("#rowData2").val());
									}
									/* 도착역 */
									else if(type2 == "arvl"){
										$("#arvlStatnCode").val($("#rowData1").val());
										$("#arvlStatnValue").val($("#rowData2").val());
									}
								}else{
									/* 출발역 */
									if(type2 == "start"){
										$("#startStatnCode2").val($("#rowData1").val());
										$("#startStatnValue2").val($("#rowData2").val());
									}
									/* 도착역 */
									else if(type2 == "arvl"){
										$("#arvlStatnCode2").val($("#rowData1").val());
										$("#arvlStatnValue2").val($("#rowData2").val());
									}
									/* 이전역 */
									else if(type2 == "prv"){
										$("#prvStatnCode").val($("#rowData1").val());
										$("#prvStatnValue").val($("#rowData2").val());
									}
									/* 다음역 */
									else if(type2 == "nxt"){
										$("#nxtStatnCode").val($("#rowData1").val());
										$("#nxtStatnValue").val($("#rowData2").val());
									}
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
				if($("#dStatnName").val().replace(" ") == ""){
					alert("검색할 역 명을 입력헤야 합니다.");
					return;
				}
				/*그리드 내용*/
				else{
					$.ajax({
						type:"GET",
						url: "/admin/statnList.do?srcText="+encodeURIComponent($("#dStatnName").val().replace(" ")),
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
	   		
   			/*날짜 다이알로그 */
   			function setDateTimeDialog(obj){
				var year = ""; /* 년 */
   				var month = ""; /* 월 */
   				var dd = ""; /* 일 */
   				var hh24 = ""; /* 시 */
   				var mi = ""; /* 분 */
   				
   				/* 년도 설정 : 년도는 현재년도와 다음년도를 선택할수 있다. */
				$("#year").html("");
   				$("#year").append('<option value="'+new Date().getFullYear()+'">'+(new Date().getFullYear()-1)+'</option>');
   				$("#year").append('<option value="'+new Date().getFullYear()+'">'+new Date().getFullYear()+'</option>');
   				$("#year").append('<option value="'+(new Date().getFullYear()+1)+'">'+(new Date().getFullYear()+1)+'</option>');
   				
   				if($(obj).val() == ""){
   					/* 현재날짜 자동선택 */
   	   				$("#year").children("option[value='"+new Date().getFullYear()+"']").attr("selected", "selected");
   					
   					/* 날짜 */
   					setDateTime();
   				}else{
   					/* $(obj).val() 형식 : YYYY-MM-DD HH24:MI */
   					var date = $(obj).val().split("-"); /* 날짜 */
   					var time = date[2].split(":");		/* 시간 */
   					
   					year = date[0];
   					month = date[1];
   					
   					/* DD HH24 이므로 공백으로 다시 구분 */
   					dd = date[2].split(" ")[0].replace(" "); 
   					hh24 = time[0].split(" ")[1].replace(" ");
   					
   					mi = time[1];
   	   				
   	   				setDateTime();
   					
   					/* 자동선택 */
   	   				$("#year").children("option[value='"+year+"']").attr("selected", "selected");
   	   				$("#month").children("option[value='"+month+"']").attr("selected", "selected");
   	   				$("#date").children("option[value='"+dd+"']").attr("selected", "selected");
   	   				$("#hh24").children("option[value='"+hh24+"']").attr("selected", "selected");
   	   				$("#mi").children("option[value='"+mi+"']").attr("selected", "selected");
   				}
   				
				/*다이알로그*/
   				$("#dateTimeDialog").dialog({
   					modal: true,
   					width: 450,
					buttons: {
						"등록": function() {
							/* 형식 : YYYY-MM-DD HH24:MI */
							var dateTime = $("#year").val()+"-"+$("#month").val()+"-"+$("#date").val()+" "+$("#hh24").val()+":"+$("#mi").val()+"";
							
							/* 값을 설정 */
							$(obj).val(dateTime);
							
							$(this).dialog("close");
						},
						"취소": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
   			} /*날짜 end */
   			
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
   			
   			/* 상세운행일정 다이알로그 */
   			function setDetailOpratDialog(){
   				/* 날짜를 사용하기 위한 변수 */
   				var startDate = "";
   				var arvlDate = "";
   				
   				/* Text and hidden 초기화 */
   				$("#detailOpratDialog input").val("");
   				$("#rowData1").val("");
				$("#rowData2").val("");
				$("#rowData3").val("");
   				
   				/* 년도 설정 : 년도는 현재년도와 다음년도를 선택할수 있다. */
				$("#startYear").html("");
   				$("#startYear").append('<option value="'+new Date().getFullYear()+'">'+(new Date().getFullYear()-1)+'</option>');
   				$("#startYear").append('<option value="'+new Date().getFullYear()+'">'+new Date().getFullYear()+'</option>');
   				$("#startYear").append('<option value="'+(new Date().getFullYear()+1)+'">'+(new Date().getFullYear()+1)+'</option>');
   				/* 현재년도 설정 */
   				$("#startYear").children("option[value='"+new Date().getFullYear()+"']").attr("selected", "selected");
   				
   				$("#arvlYear").html("");
   				$("#arvlYear").append('<option value="'+new Date().getFullYear()+'">'+(new Date().getFullYear()-1)+'</option>');
   				$("#arvlYear").append('<option value="'+new Date().getFullYear()+'">'+new Date().getFullYear()+'</option>');
   				$("#arvlYear").append('<option value="'+(new Date().getFullYear()+1)+'">'+(new Date().getFullYear()+1)+'</option>');
   				/* 현재년도 설정 */
   				$("#arvlYear").children("option[value='"+new Date().getFullYear()+"']").attr("selected", "selected");
   				
   				/* 년과 월에 대한 날짜 */
				startDate = new Date($("#startYear").val(), $("#startMonth").val(), "");
				arvlDate = new Date($("#arvlYear").val(), $("#arvlMonth").val(), "");
   				
   				/* HTML 초기화 */
   				$("#startDate").html("");
   				$("#arvlDate").html("");
   				
   				/* 날짜를 생성 */
   				for(var i = 1; i <= startDate.getDate(); i++){
   					if(i < 10){
   	   					$("#startDate").append('<option value="0'+i+'">0'+i+'</option>');   						
   					}else{
 	  					$("#startDate").append('<option value="'+i+'">'+i+'</option>');
   					}
   				}
   				for(var i = 1; i <= arvlDate.getDate(); i++){
   					if(i < 10){
   	   					$("#arvlDate").append('<option value="0'+i+'">0'+i+'</option>');   						
   					}else{
 	  					$("#arvlDate").append('<option value="'+i+'">'+i+'</option>');
   					}
   				}
   				
   				/*다이알로그*/
   				$("#detailOpratDialog").dialog({
   					modal: true,
   					width: 550,
					buttons: {
						"등록": function() {
							/* 상세운행일정 등록의 입력 값들 */
							var input = $("#detailOpratDialog input");
							/* 출발익 */
							var startTm = $("#startYear").val()+"-"+$("#startMonth").val()+"-"+$("#startDate").val()+" "+$("#startHh24").val()+":"+$("#startMi").val()+"";
							/* 도착일 */
							var arvlTm = $("#arvlYear").val()+"-"+$("#arvlMonth").val()+"-"+$("#arvlDate").val()+" "+$("#arvlHh24").val()+":"+$("#arvlMi").val()+"";
							
							/* 미입력 확인 */
							for(var i = 0; i < input.size(); i++){
								/* 상세운행일정 등록의 입력 값이 하나라도 비어있다면 */
								if($(input.get(i)).val() == ""){
									alert("모든 항목은 필수입력 사항입니다.");
									return;
								}
							}
							
							/* 초기 그리드 일 때 */
							if(!viewState){
								setGrid("detailOprat");
							}
							
							/* row 추가 */
							$("#gridBody").jqGrid('addRowData', $("#gridBody").getGridParam("records"),
								{
									state:"insert",
									startStatnCode:$(input.get(0)).val(),
									startStatnValue:$(input.get(1)).val(),
									startTm:startTm, 
									arvlStatnCode:$(input.get(2)).val(),
									arvlStatnValue:$(input.get(3)).val(),
									arvlTm:arvlTm,
									prvStatnCode:$(input.get(4)).val(),
									prvStatnValue:$(input.get(5)).val(),
									prvDistnc:$(input.get(6)).val()+" km",
									nxtStatnCode:$(input.get(7)).val(),
									nxtStatnValue:$(input.get(8)).val(),
									nxtDistnc:$(input.get(9)).val()+" km"
								}
							);
							
							$(this).dialog("close");
						},
						"취소": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
   			}

   			/* 호실 다이알로그 */
   			function setRoomDialog(){
   				/* 초기화 */
   				$("#room").val("");
   				$("#seatCo").val("");
   				$("#prtclrRoomYN").val("N");
   				$("#prtclrRoomYN").prop("checked", false);
   				
   				/*다이알로그*/
   				$("#roomDialog").dialog({
   					modal: true,
   					width: 350,
					buttons: {
						"등록": function() {
							var room = $("#room").val().replace(" ");
							var seatCo = $("#seatCo").val().replace(" ");
							
							/* 미입력 처리 */
							if(room == "" || seatCo == ""){
								alert("호실과 좌석수는 필수입력 사항입니다.");
							}
							/* row 추가 */
							else{
								/* 초기 그리드 일 때 */
								if(!viewState2){
									setGrid("room");
								}
								
								if($("#prtclrRoomYN").is(":checked")){
									$("#prtclrRoomYN").val("Y");
								}
								
								$("#gridBody2").jqGrid('addRowData', $("#gridBody2").getGridParam("records"),
									{
										state:"insert",
										room:room+" 호실",
										seatCo:seatCo+" 석",
										prtclrRoomYN:$("#prtclrRoomYN").val()+""
									}
								);
								
								$(this).dialog("close");
							}
						},
						"취소": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
   			} /* setRoomDialog end */
	   		
   			/**********************************************
   								etc
   			**********************************************/
   								
   			/* 상세운행일정, 호실 삭제 */
   			function deleteRow(type){
   				/* 상세운행정보 */
   				if(type == "detailOprat"){
					/*체크박스로 선택된 행의 ID들*/
					var rowIds = $("#gridBody").getGridParam('selarrrow');
					var rowSize = rowIds.length;
	
					/*select check*/
					if(rowIds == ""){
						alert("선택된 항목이 없습니다.");
						return;
					}else{
						if(confirm("선택한 항목을 삭제하시겠습니까?")){
							for(var i = rowSize; i > 0; i--){
								if($("#gridBody").getRowData(rowIds[i-1]).state == "insert"){
									$("#gridBody").delRowData(rowIds[i-1]);
								}else{
									detailOpratArray[rowIds[i-1]].state = "delete";
									$("#gridBody").delRowData(rowIds[i-1]);
								}
							} /* for end */
							
							if($("#gridBody").getGridParam("records") == 0){
								doGridInit("detailOprat");
							}
						} /* if end */
					} /* else end */
   				} /* 상세운행정보 end */
   				
   				/* 호실정보 */
   				else{
   					/*체크박스로 선택된 행의 ID들*/
					var rowIds = $("#gridBody2").getGridParam('selarrrow');
					var rowSize = rowIds.length;
	
					/*select check*/
					if(rowIds == ""){
						alert("선택된 항목이 없습니다.");
						return;
					}else{
						if(confirm("선택한 항목을 삭제하시겠습니까?")){
							for(var i = rowSize; i > 0; i--){
								if($("#gridBody2").getRowData(rowIds[i-1]).state == "insert"){
									$("#gridBody2").delRowData(rowIds[i-1]);
								}else{
									roomArray[rowIds[i-1]].state = "delete";
									$("#gridBody2").delRowData(rowIds[i-1]);
								}
							} /* for end */
							
							if($("#gridBody2").getGridParam("records") == 0){
								doGridInit("room");
							}
						} /* if end */
					} /* else end */
   				} /* 호실정보 end */
   			} /* deleteRow end */
   			
	   		/* 등록 */
	   		function addOprat(){
   				/* 미입력 검사 */
				for(var i = 0; i < $("#addForm tbody input").size(); i++){
					if($($("#addForm tbody input").get(i)).val() == ""){
						alert("모든 필드는 필수입력 사항입니다.");
						return;
					}
				}
				
				/* 그리드 데이터 확인 */
				if($("#gridBody").getRowData(0).state == "non"){
					alert("상세운행일정은 하나 이상 등록되어야 합니다.");
					return;
				}else if($("#gridBody2").getRowData(0).state == "non"){
					alert("호실정보는 하나 이상 등록되어야 합니다.");
					return;
				}else{
					var array1 = $("#gridBody").getRowData();  /* 상세운행정보 */
		   			var array2 = $("#gridBody2").getRowData(); /* 호실정보 */
		   			var jsonArray = new Array();
		   			
					/* 그리드정보에 delete정보 적용 */
		   			for(var v in detailOpratArray){
		   				/* 상세운행일정 */
		   				if(detailOpratArray[v].state == "delete"){
		   					array1.push(detailOpratArray[v]);
		   				}
		   			}
		   			for(var v in roomArray){
		   				/* 호실정보 */
		   				if(roomArray[v].state == "delete"){
		   					array2.push(roomArray[v]);
		   				}
		   			}
		   			
		   			/* JSON 변환 후 jsonArray 저장 */
		   			jsonArray[0] = JSON.stringify({"detailOprat":array1});
		   			jsonArray[1] = JSON.stringify({"room":array2});
		   			
		   			/* json에 값 설정 */
		   			$("#json1").val(jsonArray[0]);
		   			$("#json2").val(jsonArray[1]);	
				
		   			if(confirm("이 운행정보를 등록하시겠습니까?")){
						$("#addForm").submit();
					}
				} /* else end */
   			} /* addOprat end */
   			
	   		/* 취소 */
   			function doCancel(){
   				if(confirm("현제 작성중인 작업을 취소하시겠습니까?")){
   					location.href = "/admin/opratMng.html";
   				}
   			}
		</script>
   	</head>
   	<body>
   		<div style="font-size: 35px; padding-bottom: 15px;">
   			<strong>
   				${menuTree[3]}
   			</strong>
   		</div>
   		
   		<!-- 사용방법 -->
   		<div class="caption">
			* 운행정보는 운행에 대한 기본적인 정보를 입력합니다.
			<br>
			* 열차번호, 출발역, 도착역, 노선은 검색을 통해 입력 할 수 있습니다.
			<br>
			* 열차종류는 선택한 열차번호에 따라 자동 입력됩니다.
			<br>
			* 거리는 소숫점 첫째자리까지 입력가능합니다.
			<br>
			* 상세운행일정 정보는 목록의 오른쪽 위의 추가, 삭제 버튼을 이용하여 추가, 삭제가 가능합니다.
			<br>
			* 호실정보는 목록의 오른쪽 위의 추가, 삭제 버튼을 이용하여 추가, 삭제가 가능합니다.
			<br>
			* 모든 작업이 완료되었다면 등록버튼을 이용하여 입력한 정보를 등록 할 수 있습니다.
			<br>
			* 진행중인 작업을 취소버튼을 이용해 취소 할 수 있습니다.
   		</div>
   		
   		<!-- 운행일정 -->
   		<div>
   			<form id="addForm" action="/admin/opratProcess.do">
   				<!-- 등록으로 상태설정 -->
   				<input type="hidden" name="state" value="insert">
   				<!-- 등록자 설정 (현재 로그인한 회원명으로 등록된다.) -->
   				<input type="hidden" name="register" value="${name}">
				<!-- JSON type -->
				<input id="json1" name="json" type="hidden">
				<input id="json2" name="json" type="hidden">
				
				<table class="d-table">
					<colgroup>
						<col width="20%">
						<col width="15%">
						<col width="10%">
						<col width="20%">
						<col width="20%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
							<td colspan="6" style="text-align: center; border: none;" class="t-radius">
								<strong>운행일정</strong>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<!-- 열차코드 -->
							<td style="display: none;">
								<input id="trainCode" name="trainCode" type="hidden">
							</td>
							<td class="head">열차번호</td>
							<td>
								<input id="trainNo" type="text" style="width: 95%;" disabled="disabled">
							</td>
							<td>
								<button type="button" onclick="setTrainDialog();" style="width: 70px; height: 23px; margin-top: 5px; margin-bottom: 5px;">검색</button>
							</td>
							<td class="head">열차종류</td>
							<td colspan="2">
								<input id="trainKnd" style="width: 95%;" type="text" disabled="disabled">
							</td>
						</tr>
						<tr>
							<td class="head">출발역</td>
							<td>
								<input id="startStatnCode" name="startStatnCode" type="hidden">
								<input id="startStatnValue" style="width: 95%;" type="text" disabled="disabled">
							</td>
							<td>
								<button type="button" onclick="setStatnDialog('text', 'start');" style="width: 70px; height: 23px; margin-top: 5px; margin-bottom: 5px;">검색</button>
							</td>
							<td class="head">출발시각</td>
							<td colspan="2">
								<input name="startTm" onclick="setDateTimeDialog(this);" readonly="readonly" style="width: 95%;" type="text">
							</td>
						</tr>
						<tr>
							<td class="head">도착역</td>
							<td>
								<input id="arvlStatnCode" name="arvlStatnCode" type="hidden">
								<input id="arvlStatnValue" style="width: 95%;" type="text" disabled="disabled">
							</td>
							<td>
								<button type="button" onclick="setStatnDialog('text', 'arvl');" style="width: 70px; height: 23px; margin-top: 5px; margin-bottom: 5px;">검색</button>
							</td>
							<td class="head">도착시각</td>
							<td colspan="2">
								<input name="arvlTm" onclick="setDateTimeDialog(this);" readonly="readonly" style="width: 95%;" type="text">
							</td>
						</tr>
						<tr>
							<td class="head">노선</td>
							<td>
								<input id="routeCode" name="routeCode" type="hidden" value="ROOT_1">
								<input id="routeValue" type="text" disabled="disabled" value="경부선">
							</td>
							<td>
								<button type="button" style="width: 70px; height: 23px; margin-top: 5px; margin-bottom: 5px;">검색</button>
							</td>
							<td class="head">거리</td>
							<td>
								<input name="distnc" type="text">
							</td>
							<td class="head">km</td>
						</tr>
						<tr>
							<td style="border: none;" class="b-l-radius head">요금</td>
							<td colspan="4" style="text-align: right;">
								<input name="fare" type="text">
							</td>
							<td class="b-r-radius head" style="border: none;">원</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		
		<!-- 상세운행정보 -->
		<div style="margin-top: 30px;">
			<div class="button-group" style="width: 845px;">
				<button type="button" onclick="setDetailOpratDialog();">추가</button>
				<button type="button" onclick="deleteRow('detailOprat');">삭제</button>
			</div>
			<div id="grid" style="margin: 0 auto; margin-top: 5px; width: 845px;">
	   			<table id="gridBody"></table>
		   		<div id="footer"></div>
	   		</div>
	   	</div>
		
		<!-- 호실정보 -->
		<div style="margin-top: 30px;">
			<div class="button-group" style="width: 550px;">
				<button type="button" onclick="setRoomDialog();">추가</button>
				<button type="button" onclick="deleteRow('room');">삭제</button>
			</div>
			<div id="grid2" style="margin: 0 auto; margin-top: 5px; width: 550px;">
	  			<table id="gridBody2"></table>
	   			<div id="footer2"></div>
	  		</div>
	  	</div>
   		
   		<!-- 날짜 다이알로그 -->
   		<div id="dateTimeDialog" title="날짜" style="display: none;">
   			<table class="date-time-table">
				<tbody>
					<!-- 날짜 선택 -->
					<tr>
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
						<td>
							<select id="mi" style="width: 55px;">
   								<c:forEach var="mi" begin="0" end="60" step="5">
	   								<c:if test="${mi < 10}">
		   								<option value="0${mi}">0${mi}</option>
	   								</c:if>
	   								<c:if test="${mi > 9}">
		   								<option value="${mi}">${mi}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
						</td>
						<td>분</td>
					</tr>
				</tbody> <!-- tbody end -->
			</table> <!-- table end -->
		</div> <!-- dateTimeDialog -->
		
		<!-- trainDialog -->
		<div id="trainDialog" title="열차검색" style="display: none;">
			<table style=" margin: 0 auto; border-collapse: collapse;">
				<tbody>
					<tr>
						<td style="border: 1px solid #FFFFFF; padding: 5px; font-weight: bolder;">열차번호</td>
						<td style="border: 1px solid #FFFFFF;">
							<input id="dTrainNo" type="text" style="height: 26px;">
						</td>
						<td style="border: 1px solid #FFFFFF;">
							<button id="trainNoBtn" onclick="findTrainList();" type="button" style="width: 100%;">검색</button>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div id="trainGrid" style="margin-top: 10px;">
				<table id="trainGridBody" style="margin: 0 auto;"></table>
			</div>
		</div> <!-- trainDialog -->
		
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
		
		<!-- detailOpratDialog -->
		<div id="detailOpratDialog" title="상세운행일정 등록" style="display: none;">
   			<table class="d-table" style="width:100%; margin: 0 auto; border-collapse: collapse;">
				<tbody>
					<tr>
						<td>출발역</td>
						<td colspan="6" style="text-align: right;">
							<input id="startStatnCode2" type="hidden">
							<input id="startStatnValue2" type="text" style="width: 108px;" disabled="disabled">
							<button type="button" onclick="setStatnDialog('dialog', 'start');" style="height: 23px; margin-top: 5px; margin-bottom: 5px;">검색</button>
						</td>
					</tr>
					<tr>
						<td>출발시각</td>
						<td>
							<select id="startYear" onchange="setDateTime();" style="width: 65px;">
   								<!-- script -->
   							</select>
							<label style="width: 20px;">년</label>
						</td>
						<td>
							<select id="startMonth" onchange="setDateTime();" style="width: 55px;">
   								<c:forEach var="month" begin="1" end="12">
   									<c:if test="${month < 10}">
		   								<option value="0${month}">0${month}</option>
	   								</c:if>
	   								<c:if test="${month > 9}">
		   								<option value="${month}">${month}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
   							<label>월</label>
						</td>
						<td>
							<select id="startDate" style="width: 55px;">
   								<!-- script -->
   							</select>
   							<label>일</label>
						</td>
						<td>
							<select id="startHh24" style="width: 55px;">
   								<c:forEach var="hh24" begin="0" end="23">
   									<c:if test="${hh24 < 10}">
		   								<option value="0${hh24}">0${hh24}</option>
	   								</c:if>
	   								<c:if test="${hh24 > 9}">
		   								<option value="${hh24}">${hh24}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
   							<label>시</label>
						</td>
						<td>
							<select id="startMi" style="width: 55px;">
   								<c:forEach var="mi" begin="0" end="60" step="5">
	   								<c:if test="${mi < 10}">
		   								<option value="0${mi}">0${mi}</option>
	   								</c:if>
	   								<c:if test="${mi > 9}">
		   								<option value="${mi}">${mi}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
   							<span>분</span>
						</td>
					</tr>

					<tr>
						<td>도착역</td>
						<td colspan="6" style="text-align: right;">
							<input id="arvlStatnCode2" type="hidden">
							<input id="arvlStatnValue2" type="text" style="width: 108px;" disabled="disabled">
							<button type="button" onclick="setStatnDialog('dialog' ,'arvl');" style="height: 23px; margin-top: 5px; margin-bottom: 5px;">검색</button>
						</td>
					</tr>
					<tr>
						<td>도착시각</td>
						<td>
							<select id="arvlYear" onchange="setDateTime();" style="width: 65px;">
   								<!-- script -->
   							</select>
							<label style="width: 20px;">년</label>
						</td>
						<td>
							<select id="arvlMonth" onchange="setDateTime();" style="width: 55px;">
   								<c:forEach var="month" begin="1" end="12">
   									<c:if test="${month < 10}">
		   								<option value="0${month}">0${month}</option>
	   								</c:if>
	   								<c:if test="${month > 9}">
		   								<option value="${month}">${month}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
   							<label>월</label>
						</td>
						<td>
							<select id="arvlDate" style="width: 55px;">
   								<!-- script -->
   							</select>
   							<label>일</label>
						</td>
						<td>
							<select id="arvlHh24" style="width: 55px;">
   								<c:forEach var="hh24" begin="0" end="23">
   									<c:if test="${hh24 < 10}">
		   								<option value="0${hh24}">0${hh24}</option>
	   								</c:if>
	   								<c:if test="${hh24 > 9}">
		   								<option value="${hh24}">${hh24}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
   							<label>시</label>
						</td>
						<td>
							<select id="arvlMi" style="width: 55px;">
   								<c:forEach var="mi" begin="0" end="60" step="5">
	   								<c:if test="${mi < 10}">
		   								<option value="0${mi}">0${mi}</option>
	   								</c:if>
	   								<c:if test="${mi > 9}">
		   								<option value="${mi}">${mi}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
   							<span>분</span>
						</td>
					</tr>

					<tr>
						<td>이전역</td>
						<td colspan="2">
							<input id="prvStatnCode" type="hidden">
							<input id="prvStatnValue" type="text" style="width: 95px;" disabled="disabled">
							<button type="button" onclick="setStatnDialog('dialog' ,'prv');" style="height: 23px; margin-top: 5px; margin-bottom: 5px;">검색</button>
						</td>
						<td>이전역 거리</td>
						<td colspan="2">
							<input type="text" style="width: 95px;">
							<label>km</label>
						</td>
					</tr>
					<tr>
						<td>다음역</td>
						<td colspan="2">
							<input id="nxtStatnCode" type="hidden">
							<input id="nxtStatnValue" type="text" style="width: 95px;" disabled="disabled">
							<button type="button" onclick="setStatnDialog('dialog' ,'nxt');" style="height: 23px; margin-top: 5px; margin-bottom: 5px;">검색</button>
						</td>
						
						<td>다음역 거리</td>
						<td colspan="2">
							<input type="text" style="width: 95px;">
							<label>km</label>
						</td>
					</tr>
				</tbody>
			</table>
		</div> <!-- detailOpratDialog -->
		
		<div id="roomDialog" title="호실정보 등록" style="display: none;">
			<table class="d-table" style="width:100%; margin: 0 auto; border-collapse: collapse;">
				<tbody>
					<tr>
						<td>호실</td>
						<td style="width: 60px;">
							<input id="room" type="text" width="100%">
						</td>
						<td>호실</td>
					</tr>
					<tr>
						<td>조석수</td>
						<td style="width: 60px;">
							<input id="seatCo" type="text" width="100%">
						</td>
						<td>석</td>
					</tr>
					<tr>
						<td>특실여부</td>
						<td colspan="2">
							<input id="prtclrRoomYN" type="checkbox">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
   		
   		<!-- 그리드에서 선택한 row에 대한 임시저장 값 -->
		<div>
			<input id="rowData1" type="hidden">
			<input id="rowData2" type="hidden">
			<input id="rowData3" type="hidden">
   		</div>
   		
   		<!-- 등록, 취소 버튼 -->
   		<div class="button-group" style="width: 847px; margin-top: 30px; text-align: center;">
   			<button type="button" onclick="addOprat();">등록</button>
			<button type="button" onclick="doCancel();">취소</button>
   		</div>
	</body>
</html>