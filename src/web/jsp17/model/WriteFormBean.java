package web.jsp17.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WriteFormBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	//로그인이되어있는지 확인
		HttpSession session = request.getSession();
		//String id = (String)session.getAttribute("sid"); 아직 회원가입이랑 연결을 안해서 주석처리 임의로 java넣어줌
		String id  ="java";//회원가입이랑 연결을 안했기때문에 가상 id 작성해서 처리하도록 하자 
		
		
		
		// DB에 담아줄 글 관련 정보 선언+초기화 
		// 글번호, 그룹, 정렬순서, 답글레벨 
		int num = 0, ref = 1, re_step = 0, re_level = 0;
		// num (새글 작성 0, 답글 1이상 답글다는 원본글의 고유번호)
		
		// 답글로 넘어왔을 경우 (num, ref, re_step, re_level 4개 들고 넘어옴)
		if(request.getParameter("num") != null){ // 넘어온 파라미터중 num으로 새글작성인지 답글작성인지 판단 
			// 정보 담기 
			num = Integer.parseInt(request.getParameter("num"));  
			ref = Integer.parseInt(request.getParameter("ref"));   
			re_step = Integer.parseInt(request.getParameter("re_step")); 
			re_level = Integer.parseInt(request.getParameter("re_level"));  
		}
		
		//view한테 위만들어진 데이터를 전부 전달 할것임 .5개
		request.setAttribute("id", id);
		request.setAttribute("num", num);
		request.setAttribute("ref", ref);
		request.setAttribute("re_step", re_step);
		request.setAttribute("re_level", re_level);
		
		
		return "/WEB-INF/board_views/writeForm.jsp";
	}
}
