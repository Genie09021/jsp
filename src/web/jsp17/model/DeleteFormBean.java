package web.jsp17.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteFormBean implements SuperBean{

	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		//view 에전달
		request.setAttribute("num", num);
		request.setAttribute("pageNum", pageNum);
		
		return "/WEB-INF/board_views/deleteForm.jsp";
	}
}
