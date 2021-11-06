<%@page import="web.jsp09.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyPro</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	//넘어오는 데이터 셋팅시키기
%>
	<jsp:useBean id="article" class = "web.jsp09.model.BoardDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="article"/>
<body>
<%

	//+페이지 넘도 뽑아놓기
	String pageNum = request.getParameter("pageNum");

	//DB에 article 던져주며 업데이트 시키기
	System.out.println(article.getPw());
	BoardDAO dao = new BoardDAO();
	int result = dao.updateArticle(article);
	//넘어오는 데이터 num,writer,subject, email,content ,pw
	
	if(result == 1) {
		String uri = "list.jsp?pageNum=" + pageNum;
		response.sendRedirect(uri);
		//content로 이동하고 싶을 경우에는 글 고유번호도 같이 보내기
		//"content.jap?num=" + article.getNum();
	}else{%>
		<script>
			alert("비밀번호가 맞지 않습니다");
			history.go(-1);
		</script>
	<%}
%>

</body>
</html>