<%@page import="java.util.Objects"%>
<%@page import="dto.member.Member"%>
<%@page import="dto.alert.Alert"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Alert alert = (session.getAttribute("alert")!=null)?(Alert)session.getAttribute("alert"):null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="user-scalable=0, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, width=device-width" />
    <title>DESO</title>
    <meta name="keyword" content="DESO, 대학생, 모임, 대학생 모임">
    <meta name="description" content="대학생들만 모여 모여">
    <meta name="copyright" content="DESO">
    <meta name="author" content="DESO">
    <meta property="og:title" content="DESO">
    <meta property="og:site_name" content="DESO">
    <meta property="og:description" content="대학생들만 모여 모여">
    <meta property="og:image" content="${pageContext.request.contextPath}/images/icon_logo.svg">
    <meta property="og:type" content="website">
    <meta property="og:url" content="${pageContext.request.contextPath}">
    
       
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vendor/swiper-bundle.min.css">
    <script src="${pageContext.request.contextPath}/js/vendor/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script src="${pageContext.request.contextPath}/js/alert.js"></script>
	<style>
		body.swal2-toast-shown .swal2-container.swal2-center{
			width: 80%;
		}
		.swal2-popup.swal2-toast .swal2-header {
		    flex-direction: column;
		    padding: 0px;
		}
		
		.swal2-popup.swal2-toast .swal2-icon{
			margin:0 .5em 10px 0;
		}
		
		.swal2-popup.swal2-toast .swal2-header {
		    margin-bottom: 10px;
		}
	</style>
</head>
<body> <!-- onkeydown="return keydowncheck();" oncontextmenu='return false'-->
<script>
<%if(alert != null){ %>toast('<%=alert.getIcon() %>','<%=alert.getMsg()%>');  <% session.removeAttribute("alert"); } %>
function keydowncheck()
{
var result = true;
var keycode = event.keyCode;
if(123 == keycode) //F12 키코드
{
result = false;
}
return result;
}
</script>