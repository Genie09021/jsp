
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="/web/jsp17/style.css" rel="stylesheet" type="text/css">
</head>

<body>
	<br />
	<h1 align="center"> Content </h1>
	<table>
		<tr>
			<td colspan="2"> <b>${article.subject }</b> </td>
		</tr>
		<tr>
			<td colspan="2" height="100"> ${article.content}</td>
		</tr>
		<tr>
			<td>posted by <a href="mailto:${article.email }"><b>${article.writer }</b></a> 
				at ${article.reg }
			</td>
			<td> ${article.readcount } viewed </td>
		</tr>
		<tr>
			<%-- <c:if test="${article.writer == sessionScope.sid }">
			
			</c:if>--%>
			<td colspan="2">   
				<button onclick="window.location='/web/board/modifyForm.hrd?num=${num }&pageNum=${pageNum }'">수 정</button>
				<button onclick="window.location='/web/board/deleteForm.hrd?num=${num }&pageNum=${pageNum }'">삭 제</button>
				<button onclick="window.location='/web/board/writeForm.hrd?num=${num }&ref=${article.ref }&re_step=${article.re_step }&re_level=${article.re_level }'">답 글</button>
				<button onclick="window.location='/web/board/list.hrd?pageNum=${pageNum }'">리스트</button>
			
			</td>
		</tr>
	</table>

</body>
</html>