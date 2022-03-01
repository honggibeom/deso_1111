<%@page import="dto.information.Information"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<Information> list = (ArrayList)request.getAttribute("list");
	String title = (request.getAttribute("title") != null)?(String)request.getAttribute("title"):"이용약관";
%>
<jsp:include page="../../header.jsp" flush="false" />

    <div id="app">
        <main id="main">
            <section class="section service service-terms">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        이용 약관
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:history.back()" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content terms">
                    <div class="tab">
                        <div class="tab__navs">
                            <div>
                                <span><a href="terms?title=이용약관" class="tab__navs__nav <%=((title == null) || (title != null && title.equals("이용약관")))? "on": ""%>">이용약관</a></span>
                                <span><a href="terms?title=개인정보처리방침" class="tab__navs__nav <%=(title != null && title.equals("개인정보처리방침"))? "on": ""%>">개인정보처리방침</a></span>
                               <!-- <span><a href="terms?title=위치기반서비스" class="tab__navs__nav gps <%=(title != null && title.equals("위치기반서비스"))? "on": ""%>">위치기반서비스 이용약관 </a></span>-->
                            </div>
                        </div>
                        <div class="tab__contents">
                            <div class="tab__contents__cont on">
                            	<textarea style="min-height: 500px;" rows="20"  class="col-10" readonly="readonly"><% for(int i=0; i<list.size(); i++){%><% if(list.get(i).getI_title().equals(title)){ %><%=list.get(i).getI_content() %><%}%><%}%></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
<jsp:include page="../../main/footer.jsp" flush="false" />