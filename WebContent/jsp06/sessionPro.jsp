<%@page import="web.jsp06.test.TestDAO"%>
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
	String pw =request.getParameter("pw");
	
	System.out.println("pro id :" +id);
	System.out.println("pro pw :" +pw);
	
		TestDAO dao = new TestDAO();
		boolean res = dao.loginCheck(id, pw);

		
		
		
		
		//DAO에서 리턴받아 이리로 온다
		if(res){//id,pw확인결과 true
			
			//로그인 처리는 -> 세션속성추가jsp03메모참고
			session.setAttribute("sid", id);//sid이름은 마음대로정한것
			//로그아웃 ->속성 지우는것
			
			//main 으로 이동 
			System.out.println("main으로 이동합니다!");
			response.sendRedirect("sessionMain.jsp");
			
		}else{//id,pw확인결과false %>
		
		<script>
			alert("id 또는 pw오류 ! 다시시도");
			history.go(-1);
		</script>
			
			
			
			
	<%	}


%>


<body>

</body>
</html>