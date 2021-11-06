<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>

	<h1> A page</h1>
	
	<form action ="b.jsp" method="post">
		<input type="text" name="msg"/><br/>
		<input type="submit" value="이동"/>
	</form>
	


	<%
		out.print("hello <br />" );
		out.println("jsp");
	
	%>


</body>
</html>