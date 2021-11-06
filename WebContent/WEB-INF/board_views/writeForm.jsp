<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>writeForm</title>
	<link href="/web/jsp17/style.css" rel="stylesheet" type="text/css">
</head>

<body>
	<br />
	<h1 align="center"> 게시글 작성 </h1>
	<form action="/web/board/writePro.hrd" method="post">
		<%-- 숨겨서 글 속성 값 전송 --%>
		<input type="hidden" name="num" value="${num }" />
		<input type="hidden" name="ref" value="${ref }" />
		<input type="hidden" name="re_step" value="${re_step }" />
		<input type="hidden" name="re_level" value="${re_level }" />
		<table>
			<tr>
				<td>작성자</td>
				<td align="left">${id }</td><%--${sessionScope.sid} 회원가입 연동후--%>
			</tr>
			<tr>
				<td>제  목</td>
				<td align="left">
				<c:if test="${num == 0 }">
					<input type="text" name="subject" />
				
				</c:if>
				<c:if test="${num != 0 }">
					<input type="text" name="subject" value="[답글]" />
				
				</c:if>
				</td>
			</tr>
			<tr>
				<td>e-mail</td>
				<td align="left"><input type="text" name="email" /></td>
			</tr>
			<tr>
				<td>내  용</td>
				<td><textarea rows="20" cols="60" name="content"></textarea></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td align="left"><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td colspan="2" >
					<input type="submit" value="저장" />
					<input type="reset" value="재작성" />
					<input type="button" value="리스트보기" onclick="window.location='/web/board/list.hrd'" />
				</td>
			</tr>
		</table>
	</form>
	
</body>
</html>