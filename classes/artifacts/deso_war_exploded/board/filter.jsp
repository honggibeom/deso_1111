<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mode = (String)request.getAttribute("mode");	
	String addr = (String)request.getAttribute("addr");
	String cate = (String)request.getAttribute("cate");
	String date = (String)request.getAttribute("date");
%>
<jsp:include page="../header.jsp" flush="false" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.7.2/proj4.js"></script>
<style>
	#list{margin-top:5px; overflow-y: scroll; max-height: 300px;}
	#list .adr{width:100%; border-bottom: 1px solid #fff;}
	#list .adr.on{cursor: pointer;}
	#list .adr.no{cursor: auto;}
	#list .adr:first-child {border-radius:10px 10px 0 0;}
	#list .adr:last-child {border-radius:0 0 10px 10px; border-bottom: 0;}
</style>
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
                    <form class="filter" name="form" id="form"method="post">
                        <fieldset class="field filter__field" style="position: relative; z-index: 14;">
                            <label for="fLoc01" class="label">위치</label>
                            <div class="selectbox">
                                <input type="text" id="fLoc01" name="keyword2" class="selectbox__select bg" placeholder="지역을 선택해 주세요." readonly required>
                                <ul class="selectbox__option">
                                    <li class="selectbox__option__item" data-option="천안">천안</li>
                                    <li class="selectbox__option__item" data-option="아산">아산</li>
                                </ul>
                            </div>
                        </fieldset>
                        <fieldset class="field filter__field search">
                            <label for="fLoc" class="label label--s">동위치 입력</label>
                            <div class="search__wrap">
                                <input type="text" id="fLoc02" class="bg" placeholder="예) 쌍용동"  name="keyword" onkeydown="enterSearch();">
                            </div>
	                        <div id="list" ></div>
                        </fieldset>
                        
                        <button style="height:auto" type="button" type="button" onClick="getAddrLoc();" class="actions__submit">주소검색하기</button>
                    </form>       
                </div>             
            </div> 
        </div>
    </div>
    <div id="app">
        <main id="main">
            <section class="section meet meet-filter meet-filter">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">필터</h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:history.back();" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <form action="./list" method="get" class="filter">
                    	<input type="hidden" name="mode" value="<%=mode %>">
                        <fieldset class="filter__field search">
                            <input type="text" name="addr" id="fLoc" class="bg modalControll" data-modal="location" placeholder="검색할 위치를 입력해 주세요." value="<%=(addr != null && !addr.equals(""))?addr:"" %>" readonly required>
                            <input type="hidden" id="locationX" name="locationX">
                            <input type="hidden" id="locationY" name="locationY">
                        </fieldset>
                        <div class="filter__field filter__category">
                            <span class="label">일상</span>
                            <div class="category__list">
                            	<%if(mode.equals("모임")){ %>
                                <span class="category__item radiobox">
                                    <input type="radio" name="cate" id="cLife" value="일상" <%if(cate != null && cate.equals("일상")) {%>checked<%} %>>
                                    <label class="category__item__name" for="cLife"><i class="icon icon--video"></i>일상</label>
                                </span>
                                <span class="category__item radiobox">
                                    <input type="radio"  name="cate" id="cCareer" value="커리어" <%if(cate != null && cate.equals("커리어")) {%>checked<%} %>>
                                    <label class="category__item__name" for="cCareer"><i class="icon icon--gear"></i>커리어</label>
                                </span>
                                <span class="category__item radiobox">
                                    <input type="radio"  name="cate" id="cHobby" value="취미" <%if(cate != null && cate.equals("취미")) {%>checked<%} %>>
                                    <label class="category__item__name" for="cHobby"><i class="icon icon--lemon"></i>취미</label>
                                </span>
                                <span class="category__item radiobox">
                                    <input type="radio"  name="cate" id="cActivity" value="액티비티" <%if(cate != null && cate.equals("액티비티")) {%>checked<%} %>>
                                    <label class="category__item__name" for="cActivity"><i class="icon icon--rocket"></i>액티비티</label>
                                </span>
                                <%}else if(mode.equals("행사")){ %>
                                <span class="category__item radiobox">
                                    <input type="radio" name="cate" id="cLife" value="대학교" <%if(cate != null && cate.equals("대학교")) {%>checked<%} %>>
                                    <label class="category__item__name" for="cLife"><i class="icon icon--video"></i>대학교</label>
                                </span>
                                <span class="category__item radiobox">
                                    <input type="radio" name="cate" id="cCareer" value="축제" <%if(cate != null && cate.equals("축제")) {%>checked<%} %>>
                                    <label class="category__item__name" for="cCareer"><i class="icon icon--home"></i>축제</label>
                                </span>
                                <span class="category__item radiobox">
                                    <input type="radio" name="cate" id="cHobby" value="행사" <%if(cate != null && cate.equals("행사")) {%>checked<%} %>>
                                    <label class="category__item__name" for="cHobby"><i class="icon icon--camera"></i>행사</label>
                                </span>
                                <span class="category__item radiobox">
                                    <input type="radio" name="cate" id="cActivity" value="공연" <%if(cate != null && cate.equals("공연")) {%>checked<%} %>>
                                    <label class="category__item__name" for="cActivity"><i class="icon icon--docs"></i>공연</label>
                                </span>
                                <%} %>
                            </div>
                        </div>
                        <fieldset class="filter__field date">
                            <span class="label">날짜</span>
                            <input id="fDate" class="bg datepicker" name="date" data-mode="range" value="<%=(date != null && !date.equals(""))?date:""%>">
                            <style> 
                                .flatpickr-calendar { background: #e4e8f7 !important; border-radius: 10px !important; }
                                .flatpickr-calendar.arrowTop:after { border-bottom-color: #e4e8f7 !important; }
                                .flatpickr-day.inRange { background: #add2ff !important; }
                            </style>
                        </fieldset>
                        <div class="actions">
                        	<button type="submit" class="actions__submit">확인</button>
                        </div>
                    </form>
                </div>
            </section>
        </main>
    </div>
    <script>	    
    	function getAddrLoc(){
    		// 적용예 (api 호출 전에 검색어 체크)
    		const keyword = document.form.keyword2.value + document.form.keyword.value;
    		console.log(keyword);
    		if (!checkSearchedWord(keyword)) {
    			return ;
    		}

    		$.ajax({
    			 url :"../map"
    			,type:"post"
    			,data:$("#form").serialize()
    			,dataType:"json"
    			,success:function(jsonStr){
    				$("#list").html("");
    				var errCode = jsonStr.results.common.errorCode;
    				var errDesc = jsonStr.results.common.errorMessage;
    				if(errCode != "0"){
    					alert(errCode+"="+errDesc);
    				}else{
    					if(jsonStr != null){
    						makeListJson(jsonStr);
    					}
    				}
    			}
    		    ,error: function(xhr,status, error){
    		    	
    		    	alert("에러발생");
    		    }
    		});
    	}

    	function makeListJson(jsonStr){
    		const juso = jsonStr.results.juso;
    		
    		let dong = [];
    		
    		var j = 0;
    		for(var i=0; i<juso.length; i++){
    			
    				if(dong.length > 0){
    					if (!dong[j].admCd.includes(juso[i].admCd)) {
    						dong.push(juso[i]);
    						j++;	
    					}
    				}else {
    					dong.push(juso[i]);
    				}	
    			
    		}
    		var htmlStr = ""; 
    		if(dong.length > 0){    			
	    		$(dong).each(function(index){
	    			const data = [this.admCd,this.rnMgtSn,this.udrtYn,this.buldMnnm,this.buldSlno];
	    			var name = this.sggNm+" "+this.emdNm;
	    			htmlStr += "<input class='adr on' type='button' id='adr"+index+"' onClick='address2(event,"+index+","+data+")' value='"+name+"' />";
	    		}); 		
    		}else {
    			htmlStr += "<input class='adr no' type='text' value='입력하신 지역은 존재하지 않습니다.' readonly/>";
    		}
    		
    		$("#list").html(htmlStr);
    	}

    	function address2(event, index, ...data){
    		var activate = 'activate';
    		var eleme = "adr"+index;    				
    		const addr = document.getElementById(eleme).value;
    		
    		
    		$.ajax({
    			url:"../map2"									
    			,type:"post"
    			,data:{
    				admCd: data[0],
    				rnMgtSn: data[1],
    				udrtYn: data[2],
    				buldMnnm: data[3],
    				buldSlno: data[4]
    			}							
    			,dataType:"json"											
    			,success:function(jsonStr){									
    				var errCode = jsonStr.results.common.errorCode; 		
    				var errDesc = jsonStr.results.common.errorMessage;	
    				
    				if(errCode != "0"){ 									
    					alert(errCode+"="+errDesc);
    				}else{
    					if(jsonStr!= null){
    						
							let xx = parseFloat(jsonStr.results.juso[0].entX);
							let yy = parseFloat(jsonStr.results.juso[0].entY);
							
    						//소수점 자르고 시작
    					    let coord_X = Math.round(xx * 1000000) / 1000000;
    					    let coord_Y = Math.round(yy * 1000000) / 1000000;
    					    let point = [coord_X, coord_Y];
    						
    					    proj4.defs["EPSG:5179"] = "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs";//제공되는 좌표
    						    						
    					    let grs80 = proj4.Proj(proj4.defs["EPSG:5179"])
    					    let wgs84 = proj4.Proj(proj4.defs["EPSG:4326"]); //경위도

    					    let p = proj4.toPoint(point);
    					    p = proj4.transform(grs80, wgs84, p);
    						    						
    					    document.getElementById('fLoc').value = addr;
    						document.getElementById("locationX").value = p.y;
    						document.getElementById("locationY").value = p.x;
    			   			
    						document.getElementById("fLoc01").value = "";
    			    		document.getElementById("fLoc02").value = "";
    			    		document.getElementById("list").innerHTML = "";   
    			    		
    			    		document.querySelector('.layer').classList.remove("is-activate");
    			    		document.querySelector('.modal').classList.remove("is-activate");
    			    		
    					}
    				}
    				
    			}
    			,error: function(xhr,status, error){
    				alert("에러발생");										
    			}
    		}); 		
    	}


    	function checkSearchedWord(obj){
    		if(obj.length > 0){
    			//특수문자 제거
    			var expText = /[%=><]/ ;
    			if(expText.test(obj.value) == true){
    				toast("error","특수문자를 입력 할수 없습니다.") ;
    				obj.value = obj.value.split(expText).join(""); 
    				return false;
    			}
    			
    			//특정문자열(sql예약어의 앞뒤공백포함) 제거
    			var sqlArray = new Array(
    				//sql 예약어
    				"OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC",
    	             		 "UNION",  "FETCH", "DECLARE", "TRUNCATE" 
    			);
    			
    			var regex;
    			for(var i=0; i<sqlArray.length; i++){
    				regex = new RegExp( sqlArray[i] ,"gi") ;
    				
    				if (regex.test(obj.value) ) {
    					toast("error","\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
    					obj.value =obj.value.replace(regex, "");
    					return false;
    				}
    			}
    		}else if(obj.length == 0){
    			toast("error","위치를 입력해주세요.");
    			return false;
    		}
    		return true ;
    	}
    	    	
    	function enterSearch() {
    		var evt_code = (window.netscape) ? ev.which : event.keyCode;
    		if (evt_code == 13) {    
    			event.keyCode = 0;  
    			getAddrLoc(); 
    		} 
    	}
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/js/datepicker.js"></script>
</body>
</html>