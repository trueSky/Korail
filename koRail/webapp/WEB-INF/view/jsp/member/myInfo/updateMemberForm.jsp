<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE>
<html>
	<head>
		<style type="text/css">
			.d-table td{
				padding: 3px;
			}
		</style>
	
		<script type="text/javascript">
			$(document).ready(function(){
				/*Action style*/
				$(".menu td").eq(2).addClass("set");
				$(".lmb tr").eq(0).children("td").addClass("set");
				/*lmb img*/
				$("#lmbImg").attr("src", "/res/img/tra_visual10.jpg");
				
				/* 주소검색 */
				$("#findAddrBtn").click(findAddrList);
				
				/*엔터*/
				$("#umd").keydown(function(e){
					if(e.keyCode == 13){
						$("#findAddrBtn").click();
					}
				});
				
				/* 미입력 처리 및 유효성검사 */
				/*성명*/
				$("#nm").focusout(function(){
					if($(this).val() == ""){
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").addClass("false-text");
						$(this).parent().children(".msg").text("성명을 입력하십시오.");
					}else{
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").html("");
					}
				});
				
				/* 전화번호 */
				$("#telNo input").eq(0).focusout(function(){
					if($(this).val() == ""){
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").addClass("false-text");
						$(this).parent().children(".msg").text("전화번호를 입력하십시오.");
					}else{
						var tel = $("#telNo input").eq(0).val()+"-"+$("#telNo input").eq(1).val()+"-"+$("#telNo input").eq(2).val();
						
						$("#telNo input").eq(3).val(tel);
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").html("");
					}
				});
				$("#telNo input").eq(1).focusout(function(){
					if($(this).val() == ""){
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").addClass("false-text");
						$(this).parent().children(".msg").text("전화번호를 입력하십시오.");
					}else{
						var tel = $("#telNo input").eq(0).val()+"-"+$("#telNo input").eq(1).val()+"-"+$("#telNo input").eq(2).val();
						
						$("#telNo input").eq(3).val(tel);
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").html("");
					}
				});
				$("#telNo input").eq(2).focusout(function(){
					if($(this).val() == ""){
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").addClass("false-text");
						$(this).parent().children(".msg").text("전화번호를 입력하십시오.");
					}else{
						var telText = /\d{2,3}-\d{3,4}-\d{4}/;
						var tel = $("#telNo input").eq(0).val()+"-"+$("#telNo input").eq(1).val()+"-"+$("#telNo input").eq(2).val();
						
						if(telText.test(tel)){
							$("#telNo input").eq(3).val(tel);
							$(this).parent().children(".msg").removeClass("false-text");
							$(this).parent().children(".msg").html("");
						}else{
							$("#telNo input").eq(3).val("");
							$(this).parent().children(".msg").removeClass("false-text");
							$(this).parent().children(".msg").addClass("false-text");
							$(this).parent().children(".msg").text("전화번호형식이 아닙니다. ex) 02-8827-3078");
						}
					}
				});
				
				/*휴대전화번호*/
				$("#mbtlnum input").eq(0).focusout(function(){
					if($(this).val() == ""){
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").addClass("false-text");
						$(this).parent().children(".msg").text("전화번호를 입력하십시오.");
					}else{
						var tel = $("#mbtlnum input").eq(0).val()+"-"+$("#mbtlnum input").eq(1).val()+"-"+$("#mbtlnum input").eq(2).val();
						
						$("#mbtlnum input").eq(3).val(tel);
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").html("");
					}
				});
				$("#mbtlnum input").eq(1).focusout(function(){
					if($(this).val() == ""){
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").addClass("false-text");
						$(this).parent().children(".msg").text("휴대전화번호를 입력하십시오.");
					}else{
						var tel = $("#mbtlnum input").eq(0).val()+"-"+$("#mbtlnum input").eq(1).val()+"-"+$("#mbtlnum input").eq(2).val();
						
						$("#mbtlnum input").eq(3).val(tel);
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").html("");
					}
				});
				$("#mbtlnum input").eq(2).focusout(function(){
					if($(this).val() == ""){
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").addClass("false-text");
						$(this).parent().children(".msg").text("휴대전화번호를 입력하십시오.");
					}else{
						var telText = /\d{2,3}-\d{3,4}-\d{4}/;
						var tel = $("#mbtlnum input").eq(0).val()+"-"+$("#mbtlnum input").eq(1).val()+"-"+$("#mbtlnum input").eq(2).val();
						
						if(telText.test(tel)){
							$("#mbtlnum input").eq(3).val(tel);
							$(this).parent().children(".msg").removeClass("false-text");
							$(this).parent().children(".msg").html("");
						}else{
							$("#mbtlnum input").eq(3).val("");
							$(this).parent().children(".msg").removeClass("false-text");
							$(this).parent().children(".msg").addClass("false-text");
							$(this).parent().children(".msg").text("휴대전화번호형식이 아닙니다. ex) 010-3342-0987");
						}
					}
				});
				
				/*이메일*/
				$("#email input").eq(0).focusout(function(){
					if($(this).val() == ""){
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").addClass("false-text");
						$(this).parent().children(".msg").text("이메일을 입력하십시오.");
					}else{
						if($("#email input").eq(1).val() == ""){
							$(this).parent().children(".msg").removeClass("false-text");
							$(this).parent().children(".msg").addClass("false-text");
							$(this).parent().children(".msg").text("이메일을 입력하십시오.");
						}else{
							var emailText = /^[0-9A-Z]([-_\.]?[0-9A-Z])*@[0-9A-Z]([-_\.]?[0-9A-Z])*\.[A-Z]{2,6}$/i;
							var email = $("#email input").eq(0).val()+"@"+$("#email input").eq(1).val();
							
							if(emailText.test(email)){
								$("#email input").eq(2).val(email);
								$(this).parent().children(".msg").removeClass("false-text");
								$(this).parent().children(".msg").html("");	
							}
						}
					}
				});
				$("#email input").eq(1).focusout(function(){
					if($(this).val() == ""){
						$(this).parent().children(".msg").removeClass("false-text");
						$(this).parent().children(".msg").addClass("false-text");
						$(this).parent().children(".msg").text("이메일을 입력하십시오.");
					}else{
						var emailText = /^[0-9A-Z]([-_\.]?[0-9A-Z])*@[0-9A-Z]([-_\.]?[0-9A-Z])*\.[A-Z]{2,6}$/i;
						var email = $("#email input").eq(0).val()+"@"+$("#email input").eq(1).val();
						
						/* 유효성검사 */
						if(emailText.test(email)){
							$("#email input").eq(2).val(email);
							$(this).parent().children(".msg").removeClass("false-text");
							$(this).parent().children(".msg").html("");
						}else{
							$("#email input").eq(2).val("");
							$(this).parent().children(".msg").removeClass("false-text");
							$(this).parent().children(".msg").addClass("false-text");
							$(this).parent().children(".msg").text("이메일형식이 아닙니다. ex) test@korail.com");
						}
					}
				});
				
				/* 주소 */
				$("#detailAddrs").eq(0).focusout(function(){
					if($(this).val() == ""){
						$(this).next().removeClass("false-text");
						$(this).next().addClass("false-text");
						$(this).next().text("주소를 입력하십시오.");
					}else{
						$(this).next().removeClass("false-text");
						$(this).next().html("");
					}
				});
				
				/* replace */
				var telNo = "${member.telNo}".split("-");
				$("#telNo input").eq(0).val(telNo[0]);
				$("#telNo input").eq(1).val(telNo[1]);
				$("#telNo input").eq(2).val(telNo[2]);
				$("#telNo input").eq(3).val("${member.telNo}");
				
				var mbtlnum = "${member.mbtlnum}".split("-");
				$("#mbtlnum input").eq(0).val(mbtlnum[0]);
				$("#mbtlnum input").eq(1).val(mbtlnum[1]);
				$("#mbtlnum input").eq(2).val(mbtlnum[2]);
				$("#mbtlnum input").eq(3).val("${member.mbtlnum}");
	
				var email = "${member.emal}".split("@");
				$("#email input").eq(0).val(email[0]);
				$("#email input").eq(1).val(email[1]);
				$("#email input").eq(2).val("${member.emal}");
				
				var zipCode = "${member.zipCode}".split(",");
				$("#zipCode1").val(zipCode[0]);
				$("#zipCode2").val(zipCode[1]);
				$("input[name=zipCode]").val($.trim("${member.zipCode}".replace(/,/gi, "")));
			});
			
			/*주소검색 다이알로그*/
			function setAddrDialog(){
				/* 초기화 */
	   			$("#selectData1").val("");
	   			$("#selectData2").val("");
	   			$("#selectData3").val("");
	   			$("#umd").val("");
				$("#grid").html("<table id='gridBody'></table><div id='footer'><div>");
	   			
   				$("#gridBody").jqGrid({
   					datatype: "LOCAL",
	   				caption:"주소정보",
	   				width: 380,
	   				height: 160,
	   				scroll: 1,
	   				rowNum : 'max',
	   				pager: '#footer',
	   				colNames:["우편번호", "주소"],
	          		colModel : [
						{ name : "zipCode", align:"center", width: 30, height : 200, sortable:false,
							cellattr: function(rowId, value, rowObject, colModel, arrData) {
								return ' colspan=2';
							}
						},
						{ name : "addr", width: 70, align:"center", sortable:false}
					]
				}); /*jqGrid end*/
				
   				/*초기화면 메세지를 출력하기 위해 그리드 행 추가 및 메세지 설정*/
				$("#gridBody").jqGrid('addRowData', 0, {zipCode:"우편번호를 검색할 수 있습니다."});
				
				/*다이알로그*/
   				$("#addrDialog").dialog({
   					modal: true,
   					width: 450,
					buttons: {
						"확인" : function(){
							/* 미선택 */
							for(var i = 1; i < 4; i++){
								if($("#selectData"+i).val() == ""){
									alert("우편번호를 선택해야 합니다.");
									return;
								}
							}
							
							/* set Data */
							$("#zipCode1").val($("#selectData1").val());
							$("#zipCode2").val($("#selectData2").val());
							$("input[name=zipCode]").val($("#selectData1").val()+$("#selectData2").val());
							$("input[name=addrs]").val($("#selectData3").val());
							$(this).dialog("close");
						},
						"취소" : function(){
							$(this).dialog("close");
						}
					}
   				});
			}
			
			/*주소검색*/
			function findAddrList(){
				var umd = $("#umd").val().replace(/\s/gi, "");
				
				if(umd == ""){
					alert("검색할 읍 / 면 / 동을 입력하셔야 합니다.");
					return;
				}else{
					/*그리드 내용*/				
					$.ajax({
						type:"POST",
						url: "/addrList.do?",
						Type:"JSON",
						data:{umd:umd},
						success : function(data) {
							if(data.addrListSize == 0){
								alert("존재하지 않는 주소 입니다.");
							}else{
								/* 초기화 */
					   			$("#grid").html("<table id='gridBody'></table><div id='footer'><div>");
					   			
				   				$("#gridBody").jqGrid({
				   					datatype: "LOCAL",
					   				caption:"주소정보",
					   				width: 380,
					   				height: 160,
					   				scroll: 1,
					   				rowNum : 'max',
					   				pager: '#footer',
					   				colNames:["선택", "우편번호", "주소"],
					          		colModel : [
										{ name : "select", width: 10, align:"center", sortable:false},
										{ name : "zipCode", width: 30, align:"center", sortable:false},
										{ name : "addr", width: 70, align:"center", sortable:false}
									],
									/*row click*/
									onCellSelect :function(rowId,indexColumn,cellContent,eventObject){
										/* 선택된 우편번호 */
										var radio = $("input[value="+rowId+"]");
										
										if(rowId == radio.val()){
											var zipCode = $(this).getRowData(rowId).zipCode.replace(" ", "").split("-");
											
											/* 선택된 row의 radio 자동선택 */
											radio.prop("checked", true);
											
											/* set data */
											$("#selectData1").val(zipCode[0]);
											$("#selectData2").val(zipCode[1]);
											$("#selectData3").val($(this).getRowData(rowId).addr);
										}else{
											return;
										}
									}
								}); /*jqGrid end*/
							
								/* 데이터 추가 */
								$.each(data.addrList, function(k, v){
									$("#gridBody").jqGrid('addRowData', k,
										{
											select:'<input type="radio" name="r" value="'+k+'">',
											zipCode:v.zipCode.replace(",", "-"),
											addr:v.addr
										}
									);
								});
							} /* else end */
						} /* success end */
					}); /* ajax end */
				} /* else end */
			} /* findAddrList end */
			
			/* 정보수정 */
			function updateMemeber(){
				/*유효성검사*/
				if($("#telNo input").eq(3).val().length < 12){
					$("#telNo input").eq(3).val("");
					$("#telNo").children(".msg").removeClass("false-text");
					$("#telNo").children(".msg").addClass("false-text");
					$("#telNo").children(".msg").text("전화번호형식이 아닙니다. ex) 02-8827-3078");
					$("#telNo input").eq(0).focus();
					return;
				}else if($("#mbtlnum input").eq(3).val().length < 12){
					$("#mbtlnum input").eq(3).val("");
					$("#mbtlnum").children(".msg").removeClass("false-text");
					$("#mbtlnum").children(".msg").addClass("false-text");
					$("#mbtlnum").children(".msg").text("휴대전화번호형식이 아닙니다. ex) 010-3342-0987");
					$("#mbtlnum input").eq(0).focus();
					return;
				}
				
				for(var i = 0; i < $("#memberForm :text").size(); i++){
					if($("#memberForm :text").eq(i).val() == ""){
						$("#memberForm :text").eq(i).focus();
						return;
					}
				}
				
				if($(".false-text").size() == 0){
					if(confirm("회원님의 정보를 수정하시겠습니까?")){
						$("#memberForm").submit();						
					}
				}else{
					return;
				}
			}
			
			/* 취소 */
			function doCancel(){
				if(confirm("작업을 취소하시겠습니까?")){
					location.href = "/member/myInfo.html";
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
			<div>* 가입당시 입력했던 정보들을 수정할 수 있습니다.</div>
			<div>* 아이디는 수정할 수 없습니다.</div>
			<div>* 전화번호 및 휴대전화번호는 숫자만 입력이 가능하며 형식에 따라 입력해야 합니다.</div>
			<div style="padding-left: 15px;">ex) 010 1234 5678, ex) 02 1234 5678</div>
			<div>* 이메일은 대,소문자영문 및 숫자면 입력이 가능합니다, 또한 이메일 주소는 형식에 따라 입력해야 합니다.</div>
			<div style="padding-left: 15px">ex) koRail123 korail.com</div>
			<div>* 우편번호 검색을 이용하여 우편번호와 주소를 검색하실 수 있습니다, 하지만 상세주소는 직접 입력하셔야</div><div style="padding-left: 15px;">합니다.</div>
			<div>* 취소버튼을 이용하여 개인정보 관리화면으로 되돌아 가실 수 있습니다.</div>
		</div>
	
		<form id="memberForm" action="/member/memberProcess.do" method="POST">
			<!-- 상태를 등록으로 설정 -->
			<input name="state" type="hidden" value="update">
			
			<table class="d-table" style="text-align: left;">
				<colgroup>
					<col width="20%">
					<col width="*%">
				</colgroup>
				<tbody>
					<tr>
						<td>아이디</td>
						<td>
							<input style="width: 120px;" value="${member.id}" disabled="disabled">
						</td>
					</tr>
					<tr>
						<td>성명</td>
						<td>
							<input id="nm" name="nm" type="text" value="${member.nm}" onkeydown="setLimitLength(this, event, 19);" style="width: 120px;">
							<label class="msg"></label>
						</td>
					</tr>
					<tr>
						<td>성별</td>
						<td>
							<select name="gndr" style="width: 53px;">
								<c:if test="${member.gndr == '남'}">
									<option value="0" selected="selected">남</option>
									<option value="1">여</option>
								</c:if>
								<c:if test="${member.gndr == '여'}">
									<option value="0">남</option>
									<option value="1" selected="selected">여</option>
								</c:if>
							</select>
						</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td id="telNo">
							<input type="text" onkeydown="doNumberCheck(this, event, 3);" style="width: 50px;">
							<label>-</label>
							<input type="text" onkeydown="doNumberCheck(this, event, 4);" style="width: 80px;">
							<label>-</label>
							<input type="text" onkeydown="doNumberCheck(this, event, 4);" style="width: 80px;">
							<input name="telNo" type="hidden">
							<label class="msg"></label>
						</td>
					</tr>
					<tr>
						<td>휴대전화번호</td>
						<td id="mbtlnum">
							<input type="text" onkeydown="doNumberCheck(this, event, 3);" style="width: 50px;">
							<label>-</label>
							<input type="text" onkeydown="doNumberCheck(this, event, 4);" style="width: 80px;">
							<label>-</label>
							<input type="text" onkeydown="doNumberCheck(this, event, 4);" style="width: 80px;">
							<input name="mbtlnum" type="hidden">
							<label class="msg"></label>
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td id="email">
							<input type="text" onkeydown="doStringCheck(this, event, 25);" style="width: 110px;">
							<label>@</label>
							<input type="text" onkeydown="doStringCheck(this, event, 25, true);" style="width: 118px;">
							<input name="emal" type="hidden">
							<label class="msg"></label>
						</td>
					</tr>
					<tr>
						<td rowspan="3">주소</td>
						<td>	
							<input id="zipCode1" disabled="disabled" style="width: 61px" type="text">
							<label>-</label>
							<input id="zipCode2" disabled="disabled" style="width: 61px" type="text">
							<input name="zipCode" type="hidden">
							<input name="addrs" type="hidden" value="${member.addrs}">
							<button onclick="setAddrDialog();" type="button">우편번호 검색</button>
						</td>
					</tr>
					<tr>
						<td>
							<input name="addrs" type="text" disabled="disabled" value="${member.addrs}" style="width: 259px;">
						</td>
					</tr>
					<tr>
						<td>
							<input id="detailAddrs" name="detailAddrs" type="text" value="${member.detailAddrs}" style="width: 259px;">
							<label class="msg"></label>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		
		<div id="addrDialog" title="우편번호 검색" style="display: none; text-align: center;">
   			<!-- Info and search -->
   			<div>
	   			<strong style="color: #B2CCFF">읍 / 면 / 동으로 검색 하십시오.</strong>
   			</div>
   			<div style="margin-top: 5px; margin-bottom: 5px;">
	   			<input id="umd" type="text" style="width: 125px; height: 22px; vertical-align: middle;">
	   			<button id="findAddrBtn" type="button">검색</button>
   			</div>
   			
   			<!-- Grid -->
   			<div id="grid" style="width: 380px; margin: 0 auto;"></div>
		
			<!-- Radio selct data -->
			<input id="selectData1" type="hidden">
			<input id="selectData2" type="hidden">
			<input id="selectData3" type="hidden">
		</div>
		
		<!-- 수정 / 취소 버튼 -->
		<div class="button-group" style="text-align: center;">	
			<button onclick="updateMemeber();" type="button">수정</button>
			<button onclick="doCancel();" type="button">취소</button>
		</div>
	</body>
</html>