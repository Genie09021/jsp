<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>hello View ! ! </h1>
	<h3><%=request.getAttribute("id") %></h3>
	<h3><%=request.getAttribute("num") %></h3>
	<h3><%=session.getAttribute("memId") %></h3>
</body>
</html>