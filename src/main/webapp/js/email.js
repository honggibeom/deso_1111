function email(){
	var mail = document.getElementById("mail").value;
	var emailCheck = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	//이메일 정규식검사
	if(mail == '' && mail == null){
		toast('error',"이메일을 입력해주세요.");
	}else if(!emailCheck.test(mail)){
		toast('error',"이메일을 확인해주세요.");
	}else{
		$.ajax({
			type:"post",
			url:"../mailSend",
			data:{
				"mail" : mail,
			},
			dataType:"text",
			success:function(){
				toast('success','인증코드가 전송되었습니다.');
				document.getElementById("authNum").disabled = false;
				document.getElementById("studentBtn2").disabled = false;
			},
			error : function(request, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
			}
		});
	}	
}

function emailConfig(){
	const en = document.getElementById("authNum").value;
	if(en != null && en != ""){		
		$.ajax({
			type:"post",
			url:"../emailConfirm",
			data:{ 
				"en" : en,
			},
			dataType : "json",
			success:function(data){
				if(data ===1){
					toast('success','인증하였습니다.');
					document.getElementById("emailFl").value = "y";
					document.getElementById("studentBtn1").disabled = true;
					document.getElementById("studentBtn2").disabled = true;
				}else if(data ===2){
					toast('error','3분이 지났습니다. 인증번호를 다시 받아주세요.');
				}else{
					toast('error','인증번호가 틀렸습니다.');
				}
			},
			error : function(request, error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
			}
		});
	}else {
		toast('error','인증번호를 입력해주세요.');
	}
}