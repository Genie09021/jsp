<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>param03 page</h1>
	<jsp:forward page="param04.jsp">
		<jsp:param value="admin" name="id"/>
		<jsp:param value="1234" name="pw"/>
		<jsp:param value='<%=java.net.URLEncoder.encode("관리자") %>' name="name"/>
	</jsp:forward>
	
	<h3>Java Server Page</h3>

</body>
</html>