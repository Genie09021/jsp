package web.jsp17.mb;

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

public class MemberBoardController extends HttpServlet{

		//uri와 해당  uri 에 해당하는 Bean객체들을 정리해서 저장해 놓은 저장소
	private Map map = new HashMap();
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		
		//ServletConfig config 를 통해 web.xml <servlet>안에 <init-param>으로 초기파라미터 저장한것을
		//꺼내서 이곳에서 사용할 수 있다
		//properties 파일 저장 경로 가져오기
		String path = config.getInitParameter("prop");	//web.xml 의<init-param>의  <param-value>에저장된 경로값을
		//가져오는것 properties 파일
		// 
		Properties p = null;//properties 파일의 내용을 자바에서 쓰기 편하게 정리해서 가져와주는 클래스
		InputStream is = null;//외부파일을 가져올때 스트림을 이용하기위해 미리 변수 사용  
		
		try {
			is = new FileInputStream(path);//객체생성 자바가아닌외부파일을 연결해서 가져오는것임으로 예외처리를 강제하는 클래스 이다 자바에서 처리할 수 있도록.
			//properties 파일 저장 경로를 주면서 파일을 가져올 수있는 스트림 만들기
			
			p = new Properties();
			p.load(is);//스트림을 던져주며 그 곳에 있는 properties 파일의 내용을 (호환될 수 있는)
			//읽어들여서 key, value 형태로 만들어 준다
			
			//uri가들어오면 uri에 맞는 bean 객체가 들어와야한다->가져옴
			//아직은 문자열로 존재함으로 객체처럼 생성해 주기 위해서
			//보따리인 Map 타입 의 uri 를 key 로 가져와서  
			//즉,p에 존재하는 모든 key, value 들에서 key, value 를 빠짐없이 객체 생성하고
			//key와 그에 해당하는 생성한 객체를 Map 에 추가해서 정리할 것임 
			
			Iterator it = p.keySet().iterator();//key 들만 모아서 반복자 얻기
		while(it.hasNext()) {//반복자를 key 가 있는만큼 반복
			String key = (String)it.next();// key = uri 하나 뽑기
			String value = p.getProperty(key);//리턴받은 key =uri 를 주며 p에서 value =빈클래스의 경로인 문자열을 꺼내옴
			Class c = Class.forName(value);//문자열 형태의 클래스 전체 이름을 주면, 해당 클래스를 찾아서 Class 타입으로 리턴해줌
			Object obj =c.newInstance();//해당 찾은 클래스의 객체를 생성해줌(여기서 어떤클래스든 객체생성 다 가능하게 할려고 object 타입으로 리턴해줌)
			map.put(key, obj);//key = uri 문자열, value = uri 에 해당하는 Bean클래스의 객체 생성한 것으로 Map에 추가
			
		}
			System.out.println(map);
			System.out.println("mapsize : " + map.size());//확인용 19개 잘나오는지 출력
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//service에서는 request 객체에서 사용자가 요청한 uri 주소를 꺼낸다 (분석 -> uri 에따른 비즈니스로직처리 &view로 응답)
		
		String uri = request.getRequestURI();
		System.out.println("uri : "+uri);
		
		Object obj = map.get(uri); // 정리해둔 map에 uri=key를 주고 해당 Bean객체를 꺼내오기
		SuperBean sb = null;//온전히 Bean객체의 매서드를 사용하고자 , Bean객체의 부모타입 변수를 준비해두고 
		String view = "/WEB-INF/board_views/list.jsp";//나중에 페이지 이동할때 던져줄 view의 파일경로 담아놓을 변수 미리 선언//이상한경로오면 list로 보내줄것이다
		if(obj instanceof SuperBean) {//원하는 actionBean 메서드를 호출하기위해 obj를 형변환 해줄것인데, 부모가 맞는지 검사하고 맞으면 형변환 하겠다
			sb = (SuperBean)obj;//맞으면 부모타입은 SuperBean 으로 형변환
			view = sb.actionBean(request, response);// 여기서 받은 매개변수들을// 비지니스 로직 처리하고 이동할 view 의 파일경로도 리턴한다
		}
			//view 로 이동  시켜준다 !!
				request.getRequestDispatcher(view).forward(request, response);
		
	}
	
	
}
