package web.jsp13.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//1.클래스 생성 +httpServlet상속
public class LoginController extends HttpServlet{
	//2.service메서드 오버라이딩
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("login form page요청 !!");
		
		//view로 이동 : from 페이지 보이도록 view 페이디 포워딩
		RequestDispatcher rd = request.getRequestDispatcher("/jsp13/loginForm.jsp");
		rd.forward(request, response);
		
	}
	
}
