<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
setTimeout(function() {
	 	location.href="./list";
	}, 3000);
</script>
<jsp:include page="../aside.jsp" flush="false"/>
<main class="main h-100 container-fluid banner">
    <div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
        <span class="title fs-4">배너 등록</span>
    </div>
    <span class="form-success">배너가 정상적으로 등록되었습니다.</span>
</main>
<jsp:include page="../footer.jsp" flush="false"/>
