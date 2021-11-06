package web.jsp13.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//컨트롤러 : servlet 
public class LoginProController extends HttpServlet {
		
		@Override
		protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("login Pro Page 요청 !!");
			
			
			//비즈니스 로직 : id , pw 꺼내서 DAO 에게 체크해 결과 알려달라!!
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			//MemberDAo dao = MemberDAO.getInstance();
			//boolean result = dao.idPwCheck(id,pw);
			
			int result = 1;
			if(result == 1) {
				HttpSession session = request.getSession();
				session.setAttribute("memId", id);//로그인 처리
			
			}
			
			request.setAttribute("result", result);// id pw 확인결과 view에 전달해 주기 위해 request의 속성에 결과값 추가
			
			//해당 view로 이동
			RequestDispatcher rd = request.getRequestDispatcher("/jsp13/loginPro.jsp");
			rd.forward(request, response);
			
			
			
		}
	
	
}
