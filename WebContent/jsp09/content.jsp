<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.jsp09.model.BoardDTO"%>
<%@page import="web.jsp09.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");//list에서 보고있던 페이지 번호 던져준것, 뽑아주기
	//글 고유번호주고 해당 글에 대한 내용 db에서 가져오기
	BoardDAO dao = new BoardDAO();
	BoardDTO article =dao.getArticle(num);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
%>
<body>
	<br/>
	<h1 align="center"> Content</h1>
	<table>
		<tr>
			<td colspan ="2"><b><%=article.getSubject() %></b></td>
		</tr>
		<tr>
			<td colspan ="2" height="100"><%=article.getContent() %></td>
		</tr>
		<tr>
			<td >posted by <a href ="mailto:<%=article.getEmail()%>"><b><%=article.getWriter() %></b></a> 
			at <%=sdf.format(article.getReg()) %></td>
			<td><%=article.getReadcount() %> viewed </td>
		</tr>
		<tr>
			<td colspan ="2">
			<button onclick="window.location='modifyForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">수정</button>
			<button onclick="window.location='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">삭제</button>
			<button onclick="window.location='writeForm.jsp?num=<%=num%>&ref=<%=article.getRef()%>&re_step=<%=article.getRe_step()%>&re_level=<%=article.getRe_level()%>'">답글</button>
			<button onclick="window.location='list.jsp?pageNum=<%=pageNum%>'">리스트</button>
			</td>
		</tr>
	</table>


</body>
</html>