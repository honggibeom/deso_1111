<%@page import="dto.member.Member"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.comment.Comment"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<Comment> list = (ArrayList)request.getAttribute("list");
	Long no = (Long)request.getAttribute("no");
	Long mno = (Long)request.getAttribute("mno");
	Member member = (Member)session.getAttribute("member");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	int size = (int)request.getAttribute("size");
%>
<jsp:include page="../../header.jsp" flush="false" />
<script src="${pageContext.request.contextPath}/admin/js/jquery-3.6.0.min.js"></script>
    <div class="layer">
        <div class="modal" data-modal="report">
            <h5 class="modal__title">모임 신고하기</h5>
            <form>
                <textarea class="modal__text" name="reportCont" id="reportCont" cols="30" rows="10" placeholder="신고이유를 적어주세요.&#10;확인을 통하여 조치를 취할수 있도록 하겠습니다.&#10;감사합니다."></textarea>
                <button type="button" class="btn--submit modalClose">확인</button>
            </form>
        </div>
    </div>
    <div id="app">
        <main id="main" class="meet">
            <section class="section meet meet-replies">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">전체댓글</h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="../view?no=<%=no %>" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content btm-xl">
                    <div class="replies wrap">
                        <div class="replies__top">
                            <h3 class="replies__top__title">댓글<em class="replies__top__cnt"><%=size %>개</em></h3>
                        </div>
                        <div class="replies__list">
                        	<%for(int i=0; i<list.size(); i++){ %>
                            <div class="reply">
                            	<a href="${pageContext.request.contextPath}/friend?no=<%=list.get(i).getC_m_no() %>">
	                                <span class="reply__thumb">
	                                	<%if(list.get(i).getC_img() != null && !list.get(i).getC_img().equals("")){ %>
		                               	<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=list.get(i).getC_m_no() %>/<%=list.get(i).getC_img() %>">
		                               	<%}else { %>
		                               	<img src="${pageContext.request.contextPath}/images/member_profile.jpg">
		                               	<%} %>
	                                </span>
                                </a>
                                <ul class="reply__cont">
                                    <li class="reply__cont__name"><%=list.get(i).getC_name() %><%if(list.get(i).getC_m_no() == mno){%><span>(방장님)</span><%}%></li>
                                    <li class="reply__cont__text"><%=list.get(i).getC_content() %></li>
                                    <li class="reply__cont__detail">
                                    	<span class="date"><%=date.format(list.get(i).getRegDt()) %></span>
                                    	<button onclick="insert(<%=no %>,<%=list.get(i).getC_no() %>,'true')" class="comment">답글달기</button>
                                         <%if(list.get(i).getC_m_no() == member.getM_no()){%>
                                         <button onclick="del(<%=list.get(i).getC_no() %>,<%=list.get(i).getC_group()%>,'false')" class="comment">답글삭제</button>
                                         <%} %>
                                    </li>
                                </ul>
                              	<%if(list.get(i).getComment().size() > 0){ %>
                              		<%for(int j=0; j<list.get(i).getComment().size(); j++){ %>
	                                <div class="reply__comments">
	                                    <div class="reply">
	                                    	<a href="${pageContext.request.contextPath}/friend?no=<%=list.get(i).getComment().get(j).getC_m_no() %>">
		                                        <span class="reply__thumb">
		                                        <%if(list.get(i).getComment().get(j).getC_img() != null && !list.get(i).getComment().get(j).getC_img().equals("")){ %>
				                               	<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=list.get(i).getComment().get(j).getC_m_no() %>/<%=list.get(i).getComment().get(j).getC_img() %>">
				                               	<%}else { %>
				                               	<img src="${pageContext.request.contextPath}/images/member_profile.jpg">
				                               	<%} %>
		                                        </span>
	                                        </a>
	                                        <ul class="reply__cont">
	                                            <li class="reply__cont__name"><%=list.get(i).getComment().get(j).getC_name() %><%if(list.get(i).getComment().get(j).getC_m_no() == mno){%><span>(방장님)</span><%}%></li>
	                                            <li class="reply__cont__text"><%=list.get(i).getComment().get(j).getC_content() %></li>
	                                            <li class="reply__cont__detail">
	                                            	<span class="date"><%=date.format(list.get(i).getComment().get(j).getRegDt()) %></span>
	                                            	<button onclick="insert(<%=no %>,<%=list.get(i).getComment().get(j).getC_group()%>,'true')" class="comment">답글달기</button>
	                                            	<%if(list.get(i).getComment().get(j).getC_m_no() == member.getM_no()){%>
	                                            	<button onclick="del(<%=list.get(i).getComment().get(j).getC_no() %>,<%=list.get(i).getComment().get(j).getC_group()%>,'true')" class="comment">답글삭제</button>
	                                            	<%} %>
	                                            </li>
	                                        </ul>
	                                    </div>
	                                </div>
                                	<%} %>
                                <%} %>
                            </div>
                            <%} %>
                        </div>
                        <div id="view">
                        	<div class='reply__write on' id="comment">
					        	<form action='./insert' method='post' class=reply__write__area>
					        		<input type='hidden' id="bno" name='bno' value='<%=no%>'>
					        		<input type='hidden' id="mno" name='mno' value='<%=mno %>'>
					        		<input type='hidden' id="cno" name='cno' value='0'>
					        		<input type='hidden' id="parentFl" name='parentFl' value='false'>
					        		<textarea id="commitWriter" name='content' placeholder='댓글을 작성해 주세요'></textarea>
					        		<button type='submit'>게시</button>
					        	</form>
					        </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script>
        function insert(bno,cno,parentFl){  
        	document.getElementById("commitWriter").focus();
        	document.getElementById("bno").value = bno;
        	document.getElementById("mno").value = <%=mno%>;
        	document.getElementById("cno").value = cno;
        	document.getElementById("parentFl").value = parentFl;
        }
        
        function del(cno, gno, parentFl){
        	$.ajax({
				type:"post",
				url:"./del",
				data: {
					no:cno,
					gno:gno,
					parentFl:parentFl
				},
				dateType:"json",
				success:function(msg){
					if(msg = "o"){
						location.href='./list?no=<%=no%>&mno=<%=mno%>';
					}else {
						toast('error',"실패");
					}
				},
				error:function(request,status,error){
					toast('success',"code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			});
        }
    </script>
</body>
</html>