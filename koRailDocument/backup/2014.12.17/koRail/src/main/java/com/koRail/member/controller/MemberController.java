package com.koRail.member.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.koRail.common.controller.CommonController;
import com.koRail.common.service.CommonService;
import com.koRail.common.to.MemberBean;
import com.koRail.member.service.MemberService;

@Controller(value="memberController")
@RequestMapping("/member/")
public class MemberController extends CommonController {
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	/****************************************
	 				회원/개인정보
	 ***************************************/
	
	/********************************
	 * 회원가입 화면
	 * @return
	 ********************************/
	@RequestMapping(value="memberAdd.html")
	public String findMemberAddForm(){
		return "member/memberAddForm";
	}
	
	/***************************
	 * id 중복확인
	 * @param model
	 * @param id
	 * @return
	 **************************/
	@RequestMapping(value="idCheck.do")
	public String doIdCheck(Model model, @RequestParam("id") String id){
		Map<String, String> stringMap = memberService.doIdCheck(id);
		
		model.addAttribute("rtCode", stringMap.get("rtCode"));
		model.addAttribute("rtMsg", stringMap.get("rtMsg"));
		
		return "jsonView";
	}
	
	/********************************
	 * 회원가입, 개인정보수정, 회원탈퇴
	 * @param memberBean
	 * @return
	 *******************************/
	@RequestMapping(value="memberProcess.do")
	public String processMember(@ModelAttribute MemberBean memberBean){
		memberService.setMember(memberBean);
		return "redirect:login.html";
	}
	
	/******************************************************
	 	 					승차권
	 ******************************************************/
	
	@RequestMapping(value="tcktSearch.html")
	public String findTcktSearchForm(Model model, HttpServletRequest request){
		/*레이아웃 변경*/
		super.setLayout(request, "stp");
		
		/*메뉴*/
		super.getMenuTree(model, "tcktSearchForm");
		return "/member/tckt/tcktSearchForm";
	}
}
