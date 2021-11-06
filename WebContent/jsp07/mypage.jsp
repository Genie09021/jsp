<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%if(session.getAttribute("memId") ==null ) {%>
<script>
	alert("로그인 해주세요");
	window.location = "/web/jsp07/loginForm.jsp";
</script>
<% }else{%>	<body>
	<h1 align="center"> 마이페이지</h1>
		<table>
			<tr>
				<td><a href ="modifyForm.jsp">회원 정보 수정</a></td>
			</tr>
			
			<tr>
				<td><a href ="deleteForm.jsp">회원 탈퇴</a></td>
			</tr>
			
			<tr>
					<td><a href ="main.jsp">메인으로 이동</a></td>
			</tr>
		</table>
	</body>
	<%} %>
</html>
