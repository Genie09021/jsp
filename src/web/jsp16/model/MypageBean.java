package web.jsp16.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MypageBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("sid");
		//id를 주고 해당 photo가져오기
		MemberDAO dao = MemberDAO.getInstance();
		String photo = dao.getPhoto(id);
		System.out.println("photo : "+photo);//확인용
		if(photo == null || photo == ""){
			photo = "dfim.jpg";
		}
		//photo : DB에 저장된 이미지 이름(서버상 save폴더 (...tmp0) 안에 해당 이미지가 있어야 한다.)
		//->view에 전달 해주어야 한다
		request.setAttribute("photo", photo);
		
		
		
		return "/WEB-INF/member_views/mypage.jsp";
		
	}
}
