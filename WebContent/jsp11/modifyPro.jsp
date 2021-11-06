<%@page import="web.jsp11.model.MemberDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.jsp11.model.MemberDTO"%>
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

	MemberDTO member = new MemberDTO();//넘어오는 데이터 dto에 담아서db로 보내기 위해 dto 객체 생성

	//Multipart request .로 꺼내기
	String path = request.getRealPath("save");
	int max = 1024*1024*5;
	String enc = "utf-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	//modifyForm 에서 id는 안넘어옴으로 세션에서 꺼내서 dto에 추가해 주자
	String id = (String)session.getAttribute("sid");
	member.setId(id);
	member.setPw(mr.getParameter("pw"));
	member.setBirth(mr.getParameter("birth"));
	member.setEmail(mr.getParameter("email"));
	
	if(mr.getFilesystemName("photo") != null){//photo input태그에 뭔가 담겨서 넘어왔다면 (사진수정했다면) 
		System.out.println(mr.getFilesystemName("photo"));//확인용
		member.setPhoto(mr.getFilesystemName("photo"));//새로 넘어온파일의 이름을 dto에 넣고
		//+기존에 올린 파일이 있다면 파일 삭제하기
		
		
	}else{//photo input 태그로 사진 지정안하고 그냥 넘어왔으면
		System.out.println(mr.getFilesystemName("exPhoto"));//확인용
		
		//수정할때 DB상에 값이 없으면, form 에 null값이 전달되서 -> "null" 문자열로
		if(mr.getParameter("exPhoto").equals("null") || mr.getParameter("exPhoto").equals("")){
			member.setPhoto(null);//문자열 "null"이아니라 실제 null을 넣어주는것
		}else{
			member.setPhoto(mr.getParameter("exPhoto"));//기존에 db에 저장되어있던 이름으로 다시 dto에 넣어준다
	
		}	//http://localhost:8080/web/save/null
	}
	
	
	
	/*ㄴ코드 지저분함
		dafault 이미지 파일 미리 만들고 
		db테이블 생성시 photo varchar2(50) default 'default.확장자'
		로 하는것이 더 나을수 있따.
		사진이없으면 deafult.png 로 이름이 저장이 될 것임으로
	*/
	
	
	
	//DB에 접근해서 pw가 일치하는지 확인하고 , 나머지 내역들 수정하도록 처리할것
	MemberDAO dao = MemberDAO.getInstance();
	int result =dao.updateMember(member);
	
	if(result == 1){
		System.out.println("수정 정상처리!!");
		response.sendRedirect("main.jsp");
	}else{%>
	
	<script>
		alert("비밀번호를 다시 확인하고 수정해 보세요");
		history.go(-1);
	</script>
		
		
<%	}
%>
<body>

</body>
</html>