package com.koRail.common.service;

import java.util.List;
import java.util.Map;

import com.koRail.common.to.CommonBean;

public interface CommonService {
	/*****************************************
	 * 로그인
	 * @param type : 로그인 유형 - 일반 / 관리자
	 * @param id
	 * @param pw
	 * @return
	 ******************************************/
	public Map<String, String> doLogin(String type, String id, String pw);

	/******************************************
	 * 공통코드 조회
	 * @param commonBean
	 * @return
	 ******************************************/
	public List<CommonBean> getCommonCodeList(CommonBean commonBean) ;
}
