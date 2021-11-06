
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyPro</title>
</head>


<c:if test="${result == 1 }">
	<script>
		alert("게시글이 잘 수정 되었습니다.");
		window.location="/web/board/list.hrd?pageNum="+${pageNum};
	</script>
</c:if>
<c:if test="${result !=1 }">
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>

</c:if>


<body>

</body>
</html>