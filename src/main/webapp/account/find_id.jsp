<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String id = (String)request.getAttribute("id");
%>
<jsp:include page="../header.jsp" flush="false" />
    <div id="app">
        <main id="main">
            <section class="section account account-find">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        아이디/비밀번호 찾기
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:history.back()" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <div class="section__content__top">
                        <h1 class="logo"><img src="${pageContext.request.contextPath}/images/icon_logo.svg" alt="DESO"></h1>
                    </div>
                    <div class="account__form">
                        <div class="find__success">
                            <span>가입하신 아이디</span>
                            <span class="value"><%=id %></span>
                        </div>
                        <a href="${pageContext.request.contextPath}/index" class="btn--submit btn__full">로그인하러 가기</a>
                    </div>
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>