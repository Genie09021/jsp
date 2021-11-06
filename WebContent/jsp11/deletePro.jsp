<%@page import="java.io.File"%>
<%@page import="web.jsp11.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePro</title>
</head>
<%
	//id , pw 얻어오기
	String id=(String)session.getAttribute("sid");
	String pw = request.getParameter("pw");
	
	MemberDAO dao = MemberDAO.getInstance();
	//먼저 저장된 photo이름도 가져오겠다.->실제 이미지 파일을 서버에서 삭제 시키기위해 미리 이름 받아오기
	String photo =dao.getPhoto(id);//그사람의 사진 이름 가져옴 (mypage에서 만듬)
	String path = request.getRealPath("save");//실제 파일 저장되는 save폴더의 경로 찾고 
	System.out.println(path);//확인용 .경로
	path +="\\" + photo;//거기에 \파일명 .확장자 까지 연결해서 실제 파일 경로 준비
	System.out.println(path);//확인용 .경로
	
	
	
	//삭제
	int check = dao.deleteMember(id,pw);
	
	if(check == 1){
		//+이미지 파일도 삭제 해주어야함
		File f = new File(path);
		f.delete();
	
		//로그아웃처리
		session.invalidate();
		//main으로 이동시키기
		response.sendRedirect("main.jsp");
	}else{%>
		<script>
			alert("비밀번호가 맞지 않습니다..");
			history.go(-1);
		</script>
	<%}
	
%>
<body>

</body>
</html>