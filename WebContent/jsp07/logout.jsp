<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그아웃</title>
</head>
<%	//로그아웃 처리
	session.invalidate();//세션속성 삭제
	
	//쿠키가 있으면 쿠키도 삭제
	Cookie[] coos =request.getCookies();
	if(coos!= null){
		for(Cookie c :coos){
			if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("autoCh")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
			
		}
	}
	
	response.sendRedirect("main.jsp");//메인으로 이동
	

%>
<body>

</body>
</html>