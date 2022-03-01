<%@page import="dto.page.pageDTO"%>
<%@page import="dto.member.Member"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat" %>
<%
	String kind = (String)request.getAttribute("kind");
	String keyword = (String)request.getAttribute("keyword");
	ArrayList<Member> list = (ArrayList)request.getAttribute("list");
	pageDTO paging = (pageDTO)request.getAttribute("paging");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
%>
<jsp:include page="../aside.jsp" flush="false"/>
<main class="main container-fluid user-list" data-page="user-list">
	<div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
		<span class="title fs-4">회원목록</span>
	</div>
	<div class="list-wrap w-100">
		<div class="search-wrap float-right mb-3">
			<form action="list" method="post" class="d-flex flex-row justify-content-end w-100" style="height: 40px;">
				<select name="kind" class="form-select w-auto" aria-label="Default select example">
					<option disabled <%if(kind == null || kind.equals("")){  %> selected = "selected" <%} %>>검색 카테고리</option>
					<option value="회원번호" <%if(kind != null && kind.equals("회원번호")){  %> selected = "selected" <%} %>>회원번호</option>
					<option value="아이디" <%if(kind != null && kind.equals("아이디")){  %> selected = "selected" <%} %>>아이디</option>
					<option value="닉네임" <%if(kind != null && kind.equals("닉네임")){  %> selected = "selected" <%} %>>닉네임</option>
					<option value="학교" <%if(kind != null && kind.equals("학교")){  %> selected = "selected" <%} %>>학교</option>
					<option value="지역" <%if(kind != null && kind.equals("지역")){  %> selected = "selected" <%} %>>지역</option>
					<option value="휴대폰번호" <%if(kind != null && kind.equals("휴대폰번호")){  %> selected = "selected" <%} %>>휴대폰번호</option>
					<option value="학교이메일" <%if(kind != null && kind.equals("학교이메일")){  %> selected = "selected" <%} %>>학교이메일</option>
					<option value="상태" <%if(kind != null && kind.equals("상태")){  %> selected = "selected" <%} %>>상태</option>
					<option value="요청" <%if(kind != null && kind.equals("요청")){  %> selected = "selected" <%} %>>요청</option>
					<option value="경고횟수" <%if(kind != null && kind.equals("경고횟수")){  %> selected = "selected" <%} %>>경고횟수</option>
				</select>
				<div class="input-group mx-3 w-auto">
					<span class="input-group-text">검색어</span> <input name="keyword" type="text" class="form-control" value=<%=(keyword != null && !keyword.equals(""))?keyword:"" %>>
				</div>
				<button type="submit" class="btn btn-dark">검색하기</button>
			</form>
		</div>
		<div class="form-wrap w-100" id="userForm">
			<form class="w-100">
				<div class="table-wrap">
					<table class="table table-hover text-center">
						<thead>
							<tr>
								<th scope="col" class="form-area">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="" form="userForm">
									</div>
								</th>
								<th scope="col">회원번호</th>
								<th scope="col">아이디</th>
								<th scope="col">닉네임</th>
								<th scope="col">휴대폰번호</th>
								<th scope="col">학교이메일</th>
								<th scope="col">상태</th>
								<th scope="col">요청</th>
								<th scope="col">경고횟수</th>
								<th scope="col">회원가입일</th>
							</tr>
						</thead>
						<tbody>
							<%for(int i=0; i<list.size(); i++){ %>
							<tr data-url="${pageContext.request.contextPath}/admin/user/user?no=<%=list.get(i).getM_no()%>&page=<%=paging.getPage()%>&mode=일반회원">
								<th scope="row" class="form-area">
									<div class="form-check">
										<input class="form-check-input" name="ck" type="checkbox" value="<%=list.get(i).getM_no() %>" form="userForm">
									</div>
								</th>
								<td><%=list.get(i).getM_no()%></td>
								<td><%=list.get(i).getM_id()%></td>
								<td><%=list.get(i).getM_name()%></td>
								<td><%=list.get(i).getM_phone()%></td>
								<td><%=(list.get(i).getM_email() != null)?list.get(i).getM_email():""%></td>
								<td class="form-area">
									<select onchange="chg(event,<%=list.get(i).getM_no()%>,'상태')" class="form-select form-select-sm" aria-label=".form-select-sm example">
										<option value="0" <%if(list.get(i).getM_state() != null && !list.get(i).getM_state()){  %> selected = "selected" <%} %>>활성</option>
										<option value="1" <%if(list.get(i).getM_state() != null && list.get(i).getM_state()){  %> selected = "selected" <%} %>>비활성</option>
									</select>
								</td>
								<td class="form-area">
									<select onchange="chg(event,<%=list.get(i).getM_no()%>,'요청')" class="form-select form-select-sm" aria-label=".form-select-sm example">
										<option value="0" <%if(list.get(i).getM_joinFl() != null && !list.get(i).getM_joinFl()){  %> selected = "selected" <%} %>>가입요청</option>
										<option value="1" <%if(list.get(i).getM_joinFl() != null && list.get(i).getM_joinFl()){  %> selected = "selected" <%} %>>요청완료</option>
									</select>
								</td>
								<td class="form-area">
									<select onchange="chg(event,<%=list.get(i).getM_no()%>,'경고횟수')" class="form-select form-select-sm" aria-label=".form-select-sm example">
										<option value="0" <%if(list.get(i).getM_r_count() == 0){  %> selected = "selected" <%} %>>0</option>
										<option value="1" <%if(list.get(i).getM_r_count() == 1){  %> selected = "selected" <%} %>>1</option>
										<option value="2" <%if(list.get(i).getM_r_count() == 2){  %> selected = "selected" <%} %>>2</option>
										<option value="3" <%if(list.get(i).getM_r_count() == 3){  %> selected = "selected" <%} %>>3</option>
									</select>
								</td>
								<td><%=date.format(list.get(i).getRegDt())%></td>
							</tr>
							<%} %>
						</tbody>
					</table>
				</div>
				<div class="btn-wrap mt-4">
					<button type="button" onclick="del('회원','member')" class="btn btn-outline-dark">삭제</button>
				</div>
				<div class="pg-wrap d-flex justify-content-center mt-2">
					<nav aria-label="Page navigation example">
						<ul class="pagination w-auto mx-auto">													
							<%if(paging.getPage() > 1){ %>   
							<li class="page-item">     	
								<a class="page-link text-dark" aria-label="Previous" href="list?page=${paging.page-1}&kind=<%=kind %>&keyword=<%=keyword %>">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
	        				<%}%>
							<c:forEach begin="${paging.startPage}" end="${paging.endPage }" var="i" step="1">
								<li class="page-item">
								<c:choose>
									<c:when test="${i eq paging.page }">	
										<a class="page-link text-dark" href="#">${i}</a>								
									</c:when>
									<c:otherwise>
										<a class="page-link text-dark" href="list?page=${i}&kind=<%=kind %>&keyword=<%=keyword %>">${i}</a>
									</c:otherwise>
								</c:choose>
								</li>
							</c:forEach>
							<%if(paging.getPage() < paging.getMaxPage()){ %>
							<li class="page-item">    
								<a class="page-link text-dark" aria-label="Next" href="list?page=${paging.page+1}&kind=<%=kind %>&keyword=<%=keyword %>">
									<span aria-hidden="true">&laquo;</span>
								</a>		
							</li>	
							<%} %>
						</ul>
					</nav>
				</div>
			</form>
		</div>
	</div>
