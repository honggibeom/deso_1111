<%@page import="dto.information.Information"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Information dto = (Information)request.getAttribute("dto");
	String mode = (String)request.getAttribute("mode");
%>

<jsp:include page="../aside.jsp" flush="false"/>
<main class="main container-fluid terms-form">
    <div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
        <span class="title fs-4"><%=(dto != null)?dto.getI_title():"" %> 등록</span>
    </div>
    <div class="h-100 w-100 d-flex flex-column align-items-center mt-4">
        <div class="form-wrap form-wrap-l">
            <form action="./process" method="post" class="w-100 container-fluid">
            	<input type="hidden" name="no" value="<%=(dto != null)?dto.getI_no():0 %>">
            	<input type="hidden" name="mode" value="<%=mode %>">
                <div class="row g-3 mb-5">
                    <div class="col-2"><span>제목</span></div>
                    <div class="col-10">
                    	<%if(dto != null){ %>
                    	<strong class="fs-5"><%=dto.getI_title() %></strong>
                    	<%}else{%>
                    	<strong class="fs-5"><input class="form-control" style="width:70%;" type="text" name="title" required></strong>
                    	<%} %>
                    </div>	
                </div>
                <div class="row g-3 mb-5">
                    <div class="col-2"><label for="noticeConts" class="col-form-label">본문</label></div>
                    <div class="col-10"><textarea class="form-control" name="content" id="noticeConts" rows="20" cols="20" wrap="hard" required><%=(dto != null)?dto.getI_content():"" %></textarea></div>
                </div>
                <hr>
                <div class="d-flex justify-content-end pt-2">
                    <a href="javascript:history.back();" type="button" class="btn mx-5">취소</a>
                    <button type="submit" class="btn btn-dark">등록하기</button>
                </div>
        	</form>
        </div>
    </div>
</main>
<jsp:include page="../footer.jsp" flush="false"/>