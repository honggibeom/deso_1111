<%@page import="dto.banner.Banner"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Banner dto = (Banner) request.getAttribute("dto");
%>
<script src="https://sdk.amazonaws.com/js/aws-sdk-2.809.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/putFile.js"></script>
<jsp:include page="../aside.jsp" flush="false" />
<main class="main container-fluid banner">
	<div class="pt-5 pb-3 mb-5 border-bottom border-dark text-left">
		<span class="title fs-4">배너 등록</span>
	</div>
	<div class="h-100 w-100 d-flex flex-column align-items-center mt-4">
		<div class="form-wrap form-wrap-m">
			<form action="process" method="post" class="w-100 container-fluid" name="action">
				<input type="hidden" name="mode" value="<%=(dto != null) ? "update" : "insert"%>">
				<div class="row img_load banner">
					<div class="col-2">
						<span class="form-label">배너<strong class="cnt mx-1">1</strong></span>
					</div>
					<div class="col-10 d-flex align-items-end">

						<div class="col-6 d-flex flex-column label_wrap">
							<label class="d-block rounded" for="file01">
								<%if(dto.getImg1() != null && !dto.getImg1().equals("")){%>
								<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/banner/<%=dto.getImg1() %>">
								<%} %>
							</label>
						</div>
						<div class="col-4 px-3 d-flex flex-column">
							<input name="file" class="d-block my-3" type="file" onchange="fileProcess(event,1)" id="file01" accept="image/*">
							<input name="img1" id="file1" type="hidden" value="<%=(dto != null && dto.getImg1() != null)?dto.getImg1():null %>">
							<button class="btn btn_del border-secondary btn-block img-del">이미지 삭제</button>
						</div>

					</div>
				</div>
				<div class="row img_load banner my-3">
					<div class="col-2">
						<span class="form-label">배너<strong class="cnt mx-1">2</strong></span>
					</div>
					<div class="col-10 d-flex align-items-end">
						<div class="col-6 d-flex flex-column label_wrap">
							<label class="d-block rounded" for="file02">
								<%if(dto.getImg2() != null && !dto.getImg2().equals("")){%>
									<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/banner/<%=dto.getImg2() %>">
								<%} %>
							</label>
						</div>
						<div class="col-4 px-3 d-flex flex-column">
							<input name="file" class="d-block my-3" type="file" onchange="fileProcess(event,2)" id="file02" accept="image/*">
							<input name="img2" id="file2" type="hidden" value="<%=(dto != null && dto.getImg2() != null)?dto.getImg2():null %>">
							<button class="btn btn_del border-secondary btn-block img-del">이미지 삭제</button>
						</div>
					</div>
				</div>
				<div class="row img_load banner my-3">
					<div class="col-2">
						<span class="form-label">배너<strong class="cnt mx-1">3</strong></span>
					</div>
					<div class="col-10 d-flex align-items-end">
						<div class="col-6 d-flex flex-column label_wrap">
							<label class="d-block rounded" for="file03">
								<%if(dto.getImg3() != null && !dto.getImg3().equals("")){%>
								<img src="https://s3.ap-northeast-2.amazonaws.com/deso-file/banner/<%=dto.getImg3() %>">
								<%} %>
							</label>
						</div>
						<div class="col-4 px-3 d-flex flex-column">
							<input name="file" class="d-block my-3" type="file" onchange="fileProcess(event,3)" id="file03" accept="image/*">
							<input name="img3" id="file3" type="hidden" value="<%=(dto != null && dto.getImg3() != null)?dto.getImg3():null %>">
							<button class="btn btn_del border-secondary btn-block img-del">이미지 삭제</button>
						</div>
					</div>
				</div>
				<hr>
				<div class="d-flex justify-content-end pt-2">
					<a href="../home" type="button" class="btn mx-5">취소</a>
					<button type="button" onclick="process()" class="btn btn-dark">등록하기</button>
				</div>
			</form>
		</div>
	</div>
</main>
<script>


function process(){
	  action.submit();	
}

function fileProcess(event,i){
	document.getElementById("file"+i).value = event.target.files[0].name;
	const folder = "banner";
	const folder2 = "";
	const file = event.target.files[0];
	
	//upload
	putFile(file,folder,folder2);
}


$('.img-small').change(function(e){
    let maxSize = 3 * 1024 * 1024,
        fileSize = $(this)[0].files[0].size;
    if(fileSize > 0 && fileSize > maxSize){
        alert("이미지 파일 용량이 커서 등록되지 않습니다. 3M 이하로 등록해주세요.");
        $(this).val('');
    } 
});

$('.img-del').click(function(e){
    e.preventDefault();
    let $input = $(this).parents('.banner_wrap').find('input');
    console.log($input);
    if($input && $input.val()) $input.val('');
    return;
});

//이미지 로드 스크립트
function imgloadFn(){
    var addBtns = document.querySelectorAll('.img_load input');
    var delBtns = document.querySelectorAll('.img_load .btn_del');

    addBtns.forEach(btn => {
        btn.addEventListener('input', addImg);
    });

    delBtns.forEach(btn => {
        btn.addEventListener('click', delImg);
    });

    function delImg(event){
        event.preventDefault();
        var imgload = event.target.closest('.img_load');
        var label = imgload.getElementsByTagName('label')[0];
        var file = imgload.querySelectorAll('input');       

        file[1].value = null;
        imgload.getElementsByTagName('img')[0].remove();
        imgload.getElementsByTagName('input')[0].value="";
    };

    function addImg(event){
      var input = event.target;
      var imgload = input.closest('.img_load');
      var label = imgload.querySelector('label');
      var fReader = new FileReader();
      fReader.onload = function(event){
    	  if(imgload.getElementsByTagName('img')[0] != null){    		  
    	  	imgload.getElementsByTagName('img')[0].remove();
    	  }
          var img = document.createElement('img');
          img.setAttribute('src', event.target.result);
          label.appendChild(img);
      };
      fReader.readAsDataURL(input.files[0]);
    };
};

window.addEventListener('load', function(){
    imgloadFn();
});
</script>
<jsp:include page="../footer.jsp" flush="false" />
