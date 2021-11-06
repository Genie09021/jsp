<%@page import="web.jsp12.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>delete pro</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%

	//넘어오는 데이터 : pw
	String id = (String)session.getAttribute("memId");
	String pw = request.getParameter("pw");
	
	
	
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.deleteUser(id,pw);
	//result == 1 :회원탈퇴 성공
	//result == 0 :비번 잘못 쓴거
	//result == -1 :비밀번호 확인 잘 안된것.비밀번호 가져오는것 부터 잘못됨 id가 문제일 가능성이 높음.
	
	//회원 정보 삭제가 잘 진행 되었을때 ,
	if(result == 1 ){
		
		//회원탈퇴시 로그아웃 처리도 함께 해주는것
		session.invalidate();
		//쿠키가 있으면 쿠키도 삭제 
		Cookie[] coos =request.getCookies();
		if(coos!= null){
			for(Cookie c :coos){
				if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("autoCh")){
					c.setMaxAge(0);
					response.addCookie(c);
				}
				
			}
		}
		
	%>

<body>
	<h1 align ="center">회원 탈퇴</h1>
	<table>
	
		<tr>
				<td>회원정보가 삭제 되었습니다</td>
		</tr>
		<tr>
				<td><button onclick ="window.location ='main.jsp'">메인으로</button></td>
		</tr>
	</table>

</body>
		
	<% }else{%>
		
		<script>
			alert("비밀번호가 맞지 않습니다. 다시 시도해 주세요");
			history.go(-1);
		</script>
		
	<%}
%>
</html>