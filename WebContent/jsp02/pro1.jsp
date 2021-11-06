<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pro page</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");


 	String username =request.getParameter("username");
	String password =request.getParameter("password");
	String test = request.getParameter("test");

%>
<body>

 	username = <%= username %><br/>
	password = <%= password %><br/>

	test=<%=test %>
</body>
</html>