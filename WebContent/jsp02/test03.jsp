<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%-- 이 페이지의 모든영역은 html --%>

<%-- #1. 선언부 --%>
<%!

//선언부 : 클래스 영역
//클래스 - 인스턴스 변수 작성가능
// 작성 가능하나 자바따로 만들어서 외부객체생성해서 import로 하는게 좋다 

	static int num =5;
	int num2= 10;

 //메서드 
 public int multiply(int a , int b ){
	 
	 int c = a*b;
	 return c;
	 
	
 }
%>
<%-- #2.출력문 :명령끝에 세미콜론 없음--%>
 10 * 20 = <%= multiply(10,20) %> <br/>

<%= num %> , <%= num2 %><br/>

<%-- 스크립 트릿 --%>
<%
// 스크립트릿 영역 : 메서드 영역 : 가장 많이 사용할 태그로 , 로직 처리하는 부분이다
//main영역이라고 생각하면
for(int i =0 ; i < num ; i++){
	out.println("java server pager" + i + "<br/>");//자바 명령으로 브라우저 화면에 출력한것
	
}
	//지역변수
	String col = "yellow";
	
%>

<body bgcolor ="<%= col %>">


</body>








 