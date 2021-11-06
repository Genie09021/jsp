package web.jsp16.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ModifyFormBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//로그인이 안된 상태에서 접근시 , 
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("sid");
		
		
		if(id == null ) {//로그인이 안된 상태로 접근한것
			request.setAttribute("check", 0);// check ==0 :비로그인 check ==1 :로그인 상태 
		}else {
			//db에서 id에 해당하는 전체 정보를 가져와 하단에 뿌려주기
			MemberDAO dao = MemberDAO.getInstance();//DAO는 싱글턴으로 구성하였음으로, 객체 얻어다 사용(new못쓴다)
			MemberDTO member = dao.getMember(id);//id에 해당하는 정보 긁어와~~
			
			//member 꺼냈으니까 view에 member객체  전달해 준다
			request.setAttribute("member", member);
			request.setAttribute("check", 1);	//view에서 분기처리를 위하여 로그인시에도 1로 check보내주기
			
		}
		
		
		return "/WEB-INF/member_views/modifyForm.jsp";
	}
}
