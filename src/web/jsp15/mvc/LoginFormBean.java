package web.jsp15.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Bean클래스 : loginForm 용 .비즈니스 로직처리 할것
public class LoginFormBean implements SuperBean {

	//String id = request.getParameter("id")
	//String id = request.getParameter("id")
	//DAO.da
	///session.setAtt
	
	//리턴타입 String :이동할 jsl view 경로 리턴해 줄 것임
	//매개변수의 throws 는 Controller 의 서비스 메서드와 동일하게 -> 정상적인 비즈니스 로직 처리를 하려면request,response정보가 필요한데
	//일반 클래스에서는 서블릿이 아니기 때문에 자동으로 채워주지 못하기 때문에 Controller 에서 전달받을 것임
	public String actionBean(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("loginFormBean 실행 !! ");
		
		
		return "/jsp15/loginForm.jsp";//이동할 jsp 페이지의 경로 리턴
	}
	
	
}
