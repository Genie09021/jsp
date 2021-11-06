<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>main</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
   <br />
   <h1 align="center"> Main </h1>
   <%//main페이지 왔을때 로그인이되어있는 상태인지(session존재) 아닌지에따라 보여줄 페이지가 다름
   if(session.getAttribute("sid") ==null ){ %>
   <table>
		<tr>
			<td>로그인 원하시면 버튼을 누르세요</td>
			<td><button onclick="window.location='loginForm.jsp'">로그인</button></td>
		</tr> 
		<tr>
			<td><button onclick="window.location='signupForm.jsp'">회원가입</button></td>
		</tr>   
   
   </table>
<%}else{ %>
 <table>
		<tr>
			<td><%=session.getAttribute("sid") %>님 환영합니다</td>
			<td><button onclick="window.location='logout.jsp'">로그아웃</button></td>
		</tr> 
		<tr>
			<td><button onclick="window.location='mypage.jsp'">마이페이지</button></td>
		</tr>   
   
   </table>
	<%} %>
</body>
</html>