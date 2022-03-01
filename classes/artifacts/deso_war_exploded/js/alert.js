function toast(icon, msg){
	 const Toast = Swal.mixin({
         toast: true,
         position: 'center-center',
         showConfirmButton: true,
         timerProgressBar: false,
     })

     Toast.fire({
         icon: icon,
         title: msg
     })
}