<%@page import="web.jsp09.model.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css"/>
</head>
<%
	request.setCharacterEncoding("utf-8");
%>
	<jsp:useBean id="article" class="web.jsp09.model.BoardDTO"/>
	<jsp:setProperty property="*" name ="article"/>
<%
	//넘어오는 데이터들을 제외한 나머지 채울부분 채워주기
	article.setReg(new Timestamp(System.currentTimeMillis()));
	article.setReadcount(0);
	
	//DB에 article 객체 주면서 저장 시키기
	BoardDAO dao = new BoardDAO();
	dao.insertArticle(article);
	
	//게시판 목록으로 이동
	response.sendRedirect("list.jsp");
%>
<body>

</body>
</html>