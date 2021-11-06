<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>el02.jsp</title>
</head>
<%

	//테스트용으로 스크립트릿 사용(앞으로는 안쓸것임)
	request.setAttribute("name", "피카츄");//앞으로는 controller에 작성될것임, 지금은 그냥 여기다 작성 테스트용

		//request.setAttribute("memId", "java");
		session.setAttribute("memId", "pika");
%>
<body>

	요청 URI : ${pageContext.request.requestURI }<br/>
	request 의 name 속성 : ${requestScope.name } <br/>
	test 파라미터 : ${param.test }<br/>
	
	<%--http://localhost:8080/web/jsp14/el02.jsp?test=1234 로 요청해서 파라미터 확인--%>
	
	이름만 지정 : ${name } <br/>
	값이 존재하지 않는 경우 : ${memId }<br/>
	





</body>
</html>