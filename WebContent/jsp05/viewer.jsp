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
	//search.jsp  에서 입력한 넘어온 id 뽑아서 변수에 담기
	String search = request.getParameter("id");

	//db에 연결하여 존재하고 있는 id중 하나를 선택하여 해당 id 의 전체정보를 출력해 보자
	//jdbc드라이버 로딩
	Class.forName("oracle.jdbc.driver.OracleDriver");
	//connection 객체
	String user ="glob27", pw="glob27";
	String url = "jdbc:oracle:thin:@nullmaster.iptime.org:1521:ORCL";
	Connection conn = DriverManager.getConnection(url,user,pw);
	
	
	
	//쿼리문 작성, PreparedStatement 객체 가져오기
	String sql = "select * from test where id= ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,search);//넘어온 데이터 쿼리문에 적용
	
	
	
	
	//쿼리실행
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){//결과가 존재하면 뽑아서 뿌려주고 
		String id = rs.getString("id");
		String passwd = rs.getString("pw");
		int age = rs.getInt("age");
		Timestamp reg = rs.getTimestamp("reg"); %>
		
		<h3>id=<%=id %></h3>
		<h3>pw=<%=passwd %></h3>
		<h3>age=<%=age %></h3>
		<h3>red=<%=reg %></h3>
		
<% 	}else{ //결과가 존재하지 않으면 -%> 
	
		<h3> <%= search %> 은(는) 존재하지않는 id 입니다 </h3>
	
<% }
	
	rs.close();
	pstmt.close();
	conn.close();
	
	%>




<body>

</body>
</html>