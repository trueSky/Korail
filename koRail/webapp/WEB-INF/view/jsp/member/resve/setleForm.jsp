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
   			var viewState = false;	/* 그리드 생성싱테 : true 생성됨, false 생성되 않음 */
   			var date = new Date();	/* 현재날짜*/
   			
   			$(document).ready(function(){
	   			/*Action style*/
				$($(".menu td").get(1)).addClass("set");
				$($(".lmb tr").get(0)).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual01.jpg");
	   		
	   			/*
	   				* 파라미터 변환
	   				* 기존 파라미터 3자리마다 구분자 ,사용 ex) 50,000
	   				* 변환 파라미터 구분자 없음 ex) 50000
	   			*/
	   			/*운임요금*/
	   			$("input[name=frAmount]").val("${allFrAmount}".replace(/,/gi, ""));
	   			$("input[name=dscntAmount]").val("${allDscntAmount}".replace(/,/gi, ""));
	   			$("input[name=rcptAmount]").val("${allRcptAmount}".replace(/,/gi, ""));
	   			$("input[name=setleAmount]").val("${allRcptAmount}".replace(/,/gi, ""));
	   		
	   			/* 년도생성 */
	   			for(var year = date.getFullYear(); year < (date.getFullYear()+20); year++){
		   			$("#yyyy").append("<option value='"+year+"'>"+year+"</option>");
	   			}
	   			
	   			/*사용포인트 입력 전 값이 0 또는 ""인 경우 초기화*/
	   			$("input[name=usePint]").focusin(function(){
	   				if($(this).val() == "" || $(this).val() == 0){
	   					$(this).val("");
	   				}
	   			});
	   			/*사용포인트의 입력이 완료 후*/
	   			$("input[name=usePint]").focusout(function(){
	   				/*미입력*/
	   				if($(this).val() == "" || $(this).val() == 0){
	   					$(this).val(0);
	   					$("input[name=extraDiscount]").val(0);
	   					$("#extraDiscount").html("0 원");
	   					
	   					$("input[name=setleAmount]").val($("input[name=rcptAmount]").val());
	   					toCommaNumber(document.getElementsByName("setleAmount")[0]);
	   					$("#setleAmount").html($("input[name=setleAmount]").val()+" 원");
	   				}
	   				/*입력가능한 포인트는 현재사용가능한 포인트 까지 제한 및 자동입력*/
	   				else if(parseInt($("#tdyPint").val().replace(/,/gi, "")) < parseInt($(this).val().replace(/,/g, ""))){
	   					alert("현재 사용가능한 포인트는 "+$("#tdyPint").val()+"P까지 입니다.");
	   					
	   					$(this).val($("#tdyPint").val());
	   					$("input[name=extraDiscount]").val($(this).val());
	   					$("#extraDiscount").html($(this).val()+" 원");
	   					
	   					$("input[name=setleAmount]").val(parseInt($("input[name=rcptAmount]").val())-parseInt($(this).val().replace(/,/g, "")));
	   					toCommaNumber(document.getElementsByName("setleAmount")[0]);
	   					$("#setleAmount").html($("input[name=setleAmount]").val()+" 원");
	   				
	   					/*결제금액이 사용포인트에 의해 0보다 적아진다면 사용포인트 재설정 */
		   				if(parseInt($("input[name=setleAmount]").val().replace(/,/g, "")) < 0){
		   					$(this).val(parseInt($(this).val().replace(/,/g, ""))+parseInt($("input[name=setleAmount]").val().replace(/,/g, "")));
		   					$(this).focusin();
		   					$(this).focusout();
		   				}
	   				}
	   				/*최대 사용포인트 제한 및 최대치 자동입력*/
	   				else if(parseInt($(this).val().replace(/,/gi, "")) > 50000){
	   					alert("최대 사용포인트는 50,000P까지 입니다.");
	   					
	   					$(this).val(50000); //5만 포인트로 설정
	   					$("input[name=extraDiscount]").val($(this).val()); //추가 할인금액 설정
	   					
	   					/*결제금액에 추가 할인금액 적용*/
	   					$("input[name=setleAmount]").val(parseInt($("input[name=rcptAmount]").val())-parseInt($(this).val()));
	   					
	   					/*결제금액이 사용포인트에 의해 0보다 적어진다면 사용포인트 재설정 */
		   				if(parseInt($("input[name=setleAmount]").val()) < 0){
		   					$(this).val(parseInt($(this).val())+parseInt($("input[name=setleAmount]").val()));
		   					$(this).focusin();
		   					$(this).focusout();
		   				}
	   					
	   					/*html 설정*/
	   					toCommaNumber(document.getElementsByName("usePint")[0]);
	   					$("#extraDiscount").html($(this).val()+" 원");
	   					toCommaNumber(document.getElementsByName("setleAmount")[0]);
	   					$("#setleAmount").html($("input[name=setleAmount]").val()+" 원");
	   				}
	   				/*일반입력*/
	   				else{
	   					/*결제금액에 추가 할인금액 적용*/
	   					$("input[name=setleAmount]").val(parseInt($("input[name=rcptAmount]").val())-parseInt($(this).val().replace(/,/g, "")));
	   				
	   					/*결제금액이 사용포인트에 의해 0보다 적아진다면 사용포인트 재설정 */
		   				if(parseInt($("input[name=setleAmount]").val()) < 0){
		   					$(this).val(parseInt($(this).val().replace(/,/g, ""))+parseInt($("input[name=setleAmount]").val()));
		   					$(this).focusin();
		   					$(this).focusout();
		   				}
	   					
	   					/*html 설정*/
		   				toCommaNumber(document.getElementsByName("usePint")[0]);
	   					$("#extraDiscount").html($(this).val()+" 원");
	   					$("input[name=extraDiscount]").val($("input[name=usePint]").val());
	   					toCommaNumber(document.getElementsByName("setleAmount")[0]);
	   					$("#setleAmount").html($("input[name=setleAmount]").val()+" 원");
	   				}
	   				
	   				/*replace*/
	   				$("input[name=extraDiscount]").val($("input[name=extraDiscount]").val().replace(/,/g, ""));
	   				$("input[name=setleAmount]").val($("input[name=setleAmount]").val().replace(/,/g, ""));
	   			});
   			});
	   		
   			/*카드입력에 대한 에러메세지*/
	   		function doInitCardMsg(){
	   			$("#cardNo4").next().html("");
	   		}
   			
	   		/* 포인트 사용여부에 따른 현제 포인트 조회 */
	   		function findTdyPint(obj){
	   			/*초기화*/
	   			$("#tdyPint").val("");
	   			
	   			if($(obj).val() == "Y"){
	   				$.ajax({
						type:"POST",
						url: "/member/tdyPint.do?id=${id}",
						Type:"JSON",
						success : function(data) {
							if(data.tdyPint == "0"){
								alert("사용가능한 포인트가 없습니다.");
								$($("input[name=pintUseYN]").get(0)).prop("checked", true);
							}else if(parseInt(data.tdyPint.replace(/,/gi, "")) < 5000){
								alert("포인트는 최소 5,000P 이상 정립되어있어야 합니다.");
								$($("input[name=pintUseYN]").get(0)).prop("checked", true);
							}else{
								/*현재포인트 설정*/
								$("#tdyPint").val(data.tdyPint);
								/*사용포인트 초기화*/
			   					$("input[name=usePint]").val(0);
								$("#pintTr").show();
							}
						},
						error : function(request, status, error){
							if(request.status == 401){
								alert("세션이 만료되었습니다.");
								location.href = "/login.html";
							}else{
								alert("서버에러입니다.");
							}
						}
		   			}); /* $.ajax end */
	   			}else{
	   				/* 추가할인금액 초기화 */
	   				$("input[name=extraDiscount]").val(0);
   					$("#extraDiscount").html("0 원");
   					/*결제금액 초기화*/
   					$("input[name=setleAmount]").val($("input[name=rcptAmount]").val());
   					$("#setleAmount").html($("input[name=setleAmount]").val()+" 원");
	   				/*사용포인트 초기화*/
   					$("input[name=usePint]").val(0);
	   				
   					$("#pintTr").hide();
	   			}
	   		}
	   		
	   		/*결제*/
	   		function doSetle(){
	   			/* 카드번호 */
	   			var cardNo = $("#cardNo1").val()+$("#cardNo2").val()+ $("#cardNo3").val();
   				$("#cardNo4").val(cardNo.replace(" ", ""));
	   			
   				/* 주민등록번호 */
   				var ihidnum = $("#ihidnum1").val()+$("#ihidnum2").val();
   				$("#ihidnum3").val(ihidnum.replace(" ", ""));
   				
   				/* 유혀기간 설정 형식 YYYY-MM */
				$("#valIdPd").val($("#yyyy").val()+"-"+$("#mm").val());
   				
				/* usePint replace */
				$("input[name=usePint]").val($("input[name=usePint]").val().replace(/,/g, ""));
   				
	   			/* 유효성 검사 */
	   			if($("#cardKndSelect").val() == "non"){
	   				alert("카드종류를 선택해야 합니다.");
	   				$("#cardKndSelect").focus();
	   				return;
	   			}else if($("#cardNo4").val().length < 12){
	   				$("#cardNo1").focus();
	   				$("#cardNo4").next().removeClass("false-text");
	   				$("#cardNo4").next().addClass("false-text");
	   				$("#cardNo4").next().html("올바른 입력이 아닙니다. ex) 1234-5678-9012");
	   				return;
	   			}else if($("#yyyy").val() == "non"){
	   				alert("유효기간을 선택해야 합니다.");
	   				$("#yyyy").focus();
	   			}else if($("#scrtyCadrNo").val() == ""){
	   				$("#scrtyCadrNo").focus();
	   				alert("보안카드번호를 입력해야 합니다.");
	   			}else if($("#ihidnum3").val().length < 13){
	   				alert("주민등록번호를 입력해야 합니다.");
	   				$("#ihidnum1").focus();
	   			}else if($("input[name=usePint]").val() == 0 && $("input[name=pintUseYN]").parent().children(":checked").val() == "Y"){
	   				$("input[name=usePint]").focus();
	   				alert("사용포인트는 1P 이상 사용하셔야합니다.");
	   			}else{
	   				var text = "추가할인금액은 "+$("#extraDiscount").html()
	   							+"이며 결제금액은 "+$("#setleAmount").html()+"입니다.\n"
								+" 결제를 진행 하시겠습니까?";
	   				
	   				if(confirm(text)){
		   				$("#setleForm").submit();
	   				}else{
	   					return;
	   				}
	   			}
	   		} /* doSetle end */
	   		
	   		/*승차권 현황 화면으로 이동*/
	   		function goTcktRcrdForm(){
	   			if(confirm("진행중인 작업을 취소하시겠습니까?")){
	   				location.href = "/member/tcktRcrdForm";
	   			}else{
	   				return;
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
   				<img src="/res/img/step_tck01.gif">
   				<img src="/res/img/step_tck02.gif">
   				<img src="/res/img/step_tck03_on.gif">
   				<img src="/res/img/step_tck04.gif">
   			</div>
   		</div>
   		
		<!-- 사용방법 -->
   		<div style="clear: left; clear:  right;">
			<div class="caption" style="margin-top: 40px; margin-bottom: 0px;">
				* 결제를 위한 입력사항입니다.<br>
				* 운임금액: 할인이 적용되지 않은 금액입니다.<br>
				* 할인금액: 할인받을 수 있는 금액입니다.<br>
				* 영수금액: 운임금액에 할인금액이 적용된 금액입니다.<br>
				* 추가 할인금액: 포인트를 사용하여 할인받을 수 있는 금액입니다.<br>
				* 결제금액: 영수금액에 추가 할인금액이 적용된 금액이며 최종적으로 부과되는 금액입니다.
			</div>
   		</div>
   		
   		<!-- 입력항목 및 파라미터 -->
   		<form id="setleForm" action="/member/setleProcess.do">
   			<input name="state" value="insert" type="hidden">
   			<input name="resveCode" value="${resveCode}" type="hidden">
   			<input name="id" value="${id}" type="hidden">
   			<input name="register" value="${id}" type="hidden">
   			<div>
   				<table class="d-table" style="text-align: left;">
   					<colgroup>
   						<col width="30%">
   						<col width="70%">
   					</colgroup>
   					<tbody>
   						<tr>
   							<td class="head">카드구분</td>
   							<td>
   								<input name="cardSe" value="CARD_SE_1" type="radio" checked="checked">
   								<label style="margin-right: 10px;">개인카드</label>
   								<input name="cardSe" value="CARD_SE_2" type="radio">
   								<label>법인카드</label>
   							</td>
   						</tr>
   						<tr>
   							<td class="head">카드종류</td>
   							<td>
   								<select id="cardKndSelect" name="cardKnd">
   									<option value="non">선택</option>
   									<c:forEach var="data" items="${commonCodeList}">
   										<option value="${data.cmmnCode}">${data.cmmnCodeValue}</option>
   									</c:forEach>
   								</select>
   							</td>
   						</tr>
   						<tr>
   							<td class="head">카드번호</td>
   							<td>
   								<input id="cardNo1" type="text" onkeydown="doNumberCheck(this, event, 4, doInitCardMsg());" style="width: 50px;">
   								<label>-</label>
   								<input id="cardNo2" type="password" onkeydown="doNumberCheck(this, event, 4, doInitCardMsg());" style="width: 50px;">
   								<label>-</label>
   								<input id="cardNo3" type="password" onkeydown="doNumberCheck(this, event, 4, doInitCardMsg());" style="width: 50px;">
   								<input id="cardNo4" name="cardNo" type="hidden">
   								<label></label>
   							</td>
   						</tr>
   						<tr>
   							<td class="head">카드 유효기간</td>
   							<td>
   								<select id="yyyy">
   									<option value="non">선택</option>
   								</select>
   								<label>년</label>
								<select id="mm" style="width: 47px;">
   									<c:forEach var="i" begin="1" end="12">
   										<c:if test="${i < 10}">
	   										<option value="0${i}">0${i}</option>
   										</c:if>
   										<c:if test="${i >= 10}">
   											<option value="${i}">${i}</option>
   										</c:if>
   									</c:forEach>
   								</select>
   								<label>월</label>
   								<input id="valIdPd" name="valIdPd" type="hidden">
   							</td>
   						</tr>
   						<tr>
   							<td class="head">할부</td>
   							<td>
   								<select name="instlmt">
   									<option value="INSTLMT_1">일시불</option>
   								</select>
   							</td>
   						</tr>
   						<tr>
   							<td class="head">보안카드번호</td>
   							<td>
   								<input name="scrtyCadrNo" type="password" onkeydown="doStringCheck(this, event, 2);" style="width: 50px;">
   								<label>**(앞2자리)</label>
   							</td>
   						</tr>
   						<tr>
   							<td class="head">주민등록번호</td>
   							<td>
   								<input id="ihidnum1" type="text" style="width: 70px;" onkeydown="doNumberCheck(this, event, 6)">
   								<label>-</label>
   								<input id="ihidnum2" type="password" style="width: 70px;" onkeydown="doNumberCheck(this, event, 7)">
   								<input id="ihidnum3" name="ihidnum" type="hidden">
   							</td>
   						</tr>
   						<tr>
   							<td class="head">포인트</td>
   							<td>
   								<input name="pintUseYN" value="N" onclick="findTdyPint(this);" type="radio" checked="checked">
   								<label style="margin-right: 10px;">사용안함</label>
   								<input name="pintUseYN" value="Y" onclick="findTdyPint(this);" type="radio">
   								<label>사용함</label>
   								<div id="pintTr" style="display: none; margin-top: 5px;">
   									<input id="tdyPint" type="text" dir="rtl" style="width: 60px;" disabled="disabled">
	   								<label>현재 사용가능한 포인트 입니다.</label>
	   								<br>
	   								<input name="usePint" type="text" dir="rtl" value="0" onkeydown="doNumberCheck(this, event, 5);" onkeyup="toCommaNumber(this);" style="margin-top: 5px; width: 60px;">
	   								<label>포인트를 사용합니다.</label>
   								</div>
   							</td>
   						</tr>
   						<tr>
   							<td class="head">운임금액</td>
   							<td>
   								<input name="frAmount" type="hidden">
   								<span>${allFrAmount} 원</span>
   							</td>
   						</tr>
   						<tr>
   							<td class="head">할인금액</td>
   							<td>
   								<input name="dscntAmount" type="hidden">
   								<span>${allDscntAmount} 원</span>
   							</td>
   						</tr>
   						<tr>
   							<td class="head">영수금액</td>
   							<td>
   								<input name="rcptAmount" type="hidden">
   								<span>${allRcptAmount} 원</span>
   							</td>
   						</tr>
   						<tr>
   							<td class="head">추가 할인금액</td>
   							<td>
   								<input name="extraDiscount" type="hidden">
   								<span id="extraDiscount">0 원</span>
   							</td>
   						</tr>
   						<tr>
   							<td class="head">결제금액</td>
   							<td>
   								<input name="setleAmount" type="hidden">
   								<span id="setleAmount">${allRcptAmount} 원</span>
   							</td>
   						</tr>
   					</tbody>
   				</table>
   			</div>
   		</form>
   		
		<div style="text-align: center; margin-top: 15px;">
			<button type="button" onclick="doSetle();">결제</button>
			<button type="button" onclick="goTcktRcrdForm();">취소</button>
		</div>
	</body>
</html>