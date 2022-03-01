<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.notice.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Notice n = (Notice)request.getAttribute("notice");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	int p = (int)request.getAttribute("page");
	String action = (String)request.getAttribute("action");
%>
<jsp:include page="../aside.jsp" flush="false"/>
<main class="main container-fluid notice-form">
    <div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
        <span class="title fs-4">공지사항 <%=(n != null)?"상세":"작성" %></span>
    </div>
    <div class="h-100 w-100 d-flex flex-column align-items-center mt-4">
        <div class="form-wrap form-wrap-l">
            <form action="process" method="post" class="w-100 container-fluid">
            	<input type="hidden" name="no" value="<%=(n != null)?n.getN_no():0 %>">
            	<input type="hidden" name="action" value="<%=action %>">
            	<input type="hidden" name="page" value="<%=p %>">
                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="noticeTitle" class="col-form-label">제목</label></div>
                    <div class="col-10"><input type="text" name="title" id="noticeTitle" class="form-control" value="<%=(n != null)?n.getN_title():"" %>" required></div>
                </div>
                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="noticeConts" class="col-form-label">내용</label></div>
                    <div class="col-10">
                        <textarea class="form-control" name="content" id="noticeConts" rows="20" required><%=(n != null)?n.getN_content():"" %></textarea>
                    </div>
                </div>
                <div class="row g-3 mb-5">
                  <div class="col-2"><label for="noticeSort" class="col-form-label">공지 종류</label></div>
                  <div class="col-10">
                    <input class="form-check-input" type="radio" value="0" name="noticeSort" <%=((n == null) || (n != null && !n.getN_state()))?"checked":"" %>>
                    <span class="mx-2 form-check-label mr-5 text-muted">일반 공지</span>
                    <input class="form-check-input" type="radio" value="1" name="noticeSort" <%=(n != null && n.getN_state())?"checked":"" %>>
                    <span class="mx-2 form-check-label text-muted">중요 공지(목록 상단에 고정됩니다)</span>
                  </div>
                </div>
                <hr>
                <div class="d-flex justify-content-end">
                    <a href="./list?page=<%=p %>" class="btn mx-5">목록으로 돌아가기</a>
                    <button type="submit" class="btn btn-dark"><%=(n != null)?"수정하기":"작성하기"%></button>
                </div>
              </form>
        </div>
    </div>
</main>
<jsp:include page="../footer.jsp" flush="false"/>