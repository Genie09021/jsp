<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<c:if test="${result == 1 }">
	<c:redirect url="/member/main.hrd"/>
</c:if>
<c:if test="${result == 0 }">
	<script>
			alert("비밀번호를 확인하고 다시 시도해 주세요");
			history.go(-1);
		</script>
</c:if>
<c:if test="${result == -1 }">
	<script>
			alert("아이디가 존재하지 않습니다 다시 시도해 주세요 ");
			history.go(-1);
	</script>
</c:if>

<body>

</body>
</html>