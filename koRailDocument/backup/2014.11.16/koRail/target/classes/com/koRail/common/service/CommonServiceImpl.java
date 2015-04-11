package com.koRail.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.koRail.common.dao.CommonDAO;
import com.koRail.common.to.CommonBean;

/**************************************************************
* @Method name
* set* : DB 등록 / 수정 / 삭제, get* : 조회, do* : 기타작업
**************************************************************/
@Service(value="commonService")
public class CommonServiceImpl implements CommonService {
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	/****************************************
	 * 로그인
	 *****************************************/
	
	/*****************************************
	 * 로그인
	 * @param type : 로그인 유형 - 일반 / 관리자
	 * @param id
	 * @param pw
	 * @return
	 ******************************************/
	@Override
	public Map<String, String> doLogin(String type, String id, String pw) {
		Map<String, String> memberMap = new HashMap<String, String>();
		
		/*조회할 정보 지정*/
		memberMap.put("type", type);	/*로그인 타입 : 관리자, 일반*/
		memberMap.put("id", id);		/*아이디*/
		memberMap.put("pw", pw);		/*비밀번호*/
		memberMap.put("name", null);	/*로그인한 사용자 명*/
		memberMap.put("erCode", null);	/*에러코드*/
		memberMap.put("erMsg", null);	/*에러메세지*/
		
		/*****************************************
		 erCode, erMsg는 프로시져의 OUT파라미터 이므로
		 프로시져에서의 OUT파람미터 값으로 설정된다.
		*****************************************/
		commonDAO.selectMember(memberMap);
		
		return memberMap;
	}
	
	/***************************************
	 * 공통코드
	 ***************************************/
	
	/******************************************
	 * 공통코드 조회
	 * @param commonBean
	 * @return
	 ******************************************/
	@Override
	public List<CommonBean> getCommonCodeList(CommonBean commonBean) {
		return commonDAO.selectCommonCode(commonBean);
	}
}
