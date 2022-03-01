<%@page import="dto.member.Member"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat" %>
<jsp:include page="../aside.jsp" flush="false"/>

<%
	Member m = (Member)request.getAttribute("m");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	int p = (int)request.getAttribute("page");
	String mode = (String)request.getAttribute("mode");
%>


<main class="main container-fluid user-form">
	<div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
		<span class="title fs-4"><%=(mode.equals("일반회원"))?"회원상세":"탈퇴회원" %></span>
	</div>
	<div class="h-100 w-100 d-flex flex-column align-items-center pt-4">
		<div class="form-wrap form-wrap-m">
			<form action="./modify" method="post" class="w-100 container-fluid">
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userId" class="col-form-label">아이디</label>
					</div>
					<div class="col-5">
						<input type="hidden" name="no" value="<%=m.getM_no() %>">
						<input type="hidden" name="page" value="<%=p %>">
						<input type="text" name="id" id="userId" class="form-control"
							value="<%=m.getM_id() %>" readonly>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userName" class="col-form-label">닉네임</label>
					</div>
					<div class="col-5">
						<input type="text" name="name" id="userName" class="form-control" value="<%=m.getM_name() %>" <%if(mode.equals("탈퇴회원")) {%> readonly <%} %>>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userCol" class="col-form-label">학교</label>
					</div>
					<div class="col-5">
						<input type="text" name="school" id="userCol" class="form-control" value="<%=m.getM_school() %>" <%if(mode.equals("탈퇴회원")) {%> readonly <%} %>>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userEmail"class="col-form-label">학교 이메일</label>
					</div>
					<div class="col-5">
						<input type="email" name="email" id="userEmail" class="form-control"
							value="<%=(m.getM_email() != null)?m.getM_email():""%>" <%if(mode.equals("탈퇴회원")) {%> readonly <%} %>>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userBirth"class="col-form-label">생년월일</label>
					</div>
					<div class="col-5">
						<input type="text" name="birthdate" id="userBirth" class="form-control"
							value="1999-11-22" <%if(mode.equals("탈퇴회원")) {%> readonly <%} %>>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="useTel" class="col-form-label">휴대폰 번호</label>
					</div>
					<div class="col-5">
						<input type="text" name="phone" id="useTel" class="form-control"
							value="<%=m.getM_phone() %>" <%if(mode.equals("탈퇴회원")) {%> readonly <%} %>>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userAddr" class="col-form-label">지역</label>
					</div>
					<div class="col-10">
						<input type="text" name="address" id="userAddr" class="form-control"
							value="<%=(m.getM_address() != null)?m.getM_address():"" %>" <%if(mode.equals("탈퇴회원")) {%> readonly <%} %>>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userPwd" class="col-form-label">비밀번호</label>
					</div>
					<div class="col-5">
						<input type="password" name="pw" id="userPwd" class="form-control"
							value="<%=m.getM_pw() %>" <%if(mode.equals("탈퇴회원")) {%> readonly <%} %>>
					</div>
					<div class="col-5 pt-2" <%if(mode.equals("탈퇴회원")) {%> style="display:none;" <%} %>>
						<span class="form-text">*영문, 숫자 포함 8자이상</span>
					</div>
				</div>
				<hr>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<span>요청</span>
					</div>
					<div class="col-10">
						<span><%=(m.getM_joinFl())?"요청완료":"가입요청" %></span>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<span>경고횟수</span>
					</div>
					<div class="col-10">
						<span><strong><%=m.getM_r_count() %></strong>회</span>
					</div>
				</div>
				<%if(mode.equals("탈퇴회원")){  %>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<span>탈퇴일</span>
					</div>
					<div class="col-10">
						<span><%=date.format(m.getDelDt())%></span>
					</div>
				</div>
				<%} %>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<span>회원가입일</span>
					</div>
					<div class="col-10">
						<span><%=date.format(m.getRegDt())%></span>
					</div>
				</div>
				<hr>
				<div class="d-flex justify-content-between pt-2">
					<button type="button" onclick="del2(<%=m.getM_no() %>,<%=p %>,'<%=mode %>')" class="btn btn-outline-dark">삭제</button> 
					
					<span>
						<%if(mode.equals("탈퇴회원")){  %>
							<a href="./unsubs?page=<%=p %>" class="btn btn-dark">확인</a>
						<%}else { %>
							<a href="./list?page=<%=p %>" class="btn mx-5">취소</a>
							<button type="submit" class="btn btn-dark">확인</button>
						<%} %>
					</span>
				</div>
			</form>
		</div>
	</div>
</main>
<script>
	function del2(no,page,mode){
		var d = confirm("삭제처리하시겠습니까?");
		if(d){
			location.href="./del?no="+no+"&page="+page+"&mode="+mode;
		}
	}
</script>
<jsp:include page="../footer.jsp" flush="false"/>