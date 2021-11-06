package web.jsp16.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class SignupProBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
	
		MemberDTO member = new MemberDTO();
	
		//Multipart Request 객체 사용
		String path = request.getRealPath("save");
		System.out.println(path);
		int max = 1024*1024*5;
		String enc = "utf-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
		
		
		//넘어온 데이터를 꺼내서 DB에 저장하기
		member.setId(mr.getParameter("id"));
		member.setPw(mr.getParameter("pw"));
		member.setName(mr.getParameter("name"));
		member.setBirth(mr.getParameter("birth"));
		member.setEmail(mr.getParameter("email"));
		member.setPhoto(mr.getFilesystemName("photo"));//이미지 파일 업로드된  이름으로 저장
		
		MemberDAO dao = MemberDAO.getInstance();
		dao.insertMember(member);
		
		
		
		
		
	
		
		
		return "/WEB-INF/member_views/signupPro.jsp";
	}
}
