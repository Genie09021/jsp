<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	
</head>
	<script>
		//아이디 중복 여부 판단할 함수 
		function confirmId(inputForm){//<-- inptForm <-this.form 객체 받음
			if(inputForm.id.value == "" || !inputForm.id.value){
				alert("아이디를 입력 하세요");
				return;//메서드 강제 종료시키는것
			}
		//id 받아서 팝업 띄워서 db에 연결해서 물어보고 결과를 받아올것임.
		 var url = "confirmId.jsp?id=" + inputForm.id.value;//confirmId.jsp?id=pika 라고url에 파라미터를 보냄 get으로
			//open(url, "팝업이름","팝업 옵션")
			open(url,"confirmId","toolbar=no, location =no, status=co, menubar=no,scrollbars=no,resizable=no, width=500, height=200" );
		}
	
	</script>
<body>

<br/>
<h2 align="center">회원가입</h2>

	<form action ="signupPro.jsp" method="post" name="inputForm" enctype="multipart/form-data">
		<table>
			<tr>
				<td>ID *</td>
				<td>
				<input type = "text" name = "id"/>
				</td>
			</tr>
			<tr>
				<td>아이디 중복 체크</td>
				<td>
				<input type = "button" value = "아이디 중복 확인" onclick="confirmId(this.form)"/>
				</td>
			</tr>
			<tr>
				<td>Password *</td>
				<td>
				<input type = "password" name = "pw"/>
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
				<input type = "text" name = "name"/>
				</td>
			</tr>
			
			<tr>
				<td>Email </td>
				<td>
				<input type = "text" name = "email"/>
				</td>
			</tr>
			
			<tr>
				<td>Date of Birth</td>
				<td>
				<input type="text" name="birth" placeholder="YYYYMMDD" maxlength="8"/>
				
				</td>
			</tr>
			<tr>
				<td>photo</td>
				<td>
				<input type="file" name="photo"/>
				
				</td>
			</tr>
			<tr>
			
				<td colspan="2" align="center">
					<input type="submit" value="가입" />
					<input type="reset" value="재작성" />
					<input type="button" value ="취소" onclick ="window.location='main.jsp'">
				</td>
			</tr>
		</table>
	</form>
	
</body>
</html>
