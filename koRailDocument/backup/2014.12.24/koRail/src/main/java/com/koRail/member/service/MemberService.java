package com.koRail.member.service;

import java.util.List;
import java.util.Map;

import com.koRail.common.to.MemberBean;
import com.koRail.member.to.TcktBean;

public interface MemberService {
	
	/*****************************************
 					회원 게인정보
	******************************************/
	
	/***************************
	 * ID 중복확인
	 * @param id
	 * @return
	 **************************/
	public Map<String, String> doIdCheck(String id);
	
	/**********************************
	 * 회원가입, 개인정보수정, 회원탈퇴
	 * @param memberBean
	 ********************************/
	public void setMember(MemberBean memberBean);

	/*****************************************
						승차권
	******************************************/
	
	/***********************************
	 * 승차권 예매를 위한 운행일정 조회
	 * @param tcktBean
	 * @return
	 **********************************/
	public List<TcktBean> getTcktList(TcktBean tcktBean);
}
