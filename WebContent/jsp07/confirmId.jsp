<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Id 중복 확인 페이지</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	//사용자가 작성해 놓은 id값을 받아서 db에 존재하는지 여부 체크 필요
	//주소 뒤에 붙여온 파라미터 꺼내기
	String id =request.getParameter("id");
	//db에서 해당id가 존재하는지 ㅊㅔ크
	MemberDAO dao = new MemberDAO();
	boolean result = dao.confirmId(id);

%>
<body>
<br/>
<%	if(result){//id가 존재함%>
		<table>
			<tr>
				<td><%=id %> ,이미 사용중인 아이디 입니다.</td>
			</tr>
		</table>
		<br/>
		<form action ="confirmId.jsp" method = "post">
			<table>
				<tr>
					<td>다른 아이디를 입력해 주세요<br/>
					<input type="text" name="id"/>
					<input type="submit" value="id중복 확인"/>
					</td>
				</tr>
			</table>
		</form>
		
	<% }else{ //id가 존재하지 않는경우 , 즉 사용 가능한 경우%>
		<table>
			<tr>
				<td>입력하신 <%=id %>는 ,사용 가능한 아이디 입니다.
				<input type="button" value="닫기" onclick="setId()"/></td>
			</tr>
		</table>
		
	<%}
%>
<script>
	function setId(){
		//signupForm페이지의 id 태그에 값 변경해 주기
		opener.document.inputForm.id.value = "<%= id %>"; 
		self.close();//팝업창 닫기
	}

</script>

	
</body>
</html>