package web.jsp17.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ContentBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum"); // list에서 보고있던 페이지번호 던져준것, 뽑아놓기
		
		// 글 고유번호주고 해당 글에 대한 내용 DB에서 가져오기 
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO article = dao.getArticle(num); 
		System.out.println(article.getRef());
		System.out.println(article.getRe_step());
		System.out.println(article.getRe_level());
		
		request.setAttribute("num", num);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("article", article);
		
		
		
		
		return "/WEB-INF/board_views/content.jsp";
	}
}
