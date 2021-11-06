<%@page import="web.jsp07.model.MemberDAO"%>
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
	request.setCharacterEncoding("utf-8");

%>
<jsp:useBean id="dto" class ="web.jsp07.model.MemberDTO"/>
<jsp:setProperty property ="*" name="dto"/>
<%

	//넘어오는 데이터 : pw,birth,email -> 수정은 birth ,email 만 수정(비밀번호 변경은 따로..)
	//데이터가 넘어오건안넘어오건 무조건 가져오긴올것이다
	//비워서오는지 채워서오는지 우리는 알 수가 없기때문에.
	//경우에따라 모두 만들 수 없다.
	//미리 뿌려줘서 ,그걸보고 수정하던말던 
	//pw수정은 따로 빼겠다.
	
	//update users set birth=?, email =? where id = ? 
	//modifyForm 에서는 id값이 안 넘어와서 위에 dto 자동으로 채워주지 못함
	//그래서 session에서 id값을 꺼내서 dto에따로 추가해 줄것
	
	//String id =(String)session.getAttribute("memId");
	//dto.setId(id)
	dto.setId((String)session.getAttribute("memId"));
	
	//DB에 접근해서 해당 id 의 birth 와 email 업데이트 해주기
	MemberDAO dao = new MemberDAO();
	int result = dao.updateUser(dto);
	
	
	
%>
<body>
	<br/>
	<h2 align="center">회원정보 수정</h2>
	
<%//회원정보수정 잘된
	if(result ==1){%>
		<table>
		<tr>
				<td><b>회원정보가 수정되었습니다</b>
				</td>
		</tr>
		<tr>
				<td><button onclick="window.location='main.jsp'">메인으로</button>
				</td>
		</tr>
		</table>
		
	<%}else{%>
		
		<script>
			alert("회원정보 수정 실패...");
			history.go(-1);
		</script>
		
	<%}%>

</body>
</html>