<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../aside.jsp" flush="false"/>
<main class="main container-fluid user-form">
	<div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
		<span class="title fs-4">회원 등록</span>
	</div>
	<div class="h-100 w-100 d-flex flex-column align-items-center pt-4">
		<div class="form-wrap form-wrap-m">
			<form action="./insert" method="post" class="w-100 container-fluid">
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userId" class="col-form-label">아이디</label>
					</div>
					<div class="col-5">
						<input type="text" name="id" id="userId" class="form-control" required>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userPwd" class="col-form-label">비밀번호</label>
					</div>
					<div class="col-5">
						<input type="password" name="pw" id="userPwd" class="form-control" min="7" required>
					</div>
					<div class="col-5 pt-2">
						<span class="form-text">*영문, 숫자 포함 8자이상</span>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userName" class="col-form-label">닉네임</label>
					</div>
					<div class="col-5">
						<input type="text" name="name" id="userName" class="form-control" required>
					</div>
				</div>
				
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userCol" class="col-form-label">학교</label>
					</div>
					<div class="col-5">
						<input type="text" name="school" id="userCol" class="form-control"required>
					</div>
					<div class="col-5 pt-2">
						<span class="form-text">*예: 서울대학교</span>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userCol" class="col-form-label">학과</label>
					</div>
					<div class="col-5">
						<input type="text" name="study" class="form-control"required>
					</div>
					<div class="col-5 pt-2">
						<span class="form-text">*예: 국어국문학과</span>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="userBirth" class="col-form-label">생년월일</label>
					</div>
					<div class="col-5">
						<input type="text" name="birthdate" id="userBirth" class="form-control" required>
					</div>
					<div class="col-5 pt-2">
						<span class="form-text">*형식: YYYYMMDD</span>
					</div>
				</div>
				<div class="row g-3 mb-4">
					<div class="col-2">
						<label for="useTel" class="col-form-label">휴대폰 번호</label>
					</div>
					<div class="col-5">
						<input type="text" name="phone" id="useTel" class="form-control" required>
					</div>
				</div>
				<hr>
				<div class="d-flex justify-content-end">
					<a href="./list" type="button" class="btn mx-5">취소</a>
					<button type="submit" class="btn btn-dark">등록하기</button>
				</div>
			</form>
		</div>
	</div>
</main>
<jsp:include page="../footer.jsp" flush="false"/>