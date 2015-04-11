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
	
	String formName = "common/login/loginForm";
	
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
			
			tilesUrlBasedViewResolver.setTilesDefinitionName("nlg");
			throw new ModelAndViewDefiningException(new ModelAndView(formName));
		}else{
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