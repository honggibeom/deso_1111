<%@page import="dto.member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member m = (Member)session.getAttribute("member");
%>
<jsp:include page="../../header.jsp" flush="false" />
<div class="layer">
    <div class="modal" data-modal="unsubs">
    	<form action="${pageContext.request.contextPath}/member/del" method="post" name="form">
    		<h5 class="modal__title">탈퇴하시겠습니까?</h5>
	        <div class="modal__inform">
	        	<textarea id="content" name="del_content" placeholder="탈퇴 시 유의 사항은 아래와 같습니다...... 탈퇴 유의사항 등록 요망"></textarea>
	        </div>
	        <div class="modal__btns">
	            <button type="button" class="btn btn--cancel modalClose">취소</button>
	            <button type="button" onclick="del()" class="btn btn--submit">확인</button>
	        </div>
    	</form>
    	<script>
    		function del() {
    			const content = document.getElementById("content");
    			
    			if(content.value === ""){
    				toast('error',"유의사항을 입력해주세요.");
    				content.focus();
    			}else if(content.value.length < 10){
    				toast('error',"10글자 이상 입력해주세요.");
    				content.focus();
    			}else {
    				form.submit();
    			}   			
    		}
    	</script>
    </div>
</div>
<div id="app">
    <main id="main">
        <section class="section mypage mypage-myaccount">
            <div class="section__top fixed">
                <h2 class="section__top__title center">계정설정</h2>
                <div class="section__top__menu menu">
                    <div class="menu__group">
                        <a href="javascript:history.back();" class="menu__group__prev"></a>
                    </div>
                </div>
            </div>
            <div class="section__content edit">
                <h3 class="edit__title">기본 정보</h3>
                <div class="edit__contents">
                    <div class="field edit__item">
                        <label for="uId" class="edit__item__desc">아이디</label>
                        <input type="text" name="uId" id="uId" class="readonly" value="<%=m.getM_id() %>" readonly>
                    </div>
                    <div class="field edit__item">
                        <label for="uTel" class="edit__item__desc">전화번호</label>
                        <input type="tel" name="uTel" id="uTel" class="readonly" value="<%=m.getM_phone() %>" readonly>   
                    </div>
                    <div class="field edit__item pwd">
                        <label for="uPwd" class="edit__item__desc">비밀번호</label>
                        <input type="password" name="uPwd" id="uPwd" class="bg" value="<%=m.getM_pw() %>" onclick="location.href='./account/password'" style="cursor: pointer;" readonly/>
                        <i class="edit__item__icon"></i>  
                    </div>
                    <div class="edit__item">
                        <a href="${pageContext.request.contextPath}/logout" class="edit__item__link">로그아웃</a>
                    </div>
                    <div class="edit__item">
                        <a href="#" class="edit__item__link modalControll" data-modal="unsubs">계정 탈퇴</a> 
                    </div>
                </div>
            </div>
        </section>
    </main> 
</div>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>