<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//쿠키확인 ->쿠키전부 꺼내기
		Cookie[] coos = request.getCookies();
		for(Cookie c : coos){
			out.println(c.getName() +"="+ c.getValue() + "<br/>");
			
			//삭제하겠다면 , 똑같이 쿠키 전부 꺼내서 
			if(c.getName().equals("java")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
			
		}


%>


<body>

</body>
</html>