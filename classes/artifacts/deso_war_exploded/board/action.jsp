<%@page import="dto.member.Member"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member m = (Member)session.getAttribute("member");
	String mode = (String)request.getAttribute("mode");
	Board b = (Board)request.getAttribute("board");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat hour = new SimpleDateFormat("HH");
	SimpleDateFormat min = new SimpleDateFormat("mm");
	String appkey = "7d0d7e9b25dde7e8b3361e0a303ccd3a";
	String referer = (String)request.getAttribute("referer");
%>
<jsp:include page="../header.jsp" flush="false" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.9/l10n/ko.min.js" integrity="sha512-v8HZEmf/NZpH4NmT3re/lOJIkoRgBA6IdZIcl7QcRleZ+cffLa1kLKSady054stOAVacsqrkFoJIpcSmy+XNkA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=<%=appkey %>&libraries=services"></script> 
<script src="https://sdk.amazonaws.com/js/aws-sdk-2.809.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/putFile.js"></script>
    <div class="layer">
         <div class="section modal screen" data-modal="location">
            <div class="section service service-terms">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">위치</h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:void(0)" class="menu__group__prev modalClose"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <form class="filter">
                        <fieldset class="field filter__field search">
                            <label for="fLoc" class="label label--s">동위치 입력</label>
                            <div class="search__wrap">
                                <input type="text" id="fLoc" class="bg" placeholder="예) 쌍용동" value="<%=(b.getB_address() != null)?b.getB_address():"" %>" onclick="map()" readonly required>
                            </div>
                        </fieldset>
                        <fieldset class="field filter__field" style="position: relative; z-index: 14;">
                            <label for="fLoc" class="label label--s">상세주소 입력</label>
                            <div class="search__wrap">
                                <input type="text"  id="fLoc2" class="bg" placeholder="상세주소 입력" value="<%=(b.getB_address_sub() != null)?b.getB_address_sub():"" %>" required>
                            </div>
                        </fieldset>
                        <button type="button" onclick="address(event)" class="actions__submit">확인</button>
                    </form>
                </div>
            </div> 
        </div>
    </div>
    <div id="app">
        <main id="main">
            <section class="section meet meet-register">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        <%=(mode.equals("new"))?"모임생성":"모임수정" %>
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="${pageContext.request.contextPath}/<%=referer %>" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content register btm-xl">
                    <div class="section__content__top">
                        <h1 class="logo"><img src="${pageContext.request.contextPath}/images/icon_logo.svg" alt="DESO"></h1>
                        <p class="title">대학생들만 모여모여</p>
                    </div>
                    <form action="process" method="post" id="rgForm" name="action">
                       <input type="hidden" name="mode" value="<%=mode %>">
                       <input type="hidden" name="no" value="<%=(b != null && b.getB_no() != null)?b.getB_no():0 %>">
                       <fieldset class="field pic imgloads imgloads--col2">
                       		<span class="label">사진</span>
                            <div class="imgload">
                                <div class="imgload__cont">
                                    <%if(b.getB_img1() != null && !b.getB_img1().equals("") && !b.getB_img1().equals("null")){ %><img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/meet/mno<%=b.getB_m_no()%>/<%=b.getB_img1()%>" alt="프로필" class="imgload__cont__img"><%} %>
                                    <span class="imgload__cont__btn add">
                                        <input type="file" onchange="filePick(event,1)" accept="image/*" name="file" id="pic01">
                                        <input type="hidden" id="file1" name="img1" value="<%=(b != null && b.getB_img1() != null) ? b.getB_img1() : "" %>">
                                        <label for="pic01" class="<%=(b.getB_img1()!=null && !b.getB_img1().equals("") && !b.getB_img1().equals("null"))?"del":"add"%>"></label>
                                    </span>
                                </div>
                            </div>
                            <div class="imgload">
                                <div class="imgload__cont">
                                	<%if(b.getB_img2() != null && !b.getB_img2().equals("") && !b.getB_img2().equals("null")){ %><img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/meet/mno<%=b.getB_m_no()%>/<%=b.getB_img2()%>" alt="프로필" class="imgload__cont__img"><%} %>
                                    <span class="imgload__cont__btn">
                                        <input type="file" onchange="filePick(event,2)" accept="image/*" name="file" id="pic02">
                                        <input type="hidden" id="file2" name="img2" value="<%=(b != null && b.getB_img2() != null) ? b.getB_img2() : "" %>" >
                                        <label for="pic02" class="<%=(b.getB_img2() != null && !b.getB_img2().equals("") && !b.getB_img2().equals("null"))?"del":"add"%>"></label>
                                    </span>
                                </div>
                            </div>
                            <div class="imgload">
                                <div class="imgload__cont">
                                	<%if(b.getB_img3() != null && !b.getB_img3().equals("") && !b.getB_img3().equals("null")){ %><img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/meet/mno<%=b.getB_m_no()%>/<%=b.getB_img3()%>" alt="프로필" class="imgload__cont__img"><%} %>
                                    <span class="imgload__cont__btn">
                                        <input type="file" onchange="filePick(event,3)" accept="image/*" name="file" id="pic03">
                                        <input type="hidden" id="file3" name="img3" value="<%=(b != null && b.getB_img3() != null) ? b.getB_img3() : "" %>">
                                        <label for="pic03" class="<%=(b.getB_img3() != null && !b.getB_img3().equals("") && !b.getB_img3().equals("null"))?"del":"add"%>"></label>
                                    </span>
                                </div>
                            </div>
                            <div class="imgload">
                                <div class="imgload__cont">
                                	<%if(b.getB_img4() != null && !b.getB_img4().equals("") && !b.getB_img4().equals("null")){ %><img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/meet/mno<%=b.getB_m_no()%>/<%=b.getB_img4()%>" alt="프로필" class="imgload__cont__img"><%} %>
                                    <span class="imgload__cont__btn">
                                        <input type="file" onchange="filePick(event,4)" accept="image/*" name="file" id="pic04">
                                        <input type="hidden" id="file4" name="img4" value="<%=(b != null && b.getB_img4() != null) ? b.getB_img4() : "" %>">
                                        <label for="pic04" class="<%=(b.getB_img4() != null && !b.getB_img4().equals("") && !b.getB_img4().equals("null"))?"del":"add"%>"></label>
                                    </span>
                                </div>
                            </div>
                        </fieldset>
                        <fieldset class="field">
                            <span class="label">모임명</span>
                            <input type="text" name="title" id="mName" class="bg" value="<%=(b != null && b.getB_title() != null)?b.getB_title():"" %>" required>
                        </fieldset>
                        <fieldset class="field field__location">
                            <span class="label">위치</span>
                            <input type="text" id="location" class="bg modalControll" data-modal="location" value="<%=(b.getB_address() != null && b.getB_address_sub() != null)?b.getB_address()+" "+b.getB_address_sub():"위치를 입력해주세요." %>" readonly required>
                            <input type="hidden" name="addr" id="addr" value="<%=(b.getB_address() != null)?b.getB_address():"" %>">
                            <input type="hidden" name="addr2" id="addr2" value="<%=(b.getB_address_sub() != null)?b.getB_address_sub():"" %>">
                            <input type="hidden" name="addrX" id="addrX" value="<%=(b.getB_address_X() != null)?b.getB_address_X():"" %>">
                            <input type="hidden" name="addrY" id="addrY" value="<%=(b.getB_address_Y() != null)?b.getB_address_Y():"" %>">
                            <i class="field__location__icon"></i>  
                        </fieldset>
                        <fieldset class="field">
                            <span class="label">오픈채팅방 주소</span>
                            <input type="text" name="open" id="mOpen" class="bg" value="<%=(b != null && b.getB_open_chatting_url() != null)?b.getB_open_chatting_url():"" %>">
                        </fieldset>
                        <fieldset class="field" style="position: relative; z-index: 15;">
                            <span class="label">카테고리</span>
                            <div class="selectbox">
                                <ul class="selectbox__option">
                                    <li class="selectbox__option__item" data-option="일상">일상</li>
                                    <li class="selectbox__option__item" data-option="커리어">커리어</li>
                                    <li class="selectbox__option__item" data-option="취미">취미</li>
                                    <li class="selectbox__option__item" data-option="엑티비티">엑티비티</li>
                                </ul>
                                <input type="text" name="cate" id="mCategory" class="selectbox__select bg" value="<%=(b != null && b.getB_category() != null)?b.getB_category():"" %>" placeholder="카테고리 선택" readonly required>
                            </div>
                        </fieldset>
                        <fieldset class="field" style="position: relative; z-index: 14;">
                            <span class="label">인원수</span>
                            <div class="selectbox">
                                <input type="text" name="limit" id="mLimit" class="selectbox__select bg" value="<%=(b != null && b.getB_p_limit() != null)?b.getB_p_limit():"" %>" placeholder="인원수 선택" readonly required>
                                <ul class="selectbox__option">
                                    <li class="selectbox__option__item" data-option="3" data-unit="명">3</li>
                                    <li class="selectbox__option__item" data-option="4" data-unit="명">4</li>
                                    <li class="selectbox__option__item" data-option="5" data-unit="명">5</li>
                                    <li class="selectbox__option__item" data-option="6" data-unit="명">6</li>
                                    <li class="selectbox__option__item" data-option="7" data-unit="명">7</li>
                                    <li class="selectbox__option__item" data-option="8" data-unit="명">8</li>
                                    <li class="selectbox__option__item" data-option="9" data-unit="명">9</li>
                                    <li class="selectbox__option__item" data-option="10" data-unit="명">10</li>
                                    <li class="selectbox__option__item" data-option="11" data-unit="명">11</li>
                                    <li class="selectbox__option__item" data-option="12" data-unit="명">12</li>
                                    <li class="selectbox__option__item" data-option="13" data-unit="명">13</li>
                                    <li class="selectbox__option__item" data-option="제한 없음">제한 없음</li>
                                </ul>
                            </div>
                        </fieldset>
                        <fieldset class="field field__date" style="position: relative; z-index: 13;">
                            <span class="label">날짜</span>
                            <input type="text" name="date" id="bDate" class="bg datepicker" value="<%=(b != null && b.getB_time() != null)?date.format(b.getB_time()):"" %>" required readonly>
                            <style> 
                                .flatpickr-calendar { background: #e4e8f7 !important; border-radius: 10px !important; }
                                .flatpickr-calendar.arrowTop:after { border-bottom-color: #e4e8f7 !important; }
                                .flatpickr-day.inRange { background: #add2ff !important; }
                            </style>
                        </fieldset>
                        <fieldset class="field field__time" style="position: relative; z-index: 12;">
                            <span class="label">시간</span>
                            <div class="selectbox">
                                <input type="text" name="mHour" id="mHour" class="selectbox__select bg" placeholder="시" value="<%=(b != null && b.getB_time() != null)?hour.format(b.getB_time()):"" %>" readonly required>
                                <ul class="selectbox__option">
                                    <li class="selectbox__option__item" data-option="0" data-unit="시">0</li>
                                    <li class="selectbox__option__item" data-option="1" data-unit="시">1</li>
                                    <li class="selectbox__option__item" data-option="2" data-unit="시">2</li>
                                    <li class="selectbox__option__item" data-option="3" data-unit="시">3</li>
                                    <li class="selectbox__option__item" data-option="4" data-unit="시">4</li>
                                    <li class="selectbox__option__item" data-option="5" data-unit="시">5</li>
                                    <li class="selectbox__option__item" data-option="6" data-unit="시">6</li>
                                    <li class="selectbox__option__item" data-option="7" data-unit="시">7</li>
                                    <li class="selectbox__option__item" data-option="8" data-unit="시">8</li>
                                    <li class="selectbox__option__item" data-option="9" data-unit="시">9</li>
                                    <li class="selectbox__option__item" data-option="10" data-unit="시">10</li>
                                    <li class="selectbox__option__item" data-option="11" data-unit="시">11</li>
                                    <li class="selectbox__option__item" data-option="12" data-unit="시">12</li>
                                    <li class="selectbox__option__item" data-option="13" data-unit="시">13</li>
                                    <li class="selectbox__option__item" data-option="14" data-unit="시">14</li>
                                    <li class="selectbox__option__item" data-option="15" data-unit="시">15</li>
                                    <li class="selectbox__option__item" data-option="16" data-unit="시">16</li>
                                    <li class="selectbox__option__item" data-option="17" data-unit="시">17</li>
                                    <li class="selectbox__option__item" data-option="18" data-unit="시">18</li>
                                    <li class="selectbox__option__item" data-option="19" data-unit="시">19</li>
                                    <li class="selectbox__option__item" data-option="20" data-unit="시">20</li>
                                    <li class="selectbox__option__item" data-option="21" data-unit="시">21</li>
                                    <li class="selectbox__option__item" data-option="22" data-unit="시">22</li>
                                    <li class="selectbox__option__item" data-option="23" data-unit="시">23</li>
                                </ul>
                            </div>
                            <div class="selectbox">
                                <input type="text" name="mMinute" id="mMinute" class="selectbox__select bg" placeholder="분" value="<%=(b != null && b.getB_time() != null)?min.format(b.getB_time()):"" %>" readonly required>
                                <ul class="selectbox__option">
                                    <li class="selectbox__option__item" data-option="00" data-unit="분">00</li>
                                    <li class="selectbox__option__item" data-option="05" data-unit="분">05</li>
                                    <li class="selectbox__option__item" data-option="10" data-unit="분">10</li>
                                    <li class="selectbox__option__item" data-option="15" data-unit="분">15</li>
                                    <li class="selectbox__option__item" data-option="20" data-unit="분">20</li>
                                    <li class="selectbox__option__item" data-option="25" data-unit="분">25</li>
                                    <li class="selectbox__option__item" data-option="30" data-unit="분">30</li>
                                    <li class="selectbox__option__item" data-option="35" data-unit="분">35</li>
                                    <li class="selectbox__option__item" data-option="40" data-unit="분">40</li>
                                    <li class="selectbox__option__item" data-option="45" data-unit="분">45</li>
                                    <li class="selectbox__option__item" data-option="50" data-unit="분">50</li>
                                    <li class="selectbox__option__item" data-option="55" data-unit="분">55</li>
                                </ul>
                            </div>
                        </fieldset>
                        <fieldset class="field">
                            <span class="label">모임내용</span>
                            <textarea name="content" id="mContent" class="bg" cols="30" rows="10"><%=(b != null && b.getB_content() != null)?b.getB_content():"" %></textarea>
                        </fieldset>
                        <fieldset class="field">
                            <span class="label">모임규칙</span>
                            <textarea name="rule" id="mRule" class="bg" cols="30" rows="10"><%=(b != null && b.getB_rule() != null)?b.getB_rule():""  %></textarea>
                        </fieldset>
                        <%if(mode.equals("mod")){ %>
                        <fieldset class="field">
                            <span class="label">모임상태 변경</span>
                            <div class="toggle">
                                <span class="toggle__label">
                                    모임 완료
                                </span>
                                <span class="toggle__switch">
                                    <input type="checkbox" id="newInfo" name="deadline" value="true" <%if(b.getB_deadline_fl()){ %>checked<%} %>>
                                    <label for="newInfo"></label>
                                </span>
                            </div>
                        </fieldset>
                        <%} %>
			            <div class="actions">
			                <button type="button" onclick="process()" class="actions__submit" form="rgForm"><%=(mode.equals("mod"))?"수정하기":"등록하기" %></button>
			            </div>
                    </form>
                </div>
            </section>
        </main>
    </div>
    <script>
   		function map(){
	    	new daum.Postcode({
	        	oncomplete: function(data) {
	                    
		        var addr = ''; 
		                   
		        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		             addr = data.roadAddress;
		        } else { // 사용자가 지번 주소를 선택했을 경우(J)
		             addr = data.jibunAddress;
		        }
			    	
	    	    document.getElementById('fLoc').value = addr;
    	         	    
	    	    var geo = new daum.maps.services.Geocoder();

	    		geo.addressSearch(addr, function(result, status) {
	    			if (status == daum.maps.services.Status.OK) {
	    				var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	    				var lng = result[0].x;
	    				var lat = result[0].y;

	    				document.getElementById('addrX').value = lat;
			        	document.getElementById('addrY').value = lng;   
	    			}
	    		});
	        }
	      }).open();
	    }
	    	   
    
    	function address(event) {
    		const addr = document.getElementById("fLoc").value,
    			  addr2 = document.getElementById("fLoc2").value;
    		
    		var activate = 'is-activate';
    		
    		if(addr != null && addr != ""){    			
	    		document.getElementById("addr").value = addr;
	    		document.getElementById("addr2").value = addr2;
	    		document.getElementById("location").value = addr+" "+addr2;
	    		event.target.closest('.layer').classList.remove(activate);
	            event.target.closest('.modal').classList.remove(activate);
    		}else {
    			toast('error',"위치를 알려주세요.");
    		}
    	}
    	
    
    	function filePick(event,i){
    		document.getElementById("file"+i).value = event.target.files[0].name;

    		const folder = "board";
    		const folder2 = "meet/mno"+<%=m.getM_no()%>;
    		const file = event.target.files[0];
    		
    		//upload
 	  		putFile(file,folder,folder2);
    	}
    	
    	function process(){
    		const name = document.getElementById("mName");
    		const location = document.getElementById("location");
    		const cate = document.getElementById("mCategory");
    		const limit = document.getElementById("mLimit");
    		const date = document.getElementById("bDate");
    		const mHour = document.getElementById("mHour");
    		const mMinute = document.getElementById("mMinute");
    		const content = document.getElementById("mContent");
    		const file1 = document.getElementById("file1");

			if(file1.value === ""){
				toast('error','대표이미지를 등록해주세요.');
    			file1.focus();
			}else if(name.value === ""){
    			toast('error','모임명을 입력해주세요.');
    			name.focus();
    		}else if(location.value === "위치를 입력해주세요."){
    			toast('error','위치를 입력해주세요.');
    			location.focus();
    		}else if(cate.value === ""){
    			toast('error','카테고리를 선택해주세요.');
    		}else if(limit.value === ""){
    			toast('error','인원수를 선택해주세여.');
    		}else if(date.value === ""){
    			toast('error','날짜를 선택해주세여.');
    		}else if(mHour.value === ""){
    			toast('error','시간을 선택해주세여.');
    		}else if(mMinute.value === ""){
    			toast('error','시간을 선택해주세여.');
    		}else if(content.value === ""){
    			toast('error','내용을 입력해주세요.');
    			content.focus();
    		}else{
    			action.submit();		
    		}
    	
    	}
    </script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/js/datepicker.js"></script>
</body>
</html>