<%@page import="web.jsp12.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>login pro</title>
</head>
<%
		request.setCharacterEncoding("utf-8");

		//1.넘어온 파라미터 담기 :loginForm 타고 왔을떄 처리(main에서 바로 날라왔으면 아래 변수는 null상태로 끝남)
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String auto = request.getParameter("auto"); //자동 로그인 체크 박스 값 꺼내기
		
		//+쿠키 체크 : loginForm 을 안타고, main에서 바로 날라왔을떄는
		//위파라미터에서 값을 꺼내도 없기 때문에 다시 쿠키에서 id,pw, auto 를 꺼내서 채워주기
		Cookie[] coos = request.getCookies();
		if(coos != null){
			for(Cookie c : coos){
				if(c.getName().equals("autoId")) id = c.getValue();
				if(c.getName().equals("autoPw")) pw = c.getValue();
				if(c.getName().equals("autoCh")) auto = c.getValue();
			}
		}
		
		
		//2.
		System.out.println("id " + id);
		System.out.println("pw " + pw);
		System.out.println("auto " + auto);//auto 체크유무 어떻게 전달되는지 판단 체크 1
		
		//3.
		//로그인 체크
		//쿠키에서왓을경우 쿠키에서 얻은게 잘얻었는지 체크
		MemberDAO dao = MemberDAO.getInstance();
		boolean res = dao.idPwCheck(id,pw);
		
		//4.t/f로dao에서 리턴
		if(res){//id pw맞으면 ->로그인 처리
			if(auto != null){//자동 로그인 체크하고 로그인 시도했다
				//쿠키생성
				Cookie c1 = new Cookie("autoId" , id);
				Cookie c2 = new Cookie("autoPw" , pw);
				Cookie c3 = new Cookie("autoCh" , auto);
				c1.setMaxAge(60*60*24);//24시간 //쿠키 기간 갱신되는 구간
				c2.setMaxAge(60*60*24);//24시간
				c3.setMaxAge(60*60*24);//24시간
				response.addCookie(c1);
				response.addCookie(c2);
				response.addCookie(c3);
			}
		//세션은 if문과상관없이 만들어짐
			session.setAttribute("memId", id);//세션에 속성 추가!! == 로그인 처리한 것
			response.sendRedirect("main.jsp");//main으로 이동하도록 !
		}else{%>
			
			<script>
				alert("id 또는 pw 가 일치하지 않습니다. 다시 시도해 주세요");
				history.go(-1);
			</script>
		
	<%  }
		
%>
<body>

</body>
</html>