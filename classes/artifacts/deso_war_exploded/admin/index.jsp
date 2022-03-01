<%@page import="dto.admin.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Admin admin = (Admin)session.getAttribute("admin");
%>

<jsp:include page="./aside.jsp" flush="false"/>
<% if(admin == null){ %>
<main class="main container-fluid login">
   <div class="form-wrap mx-auto">
       <h1 class="my-5 text-center fs-4">관리자 로그인</h1>
       <form action="${pageContext.request.contextPath}/admin/login" method="post" class="w-100">
           <div class="mb-3 w-100">
             <label for="exampleInputEmail1" class="form-label">아이디</label>
             <input type="text" name="id" class="form-control" id="exampleInputEmail1">
           </div>
           <div class="mb-4">
             <label for="exampleInputPassword1" class="form-label">비밀번호</label>
             <input type="password" name="pw" class="form-control">
           </div>
           <hr>
           <button type="submit" class="btn btn-dark w-100 mt-2">로그인</button>
        </form>
     </div>
</main>
<%} else { %>
<main class="main h-100 container-fluid home">
    <div class="w-100 h-100 d-flex flex-column justify-content-center align-items-center">
        <div>
          <img class="d-block m-auto mb-5" src="${pageContext.request.contextPath}/admin/images/icon_logo.svg" alt="DESO">  
          <hr class="kf-slide">
          <span class="d-block m-auto mt-5">관리자로 로그인 되었습니다.</span>
        </div>
    </div>
</main>
<%} %>
<jsp:include page="./footer.jsp" flush="false"/>