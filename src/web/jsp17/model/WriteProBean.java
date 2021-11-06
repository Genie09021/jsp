package web.jsp17.model;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WriteProBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		
		
		request.setCharacterEncoding("UTF-8");
	
		BoardDTO article = new BoardDTO();
		
		article.setNum(Integer.parseInt(request.getParameter("num")));
		article.setRef(Integer.parseInt(request.getParameter("ref")));
		article.setRe_step(Integer.parseInt(request.getParameter("re_step")));
		article.setRe_level(Integer.parseInt(request.getParameter("re_level")));
		article.setSubject(request.getParameter("subject"));
		article.setEmail(request.getParameter("email"));
		article.setContent(request.getParameter("content"));
		article.setPw(request.getParameter("pw"));
		article.setReg(new Timestamp(System.currentTimeMillis()));
		article.setReadcount(0);
		
		
		
		// 작성자는 id로 체우기 
		//article.setWriter((String)session.getAttribute("sid"));
		article.setWriter("java");//회원가입 연결 안되어있으니 writeForm에서 저장한 가상아이디와동일하게 처리
		
		// DB에 article 객체 주면서 저장시키기 
		BoardDAO dao = BoardDAO.getInstance();
		dao.insertArticle(article); 
		
	
		
		
		
		
		
		
		
		return "/WEB-INF/board_views/writePro.jsp";
	}
}
