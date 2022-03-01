<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="false" />
    <div id="app">
        <main id="main">
            <section class="section account account-find">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        아이디/비밀번호 찾기
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:history.back()" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <div class="section__content__top">
                        <h1 class="logo"><img src="${pageContext.request.contextPath}/images/icon_logo.svg" alt="DESO"></h1>
                    </div>
                    <div class="account__form">
                        <form class="form" action="../member/pwChenage" method="post" name="memberPwChenage">
                            <fieldset class="field">
                                <label for="uPwd" class="hidden">비밀번호</label>
                                <input type="password" name="uPwd" id="uPwd" class="bd pwd-new" placeholder="비밀번호" required>
                                <em class="field__subs info">영문, 숫자 조합으로 8자 이상</em>
                                <em class="field__subs warn hidden">비밀번호는 영문, 숫자 조합으로 8자 이상으로 입력해 주십시오.</em>
                            </fieldset>
                            <fieldset class="field">
                                <label for="uPwdCf" class="hidden">비밀번호 확인</label>
                                <input type="password" name="uPwdCf" id="uPwdCf" class="bd pwd-confirm" placeholder="비밀번호 확인" required>
                                <em class="field__subs warn warn01 hidden">비밀번호가 일치하지 않습니다.</em>
                                <em class="field__subs warn warn02 hidden">새 비밀번호를 먼저 입력해 주세요.</em>
                                 <input type="hidden" id="pwFl" value="n">
                            </fieldset>
                            <button type="button" onclick="pwChenage()" class="btn--submit btn__full">확인</button>
                        </form>
                    </div> 
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script>
        (function(d){
            function checkPwdFn(inputPwds){
                inputPwds.forEach(pwd => {
                    pwd.addEventListener('change', function(e){
                        if(e.target.classList.contains('pwd-confirm')){
                            checkSame(e.target);
                        } else {
                            checkString(e.target);
                            let confirm = e.target.closest('form').querySelector('.pwd-confirm');
                            if(confirm.value.length > 0) checkSame(confirm);
                        }
                    });
                });
    
                function checkString(pwd) {
                    const pwdRegExp = /^(?=.*?[0-9])(?=.*?[a-zA-Z]).{8,}$/;
                    if(!pwdRegExp.test(pwd.value)) {
                        pwd.closest('fieldset').querySelector('.info').classList.add('hidden');
                        pwd.closest('fieldset').querySelector('.warn').classList.remove('hidden');
                    } else {
                        pwd.closest('fieldset').querySelector('.info').classList.remove('hidden');
                        pwd.closest('fieldset').querySelector('.warn').classList.add('hidden');
                    }
                    
                };
    
                function checkSame(pwd){
                    const firstPwd = d.querySelector('.pwd-new');
                    if(firstPwd.value.length <= 0){
                        pwd.closest('fieldset').querySelector('.warn01').classList.add('hidden');
                        pwd.closest('fieldset').querySelector('.warn02').classList.remove('hidden');
                        document.getElementById("pwFl").value = "n";
                    } else if( firstPwd.value.length > 0 && firstPwd.value !== pwd.value) {
                        pwd.closest('fieldset').querySelector('.warn02').classList.add('hidden');
                        pwd.closest('fieldset').querySelector('.warn01').classList.remove('hidden');
                        document.getElementById("pwFl").value = "n";
                    } else if ( firstPwd.value.length > 0 && firstPwd.value == pwd.value ) {
                        pwd.closest('fieldset').querySelector('.warn02').classList.add('hidden');
                        pwd.closest('fieldset').querySelector('.warn01').classList.add('hidden');
                        document.getElementById("pwFl").value = "y";
                    }
                }
            };
            const inputPwds = d.querySelectorAll('input[type="password"]');
            if(inputPwds.length > 0) checkPwdFn(inputPwds);
        })(document);
        
        
        function pwChenage() {
        	const pw = document.getElementById("pwFl").value;
        	if(pw === "y"){    		
	        	memberPwChenage.submit();
        	}else {
        		toast('error',"비밀번호를 확인해주세요.");
        		document.getElementById("uPwd").focus();
        	}
        }
    </script>
</body>
</html>