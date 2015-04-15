package com.koRail.common.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springbyexample.web.servlet.view.tiles2.TilesUrlBasedViewResolver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	protected Log logger = LogFactory.getLog(LoginCheckInterceptor.class);
	
	@Autowired
	private ApplicationContext applicationContext;
	
	@Autowired
	private TilesUrlBasedViewResolver tilesUrlBasedViewResolver;
	
	String exMethodName = null;
	
	String formName = "redirect:/sessionOut.html";
	
	/**
	 * 오청에 의해 실행되는 컨트롤러의 메서드 이름 설정
	 * @param request
	 */
	public void setExMethodName(HttpServletRequest request){
		//RequestMapping 정보
		RequestMappingHandlerMapping mapping = applicationContext.getBean(RequestMappingHandlerMapping.class);
		Map<RequestMappingInfo, HandlerMethod> map = mapping.getHandlerMethods();
		
		for(RequestMappingInfo requestMappingInfo : map.keySet()){
			HandlerMethod method = map.get(requestMappingInfo);
			for (String uri : requestMappingInfo.getPatternsCondition().getPatterns()) {
				if(uri.equals(request.getRequestURI().toString())){
					exMethodName = method.getBeanType().getName()+"."+method.getMethod().getName();
            	}
            }
        }
	}
	
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
		
		if(logger.isInfoEnabled()){
			logger.info("---------------------------------------------------------------------");
		}
		
		if(logger.isDebugEnabled()){
			setExMethodName(request);
			logger.debug(exMethodName+"() 시작");
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
				if(logger.isInfoEnabled()){
					logger.info("---------------------------------------------------------------------");
				}
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
		if(logger.isDebugEnabled()){
			logger.debug("---------------------------------------------------------------------");
			logger.debug(exMethodName+"() 종료");
			exMethodName = null;
		}
		if(logger.isInfoEnabled()){
			logger.info("---------------------------------------------------------------------");
		}
	}
}