<%@page import="dto.admin.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Admin admin = (Admin)session.getAttribute("admin");
%>

<jsp:include page="../aside.jsp" flush="false"/>

<main class="main container-fluid account-edit">
    <div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
      <span class="title fs-4">관리자 설정</span>
    </div>
    <div class="h-100 w-100 d-flex flex-column align-items-center">
        <div class="form-wrap">
            <form action="${pageContext.request.contextPath}/admin/modify" method="post" class="mx-auto">
                <div class="mb-4">
                  <label for="adminId" class="form-label">아이디</label>
                  <input type="text" class="form-control" id="adminId" value="<%=admin.getAdmin_id() %>">
                </div>
                <div class="mb-4">
                  <label for="adminPwd" class="form-label">현재 비밀번호</label>
                  <input type="password" class="form-control" name="pw" id="adminPwd" required>
                </div>
                <div class="mb-4">
                  <label for="adminNewPwd" class="form-label">새 비밀번호</label>
                  <input type="password" class="form-control pwdCheck" id="adminNewPwd" required>
                  <div class="form-text">*영문, 숫자 포함 8자이상</div>
                </div>
                <div class="mb-5">
                  <label for="adminNewPwdCf" class="form-label">새 비밀번호 확인</label>
                  <input type="password" class="form-control pwd-confirm pwdCheck" name="newPw" id="adminNewPwdCf" data-pwd="adminPwd" required>
                </div>
                <hr>
                <div class="d-flex justify-content-end pt-2">
                    <a href="${pageContext.request.contextPath}/admin/home" type="button" class="btn mx-5">취소</a>
                    <button type="submit" class="btn btn-dark">수정하기</button>
                </div>
              </form>
        </div>
    </div>
</main>
<script>
  //=================================================================================== 비밀번호, 비밀번호 확인 체크
  function checkPwdFn(inputPwd){
    inputPwd.change(function(e){
        if($(e.target).hasClass('pwd-confirm')) checkSame($(e.target));
        else checkString($(e.target).val());
    });
    function checkString(pwdString) {
        const pwdRegExp = /^(?=.*?[0-9])(?=.*?[a-zA-Z]).{8,}$/;
        if(!pwdRegExp.test(pwdString)) {
            alert('비밀번호는 영문과 숫자를 포함하여 8자 이상이어야 합니다.');
            return false;
        }
    };
    function checkSame(pwd){
        const firstPwd = pwd.parents('form').find('#' + pwd.data('pwd'));
        if(firstPwd.val().length <= 0) alert('비밀번호를 먼저 입력해 주세요.')
        else if( firstPwd.val().length > 0 && firstPwd.val() !== pwd.val()) alert('비밀번호가 일치하지 않습니다.');
    }
  };
  checkPwdFn($('input.pwdCheck'));
</script>

<jsp:include page="../footer.jsp" flush="false"/>