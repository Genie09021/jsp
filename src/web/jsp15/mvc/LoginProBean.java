package web.jsp15.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginProBean implements SuperBean {

	public String actionBean (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("loginProBean 실행 !!");
		//넘어온 id, pw꺼내기
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		MemberDAO dao = new MemberDAO();
		boolean result = dao.idPwCheck(id, pw);
		if(result) {
			HttpSession session = request.getSession();
			session.setAttribute("memId", id);
		}
		
		//result변수의 데이터를 view 전달 ->request 속성 추가
		request.setAttribute("result", result);//하면 view까지 이동한다
		
		return"/jsp15/loginPro.jsp";
	}
	
	
}
