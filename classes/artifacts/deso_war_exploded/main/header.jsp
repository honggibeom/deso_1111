<%@page import="java.util.*"%>
<%@page import="dto.allim.Allim"%>
<%@page import="dto.member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member m = (Member)session.getAttribute("member");
	int count = (int)session.getAttribute("count");
	String mode = (String)request.getAttribute("mode");	
	String addr = (String)request.getAttribute("addr");
	String cate = (String)request.getAttribute("cate");
	String date = (String)request.getAttribute("date");
	String path = request.getRequestURI();
%>
<jsp:include page="../header.jsp" flush="false" />
<div class="layer">
    <div class="modal" data-modal="guest">
        <h5 class="modal__title">이용 안내</h5>
        <p class="modal__text">
        	<%if(m == null) {%>
        	로그인 후 이용하실 수 있습니다.
        	<%}else if(!m.getM_studentFl()){ %>
        	인증이 완료된 후 이용하실 수 있습니다.
        	<%} %>
        </p>
        <div class="modal__btns">
            <button type="button" class="btn btn--cancel modalClose">닫기</button>
            <!-- ../html/mypage/account/edit/edit_profile.html -->
            <%if(m == null) {%>
        		<a href="./index" class="btn btn--submit">확인</a>
        	<%}else if(!m.getM_studentFl()){ %>
        		<a href="./member/student?id=<%=m.getM_id() %>" class="btn btn--submit">확인</a>
        	<%} %>
        </div>
    </div>
</div>
<div id="app">
    <header id="header" class="header">
        <div class="wrap">
            <h1 class="header__logo logo"><img src="${pageContext.request.contextPath}/images/icon_logo.svg" alt="DESO"></h1>
            <div class="header__menu">
            	<%if(path.indexOf("board") > 0){ %>
            	<a href="${pageContext.request.contextPath}/board/filter?mode=<%=mode %>&addr=<%=addr %>&cate=<%=cate %>&date=<%=date %>" class="header__menu__item menu__group__filter"><img src="${pageContext.request.contextPath}/images/icon_filter.svg" alt="필터검색"></a>
            	<%} %>
                <a href="${pageContext.request.contextPath}/allim/list" class="header__menu__item alarm"><i class="cnt"><%=count %></i></a>
            </div>
        </div>
    </header>