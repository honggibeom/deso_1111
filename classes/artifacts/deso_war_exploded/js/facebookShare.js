function facebook() {
	var linkUrl = window.location.href;
	if(linkUrl.indexOf('#') > 0){
		linkUrl.replace(/,#/, '');	
	}
	window.open('http://www.facebook.com/sharer.php?u='+ encodeURIComponent(linkUrl));
}