<%@page import="dto.friend.Friend"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<Friend> f = (ArrayList)request.getAttribute("list");
	String title = (String)request.getAttribute("title");
%>
<jsp:include page="../../header.jsp" flush="false" />
<div id="app">
    <main id="main">
        <section class="section mypage mypage-list">
            <div class="section__top fixed">
                <h2 class="section__top__title center">친구 목록</h2>
                <div class="section__top__menu menu">
                    <div class="menu__group">
                        <a href="${pageContext.request.contextPath}/mypage" class="menu__group__prev"></a>
                    </div>
                </div>
            </div>
            <div class="section__content btm-m">
                <ul class="mypage__groups member__list">
                <%if(f != null){ %>
                	<%for(int i=0; i<f.size(); i++){ %>
                    <li class="member full">
                        <div class="wrap">
                       		<a href="${pageContext.request.contextPath}/friend?no=<%=f.get(i).getF_m_no() %>">
	                            <div class="member__link" >
	                                <%if(f.get(i).getF_img() != null && !f.get(i).getF_img().equals("")){ %>
	                            	<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=f.get(i).getF_m_no() %>/<%=f.get(i).getF_img() %>">
	                            	<%}else { %>
	                            	<img src="${pageContext.request.contextPath}/images/member_profile.jpg">
	                            	<%} %>
	                                <span class="name"><%=f.get(i).getF_name() %></span>
	                            </div>
	                        </a>
                            <span class="btn__wrap">
                                <a href="${pageContext.request.contextPath}/friend/del?no=<%=f.get(i).getF_no() %>" class="btn btn--small">친구삭제</a>
                            </span>
                        </div>
                    </li>
                    <%} %>
                <%} %>
                </ul>
            </div>
        </section>
    </main>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
<jsp:include page="../../main/footer.jsp" flush="false" />