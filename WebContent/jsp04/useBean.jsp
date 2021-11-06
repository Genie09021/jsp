<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

	<jsp:useBean id="date" class="java.util.Date"/>

	<jsp:useBean id="person" class ="web.jsp04.test.Bean"/>

<body>

<%

	person.setId("test");
	person.setPw("1234");

	//out.println("오늘의 날짜 및 시간 : " + date);

%>


 아이디 : <%= person.getId() %> <br/>
 비밀번호 : <%= person.getPw() %><br/>

<%= date %>


</body>
</html>