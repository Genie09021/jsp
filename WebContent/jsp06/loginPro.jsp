<%@page import="web.jsp06.test.TestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//넘어온 id.pw꺼내서 ,해당 id pw가 db상에도 동일하게 저장되어 있으면 로그인 시키기
	String id =request.getParameter("id");
	String pw = request.getParameter("pw");

	//test의 DAO필요
	//결과가맞으면 여기로 가져오고
	TestDAO dao = new TestDAO();
	boolean res = dao.loginCheck(id,pw);
	System.out.println("jsp의 res변수 " + res);
	
	//res ==true 이면 로그인 처리
		if(res){
			
			System.out.println("쿠키생성 완료");
			//쿠키생성으로 로그인 처리
			Cookie c1 = new Cookie("cookieId", id);
			Cookie c2 = new Cookie("cookiePw", pw);
			c1.setMaxAge(60*60*24);//하루 1day 이다.
			c2.setMaxAge(60*60*24);
			
			response.addCookie(c1);//response에 꼭 쿠키저장을 해주어야 한다
			response.addCookie(c2);
			
			
			
			//-id ps잘적으면 
			response.sendRedirect("main.jsp");// 그냥 main페이지로 이동
			
			
		}else{//res == flase 면 뒤로가기처리 ->스크립트로 처리가능.스크립트태그는 어디와든 상관없다. 문법은 자바스크립트문법으로 작성
				
			System.out.println("else 탔다 아이디 비번 오류");%>
			
			
			<script>
				alert("ID또는 PW가 일치하지 않습니다. 다시 시도해 주세요 ! ! ");
				history.go(-1);//다시 form페이지로(이전 페이지)  이동시킴
			
			</script>
				
				
		<%}
			
			
			
	
%>



</body>
</html>