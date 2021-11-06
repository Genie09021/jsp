<%@page import="web.jsp11.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");

	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.idPwCheck(id,pw);
	
	System.out.println(pw);
	
	//1 = ok,0 = pw틀림, -1 = id없다
	if(result == 1){
		//로그인 처리
		session.setAttribute("sid", id);
		response.sendRedirect("main.jsp");
	}else if(result == 0){%>
		<script>
			alert("비밀번호 틀림");
			history.go(-1);
		</script>
	<%}else if(result == -1){%>
		<script>
			alert("아이디가 존재하지 않습니다 다시 시도해 주세요 ");
			history.go(-1);
		</script>
	<%}
	
%>
<body>

</body>
</html>