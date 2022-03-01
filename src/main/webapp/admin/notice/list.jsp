<%@page import="dto.notice.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.report.Report"%>
<%@page import="dto.page.pageDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat" %>
<%
	String kind = (String)request.getAttribute("kind");
	String keyword = (String)request.getAttribute("keyword");
	ArrayList<Notice> list = (ArrayList)request.getAttribute("list");
	pageDTO paging = (pageDTO)request.getAttribute("paging");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
%>
<jsp:include page="../aside.jsp" flush="false"/>
<main class="main container-fluid notice-list">
  <div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
      <span class="title fs-4">공지사항 목록</span>
  </div>
  <div class="list-wrap w-100">
    <div class="search-wrap float-right mb-3">
        <form action="./list" method="post" class="d-flex flex-row justify-content-end w-100" style="height: 40px;">
              <select name="kind" class="form-select w-auto" aria-label="Default select example">
             	<option disabled <%if(kind == null || kind.equals("")){  %> selected="selected" <%} %>>검색 카테고리</option>
				<option value="번호" <%if(kind != null && kind.equals("번호")){  %> selected="selected" <%} %>>번호</option>
				<option value="제목" <%if(kind != null && kind.equals("제목")){  %> selected="selected" <%} %>>제목</option>
				<option value="작성일" <%if(kind != null && kind.equals("작성일")){  %>selected="selected" <%} %>>작성일</option>
              </select>
              <div class="input-group mx-3 w-auto">
					<span class="input-group-text">검색어</span> 
					<input name="keyword" type="text" class="form-control" value=<%=(keyword != null && !keyword.equals(""))?keyword:"" %>>
			  </div>
              <button type="submit" class="btn btn-dark">검색하기</button>
          </form>
      </div>
      <div class="form-wrap w-100">
          <form class="w-100" id="noticeForm">
            <div class="table-wrap">
              <table class="table table-hover w-100 text-center">
                  <thead>
                      <tr>
                      <th scope="col" class="form-area">
                          <div class="form-check">
                              <input class="form-check-input" type="checkbox" value="" form="noticeForm">
                          </div>
                      </th>
                      <th scope="col">번호</th>
                      <th scope="col">작성자</th>
                      <th scope="col">제목</th>
                      <th scope="col">작성일</th>
                      <th scope="col">조회수</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%for(int i=0; i<list.size(); i++){ %>
                  		<%if(list.get(i).getN_state()){ %>          
		                    <tr data-url="./action?no=<%=list.get(i).getN_no()%>&page=<%=paging.getPage()%>&action=수정" class=<%=(list.get(i).getN_state())?"notice-top":"" %>>
		                      <th scope="row" class="form-area">
		                          <div class="form-check">
		                              <input class="form-check-input" name="ck" type="checkbox" value="<%=list.get(i).getN_no() %>" form="noticeForm">
		                          </div>
		                      </th>
		                      <td><%=list.get(i).getN_no() %></td>
		                      <td><%=list.get(i).getN_id() %></td>
		                      <td class="title"><%=list.get(i).getN_title() %></td>
		                      <td><%=date.format(list.get(i).getRegDt())%></td>
		                      <td><%=list.get(i).getN_hit() %></td>
		                    </tr>    
                    	<%} %>                
                  	<%} %>
                  	<%for(int i=0; i<list.size(); i++){ %>
                  		<%if(!list.get(i).getN_state()){ %>          
		                    <tr data-url="./action?no=<%=list.get(i).getN_no()%>&page=<%=paging.getPage()%>&action=수정" class=<%=(list.get(i).getN_state())?"notice-top":"" %>>
		                      <th scope="row" class="form-area">
		                          <div class="form-check">
		                              <input class="form-check-input" name="ck" type="checkbox" value="<%=list.get(i).getN_no() %>" form="noticeForm">
		                          </div>
		                      </th>
		                      <td><%=list.get(i).getN_no() %></td>
		                      <td><%=list.get(i).getN_id() %></td>
		                      <td class="title"><%=list.get(i).getN_title() %></td>
		                      <td><%=date.format(list.get(i).getRegDt())%></td>
		                      <td><%=list.get(i).getN_hit() %></td>
		                    </tr>    
                    	<%} %>                
                  	<%} %>
                  </tbody>
              </table>
            </div>
            <div class="btn-wrap d-flex justify-content-between">
              <button type="button" onclick="del('공지','notice')" class="btn btn-outline-dark">삭제</button>
              <a href="./action?page=<%=paging.getPage()%>&action=작성" class="btn btn-dark">글쓰기</a>
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
										<a class="page-link text-dark"
											href="list?page=${i}&kind=<%=kind %>&keyword=<%=keyword %>">${i}</a>
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
</script>
<script src="${pageContext.request.contextPath}/admin/js/multdel.js"></script>
<jsp:include page="../footer.jsp" flush="false"/>