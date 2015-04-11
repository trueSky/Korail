package com.koRail.common.dao;

import java.util.List;
import java.util.Map;

import com.koRail.common.to.CommonBean;

public interface CommonDAO {
	/******************************
	 * 회원(관리자 포함) 찾기 : 로그인
	 * @param memberMap
	 *******************************/
	public void selectMember(Map<String, String> memberMap);
	
	/*********************************
	 * 공통코드 조회
	 * @param commonBean
	 * @return
	 ********************************/
	public List<CommonBean> selectCommonCode(CommonBean commonBean);
}
