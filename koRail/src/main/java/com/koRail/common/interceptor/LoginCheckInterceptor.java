package com.koRail.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springbyexample.web.servlet.view.tiles2.TilesUrlBasedViewResolver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	@Autowired
	private TilesUrlBasedViewResolver tilesUrlBasedViewResolver;
	
	String formName = "redirect:/sessionOut.html";
	
	/********************************
	 * Login session check
	 * @param request
	 * @param response
	 * @param handler
	 * @return
	 * @throws Exception
	 *******************************/
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("id"); /*아이디*/
		String type = (String)session.getAttribute("type"); /*로그인 유형 : 관리자 , 일반*/
		
		if(logger.isDebugEnabled()){
			logger.debug("Start controller");
		}
		
		if(logger.isInfoEnabled()){
			logger.info("---------------------------------------------------------------------");
		}
		
		//Cache check
		if(tilesUrlBasedViewResolver.isCache()){
			tilesUrlBasedViewResolver.clearCache();
		}
		
		//Login session check
		if(id == null || id.equals("")){
			if(logger.isInfoEnabled()){
				logger.info("Login faile: "+type+"-"+id);
			}
			
			/*템플릿 변경*/
			tilesUrlBasedViewResolver.setTilesDefinitionName("nlg");
			
			/*
			 * 일반적인 요청과 ajax형식의 요청을 구분한 에러 처리
			 * 이 방법은 표준 header가 아닌 비 표춘 header를 이용한 방법입니다.
			 * X-Requested-With의 접두사 "X"는 비 표준을 의미합니다. (Non-standard)
			 * X-Requested-With필드에 XMLHttpRequest가 포함되어있습니다.
			 * 사용가능 환경 : JQuery, Prototype
			 */
			if(request.getHeader("X-Requested-With".toLowerCase()) == null){
				throw new ModelAndViewDefiningException(new ModelAndView(formName));
				//response.sendRedirect(formName);
			}else{
				response.sendError(401);
			}
		}else{
			/* Layout 설정/변경 */
			session.setAttribute("layoutName", "stp");	/*레이아웃 저장*/
			tilesUrlBasedViewResolver.setTilesDefinitionName("stp");/*레이아웃 설정*/
			
			if(logger.isInfoEnabled()){
				logger.info("Admin login success: "+type+"-"+id);
			}
		}
		
		if(logger.isInfoEnabled()){
			logger.info("---------------------------------------------------------------------");
		}
		
		return true;
	}
	
	public void afterCompletion(
			HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		if(logger.isInfoEnabled()){
			logger.info("---------------------------------------------------------------------");
		}
	}
}