<%@page import="dto.admin.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Admin admin = (Admin)session.getAttribute("admin");
%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="target-densitydpi=device-dpi, user-scalable=0, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, width=device-width" />
    <title>DESO관리자</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/style.css">
    <script src="${pageContext.request.contextPath}/admin/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div id="wrapper" class="container-fluid">
      <aside class="aside fixed-top bg-white shadow">
        <div class="nav-top d-flex flex-row justify-content-between">
          <a class="logo d-block text-center" href="${pageContext.request.contextPath}/admin/home"><img src="${pageContext.request.contextPath}/admin/images/icon_logo.svg" alt="DESO"></a>
          <a href="#" class="nav-toggle"><img class="h-100" src="${pageContext.request.contextPath}/admin/images/icon_list.svg" alt="menu"></a>
        </div>
          <%if(admin != null){ %>
        <ul class="nav nav-pills nav-fill flex-column bg-white">
          <li class="nav-item">
            <div><a class="nav-link depth-link meet" href="#" data-page="meet">모임</a></div>
            <div class="nav-depth flex-column p-2 my-1 bg-secondary bg-opacity-10">
              <a class="d-block" href="${pageContext.request.contextPath}/admin/board/list?mode=모임" data-page="list">모임 목록</a>
              <a class="d-block" href="${pageContext.request.contextPath}/admin/board/view?mode=모임&action=new" data-page="new">모임 등록</a>
            </div>
          </li>
          <li class="nav-item">
            <div><a class="nav-link depth-link event" href="#" data-page="event">행사</a></div>
            <div class="nav-depth flex-column p-2 my-1 bg-secondary bg-opacity-10">
              <a class="d-block" href="${pageContext.request.contextPath}/admin/board/list?mode=행사" data-page="list">행사 목록</a>
              <a class="d-block" href="${pageContext.request.contextPath}/admin/board/view?mode=행사&action=new" data-page="new">행사 등록</a>
            </div>
          </li>
          <li class="nav-item">
            <div><a class="nav-link depth-link user" href="#" data-page="user">회원 관리</a></div>
            <div class="nav-depth flex-column p-2 my-1 bg-secondary bg-opacity-10">
              <a class="d-block" href="${pageContext.request.contextPath}/admin/user/list" data-page="list">회원 목록</a>
              <a class="d-block" href="${pageContext.request.contextPath}/admin/user/insertHome" data-page="new">회원 등록</a>
              <a class="d-block" href="${pageContext.request.contextPath}/admin/user/unsubs" data-page="unsubs">탈퇴회원</a>
            </div>
          </li>
          <li class="nav-item">
            <div><a class="nav-link depth-link report" href="#" data-page="report">신고문의함</a></div>
            <div class="nav-depth flex-column p-2 my-1 bg-secondary bg-opacity-10">
              <a class="d-block" href="${pageContext.request.contextPath}/admin/report/list?sort=회원" data-page="list">회원 신고함</a>
              <a class="d-block" href="${pageContext.request.contextPath}/admin/report/list?sort=모임" data-page="list">모임 신고함</a>
              <a class="d-block" href="${pageContext.request.contextPath}/admin/report/list?sort=행사" data-page="list">행사 신고함</a>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link notice" href="${pageContext.request.contextPath}/admin/notice/list" data-page="notice">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link banner" href="${pageContext.request.contextPath}/admin/banner/list" data-page="banner">배너</a>
          </li>
          <li class="nav-item">
            <a class="nav-link info" href="${pageContext.request.contextPath}/admin/terms/list" data-page="terms">사이트정보설정</a>
          </li>
          <li class="nav-item text-center my-5">
            <a class="d-inline-block text-decoration-none text-secondary mx-4" href="${pageContext.request.contextPath}/admin/logout">로그아웃</a>
            <a class="d-inline-block text-decoration-none text-secondary" href="${pageContext.request.contextPath}/admin/admin">관리자설정</a>
          </li>
        </ul>
          <%} %>
      </aside>