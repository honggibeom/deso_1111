<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="false" />
<script src="${pageContext.request.contextPath}/admin/js/jquery-3.6.0.min.js"></script>
    <div class="layer">
        <div class="modal" data-modal="noAuth">
            <h5 class="modal__title">학교 인증</h5>
            <p class="modal__text">
                인증안하시면 서비스를 정상적으로 이용하실수 없습니다.
            </p>
            <div class="modal__btns">
                <a href="./student/cancel" class="btn btn--cancel">다음에 하기</a>
                <button type="button" class="btn btn--submit modalClose">인증 하기</button>
            </div>
        </div>
        <div class="modal" data-modal="authSuccess">
            <h5 class="modal__title">인증 신청 완료</h5>
            <p class="modal__text">
                인증확인 검토후 승인이 완료 됩니다.
            </p>
            <a href="./login.jsp" class="btn btn--submit">확인</a>
        </div>
    </div>
    <div id="app">
        <main id="main">
            <section class="section account account-auth">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        대학생 인증
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="/member/student/cancel" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <div class="section__content__top">
                        <h1 class="logo"><img src="${pageContext.request.contextPath}/images/icon_logo.svg" alt="DESO"></h1>
                        <p class="desc">
                            대학생들만 DESO 서비스를 이용할 수 있습니다.
                            <br>
                            재학중인 대학교 이메일을 입력해 주세요.
                        </p>
                    </div>
                    <div class="account__form">
                        <form class="form" action="./student/confirm" method="post" name="action">
                        	<input type="hidden" id="emailFl" value="n">
                            <div class="field is-stepPwd">
                                <label for="mail" class="hidden">인증번호</label>
                                <div class="auth">
                                    <input type="email" name="mail" id="mail" class="bd auth__input" placeholder="대학교 이메일" required>
                                    <button type="button" onclick="email()" id="studentBtn1" class="auth__btn btn--submit btn--auth">인증요청</button>
                                </div>
                            </div>
                            <div class="field is-stepPwd">
                                <label for="authNum" class="hidden">인증하기</label>
                                <div class="auth">
                                    <input type="text" name="authNum" id="authNum" class="bd auth__input" placeholder="인증번호 입력" disabled required>
                                    <button type="button" onclick="emailConfig()" id="studentBtn2" class="auth__btn btn--submit btn--auth" disabled>인증하기</button>
                                </div>
                            </div>
                            <button type="button" onclick="config()" class="btn--submit btn__full">대학생 회원 인증</button>
                        </form>
                        <button type="button" class="link__login modalControll" data-modal="noAuth">다음에 인증하기</button>
                    </div>
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/email.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script>
    	function config(){
    		const en = document.getElementById("emailFl").value;
    		if(en === "y"){
    			action.submit();
    		}else {
    			toast('error',"대학교 인증을 받아주세요.");
    		}
    	}
    </script>
</body>
</html>