<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>초기화 파라미터 목록</h2>
	<ul>
		<%
		//이름목록 가져오기
		Enumeration<String> initParams = application.getInitParameterNames();
		//Enumeration쓰려면 page디렉티브테그로 import Enumeration해주어야 한다
		
		//반복해서 이름과 값을 꺼내 li 태그로 출력해보자
		while(initParams.hasMoreElements()){
			String paramName = initParams.nextElement(); %>
			
			<li> <%= paramName %> = <%= application.getInitParameter(paramName) %> </li>
			 
		<%}
		
		
		
		
		%>

	</ul>



</body>
</html>