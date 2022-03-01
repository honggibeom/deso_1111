<%@page import="java.util.HashMap"%>
<%@page import="dto.alert.Alert"%>
<%@page import="java.util.Objects"%>
<%@page import="dto.member.Member"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

Cookie[] cookies = request.getCookies();
 
if(cookies != null){
	HashMap<String,String> map = new HashMap<String,String>();
	
    for(int i=0; i < cookies.length; i++){
        Cookie c = cookies[i] ;
        
        String name = c.getName();
        String val = c.getValue();
        map.put(name,val);
    }	
	if(map.get("cookieId") != null){		
		response.sendRedirect("./login");
	}
}

%>

<jsp:include page="./header.jsp" flush="false" />
<div id="app">
    <main id="main">
        <section class="section account account-login">
            <div class="section__content">
                <div class="section__content__top">
                    <h1 class="logo"><img src="${pageContext.request.contextPath}/images/icon_logo.svg" alt="DESO"></h1>
                </div>
                <div class="account__form">
                    <form action="${pageContext.request.contextPath}/login" method="post" class="form" name="login">
                        <fieldset class="field">
                            <label for="userId" class="hidden">아이디</label>
                            <input type="text" name="userId" id="userId" class="bg bd" placeholder="아이디">
                        </fieldset>
                        <fieldset class="field">
                            <label for="userPwd" class="hidden">비밀번호</label>
                            <input type="password" name="userPw" id="userPwd" class="bg bd" placeholder="비밀번호">
                        </fieldset>          
                        <fieldset class="link__finds">
                            <a href="${pageContext.request.contextPath}/find?mode=id">아이디 /</a>
                            <a href="${pageContext.request.contextPath}/find?mode=pw"> 비밀번호 찾기</a>
                        </fieldset>                 
                        <button onclick="loginFrom()" type="button" class="btn--submit btn__full">로그인</button>
                    </form>
                    <a href="${pageContext.request.contextPath}/joinHome" class="link__join">회원가입</a>
                </div>
            </div>
        </section>
    </main>
</div>
<script>
	function loginFrom(){
		const id = document.getElementById("userId").value,
			  pw = document.getElementById("userPwd").value;
		
		if(id != null && id === ""){
			toast('error','아이디를 입력해주세요.');
		}else if(pw != null && pw === ""){
			toast('error','비밀번호를 입력해주세요.');
		}else {
			login.submit();
		}
	}
</script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>