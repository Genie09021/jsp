package web.jsp14.mvc;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//Controller  : 모든 요청이 등어올 컨트롤러
public class MainController extends HttpServlet{

	
		@Override
		protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("main controller !!");
			//모든 요청이 이곳으로 들어오니 uri 분석하여 요청에 따라 올바른 처리를 하고 , 요청에 맞는 jsp 페이지로 forward시켜야 한다
			
			//1. uri분석 : uri 꺼내기 
			String uri =request.getRequestURI(); //wb /~~.git
			System.out.println("uri : "+ uri);
			
			//각 uri 요청에 따른 처리
			String view = "";//넘어갈 jsp 페이지 담을 변수 미리 선언
			if(uri.equals("/web/login.git")) {//요청경로가 이와같으면 로그인폼으로이동 : 문자열로 uri 지정해 놓은것과 같은 효과
				//로그인 해당하는 비즈니스 로직 처리 :할게 없음
				
				//로그인 폼 보여주기
				view ="/jsp13/loginForm.jsp";
			}else if(uri.equals("/web/loginPro.git")) {
				//로그인 프로에대한 비즈니스 로직 처리 : id pw 체크하고 맞으면 session속성 추가
				String id = request.getParameter("id");
				String pw = request.getParameter("pw");
				
				//db접근해서 id,pw check하고 결과받아 처리
				int result = 1;//dao.idPwcheck
				if(result == 1) {
					//세션생성...
					HttpSession session = request.getSession();
					session.setAttribute("memId", id);//세션속성추가 : 로그인 처리
				}
				request.setAttribute("result", result);//view 에 전달할 데이터는 request 속성에 추가
				//로그인 pro 페이지로 이동
				view ="/jsp13/loginPro.jsp";
			}
			
			//3.요청에 맞는 jsp페이지로 이동
			RequestDispatcher rd = request.getRequestDispatcher(view);
			rd.forward(request, response);
		}
		
		
		
}
