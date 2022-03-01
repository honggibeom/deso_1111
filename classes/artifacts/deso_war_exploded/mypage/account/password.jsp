<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../../header.jsp" flush="false" />
    <div id="app">
        <main id="main">
            <section class="section mypage mypage-myaccount">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">비밀번호 수정</h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:history.back();" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content edit btm-xl">
                    <h3 class="edit__title">비밀번호</h3>
                    <form action="./password/process" method="post" class="edit__contents" id="pwdForm" name="form">
                        <fieldset class="field edit__item">
                            <label for="pwd" class="edit__item__desc">기존 비밀번호를 입력하세요.</label>
                            <input type="password" name="pwd" id="pwd" class="bg" placeholder="기존 비밀번호 입력" required> 
                        </fieldset>
                        <fieldset class="field edit__item">
                            <label for="pwdNew" class="edit__item__desc">새로운 비밀번호를 입력하세요.</label>
                            <input type="password" name="pwdNew" id="pwdNew" class="bg pwd-new" placeholder="새로운 비밀번호 입력" required> 
                            <em class="field__subs info">영문, 숫자 조합으로 8자 이상</em>
                            <em class="field__subs warn hidden">비밀번호는 영문, 숫자 조합으로 8자 이상으로 입력해 주십시오.</em>
                        </fieldset>
                        <fieldset class="field edit__item edit__item__newpwd">
                            <input type="password" name="pwdCf" id="pwdCf" class="bg pwd-confirm" placeholder="비밀번호 확인" required>
                            <input type="hidden" id="pwFl" value="n"> 
                            <em class="field__subs warn warn01 hidden">비밀번호가 일치하지 않습니다.</em>
                            <em class="field__subs warn warn02 hidden">새 비밀번호를 먼저 입력해 주세요.</em>
                        </fieldset>
                    </form>
                </div>
            </section>
            <div class="actions">
                <button type="button" onclick="pwBtn()" class="actions__submit" form="pwdForm">확인</button>
            </div>
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
                    } else if( firstPwd.value.length > 0 && firstPwd.value !== pwd.value) {
                        pwd.closest('fieldset').querySelector('.warn02').classList.add('hidden');
                        pwd.closest('fieldset').querySelector('.warn01').classList.remove('hidden');
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
        
        function pwBtn(){
        	const pwFl = document.getElementById("pwFl").value; 
        	(pwFl === "y")?form.submit() : toast('error',"비밀번호를 확인해주세요.")	
        }
    </script>
</body>
</html>