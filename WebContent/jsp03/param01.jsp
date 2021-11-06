<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>param 01 page</h1>
	
	<jsp:include page="param02.jsp">
		<jsp:param name="date" value="<%=new java.util.Date() %>"/>
		</jsp:include>
		
	<h3>java server page</h3>


</body>
</html>