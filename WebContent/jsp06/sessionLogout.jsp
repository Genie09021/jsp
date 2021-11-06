<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//로그아웃처리 -> session sid 속성 삭제
	//삭제#1.name 주고 원하는 속성 각각 삭제
	
		session.removeAttribute("sid");
	
	
	System.out.println("세션속성전부 삭제할께~");
	//삭제#2. 세션의 모든 속성을 삭제하겠다
		session.invalidate();
	
	
	System.out.println("세션속성전부 삭제했으니 main으로 돌아갈게~");
	response.sendRedirect("sessionMain.jsp");


%>
<body>

</body>
</html>