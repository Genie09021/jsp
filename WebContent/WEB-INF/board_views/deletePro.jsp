
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

<c:if test="${result == 1 }">
	<script type="text/javascript">
	alert("게시글 삭제 완료 !!");
	window.location="/web/board/list.hrd?pageNum=" + ${pageNum};
	</script>
</c:if>
<c:if test="${result != 1 }">
	<script>
	alert("비밀번호 확인후 다시 시도해 주세요");
	history.go(-1);
	</script>
</c:if>

<body>

</body>
</html>