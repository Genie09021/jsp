<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>로그 메세지 기록</h2>
	<%
	application.log("로그 메세지 기록!");
		log("jsp로그로 메세지 기록");
			
	%>


</body>
</html>