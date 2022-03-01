<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	 Long no = (Long)request.getAttribute("no");
	 String mode = (String)request.getAttribute("mode");
	 String title = (String)request.getAttribute("title");
	 Long rd_m_no = (Long)request.getAttribute("rd_m_no");
	 String rd_m_id = (String)request.getAttribute("rd_m_id");
	 String referer = (String)request.getAttribute("referer");
%>
<style>
	.sub_title{
		margin-bottom: 10px;
		font-size:12px;
	}
</style>
<jsp:include page="../header.jsp" flush="false" />
     <div class="layer">
        <div class="modal" data-modal="report">
            <p class="modal__text">
                신고가 완료되었습니다.
            </p>
            <%if(mode.equals("회원")){ %>
            <a href="${pageContext.request.contextPath}/friend?no=<%=rd_m_no %>" class="btn--submit">확인</a>
            <%} else{ %>
            <a href="${pageContext.request.contextPath}/board/view?no=<%=no %>" class="btn--submit">확인</a>
            <%} %>
        </div>
    </div>
    <div id="app">
        <main id="main">
            <section class="section service service-report">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        <%=mode %> 신고
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group"><a href="<%=referer %>" class="menu__group__prev"></a></div>
                    </div>
                </div>
                <div class="section__content report btm-l">
                    <div class="section__content__top">
                        <h1 class="logo"><img src="${pageContext.request.contextPath}/images/icon_logo_b.svg" alt="DESO"></h1>
                        <p class="title">올바른 행사를 위해 의견을 전달 주세요.</p>
                    </div>
                    <div style="margin-bottom: 10px;">                    
						<div class="selectbox">
                            <input type="text" id="title" value="" class="selectbox__select bg" placeholder="신고유형을 선택해주세요." readonly required/>
                            <ul class="selectbox__option">
                                <li class="selectbox__option__item" data-option="비매너행위">비매너 행위</li>
                                <li class="selectbox__option__item" data-option="스팸성홍보">스팸성 홍보</li>
                                <li class="selectbox__option__item" data-option="불법행위">불법 행위</li>
                                <li class="selectbox__option__item" data-option="사기피해">사기 피해</li>
                                <li class="selectbox__option__item" data-option="정보부정확">정보 부정확</li>
                                <li class="selectbox__option__item" data-option="정보부정확">불쾌한 댓글내용</li>
                                <li class="selectbox__option__item" data-option="기타사유">기타 사유</li>
                            </ul>
                        </div>
                    </div>
                    <div style="margin-bottom: 15px;">
	                    <p class="sub_title">신고내용</p>
	                    <textarea style="text-align: start" id="content" cols="30" rows="10" class="bg" placeholder="예) 너무 욕설이 많아요"></textarea>
                    </div>
                    <div class="sub_title" style="color:rgba(0,0,0,0.7)">
                    	<%if(mode.equals("회원")) {%>
                    	<p>*회원 신고는 관리자에게 접수되며, 접수된 내용은 관리자가 확인 후 신고에 대한 합당한 사유 발견 시 차단 하게 됩니다.</p>
                    	<%}else { %>
                    	<p>*모임 신고는 관리자에게 접수되며, 접수된 내용은 관리자가 확인 후  신고에 대한 합당한 사유 발견 시 모임삭제 및 차단 합니다.</p>
                    	<%} %>
                    </div>
                </div>
                <div class="actions">
                    <button onclick="report()" class="actions__submit modalControll" data-modal="report">신고하기</button>
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/jquery-3.6.0.min.js"></script>
    <script>
    	function report(){
    		const title = document.getElementById("title").value;
    		const content = document.getElementById("content").value;
    		$.ajax({
    			type:"post",
    			url:"./process",
    			data: {
    				title:title,
    				content:content,
    				mode:'<%=mode%>',
    			<%if(mode.equals("회원")){%>
    				rd_id_no:<%=rd_m_no%>,
    				rd_id:'<%=rd_m_id%>'
    			<%}else{ %>
    				rd_board_no:<%=no%>,
    				rd_board_title:'<%=title%>'
    			<%}%>
    			},
    			dateType:"json",
    			success:function(i){
    			
    			},
    			error:function(request,status,error){
    				toast('error',"code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    			}
    			
    		});
    	}
    </script>
</body>
</html>