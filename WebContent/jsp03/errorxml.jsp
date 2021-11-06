<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<input type="text" name="text"/><!-- input이 form 태그 외부에 있기때문에 가져갈 수 없다 
	가져가려면form태그 내부에 써주기 form은 여러개 만들어도 됨-->
	<form action="errorxmlPro.jsp" method="post">
	num 1 : <input type="text" name="num1"/><br/>
	num 2 : <input type="text" name="num2"/><br/>
	 	<input type="submit" name="나누기"/><br/>
	</form>


</body>
</html>