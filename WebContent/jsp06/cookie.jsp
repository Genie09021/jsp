<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//쿠키 객체 생성
	Cookie c = new Cookie("id","java");
	//쿠키객체의 유효기간 설정(초단위)	
	c.setMaxAge(60);
	//클라이언트에게 쿠키 전달
	response.addCookie(c);
	
	



%>

<body>

</body>
</html>