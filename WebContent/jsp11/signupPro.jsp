<%@page import="web.jsp11.model.MemberDAO"%>
<%@page import="web.jsp11.model.MemberDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
	//enctype="multipart/form-data"로넘어온 것은
	//useBean으로 객체생성은 되지만 setProperty 는 안된다
%>
	<jsp:useBean id="member" class="web.jsp11.model.MemberDTO"></jsp:useBean>
<%
	//Multipart Request 객체 사용
	String path = request.getRealPath("save");
	System.out.println(path);
	int max = 1024*1024*5;
	String enc = "utf-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	
	
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	
	
	//넘어온 데이터를 꺼내서 DB에 저장하기
	member.setId(mr.getParameter("id"));
	member.setPw(mr.getParameter("pw"));
	member.setName(mr.getParameter("name"));
	member.setBirth(mr.getParameter("birth"));
	member.setEmail(mr.getParameter("email"));
	member.setPhoto(mr.getFilesystemName("photo"));//이미지 파일 업로드된  이름으로 저장
	
	MemberDAO dao = MemberDAO.getInstance();
	dao.insertMember(member);
	
	response.sendRedirect("main.jsp");
			
%>


<body>

</body>
</html>