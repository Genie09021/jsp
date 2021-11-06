package web.jsp15.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainBean implements SuperBean{

	//public String actionBean()
	
	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("main요청 ");
		return "/jsp15/main.jsp";
	}
	
	
	
}
