<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%--입력된값 쿼리에 추가시키는것 --%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String passwd = request.getParameter("pw");
	int age = Integer.parseInt(request.getParameter("age"));
	//<jsp:>


	//DB에 저장 시키기
		//1.JDBC 드라이브를 로딩시키기
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//2.DB접속을 위한 Connection객체 생성
		String user = "glob27", pw="glob27";
		String url = "jdbc:oracle:thin:@nullmaster.iptime.org:1521:ORCL";
		Connection conn = DriverManager.getConnection(url,user,pw);
		//3.쿼리 실행을 위한 Statement 객체생성, 쿼리문 작성
		// 데이터가 삽입되어야 하는 부분에 변수를 사용하면 보안에 취약
		//placeholder인 ? 문자로 개수만큼 대치를 하고 
		//PreparedStatement 객체로 해당 placeholder 부분에 들어가야할 데이터를 추가 시켜 준다.
		String sql ="insert into test values(?,?,?,sysdate)";
		
		
		//172sd
		System.out.println(sql);
		PreparedStatement pstmt= conn.prepareStatement(sql);
		pstmt.setString(1, id);//순서는 ? 앞에서부터1,타입에 맞는 set메서드
		pstmt.setString(2, passwd);
		pstmt.setInt(3, age);
		
		
		
		//4.쿼리 실행
		int result = pstmt.executeUpdate();
		
		//5.결과값 사용
		System.out.println(result);
		//6.Statement, ResultSet 등 사용된 객체 종료(해제)
		pstmt.close();
		//7.데이터 베이스 커넥션 종료**중요함
		conn.close();
	
		//무결성 제약조건에 위배 ...오류 (primary key :중복되면 x . 기존의 id컬럼에 같은 값이 이미 존재하면 실패 )
		//id컬럼 : primary key -> form 페이지 id 란에 중복안되는 값, 생략 X 
		//pw 컬럼 : not null-> form 페이지에 값 반드시 기입하고 테스트 하기
		//
		
		
%>

<body>

		<h2> <%=id %> 님 가입 되었습니다 . </h2>

</body>
</html>