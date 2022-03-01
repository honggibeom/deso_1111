<%@page import="dto.member.Member"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.board.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member m = (Member)session.getAttribute("member");
	List<Board> list = (ArrayList)request.getAttribute("list");
	String mode = (String)request.getAttribute("mode");	
	String addr = (String)request.getAttribute("addr");
	String cate = (String)request.getAttribute("cate");
	String date = (String)request.getAttribute("date");
	SimpleDateFormat date2 = new SimpleDateFormat("MM-dd HH:mm");
	String appkey = "7d0d7e9b25dde7e8b3361e0a303ccd3a";
	String referer = "board/list?mode="+mode;
	String mk = (mode.equals("모임")) ? "meet" : "event"; 
	String locationX = (String)request.getAttribute("x");
	String locationY = (String)request.getAttribute("y");

%>
<jsp:include page="../main/header.jsp" flush="false" />
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=<%=appkey %>&libraries=services,clusterer"></script>
<script src="${pageContext.request.contextPath}/admin/js/jquery-3.6.0.min.js"></script>

   	<div id="map" style=" display:none; width:100%; height:100vh; z-index:29;"><div id="view"></div></div>
    <main id="main" <%if(m == null || m.getM_state() || !m.getM_studentFl()) {%><%if(!m.getM_joinFl()){ %>class="guest"<%} %><%} %>>
        <section class="section meet">
            <div class="section__top fixed fixed--underheader">
                <h2 class="section__top__title">
                	<%if(mode.equals("모임")){ %>새로운 모임을<br>만나 보세요.<%} else if(mode.equals("e")){ %>새로운 행사를<br>확인해 보세요.<%} %>
                </h2>
                <div class="section__top__menu menu">
                    <div class="menu__group" id="mapDIV">
                        <button style="margin-left:7px;" onclick="mapView()" class="menu__group__map"><img id="mapImg" src="${pageContext.request.contextPath}/images/icon_map_pin.svg" alt="지도보기"></button>
                    </div>
                </div>
            </div>
            <%if(list.size() > 0){ %>
            <div id="list" class="section__content btm-m">
                <div class="card__list">
                    <%for(int i=0; i<list.size(); i++){ %>
                    <div class="card">
                        <a href="./view?no=<%=list.get(i).getB_no() %>&referer=<%=referer %>" class="wrap">
                            <ul class="card__info">
                                <li class="card__info__category"><%=list.get(i).getB_category() %></li>
                                <li class="card__info__detail">
                                    <span class="addr"><%=(list.get(i).getB_deadline_fl())?"모임완료":list.get(i).getB_address_sub() %></span>
                                    <span class="date"><%=date2.format(list.get(i).getB_time()) %></span>
                                </li>
                                <li class="card__info__title"><%=list.get(i).getB_title() %></li>
                                <li class="card__info__join"><%=list.get(i).getB_p_count() %>/<%=list.get(i).getB_p_limit()%></li>
                            </ul>
                            <div class="card__thumbnail">
                                <img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/board/<%=mk %>/mno<%=list.get(i).getB_m_no()%>/<%=list.get(i).getB_img1()%>" alt="썸네일">
                            </div>
                        </a>
                    </div>
					<%} %>
                </div>
            </div>
            <%}else{ %>
            <div class="section__content">
               <div class="result">
                   <span class="result__info">
                       검색한 위치에서는
                       <br>
                       현재 진행 중인 모임이 없습니다.
                   </span>
                   <a href="./filter?mode=<%=mode %>&addr=<%=addr %>&cate=<%=cate %>&date=<%=date %>" class="result__link btn--submit">다시 검색하기</a>
               </div>
            </div>
            <%} %>
        </section>
        <%if(mode.equals("모임")){ %>
        <div class="floating">
            <a href="${pageContext.request.contextPath}/board/action?mode=new&referer=<%=referer %>" class="floating__menu add"></a>
        </div>
        <%} %>
    </main>
