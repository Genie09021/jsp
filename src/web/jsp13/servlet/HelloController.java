package web.jsp13.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//Controller (servlet) 
public class HelloController extends HttpServlet{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//uri분석
		System.out.println("Hello!! Controller run!!");
		//비즈니스 로직처리(dto,dao,bean())
		
		//request의 속성 (attribute)을 이용하여 데이터 저장해서 포워딩 하기 ->hellp.jsp에서 request에서 값 꺼낼 수 있다
		request.setAttribute("id", "java");
		request.setAttribute("num", 1111);
		
		//+이번엔 session 의 속성을 이용하여 데이터 저장해 보자
		HttpSession session = request.getSession();//request 에서 세션 꺼내기
		session.setAttribute("memId", "pikachu");
		
		//view페이지로 이동시켜줬다
		RequestDispatcher rd = request.getRequestDispatcher("/jsp13/hello.jsp");//응답으로 보여줄 jsp지정해 주기
		rd.forward(request, response);//request와 response객체 전달
		
	}
	
	
}
