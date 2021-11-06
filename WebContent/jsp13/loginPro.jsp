<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginPro page</title>
</head>
<body>
	<h2>login Pro Page </h2>

	<h2>result : <%=request.getAttribute("result") %></h2>
	<%
		int result =(Integer)request.getAttribute("result");
		if(result == 1){%>
			<script>
				alert("로그인 성공 !!");
				//window.location="main.jsp";
			</script>
		<%} %>
		
		<h3> memId : <%= session.getAttribute("memId") %></h3>
	
</body>
</html>