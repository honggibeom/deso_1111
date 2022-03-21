<%@page import="dto.attend.Attend" %>
<%@page import="dto.comment.Comment" %>
<%@page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="dto.board.Board" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Board b = (Board) request.getAttribute("b");
    List<Attend> a = (ArrayList) request.getAttribute("a");

    SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat date2 = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat date3 = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat date4 = new SimpleDateFormat("yyyy-MM-dd");
    int p = (int) request.getAttribute("page");
    String mode = (String) request.getAttribute("mode");
    String action = (String) request.getAttribute("action");
    String appkey = "7d0d7e9b25dde7e8b3361e0a303ccd3a";
    String mk = (mode.equals("모임")) ? "meet" : "event";

%>
<script src="https://sdk.amazonaws.com/js/aws-sdk-2.809.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/putFile.js"></script>
<script type="text/javascript"
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=<%=appkey %>&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<jsp:include page="../aside.jsp" flush="false"/>
<main class="main container-fluid meet-form">
    <div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
        <span class="title fs-4"><%=mode %> <%=(action.equals("update")) ? "상세" : "등록" %></span>
    </div>
    <div class="h-100 w-100 d-flex flex-column align-items-center mt-2">
        <div class="form-wrap form-wrap-l">
            <form action="./process" method="post" name="actionProcess" class="w-100 container-fluid">
                <input type="hidden" name="mode" value="<%=mode%>">
                <input type="hidden" name="action" value="<%=action%>">
                <input type="hidden" name="no" value="<%=(b != null && b.getB_no() != null)?b.getB_no():0 %>">
                    <%if (action.equals("update") && b != null) { %>
                <div class="row w-100 g-3 align-items-center mb-4">
                    <div class="col-2"><label for="meetId" class="col-form-label">주최자 아이디</label></div>
                    <div class="col-auto"><input type="text" id="meetId" class="form-control" value="<%=b.getB_no()%>"
                                                 readonly></div>
                </div>
                    <%} %>
                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="meetName" class="col-form-label"><%=mode %>명</label></div>
                    <div class="col-6"><input type="text" name="title" id="meetName" class="form-control"
                                              value="<%=(b != null)?b.getB_title():"" %>" required></div>
                </div>
                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="meetCate" class="col-form-label">카테고리</label></div>
                    <div class="col-10">
                        <div class="row">
                            <%if (mode.equals("모임")) { %>
                            <div class="col-auto form-check">
                                <input class="form-check-input" type="radio" name="cate" value="일상" id="cate01"
                                       <%if(b != null && b.getB_category().equals("일상")){ %>checked<%} %>>
                                <label class="form-check-label" for="cate01">일상</label>
                            </div>
                            <div class="col-auto form-check">
                                <input class="form-check-input" type="radio" name="cate" value="커리어" id="cate02"
                                       <%if(b != null && b.getB_category().equals("커리어")){ %>checked<%} %>>
                                <label class="form-check-label" for="cate02">커리어</label>
                            </div>
                            <div class="col-auto form-check">
                                <input class="form-check-input" type="radio" name="cate" value="취미" id="cate03"
                                       <%if(b != null && b.getB_category().equals("취미")){ %>checked<%} %>>
                                <label class="form-check-label" for="cate03">취미</label>
                            </div>
                            <div class="col-auto form-check">
                                <input class="form-check-input" type="radio" name="cate" value="액티비티" id="cate04"
                                       <%if(b != null && b.getB_category().equals("액티비티")){ %>checked<%} %>>
                                <label class="form-check-label" for="cate04">액티비티</label>
                            </div>
                            <%} else { %>
                            <div class="col-3" style="display: flex">
                                <select class="form-select" id="meetCate" name="cate" aria-label="Default select example"
                                        name="limit" required>
                                    <option selected disabled></option>
                                    <option value="공연"
                                            <%if(b != null && b.getB_category().equals("공연")){ %>selected<%} %>>공연
                                    </option>
                                    <option value="대학교"
                                            <%if(b != null && b.getB_category().equals("대학교")){ %>selected<%} %>>대학교
                                    </option>
                                    <option value="축제"
                                            <%if(b != null && b.getB_category().equals("축제")){ %>selected<%} %>>축제
                                    </option>
                                    <option value="행사"
                                            <%if(b != null && b.getB_category().equals("행사")){ %>selected<%} %>>행사
                                    </option>
                                    <option value="제한없음"
                                            <%if(b != null && b.getB_category().equals("제한없음")){ %>selected<%} %>>제한 없음
                                    </option>
                                </select>
                                <input type="checkbox" id="charge" class="checkbox"> 유료
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="meetMem" class="col-form-label">인원</label></div>
                    <div class="col-10">
                        <div id="group">
                            <div class="col-10" style="display: flex">
                                <input type="text" id="meetMem" class="group_name form-control" placeholder="그룹명 입력"
                                       required oninput="add_g_name(1)">
                                <input type="text" class="group_num form-control" placeholder="모집정원 입력" required>
                                <input type="checkbox" class="limit"> 제한없음
                            </div>
                            <div class="col-10" style="display: flex">
                                <span>선정방법</span>
                                <input type="radio" name="a1" class="first"> 선착순
                                <input type="radio" name="a1" class="selection"> 개설자 선정
                            </div>
                            <div class="col-10" style="display: flex">
                                <span>정원초과 모집</span>
                                <input type="radio" name="b1" class="allow"> 허용
                                <input type="radio" name="b1" class="notallow"> 허용안함
                            </div>
                        </div>
                        <button class="form-control" type="button" onclick="g_add()">+그룹추가</button>
                    </div>
                </div>
                <hr>
                    <%if (action.equals("update")) { %>
                <div class="row g-3 mb-5">
                    <div class="col-2"><label class="form-label pt-2">참여자</label></div>
                    <div class="col-10">
                        <div class="accordion-button collapsed" data-bs-toggle="collapse" href="#joins" role="button"
                             aria-expanded="false" aria-controls="joins">
                            <span>참여자 목록</span>
                            <span class="col-auto badge bg-secondary rounded-pill mx-2"><%=b.getB_p_count() %></span>
                        </div>
                        <div class="collapse" id="joins">
                            <ul class="list-group list-group-flush">
                                <%for (int i = 0; i < a.size(); i++) { %>
                                <%if (a.get(i).getKind()) { %>
                                <li class="list-group-item"><span><%=a.get(i).getM_no() %> 번</span><span
                                        class="fw-bolder mx-2"><%=a.get(i).getM_name() %></span></li>
                                <%} %>
                                <%} %>
                            </ul>
                        </div>
                    </div>
                </div>
                    <%if (mode.equals("모임")) { %>
                <div class="row g-3 mb-5">
                    <div class="col-2"><label class="form-labell pt-2">대기자</label></div>
                    <div class="col-10">
                        <div class="accordion-button collapsed" data-bs-toggle="collapse" href="#waitings" role="button"
                             aria-expanded="false" aria-controls="waitings">
                            <span>대기자 목록</span>
                            <span class="col-auto badge bg-secondary rounded-pill mx-2"><%=b.getB_p_w_count() %></span>
                        </div>
                        <div class="collapse" id="waitings">
                            <ul class="list-group list-group-flush">
                                <%for (int i = 0; i < a.size(); i++) { %>
                                <%if (!a.get(i).getKind()) { %>
                                <li class="list-group-item"><span><%=a.get(i).getM_no() %> 번</span><span
                                        class="fw-bolder mx-2"><%=a.get(i).getM_name() %></span></li>
                                <%} %>
                                <%} %>
                            </ul>
                        </div>
                    </div>
                </div>
                    <%}%>
                <hr>
                    <%}%>

                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="meetLoc" class="col-form-label">위치</label></div>
                    <div class="col-10">
                        <input type="text" id="meetLoc" class="form-control"
                               value="<%=(b != null)?b.getB_address():""%>" placeholder="위치를 입력해주세요."
                               onclick="mapView()" required readonly>
                        <input type="hidden" name="addr" id="addr"
                               value="<%=(b != null && b.getB_address() != null)?b.getB_address():"" %>">
                        <input type="hidden" name="addrX" id="addrX"
                               value="<%=(b != null && b.getB_address_X() != null)?b.getB_address_X():"" %>">
                        <input type="hidden" name="addrY" id="addrY"
                               value="<%=(b != null && b.getB_address_Y() != null)?b.getB_address_Y():"" %>">
                        <div id="map"></div>
                    </div>
                </div>
                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="meetLoc2" class="col-form-label">상세주소</label></div>
                    <div class="col-10">
                        <input type="text" name="addr2" id="meetLoc2" class="form-control"
                               value="<%=(b != null)?b.getB_address_sub():"" %>" placeholder="상세주소를 입력해주세요." required>
                    </div>
                </div>
                <div class="row g-3 mb-4" >
                    <div class="col-2"><label for="meetDate" class="col-form-label">신청기간</label></div>
                    <div class="col-8">
                        <div style="display: flex">
                            <div class="col-8">
                                <span>시작일시</span>
                                <div class="d-flex flex-row justify-content-start">
                                    <div class="col-5">
                                        <input type="date" id="meetDate" name="date" class="form-control datepicker input-date"
                                            value="<%=(b != null)?date.format(b.getB_time()):"" %>" data-input required>
                                    </div>
                                    <div class="col-5 d-flex flex-row">
                                        <input type="time" id="mMinute" name="Time" class="form-control timepicker input-time" data-input required>
                                    </div>
                                </div>
                            </div>
                            <div class="col-8">
                                <span>종료일시</span>
                                <div class="d-flex flex-row justify-content-start">
                                    <div class="col-5">
                                        <input type="date" id="meetDate" name="date2" class="form-control datepicker input-date"
                                            value="<%=(b != null)?date2.format(b.getB_time()):"" %>" data-input required>
                                    </div>
                                    <div class="col-5 d-flex flex-row">
                                        <input type="time" id="mMinute" name="Time2" class="form-control timepicker input-time" data-input required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <span style="padding-left: 17%">※신청 종료일시는 시작일시보다 뒤로 설정해주세요!</span>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="meetDate" class="col-form-label">행사기간</label></div>
                    <div class="col-8">
                        <div style="display: flex">
                            <div class="col-8">
                                <span>시작일시</span>
                                <div class="d-flex flex-row justify-content-start">
                                    <div class="col-5">
                                        <input type="date" id="meetDate1" name="date3" class="form-control datepicker input-date"
                                               value="<%=(b != null)?date3.format(b.getB_time()):"" %>" data-input required >
                                    </div>
                                    <div class="col-5 d-flex flex-row">
                                        <input type="time" id="mMinute" name="Time3" class="form-control timepicker input-time" data-input required>
                                    </div>
                                </div>
                            </div>
                            <div class="col-8">
                                <span>종료일시</span>
                                <div class="d-flex flex-row justify-content-start">
                                    <div class="col-5">
                                        <input type="date" id="meetDate" name="date4" class="form-control datepicker input-date"
                                           value="<%=(b != null)?date4.format(b.getB_time()):"" %>" data-input required>
                                    </div>
                                    <div class="col-5 d-flex flex-row">
                                        <input type="time" id="mMinute1" name="Time4" class="form-control timepicker input-time" data-input required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <span style="padding-left: 17%" >※행사 종료일시는 시작일시보다 뒤로 설정해주세요!</span>
                </div>
                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="meetConts" class="col-form-label"><%=mode %> 내용</label></div>
                    <div class="col-10">
                        <textarea class="form-control" name="content" id="meetConts" rows="8"
                                  required><%=(b != null) ? b.getB_content() : "" %></textarea>
                    </div>
                </div>
                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="meetRules" class="col-form-label"><%=mode %> 규칙</label></div>
                    <div class="col-10">
                        <textarea class="form-control" name="rule" id="meetRules" rows="8"
                          required><%=(b != null) ? b.getB_rule() : "" %></textarea>
                    </div>
                </div>
                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="meetUrl" class="col-form-label">참가신청 URL</label></div>
                    <div class="col-10">
                        <input type="text" name="open" id="meetUrl" class="form-control" placeholder="신청 홈페이지가 있으면 도메인 주소를 입력해 주세요.">
                    </div>
                </div>
                <div class="row g-3 mb-4">
                    <div class="col-2"><label for="addinfo" class="col-form-label">추가정보</label></div>
                    <div class="col-10">
                        <div class="group2">
                            <div style="display: flex">
                                <select style="height: 38px" id="addinfo" class="addinfo col-2 " aria-label="Default select example" name="limit" required>
                                    <option selected disabled>그룹명</option>
                                    <option class="g_name" value="" <%if(b != null){ %>selected<%} %>></option>
                                </select>
                                <select id="selectBox1" style="height: 38px" class="col-2 selectBox" aria-label="Default select example" name="limit" required>
                                    <option value="객관식" <%if(b != null && b.getB_p_limit().equals("객관식")){ %>selected<%} %>>
                                        객관식
                                    </option>
                                    <option value="주관식" <%if(b != null && b.getB_p_limit().equals("주관식")){ %>selected<%} %>>
                                        주관식
                                    </option>
                                </select>
                                <div class="col-6 question">
                                    <input type="text" name="open" id="answer" class="form-control" placeholder="질문을 입력해 주세요.">
                                    <table class="group3" id="group3-1">
                                        <tr>
                                            <td>1. </td>
                                            <td>
                                                <input type="text" name="open" id="item1-1" class="form-control" placeholder="각 항목을 입력해 주세요.">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2. </td>
                                            <td>
                                                <input type="text" name="open" id="item1-2" class="form-control" placeholder="각 항목을 입력해 주세요.">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>3. </td>
                                            <td>
                                                <input type="text" name="open" id="item1-3" class="form-control" placeholder="각 항목을 입력해 주세요.">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>4. </td>
                                            <td>
                                                <input type="text" name="open" id="item1-4" class="form-control" placeholder="각 항목을 입력해 주세요.">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>5. </td>
                                            <td>
                                                <input type="text" name="open" id="item1-5" class="form-control" placeholder="각 항목을 입력해 주세요.">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <input id="necessary" type="checkbox" class="checkbox"> 필수
                                <button style="height: 38px" class="btn_add" type='button' >+</button>
                                <button style="height: 38px" class="btn_del" type='button' >-</button>
                            </div>
                        </div>
                        <button class="form-control" type="button" onclick="g2_add()">+문항추가</button>
                    </div>
                </div>

                <div class="row g-3 mb-5">
                    <div class="col-2"><label class="col-form-label">사진</label></div>
                    <div id="group4" class="col-10 d-flex flex-row" style="overflow-x: auto">
                        <div class="img_load p-1">
                            <div class="label_wrap">
                                <label class="d-block rounded" for="file01">
                                    <%if ((b != null) && (b.getB_img1() != null && !b.getB_img1().equals(""))) {%>
                                    <img class="img"
                                         src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/<%=mk %>/mno<%=b.getB_m_no()%>/<%=b.getB_img1()%>">
                                    <%} %>
                                </label>
                            </div>
                            <div class="d-flex flex-column">
                                <input name="file" onchange="filePick(event,1)" class="d-block my-3" id="file01" type="file"
                                       style="visibility: hidden; height: 0px" accept="image/*">
                                <input type="hidden" id="file1" name="img1"
                                        value="<%=(b != null && b.getB_img1() != null)?b.getB_img1():""%>">
                                <button class="btn btn_del border-secondary btn-block img-del">이미지 삭제</button>
                            </div>
                        </div>

                        <div class="img_load p-1">
                            <div class="label_wrap">
                                <label class="d-block rounded" for="file02">
                                    <%if ((b != null) && (b.getB_img2() != null && !b.getB_img2().equals(""))) {%>
                                    <img class="img"
                                         src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/<%=mk %>/mno<%=b.getB_m_no()%>/<%=b.getB_img2()%>">
                                    <%} %>
                                </label>
                            </div>
                            <div class="d-flex flex-column">
                                <input name="file" onchange="filePick(event,2)" class="d-block my-3" id="file02" type="file"
                                       style="visibility: hidden; height: 0px" accept="image/*">
                                <input type="hidden" id="file2" name="img2"
                                       value="<%=(b != null && b.getB_img2() != null)?b.getB_img2():""%>">
                                <button class="btn btn_del border-secondary btn-block img-del">이미지 삭제</button>
                            </div>
                        </div>

                        <div class="img_load p-1">
                            <div class="label_wrap">
                                <label class="d-block rounded" for="file03" >
                                    <%if ((b != null) && (b.getB_img3() != null && !b.getB_img3().equals(""))) {%>
                                    <img class="img"
                                         src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/<%=mk %>/mno<%=b.getB_m_no()%>/<%=b.getB_img3()%>">
                                    <%} %>

                                </label>
                            </div>
                            <div class="d-flex flex-column">
                                <input name="file" onchange="filePick(event,3)" class="d-block my-3" id="file03" type="file"
                                       style="visibility: hidden; height: 0px" accept="image/*">
                                <input type="hidden" id="file3" name="img3"
                                       value="<%=(b != null && b.getB_img3() != null)?b.getB_img3():""%>">
                                <button class="btn btn_del border-secondary btn-block img-del">이미지 삭제</button>
                            </div>
                        </div>
                        <button type="button " style="background-color: #ffffff; border:none" id="img_add" onclick="add_img()"><img src="../images/icon_img_add.png" alt="이미지 추가" style="padding-bottom: 45%" ></button>
                    </div>
                </div>

                <hr>
                <%if (action.equals("update")) { %>
                <div class="row g-3 mb-5">
                    <div class="col-2"><label class="form-labell pt-2">댓글</label></div>
                    <div class="col-10">
                        <div class="accordion-button collapsed" data-bs-toggle="collapse" href="#comments" role="button"
                            aria-expanded="false" aria-controls="comments">
                            <span>댓글 목록</span>
                            <span id="commentSize" class="col-auto badge bg-secondary rounded-pill mx-2"></span>
                        </div>
                        <div class="collapse" id="comments"></div>
                    </div>
                </div>
                <hr>
                <%} %>
                <div class="d-flex justify-content-between pt-2">
                    <%if (action.equals("update")) { %>
                    <a href="./del?no=<%=b.getB_no() %>&mode=<%=b.getB_kind() %>" class="btn btn-outline-dark">삭제</a>
                    <%} %>
                    <span>
	                    <a href="./list?page=<%=p %>&mode=<%=mode%>" class="btn mx-5">취소</a>
                        <button type="button" onclick="process()"
                                class="btn btn-dark"><%=(action.equals("update") ? "수정" : "등록") %>하기</button>
                        <button type="button" onclick="preview()" class="btn btn-dark">미리보기</button>
                    </span>
                </div>
            </form>
        </div>
    </div>
</main>
<script>
    <%if(action.equals("update")){%>
    mapWidth();
    map('<%=b.getB_address()%>');

    window.addEventListener('load', commentBtn(<%=b.getB_no()%>));

    function commentBtn(no) {
        $.ajax({
            type: "post",
            url: "../comment",
            data: {
                no: no,
            },
            dateType: "json",
            success: function (comments) {
                comment(JSON.parse(comments));
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }

        });
    }

    function comment(comments) {
        const mno = <%=b.getB_m_no()%>;
        var v = "";
        v += "<ul class='list-group list-group-flush'>";
        for (let i = 0; i < comments.length; i++) {
            v += "<li class='list-group-item'>";
            v += "<div class='d-flex flex-row justify-content-between'>";
            v += "<span class='col-10'>";
            v += "<span class='txt'>" + comments[i].content + "</span>";
            if (mno === comments[i].mno) {
                v += "<span class='col-auto badge rounded-pill badge-host mx-2'>방장</span>";
            }
            v += "</span>";
            v += "<button type='button' onclick='commentDel(" + comments[i].no + ")' class='col-auto bg-gray-400 rounded-pill btn-del'></button>";
            v += "</div>";
            v += "<small class='text-muted'>" + comments[i].date + "</small>";
            v += "</li>";
        }
        v += "</ul>";

        document.getElementById("commentSize").innerHTML = comments.length;
        document.getElementById("comments").innerHTML = v;
    }

    function commentDel(no) {
        $.ajax({
            type: "post",
            url: "../comment/del",
            data: {
                no: no
            },
            dateType: "json",
            success: function () {
                alert("삭제되었습니다.");
                commentBtn(<%=b.getB_no()%>);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }

        });
    }

    <%}%>

    function mapView() {
        new daum.Postcode({
            oncomplete: function (data) {

                var addr = '';

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                document.getElementById("addr").value = addr;
                document.getElementById("meetLoc").value = addr;
                mapWidth();
                map(addr);
            }
        }).open();
    }

    function map(addr) {

        var geo = new daum.maps.services.Geocoder();
        geo.addressSearch(addr, function (result, status) {
            if (status == daum.maps.services.Status.OK) {
                var coords = new daum.maps.LatLng(result[0].y, result[0].x);
                lng = result[0].x;
                lat = result[0].y;

                document.getElementById('addrX').value = lat;
                document.getElementById('addrY').value = lng;

                var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                    mapOption = {
                        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
                        level: 3 // 지도의 확대 레벨
                    };

                // 지도를 생성합니다
                var map = new kakao.maps.Map(mapContainer, mapOption);

                var marker = new kakao.maps.Marker({
                    map: map,
                    position: new kakao.maps.LatLng(lat, lng)
                });
            }
        });

    }

    function mapWidth() {
        document.getElementById('map').style.width = 100 + "%";
        document.getElementById('map').style.height = 400 + "px";
        document.getElementById('map').style.marginTop = 10 + "px";
    }

    function filePick(event, i) {
        document.getElementById("file" + i).value = event.target.files[0].name;
        const folder = "board";
        const folder2 = "<%=mk%>/mno" +<%=(b != null)?b.getB_m_no():0%>;
        const file = event.target.files[0];

        //upload
        putFile(file, folder, folder2);
    }

    //이미지 로드 스크립트
    function imgloadFn() {
        var addBtns = document.querySelectorAll('.img_load input');
        var delBtns = document.querySelectorAll('.img_load .btn_del');

        addBtns.forEach(btn => {
            btn.addEventListener('input', addImg);
        });

        delBtns.forEach(btn => {
            btn.addEventListener('click', delImg);
        });

        function delImg(event) {
            event.preventDefault();
            var imgload = event.target.closest('.img_load');
            var label = imgload.getElementsByTagName('label')[0];

            if (imgload.getElementsByTagName('img')[0] != null) {
                imgload.getElementsByTagName('img')[0].remove();
                imgload.getElementsByTagName('input')[1].value = "";
            }
        };

        function addImg(event) {
            var maxSize = 3 * 1024 * 1024;
            if (event.target.files[0].size > maxSize) {
                alert("이미지 파일 용량이 커서 등록되지 않습니다. 3MB 이하로 등록해주세요.");
                return false;
            } else {
                var input = event.target;
                var imgload = input.closest('.img_load');
                var label = imgload.querySelector('label');

                var fReader = new FileReader();
                fReader.onload = function (event) {
                    if (imgload.getElementsByTagName('img')[0] != null) {
                        imgload.getElementsByTagName('img')[0].remove();
                    }
                    var img = document.createElement('img');
                    img.setAttribute('src', event.target.result);
                    label.appendChild(img);
                };
                fReader.readAsDataURL(input.files[0]);
            }
            ;
        };
    };


    function process() {
        const file1 = document.getElementById("file1");
        const meetName = document.getElementById("meetName");
        const cate = document.getElementById("meetCate");
        const meetMem = document.getElementById("meetMem");
        const addr = document.getElementById("addr");
        const meetLoc2 = document.getElementById("meetLoc2");
        const mMinute = document.getElementById("mMinute");
        const meetConts = document.getElementById("meetConts");
        const meetRules = document.getElementById("meetRules");


        console.log(meetLoc.value);

        if (file1.value === "") {
            alert('대표이미지를 등록해주세요.');
            file1.focus();
        } else if (meetName.value === "") {
            alert('모임명을 입력해주세요.');
            meetName.focus();
        } else if (cate.value === "") {
            alert('카테고리를 선택해주세요.');
        } else if (meetMem.value === "모임 인원" || meetMem.value === "행사 인원") {
            alert('인원수를 선택해주세요.');
            meetMem.focus();
        } else if (addr.value === "") {
            alert('주소를 등록해주세요.');
            addr.focus();
        } else if (meetLoc2.value === "") {
            alert('상세주소를 등록해주세요.');
            meetLoc2.focus();
        } else if (meetDate.value === "") {
            alert('날짜를 선택해주세요.');
            meetDate.focus();
        } else if (mMinute.value === "") {
            alert('시간을 선택해주세요.');
            mMinute.focus();
        } else if (meetConts.value === "") {
            alert('내용을 입력해주세요.');
            meetConts.focus();
        } else if (meetRules.value === "") {
            alert('규칙을 입력해주세요.');
            meetRules.focus();
        } else {
            actionProcess.submit();
        }
    }

    window.addEventListener('load', function () {
        imgloadFn();
    });

    let num = 2;

    function g_add() {
        const c = "<div class=\"col-10\" style=\"display: flex\">" +
            "<span>선정방법</span>" +
            "<input type=\"radio\" name=\"a" + num + "\" class=\"first\"> 선착순" +
            "<input type=\"radio\" name=\"a" + num + "\" class=\"selection\"> 개설자 선정" +
            "</div>"

        const a = "<div class=\"col-10\" style=\"display: flex\">" +
            "<span>정원초과 모집</span>" +
            "<input type=\"radio\" name=\"b" + num + "\" class=\"allow\"> 허용" +
            "<input type=\"radio\" name=\"b" + num + "\" class=\"notallow\"> 허용안함" +
            "</div>"

        const newItem = "<div class=\"col-10\" style=\"display: flex\">"
            + "<input type=\"text\" class=\"group_name form-control\" placeholder=\"그룹명 입력\" required oninput=\"add_g_name(" + num + ")\">"
            + "<input type=\"text\" class=\"group_num form-control\" placeholder=\"모집정원 입력\" required>"
            + "<input type=\"checkbox\" class=\"limit\"> 제한없음 </div>" + c + a

        $("#group").append(newItem);

        const text = "<option class=\"g_name\"+ value=\"\" <%if(b != null){ %>selected<%} %>></option>"
        $(".addinfo").append(text)
        num++;
    }

    let num2 = 1;
    let arr = [];
    arr[0] = 6;
    function g2_add() {
        arr[num2] = 6;
        num2++;
        const text = ` <div style="display: flex">`
            + document.getElementsByClassName("addinfo").item(0).outerHTML +
            `<select id="selectBox`+ num2 +`" style="height: 38px" class="col-2 selectBox" aria-label="Default select example" name="limit" required>
                    <option value="객관식" <%if(b != null && b.getB_p_limit().equals("객관식")){ %>selected<%} %>>객관식</option>
                    <option value="주관식" <%if(b != null && b.getB_p_limit().equals("주관식")){ %>selected<%} %>>주관식</option>
                </select>
                <div class="col-6 question">
                    <input type="text" name="open" id="answer" class="form-control" placeholder="질문을 입력해 주세요.">
                        <table class="group3" id="group3-` + num2 + `">
                            <tr>
                                <td>1. </td>
                                <td>
                                    <input type="text" name="open" id="item`+ num2 +`-1" class="form-control" placeholder="각 항목을 입력해 주세요.">
                                </td>
                            </tr>
                            <tr>
                                <td>2. </td>
                                <td>
                                    <input type="text" name="open" id="item`+ num2 +`-2" class="form-control" placeholder="각 항목을 입력해 주세요.">
                                </td>
                            </tr>
                            <tr>
                                <td>3. </td>
                                <td>
                                    <input type="text" name="open" id="item`+ num2 +`-3" class="form-control" placeholder="각 항목을 입력해 주세요.">
                                </td>
                            </tr>
                            <tr>
                                <td>4. </td>
                                <td>
                                    <input type="text" name="open" id="item`+ num2 +`-4" class="form-control" placeholder="각 항목을 입력해 주세요.">
                                </td>
                            </tr>
                            <tr>
                                <td>5. </td>
                                <td>
                                    <input type="text" name="open" id="item`+ num2 +`-5" class="form-control" placeholder="각 항목을 입력해 주세요.">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <input id="necessary" type="checkbox" class="checkbox"> 필수
                    <button style="height: 38px" class="btn_add" type='button' >+</button>
                    <button style="height: 38px" class="btn_del" type='button' >-</button>
                </div>`
        $(".group2").append(text);
    }

    $(document).on('click', '.btn_add', function(){
        let idx = $('.btn_add').index(this);
        /*console.log(idx + 1);*/
        const table = document.getElementById('group3-' + (idx + 1));
        const newRow = table.insertRow();
        const newCell1 = newRow.insertCell(0);
        const newCell2 = newRow.insertCell(1);
        newCell1.innerText = arr[idx] + '. ';
        newCell2.innerHTML = `<input type="text" name="open" id="item` + (idx + 1) + `-` + arr[idx] +
            `" class="form-control" placeholder="각 항목을 입력해 주세요.">`;
        arr[idx]++;
        /*console.log(arr[idx])*/
    });

    $(document).on('click', '.btn_del', function(){
        let idx = $('.btn_del').index(this);
        const table = document.getElementById('group3-' + (idx + 1));
        const newRow = table.deleteRow(-1);
        arr[idx]--;
        /*console.log(arr[idx])*/
    });

    $(document).on('click', '.selectBox', function() {
        let idx = $('.selectBox').index(this);
        /*console.log('selectBox의 index: ' + (idx + 1));*/
        let table = document.getElementsByClassName('group3').item(idx);
        let btnA = document.getElementsByClassName('btn_add').item(idx);
        let btnB = document.getElementsByClassName('btn_del').item(idx);
        /*console.log($(table))
        console.log($('#selectBox'+(idx+1)+' option:selected'))
        console.log($('#selectBox2 option:selected'))*/

        let result = $('#selectBox'+(idx+1)+' option:selected').val();
        if (result == "객관식") {
            $(table).show();
            $(btnA).show();
            $(btnB).show();
        } else {
            $(table).hide();
            $(btnA).hide();
            $(btnB).hide();
        }
    });

    function add_g_name(number) {
        //num2-1=질문개수
        //num-1=그룹개수
        let name = document.getElementsByClassName('group_name').item(number - 1).value
        for (let i = 1; i < num2; i++) {
            document.getElementsByClassName("g_name").item(number - 1).value = name
            document.getElementsByClassName("g_name").item(number - 1).textContent = name
            number += (num - 1)
        }
    }

    function add_img() {
        let img_add = document.getElementById("img_add")
        const a = "<div class=\"img_load p-1\">" + "<div class=\"label_wrap\">" +
            "<label class=\"d-block rounded\" for=\"file04\">" + "<%if ((b != null) && (b.getB_img3() != null && !b.getB_img3().equals(""))) {%>" +
            "<img src=\"https://s3.ap-northeast-2.amazonaws.com/deso-file/board/<%=mk %>/mno<%=b.getB_m_no()%>/<%=b.getB_img3()%>\">" + "<%} %>" +
            "</label>" + "</div>" + "<div class=\"d-flex flex-column\">" +
            "<input name=\"file\" onchange=\"filePick(event,3)\" class=\"d-block my-3\" id=\"file03\" type=\"file\" accept=\"image/*\" style=\"visibility: hidden; height: 0px\">" +
            "<input type=\"hidden\" id=\"file3\" name=\"img3\" value=\"<%=(b != null && b.getB_img3() != null)?b.getB_img3():""%>\">" +
            "<button class=\"btn btn_del border-secondary btn-block img-del\">이미지 삭제</button>" + "</div>" + "</div>"
        $(a).insertBefore(img_add)
    }

    function preview() {
        localStorage.setItem("meetname", document.getElementById("meetName").value)
        localStorage.setItem("meetMem", document.getElementById("meetMem").value)
        localStorage.setItem("meetCate", document.getElementById("meetCate").value)
        localStorage.setItem("charge", document.getElementById("charge").checked)
        // for(let i = 0;i<4;i++){
        //   if(document.getElementsByClassName("img").item(i).src==null)
        //         break;
        //     localStorage.setItem("img"+i,document.getElementsByClassName("img").item(i).src==null)
        // }

        // localStorage.setItem("img",document.getElementsByClassName("img").item(0).src)
        localStorage.setItem("meetLoc", document.getElementById("meetLoc").value)
        localStorage.setItem("meetLoc2", document.getElementById("meetLoc2").value)
        localStorage.setItem("meetConts", document.getElementById("meetConts").value)
        localStorage.setItem("meetRules", document.getElementById("meetRules").value)
        localStorage.setItem("meetUrl", document.getElementById("meetUrl").value)
        window.open("preview.html")

    }

</script>

<jsp:include page="../footer.jsp" flush="false"/>
