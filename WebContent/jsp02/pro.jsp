<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
  <%@
  page import = "java.util.Enumeration"
   %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<% 
	String col = "green";



	//넘어온 요청 파라미터 뽑아서 변수에 담아놓기
	String id = request.getParameter("idid");
	String pw = request.getParameter("pwpw");
	//String pet = request.getParameter("pet");
	String[] pet = request.getParameterValues("pet");
	
%>


<body bgcolor ="<%= col %>">


<table border ="1">

	<tr>
		<td>id</td>
		<td><%= id %></td>
	</tr>
	<tr>
		<td>pw</td>
		<td><%= pw %></td>
	</tr>
	<tr>
		<td>pet</td>
		<td>
			<input type="checkbox" name ="pet" value ="dog" 
				<% if(pet != null){for(String p :pet){if(p.equals("dog")){%> checked <% }}} %>
			 /> 강아지
			<input type="checkbox" name ="pet" value ="cat" 
				<% if(pet != null){for(String p :pet){if(p.equals("cat")){%> checked <% }}}%>
			/> 고양이
			<input type="checkbox" name ="pet" value ="tiger" 
				<% if(pet != null){for(String p :pet){if(p.equals("tiger")){%> checked <% }}}%>
			/> 호랑이
		</td>
	</tr>

	<!-- 넘어온 파라미터중에 강아지 고양이 호랑이가 각각 들어왔다면 체크박스 표시 
		checked 라는 속성을 주어 체크된 상태로 페이지가 뜨게 만들기
		
		if(pet != null){//체크박스 체크했는지안했는지 체크
			for(int i=0;i<pet.length;i++){
				if(pet[i].equals("dog"){
				checked
				}
			}
		}
		
		
		-->


</table>


<h1>pro page</h1>
	id= <%= id +1  %>
	pw= <%= pw %>
	 pet =<%= pet %><br/>
	pet =
	
	
	<%
		//#1.배열을 출력
 if(pet !=null){
	 for(int i =0; i<pet.length;i++){%>
		<%=  pet[i] %> ,
		
		<h4><%=pet[i] %></h4>
		
		 
	<%  }//for문
 }//if문
	
	
	//파라미터 이름 목록 출력
	Enumeration paramNames = request.getParameterNames();
	while(paramNames.hasMoreElements()){
		String name = (String)paramNames.nextElement();
		out.println(name + " ");
		
	}
	
	%>
	
	
	--%>
	
</body>
</html>