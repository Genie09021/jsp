package web.jsp16.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFormBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//로그인시 접근하면 이상한 페이지가 된다
		HttpSession session  = request.getSession();
		if(session.getAttribute("sid") == null) {
			request.setAttribute("check", 0); //로그아웃(ok)
		}else {
			request.setAttribute("check", 1);//로그인(no ->view 에서 main으로 이동시켜버리자) 
		}
		
		return "/WEB-INF/member_views/loginForm.jsp";
	}

}
