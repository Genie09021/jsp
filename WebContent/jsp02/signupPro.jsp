<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<%
//post 방식 : 요청 파라미터로 넘어오는 파라미터 값이 한글일 경우 인코딩 처리.
//데이터를 꺼내오기 전에 한번만 적어주자 ! -> 스크립트릿(문서)초반에 작성하자 !!!

request.setCharacterEncoding("UTF-8");

String id =request.getParameter("id");
String pw =request.getParameter("pw");
String email =request.getParameter("email");
String gender =request.getParameter("gender");

String[] hobbies =request.getParameterValues("hobbies");

String birthYY =request.getParameter("birthYY");
String birthMM =request.getParameter("birthMM");
String birthDD =request.getParameter("birthDD");
String job =request.getParameter("job");
String bio= request.getParameter("bio");


//System.out.println(id);

%>
<body>
<h2> Pro page </h2>
	<table>
			<tr>
				<td>ID *<br/>
				<%=id %></td>
			<tr>
				<td>Password *<br/>
				<%= pw %></td>
			<tr>
				<td>Email <br/>
				<%= email %></td>
			<tr>
				<td>Gender <br/>
				<%= gender %></td>
			<tr>
				<td>Date of Birth<br/>
				<%= birthYY %>년 <%=birthMM %> 월<%=birthDD %>일</td>
			<tr>
				<td>Hobbies<br/>
				<%  
				if(hobbies != null){
					for(int i=0; i < hobbies.length;i++) { %>
						<%= hobbies[i] %> 
				
				<%	 	}
				
					}
				%>
				</td>
			</tr>
			<tr>
				<td>bio
				<textarea rows="5" cols="20" name="bio" > <%= bio %> </textarea></td>
			</tr>
			<tr>
				<td>job
				<%= job %>
				</td>
			</tr>
		</table>
			
</body>
</html>