package com.koRail.member.controller;

import java.util.List;
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
import com.koRail.common.to.CommonBean;
import com.koRail.common.to.MemberBean;
import com.koRail.member.service.MemberService;
import com.koRail.member.to.TcktBean;

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
	
	/***************************************
	 * 승차권 예매를 위한 운행일정 조회 화면
	 * @param model
	 * @param request
	 * @return
	 ***************************************/
	@RequestMapping(value="tcktSearch.html")
	public String findTcktSearchForm(Model model, HttpServletRequest request){
		/*레이아웃 변경*/
		super.setLayout(request, "stp");
		/*메뉴*/
		super.getMenuTree(model, "tcktSearchForm");
		
		/*열차종류 조회를 위한 코드설정*/
		CommonBean commonBean = new CommonBean();
		commonBean.setSeCode("TRAIN");
		/*열차*/
		model.addAttribute("commonCodeList", commonService.getCommonCodeList(commonBean));
		return "/member/resve/tcktSearchForm";
	}
	
	/*********************************
	 * 승차권 예매를 위한 운행일정 조회
	 * @param model
	 * @param tcktBean
	 * @return
	 *********************************/
	@RequestMapping(value="tcktList.do")
	public String findTcktList(Model model, TcktBean tcktBean){
		List<TcktBean> tcktList = memberService.getTcktList(tcktBean);
		
		model.addAttribute("tcktList", tcktList);
		model.addAttribute("tcktListSize", tcktList.size());
		
		return "jsonView";
	}
}
