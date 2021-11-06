<%@page import="web.jsp14.mvc.TestVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--core태그 사용하겠다 선언 --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstl01.jsp</title>
</head>
<body>

	<%--변수 선언 --%>
	<c:set var="id" value="java"/>
	<c:set var="name">피카츄</c:set>


	<h2> id : ${id }</h2>
	<h2> name : ${name }</h2>


	<%--프로퍼티 설정 : 방식 통일해서 설정 --%>
	<%-- * 스크립트릿, 표현식 사용 :앞으로는 스크립트 태그를 사용 안할것이니 몰라도 지워도 됨--%>
	<% TestVO vo = new TestVO(); %>
	<c:set target="<%=vo %>" property ="id" value="pikachu"/>
	<h2>vo.id = <%=vo.getId() %></h2>
	
	<%-- * 액션태그, EL사용 :이제부터는 이방식 사용 --%>
	<jsp:useBean id="vo2" class="web.jsp14.mvc.TestVO"/>
	<c:set target="${vo2 }" property ="id" value="krong"/>
	<h2>vo.id el : ${vo2.id} </h2>
	
	
	<%--변수 삭제 --%>
	<c:remove var="id"/>
	<c:remove var="name"/>
	
	<h2> id : ${id }</h2>
	<h2> name : ${name }</h2>
	
	<%--if --%>
	<c:set var="num" value="80"/> <%--int num = 100; 과같은것 --%>
	<c:if test="${num >=100 }">
		<h2>${num }은 100보다 크거나 같다</h2>
	</c:if>
	<c:if test="${num < 100 }">
		<h2>${num }은 100보다 작다</h2>
	</c:if>
	
	<%--choose --%>
	<c:choose>
		<c:when test="${num >100 }">
			<h2>100보다 크다</h2>
		</c:when>
				<c:when test="${num <100 }">
			<h2>100보다 작다</h2>
		</c:when>
		<c:otherwise>
			<h2>100이다</h2>
		</c:otherwise>
		
	</c:choose>
	
	
	
	<%-- forEach --%>
	<c:set var="arr" value="<%=new int[]{1,2,3,4,5} %>"/>
	
	<c:forEach var="i" items="${arr}">
		<h3>${i} </h3>
	</c:forEach>
	
	<c:forEach var="a" begin="1" end="10" step="1">
		<h3> a : ${a }</h3>
	</c:forEach>
	
	
	
	<%--구구단 2단 ~ 9단 전체 출력 --%>
	
	<c:forEach var ="a" begin="2" end="9" step="1">
		<c:forEach var ="b" begin="2" end="9" step="1">
			<h2> a * b = ${a } * ${b}</h2>
			
		</c:forEach>
	
	</c:forEach>
		<%--구구단 2단 ~ 9단 전체 출력 --%>
	
	<c:forEach var ="i" begin="2" end="9" step="1">
		<h1>*** ${i} 단 ***</h1>
		<c:forEach var ="j" begin="2" end="9" step="1">
			<h2> ${i} * ${j} = ${i } * ${j}</h2>
			
		</c:forEach>
	
	</c:forEach>
	
	<c:forEach var="a" items="${arr}" begin="2" end="4" varStatus="status">
		<h3> a = ${a } / status.index : ${status.index} / ${arr[status.index] } </h3>
	
	</c:forEach>
	
	<%--사용방법 예시 
	 글 제목만 vo에서 뽑아서 저장하려고 할떄
	<c:forEach var="vo" items="${articleList }">
		<h2>${vo.subject }</h2>
	
	</c:forEach>
	--%>
	
	<%--forTokens예시 //잘라서 반복하는 반복문의 일종--%>
	<c:forTokens var="s" items="a,bc,d,e,f,g" delims=",">
		<h2>${s }</h2>
	</c:forTokens>
	
	<%--import 예시 --%>
	<c:import var="login" url="/jsp13/loginForm.jsp"/>
	
		${login }
	
	
	
	<%-- url  --%>
	<c:url var="u" value="../jsp13/loginForm.jsp"><%--절대경로 상대경로 둘다 가능하다 --%>
		<c:param name="id" value="12345"/>
		<c:param name="pw" value="aaaa"/>
	</c:url>
	<%-- <c:redirect url="${u }"/>--%>
	<%-- <c:redirect url="/jsp13/hello.jsp" />--%> <%--context path는 생략하고 작성한다 --%>
	
	<%--out --%>
	<h1><c:out value="${num }"/></h1>
	<h1>${num }</h1>
	
	
</body>
</html>