<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.notice.Notice"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Notice notice = (Notice)request.getAttribute("notice");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
%>
<jsp:include page="../header.jsp" flush="false" />
<body>
    <div id="app">
        <main id="main">
            <section class="section service service-notice">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        공지사항
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:history.back()" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content board">
                    <div class="board__detail">
                        <div class="board__detail__title <%=(notice.getN_state())?"accent":""%>">
                        	<h3><%=notice.getN_title() %></h3>
                        	<span class="date"><%=date.format(notice.getRegDt())%></span>
                        </div>
                        <p class="board__detail__content">
                           <%=notice.getN_content() %>
                        </p>
                    </div>
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>