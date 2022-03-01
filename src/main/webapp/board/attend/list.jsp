<%@page import="java.util.ArrayList"%>
<%@page import="dto.attend.Attend"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<Attend> list = (ArrayList)request.getAttribute("list");
	int state = (Integer)request.getAttribute("state");
	Long b_no = (Long)request.getAttribute("no");
%>
<jsp:include page="../../header.jsp" flush="false" />
    <div id="app">
        <main id="main">
            <section class="section profiles profiles-waitings">
                <div class="section__top fixed">
                    <h2 class="section__top__title center"><%=(state == 0)?"대기자":"참가자" %></h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="../view?no=<%=b_no %>" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <ul class="member__list">
                    	<%for(int i=0; i<list.size(); i++){ %>
                        <li class="member full">
                            <div class="wrap">
                            	<a href="${pageContext.request.contextPath}/friend?no=<%=list.get(i).getM_no() %>">
	                                <div class="member__link">
	                                    <%if(list.get(i).getM_img() != null && !list.get(i).getM_img().equals("")){ %>
		                               	<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=list.get(i).getM_no() %>/<%=list.get(i).getM_img() %>">
		                               	<%}else { %>
		                               	<img src="${pageContext.request.contextPath}/images/member_profile.jpg">
		                               	<%} %>
	                                    <span class="name"><%=list.get(i).getM_name() %></span>
	                                </div>
                                </a>
                                <%if(state == 0){ %>
                                <span class="btn__wrap">
                                    <a href="./state?no=<%=list.get(i).getNo() %>&mode=1&b_no=<%=b_no %>" class="btn btn--small">수락</a>
                                    <a href="./state?no=<%=list.get(i).getNo() %>&mode=0&b_no=<%=b_no %>" class="btn btn--small--light">거부</a>
                                </span>
                                <%} %>
                            </div>
                        </li>
                        <%} %>
                    </ul>
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>