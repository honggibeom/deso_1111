<%@page import="dto.member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member m = (Member)session.getAttribute("member");
%>
<jsp:include page="../header.jsp" flush="false" />
    <div id="app">
        <main id="main" class="meet">
            <section class="section mypage mypage-main">
                <div class="section__top fixed">
                    <h2 class="section__top__title">
                        <span class="logo"><img src="${pageContext.request.contextPath}/images/icon_logo.svg" alt="DESO"></span>
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:void(0)" class="menu__group__more depthControll"><i class="dot"></i></a>
                        </div>
                        <ul class="menu__depth depthMenu">
                            <li><a href="${pageContext.request.contextPath}/mypage/account" class="icon icon--user">계정 설정</a></li>
                            <li><a href="${pageContext.request.contextPath}/allim/action" class="icon icon--alarm">알람 설정</a></li>
                            <li><a href="${pageContext.request.contextPath}/information/terms" class="icon icon--info">이용 약관</a></li>
                            <li><a href="${pageContext.request.contextPath}/notice/list" class="icon icon--docs">공지사항</a></li>
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
                                <li class="cardL__info__name"><%=m.getM_name()%></li>
                                <li class="cardL__info__dept"><%=m.getM_school()%> <%=m.getM_study() %></li>
                                <li class="cardL__info__location"><%=(m.getM_address() != null)?m.getM_address() : "주소를 입력해보세요"%></li>
                                <li class="cardL__info__intro"><%=(m.getM_about_me() != null)?m.getM_about_me() : "자기소개를 해보세요"%></li>
                            </ul>
                        </div>
                    </div>
                    <div class="mypage-main__wrap">
                        <a href="${pageContext.request.contextPath}/mypage/profile" class="link__profile">프로필 수정</a>
                        <ul class="mypage__menu">
                            <li class="mypage__menu__item"><a href="${pageContext.request.contextPath}/mypage/activity/mymeet?title=내가만든 모임" class="mymeets">내가만든 모임</a></li>
                            <li class="mypage__menu__item"><a href="${pageContext.request.contextPath}/mypage/activity/myjoin?kind=모임&title=참여중인 모임" class="myjoins">참여중인 모임</a></li>
                            <li class="mypage__menu__item"><a href="${pageContext.request.contextPath}/mypage/activity/myjoin?kind=행사&title=참여중인 행사" class="myevents">참여중인 행사</a></li>
                            <li class="mypage__menu__item"><a href="${pageContext.request.contextPath}/mypage/activity/friend" class="mygroup">친구목록</a></li>
                        </ul>
                    </div>
                </div>
            </section>
        </main>
<jsp:include page="../main/footer.jsp" flush="false" />
<script src="${pageContext.request.contextPath}/js/script.js"></script>