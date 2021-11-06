<%@page import="web.jsp06.test.SignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
 	request.setCharacterEncoding("utf-8");


	String id = request.getParameter("id");
	String email = request.getParameter("email");
	//email수정 - DB에있는 회원정보의 사용자의 정보를 수정한다는것
	//DB-DAO필요하다는것
	
	SignupDAO dao = new SignupDAO();
	int result = dao.updateEmail(id, email);//id와 email던져주면서 수정하라고 할것이다
	//DAO에  updateemail메서드 만들러 ㄱㄱ
%>
<body>
<%

if(result == 1){%>
	<h3> <%=id %>님의 이메일 정보가 '<%=email %>'로 수정 되었습니다</h3>
	
<%}else{%>
	
	<h2>수정실패</h2>
	
<% }



%>

</body>
</html>