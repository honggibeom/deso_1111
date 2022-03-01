<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.page.pageDTO"%>
<%@page import="dto.board.Board"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	List<Board> list = (ArrayList)request.getAttribute("list");
	String mode = (String)request.getAttribute("mode");
	String kind = (String)request.getAttribute("kind");
	String keyword = (String)request.getAttribute("keyword");
	pageDTO paging = (pageDTO)request.getAttribute("paging");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat date2 = new SimpleDateFormat("HH:mm");
%>
<jsp:include page="../aside.jsp" flush="false"/>
<main class="main container-fluid meet-list">
    <div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
        <span class="title fs-4"><%=mode %> 목록</span>
    </div>
    <div class="list-wrap w-100">
      <div class="search-wrap float-right mb-3">
          <form action="list" method="post" class="d-flex flex-row justify-content-end w-100" style="height: 40px;">
          	  <input type="hidden" name="mode" value="<%=mode %>">
              <select name="kind" class="form-select w-auto" aria-label="Default select example">
                  <option disabled <%if(kind == null || kind.equals("")){  %> selected = "selected" <%} %>>검색 카테고리</option>
                  <option value="주최자아이디" <%if(kind != null && kind.equals("주최자아이디")){  %> selected = "selected" <%} %>>주최자 아이디</option>
                  <option value="카테고리" <%if(kind != null && kind.equals("카테고리")){  %> selected = "selected" <%} %>>카테고리</option>
                  <option value="위치" <%if(kind != null && kind.equals("위치")){  %> selected = "selected" <%} %>>위치</option>
                  <option value="시간/날짜" <%if(kind != null && kind.equals("시간/날짜")){  %> selected = "selected" <%} %>>시간/날짜</option>
                  <option value="인원" <%if(kind != null && kind.equals("인원")){  %> selected = "selected" <%} %>>인원</option>
                  <option value="<%=mode%>명" <%if(kind != null && kind.equals(mode+"명")){  %> selected = "selected" <%} %>><%=mode %>명</option>
              </select>
              <div class="input-group mx-3 w-auto">
                  <span class="input-group-text">검색어</span> <input name="keyword" type="text" class="form-control" value=<%=(keyword != null && !keyword.equals(""))?keyword:"" %>>
              </div>
              <button type="submit" class="btn btn-dark">검색하기</button>
          </form>
      </div>
      <div class="form-wrap w-100">
          <form class="w-100" id="meetForm">
            <div class="table-wrap">
              <table class="table table-hover text-center">
                  <thead>
                    <tr>
                      <th scope="col" class="form-area">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" form="meetForm">
                        </div>
                      </th>
                      <th scope="col">주최자 아이디</th>
                      <th scope="col" class="title"><%=mode %>명</th>
                      <th scope="col">카테고리</th>
                      <th scope="col">위치</th>
                      <th scope="col">시간/날짜</th>
                      <th scope="col">인원</th>
                      <th scope="col"><%=mode %>생성날짜</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%for(int i=0; i<list.size(); i++){ %>
                    <tr data-url="${pageContext.request.contextPath}/admin/board/view?no=<%=list.get(i).getB_no()%>&page=<%=paging.getPage()%>&mode=<%=mode%>&action=update">
                      <th scope="row" class="form-area">
                          <div class="form-check">
                              <input class="form-check-input" name="ck" type="checkbox" value="<%=list.get(i).getB_no() %>" form="meetForm">
                          </div>
                      </th>
                      <td><%=list.get(i).getB_m_id() %></td>
                      <td class="title"><%=list.get(i).getB_title() %></td>
                      <td><%=list.get(i).getB_category() %></td>
                      <td><%=list.get(i).getB_address() %></td>
                      <td>
                          <div class="date"><%=date.format(list.get(i).getB_time()) %></div>
                          <div class="time"><%=date2.format(list.get(i).getB_time()) %></div>
                      </td>
                      <td><%=list.get(i).getB_p_limit() %></td>
                      <td><%=date.format(list.get(i).getRegDt()) %></td>
                    </tr>
                    <%} %>
                  </tbody>
              </table>
            </div>
            <div class="btn-wrap mt-4 text-start">
              <button type="button" onclick="del('게시판','board')" class="btn btn-outline-dark">삭제</button>
            </div>
            <div class="pg-wrap d-flex justify-content-center mt-2">
					<nav aria-label="Page navigation example">
						<ul class="pagination w-auto mx-auto">													
							<%if(paging.getPage() > 1){ %>   
							<li class="page-item">     	
								<a class="page-link text-dark" aria-label="Previous" href="./list?page=${paging.page-1}&kind=<%=kind %>&keyword=<%=keyword %>&mode=<%=mode%>">
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
										<a class="page-link text-dark" href="./list?page=${i}&kind=<%=kind %>&keyword=<%=keyword %>&mode=<%=mode%>">${i}</a>
									</c:otherwise>
								</c:choose>
								</li>
							</c:forEach>
							<%if(paging.getPage() < paging.getMaxPage()){ %>
							<li class="page-item">    
								<a class="page-link text-dark" aria-label="Next" href="./list?page=${paging.page+1}&kind=<%=kind %>&keyword=<%=keyword %>&mode=<%=mode%>">
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