<jsp:include page="../main/footer.jsp" flush="false" />
<script src="${pageContext.request.contextPath}/js/script.js"></script>
<script>
function mapView(){
	const map = document.getElementById("mapImg");
	const modal = document.getElementById("map");
	<%if(list.size() > 0){ %>const list = document.getElementById("list");<%}%>
		
	if(modal.style.display === "block"){
		modal.style.display="none";
		<%if(list.size() > 0){ %>list.style.display="block";<%}%>
		map.src = "../images/icon_map_pin.svg";
		/* if(document.getElementById("myMap") != null){	
			document.getElementById("myMap").remove();			
		} */
	}else {
		modal.style.display="block";
		<%if(list.size() > 0){ %>list.style.display="none";<%}%>
		map.src = "../images/icon_list.svg";
		
		/* if(document.getElementById("myMap") == null){			
			var btn = document.createElement('button');
			btn.setAttribute("onclick",'myMapView()');
			btn.setAttribute("class",'menu__group__map');
			btn.setAttribute("id","myMap");
						
			var img = document.createElement('img');
			img.src = "/images/icon_map_pin.svg";
			
			btn.appendChild(img);
			
			document.getElementById("mapDIV").appendChild(btn);
		} */
		openMap(); 
	}
}

/* //내 위치
function myMapView(){	
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showYourLocation, showErrorMsg);
	} else { 
		toast("error","위치 권한을 켜주세요.");
	}
}

//내 위치 x,y 반영하기
function showYourLocation(position) {
	openMap(position.coords.latitude,position.coords.longitude);
}

function showErrorMsg(error) {
	switch(error.code) {
		case error.PERMISSION_DENIED:
			toast("error","위치 권한을 켜주세요.");
		break;
		case error.POSITION_UNAVAILABLE:
			toast("error","위치 권한을 켜주세요.");
		break;
		case error.TIMEOUT:
			toast("error","위치 권한을 켜주세요.");
		break;
		case error.UNKNOWN_ERROR:
			toast("error","위치 권한을 켜주세요.");
		break;
	}
} */

function openMap(){
	var positionX = "<%=locationX%>";
	var positionY = "<%=locationY%>";
	console.log(positionX,positionY);
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(positionX, positionY), // 지도의 중심좌표
	    level: 8 // 지도의 확대 레벨
	};

	var map = new kakao.maps.Map(mapContainer, mapOption);

		
	var clusterer = new kakao.maps.MarkerClusterer({
	    map: map, 
	    averageCenter: true,
	    minLevel: 4, 
	    disableClickZoom: true
	});

	var data = [];	
	<%for(int i=0; i<list.size(); i++){%>
		var list = [<%=list.get(i).getB_address_X()%>,<%=list.get(i).getB_address_Y()%>,<%=list.get(i).getB_no()%>];
		data.push(list);	
	<%}%>
  
	var markers = [];
	for(var i=0; i<data.length; i++){
		var marker = new kakao.maps.Marker({
	    	position: new kakao.maps.LatLng(data[i][0],data[i][1]),
	        map:map
	    });
	   
	    markers.push(marker);
          
	    kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker,data[i][2]));
	}

	clusterer.addMarkers(markers);

	function makeClickListener(map, marker, bno) {
	    return function() {
	        $.ajax({
				type:"post",
				url:"./mapView",
				data: {
					no:bno
				},
				dateType:"json",
				success:function(data){
					boardlist(JSON.parse(data));
				},
				error:function(request,status,error){
					toast('error',"code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			});
	    };
	}
	
	 kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
	      var level = map.getLevel()-1;
		  map.setLevel(level, {anchor: cluster.getCenter()});
	});
}

function boardlist(data){
	var mk = '<%=mk%>';
	var referer = '<%=referer%>';
	
	var view = "";
	view += "<div class='card__list card__list--top'>";
	view += "	<div class='card'>";
	view += "	<div class='close'><button onclick='viewClose()'></button></div>";
	view += "   	<a href='./view?no="+data[0].no+"&referer="+referer+"' class='wrap'>";
	view += "	    <ul class='card__info'>";
	view += "            <li class='card__info__category'>"+data[0].category+"</li>";
 	view += "            <li class='card__info__detail'>";
	view += "               <span class='addr'>"+data[0].address+"</span>";
	view += "               <span class='date'>"+data[0].time+"</span>";
	view += "           </li>";
	view += "           <li class='card__info__title'>"+data[0].title+"</li>";
	view += "           <li class='card__info__join'>"+data[0].count+"/"+data[0].limit+"</li>";
	view += "       </ul>";
	view += "        <div class='card__thumbnail'>";
	view += "            <img src='https://s3.ap-northeast-2.amazonaws.com/deso-file/board/"+mk+"/mno"+data[0].mno+"/"+data[0].img+"'>"
	view += "        </div>";
	view += "   	</a>";
	view += "	</div>";
	view += "</div>";
	
	document.getElementById("view").innerHTML = view;
}

function viewClose(){
	document.getElementById("view").innerHTML = "";
}
</script>