<%@page import="dto.member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member m = (Member)session.getAttribute("member");
%>
<script src="${pageContext.request.contextPath}/admin/js/jquery-3.6.0.min.js"></script>
<jsp:include page="../header.jsp" flush="false" />
    <div id="app">
        <main id="main">
            <section class="section mypage mypage-edit-alarm">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">알림설정</h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:history.go(-1)" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <div class="edit">
                        <div class="field">
                            <span class="field__title">기본알림 설정</span>
                            <div class="toggle">
                                <span class="toggle__label">
                                    알림 설정을 통해 DESO에서 제공하는
                                    <br>
                                    새로운 정보를 받아 보세요.  
                                </span>
                                <span class="toggle__switch">
                                    <input type="checkbox" id="newInfo" name="ck" value="1" onchange="allim()" <%if(m.getM_allimFl()){%>checked<%}%>>
                                    <label for="newInfo"></label>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
    <script>
    	function allim(){
    		var check = document.querySelectorAll('input[name="ck"]:checked');
    		var val = 0;
    		if(check.length > 0){
    			val = check[0].value;
    		}else {
    			val = 0;
    		}    		
    		
    		 $.ajax({
				type:"post",
				url:"../allim/process",
				data: {
					val:val
				},
				dateType:"json",
				error:function(request,status,error){
					alert('error',"code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			}); 
    	}
    </script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
<html>