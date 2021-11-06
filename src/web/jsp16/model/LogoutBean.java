package web.jsp16.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 비즈니스로직은 로그아웃처리 해주면됨
		HttpSession session = request.getSession();
		session.invalidate();
		//쿠키삭제
		
		
		return "/WEB-INF/member_views/logout.jsp";
	}
}
