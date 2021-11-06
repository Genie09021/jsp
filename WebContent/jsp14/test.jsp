<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>test.jsp</title>
</head>
<body>
		
		<h2> 기존 : <%=request.getAttribute("num") %></h2>
		<h2> 기존 : <%=request.getAttribute("id") %></h2>
	
	
		<h2>EL : ${requestScope.num }</h2>
		<h2>EL : ${requestScope.id }</h2>
	
		<h2> EL : ${num }</h2>
		<h2> EL : ${id }</h2>
		
		<h2>기존 : <%=request.getAttribute("myList") %></h2>
		<h2> EL : ${myList }</h2>
		
		
		
		<h2>EL 문자형태 숫자 연산 : ${age + '10' }</h2>
		<h2>EL 문자형태 숫자 연산 : ${age } hello</h2>
		
		<h2>session num : <%=session.getAttribute("num") %></h2>
		<h2>EL session num :${sessionScope.num }</h2>
		
		
		<h2>arr : ${arr }</h2>
		<h2>arr : ${arr[0] }</h2>
		
		
		<h2>list : ${list } </h2>
		<H2>list : ${list[0] } </H2> <%-- 자바 배열처럼 사용가능 --%>
		<H2>list : ${list.get(0) } </H2> <%-- arrayList의 get()메서드 사용 가능 --%>

		<h2>vo.id : ${requestScope.vo.id }</h2>
		<h2>vo.id : ${requestScope.vo.getId() }</h2>
		<h2>vo.id : ${requestScope.vo.name }</h2>
		<h2>vo.id : ${requestScope.vo.age }</h2>
		<h2>vo.id : ${vo.id }</h2>

</html>