package com.koRail.member.service;

import java.util.Map;

import com.koRail.common.to.MemberBean;

public interface MemberService {
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
}
