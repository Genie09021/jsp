package web.jsp14.mvc;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class TestController extends HttpServlet{

	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//request 에 속성 추가
		request.setAttribute("num", 99);
		request.setAttribute("id", "java");
		
		
		//+null 값 보내보기
		//List list = null;
		//request.setAttribute("myList", list);
		
		
		//+문자형 숫자를 보내서 EL 에서 숫자연산 해보기
		request.setAttribute("age", "20");//숫자를 문자형태로 보내는것
		
		//session에 속성 추가
		HttpSession session = request.getSession();
		session.setAttribute("num", 777);
		
		
		
		//int형의 배열 보내보기
		int [] arr = {10, 20, 30, 40, 50};
		request.setAttribute("arr", arr);
		
		//ArrayList 보내보기
		List list = new ArrayList();//arraylist 에 데이터 추가
		list.add("java");
		list.add("jsp");
		list.add("spring");
		request.setAttribute("list", list);//속성추가
		
		
		
		//+TestVo 보내기
		TestVO vo = new TestVO();
		vo.setId("pikapika");
		vo.setAge(100);
		vo.setName("피카츄");
		request.setAttribute("vo", vo);
		
		
		//RequestDispatcher rd = request.getRequestDispatcher("/jsp14/test.jsp");
		//rd.forward(request, response);를 한줄로 줄인것
		//view로 이동
		request.getRequestDispatcher("/jsp14/test.jsp").forward(request, response);
		
		
		
	}
}
