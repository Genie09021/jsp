<%@page import="web.jsp11.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	String id = (String)session.getAttribute("sid");
	//id를 주고 해당 photo가져오기
	MemberDAO dao = MemberDAO.getInstance();
	String photo = dao.getPhoto(id);
	if(photo == null || photo == ""){
		photo = "dfim.jpg";
	}
%>
<body>
	<br/>
	<h1 align="center">mypage</h1>
	<table>
		<tr>
			<td><%=session.getAttribute("sid")%><%=id%></td>
			<td><img src="/web/save/<%=photo%>" width="250"/></td>
		</tr>
		<tr>
			<td><button onclick="window.location='modifyForm.jsp'">회원정보 수정</button></td>
			<td><button onclick="window.location='deleteForm.jsp'">회원탈퇴</button></td>
			<td><button onclick="window.location='main.jsp'">메인</button></td>
		</tr>
	</table>
</body>
</html>