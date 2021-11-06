package web.jsp13.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/HelloServlet")//어노테이션으로 브라우저에서 요청하는 주소를 매핑 해 놓은것 : 매핑 해 놓은 /HelloServlet 이라고 브라우저에서 요청하면,doGet() 실행된다
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    //   static int y = 100;
   
    public HelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	//GET요청이 들어오면 실행할 메서드 : 개발자는 get요청이 들어오면 처리할 내용을 메서드 안에 작성해 두기
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("get 요청함!!");
		String id = request.getParameter("id");
		response.getWriter().append("Served at:Helloooo ").append(request.getContextPath());
	}
	//POST 요청이 들어오면 실행될 메서드 : 개발자는 post 요청이 들어오면 처리할 내용을 메서드 안에 작성해 두기
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
							//request, response 내부객체와 동일하게 사용되는 매개변수
		System.out.println("Service메서드 호출!!");
		
	//	int x = 10;
	//	System.out.println(x);
	//	System.out.println(HelloServlet.y);
		
		//웹브라우저로 전송되어화면서 출력할 태그들을 메서드 이용하여 문자열로 토스
		
		PrintWriter pw = response.getWriter();
		pw.println("<html>");
		pw.println("<head>");
		pw.println("</head>");
		pw.println("<body>");
		pw.println("<h2> Hello Servlet</h2>");
		pw.println("</body>");
		pw.println("</html>");
		
		
	}
	

}
