<%@page import="web.jsp07.model.MemberDTO"%>
<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modify Form</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
//+6.10
if(session.getAttribute("memId") ==null){%>
	<script>
	alert("로그인 해 주세요");
	window.location = "/web/jsp07/loginForm.jsp";
	</script>
	
<% }else{


//로그인하고 마이페이지 실행해야함 

	String id = (String)session.getAttribute("memId");
	
	MemberDAO dao = new MemberDAO();
	MemberDTO user =dao.getUser(id);
	
%>

<body>

	<br/>
	<h2 align="center">회원정보 수정</h2>

	<form action ="modifyPro.jsp" method="post" >
		<table>
			<tr>
				<td>ID *</td>
				<td>
				<%= user.getId() %>
				</td>
			</tr>
			<tr>
				<td>Password *</td>
				<td>
					<input type = "password" name = "pw" value="<%=user.getPw()%>"/>
				</td>
			</tr>
			<tr>
				<td>Password Confirm *</td>
				<td>
					<input type = "password" name = "pwCh"/>
				</td>
			</tr>
			
			<tr>
				<td>Name *</td>
				<td>
					<%=user.getName() %>
				</td>
			</tr>
			
			<tr>
				<td>Email </td>
				<td>
				<% if(user.getEmail() == null){ %>
						<input type = "text" name = "email"/>
					<%}else{ %>
						<input type = "text" name = "email" value ="<%=user.getEmail() %>"/>
					<%} %>
				</td>
			</tr>
			
			<tr>
				<td>Date of Birth</td>
				<td>
					<% if(user.getBirth() == null){ %>
					<input type="text" name="birth" placeholder="YYYYMMDD" maxlength="8"/>
					<%}else{ %>
					<input type="text" name="birth" placeholder="YYYYMMDD" value="<%=user.getBirth() %>"/>
					<%} %>
				
				</td>
			</tr>
			<tr>
			
				<td colspan="2" align="center">
					<input type="submit" value="수정" />
					<input type="reset" value="재작성" />
					<input type="button" value ="취소" onclick ="window.location='main.jsp'">
				</td>
			</tr>
		</table>
	</form>


</body>

<%} //else닫기%>
</html>