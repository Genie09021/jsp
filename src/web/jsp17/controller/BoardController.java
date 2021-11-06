package web.jsp17.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.jsp17.model.SuperBean;

public class BoardController extends HttpServlet{

	private Map map = new HashMap();
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		String path = config.getInitParameter("prop");
		Properties p = null;
		InputStream is = null;
		
		try {
			is = new FileInputStream(path);
			p= new Properties();
			p.load(is);;
			
			Iterator it = p.keySet().iterator();
		while(it.hasNext()) {
			String key = (String)it.next();
			String value = p.getProperty(key);
			Class c = Class.forName(value);
			Object obj =c.newInstance();
			map.put(key, obj);
			
		}
			System.out.println(map);
			System.out.println("mapsize : " + map.size());//확인용 8개 잘나오는지 출력
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uri = request.getRequestURI();
		System.out.println("uri : "+uri);
		
		Object obj = map.get(uri);
		SuperBean sb = null;
		String view = "/WEB-INF/board_views/list.jsp";
		if(obj instanceof SuperBean) {
			sb = (SuperBean)obj;
			view = sb.actionBean(request, response);
		}
				request.getRequestDispatcher(view).forward(request, response);
		
	}
	
	
}
