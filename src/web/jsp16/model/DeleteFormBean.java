package web.jsp16.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteFormBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		
		
		
		
		
		return "/WEB-INF/member_views/deleteForm.jsp";
	}

}
