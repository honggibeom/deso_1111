//다중삭제
function del(kind,mode){
	var check = document.querySelectorAll('input[name="ck"]:checked');
	
	if(check.length > 0){		    	
		var val = [];
		for(var i = 0; i < check.length; i++){
			val.push(check[i].value);
		}
		var d = confirm("선택하신 "+check.length+"개의 "+kind+"을 삭제처리하시겠습니까?");
		if(d){
			$.ajax({
				type:"post",
				url:"../mutldel",
				traditional : true,	//ajax 배열 보는법
				data: {
					sno:val,
					mode:mode
				},
				dateType:"json",
				success:function(i){
					if(i == 1){
						alert("삭제되었습니다.");
						location.reload();
					}else{
						alert("실패");
					}
				},
				error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			});
		}
	}else{
		alert("삭제할 게시판을 선택해주세요.");
	}
}