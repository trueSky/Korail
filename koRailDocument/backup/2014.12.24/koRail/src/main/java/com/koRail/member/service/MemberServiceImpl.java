package com.koRail.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.koRail.common.dao.MemberDAO;
import com.koRail.common.to.MemberBean;
import com.koRail.member.dao.ResveDAO;
import com.koRail.member.to.TcktBean;

@Service(value="memberService")
public class MemberServiceImpl implements MemberService {
	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	@Resource(name="resveDAO")
	private ResveDAO resveDAO;
	
	/*****************************************
					회원 게인정보
	******************************************/
	
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
	
	/*****************************************
						승차권
	******************************************/

	/***********************************
	 * 승차권 예매를 위한 운행일정 조회
	 * @param tcktBean
	 * @return
	 **********************************/
	@Override
	public List<TcktBean> getTcktList(TcktBean tcktBean){
		return resveDAO.selectTcktList(tcktBean);
	}
}
