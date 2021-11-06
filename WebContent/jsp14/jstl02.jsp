<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--fmt 커스텀 태그를 이 jsp 파일에서 사용하겠다 --%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>jstl02.jsp</title>
</head>
<body>

	<h2>jstl 02 page 요청</h2>
	<%--requestEncoding --%>
	<%//request.setCharacterEncoding("UTF-8"); 와 동일 %>
	<fmt:requestEncoding value="UTF-8"/>
	
	
	<%--날짜 관련 --%>
	<fmt:formatDate value="${day}"/> <br/>
	<fmt:formatDate value="${day}" type="date"/> <br/>
	<fmt:formatDate value="${day}" type="time"/> <br/>
	<fmt:formatDate value="${day}" type="both"/> <br/>
	<br/>
	<fmt:formatDate value="${day}" type="both" dateStyle="short"/> <br/>
	<fmt:formatDate value="${day}" type="both" dateStyle="medium"/> <br/>
	<fmt:formatDate value="${day}" type="both" dateStyle="long"/> <br/>
	<fmt:formatDate value="${day}" type="both" dateStyle="full"/> <br/>
	<br/>
	
	<fmt:formatDate value="${day}" type="both" dateStyle="short" timeStyle="short"/> <br/>
	<fmt:formatDate value="${day}" type="both" dateStyle="medium" timeStyle="medium"/> <br/>
	<fmt:formatDate value="${day}" type="both" dateStyle="long" timeStyle="long"/> <br/>
	<fmt:formatDate value="${day}" type="both" dateStyle="full" timeStyle="full"/> <br/>
	<br/>
	<%--위 처럼 만들어진 포멧말고 내가 지정한 포멧 사용 가능 --%>
	<fmt:formatDate value="${day }" pattern="yy년 MM월 dd일" /> <br/>
	
	<%-- 숫자 관련  --%>
	<fmt:formatNumber value="1000000" groupingUsed="true" /> <br/><%--자릿수를 구분해줌 --%>
	<fmt:formatNumber value="1000000" groupingUsed="false" /> <br/>
	<fmt:formatNumber value="1000000" type="number" /> <br/>
	<fmt:formatNumber value="1000000" type="currency" currencySymbol="\\"/> <br/>
	<fmt:setLocale value="en_us"/>
	<fmt:formatNumber value="150.25" type="currency" currencySymbol="$"/> <br/>
	
	<fmt:formatNumber value="0.3" type="percent" /> <br/>
	<fmt:formatNumber value="150.333" pattern=".0" /> <br/>
	
	
	<%--timezone 한국표준시간 KST --%>
	<fmt:timeZone value="GMT">
		런던 GBR : <fmt:formatDate value="${day }" type="both"/>
	</fmt:timeZone>
	<br/>
	<fmt:timeZone value="GMT-4">
		뉴욕 NY : <fmt:formatDate value="${day }" type="both"/>
	</fmt:timeZone>
	
	<%--문자열을 숫자로 파싱(변환) integerOnly 속성을 사용하면 소수점 날라감 --%>
	<fmt:parseNumber value="1000.123" var="result" integerOnly="true"/> <br/>
	result :  ${result }
	
	
	
	
	
	
</body>
</html>