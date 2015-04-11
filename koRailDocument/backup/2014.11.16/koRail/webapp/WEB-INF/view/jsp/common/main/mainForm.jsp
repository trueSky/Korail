<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 파라미터 인코딩 설정 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 프로젝트까지의 웹 경로 -->
<% String path = request.getContextPath(); %>

<!-- 국제화 메세지를 사용하기 위한 태그설정 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 국가코드 설정, 로케일 태그를 선언 하지않으면 기본 설정으로 웹 브라우져 국가코드 또는 OS의 국가코드를 참조한다. -->
<fmt:setLocale value="${sessionScope.language}" />

<!-- 파라미터 인코딩 형식 -->
<fmt:requestEncoding value="UTF-8" />

<!-- 메세지 properties파일의 페키지.파일명 -->
<fmt:bundle basename="language.msg.msg">
	<script>
	$(document).ready(function(){
		$("#prev").click(function(){
			var sp = 150;
			
			var item = $("div.carousel-inner").children(".active");
			var ol = $("ol.carousel-indicators").children(".active");
			
			if(item.index() == 0){
				
				item.fadeOut(sp, function(){
					item.removeClass("active");
					ol.removeClass("active");
					
					$("div.carousel-inner :last-child").fadeIn(sp, function(){
						$("div.carousel-inner :last-child").addClass("active");
						$("ol.carousel-indicators :last-child").addClass("active");
					});
				});
				
			}else{
				item.fadeOut(sp, function(){
					item.removeClass("active");
					ol.removeClass("active");
				
					item.prev().fadeIn(sp, function(){
						item.prev().addClass("active");
						ol.prev().addClass("active");
					});
				});
			}
		});
		
		$("#next").click(function(){
			var sp = 150;
			
			var item = $("div.carousel-inner").children(".active");
			var ol = $("ol.carousel-indicators").children(".active");
			
			if(item.index()+1 == $("div.carousel-inner").children("div").size()){
				item.fadeOut(sp, function(){
					item.removeClass("active");
					ol.removeClass("active");
				
					$("div.carousel-inner :first-child").fadeIn(sp, function(){
						$("div.carousel-inner :first-child").addClass("active");
						$("ol.carousel-indicators :first-child").addClass("active");
					});
				});
				
			}else{
				item.fadeOut(sp, function(){
					item.removeClass("active");
					ol.removeClass("active");
					
					item.next().fadeIn(sp, function(){
						item.next().addClass("active");
						ol.next().addClass("active");
					});
				});
				
			}
		});
	});
	</script>
	
	<div class="row">
		<div class="col-xs-6">
			<div id="carousel" class="carousel">
				<ol class="carousel-indicators">
    				<li class="active"></li>
    				<li></li>
    				<li></li>
  				</ol>
			
			  	<!-- Wrapper for slides -->
			  	<div class="carousel-inner">
			    	<div class="item active">
			     		<img class="img-thumbnail" style="width: 100%; height: 250px;" src="<%=path %>/res/img/1.jpg">
			    	</div>
			    	
			    	<div class="item">
			     		<img class="img-thumbnail" style="width: 100%; height: 250px;" src="<%=path %>/res/img/2.jpg">
			    	</div>
			    	
			    	<div class="item">
			     		<img class="img-thumbnail" style="width: 100%; height: 250px;" src="<%=path %>/res/img/egv.gif">
			    	</div>
			  	</div>
			 
			  	<!-- Controls -->
			  	<a id="prev" class="left carousel-control" href="#">
			    	<span class="icon-prev"></span>
			  	</a>
			  	<a id="next" class="right carousel-control" href="#">
			    	<span class="icon-next"></span>
			  	</a>
			</div>
		</div>
	</div>
</fmt:bundle>