<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%

	request.setCharacterEncoding("UTF-8");

%>

<jsp:useBean id="vo" class="web.jsp04.test.SignupFormVO"/>
<jsp:setProperty property="*" name="vo"/>



<body>
	<table>
			<tr>
				<td>ID *<br/>
				<jsp:getProperty property="id" name="vo"/>
				</td>
			</tr>
			<tr>
				<td>Password *<br/>
				<jsp:getProperty property="pw" name="vo"/>
				</td>
			</tr>
			<tr>
				<td>Email <br />
				<jsp:getProperty property="email" name="vo"/>
				</td>
			</tr>
			<tr>
				<td>Gender *<br />
				<jsp:getProperty property="gender" name="vo"/>
				</td>
			</tr>
			
			<tr>
				<td>Date of Birth
				<jsp:getProperty property="birthYY" name="vo"/>년
				<jsp:getProperty property="birthMM" name="vo"/>월
				<jsp:getProperty property="birthDD" name="vo"/>일
				</td>
			</tr>
			
			
			
			<tr>
				<td>Job
				<jsp:getProperty property="job" name="vo"/>
				</td>
			</tr>
			<tr>
				<td>bio
		
				<textarea rows="5" cols="20" name="bio" >
				<jsp:getProperty property="bio" name="vo"/>
				</textarea>
				</td>
			</tr>
			
		</table>


</body>
</html>