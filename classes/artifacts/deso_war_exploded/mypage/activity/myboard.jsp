<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.board.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<Board> b = (ArrayList)request.getAttribute("list");
	String title = (String)request.getAttribute("title");
	SimpleDateFormat date = new SimpleDateFormat("MM-dd HH:mm");
	String referer = (String)request.getAttribute("referer");
	String mk = (title.equals("참여중인 행사"))?"event":"meet";
%>
<jsp:include page="../../header.jsp" flush="false" />
    <div id="app">
        <main id="main">
            <section class="section mypage mypage-list">
                <div class="section__top fixed">
                    <h2 class="section__top__title center"><%=title %></h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="${pageContext.request.contextPath}/mypage" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <div class="card__list">
                    	<%if(b != null && b.size() > 0 ){ %>
	                    	<%for(int i=0; i<b.size(); i++){ %>
	                        <div class="card">
	                            <a href="${pageContext.request.contextPath}/board/view?no=<%=b.get(i).getB_no() %>&referer=<%=referer%>" class="wrap">
	                                <ul class="card__info">
	                                    <li class="card__info__category"><%=b.get(i).getB_category() %></li>
	                                    <li class="card__info__detail">
	                                        <span class="addr"><%=(b.get(i).getB_deadline_fl())?"모임완료":b.get(i).getB_address_sub() %></span>
	                                        <span class="date"> <%=date.format(b.get(i).getB_time()) %></span>
	                                    </li>
	                                    <li class="card__info__title"><%=b.get(i).getB_title() %></li>
	                                    <li class="card__info__join"><%=b.get(i).getB_p_count() %>/<%=b.get(i).getB_p_limit()%></li>
	                                </ul>
	                                <div class="card__thumbnail">
	                                    <img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/<%=mk %>/mno<%=b.get(i).getB_m_no()%>/<%=b.get(i).getB_img1()%>" alt="썸네일">
	                                </div>
	                            </a>
	                        </div>
	                		<%} %>
                		<%}else{ %>
	                		<div class="card">
	                			<p><%=title %>이 없습니다.</p>
	                		</div>
                		<%} %>
                    </div>
                </div>
            </section>
        </main>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
<jsp:include page="../../main/footer.jsp" flush="false" />
