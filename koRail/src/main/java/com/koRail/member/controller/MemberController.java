package com.koRail.member.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.koRail.common.controller.CommonController;
import com.koRail.common.exception.SQLExecutException;
import com.koRail.common.service.CommonService;
import com.koRail.common.to.CommonBean;
import com.koRail.common.to.MemberBean;
import com.koRail.common.to.RoomBean;
import com.koRail.member.service.MemberService;
import com.koRail.member.to.PintBean;
import com.koRail.member.to.ResveBean;
import com.koRail.member.to.ResveRcrdBean;
import com.koRail.member.to.SetleBean;
import com.koRail.member.to.TcktBean;

@Controller(value="memberController")
@RequestMapping("member")
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
	
	/*******************************
	 * 회원가입, 개인정보수정, 회원탈퇴
	 * @param model
	 * @param memberBean
	 * @param redirectAttributes
	 * @return
	 ********************************/
	@RequestMapping(value="memberProcess.do")
	public String processMember(Model model, @ModelAttribute MemberBean memberBean,
			RedirectAttributes redirectAttributes){
		try{
			/*정보 등록,수정,삭제*/
			memberService.setMember(memberBean);
			
			/*상태에 따른 화면 변경*/
			if("update".equals(memberBean.getState())){
				if(memberBean.getPassword() == null){
					return "redirect:/member/myInfo.html";
				}else{
					model.addAttribute("erCode", 0);
					return "jsonView";
				}
			}else if("delete".equals(memberBean.getState())){
				model.addAttribute("erCode", 0);
				return "jsonView";
			}else{
				return "redirect:/login.html";
			}
		}catch(SQLExecutException e){
			model.addAttribute("erCode", 1);
			model.addAttribute("erMsg", e.getMessage());
			return "jsonView";
		}
	}
	
	/*******************************************
	 * 개인정보 조회
	 * @param model
	 * @param request
	 * @return
	 *******************************************/
	@RequestMapping(value="myInfo.html")
	public String doTest(Model model, HttpServletRequest request){
		HttpSession session = request.getSession();
		/*session set parameter*/
		session.setAttribute("type", "common");
		session.setAttribute("type2", "myInfo");
		
		/*Set parameter*/
		MemberBean memberBean = new MemberBean();
		memberBean.setFormType("myInfoForm");
		memberBean.setSrcText(session.getAttribute("id").toString());
		
		/*메뉴*/
		super.getMenuTree(model, "myInfoMngForm");
		
		/*개인정보 조회 및 model 설정*/
		model.addAttribute("member", memberService.getMember(memberBean));
		/*포인트 조회 및 model 설정*/
		model.addAttribute("pint", memberService.getPint(memberBean.getSrcText()));
		
		return "/member/myInfo/myInfoMngForm";
	}
	
	/*******************************
	 * 개인정보 수정 화면
	 * @param model
	 * @param request
	 * @return
	 *******************************/
	@RequestMapping(value="updateMember.html")
	public String findUpdateUserForm(Model model, HttpServletRequest request){
		/*Set parameter*/
		HttpSession session = request.getSession();
		MemberBean memberBean = new MemberBean();
		memberBean.setFormType("myInfoForm");
		memberBean.setSrcText(session.getAttribute("id").toString());
		
		/*메뉴*/
		super.getMenuTree(model, "updateMemberForm");
		
		/*개인정보 조회 및 model 설정*/
		model.addAttribute("member", memberService.getMember(memberBean));
		
		return "/member/myInfo/updateMemberForm";
	}
	
	/***********************************
	 * 이용 내역
	 * @param model
	 * @param request
	 * @param redirectAttributes
	 * @return
	 ***********************************/
	@RequestMapping(value="useHstr.html")
	public String findUseHistoryForm(Model model, HttpServletRequest request,
			RedirectAttributes redirectAttributes){
		try{
			HttpSession session = request.getSession();
			
			/*메뉴*/
			super.getMenuTree(model, "useHistoryForm");
			
			/*로그인된 아이디로 포인트 조회*/
			PintBean pintBean = memberService.getPint(session.getAttribute("id").toString());
			model.addAttribute("pint", pintBean);
			
			return "/member/myInfo/useHistoryForm";
		}catch(NullPointerException e){
			return "redirect:/login.html";
		}
	}
	
	/********************************************
	 * 사용내역 조회
	 * @param model
	 * @param request
	 * @param commonBean
	 * @return
	 *********************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="useHstrList.do")
	public String findUseHistoryList(Model model, HttpServletRequest request,
			@ModelAttribute CommonBean commonBean){
		/*이용내역 정보*/
		Map<String, ?> map = memberService.getUseHistoryMap(commonBean);
		
		/*승차권 예매 내역*/
		List<ResveRcrdBean> resveRcrdList = (List<ResveRcrdBean>)map.get("resveRcrdList");
		model.addAttribute("resveRcrdListSize", resveRcrdList.size());
		model.addAttribute("resveRcrdList", resveRcrdList);
		
		/*포인트 사용 내역*/
		List<PintBean> pintList = (List<PintBean>)map.get("pintList");
		model.addAttribute("pintListSize", pintList.size());
		model.addAttribute("pintList", pintList);
		
		return "jsonView";
	}
	
	/********************************
	 * 현재 사용가능한 포인트 조히
	 * @param model
	 * @param id
	 * @return
	 ********************************/
	@RequestMapping("tdyPint.do")
	public String findTdyPint(Model model, @RequestParam("id") String id){
		model.addAttribute("tdyPint", memberService.getTdyPint(id));
		return "jsonView";
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
		/*메뉴*/
		super.getMenuTree(model, "tcktSearchForm");
		
		request.getSession().setAttribute("type2", "tckt");
		
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
	
	/**********************************************************
	 * 예약을 위해 선택한 승차권에 대한 호실정보 조회 및 예약된 좌석정보 조회
	 * @param model
	 * @param roomBean
	 * @return
	 **********************************************************/
	@RequestMapping(value="tcktRoomInfo.do")
	public String findTcktRoomInfo(Model model, @ModelAttribute RoomBean roomBean){
		Map<String, ?> map = memberService.getTcktRoomInfoList(roomBean);
		
		model.addAttribute("tcktRoomInfoList", map.get("roomList"));
		model.addAttribute("seatNoList", map.get("seatNoList"));
		
		return "jsonView";
	}
	
	/***************************************
	 * 예약 등록, 삭제
	 * @param model
	 * @param resveBean
	 * @param json
	 * @param redirectAttributes
	 * @return
	 ***************************************/
	@RequestMapping(value="processResve.do")
	public String doTest(Model model, @ModelAttribute ResveBean resveBean,
			@RequestParam(value="json", required=false) String json, RedirectAttributes redirectAttributes){
		/*등록*/
		if("insert".equals(resveBean.getState())){
			/* 
				* 예약 등록
			 	* Redirect post type parameter setting
			*/
			redirectAttributes.addFlashAttribute("resveCode", memberService.setResve(resveBean, json));
			
			return "redirect:resveAdd.html";
		}
		/*삭제*/
		else if("delete".equals(resveBean.getState())){			
			memberService.setResve(resveBean, json);
			
			model.addAttribute("rtCode", resveBean.getRtCode());
			model.addAttribute("rtMsg", resveBean.getRtMsg());
			
			return "jsonView";
		}else{
			return "redirect:tcktSearch.html";
		}
	}
	
	/*********************************
	 * 결제할 예매 정보 조회
	 * @param model
	 * @param request
	 * @param resveCode
	 * @return
	 **********************************/
	@RequestMapping(value="resveAdd.html")
	public String findResveAddForm(Model model, HttpServletRequest request,
			@RequestParam(value="resveCode", required=false) String resveCode) {
		/* Redirect post type parameter */
		if(resveCode == null){
			Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
			resveCode = (String) flashMap.get("resveCode");
        }
		
		/*메뉴*/
		super.getMenuTree(model, "resveAddForm");
		
		/* 결제할 예매 정보 */
		model.addAttribute("resve", memberService.getResve(resveCode));
		/*예약코드*/
		model.addAttribute("resveCode", resveCode);
		
		return "/member/resve/resveAddForm";
	}
	
	/************************************
	 * 결제화면 이동
	 * @param model
	 * @param resveBean
	 * @param detailResveBean
	 * @return
	 ************************************/
	@RequestMapping(value="setle.html")
	public String findsetleForm(Model model, @ModelAttribute ResveBean resveBean,
			@RequestParam(value="json") String json){
		/*메뉴*/
		super.getMenuTree(model, "setleForm");
		
		/*승차자명 등록*/
		memberService.setPsngrNm(json);
		
		/*카드종류 조회를 위한 코드설정*/
		resveBean.setSeCode("CARD_KND");
		/*카드종류*/
		model.addAttribute("commonCodeList", commonService.getCommonCodeList(resveBean));
		
		/*예약코드*/
		model.addAttribute("resveCode", resveBean.getResveCode());
		/*총 운임금액*/
		model.addAttribute("allFrAmount", resveBean.getAllFrAmount());
		/*총 할인금액*/
		model.addAttribute("allDscntAmount", resveBean.getAllDscntAmount());
		/*총 영수금액*/
		model.addAttribute("allRcptAmount", resveBean.getAllRcptAmount());
		
		return "/member/resve/setleForm";
	}
	
	/********************************
	 * 결제
	 * @param setleBean
	 * @return
	 *********************************/
	@RequestMapping(value="setleProcess.do")
	public String processSetle(RedirectAttributes redirectAttributes,
			@ModelAttribute SetleBean setleBean){
		if("insert".equals(setleBean.getState())){
			/*결제*/
			memberService.setSetle(setleBean);
			/* Redirect post type parameter setting */
			redirectAttributes.addFlashAttribute("resveCode", setleBean.getResveCode());
		}
		
		return "redirect:/member/setleSuccess.html";
	}
	
	/*************************************
	 * 결제 결과 화면
	 * @param model
	 * @param request
	 * @return
	 ***************************************/
	@RequestMapping(value="setleSuccess.html")
	public String findSetleSuccessForm(Model model, HttpServletRequest request){
		/* Redirect post type parameter */
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		
		/*메뉴*/
		super.getMenuTree(model, "setleSuccessForm");
		
		/*조회*/
		model.addAttribute("tcktInfo", memberService.getDetailTcktRcrdList((String)flashMap.get("resveCode")));
		
		/*요청화면 : setleSuccess.html*/
		model.addAttribute("requestForm", request.getRequestURI().split("/")[2]);
		
		return "/member/resve/detailResveRcrdForm";
	}
	
	/********************************
	 * 승차권 예매 현황
	 * @param model
	 * @param request
	 * @return
	 ********************************/
	@RequestMapping(value="resveRcrd.html")
	public String findResveRcrdForm(Model model, HttpServletRequest request){
		/*메뉴*/
		super.getMenuTree(model, "resveRcrdForm");
		
		/*현재 로그인되어있는 아이디*/
		String id = (String)request.getSession().getAttribute("id");
		/*조회*/
		List<ResveRcrdBean> resveRcrdList = memberService.getResveRcrdList(id);
		model.addAttribute("resveRcrdListSize", resveRcrdList.size());
		model.addAttribute("resveRcrdList", resveRcrdList);
		
		return "/member/resve/resveRcrdForm";
	}
	
	/*******************************
	 * 승차권 발권현황 화면
	 * @param model
	 * @param request
	 * @param resveCode
	 * @return
	 ********************************/
	@RequestMapping(value="detailResveRcrd.html")
	public String findDetailResveRcrdForm(Model model, HttpServletRequest request,
			@RequestParam(value="resveCode") String resveCode){
		/*메뉴*/
		super.getMenuTree(model, "detailResveRcrdForm");
		
		/*조회*/
		model.addAttribute("tcktInfo", memberService.getDetailTcktRcrdList(resveCode));
		/*예약코드*/
		model.addAttribute("resveCode", resveCode);
		/*요청화면 : detailResveRcrd.html*/
		model.addAttribute("requestForm", request.getRequestURI().split("/")[2]);
		
		return "/member/resve/detailResveRcrdForm";
	}
}
