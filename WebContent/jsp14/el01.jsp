<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>el01.jsp</title>
</head>
<body>

	<h2> ${"10" +10 }</h2>
	<%-- <h2> ${"테스트" +10 }</h2>--%>
	<h2> ${null +10 }</h2>
</body>
</html>