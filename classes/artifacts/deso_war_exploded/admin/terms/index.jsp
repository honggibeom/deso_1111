<%@page import="java.util.ArrayList"%>
<%@page import="dto.information.Information"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<Information> list = (ArrayList)request.getAttribute("list");
	String title = (String)request.getAttribute("title");
%>
<style>
#scroll_bar {
    -ms-overflow-style: none; /* IE and Edge */
    scrollbar-width: none; /* Firefox */
}
#scroll_bar::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Opera*/
}

</style>
<jsp:include page="../aside.jsp" flush="false"/>
<main class="main container-fluid service-terms">
    <div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
        <span class="title fs-4">사이트 정보 설정</span>
        <a href="./action?mode=insert">등록하기</a>
    </div>
    <div class="terms-tab mx-auto pt-5">
        <ul class="nav nav-pills tab-nav my-5" id="pills-tab" role="tablist">
        	<%for(int i=0; i<list.size(); i++){ %>
            <li class="nav-item col-2 text-center" >
              <button onclick="terms(<%=i %>)"class="i_title nav-link text-decoration-none text-black fs-5"><%=list.get(i).getI_title() %></button>
            </li>
            <%} %>
          </ul>
          <div class="tab-content" id="pills-tabContent">
          	<%for(int i=0; i<list.size(); i++){ %>
            <div class="tab-pane fad i_content">
                <textarea rows="20"  class="col-10" id="scroll_bar" style="width:100%; padding:30px; border:none; outline:none;" readonly="readonly"><%=list.get(i).getI_content() %></textarea>
                <hr>
                <div class="d-flex justify-content-end pt-2">
                	<a href="./del?no=<%=list.get(i).getI_no() %>" class="btn">삭제</a>
                    <a href="./action?no=<%=list.get(i).getI_no() %>&mode=update" class="btn btn-dark">수정하기</a>
                </div>
            </div>
            <%} %>
          </div>
    </div>
</main>
<script>
var title = document.querySelectorAll('.i_title');
var content = document.querySelectorAll('.i_content');

title[0].classList.add('active');
content[0].classList.add('show');
content[0].classList.add('active');

function terms(no){	 
	 for(var i=0; i<title.length; i++){
		 title[i].classList.remove("active");
		 title[no].classList.add('active');
	 }
	 
	 for(var j=0; j<content.length; j++){
		 content[j].classList.remove('show');
		 content[j].classList.remove('active');
		 content[no].classList.add('show');
		 content[no].classList.add('active');
	 }	 
}
</script>
<jsp:include page="../footer.jsp" flush="false"/>