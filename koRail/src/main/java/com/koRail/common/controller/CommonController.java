package com.koRail.common.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springbyexample.web.servlet.view.tiles2.TilesUrlBasedViewResolver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.koRail.common.service.CommonService;
import com.koRail.common.to.AddrBean;
import com.koRail.common.to.CommonBean;
import com.koRail.common.util.MenuTree;

/**********************************************************
 * @Return type
 * 	String : 이동할 화면
 *	jsonView : json 형식
 * @RequestMapping
 * 	*.html 	: 단순 화면 이동 또는 화면이동과 DB 조회
 	*.do 	: DB 접속
 * @Method name
 *  find**List	: DB조회 결과가 List인 경우
 *  find*		: DB조회 결과가 하나이거나 화면이동인 경우
 *	process*	: DB 등록 / 수정 / 삭제인 경우
 *	set*		: 설정
 *	do*			: 기타작업
 * @author Administrator
 **********************************************************/
@Controller(value="CommonController")
@RequestMapping(value="/")
public class CommonController {
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	@Autowired
	private TilesUrlBasedViewResolver tilesUrlBasedViewResolver;
	
	/******************************************************
	 						설정
	 ******************************************************/
	
	/*************************************
	 * Layout 설정/변경
	 * 레이아웃 종류
	 *	ntp : 템블릿이 적용되자 않은 레이아웃
	 *	nlg : 로그인을 하지않은 레이아웃
	 *	stp : 템플릿이 적용된 레이아웃
	 * @param request
	 * @param layoutName
	 *************************************/
	public void setLayout(HttpServletRequest request, String layoutName){
		request.getSession().setAttribute("layoutName", layoutName);	/*레이아웃 저장*/
		tilesUrlBasedViewResolver.setTilesDefinitionName(layoutName);	/*레이아웃 설정*/
	}
	
	/**************************************
	 * 트리메뉴
	 * @param model
	 * @param formName
	 **************************************/
	public void getMenuTree(Model model, String formName){
		model.addAttribute("menuTree", MenuTree.getInstance().getMenu(formName));
	}
	
	/***************************************
	 * 세션만료화면
	 * @return
	 *************************************/
	@RequestMapping(value="sessionOut.html")
	public String findSessionTimeOutForm(){
		return "/error/sessionTimeOutForm";
	}
	
	/*********************************************************
								main
	*********************************************************/
	
	/**************************
	 * 메인화면으로 이동
	 * @return
	 **************************/
	@RequestMapping(value="main.html")
	public String findMainForm(HttpServletRequest request){
		this.setLayout(request, "nlg");
		return "/common/main/mainForm";
	}
	
	/*********************************************************
							login
	 *********************************************************/
	
	/****************************************
	 * 로그인화면으로 이동
	 * @param request
	 * @return
	 ***************************************/
	@RequestMapping(value="login.html")
	public String findLoginForm(HttpServletRequest request){
		/* Redirect post type parameter */
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		
		/*redirect check*/
		if(flashMap == null){
			request.getSession().invalidate(); /*모든세션 초기화*/
			this.setLayout(request, "nlg"); /*레이아웃 제설정*/
			return "/common/login/loginForm";
		}else{
			return "/common/login/loginForm";
		}
	}

	/***************************************************
	 * 로그인
	 * @param model
	 * @param request
	 * @param type : 로그인 유형 - 일반 / 관리자
	 * @param id
	 * @param pw
	 * @return
	 *****************************************************/
	@RequestMapping(value="login.do")
	public String test(Model model, HttpServletRequest request,
			@RequestParam(value="type") String type,
			@RequestParam(value="id") String id,
			@RequestParam(value="pw") String pw){
		
		Map<String, String> map = commonService.doLogin(type, id, pw);
		
		/*에러코드 : 성공 0 , 실패 1*/
		String erCode = map.get("erCode");
		
		/*성공 시 세션에 저장*/
		if("0".equals(erCode)){
			/*로그인한 타입*/
			request.getSession().setAttribute("type", type);
			/*로그인한 아이디*/
			request.getSession().setAttribute("id", id);
			/*로그인한 아이디의 비밀번호*/
			request.getSession().setAttribute("password", pw);
			/*로그인한 사용자 명*/
			request.getSession().setAttribute("name", map.get("name"));
		}
		
		/*에러코드*/
		model.addAttribute("erCode", erCode);
		/*에러 메세지*/
		model.addAttribute("erMsg", map.get("erMsg"));
		
		return "jsonView";
	}
	
	/*************************************
	 * 로그아웃
	 * @param request
	 * @return
	 *************************************/
	@RequestMapping(value="logout.do")
	public String doLogout(HttpServletRequest request){
		request.getSession().invalidate(); /*모든세션 초기화*/
		this.setLayout(request, "nlg"); /*레이아웃 제설정*/
		return "redirect:login.html";
	}
	
	/*************************************************************
	 						공통코드
	 ************************************************************/
	
	/***********************************
	 * 공통코드 조회
	 * @param model
	 * @param commonBean
	 * @return
	 ***********************************/
	@RequestMapping(value="commonCodeList.do")
	public String findCommonCode(Model model, @ModelAttribute CommonBean commonBean){
		model.addAttribute("commonCode", commonService.getCommonCodeList(commonBean));
		return "jsonView";
	}
	
	/**************************************************************
	 							주소
	 **************************************************************/
	
	/******************************
	 * 주소검색
	 * @param model
	 * @param umd
	 * @return
	 ******************************/
	@RequestMapping(value="addrList.do")
	public String findAddrList(Model model, @RequestParam(value="umd") String umd){
		List<AddrBean> addrList = commonService.getAddrList(umd);
		
		model.addAttribute("addrList", addrList);
		model.addAttribute("addrListSize", addrList.size());
		
		return "jsonView";
	}
}