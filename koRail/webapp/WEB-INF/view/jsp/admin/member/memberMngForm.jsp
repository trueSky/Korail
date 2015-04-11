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
   			var viewState2 = false; /*승차권 예매 내역 그리드가 화면에 보여지는 상태(true : 보임 , false : 숨김)*/
   			var srcDate1 = "";   /* 시작 날짜 */
   			var srcDate2 = "";   /* 끝 날짜 */
   			
	   		$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(3)).addClass("set");
				$($(".lmb tr").get(3)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual13.jpg");
				
	   			/*엔터*/
				$("#srcText").keydown(function(e){
					if(e.keyCode == 13){
						$("#searchBtn").click();
					}
				});
	   			
				/*날짜조회 다이알로그 radio style*/
				$("input[name=dtype]").click(function(){
					if($(this).val() == "rgsde"){
						$(this).attr("checked", "checked");
						$(this).parent().parent().css("background", "#FF8224");
		   				$(this).parent().parent().next().css("background", "#515151");
					}else{
						$(this).attr("checked", "checked");
						$(this).parent().parent().css("background", "#FF8224");
		   				$(this).parent().parent().prev().css("background", "#515151");
					}
				});
	   			
	   			/*그리드 초기상태*/
				doGridInit();
				/*전체로 자동조회*/
				findMemberList("normal");
	   		});
   			
	   		/*그리드 초기상태*/
   			function doGridInit(){
	   			viewState = false;
	   			
	   			/* 초기화 */
	   			$("#grid").html("<table id='gridBody'></table><div id='footer'><div>");
	   			
   				$("#gridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"회원",
	   				width: 847,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["state", "번호", "승차권 예매 내역", "아이디", "성명", "가입일", "개인정보 수정일"],
	          		colModel : [
						{ name : "state", hidden:true},
						{ name : "no", align:"center", width: 30, height : 200, sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=6';
							}
						},
						{ name : "rcrd", align:"center", width: 40, sortable:false},
						{ name : "id", width: 60, align:"center", sortable:false},
						{ name : "nm", width: 40, align:"center", sortable:false},
						{ name : "rgsde", width: 50, align:"center", sortable:false},
						{ name : "updde", width: 50, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
				
   				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").addRowData(0, {no:"조회된 결과가 존재하지 않습니다."});
	   		} /* doGridInit end */
	   		
	   		/* 그리드 생성 */
	   		function setGrid(){
	   			viewState = true;
   				
	   			/* 초기화 */
	   			$("#grid").html("<table id='gridBody'></table><div id='footer'><div>");
	   			
   				$("#gridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"회원",
	   				multiselect: true,
	   				width: 847,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["state", "번호", "승차권 예매 내역", "아이디", "성명", "zipCode", "addrs",
	   				       "detailAddrs", "telNo", "mbtlnum", "email",
	   				    	"gndr", "가입일", "개인정보 수정일"
	   				],
	          		colModel : [
						{ name : "state", hidden:true},
						{ name : "no", align:"right", width: 30, sortable:false},
						{ name : "rcrd", align:"center", width: 40, sortable:false},
						{ name : "id", align:"center", width: 60, sortable:false},
						{ name : "nm", width: 40, align:"center", sortable:false},
						{ name : "zipCode", hidden:true},
						{ name : "addrs", hidden:true},
						{ name : "detailAddrs", hidden:true},
						{ name : "telNo", hidden:true},
						{ name : "mbtlnum", hidden:true},
						{ name : "emal", hidden:true},
						{ name : "gndr", hidden:true},
						{ name : "rgsde", width: 50, align:"center", sortable:false},
						{ name : "updde", width: 50, align:"center", sortable:false}
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
	   			/* 현제날짜 */
	   			var date = new Date();
	   			
	   			/* 변수 초기화 */
	   			srcDate1 = "";
	   			srcDate2 = "";
	   			
	   			/* 초기화 */
   				$("#startYear1").html("");
   				$("#endYear1").html("");
   				$("#startDate1").val("");
   				$("#endDate1").val("");
   				
   				/* 년도 설정 : 년도는 현재년도와 다음년도를 선택할수 있다. */
   				for(var i = 1980; i < 2100; i++){
   					$("#startYear1").append('<option value="'+i+'">'+i+'</option>');
   					$("#endYear1").append('<option value="'+i+'">'+i+'</option>');
   				}
   				/* 현재년도 자동선택 */
   				$("#startYear1").children("option[value='"+date.getFullYear()+"']").attr("selected", "selected");
	   			$("#endYear1").children("option[value='"+date.getFullYear()+"']").attr("selected", "selected");
   				
   				/* 현재 월 선택 */
   				if((date.getMonth()+1) < 10){
   					$("#startMonth1").children("option[value='0"+(date.getMonth()+1)+"']").attr("selected", "selected");
   	   				$("#endMonth1").children("option[value='0"+(date.getMonth()+1)+"']").attr("selected", "selected");
   				}else{
   					$("#startMonth1").children("option[value='"+(date.getMonth()+1)+"']").attr("selected", "selected");
   	   				$("#endMonth1").children("option[value='"+(date.getMonth()+1)+"']").attr("selected", "selected");
   				}
	   			
   				/* 날짜설정 */
   				setDate("all");
   				
   				/*현재 월의 01~마지막 일 자동선택*/
   				$("#startDate1 :first").attr("selected", "selected");
   				$("#endDate1 :last").attr("selected", "selected");
   				
   				/*가입일 자동선택 및 style*/
   				$("input[name=dtype]").eq(1).removeAttr("checked", "checked");
   				$("input[name=dtype]").eq(0).prop("checked", true);
   				$("input[name=dtype]").eq(0).parent().parent().css("background", "#FF8224");
   				$("input[name=dtype]").eq(0).parent().parent().next().css("background", "#515151");
   				
	   			/*다이알로그*/
   				$("#dateDialog").dialog({
   					modal: true,
   					width: 390,
					buttons: {
						"조회": function() {
							srcDate1 = $("#startYear1").val()+"-"+$("#startMonth1").val()+"-"+$("#startDate1").val();
							srcDate2 = $("#endYear1").val()+"-"+$("#endMonth1").val()+"-"+$("#endDate1").val();
							
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
	   			for(var index = 1; index < 3; index++){
		   			/* 시작날짜 설정 */
		   			if(mode == "start" || mode == "all"){
		   				/* 년과 월에 대한 날짜 */
		   				var newStartDate = new Date($("#startYear"+index).val(), $("#startMonth"+index).val(), "");
		   				/*현재 선택된 날짜*/
		   				var oldStartDate = $("#startDate"+index).val();
		   				
		   				$("#startDate"+index).html("");
		   				
		   				for(var i = 1; i <= newStartDate.getDate(); i++){
		   					if(i < 10){
		   	   					$("#startDate"+index).append('<option value="0'+i+'">0'+i+'</option>');   						
		   					}else{
		 	  					$("#startDate"+index).append('<option value="'+i+'">'+i+'</option>');
		   					}
		   				}
		   				
		   				/*선택한 날짜 유지*/
		   				if(oldStartDate != null){
		   					$("#startDate"+index).children("option[value='"+oldStartDate+"']").attr("selected", "selected");	
		   				}
		   			}
					/* 끝 날짜 설정 */
		   			if(mode == "end" || mode == "all"){
		   				/* 년과 월에 대한 날짜 */
		   				var newEndDate = new Date($("#endYear"+index).val(), $("#endMonth"+index).val(), "");
		   				/*현재 선택된 날짜*/
		   				var oldEndDate = $("#endDate"+index).val();
		   				
		   				$("#endDate"+index).html("");
		   				
		   				for(var i = 1; i <= newEndDate.getDate(); i++){
		   					if(i < 10){
		   	   					$("#endDate"+index).append('<option value="0'+i+'">0'+i+'</option>');   						
		   					}else{
		 	  					$("#endDate"+index).append('<option value="'+i+'">'+i+'</option>');
		   					}
		   				}
		   				
		   				/*선택한 날짜 유지*/
		   				if(oldEndDate != null){
		   					$("#endDate"+index).children("option[value='"+oldEndDate+"']").attr("selected", "selected");
		   				}
		   			}
	   			}
	   		}
	   		
	   		/*리스트*/
			function findMemberList(mode){
	   			var srcType = null;	/*검색유형*/
	   			var srcText = null;	/* 검색어 */
	   			
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
	   				srcType = "rgsde";
	   				srcText = "";
	   			}else if(mode == "updde"){
	   				/* 삭제할 시 제검색 유형 설정 */
	   				$("#deleteType").val("updde");
	   				srcType = "updde";
	   				srcText = "";
	   			}
	   			/* 일반 검색 */
	   			else{
	   				/*검색조건*/
		   			srcType = $("#srcType").val();
		   			srcText = $("#srcText").val().replace(/\s/gi, "");
		   			srcDate1 = null;
		   			srcDate2 = null;
		   			
	   				/* 삭제할 시 제검색 유형 설정 */
	   				$("#deleteType").val("normal");
	   				
	   				if(srcType != "ALL" && srcText == ""){
						alert("조회조건을 입력해야 합나디다.");
						return;
		   			}
	   			}
		   		
				/*그리드 내용*/				
				$.ajax({
					type:"POST",
					url: "/admin/memberList.do",
					Type:"JSON",
					data:{
							srcType:srcType,
							srcText:srcText,
							srcDate1:srcDate1,
							srcDate2:srcDate2
					},
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
								var zipCode = "";
								
								if(v.zipCode != null){
									zipCode = v.zipCode.replace(/,/gi, "-");
								}
								
								$("#gridBody").addRowData(
									k,
									{
										state:v.state,
										no:k+1,
										rcrd:"<button type='button' onclick='setRcrdDialog(&quot;"+v.id+"&quot;);'>승차권 예매 내역</button>",
										id:v.id,
										nm:v.nm,
										zipCode:zipCode,
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
							url: "/admin/memberProcess.do?",
							Type:"JSON",
							data:{deleteCodeArray:$("input[name=deleteCodeArray]").val()},
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
											alert(data.errorMsg+"에 만료되지 않은 승차권이 존재합니다.");
										}
									}
								}
							}, /* success end */
							error : function(request, status, error){
								if(request.status == 401){
									alert("세션이 만료되었습니다.");
									location.href = "/logout.do";
								}else{
									alert("서버에러입니다.");
								}
							}
						}); /* ajax end */
					} /* if end */
				} /* else end */
   			} /* deleteMember end */
   			
   			/*승차권 예매 내역 다이알로그*/
   			function setRcrdDialog(id){
   				/* 현제날짜 */
	   			var date = new Date();
   				
   				/*id 저장*/
   				$("#srcId").val(id);
	   			
	   			/* 초기화 */
   				$("#startYear2").html("");
   				$("#endYear2").html("");
   				$("#startDate2").val("");
   				$("#endDate2").val("");
   				
   				/* 년도 설정 : 년도는 현재년도와 다음년도를 선택할수 있다. */
   				for(var i = 1980; i < 2100; i++){
   					$("#startYear2").append('<option value="'+i+'">'+i+'</option>');
   					$("#endYear2").append('<option value="'+i+'">'+i+'</option>');
   				}
   				/* 현재년도 자동선택 */
   				$("#startYear2").children("option[value='"+date.getFullYear()+"']").attr("selected", "selected");
	   			$("#endYear2").children("option[value='"+date.getFullYear()+"']").attr("selected", "selected");
   				
   				/* 현재 월 선택 */
   				if((date.getMonth()+1) < 10){
   					$("#startMonth2").children("option[value='0"+(date.getMonth()+1)+"']").attr("selected", "selected");
   	   				$("#endMonth2").children("option[value='0"+(date.getMonth()+1)+"']").attr("selected", "selected");
   				}else{
   					$("#startMonth2").children("option[value='"+(date.getMonth()+1)+"']").attr("selected", "selected");
   	   				$("#endMonth2").children("option[value='"+(date.getMonth()+1)+"']").attr("selected", "selected");
   				}
	   			
   				/* 날짜설정 */
   				setDate("all");
   				
   				/*현재 월의 01~마지막 일 자동선택*/
   				$("#startDate2 :first").attr("selected", "selected");
   				$("#endDate2 :last").attr("selected", "selected");
   				
				/*Set dialog title*/
   				$("#resveRcrdDialog").removeAttr("title");
   				$("#resveRcrdDialog").attr("title", "승차권 예매 내역 ("+id+")");
   				
   				/*기본 그리드 생성*/
   				$("#rcrdGrid").html("<table id='rcrdGridBody'></table><div id='rcrdGridFooter'></div>");
   				$("#rcrdGridBody").jqGrid({
					datatype: "LOCAL",
	   				caption:"승차권 예매 내역",
	   				width: 800,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#rcrdGridFooter',
	   				colNames:["번호", "열차번호", "열차종류", "출발역", "출발일시",
	   				       "도착역", "도착일시", "예약매수", "결제상태"
	   				],
	          		colModel : [
						{ name : "no", align:"center", width: 20, sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=9';
							}
						},
						{ name : "trainNo", align:"center", width: 40, sortable:false},
						{ name : "trainKend", width: 60, align:"center", sortable:false},
						{ name : "startStatn", width: 60, align:"center", sortable:false},
						{ name : "startTm", width: 70, align:"center", sortable:false},
						{ name : "arvlStatn", width: 60, align:"center", sortable:false},
						{ name : "arvlTm", width: 70, align:"center", sortable:false},
						{ name : "resveCo", width: 40, align:"center", sortable:false},
						{ name : "setleSttus", width: 40, align:"center", sortable:false}
					],
				}); /*jqGrid end*/
				$("#rcrdGridBody").addRowData(0, {no:"조회된 결과가 존재하지 않습니다."});
   				
   				viewState = false;
   				findRcrdList();
				
   				/*다이알로그*/
   				$("#resveRcrdDialog").dialog({
   					modal: true,
   					width: 900,
					buttons: {
						"닫기": function() {
							$(this).dialog("close");
						}
					} /* btuuon end */
   				}); /* dialog end */
   			}
   			
   			/*승차권 예매 내역 조회*/
   			function findRcrdList(){
   				/*조회기간 형식) YYYY-MM-DD*/
   				var startTm = $("#startYear2").val()+"-"+$("#startMonth2").val()+"-"+$("#startDate2").val();
   				var arvlTm = $("#endYear2").val()+"-"+$("#endMonth2").val()+"-"+$("#endDate2").val();
   				
   				/*그리드*/
   				$.ajax({
					type:"POST",
					url: "/member/useHstrList.do",
					data: {srcType:$("#srcId").val(), srcDate1:startTm, srcDate2:arvlTm},
					Type:"JSON",
					success : function(data) {
						/* 승차권 예매 내역 */
						if(data.resveRcrdListSize == 0){
							alert("조회된 결과가 존재하지 않습니다.");
						}else{
							if(!viewState2){
								viewState = true;
								$("#rcrdGrid").html("<table id='rcrdGridBody'></table><div id='rcrdGridFooter'></div>");
								$("#rcrdGridBody").jqGrid({
									datatype: "LOCAL",
					   				caption:"승차권 예매 내역",
					   				width: 800,
					   				height: 160,
					   				scroll: 1,
					   				rowNum : 'max',
					   				pager: '#rcrdGridFooter',
					   				colNames:["번호", "열차번호", "열차종류", "출발역", "출발일시",
					   				       "도착역", "도착일시", "예약매수", "결제상태"
					   				],
					          		colModel : [
										{ name : "no", align:"right", width: 20, sortable:false},
										{ name : "trainNo", align:"center", width: 40, sortable:false},
										{ name : "trainKnd", width: 60, align:"center", sortable:false},
										{ name : "startStatn", width: 60, align:"center", sortable:false},
										{ name : "startTm", width: 70, align:"center", sortable:false},
										{ name : "arvlStatn", width: 60, align:"center", sortable:false},
										{ name : "arvlTm", width: 70, align:"center", sortable:false},
										{ name : "resveCo", width: 20, align:"center", sortable:false},
										{ name : "setleSttus", width: 40, align:"center", sortable:false}
									],
								}); /*jqGrid end*/
							}
							
   							/* 데이터 삽입 */
							$.each(data.resveRcrdList, function(k, v){
								$("#rcrdGridBody").addRowData(
									k+1,
									{
										no:k+1,
										trainNo:v.trainNo,
										trainKnd:v.trainKnd,
										startStatn:v.startStatn,
										startTm:v.startTm,
										arvlStatn:v.arvlStatn,
										arvlTm:v.arvlTm,
										resveCo:v.resveCo+" 장",
   										setleSttus:v.setleSttusValue
									}
								);
   							}); /* $.each end */
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
				}); /* $.ajax end */
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
   			<div>* 전체, 아이디, 성명으로 회원을 조회할 수 있습니다.</div>
   			<div>* 전체조회에 한하여 검색조건을 입력하지 않더라도 조회가 가능합니다.</div>
			<div>* 날짜조회를 이용하여 가입일 또는 개인정보 수정일을 기준으로 회원을 조회 할 수 있습니다.</div>
			<div style="padding-left: 14px;">(다중선택이 가능합니다.)</div>
			<div>* 회원목록의 체크박스를 이용하여 삭제할 회원을 선택한 후 삭제버튼을 이용해 회원정보를 삭제할 수</div>
			<div style="padding-left: 14px;">있습니다.</div>
			<div>* 회원목록에서 특정해원을 클릭하여 선택하게되면 선택된 회원에 대한 상세정보를 볼 수 있습니다.</div>
			<div>* 승차권 예매 내역 버튼을 이용하여 회원의 예매 내역을 볼 수 있습니다.</div>
			<div>* 승차권 예매 내역은 기본적으로 최근 1계월 동안의 내역이 자동조회됩니다.</div>
   		</div>
   		
   		<!-- search -->
   		<div id="serch">
   			<table class="search-group">
   				<tbody>
   					<tr>
   						<!-- 조회 -->
   						<td style="width: 100px; padding-left: 15px;">
   							<select id="srcType" style="width: 100%; height: 25px">
   								<option value="ALL">전체</option>
   								<option value="id">아이디</option>
   								<option value="name">성명</option>
   							</select>
   						</td>
   						<td style="width: 120px;">
   							<input id="srcText" type="text" style="width: 95%; height: 19px;">
   						</td>
   						<td style="width: 75px;">
   							<button id="searchBtn" onclick="findMemberList('normal');" type="button" style="width: 100%; height: 25px;">조회</button>
   						</td>
   						<!-- 날짜검색 -->
   						<td style="width: 90px;">
   							<button onclick="setDataDialog();" type="button" class="btn" style="width: 95%; height: 25px; margin-left: 3px;">날짜조회</button>
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
   		<div id="grid" style="margin: 0 auto; margin-top: 15px; width: 847px;">
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
   						<td class="t-radius" colspan="6">상세정보</td>
   					</tr>
   				</thead>
   				<tbody>
   					<tr>
   						<td class="head">아이디</td>
   						<td id="id">--</td>
   						<td class="head">성명</td>
   						<td id="nm">--</td>
   					</tr>
   					<tr>
   						<td class="head">가입일</td>
   						<td id="rgsde">--</td>
   						<td class="head">개인정보 수정일</td>
   						<td id="updde">--</td>
   					</tr>
   					<tr>
   						<td class="head">전화번호</td>
   						<td id="telNo">--</td>
   						<td class="head">휴대전화번호</td>
   						<td id="mbtlnum">--</td>
   					</tr>
   					<tr>
   						<td class="head">이메일</td>
   						<td id="email">--</td>
   						<td class="head">성별</td>
   						<td id="gndr">--</td>
   					</tr>
   					<tr>
   						<td class="head">우편번호</td>
   						<td id="zipCode">--</td>
   						<td class="head">주소</td>
   						<td id="addrs">--</td>
   					</tr>
   					<tr>
   						<td class="head b-l-radius">상세주소</td>
   						<td id="detailAddrs" class="b-r-radius" colspan="5">--</td>
   					</tr>
   				</tbody>
   			</table>
   		</div>
		
		<div id="dateDialog" title="날짜조회" style="display: none;">
			<table class="d-table" style="margin-top: 5px; width: 350px;">
				<colgroup>
					<col width="50%">
					<col width="50%">
				</colgroup>
				<tbody>
					<!-- 검색 형식 -->
					<tr>
						<td class="head t-l-radius">
							<label style="vertical-align: middle;">
								<input value="rgsde" type="radio" name="dtype" checked="checked" style="vertical-align: middle;"> 가입일
							</label>
						</td>
						<td class="head t-r-radius">
							<label style="vertical-align: middle;">
								<input value="updde" type="radio" name="dtype" style="vertical-align: middle;"> 개인정보 수정일
							</label>
						</td>
					</tr>
					<!-- 날짜 -->
					<tr>
						<td class="head" colspan="2">
							<select id="startYear1" onchange="setDate('start');" style="width: 75px;">
   								<!-- script -->
   							</select>
   							<label style="margin-right: 20px;">년</label>
   							<select id="startMonth1" onchange="setDate('start');" style="width: 55px;">
   								<c:forEach var="month" begin="1" end="12">
   									<c:if test="${month < 10}">
		   								<option value="0${month}">0${month}</option>
	   								</c:if>
	   								<c:if test="${month > 9}">
		   								<option value="${month}">${month}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
   							<label style="margin-right: 20px;">월</label>
   							<select id="startDate1" style="width: 55px;">
   								<!-- script -->
   							</select>
   							<label>일</label>
						</td>
					</tr>
					<tr>
						<td class="head" colspan="2" style="text-align: center;">~</td>
					</tr>
					<tr>
						<td class="head" colspan="2">
							<select id="endYear1" onchange="setDate('end');" style="width: 75px;">
   								<!-- script -->
   							</select>
   							<label style="margin-right: 20px;">년</label>
   							<select id="endMonth1" onchange="setDate('end');" style="width: 55px;">
   								<c:forEach var="month" begin="1" end="12">
   									<c:if test="${month < 10}">
		   								<option value="0${month}">0${month}</option>
	   								</c:if>
	   								<c:if test="${month > 9}">
		   								<option value="${month}">${month}</option>
	   								</c:if>
	   							</c:forEach>
   							</select>
   							<label style="margin-right: 20px;">월</label>
   							<select id="endDate1" style="width: 55px;">
   								<!-- script -->
   							</select>
   							<label>일</label>
						</td>
					</tr>
				</tbody> <!-- tbody end -->
			</table> <!-- table end -->
		</div>
		
		<div id="resveRcrdDialog" style="display: none;">
			<!-- 검색 -->
			<div>
				<table class="d-table" style="margin-top: 5px; width: 600px;">
					<tbody>
						<!-- 날짜 -->
						<tr>
							<td class="head">
								<select id="startYear2" onchange="setDate('start');" style="width: 75px;">
	   								<!-- script -->
	   							</select>
	   							<label>년</label>
	   							<select id="startMonth2" onchange="setDate('start');" style="width: 55px;">
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
	   							<select id="startDate2" style="width: 55px;">
	   								<!-- script -->
	   							</select>
	   							<label>일</label>
	   							<label style="margin-left: 10px; margin-right: 10px;">~</label>
	   							<select id="endYear2" onchange="setDate('end');" style="width: 75px;">
	   								<!-- script -->
	   							</select>
	   							<label>년</label>
	   							<select id="endMonth2" onchange="setDate('end');" style="width: 55px;">
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
	   							<select id="endDate2" style="width: 55px;">
	   								<!-- script -->
	   							</select>
	   							<label>일</label>
							</td>
						</tr>
					</tbody> <!-- tbody end -->
				</table> <!-- table end -->
				<div style="width: 75px; height: 30px; margin: 0 auto; margin-top: 10px;">
					<input id="srcId" type="hidden">
					<button type="button" onclick="findRcrdList();">조회</button>
				</div>
			</div>
			<!-- 그리드 -->
			<div id="rcrdGrid" style="width: 800px; margin: 0 auto; margin-top: 8px;">
				<table id="rcrdGridBody"></table>
				<div id="rcrdGridFooter"></div>
			</div>
		</div>
		<!-- 삭제 -->
		<div>
			<!-- 삭제할 역 코드들 -->
   			<input type="hidden" name="deleteCodeArray">			
		</div>
	</body>
</html>