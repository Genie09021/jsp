package web.jsp15.mvc;

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

//서블릿 컨테이너에 처음 요청들어오면 자동으로 객체 생성되고 서버가 stop 될때까지 살아있다.(마치 싱글턴처럼 사용됨)
public class MemberTestController extends HttpServlet{
	
	//+Map (key=uri, value=uri 맞는 Bean클래스 객체)
	//service -> 요청 ->Map에 키로 던져 value=Bean 클래스 -> actionBean
	
	//key=uri, value =  uri 에 맞는 Bean 클래스의 생성된 객체들을 저장해 놓을 저장소 
	private Map beansMap = new HashMap();
	
	//	LoginFormBean lfb; ~15 까지 properties 만들었으니 주석처리
	//	LoginProBean lpb;
	//	48개 추가 
	
	//init : 오버라이딩 : Bean클래스들을 미리 로딩 시켜놓고 service에서 요청에 따라 필요한거 가져다 써라 ~~ 
	@Override
	public void init(ServletConfig config) throws ServletException {
	//	lfb = new LoginFormBean(); properties 만들었으니 주석처리
	//	lpb = new LoginProBean();
		//48개추가(bean클래스 ,jsp, 요청경로가 50개일때)
		
		String path =config.getInitParameter("propertiesPath");//properties만들어준 경로 꺼내보기 path라고 함//webxml에 초기화 설정정보 가져올 수있다
		System.out.println("path : "+path);
		
		//Properties 클래스로 properties 파일 정보 로드 시키기 .property-텍스트로 정리해놓은 설정정보 문서화한것 xml같은것이다
		//properties 만들어서 if else줄일수있다
		Properties p = null;	//properties 타입의 외부파일 가져올떄 사용
		InputStream is = null;	//properties 파일 로드 시켜주는 기능을 위해 사용
		
		
		try {
		p = new Properties();	//Map
		is = new FileInputStream(path); ///외부파일 가져올때 스트림 생성, 생성자 인수로 파일 저장경로 던져주기
		
		// 로드 시키기(key, value)
		p.load(is);//이 경로에 있는 스트림을 만들어주고 스트림 만들어준것을 properties 자동으로 key, value 형태로 를 매핑 시켜준다
		//매개변수로 inputstream을 받아 properties파일을 자동으로 Map타입으로 만들어 준다
		System.out.println("p : " + p);//출력으로 자동으로 map타입으로 변환된 것을 알 수 있다.
		//텍스트파일인 문서를 자바에서 읽게하는것이 key value로 문자로 된다
		
		Iterator it = p.keySet().iterator();//반복자 얻어오기
		while(it.hasNext()) {
			String key = (String)it.next();
			String value =p.getProperty(key);
		//	System.out.println("key : "+key); 확인후 주석 처리
		//	System.out.println("value : "+ value);
			
			//Properties 파일은 원본 그대로 유지, 
			//beansMap에 uri 경로 = key, Bean 클래스 객체 = value 정리해서 저장
			Class c = Class.forName(value);//bean클래스 경로명(문자열)으로 해당 클래스 찾아 리턴받기 //경로에맞는 해당 클래스를 찾아줌
			Object obj = c.newInstance();// 해당 클래스로 객체 생성 new XXXBena()과 동일
			beansMap.put(key, obj);//map에 저장
			
		}
		
		System.out.println("beansMap : " +beansMap);
		
		/*+추가 설명
		p : key = uri(String)/ value=Bean (String)
				beansMap : key =uri(String) / value =Bean(객체 생성된거 new~로)
		*/
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//+HashMap 복습
		Map map  = new HashMap();	//저장 put(key, vlaue); 값 꺼내기 .get(key); 하나씩 모두접근 .keySet() .iterator()반복자 얻어서 다 돌리기
		map.put("hello", "servlet");
		map.put("hello", 10);
		//map.put("hello", new Date());
		
		
		String uri = request.getRequestURI();
		System.out.println("uri : " +uri);
		//http://localhost:8080/web/아무거나 .git
		//http://localhost:8080/web/main .git ->main.jsp 셋팅
		//http://localhost:8080/web/index .git ->index.jsp 
		
		/*uri 에따른 처리
		String view ="";
		if(uri.equals("/web/main.git")) {
			//처리 :DTO DAO 등등 : jsp페이지에 섞여있던 자바 코드가 다 이곳으로 이동,jsp 페이지는 결과만 보여준다.
			view="/jsp15/main.jsp";
		}else if(uri.equals("/web/index.git")) {

			//비즈니스 로직 처리
			
			view="/jsp15/index.jsp";
		}//단점 -> if-else 페이지 개수만큼 else if 가 존재한다 , 코드 많고 복잡해 진다=>	비즈니스 로직 처리를 Model 클래스로 분리 시키자
		*/
		
		
		//uri = key 값 주고 value = bean클래스 객체 꺼내기 ->이유는 요청에 맞는 actionBean 메서드 호출하고 맞는 view주소 리턴받기 위해서 
		Object obj = beansMap.get(uri);//value 가 나온다

		String view="";
		SuperBean sb = null;
		if(obj instanceof SuperBean) {
			sb = (SuperBean)obj;
			view = sb.actionBean(request, response); //모델한테 위임 : 비즈니스 로직 처리하고 이동할 view 리턴해줘
		}
		//jsp페이지 만들고 ㅡ Bean클래스 만들고 ->properties 파일에 한줄 추가(주의점 : Bean클래스를 만들고 properties 에 추가하기)

		
		/* ++if else지우기
		if(uri.equals("/web/loginForm.git")) {
			//+LoginFormBean lfb = new LoginFormBean();//위에 첫줄에서 변수선언 그아래에서 객체생성해줘서 주석처리해도됨
		//	view=lfb.actionBean(request, response); properties 만들었으니 주석처리
			//원래view="/jsp15/loginForm.jsp";//실제 jsp페이지의 경로
			
		}else if(uri.equals("/web/loginPro.git")){
			//비즈니스 로직 처리
			//+LoginProBean lpb = new LoginProBean();
		//	view=lpb.actionBean(request, response); properties 만들었으니 주석처리
			//view="/jsp15/loginPro.jsp";
		
		}//만약 요청경로가 50개일경우 elseif50개 필요한 단점이 있다
		*/
		
		//view forward
		request.getRequestDispatcher(view).forward(request, response);
		
		
	}
	
	
	
}
