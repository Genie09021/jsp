<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
 <%
 //JDBC와 데이터 베이스의 연동 단계
		//(클래스들 임포트 하기)
		//1.JDBC 드라이브를 로딩시키기
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//2.DB접속을 위한 Connection객체 생성
		String user = "glob27", pw="glob27";
		String url = "jdbc:oracle:thin:@nullmaster.iptime.org:1521:ORCL";
		Connection conn = DriverManager.getConnection(url, user, pw);
		//3.쿼리 실행을 위한 Statement 객체생성, 쿼리문 작성
		String sql = "select * from test";
		PreparedStatement pstmt =conn.prepareStatement(sql);
		//4.쿼리 실행
		ResultSet rs= pstmt.executeQuery();
		//5.결과값 사용
		while(rs.next()){
			String id=rs.getString("id");
			String passwd=rs.getString("pw");
			int age = rs.getInt("age");
			Timestamp reg =rs.getTimestamp("reg"); %>
		
		<p>id : <%=id %>/ pw :<%=passwd %>/ age : <%=age %> / reg : <%=reg %></p>	
		
			
	<% 	}
		
		//6.Statement, ResultSet 등 사용된 객체 종료(해제)
		rs.close();
		pstmt.close();
		//7.데이터 베이스 커넥션 종료**중요함
 		conn.close();
 
 
 
 %>

<body>

</body>
</html>