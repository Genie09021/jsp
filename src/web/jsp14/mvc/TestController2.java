package web.jsp14.mvc;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TestController2 extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("jstl02요청 !!");
		request.setAttribute("day", new Date());
		//jstl02페이지로 이동
		request.getRequestDispatcher("/jsp14/jstl02.jsp").forward(request, response);
		
		
		
	}
	
	
}
