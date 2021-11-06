<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
		//1.JDBC 드라이브를 로딩시키기
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//2.DB접속을 위한 Connection객체 생성
		//String user = "glob27", pw="glob27";
		//String url = "jdbc:oracle:thin:@nullmaster.iptime.org:1521:ORCL";
		//Connection conn = DriverManager.getConnection(url, user, pw);

		//1.커넥션
		//context .xml 에 세팅해 놓은 정보들을 꺼내려면 InitialContext() 로 객체가하나필요함.
		//커넥션 풀에서 가져옴
		//Context 는 InitialContext() 의 부모격.
		Context ctx = new InitialContext();
		Context env =(Context)ctx.lookup("java:comp/env");
		DataSource ds =(DataSource)env.lookup("jdbc/orcl");
		Connection conn = ds.getConnection();
		
		//2.SQL쿼리문 작성, pstmt 객체 얻어오기
		String sql="select * from test";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		//3.쿼리문 실행
		ResultSet rs=pstmt.executeQuery();
		while(rs.next()){
			String id =rs.getString("id");
			String pw = rs.getString("pw");
			int age = rs.getInt("age");
			Timestamp reg = rs.getTimestamp("reg");
		%>
		<h4> id =<%= id %> / pw = <%=pw%> / age =<%=age %> /reg = <%=reg %></h4>	
		
		<% 
		
	}
	//4.닫기
	
	rs.close();
	pstmt.close();
	conn.close();

%>

<body>




</body>
</html>