<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.notice.Notice"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<Notice> list = (ArrayList)request.getAttribute("list");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
%>
<jsp:include page="../header.jsp" flush="false" />
    <div id="app">
        <main id="main">
            <section class="section service service-notice">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        공지사항
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:history.back();" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content board">
                    <div class="section__content__top">
                        <h1>공지사항</h1>
                        <p class="title">DESO에서 전하는 새로운 소식</p>
                    </div>
                    <ul class="board__list">
                    	<%for(int i=0; i<list.size(); i++){ %>
                    		<%if(list.get(i).getN_state()){ %>          
		                    	<li class="board__list__item">
		                            <a href="./detail?no=<%=list.get(i).getN_no() %>" class="wrap">                            
		                                <span class="title accent">[중요] <%=list.get(i).getN_title() %></span>
		                                <em class="date"><%=date.format(list.get(i).getRegDt())%></em>
		                            </a>
		                        </li>
                        	<%} %>   		
                    	<%} %>
                    	<%for(int i=0; i<list.size(); i++){ %>  
	                    	<%if(!list.get(i).getN_state()){ %>              
		                    	<li class="board__list__item">
		                            <a href="./detail?no=<%=list.get(i).getN_no() %>" class="wrap"> 
		                                <span class="title">[공지] <%=list.get(i).getN_title() %></span>
		                                <em class="date"><%=date.format(list.get(i).getRegDt())%></em>
		                            </a>
		                        </li>   
	                        <%} %>		
                    	<%} %>
                    </ul>
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>