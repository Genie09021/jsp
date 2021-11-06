package web.jsp17.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ModifyProBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");
		 
		 
		 BoardDTO article= new BoardDTO();
		 //수정용 num writer subject email content pw
		 //페이징 처리용 pageNum
		 article.setNum(Integer.parseInt(request.getParameter("num")));
		 article.setWriter(request.getParameter("writer"));
		 article.setSubject(request.getParameter("subject"));
		 article.setEmail(request.getParameter("email"));
		 article.setContent(request.getParameter("content"));
		 article.setPw(request.getParameter("pw"));
		 
		 
			// 페이지넘도 뽑아놓기 
			String pageNum = request.getParameter("pageNum");

			// 넘어오는 데이터 num, writer, subject, email, content, pw 
			//DB에 article 던져주며 업데이트 시키기 
			BoardDAO dao = BoardDAO.getInstance(); 
			int result = dao.updateArticle(article); 
	
			request.setAttribute("result", result);
			request.setAttribute("pageNum", pageNum);
			
		
		
		
		
		
		// TODO Auto-generated method stub
		return "/WEB-INF/board_views/modifyPro.jsp";
	}
}
