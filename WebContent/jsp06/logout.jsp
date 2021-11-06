<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%--로그아웃 시켜주는것 ,만든 쿠키를 삭제하면 될것--%>
<%
	
	Cookie[] coos =request.getCookies();
	for(Cookie c : coos){
		if(c.getName().equals("cookieId")){
			c.setMaxAge(0);
			response.addCookie(c);
		}
		if(c.getName().equals("cookiePw")){
			c.setMaxAge(0);
			response.addCookie(c);
		}
		
	}

		response.sendRedirect("main.jsp");
		

%>
<body>


</body>
</html>