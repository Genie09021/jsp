package web.jsp17.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteProBean implements SuperBean{

	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// num, pw
		int num = Integer.parseInt(request.getParameter("num"));
		String pw = request.getParameter("pw");

		String pageNum = request.getParameter("pageNum");
		

		// DB상 비번과 일치하면 해당 글 삭제 처리 
		BoardDAO dao = BoardDAO.getInstance();
		int result = dao.deleteArticle(num, pw); 
		
		
		request.setAttribute("num", num);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("result", result);
		
		return "/WEB-INF/board_views/deletePro.jsp";
	}
}
