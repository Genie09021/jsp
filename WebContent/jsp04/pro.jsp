<%@page import="web.jsp04.test.FormVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");//나중에 form 의 method ="post"로 변경하면 필요 
	
	//FormVO vo = new FormVO();//패키지가 다름으로 import 필요 
	//넘어온 데이터를 저장할 FormVO객체 생성해 놓기
	
	//넘어온 파라미터를 request 객체에서 각각 꺼내서 변수에 저장해 놓기
	//String idd = request.getParameter("id");
	//String pw = request.getParameter("pw");
	//String name = request.getParameter("name");
	//int age = Integer.parseInt(request.getParameter("age"));
	
	//VO에  request에서 각각의 넘어온 데이터를 뽑아서 데이터 담기
	//vo.setId(idd);
	//vo.setId(request.getParameter("id"));
	//vo.setPw(request.getParameter("pw"));
	//vo.setName(request.getParameter("name"));
	//vo.setAge( Integer.parseInt(request.getParameter("age")));
	

%>



<jsp:useBean id="vo" class="web.jsp04.test.FormVO"/>

<jsp:setProperty name="vo" property="*" />

<%--넘어온 파라미터 자동으로 찾아서, 해당 set메서드 호출하여 값 저장 
<jsp:setProperty name="vo" property="id" />
<jsp:setProperty name="vo" property="name" />
<jsp:setProperty name="vo" property="pw" />
<jsp:setProperty name="vo" property="age" />--%>


<body>





id : <%= vo.getId() %> 
pw : <%= vo.getPw() %> 
name : <%= vo.getName() %> 
age : <%= vo.getAge() %> 

<jsp:getProperty name="vo" property="id"/>
<jsp:getProperty name="vo" property="pw"/>
<jsp:getProperty name="vo" property="name"/>
<jsp:getProperty name="vo" property="age"/>

</body>
</html>