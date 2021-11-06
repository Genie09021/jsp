<%@page import="web.jsp05.test.TestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<%
 
	request.setCharacterEncoding("UTF-8");	// 버전 1, 2 
/* 버전 1
String id = request.getParameter("id");
String pw = request.getParameter("pw");
int age = Integer.parseInt(request.getParameter("id"));
TestDAO dao = new TestDAO();
dao.insert(id, pw, age);//dao 메서드 먼저 정의해놓고 dao로 insert만들러감
*/

%>
<%--버전2 --%>
<jsp:useBean id="dto" class="web.jsp05.test.TestDTO"/>
<jsp:setProperty property ="*" name ="dto"/>

<%


TestDAO dao = new TestDAO();
//dao.insert(id, pw, age); 구버전 주석처리
dao.insert2(dto);

%>
<body>
<h2> pro</h2>

</body>
</html>