<%@page import="dto.friend.Friend"%>
<%@page import="java.util.*"%>
<%@page import="dto.member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Member m = (Member)request.getAttribute("m");
Long fno = (Long)request.getAttribute("fno");
String referer = (String)request.getAttribute("referer");
%>
<jsp:include page="../header.jsp" flush="false" />
<div id="app">
    <main id="main" class="meet">
        <section class="section profiles profiles-profile">
            <div class="section__top fixed">
                <h2 class="section__top__title center">친구목록</h2>
                <div class="section__top__menu menu">
                    <div class="menu__group">
                        <a href="<%=referer %>" class="menu__group__prev"></a>
                        <a href="javascript:void(0)" class="menu__group__more depthControll"><i class="dot"></i></a>
                    </div>
                    <ul class="menu__depth depthMenu">
	                    <li><a href="${pageContext.request.contextPath}/report/page?mode=회원&rd_m_no=<%=m.getM_no() %>&rd_m_id=<%=m.getM_id() %>" class="menu__group__report">회원 신고</a></li>
                    </ul>
                </div>
            </div>      
            <div class="section__content btm-m">
                <div class="cardL">
                    <div class="wrap">
                        <div class="cardL__thumbnail">
                            <span>
                            	<%if(m.getM_img1() != null && !m.getM_img1().equals("")){ %>
                            	<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=m.getM_no() %>/<%=m.getM_img1() %>">
                            	<%}else { %>
                            	<img src="${pageContext.request.contextPath}/images/member_profile.jpg">
                            	<%} %>
                            </span>
                        </div>
                        <ul class="cardL__info">
                            <li class="cardL__info__name">
                            	<%=m.getM_name()%>
                      			<%if(fno > 0){ %>
                            	<a href="${pageContext.request.contextPath}/friend/del?no=<%=fno%>" class="utils btn btn--small">친구삭제</a>
                            	<%}else { %>
                            	<a href="${pageContext.request.contextPath}/friend/insert?fno=<%=m.getM_no()%>&name=<%=m.getM_name() %>&img=<%=m.getM_img1() %>" class="utils btn btn--small">친구추가</a>
                            	<%} %>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
	</main>
<jsp:include page="../main/footer.jsp" flush="false" />
<script src="${pageContext.request.contextPath}/js/script.js"></script>