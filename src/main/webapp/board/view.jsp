<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.comment.Comment"%>
<%@page import="dto.attend.Attend"%>
<%@page import="dto.member.Member"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member member = (Member)session.getAttribute("member");
	Board b = (Board)request.getAttribute("board");
	Member m = (Member)request.getAttribute("member");
	List<Attend> a = (ArrayList)request.getAttribute("attend");
	List<Comment> c = (ArrayList)request.getAttribute("comment");
	Boolean attendFl = (Boolean)request.getAttribute("attendFl");
	Boolean state = (Boolean)request.getAttribute("state");
	SimpleDateFormat date = new SimpleDateFormat("MM-dd HH:mm");
	SimpleDateFormat date2 = new SimpleDateFormat("yyyy-MM-dd");
	String appkey = "7d0d7e9b25dde7e8b3361e0a303ccd3a";
	String referer = (session.getAttribute("referer") != null)?(String)session.getAttribute("referer"):null;
	
	Long bmno = (b.getB_m_no() != null)?b.getB_m_no():0L;
	String mk = (b.getB_kind().equals("모임"))?"meet":"event";

%>
<jsp:include page="../header.jsp" flush="false" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vendor/swiper-bundle.min.css">
<script src="${pageContext.request.contextPath}/js/vendor/swiper-bundle.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=<%=appkey %>&libraries=services"></script>
    <div class="layer">
        <div class="modal social" data-modal="social">
            <h5 class="modal__title">공유하기</h5>
            <div class="modal__cont">
               <div class="sns" style="justify-content: center !important;">
                    <button onclick="facebook()" class="sns__item" style="margin: 0 !important;">
                        <object data="${pageContext.request.contextPath}/images/icon_sns_facebook.svg" type="image/svg+xml" style="pointer-events: none; z-index:-1;"></object> 
                        <span>페이스북</span>
                    </button>
                </div>
                <div class="copy">
                    <input class="copy__txt" type="text" id="copy_url"  readonly>
                    <button class="copy__btn" onclick="copyText(this);" type="button">복사</button>
                    <script>
                    	window.addEventListener('load',() => {
                    		var filter = "win16|win32|win64|mac";

                    		if(navigator.platform){
                    			if(0 > filter.indexOf(navigator.platform.toLowerCase())){
                    				document.getElementById("copy_url").value = "https://play.google.com/store/apps/details?id=com.idenit.desoadmin";
                    			}else{
                    				document.getElementById("copy_url").value = window.location.href;
                    			}
                    		};
                    	})
                    </script>
                </div>
            </div>
        </div>
    </div>
    <div id="app">
        <main id="main" class="meet">
            <section class="section meet meet-detail">
                <div class="section__top fixed fixed">
                    <h2 class="section__top__title center"><%=b.getB_kind() %></h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="${pageContext.request.contextPath}/<%=referer %>" class="menu__group__prev"></a>
                            <a href="javascript:void(0)" class="menu__group__more depthControll"><i class="dot"></i></a>
                        </div>
                        <ul class="menu__depth depthMenu">
                            <li><a href="#" class="icon icon--share modalControll" data-modal="social">공유 하기</a></li>
                            <%if(member != null && (b.getB_m_no() == member.getM_no() && b.getB_kind().equals("모임"))){ %>
							<li><a href="${pageContext.request.contextPath}/board/action?no=<%=b.getB_no() %>&mode=mod&referer=board/view?no=<%=b.getB_no() %>" class="icon icon--folder">수정하기</a></li>
                            <%} else {%>
                            <li><a href="${pageContext.request.contextPath}/report/page?mode=<%=b.getB_kind() %>&no=<%=b.getB_no() %>&title=<%=b.getB_title() %>" class="icon icon--tel">신고하기</a></li>
                            <%} %>
                        </ul>
                    </div>
                </div>
                <div class="section__content btm-l">
                    <div class="cardL">
                        <div class="wrap">
                        <div class="cardL__slider swiper">
                                <ul class="cardL__slider__wrap swiper-wrapper">
                                	<%if(b.getB_img1() != null && !b.getB_img1().equals("") && !b.getB_img1().equals("null")){ %>
                                    <li class="cardL__slider__slide swiper-slide">
                                        <img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/<%=mk %>/mno<%=bmno%>/<%=b.getB_img1()%>" >
                                    </li>
                                    <%} %>
                                    <%if(b.getB_img2() != null && !b.getB_img2().equals("") && !b.getB_img2().equals("null")){ %>
                                    <li class="cardL__slider__slide swiper-slide">
                                        <img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/<%=mk %>/mno<%=bmno%>/<%=b.getB_img2()%>" >
                                    </li>
                                    <%} %>
                                    <%if(b.getB_img3() != null && !b.getB_img3().equals("") && !b.getB_img3().equals("null")){ %>
                                    <li class="cardL__slider__slide swiper-slide">
                                        <img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/<%=mk %>/mno<%=bmno%>/<%=b.getB_img3()%>" >
                                    </li>
                                    <%} %>
                                    <%if(b.getB_img4() != null && !b.getB_img4().equals("") && !b.getB_img4().equals("null")){ %>
                                    <li class="cardL__slider__slide swiper-slide">
                                        <img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/<%=mk %>/mno<%=bmno%>/<%=b.getB_img4()%>" >
                                    </li>
                                    <%} %>
                                </ul>
                            </div>
                            <ul class="cardL__info">
                                <li class="cardL__info__category"><%=b.getB_category() %></li>
                                <li class="cardL__info__title"><%=b.getB_title() %></li>
                                <li class="cardL__info__day"><%=date.format(b.getB_time()) %></li>
                                <li class="cardL__info__location"><%=b.getB_address() %> <%=b.getB_address_sub() %></li>
                                <li class="cardL__info__join"><%=b.getB_p_count() %>/<%=b.getB_p_limit()%></li>
                            </ul>
                        </div>
                    </div>
                    <div class="details">
                    	<%if(b.getB_kind().equals("모임") && m != null ){ %>
                        <div class="details__item host">
                            <div class="details__item__content hostcard">
                               <div class="wrap">
                               		<a href="${pageContext.request.contextPath}/friend?no=<%=m.getM_no() %>">
	                                    <div class="hostcard__thumbnail">
	                                    	<%if(m.getM_img1() != null && !m.getM_img1().equals("")){ %>
			                               	<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=m.getM_no() %>/<%=m.getM_img1() %>">
			                               	<%}else { %>
			                               	<img src="${pageContext.request.contextPath}/images/member_profile.jpg">
			                               	<%} %>
	                                    </div>
	                                    <ul class="hostcard__info">
	                                        <li class="hostcard__info__title">주최자 소개</li>
	                                        <li class="hostcard__info__name"><%=m.getM_name() %></li>
	                                        <li class="hostcard__info__date">모임생성일자 : <span class="value"><%=date.format(b.getRegDt()) %></span></li>
	                                    </ul>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="details__item">
                            <div class="details__item__title">
                                <h3>오픈채팅방</h3>
                            </div>
                            <div class="details__item__chat"> 
                                <div class="blind">
                                    <%if((member != null)){%>
	                                    <%if(((attendFl && state) && (!b.getB_deadline_fl())) || (b.getB_m_no() == member.getM_no())){ %>
	                                    	<span class="link"><a href="<%=b.getB_open_chatting_url()%>"><%=b.getB_open_chatting_url() %></a></span>
	                                   	<%}else { %>
											<span class="inform">참여중인 회원만 볼 수 있습니다.</span>
										<%} %>
									<%}else { %>
									<span class="inform">참여중인 회원만 볼 수 있습니다.</span>
									<%} %>
                                </div>
                            </div>
                        </div>
                        <%} %>
                        <hr class="divider divider--gray04 divider--gap">
                        <div class="details__item">
                            <%if(member != null){%>
	                            <%if(((attendFl && state) && (!b.getB_deadline_fl())) || (b.getB_m_no() == member.getM_no())){ %>
	                            <div class="details__item__title">
	                                <h3>참석자<em class="joins__cnt">(<%=b.getB_p_count() %>)</em></h3>
	                                <a href="${pageContext.request.contextPath}/board/attend/list?no=<%=b.getB_no() %>&state=1" class="joins__more">모두보기</a>
	                            </div>
	                            <ul class="details__item__members member__list--row">
	                            	<%for(int i=0; i<a.size(); i++){ %>
	                            		<%if(a.get(i).getKind()){ %>
		                                <li class="member">
		                                    <div class="member__link">
		                                    	<a href="${pageContext.request.contextPath}/friend?no=<%=a.get(i).getM_no() %>">
			                                        <span class="member__thumb">
			                                        	<%if(a.get(i).getM_img() != null && !a.get(i).getM_img().equals("")){ %>
						                               	<img style="width:100%; border-radius:50%;" src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=a.get(i).getM_no() %>/<%=a.get(i).getM_img() %>">
						                               	<%}else { %>
						                               	<img style="width:100%; border-radius:50%;" src="${pageContext.request.contextPath}/images/member_profile.jpg">
						                               	<%} %>
			                                        </span>
			                                        <span class="member__name"><%=a.get(i).getM_name() %></span>
		                                        </a>
		                                    </div>
		                                </li>
	                                	<%} %>	
	                                <%} %>
	                            </ul>
	                            <%}else { %>
	                            <div class="details__item__title">
	                                <h3>참석자</h3>
	                            </div>
	                            <div class="details__item__members"> 
	                                <div class="blind">
										<span class="inform">참여중인 회원만 볼 수 있습니다.</span>
	                                </div>
	                            </div>
								<%} %>
							<%}else { %>
                            <div class="details__item__title">
                                <h3>참석자</h3>
                            </div>
                            <div class="details__item__members"> 
                                <div class="blind">
									<span class="inform">참여중인 회원만 볼 수 있습니다.</span>
                                </div>
                            </div>
							<%} %>
                        </div>
                        <%if((member != null) && (b.getB_m_no() == member.getM_no())){ %>
                        <hr class="divider divider--gray04 divider--gap">
                        <div class="details__item">
                            <div class="details__item__title">
                                <h3>대기자<em class="joins__cnt">(<%=b.getB_p_w_count() %>)</em></h3>
                                <a href="${pageContext.request.contextPath}/board/attend/list?no=<%=b.getB_no() %>&state=0" class="joins__more">모두보기</a>
                            </div>
                            <ul class="details__item__members">
                            	<%for(int i=0; i<a.size(); i++){ %>
	                            	<%if(!a.get(i).getKind()){ %>
	                                <li class="member">
	                                    <div class="member__link">
	                                    	<a href="${pageContext.request.contextPath}/friend?no=<%=a.get(i).getM_no() %>">
		                                        <span class="member__thumb">
		                                        	<%if(a.get(i).getM_img() != null && !a.get(i).getM_img().equals("")){ %>
					                               	<img style="width:100%; border-radius:50%;" src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=a.get(i).getM_no() %>/<%=a.get(i).getM_img() %>">
					                               	<%}else { %>
					                               	<img style="width:100%; border-radius:50%;" src="${pageContext.request.contextPath}/images/member_profile.jpg">
					                               	<%} %>
		                                        </span>
		                                        <span class="member__name"><%=a.get(i).getM_name() %></span>
	                                        </a>
	                                    </div>
	                                </li>
	                                <%} %>
                   				<%} %>
                            </ul>
                        </div>
                        <%} %>
                        <hr class="divider divider--gray04 divider--gap">
                        <div class="details__item event">
                            <div class="details__item__title"><h3 class="light"><%=(b.getB_kind().equals("모임"))?"모임 소개":"행사 소개"%></h3></div>
                            <p class="details__item__desc gap">
                                <%=b.getB_content() %>
                            </p>
                        </div>
                        <div class="details__item event">
                            <div class="details__item__title"><h3 class="light"><%=(b.getB_kind().equals("모임"))?"모임 규칙":"행사 규칙"%></h3></div>
                            <p class="details__item__desc"><%=b.getB_rule() %></p>
                        </div>
                        <hr class="divider divider--gray04 divider--gap">
                        <div class="details__item">
                            <div class="details__item__title"><h3>위치</h3></div>
                            <div class="details__item__location">
                                <span class="text"><%=b.getB_address() %> <%=b.getB_address_sub() %></span>
                                <div class="map map--block">
                                	<div id="map" style="width: 90%; height: 200px; margin:0 auto; border-radius: 10px;"></div>
                                </div>
                            </div>
                        </div>
                        <hr class="divider divider--gray04 divider--gap">
                        <div class="details__item__replies replies">
                        	<%if(member != null){%>
	                        	<%if(((attendFl && state) && (!b.getB_deadline_fl())) || (b.getB_m_no() == member.getM_no())){ %>
	                        	<div class="replies__top">
	                                <h3 class="replies__top__title">댓글<em class="replies__top__cnt"><%=c.size() %>개</em></h3>
	                            </div>
	                            <div class="replies__list">
	                            	<%for(int i=0; i<c.size(); i++){ %>
		                            	<%if(!c.get(i).getC_parentFl()){ %>
			                                <div class="reply">
			                                	<a href="${pageContext.request.contextPath}/friend?no=<%=c.get(i).getC_m_no() %>">
				                                    <span class="reply__thumb">
				                                    	<%if(c.get(i).getC_img() != null && !c.get(i).getC_img().equals("")){ %>
						                               	<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=c.get(i).getC_m_no() %>/<%=c.get(i).getC_img() %>">
						                               	<%}else { %>
						                               	<img src="${pageContext.request.contextPath}/images/member_profile.jpg">
						                               	<%} %>
				                                    </span>
			                                    </a>
			                                    <ul class="reply__cont">
			                                        <li class="reply__cont__name"><%=c.get(i).getC_name() %></li>
			                                        <li class="reply__cont__text"><%=c.get(i).getC_content() %></li>
			                                        <li class="reply__cont__detail">
			                                       		<span class="date"><%=date2.format(c.get(i).getRegDt()) %></span>
			                                       		<%if(c.get(i).getComment().size() > 0){ %>
			                                       		<span class="date"><a href="./comment/list?no=<%=b.getB_no() %>&mno=<%=b.getB_m_no()%>"> -답글 <%=c.get(i).getComment().size()%>개 보기</a></span>
			                                       		<%} %>
			                                        </li>
			                                    </ul>
			                                </div>
		                                <%} %>
	                                <%} %>
	                                <div class="more"><a href="./comment/list?no=<%=b.getB_no() %>&mno=<%=b.getB_m_no()%>">More</a></div>
	                            </div>
	                            <%} else { %>
	                            <div class="replies__top">
	                                <h3 class="replies__top__title">댓글</h3>
	                            </div>
	                            <div class="blind"> 
	                                <span class="inform">참여중인 회원만 볼 수 있습니다.</span>
	                            </div>                            
	                            <%} %>
                            <%} else { %>
                            <div class="replies__top">
                                <h3 class="replies__top__title">댓글</h3>
                            </div>
                            <div class="blind"> 
                                <span class="inform">참여중인 회원만 볼 수 있습니다.</span>
                            </div>                            
                            <%} %>
                        </div>
                    </div>
                </div>
                <div class="actions">
                	<%if(member == null){ %>
                	<a href="../index" class="actions__submit">회원전용페이지입니다.</a>
                	
                	<%}else if((member != null) && (b.getB_m_no() == member.getM_no() && !b.getB_deadline_fl())){ %>
                	<a href="./deadline?no=<%=b.getB_no() %>" class="actions__submit">모임 완료</a>
                	                    
                    <%}else if((member != null) && (b.getB_m_no() == member.getM_no() && b.getB_deadline_fl())){%>
                    <a onclick="b_del()" class="actions__submit">모임 마감</a>
                    
                	<%}else if((member != null) && (b.getB_m_no() != member.getM_no() && b.getB_deadline_fl())){%>
                    <span class="actions__submit">모임완료된 게시판입니다.</span>
                    
                    
					<%}else if(attendFl && !state){%>
                    <a href="./attend?attend=0&no=<%=b.getB_no() %>&kind=<%=b.getB_kind() %>" class="actions__submit">대기 취소</a>
                    
                    <%}else if(attendFl && state){%>
                    <a href="./attend?attend=1&no=<%=b.getB_no() %>&kind=<%=b.getB_kind() %>" class="actions__submit">참여 취소</a>
                    
					<%}else { %>
                    <a href="./attend?attend=2&no=<%=b.getB_no() %>&kind=<%=b.getB_kind() %>" class="actions__submit">참여하기</a>
					<%} %>                   
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/js/kakaoShare.js"></script>
    <script src="${pageContext.request.contextPath}/js/facebookShare.js"></script>
   	<script>  	
   		function b_del(){
   			Swal.fire({
                title: '마감처리하시면 게시판이 삭제됩니다.',
                text: "마감하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '승인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                	location.href="./del?no=<%=b.getB_no() %>"
                }
            })
   		}
   	
   	
        var imageSlider = new Swiper('.cardL__slider');
        function copyText(btn){
            var textToCopy = btn.closest('.copy').querySelector('.copy__txt');
            textToCopy.select();
            document.execCommand('copy');
            toast("success","복사되었습니다.");
        };
        
        
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(<%=b.getB_address_X()%>, <%=b.getB_address_Y()%>), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };  

	    // 지도를 생성합니다    
	    var map = new kakao.maps.Map(mapContainer, mapOption); 
        // 마우스 드래그로 지도 이동 가능여부를 설정합니다
	    map.setDraggable(false)
	    	
 	    
        // 마커를 생성하고 지도에 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(<%=b.getB_address_X()%>, <%=b.getB_address_Y()%>) 
        });
	    
    </script>
</body>
</html>