</main>
<script>
    (function(d){
        let tr = d.querySelectorAll('tbody tr');
        tr.forEach(el => {
            if(el.dataset.url){
                  el.addEventListener('click', function(e){
                    if(!e.target.classList.contains('form-area') && !e.target.closest('.form-area')){
                        let url = e.target.dataset.url? e.target.dataset.url : e.target.closest('tr').dataset.url;
                        window.location.href = url;
                    }
                });
            };
        });
    })(document);
    
    function chg(event,no,mode){
    	const val = event.target.value;

		$.ajax({
			type:"post",
			url:"./mod",
			data: {
				val:val,
				no:no,
				mode:mode
			},
			dateType:"json",
			success:function(i){
				console.log(i);
				if(i == 1){
					alert("변경되었습니다.");
					location.reload();
				}else if(i == 2){
					alert("수정하신 회원을 블랙처리되었습니다.");
					location.reload();
				}else if(i == 3){
					alert("회원상태가 활성으로 들어가 경고횟수가 초기화되었습니다.");
					location.reload();
				}else if(i == 0){
					alert("실패");
				}
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			
		});
    	
    }
    
    
</script>
<script src="${pageContext.request.contextPath}/admin/js/multdel.js"></script>
<jsp:include page="../footer.jsp" flush="false"/>
