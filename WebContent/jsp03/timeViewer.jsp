<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
//request.setAttribute (String name ,Object obj) 로 추가한 속성 꺼내려면
//request.getAttirbute(String name) 으로 속성값을 꺼낼수 있다
//이때 getAttribute()로 꺼내는 데이터의 리턴타입은 Object ->원하는 데이터 타입으로 다시 형변환 해주어야 사용할 수 있다
	
	Calendar cal =(Calendar)request.getAttribute("time");

%>

<body>

	현재시간 : <%= cal.get(Calendar.HOUR) %> 시
				<%= cal.get(Calendar.MINUTE) %> 분
				<%= cal.get(Calendar.SECOND) %> 초
				
				
				
</body>
</html>