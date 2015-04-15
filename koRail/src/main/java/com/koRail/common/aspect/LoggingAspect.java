package com.koRail.common.aspect;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

@Aspect
public class LoggingAspect {
	protected Log logger = null;
	
	@Before("execution(* com..controller.*.*(..))")
	public void doTest(JoinPoint joinPoint){
		System.out.println(joinPoint.getClass().getName());
		
	}
	
	/**********************
	 * service logging
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 **********************/
	@Around("execution(* com..service.*.*(..))")
	public Object doServiceLogging(ProceedingJoinPoint joinPoint) throws Throwable{
		String className = joinPoint.getTarget().getClass().getSimpleName(); //클레스명
		String argsValue = "";
		
		logger = LogFactory.getLog(className);
		
		if (logger.isDebugEnabled()) {
			logger.debug(className + "." + joinPoint.getSignature().getName() + "()"+ "시작");
			
			Object[] args = joinPoint.getArgs(); //파라미터
			if ((args != null) && (args.length > 0)) {
				for (int i = 0; i < args.length; i++) {
					if(i+1 == args.length){
						argsValue += args[i];
					}else{
						argsValue += args[i]+", ";
					}
				}
				
				logger.debug("파라미터: " + argsValue);
			}
		}
		
		// 타겟 클레스의 메서드
		Object retVal = joinPoint.proceed();
		
		if (logger.isDebugEnabled()) {
			logger.debug(className + "." + joinPoint.getSignature().getName() + "()"+ " 종료");
		}

		return retVal;
	}
	
	/**********************************
	 * DAO logging
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 **********************************/
	@Around("execution(* com..dao.*.*(..))")
	public Object daoLogging(ProceedingJoinPoint joinPoint) throws Throwable{
		String className = joinPoint.getTarget().getClass().getSimpleName(); //클레스명
		String argsValue = "";
		
		logger = LogFactory.getLog(className);
		
		if (logger.isDebugEnabled()) {
			logger.debug("---------------------------------------------------------------------");
			logger.debug(className + "." + joinPoint.getSignature().getName() + "()"+ "시작");
			
			Object[] args = joinPoint.getArgs(); //파라미터
			if ((args != null) && (args.length > 0)) {
				for (int i = 0; i < args.length; i++) {
					if(i+1 == args.length){
						argsValue += args[i];
					}else{
						argsValue += args[i]+", ";
					}
				}
				
				logger.debug("파라미터: " + argsValue);
			}
		}
		
		// 타겟 클레스의 메서드
		Object retVal = joinPoint.proceed();
		
		if (logger.isDebugEnabled()) {
			logger.debug(className + "." + joinPoint.getSignature().getName() + "()"+ " 종료");
			logger.debug("---------------------------------------------------------------------");
		}
		
		return retVal;
	}
}