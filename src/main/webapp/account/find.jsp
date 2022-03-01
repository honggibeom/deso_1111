<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mode = (String)request.getAttribute("mode");
%>
<script src="${pageContext.request.contextPath}/admin/js/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<jsp:include page="../header.jsp" flush="false" />
    <div class="layer">
        <div class="modal" data-modal="noId">
            <p class="modal__text">
                가입 내역이 없습니다.
                <br>
                회원가입 후 이용해 주십시오.
            </p>
            <a href="${pageContext.request.contextPath}/joinHome" class="btn--submit">회원가입 바로가기</a>
        </div>
    </div>
    <div id="app">
        <main id="main">
            <section class="section account account-find">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        아이디/비밀번호 찾기
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="${pageContext.request.contextPath}/index" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <div class="section__content__top">
                        <h1 class="logo"><img src="${pageContext.request.contextPath}/images/icon_logo.svg" alt="DESO"></h1>
                    </div>
                    <div class="find">
                        <div class="find__menu">
                            <span class="find__menu__item <%=(mode.equals("id"))? "on":""%>"><a href="${pageContext.request.contextPath}/find?mode=id">아이디 찾기</a></span>
                            <span class="find__menu__item <%=(mode.equals("pw"))? "on":""%>"><a href="${pageContext.request.contextPath}/find?mode=pw">비밀번호 찾기</a></span>
                        </div>
                        <div class="find__contents">
                            <div class="account__form">
                                <form action="find/success" method="post" name="formSend" class="form">
                                	<input type="hidden" value="<%=mode %>" name="mode">
                                	<%if(mode.equals("pw")) {%>
	                                	<fieldset class="field">
	                                        <label for="uId" class="hidden">아이디</label>
	                                        <input type="text" name="uId" id="uId" class="bd" placeholder="아이디" required>
	                                    </fieldset>
                                	<%} %>
                                    <fieldset class="field">
                                        <label for="tel" class="hidden">인증번호</label>
                                        <div class="auth">
                                            <input type="tel" name="uTel" id="uTel" class="bd auth__input" placeholder="가입시 입력한 휴대폰 번호" required>
                                            <button type="button" onclick="phonebtn()" class="auth__btn btn--submit btn--auth">인증요청</button>
                                        </div>
                                    </fieldset>

                                    <fieldset class="field">
                                        <label for="authNum" class="hidden">인증하기</label>
                                        <div class="auth">
                                            <input type="text" name="authNum" id="authNum" class="bd auth__input" placeholder="인증번호 입력" required>
                                            <button type="button" onclick="phoneResult()" id="btn" class="auth__btn btn--submit btn--auth" disabled>인증하기</button>
                                            <input type="hidden" id="phoneFl" value="n">
                                        </div>
                                    </fieldset>
                                	<button type="button" onclick="findSubmit()" class="btn--submit btn__full">확인</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/js/phone.js"></script>
    <script>
    	function phonebtn(){
    		phone();
    		document.getElementById("btn").disabled = false;
    	}
    	
    	function findSubmit(){
    		const p = document.getElementById("phoneFl").value;
    		if(p === "y"){
    			formSend.submit();
    		}else {
    			toast('error',"핸드폰 인증해주세요.");
    		}
    		
    	}
    </script>
</body>
</html>