<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td colspan="2"> 
				<jsp:include page="layoutTop.jsp"/>
			</td>
		</tr>
		<tr>
			<td> 
				<jsp:include page="layoutLeft.jsp"></jsp:include>
			</td>
			<td> 
				<form action ="signupPro.jsp" method="post" >
				<table>
					<tr>
						<td>ID *<br/>
						<input type = "text" name = "id"/>
						</td>
					</tr>
					<tr>
						<td>Password *<br/>
						<input type = "password" name = "pw"/>
						</td>
					</tr>
					<tr>
						<td>Email <br />
						<input type = "text" name = "email"/>
						</td>
					</tr>
					<tr>
						<td>Gender *<br />
						<input type = "radio" name = "gender" value ="male" checked/>남
						<input type = "radio" name = "gender" value ="female" />여
						</td>
					</tr>
					<tr>
						<td>Hobbies<br />
						<input type = "checkbox" name = "hobbies" value ="music" />music
						<input type = "checkbox" name = "hobbies" value ="sports" />sports
						<input type = "checkbox" name = "hobbies" value ="travel" />travel
						<input type = "checkbox" name = "hobbies" value ="movies" />movie
						</td>
					</tr>
				
					<tr>
						<td>Date of Birth
						<input type="text" name="birthYY" placeholder="YYYY"/>년
						<input type="text" name="birthMM" placeholder="MM"/>년
						<input type="text" name="birthDD" placeholder="DD"/>년
						</td>
					</tr>
					<tr>
						<td>Job
						<select name="job">
						<option>Employer</option>
						<option>Employee</option>
						<option>Teacher</option>
						<option>Student</option>
						</select>
						</td>
					</tr>
					<tr>
						<td>bio
				
						<textarea rows="5" cols="20" name="bio" ></textarea></td>
					</tr>
					<tr>
					<td><input type="submit" value="signup" /></td>
					</tr>
				</table>
			</form>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p>글로벌 아이티 인재개발원
						tel:00000000000</p>
			</td>
		</tr>
	
	
	
	
	
	</table>

</body>
</html>