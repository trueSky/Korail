package com.koRail.member.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.koRail.common.dao.MemberDAO;
import com.koRail.common.to.MemberBean;

@Service(value="memberService")
public class MemberServiceImpl implements MemberService {
	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	/***************************
	 * ID 중복확인
	 * @param id
	 * @return
	 **************************/
	public Map<String, String> doIdCheck(String id){
		Map<String, String> stringMap = new HashMap<String, String>();
		
		/* Map 설정 */
		stringMap.put("id", id);
		stringMap.put("rtId", null);
		stringMap.put("rtCode", null);
		stringMap.put("rtMsg", null);
		
		memberDAO.selectMemberId(stringMap);
		
		return stringMap;
	}
	
	/**********************************
	 * 회원가입, 개인정보수정, 회원탈퇴
	 * @param memberBean
	 **********************************/
	@Override
	public void setMember(MemberBean memberBean){
		if("insert".equals(memberBean.getState())){
			memberDAO.insertMember(memberBean);
		}else if("update".equals(memberBean.getState())){
			System.out.println("u");
		}else if("delete".equals(memberBean.getState())){
			System.out.println("d");
		}else{
			return;
		}
	}
}
