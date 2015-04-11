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
				
				/*호실 radio style*/
				$("input[name=prtclrRoomYN]").click(function(){
					if($(this).val() == "Y"){
						$("#seatCo1").parent().css("background", "#FF8224");
						$("#seatCo2").parent().css("background", "#000000");
		   				$("#seatCo2").attr("disabled", "disabled");
		   				$("#seatCo1").removeAttr("disabled", "disabled");
		   				$(this).attr("checked", "checked");
		   				$(this).parent().parent().css("background", "#FF8224");
		   				$(this).parent().parent().next().css("background", "#000000");
					}else{
						$("#seatCo2").parent().css("background", "#FF8224");
						$("#seatCo1").parent().css("background", "#000000");
		   				$("#seatCo1").attr("disabled", "disabled");
		   				$("#seatCo2").removeAttr("disabled", "disabled");
		   				$(this).attr("checked", "checked");
		   				$(this).parent().parent().css("background", "#FF8224");
		   				$(this).parent().parent().prev().css("background", "#000000");
					}
				});
				
				/* 날짜설정 */
				setYear();
	   		});
   			
	   		/***********************************************
								Date setting
			*************************************************/
   			
	   		/*날짜생성1 */
   			function setYear(){
	   			/* 출발일시 도착일시 형식) YYYY-MM-DD HH24:MI */
	   			/*출발일시*/
	   			$("#year1").html("");
	   			/*도착일시*/
	   			$("#year2").html("");
	   			/*년도생성*/
	   			for(var i = ("${oprat.startTm}".split("-")[0]-1); i <= (new Date().getFullYear()+1); i++){
	   				$("#year1").append('<option value="'+i+'">'+i+'</option>');
	   				$("#year2").append('<option value="'+i+'">'+i+'</option>');
	   			}
	   			
	   			/* 날짜생성 */
				setDateTime();
	  	 		/*현재날짜 자동선택*/
				setSelectd();
   			}
   			/* 날짜생성2 */
   			function setDateTime(){
   				for(var i = 1; i < 3; i++){
   					/* 년과 월에 대한 날짜 */
   					var dateSize = new Date($("#year"+i).val(), $("#month"+i).val(), "");
   	   	   			/*선택된 날짜*/
   	   	   			var dd = $("#date"+i).val();
   					
   					/* HTML 초기화 */
   	   				$("#date"+i).html("");
   	   	   				   				
   	   				for(var i2 = 1; i2 <= dateSize.getDate(); i2++){
   	   					if(i2 < 10){
   	   	   					$("#date"+i).append('<option value="0'+i2+'">0'+i2+'</option>');   						
   	   					}else{
   	 	  					$("#date"+i).append('<option value="'+i2+'">'+i2+'</option>');
   	   					}
   	   				}
   	   				
   	   				/*선택된 날짜 유지*/
   	   				if(dd != null){
   	   					$("#date"+i).children("option[value='"+dd+"']").attr("selected", "selected");
   	   				}
   				}
   			}
   			/*현재 자동선택*/
   			function setSelectd(){
   				/* 출발일시 도착일시 형식) YYYY-MM-DD HH24:MI */
   				/*replace : YYYY-MM-DD-HH24-MI*/
   				/*출발일시*/
   				var startTm = "${oprat.startTm}".replace(/([\s]|[:])/gi, "-").split("-");
   				var arvlTm = "${oprat.arvlTm}".replace(/([\s]|[:])/gi, "-").split("-");
   				
   				/*현재날짜*/
   				var year = [startTm[0], arvlTm[0]];		/*년*/
				var month = [startTm[1], arvlTm[1]];	/*월*/
   				var dd = [startTm[2], arvlTm[2]];		/*알*/
   				var hh24 = [startTm[3], arvlTm[3]];		/*시 (24시간 표기)*/
   				var	mi = [startTm[4], arvlTm[4]];		/*분*/
   				
				/* 자동선택 */
				for(var i = 1; i < 3; i++){
					$("#year"+i).children("option[value='"+year[i-1]+"']").attr("selected", "selected");
					
					if(month < 10){
	  	   				$("#month"+i).children("option[value='0"+month[-1]+"']").attr("selected", "selected");
					}else{
						$("#month"+i).children("option[value='"+month[i-1]+"']").attr("selected", "selected");
					}
					
					if(hh24 < 10){
						$("#hh24"+i).children("option[value='0"+hh24[i-1]+"']").attr("selected", "selected");
					}else{
						$("#hh24"+i).children("option[value='"+hh24[i-1]+"']").attr("selected", "selected");
					}
					
					if(mi < 10){
						$("#mi"+i).children("option[value='0"+mi[i-1]+"']").attr("selected", "selected");
					}else{
						$("#mi"+i).children("option[value='"+mi[i-1]+"']").attr("selected", "selected");	
					}
					
					if(dd < 10){
	  					$("#date"+i).children("option[value='0"+dd[i-1]+"']").attr("selected", "selected");
	  				}else{
	  					$("#date"+i).children("option[value='"+dd[i-1]+"']").attr("selected", "selected");
	  				}
				}
   			}
   			
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
	   			
	   			/*경유지*/
	   			if(mode == "detailOprat" || allInit){
	   				viewState = false;
	   				
	   				/*그리드 초기화*/
					$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
	   				
					$("#gridBody").jqGrid({
						datatype: "LOCAL",
		   				caption:"경유지",
		   				width: 845,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer',
		   				colNames:["state", "번호", "출발역", "출발일시", "도착역", "도착일시", "이전역", "다음역"],
		          		colModel : [
							{ name : "state", hidden:true},
							{ name : "no", width: 40, align:"center", sortable:false,
								cellattr: function(rowId, value, rowObject, colModel, arrData) {
									return ' colspan=7';
								}
							},
							{ name : 'startStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'startTm', width: 70, align:"center", sortable:false},
							{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'arvlTm', width: 70, align:"center", sortable:false},
							{ name : 'prvStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'nxtStatnValue', width: 70, align:"center", sortable:false}
							
						]
					}); /*jqGrid end*/
					
					/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
					$("#gridBody").jqGrid('addRowData', 0, {state:"non", no:"경유지를 등록하실 수 있습니다."});
	   			} /* 경유지 end */
	   			
	   			/* 호실정보 */
	   			if(mode == "room" || allInit){
	   				viewState2 = false;
		   				
	   				/*그리드 초기화*/
					$("#grid2").html("<table id='gridBody2'></table><div id='footer2'></div>");
	   				
					$("#gridBody2").jqGrid({
						datatype: "LOCAL",
		   				caption:"호실",
		   				width: 550,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer2',
		   				colNames:["state", "번호", "호실", "좌석수", "특실여부"],
		          		colModel : [
							{ name : "state", hidden:true},
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
					$("#gridBody2").jqGrid('addRowData', 0, {state:"non", no:"호실을 등록하지 않았습니다."});
		   		} /* 호실정보 */

		   		/* 초기데이터 설정 */
		   		if(dataSet){
		   			/* detailOprat */
		   			if("${detailOpratList.size()}" > 0){
		   				for(var i = 0; i < "${detailOpratList.size()}"; i++){
		   					detailOpratArray.push({
		   						no:(i+1),
			   					state:$($("#detailOprat"+(i+1)+" :hidden").get(0)).val()+"",
			   					detailOpratCode:$($("#detailOprat"+(i+1)+" :hidden").get(1)).val()+"",
			   					startStatnCode:$($("#detailOprat"+(i+1)+" :hidden").get(2)).val()+"",
			   					startStatnValue:$($("#detailOprat"+(i+1)+" :hidden").get(3)).val()+"",
			   					startTm:$($("#detailOprat"+(i+1)+" :hidden").get(4)).val()+"",
			   					arvlStatnCode:$($("#detailOprat"+(i+1)+" :hidden").get(5)).val()+"",
			   					arvlStatnValue:$($("#detailOprat"+(i+1)+" :hidden").get(6)).val()+"",
			   					arvlTm:$($("#detailOprat"+(i+1)+" :hidden").get(7)).val()+"",
			   					prvStatnCode:$($("#detailOprat"+(i+1)+" :hidden").get(8)).val()+"",
			   					prvStatnValue:$($("#detailOprat"+(i+1)+" :hidden").get(9)).val()+"",
			   					prvDistnc:$($("#detailOprat"+(i+1)+" :hidden").get(10)).val()+" km",
			   					nxtStatnCode:$($("#detailOprat"+(i+1)+" :hidden").get(11)).val()+"",
			   					nxtStatnValue:$($("#detailOprat"+(i+1)+" :hidden").get(12)).val()+"",
			   					nxtDistnc:$($("#detailOprat"+(i+1)+" :hidden").get(13)).val()+" km"
			   				});
			   			}
			   			
			   			setGrid("detailOprat"); /* 그리드 설정 */
			   			
			   			/* 행 추가 */
			   			for(var i = 0; i < detailOpratArray.length; i++){
			   				$("#gridBody").jqGrid('addRowData', i, detailOpratArray[i]);
			   			}
		   			} /* detailOprat end */
		   			
		   			/* room */
		   			if("${roomList.size()}" > 0){
		   				for(var i = 0; i < "${roomList.size()}"; i++){
		   					roomArray.push({
		   						no:(i+1),
			   					state:$($("#room"+(i+1)+" :hidden").get(0)).val()+"",
			   					roomCode:$($("#room"+(i+1)+" :hidden").get(1)).val()+"",
			   					room:$($("#room"+(i+1)+" :hidden").get(2)).val()+" 호실",
			   					seatCo:$($("#room"+(i+1)+" :hidden").get(3)).val()+" 석",
			   					prtclrRoomYN:$($("#room"+(i+1)+" :hidden").get(4)).val()+""
			   				});
			   			}
			   			
		   				setGrid("room"); /* 그리드 설정 */
			   			
		   				/* 행 추가 */
			   			for(var value in roomArray){
			   				$("#gridBody2").jqGrid('addRowData', value, roomArray[value]);
			   			}
		   			} /* romm end */
		   		} /* 초기데이터 설정 end */
	   		} /* doGridInit end */
	   		
	   		/*그리드 생성 그리드의 존재여부확인 후 존재할 경우 실행하지 않는다*/
	   		function setGrid(mode){
	   			/*경유지*/
	   			if(mode == "detailOprat"){
	   				/*그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
					viewState = true;
	   				
					/*그리드 초기화*/
	   				$("#grid").html("<table id='gridBody'></table><div id='footer'></div>");
					
					$("#gridBody").jqGrid({
						datatype: "LOCAL",
		   				caption:"경유지",
		   				multiselect: true,
		   				width: 845,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer',
		   				colNames:[
		   					"state", "번호", "startStatnCode", "출발역", "출발일시", 
							"arvlStatnCode", "도착역", "도착일시", "prvStatnCode", "이전역",
							"nxtStatnCode", "다음역",
						],
		          		colModel : [
							{ name : 'state', hidden:true},
							{ name : 'no', width: 40, align:"right", sortable:false},
							{ name : 'startStatnCode', hidden:true},
							{ name : 'startStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'startTm', width: 120, align:"center", sortable:false},
							{ name : 'arvlStatnCode', hidden:true},
							{ name : 'arvlStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'arvlTm', width: 120, align:"center", sortable:false},
							{ name : 'prvStatnCode', hidden:true},
							{ name : 'prvStatnValue', width: 70, align:"center", sortable:false},
							{ name : 'nxtStatnCode', hidden:true},
							{ name : 'nxtStatnValue', width: 70, align:"center", sortable:false}
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
		   				caption:"호실",
		   				multiselect: true,
		   				width: 550,
		   				height: 160,
		   				scroll: 1,
		   				rowNum : 'max',
		   				pager: '#footer2',
		   				colNames:["번호", "state", "호실", "좌석수", "특실여부"],
		          		colModel : [
							{ name : "no", width: 40, align:"right", sortable:false},
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
	   				caption:"열차",
	   				width: 395,
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
						{ name : "trainNo", width: 70, sortable:false},
						{ name : "trainKndCode", hidden:true},
						{ name : "trainKndValue", width: 70, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
				
				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#trainGridBody").jqGrid('addRowData', 1, {select:"열차번호를 이용하여 열차를 검색할 수 있습니다."});
   				
   				/*다이알로그*/
   				$("#trainDialog").dialog({
   					modal: true,
   					width: 430,
					buttons: {
						"확인": function() {
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
				if($("#dTrainNo").val().replace(/\s/gi,"") == ""){
					alert("검색할 열차번호를 입력헤야 합니다.");
					return;
				}
				/*그리드 내용*/
				else{
					$.ajax({
						type:"POST",
						url: "/admin/trainList.do",
						Type:"JSON",
						data:{srcText:$("#dTrainNo").val().replace(/\s/gi ,"")},
						success : function(data) {
							if(data.trainListSize == 0){
								alert("결과가 존재하지 않습니다.");
							}else{
								/*그리드 초기화*/
								$("#trainGrid").html("<table id='trainGridBody'></table>");
									
								$("#trainGridBody").jqGrid({
									datatype: "LOCAL",
						   			caption:"열차",
						   			width: 395,
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
										
										/*라디오 버튼 자동선택*/
										$("input[value='"+trainCode+"']").click();
										
										$("#rowData1").val(trainCode);
										$("#rowData2").val(trainNo);
										$("#rowData3").val(trainKnd);
									}
								}); /*jqGrid end*/
								
								/*데이터 삽입*/
								$.each(data.trainList, function(k,v){
									$("#trainGridBody").addRowData(
										k+1,
										{
											select:'<input type="radio" name="trainCode" value="'+v.trainCode+'">',
											trainCode:v.trainCode+"",
											trainNo:v.trainNo+"",
											trainKnd:v.trainKndValue+""
										}
									); /*addRowData end*/
								}); /*$.each end*/
							} /*if end*/
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
					caption:"역",
		   			width: 350,
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
   					width: 390,
					buttons: {
						"확인": function() {
							if($("#rowData1").val() == ""){
								alert("역을 선택해야 합니다.");
							}else{
								if($("#startStatnCode").val() == $("#rowData1").val()){
									alert("이미 사용중인 역 입니다.");
									return;
								/*경유지 등록의 도착역 또는 다음역이 운행일정의 도착역과 동일한 경우*/
								}else if(type1 == "dialog" && $("#arvlStatnCode").val() == $("#rowData1").val()){
									if(type2 == "arvl" || type2 == "nxt"){
										$("#arvlStatnCode2").val($("#rowData1").val());
										$("#arvlStatnValue2").val($("#rowData2").val());
										$("#nxtStatnCode").val($("#rowData1").val());
										$("#nxtStatnValue").val($("#rowData2").val());
									}else{
										alert("이미 사용중인 역 입니다.");
										return;
									}
								}else if($("#arvlStatnCode").val() == $("#rowData1").val()){
									alert("이미 사용중인 역 입니다.");
									return;
								}else{
									if(type1 == "text"){
										/* 출발역 */
										if(type2 == "start"){
											for(var i = 0; i < $("#gridBody").getGridParam("records"); i++){
												/*경유지의 출발역*/
												var startStatn = $("#gridBody").getRowData(i).startStatnCode;
												/*경유지의 도착역*/
												var arvlStatn = $("#gridBody").getRowData(i).arvlStatnCode;
												
												if(startStatn == $("#rowData1").val() || arvlStatn == $("#rowData1").val()){
													alert("경유지에 등로된 역은 사용하실 수 없습니다.");
													return;
												}
											}
											
											$("#startStatnCode").val($("#rowData1").val());
											$("#startStatnValue").val($("#rowData2").val());
											
											/*경유지의 첫 행이 등록 되어있을 때 출발역 변경 시 이전역 수정*/
											if($("#gridBody").getRowData(0).state != "non"){
												$("#gridBody").setRowData(
													0,
													{
														prvStatnCode:$("#rowData1").val(),
														prvStatnValue:$("#rowData2").val()
													}
												);
											}
										}
										/* 도착역 */
										else if(type2 == "arvl"){
											for(var i = 0; i < $("#gridBody").getGridParam("records"); i++){
												/*경유지의 출발역*/
												var startStatn = $("#gridBody").getRowData(i).startStatnCode;
												
												if(startStatn == $("#rowData1").val()){
													alert("경유지에 등로된 역은 사용하실 수 없습니다.");
													return;
												}
											}
											
											$("#arvlStatnCode").val($("#rowData1").val());
											$("#arvlStatnValue").val($("#rowData2").val());
										}
									}else{
										/* 출발역 */
										if(type2 == "start"){
											$("#startStatnCode2").val($("#rowData1").val());
											$("#startStatnValue2").val($("#rowData2").val());
										}
										/* 이전역 */
										else if(type2 == "prv"){
											$("#prvStatnCode").val($("#rowData1").val());
											$("#prvStatnValue").val($("#rowData2").val());
										}else if(type2 == "arvl" || type2 == "nxt"){
											$("#arvlStatnCode2").val($("#rowData1").val());
											$("#arvlStatnValue2").val($("#rowData2").val());
											$("#nxtStatnCode").val($("#rowData1").val());
											$("#nxtStatnValue").val($("#rowData2").val());
										}
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
				if($("#dStatnName").val().replace(/\s/gi, "") == ""){
					alert("검색할 역 명을 입력헤야 합니다.");
					return;
				}
				/*그리드 내용*/
				else{
					$.ajax({
						type:"POST",
						url: "/admin/statnList.do",
						Type:"JSON",
						data:{srcText:$("#dStatnName").val().replace(/\s/gi, "")},
						success : function(data) {
							if(data.statnListSize == 0){
								alert("결과가 존재하지 않습니다.");
							}else{
								/*그리드 초기화*/
								$("#statnGrid").html("<table id='statnGridBody'></table>");
									
								$("#statnGridBody").jqGrid({
									datatype: "LOCAL",
						   			caption:"역",
						   			width: 350,
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
									$("#statnGridBody").addRowData(
										k,
										{
											select:'<input type="radio" name="statnCode" value="'+v.statnCode+'">',
											statnCode:v.statnCode+"",
											statnNm:v.statnNm+""
										}
									); /*addRowData end*/
								}); /*$.each end*/
							} /*if end*/
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
				} /*else end*/
   			}
   			
   			/* 경유지 다이알로그 */
   			function setDetailOpratDialog(){
   				/*출발일시*/
   				var startTime = parseInt($("#year1").val()+$("#month1").val()+$("#date1").val()+$("#hh241").val()+$("#mi1").val());
				/*도착일시*/
   				var arvlTime = parseInt($("#year2").val()+$("#month2").val()+$("#date2").val()+$("#hh242").val()+$("#mi2").val());
   				
   				if($("#startStatnCode").val() == "" || $("#startStatnCode").val() == null){
	   				alert("출발역을 입력해야 합니다.");
	   				return;
	   			}else if($("#arvlStatnCode").val() == "" || $("#arvlStatnCode").val() == null){
	   				alert("도착역을 입력해야 합니다.");
	   				return;
	   			}else if(startTime >= arvlTime){
	   				alert("출발일시는 도착일시보다 같거나 많을 수 없습니다.");
	   				return;
	   			}else{
	   				/* 날짜를 사용하기 위한 변수 */
	   				var startDate = "";
	   				var arvlDate = "";
	   				
	   				/*현재날짜*/
					var month = (new Date().getMonth()+1);	/*월*/
	   				var dd = new Date().getDate();			/*알*/
	   				var hh24 = new Date().getHours();		/*시 (24시간 표기)*/
	   				var	mi = new Date().getMinutes();		/*분*/
		   				
	   				/*그리드의 마지막 레코드*/
	   				var row = ($("#gridBody").getGridParam("records")-1);				/*경유지의 마지막 레코드*/
	   				var startStatnCode = $("#gridBody").getRowData(row).nxtStatnCode;	/*출발역 코드*/
	   				var startStatnValue = $("#gridBody").getRowData(row).nxtStatnValue;	/*출발역 값*/
	   				var prvStatnCode = $("#gridBody").getRowData(row).startStatnCode;	/*이전역 코드*/
	   				var prvStatnValue = $("#gridBody").getRowData(row).startStatnValue;	/*이전역 값*/
	
					/* Text and hidden init and setting */
	   				$("#detailOpratDialog input").val("");
	   				$("#rowData1").val("");
					$("#rowData2").val("");
					$("#rowData3").val("");
						
					/*역 정보 자동 입력*/
					if($("#gridBody").getRowData(row).state == "non"){
						$("#prvStatnCode").val($("#startStatnCode").val());
						$("#prvStatnValue").val($("#startStatnValue").val());
					}else{
						$("#startStatnCode2").val(startStatnCode);
						$("#startStatnValue2").val(startStatnValue);
						$("#prvStatnCode").val(prvStatnCode);
						$("#prvStatnValue").val(prvStatnValue);
					}
						
	   				/* 년도 설정 : 년도는 현재년도와 다음년도를 선택할수 있다. */
					$("#startYear").html("");
	   				$("#startYear").append('<option value="'+(new Date().getFullYear()-1)+'">'+(new Date().getFullYear()-1)+'</option>');
	   				$("#startYear").append('<option value="'+new Date().getFullYear()+'">'+new Date().getFullYear()+'</option>');
	   				$("#startYear").append('<option value="'+(new Date().getFullYear()+1)+'">'+(new Date().getFullYear()+1)+'</option>');
	   				/* 현재년도 설정 */
	   				$("#startYear").children("option[value='"+new Date().getFullYear()+"']").attr("selected", "selected");
		   				
	   				$("#arvlYear").html("");
	   				$("#arvlYear").append('<option value="'+(new Date().getFullYear()-1)+'">'+(new Date().getFullYear()-1)+'</option>');
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
		   				
		   			/*현재날짜 자동선택*/
		   			if(month < 10){
		  	   			$("#startMonth").children("option[value='0"+month+"']").attr("selected", "selected");
		  	   			$("#arvlMonth").children("option[value='0"+month+"']").attr("selected", "selected");
					}else{
						$("#startMonth").children("option[value='"+month+"']").attr("selected", "selected");
						$("#arvlMonth").children("option[value='"+month+"']").attr("selected", "selected");
					}
		   				
		   			if(dd < 10){
		  				$("#startDate").children("option[value='0"+dd+"']").attr("selected", "selected");
		  				$("#arvlDate").children("option[value='0"+dd+"']").attr("selected", "selected");
		  			}else{
		  				$("#startDate").children("option[value='"+dd+"']").attr("selected", "selected");
		  				$("#arvlDate").children("option[value='"+dd+"']").attr("selected", "selected");
		  			}
						
					if(hh24 < 10){
						$("#startHh24").children("option[value='0"+hh24+"']").attr("selected", "selected");
						$("#arvlHh24").children("option[value='0"+hh24+"']").attr("selected", "selected");
					}else{
						$("#startHh24").children("option[value='"+hh24+"']").attr("selected", "selected");
						$("#arvlHh24").children("option[value='"+hh24+"']").attr("selected", "selected");
					}
						
					if(mi < 10){
						$("#startMi").children("option[value='0"+mi+"']").attr("selected", "selected");
						$("#arvlMi").children("option[value='0"+mi+"']").attr("selected", "selected");
					}else{
						$("#startMi").children("option[value='"+mi+"']").attr("selected", "selected");	
						$("#arvlMi").children("option[value='"+mi+"']").attr("selected", "selected");	
					}
					
					/* 이전역 검색 번튼 */
					if($("#gridBody").getGridParam("records") > 0 && $("#gridBody").getRowData(0).state != "non"){
						$("#prvStatnValue").next().removeAttr("disabled", "disabled");
						$("#prvStatnValue").next().removeClass("b-disabled");
					}else if($("#gridBody").getRowData(0).state != "insert"){
						$("#prvStatnValue").next().attr("disabled", "disabled");
						$("#prvStatnValue").next().addClass("b-disabled");
						$("#prvStatnValue").next().css("pading", "0px");
						$("#prvStatnValue").next().css("hight", "27px");
					}else{
						$("#prvStatnValue").next().removeAttr("disabled", "disabled");
						$("#prvStatnValue").next().removeClass("b-disabled");
					}
					
					/*다이알로그*/
		   			$("#detailOpratDialog").dialog({
		   				modal: true,
		   				width: 550,
						buttons: {
							"확인": function() {
								/* 경유지 등록의 입력 값들 */
								var input = $("#detailOpratDialog input");
								/*출발역*/
			   					var startStatn = $("#startStatnCode2").val();
			   					/*도착역*/
			   					var arvlStatn = $("#arvlStatnCode2").val();
								/*출발일시*/
			   					var startTm = parseInt($("#startYear").val()+$("#startMonth").val()+$("#startDate").val()+$("#startHh24").val()+$("#startMi").val());
			   					/*도착일시*/
			   					var arvlTm = parseInt($("#arvlYear").val()+$("#arvlMonth").val()+$("#arvlDate").val()+$("#arvlHh24").val()+$("#arvlMi").val());
			   					
			   					/* 미입력 확인 */
								for(var i = 0; i < input.size(); i++){
									/* 경유지 등록의 입력 값이 하나라도 비어있다면 */
									if($(input.get(i)).val() == ""){
										alert("모든 항목은 필수입력 사항입니다.");
										return;
									}
								}
			   					/*출발역 도착역 검사*/
			   					if(startStatn == arvlStatn){
			   						alert("출발역과 도착역은 동일한 역을 사용할 수 없습니다.");
			   						return;
			   					}
			   					/*출발일시 도착일시 검사*/
			   					else if(startTm >= arvlTm){
									alert("출발일시는 도착일시보다 같거나 많을 수 없습니다.");
									return;
								}else if(startTime >= startTm || startTime >= arvlTm || arvlTime <= startTm || arvlTime < arvlTm){
			   						alert("경유지의 출발일시와 도착일시는 운행일정의 출발일시와 도착일시 내에서만 사용가능 합니다.");
			   						return;
			   					}
			   					/*그리드와 입력된 값 검사*/
			   					else{
				   					for(var i = 0; i < $("#gridBody").getGridParam("records"); i++){
				   						/*그리드 출발역*/
				   						var gridStartStatn = $("#gridBody").getRowData(i).startStatnCode;
				   						/*그리드 도착역*/
				   						var gridArvlStatn = $("#gridBody").getRowData(i).arvlStatnCode;
				   						/*그리드 출발일시*/
				   						var gridStartTm = $("#gridBody").getRowData(i).startTm.replace(/([-]|[\s]|[:])/gi, "");
				   						/*그리드 도착일시*/
				   						var gridArvlTm = $("#gridBody").getRowData(i).arvlTm.replace(/([-]|[\s]|[:])/gi, "");
				   						
				   						if(startStatn == gridStartStatn){
				   							alert("사용중인 출발역 입니다.");
				   							return;
				   						}else if(arvlStatn == gridStartStatn){
				   							alert("입력하신 도착역은 출발역으로 등록된 역 입니다.");
				   							return;
				   						}else if(arvlStatn == gridArvlStatn){
				   							alert("사용중인 도착역 입니다.");
				   							return;
				   						}else if(startTm == gridStartTm){
				   							alert("사용중인 출발일시 입니다.");
				   							return;
				   						}else if(arvlTm == gridArvlTm){
				   							alert("사용중인 도착일시 입니다.");
				   							return;
				   						}
				   					}
			   					}
								
								/* 출발익 */
								startTm = $("#startYear").val()+"-"+$("#startMonth").val()+"-"+$("#startDate").val()+" "+$("#startHh24").val()+":"+$("#startMi").val()+"";
								/* 도착일 */
								arvlTm = $("#arvlYear").val()+"-"+$("#arvlMonth").val()+"-"+$("#arvlDate").val()+" "+$("#arvlHh24").val()+":"+$("#arvlMi").val()+"";
									
								/* 초기 그리드 일 때 */
								if(!viewState){
									setGrid("detailOprat");
								}
								
								/* row 추가 */
								$("#gridBody").addRowData(
									$("#gridBody").getGridParam("records"),
									{
										state:"insert",
										no:($("#gridBody").getGridParam("records")+1),
										startStatnCode:$(input.get(0)).val(),
										startStatnValue:$(input.get(1)).val(),
										arvlStatnCode:$(input.get(2)).val(),
										arvlStatnValue:$(input.get(3)).val(),
										startTm:startTm,
										arvlTm:arvlTm,
										prvStatnCode:$(input.get(4)).val(),
										prvStatnValue:$(input.get(5)).val(),
										nxtStatnCode:$(input.get(6)).val(),
										nxtStatnValue:$(input.get(7)).val()
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
	   		}
   			
   			/* 호실 다이알로그 */
   			function setRoomDialog(){
   				/* 초기화 */
   				$("#room").val("");
   				$("input[name=prtclrRoomYN]").eq(0).click();
   				$("#seatCo1 option").eq(0).attr("selected", "selected");
   				$("#seatCo2 option").eq(0).attr("selected", "selected");
   				
   				/*다이알로그*/
   				$("#roomDialog").dialog({
   					modal: true,
   					width: 300,
					buttons: {
						"확인": function() {
							/*호실번호*/
							var room = $("#room").val().replace(/\s/gi, "");
							/*특실여부*/
							var prtclrRoomYN = $("input[name=prtclrRoomYN]:checked").val();
							/*좌석수*/
							var seatCo = null;
							/*좌석수 설정*/
							if(prtclrRoomYN == "Y"){
								seatCo = $("#seatCo1").val();
							}else{
								seatCo = $("#seatCo2").val();
							}
							
							/* 미입력 처리 및 유효성 검사 */
							if(room == "" || seatCo == "non"){
								alert("호실과 좌석수는 필수입력 사항입니다.");
								return;
							}
							
							for(var i = 0; i < $("#gridBody2").getGridParam("records"); i++){
								if($("#gridBody2").getRowData(i).room.split(" 호실")[0] == room){
									alert(room+" 호실은 사용 중인 호실입니다.");
									return;
								}
							}
							
							/* 초기 그리드 일 때 */
							if(!viewState2){
								setGrid("room");
							}
							/* row 추가 */
							$("#gridBody2").addRowData(
								$("#gridBody2").getGridParam("records"),
								{
									no:$("#gridBody2").getGridParam("records")+1,
									state:"insert",
									room:room+" 호실",
									seatCo:seatCo+" 석",
									prtclrRoomYN:prtclrRoomYN
								}
							);
							
							$(this).dialog("close");
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
	   		
	   		/*날짜선택 제어*/
   			function doControlSelect(type){
   				if(type == "form"){
   					if($("#gridBody").getRowData(0).state != "non"){
   						alert("경유지가 등록된 상태에서는 출발일시와 도착일시를 변경할 수 없습니다.");
   					}else{
   						return;
   					}
   				}
   			}
   			
   			/* 경유지, 호실 삭제 */
   			function deleteRow(type){
   				/* 경유지 */
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
   				} /* 경유지 end */
   				
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
   			
   			/* 수정 */
	   		function doUpdate(){
	   			/*출발일시*/
   				var startTime = parseInt($("#year1").val()+$("#month1").val()+$("#date1").val()+$("#hh241").val()+$("#mi1").val());
				/*도착일시*/
   				var arvlTime = parseInt($("#year2").val()+$("#month2").val()+$("#date2").val()+$("#hh242").val()+$("#mi2").val());
				
	   			/* 출발일시, 도착일시 설정 날짜형식 ) YYYY-MM-DD HH24:MI */
				$("#startTm").val($("#year1").val()+"-"+$("#month1").val()+"-"+$("#date1").val()+" "+$("#hh241").val()+":"+$("#mi1").val());
				$("#arvlTm").val($("#year2").val()+"-"+$("#month2").val()+"-"+$("#date2").val()+" "+$("#hh242").val()+":"+$("#mi2").val());
   				
   				/* 미입력 검사 */
				for(var i = 0; i < $("#addForm tbody input").size(); i++){
					if($($("#updateForm tbody input").get(i)).val() == ""){
						alert("모든 필드는 필수입력 사항입니다.");
						return;
					}
				}
   				
   				/*날짜입력 검사*/
   				if(startTime >= arvlTime){
					ert("출발일시는 도착일시보다 같거나 많을 수 없습니다.");
   					return;
   				}

   				
   				/* 그리드 데이터 확인 */
				if($("#gridBody2").getRowData(0).state == "non"){
					alert("호실정보는 하나 이상 등록되어야 합니다.");
					return;
				}else{
					$.ajax({
						type:"POST",
						url: "/admin/opratCheck.do",
						Type:"JSON",
						data:{code:$("#trainCode").val(), srcDate1:$("#startTm").val(), srcDate2:$("#arvlTm").val()},
						success : function(data) {
							if(data.opratCount > 0){
								alert("등록된 운행일정입니다.");
							}else{
								var array1 = $("#gridBody").getRowData();  /* 상세운행정보 */
					   			var array2 = $("#gridBody2").getRowData(); /* 호실정보 */
					   			var jsonArray = new Array();
					   			
								/* 그리드정보에 delete정보 적용 */
					   			for(var v in detailOpratArray){
					   				/* 경유지 */
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
					   			
					   			if(confirm("이 운행정보를 수정하시겠습니까?")){
					   				/*replace*/
					   				$("input[name=fare]").val($("input[name=fare]").val().replace(/,/gi, ""));
					   				
					   				$("#updateForm").submit();
				   				}
							} /*if end*/
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
	   			} /* else end */
	   		}  /* doUpdate end */
   			
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
			<div>* 운행정보는 운행에 대한 기본적인 정보를 입력합니다.</div>
			<div>* 열차번호, 출발역, 도착역, 노선은 검색을 통해 입력 할 수 있습니다.</div>
			<div>* 열차종류는 선택한 열차번호에 따라 자동 입력됩니다.</div>
			<div>* 출발일시와 도착일시는 운행일정 등록당시 선택하신 날짜 및 시각이 자동선택되어있습니다.</div>
			<div>* 이미등록된 역은 사용하실 수 없습니다.</div>
			<div>* 경유지가 등록되어있는 경우 운행일정의 출발일시와 도착일시는 변경할 수 없습니다.</div>
			<div>* 경유지는 목록의 오른쪽 위의 추가, 삭제 버튼을 이용하여 추가, 삭제가 가능합니다.</div>
			<div>* 경유지는 첫 행 추가 시 이전역은 운행일정의 출발역으로 자동입력되며 변경할 수 없습니다.</div>
			<div>* 운행일정의 출발역을 변경할 경우 경유지의 첫 행의 이전역이 운행일정의 출발역으로 자동변경됩니다.</div>
			<div>* 경유지의 출발일시와 도착일시는 현재 날짜 및 시각이 자동선택되어있습니다.</div>
			<div>* 경유지의 출발역은 이전 행이 존재할 경우 이전 행의 다음역이 자동입력됩니다.</div>
			<div>* 경유지의 도착역을 선택 시 선택한 도착역의 정보가 다음역에 자동입력됩니다,</div>
			<div style="padding-left: 12px;">또한 다음역을 선택하더라도 선택한 다음역의 정보가 도착역에 자동입력됩니다.</div>
			<div>* 호실은 목록의 오른쪽 위의 추가, 삭제 버튼을 이용하여 추가, 삭제가 가능합니다.</div>
			<div>* 호실은 최대 5자리까지 숫자만 입력가능합나디.</div>
			<div>* 모든 작업이 완료되었다면 수정 버튼을 이용하여 입력한 정보를 수정 할 수 있습니다.</div>
			<div>* 호실은 하나이상 등록을 해야합나디ㅏ.</div>
			<div>* 진행중인 작업을 취소버튼을 이용해 취소 할 수 있습니다.</div>
   		</div>
   		
   		<!-- 운행일정 -->
   		<div>
   			<form id="updateForm" action="/admin/opratProcess.do">
   				<!-- 수정으로 상태설정 -->
   				<input type="hidden" name="state" value="update">
   				<!-- 수정자 설정 (수정자는 현재 로그인한 회원명으로 등록된다.) -->
   				<input type="hidden" name="updUsr" value="${name}">
   				<!-- 수정할 운행일정 코드 -->
   				<input name="opratCode" type="hidden" value="${oprat.opratCode}">
				<!-- JSON type -->
				<input id="json1" name="json" type="hidden">
				<input id="json2" name="json" type="hidden">
				
				<table class="d-table">
					<colgroup>
						<col width="10%">
						<col width="25%">
						<col width="10%">
						<col width="32%">
						<col width="3%">
					</colgroup>
					<thead>
						<tr>
							<td colspan="5" class="t-radius">
								<strong>운행일정</strong>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<!-- 열차코드 -->
							<td style="display: none;">
								<input id="trainCode" name="trainCode" type="hidden" value="${oprat.trainCode}">
							</td>
							<td class="head">열차번호</td>
							<td>
								<input id="trainNo" type="text" style="width: 76%;" disabled="disabled" value="${oprat.trainNo}">
								<button type="button" onclick="setTrainDialog();" style="width: 20%;">검색</button>
							</td>
							<td class="head">열차종류</td>
							<td colspan="2">
								<input id="trainKnd" style="width: 98%;" type="text" disabled="disabled" value="${oprat.trainKndValue}">
							</td>
						</tr>
						<tr>
							<td class="head">출발역</td>
							<td>
								<input id="startStatnCode" name="startStatnCode" type="hidden" value="${oprat.startStatnCode}">
								<input id="startStatnValue" style="width: 76%;" type="text" disabled="disabled" value="${oprat.startStatnValue}">
								<button type="button" onclick="setStatnDialog('text', 'start');" style="width: 20%;">검색</button>
							</td>
							<td class="head">출발일시</td>
							<td colspan="2">
								<input id="startTm" name="startTm" type="hidden">
								<select id="year1" onchange="setDateTime();" onclick="doControlSelect('form');" style="width: 15%;">
	   								<!-- script -->
	   							</select>
	   							<label>년</label>
								<select id="month1" onchange="setDateTime();" onclick="doControlSelect('form');" style="width: 12%;">
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
								<select id="date1" onclick="doControlSelect('form');" style="width: 12%;">
	   								<!-- script -->
	   							</select>
	   							<label>일</label>
								<select id="hh241" onclick="doControlSelect('form');" style="width: 12%;">
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
								<select id="mi1" onclick="doControlSelect('form');" style="width: 12%;">
	   								<c:forEach var="mi" begin="0" end="59" step="1">
		   								<c:if test="${mi < 10}">
			   								<option value="0${mi}">0${mi}</option>
		   								</c:if>
		   								<c:if test="${mi > 9}">
			   								<option value="${mi}">${mi}</option>
		   								</c:if>
		   							</c:forEach>
	   							</select>
	   							<label>분</label>
							</td>
						</tr>
						<tr>
							<td class="head">도착역</td>
							<td>
								<input id="arvlStatnCode" name="arvlStatnCode" type="hidden" value="${oprat.arvlStatnCode}">
								<input id="arvlStatnValue" style="width: 76%;" type="text" disabled="disabled" value="${oprat.arvlStatnValue}">
								<button type="button" onclick="setStatnDialog('text', 'arvl');" style="width: 20%;">검색</button>
							</td>
							<td class="head">도착일시</td>
							<td colspan="2">
								<input id="arvlTm" name="arvlTm" type="hidden">
								<select id="year2" onchange="setDateTime();" onclick="doControlSelect('form');" style="width: 15%;">
	   								<!-- script -->
	   							</select>
	   							<label>년</label>
								<select id="month2" onchange="setDateTime();" onclick="doControlSelect('form');" style="width: 12%;">
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
								<select id="date2" onclick="doControlSelect('form');" style="width: 12%;">
	   								<!-- script -->
	   							</select>
	   							<label>일</label>
								<select id="hh242" onclick="doControlSelect('form');" style="width: 12%;">
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
								<select id="mi2" onclick="doControlSelect('form');" style="width: 12%;">
	   								<c:forEach var="mi" begin="0" end="59" step="1">
		   								<c:if test="${mi < 10}">
			   								<option value="0${mi}">0${mi}</option>
		   								</c:if>
		   								<c:if test="${mi > 9}">
			   								<option value="${mi}">${mi}</option>
		   								</c:if>
		   							</c:forEach>
	   							</select>
	   							<label>분</label>
							</td>
						</tr>
						<tr>
							<td class="head">노선</td>
							<td>
								<input id="routeCode" name="routeCode" type="hidden" value="${oprat.routeCode}">
								<input id="routeValue" type="text" disabled="disabled" value="${oprat.routeValue}" style="width: 76%;">
								<button type="button" style="width: 20%;">검색</button>
							</td>
							<td class="head">요금</td>
							<td>
								<input name="fare" type="text" value="${oprat.fare}" onkeydown="doNumberCheck(this, event, 13, toCommaNumber(this));" onkeyup="toCommaNumber(this);" style="width: 98%;" dir="rtl">
							</td>
							<td class="b-r-radius head">원</td>
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
	   		<!-- data -->
   			<c:forEach var="value" items="${detailOpratList}" varStatus="state">
		   		<div id="detailOprat${state.count}">
	   				<input type="hidden" value="${value.state}">
	   				<input type="hidden" value="${value.detailOpratCode}">
					<input type="hidden" value="${value.startStatnCode}">
		   			<input type="hidden" value="${value.startStatnValue}">
		   			<input type="hidden" value="${value.startTm}">
		   			<input type="hidden" value="${value.arvlStatnCode}">
		   			<input type="hidden" value="${value.arvlStatnValue}">
		   			<input type="hidden" value="${value.arvlTm}">
		   			<input type="hidden" value="${value.prvStatnCode}">
		   			<input type="hidden" value="${value.prvStatnValue}">
		   			<input type="hidden" value="${value.prvDistnc}">
		   			<input type="hidden" value="${value.nxtStatnCode}">
		   			<input type="hidden" value="${value.nxtStatnValue}">
		   			<input type="hidden" value="${value.nxtDistnc}">
		   		</div>
   			</c:forEach>
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
	  		<!-- data -->
   			<c:forEach var="value" items="${roomList}" varStatus="state">
		   		<div id="room${state.count}">
	   				<input type="hidden" value="${value.state}">
	   				<input type="hidden" value="${value.roomCode}">
					<input type="hidden" value="${value.room}">
		   			<input type="hidden" value="${value.seatCo}">
		   			<input type="hidden" value="${value.prtclrRoomYN}">
		   		</div>
   			</c:forEach>
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
		<div id="detailOpratDialog" title="경유지 등록" style="display: none;">
   			<table class="d-table" style="width:100%; margin: 0 auto;">
				<tbody>
					<tr>
						<td class="head t-l-radius">출발역</td>
						<td colspan="2">
							<input id="startStatnCode2" type="hidden">
							<input id="startStatnValue2" type="text" style="width: 117px;" disabled="disabled">
							<button type="button" onclick="setStatnDialog('dialog', 'start');" style="height: 27px; vertical-align: top;">검색</button>
						</td>
						<td class="head">도착역</td>
						<td colspan="2" class="t-r-radius">
							<input id="arvlStatnCode2" type="hidden">
							<input id="arvlStatnValue2" type="text" style="width: 102px;" disabled="disabled">
							<button type="button" onclick="setStatnDialog('dialog' ,'arvl');" style="height: 27px; vertical-align: top;">검색</button>
						</td>
					</tr>
					<tr>
						<td class="head">출발일시</td>
						<td>
							<select id="startYear" onchange="setDateTime();" style="width: 70px;">
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
   								<c:forEach var="mi" begin="0" end="60" step="1">
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
						<td class="head">도착일시</td>
						<td>
							<select id="arvlYear" onchange="setDateTime();" style="width: 70px;">
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
   								<c:forEach var="mi" begin="0" end="59" step="1">
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
						<td class="head b-l-radius">이전역</td>
						<td colspan="2">
							<input id="prvStatnCode" type="hidden">
							<input id="prvStatnValue" type="text" style="width: 117px;" disabled="disabled">
							<button type="button" onclick="setStatnDialog('dialog' ,'prv');" style="width:51px; height: 27px; padding: 0px; vertical-align: top;">검색</button>
						</td>
						<td class="head">다음역</td>
						<td colspan="2" class="b-r-radius">
							<input id="nxtStatnCode" type="hidden">
							<input id="nxtStatnValue" type="text" style="width: 102px;" disabled="disabled">
							<button type="button" onclick="setStatnDialog('dialog' ,'nxt');" style="height: 27px; vertical-align: top;">검색</button>
						</td>
					</tr>
					<tr>
				</tbody>
			</table>
		</div> <!-- detailOpratDialog -->
		
		<div id="roomDialog" title="호실정보 등록" style="display: none;">
			<table class="d-table" style="width:100%; margin: 0 auto;">
				<colgroup>
					<col width="30%">
					<col width="35%">
					<col width="35%">
				</colgroup>
				<tbody>
					<tr>
						<td class="head t-l-radius">호실</td>
						<td class="t-r-radius" colspan="2" style="width: 60px;">
							<input id="room" type="text" dir="rtl" onkeydown="doNumberCheck(this, event, 5)" style="width: 98%;">
						</td>
					</tr>
					<tr>
						<td class="head" rowspan="2">좌석수</td>
						<td>
							<label>특실<input type="radio" name="prtclrRoomYN" value="Y"></label>
						</td>
						<td>
							<label>일반실<input type="radio" name="prtclrRoomYN" value="N"></label>
						</td>
					</tr>
					<tr>
						<td class="b-l-radius">
							<select id="seatCo1" style="width: 99%;">
								<option value="non">선택</option>
								<option value="26">26</option>
								<option value="35">35</option>
							</select>
						</td>
						<td class="b-r-radius">
							<select id="seatCo2" style="width: 99%;">
								<option value="non">선택</option>
								<option value="56">56</option>
								<option value="60">60</option>
							</select>
						</td>
					<tr>
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
   		
   		<!-- 수정/취소 버튼 -->
   		<div class="button-group" style="width: 847px; margin-top: 30px; text-align: center;">
   			<button type="button" onclick="doUpdate();">수정</button>
			<button type="button" onclick="doCancel();">취소</button>
   		</div>
	</body>
</html>