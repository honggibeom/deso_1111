<%@page import="dto.notice.Notice"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.allim.Allim"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
List<Notice> list = (ArrayList)request.getAttribute("list");
SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
%>
<jsp:include page="../header.jsp" flush="false" />
    <div id="app">
        <main id="main">
            <section class="section mypage mypage-list">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        알림
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:history.back();" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content board" style="height: 100%;">
                	<%if(list.size() > 0 ){ %>
                    <ul class="board__list">
                        <%for(int i=0; i<list.size(); i++){ %>
                    		<%if(list.get(i).getN_state()){ %>          
		                    	<li class="board__list__item">
		                            <a href="${pageContext.request.contextPath}/notice/detail?no=<%=list.get(i).getN_no() %>" class="wrap">                            
		                                <span class="title accent">[중요] <%=list.get(i).getN_title() %></span>
		                                <em class="date"><%=date.format(list.get(i).getRegDt())%></em>
		                            </a>
		                        </li>
                        	<%} %>   		
                    	<%} %>
                    	<%for(int i=0; i<list.size(); i++){ %>  
	                    	<%if(!list.get(i).getN_state()){ %>              
		                    	<li class="board__list__item">
		                            <a href="${pageContext.request.contextPath}/notice/detail?no=<%=list.get(i).getN_no() %>" class="wrap"> 
		                                <span class="title">[공지] <%=list.get(i).getN_title() %></span>
		                                <em class="date"><%=date.format(list.get(i).getRegDt())%></em>
		                            </a>
		                        </li>   
	                        <%} %>		
                    	<%} %>
                    </ul>
                    <%}else { %>
                    <div style="width: 100%; height: 100%; background: #fcfcfc; text-align: center; padding-top: 5rem;">
                    	<p style="color: rgba(0,0,0,0.5); font-size: 12px;">알림없음</p>
                    </div>
                    <%} %>
                </div>
            </section>
        </main>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
<jsp:include page="../main/footer.jsp" flush="false" />