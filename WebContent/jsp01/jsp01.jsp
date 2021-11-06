<%@ page language="java" contentType="text/html; charset=UTF-8"
  
    

    
   
    %>
  
  <%-- jsp주석
  language 속성 = 언어설정 jsp는 자바밖에 못씀, 
  contentType=text/html 해당문서의 컨텐츠를 표시, html로만들어진 text 문서이다~,
   charset, pageEncoding = 인코딩설정, charset=설정이면 pageEncoding 생략가능
   contentType : text/xml, applicatioin/json : MIME  Type 형태 라고 한다
   import 속성 = 자바와 같다 util 제외하고는 import 필요
   session = 이페이지에서 세션 사용여부 , 기본값 true ,로그인 유지시 세션유지가 필요하다.
   buffer 출력버퍼의 크기 설정 기본값 8kb, 출력해야할것들을 버퍼에 담아뒀다 출력하는 임시저장소 
   autoFlush 출력버퍼의 동작을 제어 하는 속성 기본 .true 가 기본값.버퍼에 쌓여있는데이터를 전송 출력 하고 자동으로 비우는것
   isThreadSafe 이페이지의 멀티 스레드를 허용 할것인지 ,true 여러 사용자를 동시에 요청받기, false는 요청 순서대로 .
   errorPage 에러가 났을때 따옴표안으로 이동할 페이지 경로를 작성.에러 페이지 셋팅
   isErrorPage 지금 페이지가 에러인지 판단 true 로하면 exception.객체 바로 쓸수있다
   기본값 false 이다
   defferSyntaxAllowedAsLiteral 웹의 공용언어 : ${내용} #{내용} 기본값 false 
   서블릿버전에따라 사용불가 할 수있다
   서블릿 2.3 > EL 지원한함
   서블릿 2.4 >${내용} 지원 #{내용} 지원안함
   서블릿 2.5> 둘다지원
   --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>




	서버 : <%= application.getServerInfo() %><br/>
	서블릿 : <%= application.getMajorVersion() %> . <%=application.getMinorVersion() %><br/>
	jsp : <%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %><br/>



	




</body>
</html>