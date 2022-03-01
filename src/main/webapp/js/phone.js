//핸드폰인증번호 전송   
function phone(){
	tel = document.getElementById("uTel").value;
	if(tel != null && tel != ""){
		$.ajax({
			type:"post",
			url:"coolsms",
			data:{ 
				"tal" : tel,
			},
			dataType : "text",
			success:function(){
				toast('success','인증번호가 발송되었습니다. 3분안으로 인증해주세요.');
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});	
	}else {
		toast('error',"번호를 입력해주세요.");
	}
}
	
function phoneResult(){
	const cn = document.getElementById("authNum").value;
	if(cn != null && cn != ""){
		$.ajax({
			type:"post",
			url:"coolsmsConfirm",
			data:{ 
				"cn" : cn,
			},
			dataType : "json",
			success:function(data){
				if(data ===1){
					toast('success','인증하였습니다.');
					document.getElementById("phoneFl").value = "y";
				}else if(data ===2){
					toast('error','3분이 지났습니다. 인증번호를 다시 받아주세요.');
				}else{
					toast('error','인증번호가 틀렸습니다.');
				}
			},
			error:function(){
				alert('통신장애(전화번호)');
			}
		});
	}else {
		toast('error',"인증번호를 입력해주세요.");
	}
}