package web.jsp15.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SuperBean {

	//인터페이스안에 만들 수 있는것 -변수x상수o 일반메서드 x추상메서드o
	
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException;
		
	
	
	
	
	
}
