package web.jsp16.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginProBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String auto = request.getParameter("auto");

		MemberDAO dao = MemberDAO.getInstance();
		int result = dao.idPwCheck(id,pw);
		System.out.println("LP result :" +result);//확인

		
		//1 = ok,0 = pw틀림, -1 = id없다
		if(result == 1){
			//로그인 처리
			HttpSession session= request.getSession();
			session.setAttribute("sid", id);
			//쿠키처리
		}
		
		//view에서 결과에 따른 페이징 처리를 위해 result값 보내주기.
		request.setAttribute("result", result);
		
		
		return "/WEB-INF/member_views/loginPro.jsp";
	}

}
