<%@page import="dto.member.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member m = (Member)session.getAttribute("member");
%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script src="https://sdk.amazonaws.com/js/aws-sdk-2.809.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/putFile.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.7.2/proj4.js"></script>

<jsp:include page="../../header.jsp" flush="false" />
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
                        <fieldset class="field filter__field search">
                            <label for="fLoc" class="label label--s">동위치 입력</label>
                            <div class="search__wrap">
                                <input type="text" id="fLoc" class="bg" placeholder="예) 쌍용동" name="keyword" onkeydown="enterSearch();">
                            </div>
							<div id="list" ></div>
                        </fieldset>
                        <button style="height: auto;" type="button" onClick="getAddrLoc();" class="actions__submit">주소검색하기</button>
                    </form>
                </div>
            </div> 
        </div>
    </div>
    <div id="app">
        <main id="main">
            <section class="section mypage mypage-edit-profile">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">
                        프로필 수정
                    </h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="${pageContext.request.contextPath}/mypage" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <div class="section__content__top">
                        <h1 class="logo"><img src="${pageContext.request.contextPath}/images/icon_logo.svg" alt="DESO"></h1>
                        <p class="title">대학생들만 모여모여</p>
                    </div>
                    <form action="./profile/process" method="post" class="form" name="action">
                        <fieldset class="field imgloads imgloads--col2">
                            <div class="imgload">
                                <div class="imgload__cont">
                                    <%if(m.getM_img1() != null && !m.getM_img1().equals("")){ %><img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=m.getM_no() %>/<%=m.getM_img1() %>" class="imgload__cont__img"><%} %>
                                    <span class="imgload__cont__btn add">
                                        <input type="file" accept="image/*" name="poto" id="pic01" onchange="file(event,1)" >
                                        <input name="img1" id="file1" type="hidden" value="<%=(m != null && m.getM_img1() != null)?m.getM_img1():"" %>">
                                        <label for="pic01" class="<%=(m.getM_img1()!=null && !m.getM_img1().equals(""))?"del":"add"%>"></label>
                                    </span>
                                </div>
                            </div>
                            <div class="imgload">
                                <div class="imgload__cont">
                                	<%if(m.getM_img2() != null && !m.getM_img2().equals("")){ %><img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=m.getM_no() %>/<%=m.getM_img2() %>" class="imgload__cont__img"><%} %>
                                    <span class="imgload__cont__btn">
                                        <input type="file" accept="image/*" name="poto" id="pic02" onchange="file(event,2)" >
                                        <input name="img2" id="file2" type="hidden" value="<%=(m != null && m.getM_img2() != null)?m.getM_img2():"" %>">
                                        <label for="pic02" class="<%=(m.getM_img2()!=null && !m.getM_img2().equals(""))?"del":"add"%>"></label>
                                    </span>
                                </div>
                            </div>
                            <div class="imgload">
                                <div class="imgload__cont">
                                	<%if(m.getM_img3() != null && !m.getM_img3().equals("")){ %><img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=m.getM_no() %>/<%=m.getM_img3() %>" class="imgload__cont__img"><%} %>
                                    <span class="imgload__cont__btn">
                                        <input type="file" accept="image/*" name="poto" id="pic03" onchange="file(event,3)" >
                                        <input name="img3" id="file3" type="hidden" value="<%=(m != null && m.getM_img3() != null)?m.getM_img3():"" %>">
                                        <label for="pic03" class="<%=(m.getM_img3()!=null && !m.getM_img3().equals(""))?"del":"add"%>"></label>
                                    </span>
                                </div>
                            </div>
                            <div class="imgload">
                                <div class="imgload__cont">
                                	<%if(m.getM_img4() != null && !m.getM_img4().equals("")){ %><img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/member/mno<%=m.getM_no() %>/<%=m.getM_img4() %>" class="imgload__cont__img"><%} %>
                                    <span class="imgload__cont__btn">
                                        <input type="file" accept="image/*" name="poto" id="pic04" onchange="file(event,4)" >
                                        <input name="img4" id="file4" type="hidden" value="<%=(m != null && m.getM_img4() != null)?m.getM_img4():"" %>">
                                        <label for="pic04" class="<%=(m.getM_img4()!=null && !m.getM_img4().equals(""))?"del":"add"%>"></label>
                                    </span>
                                </div>
                            </div>
                        </fieldset>
                        <fieldset class="field">
                            <label for="name">닉네임</label>
                            <input type="text" name="name" id="name" class="bg" value="<%=m.getM_name() %>" required>
                        </fieldset>
                        <fieldset class="field">
                            <label for="dept">학교/학과</label>
                            <input type="text" id="dept" class="readonly" value="<%=(m.getM_school()!=null&&m.getM_study()!=null)?m.getM_school()+" / "+m.getM_study():"" %>" disabled required>
                        </fieldset>
                        <fieldset class="field">
                            <label for="addr">위치</label>
                            <input type="text" id="location" name="addr" class="bg modalControll" data-modal="location" value="<%=(m.getM_address() != null)?m.getM_address():"위치를 입력해주세요." %>" readonly required>
                            <input type="hidden" id="locationX" name="locationX">
                            <input type="hidden" id="locationY" name="locationY">
                        </fieldset>
                        <fieldset class="field">
                            <label for="intro">자기소개</label>
                            <textarea name="intro" id="intro" cols="30" rows="10" class="bg"><%=(m.getM_about_me() != null)? m.getM_about_me() : "" %></textarea>
                        </fieldset>
                        <button type="button" onclick="process()" class="btn--submit btn__full">저장하기</button>
                    </form>
                </div>
            </section>
        </main>
    </div>
    <script>    	
    	
	    	
  		function process(){
	    	action.submit();
    	}
        	
    	function file(event,i){
    		document.getElementById("file"+i).value = event.target.files[0].name;
    		const folder = "member";
    		const folder2 = "mno"+<%=m.getM_no()%>;
			const file = event.target.files[0];
    		
    		//upload
 	  		putFile(file,folder,folder2);
    	}
    	
    	
    	function getAddrLoc(){
    		// 적용예 (api 호출 전에 검색어 체크) 	
    		if (!checkSearchedWord(document.form.keyword)) {
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
	    			let name = this.sggNm+" "+this.emdNm;
	    			
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
    						    						
    						document.getElementById("location").value = addr;
    						document.getElementById("locationX").value = p.y;
    						document.getElementById("locationY").value = p.x;
    			   			
    			    		document.getElementById("fLoc").value = "";
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
    		if(obj.value.length >= 2){
    			//특수문자 제거
    			var expText = /[%=><]/ ;
    			if(expText.test(obj.value) == true){
    				alert("특수문자를 입력 할수 없습니다.") ;
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
    				    alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
    					obj.value =obj.value.replace(regex, "");
    					return false;
    				}
    			}
    		}else if(obj.value.length == 1){
    			toast("error","두글자 이상 입력되어야 합니다.");
    			return false;
    		}else if(obj.value.length == 0){
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
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
<html>