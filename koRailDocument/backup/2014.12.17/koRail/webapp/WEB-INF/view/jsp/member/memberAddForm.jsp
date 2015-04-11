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
				var idCheckNum = 0; /* ID중복확인 사용여부 : 사용함 : 1, 사용하지 않음 : 0 */
				
				/* 주소검색 */
				$("#findAddrBtn").click(findAddrList);
				
				/*엔터*/
				$("#umd").keydown(function(e){
					if(e.keyCode == 13){
						$("#findAddrBtn").click();
					}
				});
			});
			
			/* ID 중복확인 */
			function doIdCheck(){
				var id = $("#id").val().replace(" ");
				
				if(id == ""){
					alert("아이디를 입력하셔야 합니다.");
				}else{
					$.ajax({
						type:"POST",
						url: "/member/idCheck.do?id="+id,
						Type:"JSON",
						success : function(data) {
							if(data.rtCode == 0){
								$("#idCheckMsg").removeClass("false-text");
								$("#idCheckMsg").addClass("true-text");
								$("#idCheckMsg").html(data.rtMsg);
							}else{
								$("#idCheckMsg").removeClass("true-text");
								$("#idCheckMsg").addClass("false-text");
								$("#idCheckMsg").html('<input class="idFalse" type="hidden"><span>'+data.rtMsg+'</span>');
							}
						}
					});	/* $.ajax */
				} /* else end */
				
				/*중복확인 사용 여부*/
				idCheckNum = 1;
			}
			
			/* ID 중복확인 해제 */
			function doIdCheckInit(e){
				/*중복확인 사용 여부*/
				idCheckNum = 0;
				$("#idCheckMsg").html("");

			}
			
			/* 비밀번호 확인 */
			function doPasswordCheck(obj){
				/* 이벤트가 발생한 tag가 속한 td < .msg */
				var chTag = $(obj).parent().children(".msg");
				
				 chTag.html("");
				
				if($("#password").val() != ""){
					if($("#password").val() == $(obj).val()){
						chTag.removeClass("false-text");
						chTag.addClass("true-text");
						chTag.html("비밀번호가 일치합니다.");
					}else{
						if($(obj).val().length > 0){
							chTag.removeClass("true-text");
							chTag.addClass("false-text");
							chTag.html("<input class='false' type='hidden'>비밀번호가 일치하지 않습니다.");
						}else{
							chTag.html("");
						}
					}	
				}
			}
			
			/* 전화번호 형식 확인 */
			function doNumberCheck(obj){
				/*전화번효, 휴대전화번호 형식*/
				var telText = /\d{2,3}-\d{3,4}-\d{4}/;
				/* 숫자형식 */
				var numberText = /\d+/;
				/* 이벤트가 발생한 객채 */
				var text = $(obj);
				/* 이벤트가 발생한 tag가 속한 td < .msg */
				var chTag = $(obj).parent().children(".msg");
				
				if(text.val() == ""){
					chTag.html("");
				}else{
					if(numberText.test(text.val())){
						/* 전화번호의 값 */
						var tel1 = $(text.parent().children("input").get(0)).val();
						var tel2 = $(text.parent().children("input").get(1)).val();
						var tel3 = $(text.parent().children("input").get(2)).val();
						
						if(tel1 && tel2 && tel3 != ""){
							if(telText.test(tel1+"-"+tel2+"-"+tel3)){
								chTag.removeClass("false-text");
								chTag.addClass("true-text");
								chTag.html("옭바른 전화번호 형식 입니다.");
								/* 전송할 데이터 */
								$(obj).parent().children(":hidden").val(tel1+"-"+tel2+"-"+tel3);
							}else{
								chTag.removeClass("true-text");
								chTag.addClass("false-text");
								chTag.html("<input class='false' type='hidden'>형식 ex):010-2228-3324 또는 ex):02-247-8873");
							}
						}
					}else{
						chTag.removeClass("true-text");
						chTag.addClass("false-text");
						chTag.html("<input class='false' type='hidden'>숫자만 입력가능 합니다.");
					}
				}
			}
			
			/* 이메일 형식 확인 */
			function doEmailCheck(obj){
				/* 이메일 형식 */
				var emailText = /^[0-9A-Z]([-_\.]?[0-9A-Z])*@[0-9A-Z]([-_\.]?[0-9A-Z])*\.[A-Z]{2,6}$/i;
				/* 이벤트가 발생한 tag가 속한 td < .msg */
				var chTag = $(obj).parent().children(".msg");
				
				var email1 = $("#email1").val();
				var email2 = $("#email2").val();
				var hEmail = $("input[name=emal]");
				
				if(email1 == "" || email2 == ""){
					chTag.html("");
				}else{
					if((email1.length+email2.length) == 0){
						chTag.html("");
					}else{
						if(email1 && email2 == ""){
							chTag.html("");
						}else{
							/*서버로 전달할 값 설정*/
							hEmail.val(email1+"@"+email2);
							
							if(emailText.test(hEmail.val())){
								chTag.removeClass("false-text");
								chTag.addClass("true-text");
								chTag.html("옭바른 이메일 형식 입니다.");
							}else{
								chTag.removeClass("true-text");
								chTag.addClass("false-text");
								chTag.html("<input class='false' type='hidden'>옭바른 이메일 형식이 아닙니다.");
							}
						} /* else end */
					} /* else end */	
				} /* else end */
			} /* doEmailCheck end */
			
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
							$("#zipCOde1").val($("#selectData1").val());
							$("#zipCOde2").val($("#selectData2").val());
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
				var umd = $("#umd").val().replace(" ");
				
				if(umd == ""){
					alert("검색할 읍 / 면 / 동을 입력하셔야 합니다.");
					return;
				}else{
					/*그리드 내용*/				
					$.ajax({
						type:"POST",
						url: "/addrList.do?umd="+umd,
						Type:"JSON",
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
			
			/* 회원가입 */
			function addMemeber(){
				/*입력되지 않은 항목*/
				var erTexts = ["아이디는", "성명은", "전화번호는", "전화번호는", "전화번호는",
				               	"휴대전화번호는", "휴대전화번호는", "휴대전화번호는", "이메일은", "이메일은",
								"주소는", "주소는", "주소는", "주소는"];
				
				/*유혀성 검사 실패 항목 및 미 입력 항목 검사*/
				if($(".false").size() == 0){
					/*text*/
					for(var i = 0; i < $("#memberForm :text").size(); i++){
						if($($("#memberForm :text").get(i)).val() == ""){
							alert(erTexts[i]+" 필수입력 사항입니다.");
							return;
						}
					}
					/*password*/
					for(var i = 0; i < 2; i++){
						if($($("#memberForm :password").get(i)).val() == ""){
							alert("비밀번호는 필수입력 사항입니다.");
							return;
						}	
					}
					
					/*ID중복확인 사용여부*/
					if(idCheckNum == 0){
						alert("아이디의 중복확인이 필요합니다.");
						return;
					}else if($(".idFalse").size() == 1){
						alert("이미 사용중인 아이디 입니다.");
						return;
					}else{
						$("#memberForm").submit();	
					}
				}else{
					alert("입력이 잘못된 항목이 존재합니다.");
					return;
				}
			}
			
			/* 취소 */
			function doCancel(){
				if(confirm("작업을 취소하시겠습니까?")){
					location.href = "/login.html";
				}
			}
		</script>
	</head>
	<body>
		<div style="font-size: 35px;">
   			<strong>회원가입</strong>
   		</div>
	
		<form id="memberForm" action="/member/memberProcess.do" method="POST">
			<!-- 상태를 등록으로 설정 -->
			<input name="state" type="hidden" value="insert">
			
			<table class="d-table" style="text-align: left;">
				<colgroup>
					<col width="20%">
					<col width="*%">
				</colgroup>
				<tbody>
					<tr>
						<td>아이디</td>
						<td>
							<input id="id" name="id" type="text" onkeyup="doIdCheckInit(event);" style="width: 120px;">
							<button onclick="doIdCheck();" type="button">중복확인</button>
							<label id="idCheckMsg"></label>
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>
							<input id="password" type="password" style="width: 120px;">
						</td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td>
							<input type="password" name="password" onkeyup="doPasswordCheck(this);" style="width: 120px;">
							<label class="msg"></label>
						</td>
					</tr>
					<tr>
						<td>성명</td>
						<td>
							<input name="nm" type="text" type="text" style="width: 120px;">
						</td>
					</tr>
					<tr>
						<td>성별</td>
						<td>
							<select name="gndr" style="width: 53px;">
								<option value="0">남</option>
								<option value="1">여</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>
							<input type="text" type="text" onkeyup="doNumberCheck(this);" style="width: 50px;">
							<label>-</label>
							<input type="text" type="text" onkeyup="doNumberCheck(this);" style="width: 80px;">
							<label>-</label>
							<input type="text" type="text" onkeyup="doNumberCheck(this);" style="width: 80px;">
							<input name="telNo" type="hidden">
							<label class="msg"></label>
						</td>
					</tr>
					<tr>
						<td>휴대전화번호</td>
						<td>
							<input type="text" type="text" onkeyup="doNumberCheck(this);" style="width: 50px;">
							<label>-</label>
							<input type="text" type="text" onkeyup="doNumberCheck(this);" style="width: 80px;">
							<label>-</label>
							<input type="text" type="text" onkeyup="doNumberCheck(this);" style="width: 80px;">
							<input name="mbtlnum" type="hidden">
							<label class="msg"></label>
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>
							<input id="email1" type="text" onkeyup="doEmailCheck(this);" style="width: 110px;">
							<label>@</label>
							<input id="email2" type="text" onkeyup="doEmailCheck(this);" style="width: 118px;">
							<input name="emal" type="hidden">
							<label class="msg"></label>
						</td>
					</tr>
					<tr>
						<td rowspan="3">주소</td>
						<td>	
							<input id="zipCOde1" disabled="disabled" style="width: 61px" type="text">
							<label>-</label>
							<input id="zipCOde2" disabled="disabled" style="width: 61px" type="text">
							<input name="zipCode" type="hidden">
							<input name="addrs" type="hidden">
							<button onclick="setAddrDialog();" type="button">우편번호 검색</button>
						</td>
					</tr>
					<tr>
						<td>
							<input name="addrs" type="text" disabled="disabled" style="width: 259px;">
						</td>
					</tr>
					<tr>
						<td>
							<input name="detailAddrs" type="text" style="width: 259px;">
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
		
		<!-- 등록 / 취소 버튼 -->
		<div class="button-group" style="text-align: center;">	
			<button onclick="addMemeber();" type="button">가입</button>
			<button onclick="doCancel();" type="button">취소</button>
		</div>
	</body>
</html>