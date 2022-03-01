<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String queryString = (request.getQueryString() != null)?URLDecoder.decode(request.getQueryString(), "UTF-8"):"";
%>
	<nav id="navigation" class="nav">
		<ul>
			<li class="nav__item <%if(request.getServletPath().indexOf("main") > 0 ){ %>on<%} %> ">
				<a href="${pageContext.request.contextPath}/main" class="icon">	
					<img src="${pageContext.request.contextPath}/images/icon_nav_home_on.svg" alt="home" class="on">					
					<img src="${pageContext.request.contextPath}/images/icon_nav_home_off.svg" alt="home" class="off"> 
				</a> 
				<a href="${pageContext.request.contextPath}/main" class="title">홈</a>
			</li>
			<li class="nav__item <%if(request.getServletPath().indexOf("board") > 0 && queryString.equals("mode=모임")){ %>on<%} %>">
				<a href="${pageContext.request.contextPath}/board/list?mode=모임" class="icon"> 
					<img src="${pageContext.request.contextPath}/images/icon_nav_meet_on.svg" alt="meet" class="on">
					<img src="${pageContext.request.contextPath}/images/icon_nav_meet_off.svg" alt="meet" class="off">
				</a>
				<a href="${pageContext.request.contextPath}/board/list?mode=모임" class="title">모임</a>
			</li>
			<li class="nav__item <%if(request.getServletPath().indexOf("board") > 0 && queryString.equals("mode=행사")){ %>on<%}%>">
				<a href="${pageContext.request.contextPath}/board/list?mode=행사" class="icon"> 	
					<img src="${pageContext.request.contextPath}/images/icon_nav_event_on.svg" alt="event" class="on">
					<img src="${pageContext.request.contextPath}/images/icon_nav_event_off.svg" alt="event" class="off">
				</a>
				<a href="${pageContext.request.contextPath}/board/list?mode=행사" class="title">행사</a>
			</li>
			<li class="nav__item <%if(request.getServletPath().indexOf("mypage") > 0){ %>on<%}%>">
				<a href="${pageContext.request.contextPath}/mypage" class="icon"> 
					<img src="${pageContext.request.contextPath}/images/icon_nav_mypage_on.svg" alt="mypage" class="on">	
					<img src="${pageContext.request.contextPath}/images/icon_nav_mypage_off.svg" alt="mypage" class="off">
				</a> 
				<a href="${pageContext.request.contextPath}/mypage" class="title">마이페이지</a>
			</li>
		</ul>
	</nav>
</div>
</body>
</html>