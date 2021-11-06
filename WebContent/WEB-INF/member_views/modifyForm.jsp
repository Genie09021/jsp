
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="/web/jsp16/style.css" rel="stylesheet" type="text/css">
</head>
<%--// check ==0 :비로그인 check ==1 :로그인 상태 --%>
<c:if test="${check ==0 }">
	<script>
		alert("로그인후 이용해 주세요");
		window.location="/web/member/loginForm.hrd";
	</script>
</c:if>
<c:if test="${check != 0 }">





<body>
<br/>
	<h1 align="center">회원정보 수정</h1>
	<form action = "/web/member/modifyPro.hrd" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>ID *</td>
				<td>
					${member.id }
				</td>
			</tr>
			<tr>
				<td>Password *</td>
				<td>
				<input type = "password" name = "pw" value="${member.pw }"/>
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
				${member.name }
				</td>
			</tr>
			
			<tr>
				<td>Email </td><%--필수입력이 아님으로 입력이 있을 수도 있고 없을 수도 있다 --%>
				<td>
					<input type = "text" name = "email" value="${member.email }"/>
					
				</td>
			</tr>
			
			<tr>
				<td>Date of Birth</td>
				<td>
					<c:if test="${member.birth != null }">
					<input type="text" name="birth" maxlength="8" value="${memeber.birth }"/>
					</c:if>
					<c:if test="${member.birth == null }">
					<input type="text" name="birth" maxlength="8" placeholder="YYYYMMDD"/>
					</c:if>

				</td>
			</tr>
			<tr>
				<td>photo</td>
				<td>
					<c:if test="${member.photo !=null }">
						<img src="web/save/${member.photo }" width="150"/>
					
					</c:if>
					<c:if test="${member.photo == null} ">
						<img src="/web/save/dfim.jpg" width="150"/>
					</c:if>
						<input type="file" name="photo"/>
						<input type="hidden" name="exPhoto" value="${member.photo }"/><%--이전에 저장된 사진정보 hidden으로 보내기 있던없던 보내준다--%>
					</td>
			</tr>
			<tr>
			
				<td colspan="2" align="center">
					<input type="submit" value="수정" />
					<input type="button" value ="취소" onclick ="window.location='/web/member/main.hrd'">
				</td>
			</tr>
		</table>
	</form>
</body>
</c:if>
</html>