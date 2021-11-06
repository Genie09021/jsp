<%@page import="web.jsp10.model.UploadDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>파일 업로드 처리해주는 페이지 =pro페이지</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	/*#.(파일을 저장할떄 필요한)
		넘어온 데이터는 MultipartRequest 객체를 이용해 꺼낸다
		MultipartRequest 객체 생성시 , 필요한 인자들
		1.request 내부객체 필요
		2.업로드될 파일 저장 경로 (서버에안하고 개인pc(=로컬)에 할것)
		3.업로드 할 파일 최대 크기
		4.인코딩 타입 UTF-8 지정
		5.업로드된 파일 이름이 같을 경우, 덮어씌우기 방지 해줄수 있는객체 던져주기
	*/
	//로컬(pc)에저장 - 웹상에서 해당 이미지 서비스 불가능 ->"서버에 저장할것 ": 
		//String path = "c:\\test\\";//파일 저장 위치(\\두개써서 경로지정.뒤에슬레쉬\\꼭있어야한다.그폴더안에 넣을거니까)
		
		
		//서버에 파일 저장
		String path = request.getRealPath("save");//웹안에 save폴더임으로 save만 작성 .save안의 폴더이면 save/test
		System.out.println(path);
		
		int max = 1024*1024*5;//5MB
		String enc ="UTF-8";//인코딩
		//덮어씌우기 방지 객체
		//중복이름으로 파일 저장시 파일 이름뒤에 1,2,3,....자동으로 붙혀줌
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
		//MultipartRequest 객체 생성
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);//만든순서대로 객체 넣어줘야함
		//multipart객체 생성시 파일 자동으로 저장된다 
		
		//파일 저장은 mr객체 생성시 자동으로 일단 파일을 저장 시킨다. 우리가 직접 해줄것이 없다.
		//단점은 자동저장임으로 악성코드나 보안에 좋지않을수도있다.이미지만 업로드되지않고 text문서등 도 모두 업로드 될 수있다->.이미지가 아니면 삭제시키는것 필요.
		//cotentType 뽑아보면 알수있음
		
		//넘어온 파라미터 mr로 꺼내기
		String writer=mr.getParameter("writer");//일반 파라미터 꺼내기
		
		//mr로 파일정보 꺼내기
		String sysName =mr.getFilesystemName("upload");//업로드 파일이름(file업로드  이름을 upload라고 지정해주었음으로)
		String orgName= mr.getOriginalFileName("upload");//파일 원본 이름
		String contentType = mr.getContentType("upload");//파일 종류 (사진인지 글인지)
		
		
		//사진만 파일 올릴 수 있게 하기 :컨텐트 타입으로 확인후 image가 아닌 파일은 파일삭제를 먼저 처리해주어야함
		//"image/jpeg"
		String[] type = contentType.split("/");// '/'기준으로 분할하여 String배열로 리턴
		System.out.println(type);
		if(!(type != null && type[0].equals("image"))){//image파일이 아닐때 이어야하니까
			 
			File f = mr.getFile("upload");//해당 업로드된 파일을 File객체로 가져오기
			f.delete();		//파일삭제
			System.out.println("파일 삭제됨");
		}
		
		//db저장 ->이미지 파일명
		UploadDAO dao = new UploadDAO();
		dao.uploadImg(writer,sysName);
		/*이렇게 써도 됨 UploadDTO dto = new UploadTO();
		dto.setWriter(writer);
		dto.setImg(sysName);
		dto.uploadImg(dto)*/
		//db꺼내와서 보여줄때 ->파일명
		
		
%>
</body>

	<h2>작성자 --> <%=writer %></h2>
	<h2>업로드 파일명--> <%=sysName %></h2>
	<h2>원본 파일명 --> <%=orgName %></h2>
	<h2>파일 종류 --> <%=contentType %></h2>
	
	<%--<img src="c://test//<%=sysName%>"/>로컬주소로는 서비스가안되서 이미지가 안나옴 --%>
	<img src="/web/save/<%=sysName%>"/><%--서버에 저장되어있기때문에 이미지 파일이 브라우저에 보임 --%>
	<%--src="/프로젝트명/폴더명.../파일명 (오리지날 파일명x시스템상 저장파일명으로해야함)" --%>

</html>