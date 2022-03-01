<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="dto.banner.Banner"%>
<%@page import="dto.board.Board"%>
<%@page import="dto.member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./header.jsp" flush="false" />
<%
	Member m = (Member)session.getAttribute("member");
	List<Board> meet = (ArrayList)request.getAttribute("meet");
	List<Board> event = (ArrayList)request.getAttribute("event");
	Banner banner = (Banner)request.getAttribute("banner");
	SimpleDateFormat date = new SimpleDateFormat("MM-dd HH:mm");
%>
<main id="main" <%if(m == null || m.getM_state() || !m.getM_studentFl()) {%><%if(!m.getM_joinFl()){ %>class="guest"<%} %><%} %>>
	<section class="section home">
		<div class="section__content btm-m">
			<div class="notice">
				<a href="${pageContext.request.contextPath}/notice/list">[공지] 꼭! 참고해야하는 모임 시 주의 사항 </a>
			</div>
			<div class="banner__area swiper">
				<ul class="banner__list swiper-wrapper">
					<%if(banner != null && banner.getImg1() != null && !banner.getImg1().equals("")){%>
					<li class="swiper-slide banner">
						<a class="wrap">
							<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/banner/<%=banner.getImg1() %>" alt="event" class="banner__img">
						</a>
					</li>
					<%} %>
					<%if(banner != null && banner.getImg2() != null && !banner.getImg2().equals("")){%>
					<li class="swiper-slide banner">
						<a class="wrap">
							<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/banner/<%=banner.getImg2() %>" alt="event" class="banner__img">
						</a>
					</li>
					<%} %>
					<%if(banner != null && banner.getImg3() != null  && !banner.getImg3().equals("")){%>
					<li class="swiper-slide banner">
						<a class="wrap">
							<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/banner/<%=banner.getImg3() %>" alt="event" class="banner__img">
						</a>
					</li>
					<%} %>
				</ul>
			</div>
			<hr class="divider divider--gray04">
			<section class="meet">
				<h2 class="title">DESO 모임</h2>
				<div class="card__list">
					<%for(int i=0; i < meet.size(); i++){ %>
						<div class="card">
							<a href="${pageContext.request.contextPath}/board/view?no=<%=meet.get(i).getB_no() %>&referer=main" class="wrap">
								<ul class="card__info">
									<li class="card__info__category"><%=meet.get(i).getB_category() %></li>
									<li class="card__info__detail"><span class="addr"><%=(meet.get(i).getB_deadline_fl())?"모임완료":meet.get(i).getB_address_sub() %></span>
										<span class="date"><%=date.format(meet.get(i).getB_time()) %></span></li>
									<li class="card__info__title"><%=meet.get(i).getB_title() %></li>
									<li class="card__info__join"><%=meet.get(i).getB_p_count() %>/<%=meet.get(i).getB_p_limit() %></li>
								</ul>
								<div class="card__thumbnail">
									<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/meet/mno<%=meet.get(i).getB_m_no()%>/<%=meet.get(i).getB_img1()%>" alt="모임">
								</div>
							</a>
						</div>
					<%} %>		
				</div>
			</section>
			<hr class="divider divider--gray03">
			<section class="event">
				<h2 class="title">DESO 행사</h2>
				<div class="cardR__list">
					<%for(int i=0; i < event.size(); i++){ %>
						<div class="cardR">
							<a href="${pageContext.request.contextPath}/board/view?no=<%=event.get(i).getB_no() %>&referer=main" class="wrap">
								<div class="cardR__thumbnail">
									<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/event/mno<%=event.get(i).getB_m_no()%>/<%=event.get(i).getB_img1()%>" alt="이벤트">
								</div>
								<ul class="cardR__info">
									<li class="cardR__info__addr"><%=(event.get(i).getB_deadline_fl())?"모임완료":event.get(i).getB_address_sub() %></li>
									<li class="cardR__info__date"><%=date.format(event.get(i).getB_time()) %></li>
									<li class="cardR__info__title"><%=event.get(i).getB_title() %></li>
								</ul>
							</a>
						</div>
					<%} %>
				</div>
			</section>
		</div>
	</section>
</main>
<jsp:include page="./footer.jsp" flush="false" />
<script src="${pageContext.request.contextPath}/js/script.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper.js"></script>