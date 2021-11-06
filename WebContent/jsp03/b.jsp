<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>B page</h1>
	<%
	System.out.println("8888888");
	response.sendRedirect("c.jsp");//자바로 페이지 이동 (c.jsp)페이지 요청
	//response.sendRedirect("http://www.google.co.kr");//구글로 이동시키기
	
	%>

 	<%-- <jsp:forward page="c.jsp"/>--%>
 <%--
 	<jsp:forward page="c.jsp">
 		<jsp:param value="testid" name="id"/>
 		<%--jsp:param은 여러개 사용 가능 --%>
 <%-- </jsp:forward>  --%>
 
</body>
</html>