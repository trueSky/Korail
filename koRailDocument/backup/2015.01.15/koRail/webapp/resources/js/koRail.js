/* 입력제한 숫자 */
function doNumberCheck(obj, event, length, paramFunction){
	/*문자열 치환*/
	var value = $(obj).val().replace(" ", "");
	
	/*치환된 문자열 적용*/
	$(obj).val(value);
	
	/* exc function */
	paramFunction;
	
	if(event.keyCode < 48){
		event.returnValue = true;
	}else if(event.keyCode >= 48 && event.keyCode <= 57){
		if(value.length >= length){
			event.returnValue = false;
		}
	}else if(event.keyCode >= 96 && event.keyCode <= 105){
		if(value.length >= length){
			event.returnValue = false;
		}
	}else{
		event.returnValue = false;
	}
}

/*
 * 숫자형식 변환
 * 형식 : 000,000 ex) 123,456
 * 사용가능 기호 : +, -
 */
function toCommaNumber(number) {
	var reg = /(^[+-]?\d+)(\d{3})/;	// 정규식
	var string = number.toString();	// 숫자를 문자열로 변환

	while (reg.test(string)){
		string = string.replace(reg, '$1' + ',' + '$2');
	}

	return string;
}

/* 입력제한 문자열 */
function doStringCheck(obj, event, length){
	/*문자열 치환*/
	var value = $(obj).val().replace(" ", "");
	
	/*치환된 문자열 적용*/
	$(obj).val(value);
	
	if(event.keyCode < 48){
		event.returnValue = true;
	}else if(event.keyCode >= 48 && event.keyCode <= 105){
		if(value.length >= length){
			event.returnValue = false;
		}
	}else{
		event.returnValue = false;
	}
}
