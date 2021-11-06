package web.jsp16.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.jsp16.model.SuperBean;


public class MemberController extends HttpServlet {
	
	private Map beansMap = new HashMap();
	
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		
		System.out.println("init!!");//확인용 출력
		String path = config.getInitParameter("prop");
		Properties p = null;
		InputStream is = null;
		
		try {
			is = new FileInputStream(path);
			p = new Properties();
			p.load(is);
			
			Iterator it = p.keySet().iterator();
			while(it.hasNext()) {
				String key = (String)it.next();
				String value = p.getProperty(key);
				Class c = Class.forName(value);
				Object obj = c.newInstance();
				beansMap.put(key, obj);
				
			}
		//	System.out.println(beansMap);
		//	System.out.println(beansMap.size());//11개 나와야함 member properties에 11개 적어줬음으로
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("service !!");
		String uri = request.getRequestURI();
		System.out.println("uri : "+uri);
		
		Object obj = beansMap.get(uri);
		SuperBean sb = null;
		String view = "/WEB-INF/member_view/main.jsp";//초기값 넣어놓기
		if(obj instanceof SuperBean) {
			sb = (SuperBean)obj;
			view = sb.actionBean(request, response);
		}
		
		//view로 이동
		request.getRequestDispatcher(view).forward(request, response);
		
		
	}
}
