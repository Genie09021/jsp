<%@page import="web.jsp06.test.SignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%--회원가입  db에 저장시키기 --%>
<%

	request.setCharacterEncoding("utf-8");


%>
<jsp:useBean id="vo" class="web.jsp06.test.SignupVO"/>
<jsp:setProperty property="*" name="vo"/>

<%
		//DAO객체 생성
		SignupDAO dao = new SignupDAO();
		//회원정보 db에 저장시키는 메서드 호출 이때 데이터는 vo하나 보내기
		dao.insertForm(vo);
%>


<body>
	<h2>pro</h2>

</body>
</html>