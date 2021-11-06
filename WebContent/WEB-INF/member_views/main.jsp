<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>main</title>
	<link href="/web/jsp16/style.css" rel="stylesheet" type="text/css">
</head>
<body>
   <br />
   <h1 align="center"> Main </h1>
   
   <c:if test="${sessionScope.sid == null }">
   
   <table>
		<tr>
			<td>로그인 원하시면 버튼을 누르세요</td>
			<td><button onclick="window.location='/web/member/loginForm.hrd'">로그인</button></td>
		</tr> 
		<tr>
			<td><button onclick="window.location='/web/member/signupForm.hrd'">회원가입</button></td>
		</tr>   
   
   </table>
   </c:if>
   <c:if test="${sessionScope.sid != null }">
	 <table>
			<tr>
				<td>${sessionScope.sid } 님 환영합니다</td>
				<td><button onclick="window.location='/web/member/logout.hrd'"> 로그아웃 </button></td>
			</tr> 
			<tr>
				<td><button onclick="window.location='/web/member/mypage.hrd'"> 마이페이지 </button></td>
			</tr>   
	   
   	</table>
	</c:if>
</body>
</html>