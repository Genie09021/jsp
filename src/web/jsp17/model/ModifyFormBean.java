package web.jsp17.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ModifyFormBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// 컨텐트페이지에서 넘겨준 pageNum 꺼내 놓기 
		String pageNum = request.getParameter("pageNum");

		// 넘어온 글 고유 번호 꺼내서 
		int num = Integer.parseInt(request.getParameter("num"));
		// DB에서 해당 글 가져와 화면에 뿌려주기 
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO article = dao.getUpdateArticle(num);
		
		//여기서 만들어진 3개 보내기 
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("num", num);
		request.setAttribute("article", article);
		
		return "/WEB-INF/board_views/modifyForm.jsp";
	}
}
