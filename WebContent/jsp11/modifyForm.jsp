<%@page import="web.jsp11.model.MemberDTO"%>
<%@page import="web.jsp11.model.MemberDAO"%>
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
	//db에서 내정보 id로 긁어오기 할건데 , id는 넘어오는 파라미터가 없음으로 세션에서 
	String id = (String)session.getAttribute("sid");
	//db에서 id에 해당하는 전체 정보를 가져와 하단에 뿌려주기
		MemberDAO dao = MemberDAO.getInstance();//DAO는 싱글턴으로 구성하였음으로, 객체 얻어다 사용(new못쓴다)
		MemberDTO member = dao.getMember(id);//id에 해당하는 정보 긁어와~~

%>
<body>
<br/>
	<h1 align="center">회원정보 수정</h1>
	<form action = "modifyPro.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>ID *</td>
				<td>
				<%=member.getId()%> , <%=id %>
				</td>
			</tr>
			<tr>
				<td>Password *</td>
				<td>
				<input type = "password" name = "pw" value="<%=member.getPw()%>"/>
				</td>
			</tr>
			<tr><%--유효성 검사 필요 /추가하기 --%>
				<td>Password Confirm *</td>
				<td>
				<input type = "password" name = "pwCh"/>
				</td>
			</tr>
			
			<tr>
				<td>Name *</td>
				<td>
				<%=member.getName()%>
				</td>
			</tr>
			
			<tr>
				<td>Email </td><%--필수입력이 아님으로 입력이 있을 수도 있고 없을 수도 있다 --%>
				<td>
					<%
						if(member.getEmail() == null || member.getEmail().equals("null")) {%>
						<input type = "text" name = "email"/>
					<%}else{ %>
						<input type = "text" name = "email" value="<%=member.getEmail()%>"/>
					<%} %>
					
					<%--null이아닐때를 조건으로 하면 더 편함 . cap참고 --%>
				</td>
			</tr>
			
			<tr>
				<td>Date of Birth</td>
				<td>
				<%if(member.getBirth() != null) {%>
					<input type="text" name="birth" maxlength="8" value="<%=member.getBirth()%>"/>
				<%}else{ %>
					<input type="text" name="birth" maxlength="8" placeholder="YYYYMMDD"/>
				<%} %>
				</td>
			</tr>
			<tr>
				<td>photo</td>
				<td>
					<% if(member.getPhoto() != null){//사진이 이미 저장되었는게있을경우 보여주기-분기처리%>
						<img src="web/save/<%=member.getPhoto()%>" width="150"/>
					<%}else{//저장된 사진이 없을경우 디폴트 이미지로 보여주기-분기처리%>
						<img src="/web/save/dfim.jpg" width="150"/>
					<%} %>
					<%--기존 사진이 있는지 없는지에따라,기존 사진이 있을경우 hidden으로 안넘겨주면 기존사진이 날아감으로--%>
					<input type="file" name="photo"/><%--무조건띄워줄것 버튼으로 사진 올릴지말지는 자유 기회는준다/무조건 업데이트는 될것이다--%>
					<input type="hidden" name="exPhoto" value="<%=member.getPhoto() %>"/><%--이전에 저장된 사진정보 hidden으로 보내기 있던없던 보내준다--%>
					</td>
			</tr>
			<tr>
			
				<td colspan="2" align="center">
					<input type="submit" value="수정" />
					<input type="button" value ="취소" onclick ="window.location='main.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>