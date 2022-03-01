<%@page import="dto.report.Report"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat" %>
<jsp:include page="../aside.jsp" flush="false"/>

<%
	Report r = (Report)request.getAttribute("r");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	int p = (int)request.getAttribute("page");
	String sort = (String)request.getAttribute("sort");
%>
<main class="main container-fluid service-report">
    <div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
        <span class="title fs-4">신고 상세</span>
    </div>
    <form action="./report" method="post">
    	<input type="hidden" name="no" value="<%=r.getR_no() %>">
    	<input type="hidden" name="id_no" value="<%=r.getRd_id_no() %>">
    	<input type="hidden" name="board_no" value="<%=r.getRd_board_no() %>">
    	<input type="hidden" name="page" value="<%=p %>">
    	<input type="hidden" name="sort" value="<%=sort %>">
	    <div class="h-100 w-100 d-flex flex-column align-items-center pt-4">
	      	<div class="w-100 container">
        		<div class="row g-3 mb-4">
            		<div class="col-3"><span>신고한 아이디</span></div>
           			<div class="col-9"><span class="text-secondary"><%=r.getR_id() %></span></div>
       			</div>
		        <div class="row g-3 mb-4">
		        	<%if(sort.equals("회원")){ %>
		            <div class="col-3"><span>신고 받은 아이디</span></div>
		            <div class="col-9"><span class="text-dark"><%=r.getRd_id() %></span></div>
		            <%} else {%>
		            <div class="col-3"><span>신고 받은 <%=sort %></span></div>
		            <div class="col-9"><span class="text-dark"><%=r.getRd_board_no() %></span></div>
		            <%} %>
		        </div>
		        <div class="row g-3 mb-5">
		            <div class="col-3"><span>신고 날짜</span></div>
		            <div class="col-9"><span><%=date.format(r.getRegDt())%></span></div>
		        </div>
		        <div class="row g-3 mb-5">
		            <div class="col-3"><span>신고 내용</span></div>
		            <div class="col-9">
		              <textarea class="form-control" id="exampleFormControlTextarea1" rows="10" readonly><%=r.getR_content() %></textarea>
		            </div>
		        </div>
	        	<hr>
		        <div class="d-flex justify-content-between pt-2">
		            <button type="button" onclick="del2(<%=r.getR_no() %>,<%=p %>,'<%=sort %>')" class="btn btn-outline-dark">삭제</button> 
		            <span>            
			            <a href="./list?page=<%=p %>&sort=<%=sort %>" class="btn mx-5">취소</a>
			            <%if(!r.getR_process()){ %>
			            <button type="submit" class="btn btn-dark">신고적용</button>
			            <%} else{ %>
			            <button type="button" onclick="alert('이미 처리된 신고내역입니다.')" class="btn btn-dark">신고적용</button>
			            <%} %>
		            </span>
		        </div>
	      	</div>
	  	</div>
	</form>
</main>
<script>
	function del2(no,page,sort){
		var d = confirm("삭제처리하시겠습니까?");
		if(d){
			location.href="./del?no="+no+"&page="+page+"&sort="+sort;
		}
	}
</script>
<jsp:include page="../footer.jsp" flush="false"/>