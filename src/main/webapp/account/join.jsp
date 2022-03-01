<%@page import="dto.information.Information"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Information use = (Information)request.getAttribute("use");
	Information privacy = (Information)request.getAttribute("privacy");
	Information gps = (Information)request.getAttribute("gps");

%>
<style>
.tab__contents__cont.on{text-align:start; overflow-y: scroll; height: 100%;}
#scroll_bar {
    -ms-overflow-style: none; /* IE and Edge */
    scrollbar-width: none; /* Firefox */
}
#scroll_bar::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Opera*/
}
</style>
<jsp:include page="../header.jsp" flush="false" />
<script src="${pageContext.request.contextPath}/admin/js/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <div class="layer">
        <div class="modal" data-modal="auth">
            <h5 class="modal__title">회원 가입 완료</h5>
            <p class="modal__text">
                학교를 인증해 주세요.
            </p>
            <a href="${pageContext.request.contextPath}/account/student_auth.jsp" class="btn--submit">인증하러 가기</a>
        </div>
         <div class="modal screen" data-modal="terms">
            <div class="section service service-terms">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        약관
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:void(0)" class="menu__group__prev modalClose"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content terms">
                    <div class="tab">
                        <div class="tab__navs">
                            <div>
                                <span class="tab__navs__nav on" data-tab="use">이용약관</span>
                                <span class="tab__navs__nav" data-tab="privacy">개인정보처리방침</span>
                                <!--<span class="tab__navs__nav gps" data-tab="gps">위치기반서비스 이용약관</span>-->
                            </div>
                        </div>
                        <div class="tab__contents" style="margin:0;">
                            <div class="tab__contents__cont on" data-tab="use">
                                <textarea rows="20"  class="col-10" id="scroll_bar" style="width:100%; padding: 20px 0 60px 0; height: 100%;" readonly="readonly"><%=use.getI_content() %></textarea>
                            </div>
                            <div class="tab__contents__cont" data-tab="privacy">
                            	<textarea rows="20"  class="col-10" id="scroll_bar" style="width:100%; padding: 20px 0 60px 0; height: 100%;" readonly="readonly"><%=privacy.getI_content() %></textarea>
                            </div>
                            <!--<div class="tab__contents__cont" data-tab="gps">
                            	<textarea rows="20"  class="col-10" id="scroll_bar" style="width:100%; padding: 20px 0 60px 0; height: 100%;" readonly="readonly"><%=gps.getI_content() %></textarea>
                            </div>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="app">
        <main id="main">
            <section class="section account account-join">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        회원가입
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="${pageContext.request.contextPath}/home" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <div class="section__content__top">
                        <h1 class="logo"><img src="${pageContext.request.contextPath}/images/icon_logo.svg" alt="DESO"></h1>
                    </div>
                    <div class="account__form join">
                        <form action="member/join" method="post" name="join" class="form">
                            <fieldset class="field">
                            	<div class="auth">
	                                <label for="uId" class="hidden">아이디</label>
	                                <input type="text" name="uId" id="uId" class="bd auth__input" placeholder="아이디" maxlength="10" required>
	                                <button type="button" onclick="idCheck()" class="auth__btn btn--submit btn--auth">중복확인</button>
	                                <input type="hidden" id="idFl" value="n">
                                </div>
                            </fieldset>
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
                            <fieldset class="field">
                                <label for="uNick" class="hidden">닉네임</label>
                                <input type="text" name="uNick" id="uNick" onkeyup="nickname()" class="bd" placeholder="닉네임" required>
                                <input type="hidden" id="nameFl" value="n">
                            </fieldset>
                            <fieldset class="field">
                                <label for="ucol" class="hidden">대학교명, 학과 입력</label>
                                <div class="input bd college">
                                    <span class="input__item"><input type="text" name="ucol" id="ucol" class="input__block" placeholder="서울대학교" required></span>
                                    <span class="input__item"><input type="text" name="study" class="input__block" onkeyup="col()" placeholder="국어국문학과" required></span>
                                </div>
                                <em class="field__subs">대학교 인증 후 계정이 활성화 되므로 정확한 대학교명과 학과를 입력해 주세요.</em>
                                <input type="hidden" id="colFl" value="n">
                            </fieldset>
                            <fieldset class="field">
                                <label for="uYear" class="hidden">생년월일</label>
                                <div class="input bd college">
                                    <span class="input__item"><input type="text" name="year" id="uYear" class="input__block" placeholder="YYYY" maxlength="4" required></span>
                                    <span class="input__item"><input type="text" name="month" id="uMonth" class="input__block" placeholder="MM" maxlength="2"  required></span>
                                    <span class="input__item"><input type="text" name="day" id="uDate" class="input__block" placeholder="DD" maxlength="2" required></span>
                                </div>
                                <em class="field__subs warn birth hidden"></em>
                            </fieldset>
                            <fieldset class="field is-stepPwd">
                                <label for="uTel" class="hidden">인증번호</label>
                                <div class="auth">
                                    <input type="tel" name="uTel" id="uTel" class="bd auth__input" placeholder="휴대폰 번호" required>
                                    <button type="button" onclick="phoneChk()" class="auth__btn btn--submit btn--auth">인증요청</button>
                                </div>
                            </fieldset>
                            <fieldset class="field is-stepPwd">
                                <label for="authNum" class="hidden">인증하기</label>
                                <div class="auth">
                                    <input type="text" name="authNum" id="authNum" class="bd auth__input" placeholder="인증번호 입력" required>
                                    <button type="button" onclick="phoneResult()" class="auth__btn btn--submit btn--auth">인증하기</button>
                                    <input type="hidden" id="phoneFl" value="n">
                                </div>
                            </fieldset>
                            <p class="form__inform">
                            	회원가입 버튼을 클릭하면, 
                            	<a href="javascript:void(0)" class="modalControll" data-modal="terms">이용약관</a> / 
                            	<a href="javascript:void(0)" class="modalControll" data-modal="terms">개인정보처리방침</a>
                            	<!-- <a href="javascript:void(0)" class="modalControll" data-modal="terms">위치기반서비스 이용약관</a>-->
                            	 에 동의하게 됩니다.
                           	</p>
                            <input type="button" class="btn--submit btn__full" onclick="memberJoin()" value="회원가입">
                        </form>
                    </div>
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/js/phone.js"></script>
    <script>      
       	//휴대폰 중복확인
       	function phoneChk(){
       		const tel = document.getElementById("uTel").value;
       		if(tel != "" && tel != null){       			
	       		$.ajax({
	       			type : "POST",
	       			url : "member/join/checkTel",
	       			data : {
	       				"tel" : tel
	       			},
	       			dataType : "json",
	       			success : function(msg){
	       				if(msg === 0){
	       					phone();
	       				}else{	
	       					toast('error','해당 휴대폰 번호는 이미 가입된 내역이 있습니다.');
	       				}	
	       			},
	       			error : function(error){
	       				toast('error',"error:"+error);
	       				
	       			}
	       		});
       		}else{
       			toast('','휴대폰 번호를 입력해주세요.');
       		}
       	}
       	
       	$('#uId').on('keyup', function(event){
       	    if (!(event.keyCode >=37 && event.keyCode<=40)) { 
       	      var inputVal=$(this).val();
       	      $(this).val(inputVal.replace(/[^a-z0-9]/gi,''));  
       	    } 
       	  });
       	
    	//아이디 체크
       	function idCheck(){
       		const id = document.getElementById("uId").value;
       		console.log(id.length);
    		if(id != "" && id != null){  
    			if(id.length < 6){
    				toast('error','아이디는 6~10자로 입력하셔야합니다.');
    				document.getElementById("idFl").value = "n";
    			}else{
		       		$.ajax({
		       			type : "POST",
		       			url : "member/join/checkId",
		       			data : {
		       				"id" : id
		       			},
		       			dataType : "json",
		       			success : function(msg){	       				
		       				if(msg === 0){
		       					toast('success','사용가능한 아이디입니다.');
		       					document.getElementById("idFl").value = "y";
		       				}else{	
		       					toast('error','해당아이디는 이미 가입된 내역이 있습니다.');
		       					document.getElementById("idFl").value = "n";
		       				}	
		       			},
		       			error : function(error){
		       				toast('error',"error:"+error);
		       				document.getElementById("idFl").value = "n";
		       			}
		       		});
    			}
       		}else{
       			toast('error','아이디를 입력해주세요.');
       		}
       		
       	}
    	
    	//닉네임 입력
    	function nickname(){		    			
	    	document.getElementById("nameFl").value = "y";
    	}
    	
    	//대학교입력
    	function col(){
    		document.getElementById("colFl").value = "y";
    	}
       	    	
    	
        (function(d){
        	//생년월일 체크
        	function checkBirthDate(){
                var birthYear = document.querySelector('#uYear'),
                    birthMonth = document.querySelector('#uMonth'),
                    birthDate = document.querySelector('#uDate'),
                    warn = document.querySelector('.warn.birth');
                var thisYear = Number(new Date().getFullYear());
                var limitYear = Number(thisYear) - 25;

                function writeWarning(text){
                    if(text.length < 1) {
                        if(!warn.classList.contains('hidden')) warn.classList.add('hidden');
                        warn.innerText = '';
                    } else {
                        if(warn.classList.contains('hidden')) warn.classList.remove('hidden');
                        warn.innerText = text;
                    }
                };

                function isValidYear(yearText){
                    var year = Number(yearText);
                    if(isNaN(yearText) || yearText.length < 1) {
                        birthYear.value = '';
                        writeWarning('생년을 입력해 주세요.');
                        return false;
                    } else if ( yearText.length < 4 ) {
                        writeWarning('생년 4자리를 입력해 주세요.');
                        return false;
                    } else if (year > thisYear) {
                        writeWarning( yearText + '년은 미래입니다.');
                        return false;
                    } else if (year < limitYear) {
                        writeWarning(limitYear +'년 이전 출생자는 가입이 제한 될 수 있습니다.');
                        return false;
                    } else {
                        writeWarning('');
                        return true;
                    }
                };
                
                function isValidMonth(monthText){
                    var month = Number(monthText);
                    if(isNaN(monthText) || monthText.length < 1) {
                        birthMonth.value = '';
                        writeWarning('생월을 입력해 주세요.');
                        birthFl = "n";
                        return false;
                    } else if ( month < 1 || month > 12) {
                        writeWarning('정확한 월을 입력해 주세요.');
                        return false;
                    } else {
                        writeWarning('');
                        return true;
                    }
                };

                function isValidDate(dateText){
                    var date = Number(dateText);
                    if(isNaN(dateText) || dateText.length < 1) {
                        birthDate.value = '';
                        writeWarning('생일을 입력해 주세요.');
                        return false;
                    } else if ( date < 1 || date > 31) {
                        writeWarning('정확한 일을 입력해 주세요.');
                        return false;
                    } else {
                        isValidMaxdate(birthYear.value, birthMonth.value, date);
                    }
                };

                function isValidMaxdate(year, month, date){
                    var maxDates = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
                    var maxdate = maxDates[month - 1];
                    if(month ==2 && (year%4 == 0 && year%100 == 0 || year%400 == 0)){
                        maxdate = 29;
                    }
                    if(date > maxdate) {
                        writeWarning('정확한 일을 입력해 주세요.');
                        return false;
                    } else {
                        writeWarning('');
                        return true;
                    }
                };

                function checkValidBirthDate(year, month, date){
                    if(year.length <= 0 && month.length <= 0 && date.length <=0) {
                        writeWarning('생년월일을 입력해 주세요');
                        return false;
                    }
                    if(isValidYear(year)){
                        if(isValidMonth(month)){
                            isValidDate(date);
                        }
                    }
                };

                birthYear.addEventListener('change', function(e){
                    checkValidBirthDate(e.target.value, birthMonth.value, birthDate.value);
                });
                
                birthMonth.addEventListener('change', function(e){
                    checkValidBirthDate(birthYear.value, e.target.value, birthDate.value);
                });

                birthDate.addEventListener('change', function(e){
                    checkValidBirthDate(birthYear.value, birthMonth.value, e.target.value);
                });
            };
            checkBirthDate();
        	
            function tabFn(){
                var tabs = document.querySelectorAll('.tab');
                var activate = 'on';

                tabs.forEach(tab => {
                    tab.querySelectorAll('.tab__navs__nav').forEach(nav => {
                        nav.addEventListener('click', switchTab);
                    });
                });

                function switchTab(event){
                    var nav = event.target;
                    if(nav.classList.contains(activate)){
                        return;
                    } else {
                        var tab = nav.closest('.tab'),
                            data = nav.dataset.tab,
                            activated = tab.querySelectorAll('.' + activate);

                        activated.forEach(el => {
                            el.classList.remove(activate);
                        });
                        
                        nav.classList.add(activate);
                        tab.querySelector('.tab__contents__cont[data-tab="'+ data +'"]').classList.add(activate);
                    }
                };
            };
            if(d.querySelectorAll('.tab').length > 0) tabFn();
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
        
        
      //회원가입
    	function memberJoin(){
    		let id = document.getElementById("idFl").value;
    		let pw = document.getElementById("pwFl").value;
    		let name = document.getElementById("nameFl").value;
    		let col = document.getElementById("colFl").value;
    		let phone = document.getElementById("phoneFl").value;
    		
    		var birthYear = document.getElementById('uYear'),
                birthMonth = document.getElementById('uMonth'),
                birthDate = document.getElementById('uDate');
    		
    		console.log('pw = '+pw);
    		console.log('birthYear = '+birthYear.value + ' length = '+birthYear.value.length);
    		console.log('birthMonth = '+birthMonth.value + ' length = '+birthMonth.value.length);
    		console.log('birthDate = '+birthDate.value + ' length = '+birthDate.value.length);
    		 
    		    		
    		if(id != "y") {
    			toast('error','아이디를 중복확인해주세요.');
    			document.getElementById("uId").focus();
    		}else if(document.getElementById("uPwd").value.length < 7){
    			toast('error','비밀번호를 8자 이상 입력해주세요.');
    			document.getElementById("uPwd").focus();
    		}else if(pw != "y") {
    			toast('error','비밀번호를 확인해주세요.');
    			document.getElementById("uPwdCf").focus();
    		}else if(document.getElementById("uNick").value.length > 10){
    			toast('error','닉네임은 10자 이하로 입력하셔야합니다.');
    			document.getElementById("uNick").focus();
    		}else if(name != "y") {
    			toast('error',"닉네임을 입력해주세요.");    				
    			document.getElementById("uNick").focus();
    		}else if(col != "y") {
    			toast('error',"대학교/학과를 입력해주세요.");
    			document.getElementById("ucol").focus();
    		}else if(birthYear.value === '' && birthYear.value.length < 3) {
    			toast('error','날짜를 입력해주세요.');
    			birthYear.focus();
    		}else if(birthMonth.value === '' && birthMonth.value.length < 1) {
    			toast('error','날짜를 입력해주세요.');
    			birthMonth.focus();
    		}else if(birthDate.value === '' && birthDate.value.length < 1) {
    			toast('error','날짜를 입력해주세요.');
    			birthDate.focus();
    		}else if(phone != "y") {
    			toast('error',"핸드폰 인증을 받아주세요.");
    			document.getElementById("uTel").focus();
    		}else {
    			join.submit();
    		}
    	}
        
    </script>
</body>
</html>