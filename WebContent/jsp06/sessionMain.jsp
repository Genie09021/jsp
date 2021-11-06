<%@page import="java.util.Enumeration"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
//main으로 이동하면 (새로실행하면) 위에서부터 다시 실행됨




	//#1.
	//로그인 됬었는지아닌지
	///세션이 있는지 없는지 꺼내보기
		String sid = (String)session.getAttribute("sid");
		System.out.println("sid : " +sid);
	
	//세션 내부객체를 사용못하는 환경에서는 request 에서 getSession() 메서드를 활용하여
	//세션을 꺼낼 수도 있다
		HttpSession mySession = request.getSession();
	


	//추가)날짜관련 객체 
	Date time = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");//날짜관련 출력 형태(패턴) 지정

%>
<body>
	<h2> Main Page</h2>
	<h3> 세션 기능 사용해 보기</h3>
	세션 id : <%= session.getId() %>
	
	<% 
	time.setTime(session.getCreationTime()); 
	%>
	
	세션 생성시간 : <%= sdf.format(time)%>
	
	<%--밀리세컨드로 출력됨 date객체로 만들어주고 위에지정해준형태나오도록 --%>
	
	
	
	
	<%
	time.setTime(session.getLastAccessedTime());
	%>
	최근 접근 시간 : <%=sdf.format(time) %>
	
	
	
	
	[세션 리스트 ] <br/>
	<%
	 Enumeration enu = session.getAttributeNames();
		while (enu.hasMoreElements()){
			String name = enu.nextElement().toString();
			String value = session.getAttribute(name).toString();
			out.println(name + "=" + value + "<br/>");
	
	}
	
	%>
	
	
	
	
	
	
	
	<%//#2.
	
	if(sid == null){
		//로그인안됨(비로그인 상태)%>
		
		<h2>로그인하시려면 아래 버튼 클릭</h2>
		<button onclick ="window.location.href ='sessionForm.jsp'"> 로그인 </button>
		
	<% }else{//로그인 상태 %>
		
		<h4> <%= sid %> 님, 환영합니다</h4>
		<button onclick ="window.location.href ='sessionLogout.jsp'"> 로그아웃 </button>
		
		
	<% }
	
	%>
	
	
	
	
	
<%--브라우저껏다 다시 켜면  세션 종료 다시로그인 --%>

</body>
</html>