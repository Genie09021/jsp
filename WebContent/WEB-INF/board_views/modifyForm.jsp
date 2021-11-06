<%@page import="web.jsp12.model.BoardDTO"%>
<%@page import="web.jsp12.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="/web/jsp17/style.css" rel="stylesheet" type="text/css">
</head>

<body>
	<br />
	<h1 align="center"> 게시글 수정 </h1>
	<form action="/web/board/modifyPro.hrd?pageNum=${pageNum }" method="post">
		<%-- 숨겨서 글 고유번호 값 전송 --%>
		<input type="hidden" name="num" value="${num }" />
		<table>
			<tr>
				<td>작성자</td>
				<td align="left"><input type="text" name="writer" value="${article.writer }"/></td>
			</tr>
			<tr>
				<td>제  목</td>
				<td align="left"><input type="text" name="subject" value="${article.subject }"/></td>
			</tr>
			<tr>
				<td>e-mail</td>
				<td align="left"><input type="text" name="email" value="${article.email }"/></td>
			</tr>
			<tr>
				<td>내  용</td>
				<td><textarea rows="20" cols="60" name="content">${article.content }</textarea></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td align="left"><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td colspan="2" >
					<input type="submit" value="수정" />
					<input type="reset" value="재작성" />
					<input type="button" value="취소" onclick="window.location='/web/board/content.hrd?num=${num }&pageNum=${pageNum }'" />
					<input type="button" value="리스트보기" onclick="window.location='/web/board/list.hrd?pageNum=${pageNum }'" />
				</td>
			</tr>
		</table>
	</form>
	
	
</body>
</html>