<%@page import="web.jsp11.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="/web/jsp16/style.css" rel="stylesheet" type="text/css">
</head>

<body>
	<br/>
	<h1 align="center">mypage</h1>
	<table>
		<tr>
			<td>${sessionScope.sid }</td>
			<td><img src="/web/save/${photo }" width="250"/></td>
		</tr>
		<tr>
			<td><button onclick="window.location='/web/member/modifyForm.hrd'">회원정보 수정</button></td>
			<td><button onclick="window.location='/web/member/deleteForm.hrd'">회원탈퇴</button></td>
			<td><button onclick="window.location='/web/member/main.hrd'">메인</button></td>
		</tr>
	</table>
</body>
</html>