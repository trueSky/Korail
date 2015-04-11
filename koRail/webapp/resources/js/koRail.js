/*  
 * 입력제한 숫자
 * obj : 이벤트를 실행한 요소
 * event
 * length : 입력허용 범위
 * paramFunction : 추가로 실행할 함수
*/
function doNumberCheck(obj, event, length, paramFunction){
	/*문자열 치환*/
	var value = obj.value;
	
	/*공백 치환*/
	if(/\s/gi.test(value)){
		value = value.replace(/\s/gi, "");
	}
	
	/*value에 대한 콤마길이 제외*/
	if(/,/gi.test(value)){
		var comma =  value.replace(/\d/gi, "");
		length = length+comma.length;
	}
	
	if(event.keyCode < 48){
		event.returnValue = true;
	}else if(event.keyCode >= 48 && event.keyCode <= 57){
		if(value.length >= length){
			event.preventDefault();
		}
	}else if(event.keyCode >= 96 && event.keyCode <= 105){
		if(value.length >= length){
			event.preventDefault();
		}
	}else{
		event.preventDefault();
	}
	
	/* exc function */
	paramFunction;
}

/*
 * obj : 이벤트가 발생한 객체
 * 숫자형식 변환
 * 형식 : 000,000 ex) 123,456
 * 사용가능 기호 : +, -
 */
function toCommaNumber(obj) {
	var reg = /(^[+-]?\d+)(\d{3})/;	// 정규식
	var string = obj.value; //값
	
	/*replace*/
	if(/,/gi.test(obj.value)){
		string = string.replace(/,/gi, "");	// 숫자를 문자열로 변환
	}

	while (reg.test(string)){
		string = string.replace(reg, '$1' + ',' + '$2');
	}

	obj.value = string;	/*객체에 값 설정*/
}

/*
 * 입력제한 문자열
 * obj : 이벤트를 실행한 요소
 * event
 * length : 입력허용 범위
 * SkipDot : . 허용여부 
*/
function doStringCheck(obj, event, length, SkipDot){
	/*문자열 치환*/
	var value = obj.value;
	
	/*공백 치환*/
	if(/\s/gi.test(value)){
		value = value.replace(/\s/gi, "");
	}
	
	if(event.keyCode == 190 && SkipDot == true){
		event.returnValue = true;
	}else if(event.keyCode < 48){
		event.returnValue = true;
	}else if(event.keyCode >= 48 && event.keyCode <= 105){
		if(value.length >= length){
			event.preventDefault();
		}
	}else{
		event.preventDefault();
	}
}

/*입력수 재한*/
function setLimitLength(obj, event, length){
	/*문자열 치환*/
	var value = obj.value;
	
	/*공백 치환*/
	if(/\s/gi.test(value)){
		value = value.replace(/\s/gi, "");
	}
	
	if(event.keyCode < 48){
		event.returnValue = true;
	}else if(value.length >= length){
		event.preventDefault();
	}
}
