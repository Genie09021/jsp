<%@page import="web.jsp09.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	//+페이지 넘도 뽑아놓기
	String pageNum = request.getParameter("pageNum");
	//num,pw,
	int num = Integer.parseInt(request.getParameter("num"));
	String pw = request.getParameter("pw");
	
	System.out.println(num);
	System.out.println(pw);
	

	//DB상 비번과 일치하면 해당 글 삭제 처리
	BoardDAO dao = new BoardDAO();
	int result = dao.deleteArticle(num,pw);
	if(result == 1){
		String uri = "list.jsp?pageNum=" + pageNum;
		response.sendRedirect(uri);
		//삭제 잘 되었을 경우에도 alert 띄운다음 list로 이동하고 싶으면
		//response.sendRedirext() 사용하지 말고,
		//스크립트로 모두 처리 : alert("...."); window.location="list.jsp";
	}else{%>
		<script>
			alert("비밀번호 확인후 다시 시도해 주세요");
			history.go(-1);
		</script>
	<%}
%>
<body>



</body>
</html>