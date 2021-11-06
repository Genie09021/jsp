<%@page import="web.jsp12.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Signup pro</title>
</head>
<%
	request.setCharacterEncoding("utf-8");

%>
	<jsp:useBean id="dto" class ="web.jsp12.model.MemberDTO"/>
	<jsp:setProperty name="dto" property="*" />
	
<%
	//dao에게 일 시킬것이다
	MemberDAO dao = MemberDAO.getInstance();
	//일시킬 메서드 만들어 줄것이다
	dao.insertMember(dto);
	
	
	//페이징 처리 #1. 가입처리 직후 바로 메인으로 이동시키기(사용자는 가입누르면 바로 main페이지가 보일것)
	response.sendRedirect("main.jsp");//바로이동
	
%>


<body>

  
	<script>
		//페이징 처리 #3.
		//alert("회원가입 정상처리");
		//window.location.href ="main.jsp"; //메인으로 이동
	</script>
 


	<%--페이징 처리 #2. 가입처리후 화면에 가입완료 메세지와 버튼 보일것. 사용자가 누르면 메인으로 이동하는 커리 
	<h4> 회원가입 완료</h4>
	<button onclick ="window.location='main.jsp'">main으로 이동</button>--%>
	
	<%--페이징 처리 #4. 가입처리후 화면에 가입완료 메세지보여주고 5초후 다시 main이동
	<h4 align="center"> <%=dto.getId()%> 님, 회원가입 완료</h4>
	<meta http-equiv ="Refresh" content ="5;url=main.jsp"/>--%>
	
</body>
</html>