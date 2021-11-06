<%@page import="java.util.List"%>
<%@page import="web.jsp10.model.UploadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String writer = request.getParameter("writer");
	System.out.println(writer);
	
	// DB에서 해당 writer의 이미지 파일명 가져오기
	UploadDAO dao = new UploadDAO();
	List imgs = dao.getImg(writer);
	System.out.println(imgs);
%>
<body>
	<h1>IMG Viewer</h1>
	<%	//이미지가 없을경우
		if(imgs == null){%>
		
			<h3>찾는 이미지가 없습니다</h3>	
	<%	}else{
		for(int i =0; i< imgs.size(); i++){
			String imgN=(String)imgs.get(i);%>
			
			<img src="/web/save/<%=imgN%>" width="350"/>
			
		<%}//for
	}//else%>
</body>
</html>