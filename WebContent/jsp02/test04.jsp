<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.util.Date" %>
    <!-- 설정테그 여러개 가능 -->
    <%
    //자바코드작성은 스크립트에
   /* for(int i =0; i<10; i++){
    	if(i % 2 == 0) {
    		out.println( i + "<br/>");
    		System.out.println(i);
    	}
    }
    */
    int count =0;
    Date day = new Date();
    
    int a =10;
    int b =10;
    int c =10;
    %>
    
    출력문안에서 단순연산, 객체생성도 된다
    메소드 호출도 가능
    
    count : <%=++count %> <br/>
    date : <%= new java.util.Date() %> <br/>
    date : <%= day %><br/>
    total <%= a+b+c %><br/>
    
    스크립트릿 -자바주석가능
   
    
    
    
    
    
    
    
    
    
    
    
    