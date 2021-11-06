package web.jsp16.model;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteProBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		//id , pw 얻어오기
		String id=(String)session.getAttribute("sid");
		String pw = request.getParameter("pw");
		
		MemberDAO dao = MemberDAO.getInstance();
		//먼저 저장된 photo이름도 가져오겠다.->실제 이미지 파일을 서버에서 삭제 시키기위해 미리 이름 받아오기
		String photo =dao.getPhoto(id);//그사람의 사진 이름 가져옴 (mypage에서 만듬)
		String path = request.getRealPath("save");//실제 파일 저장되는 save폴더의 경로 찾고 
		
		path +="\\" + photo;//거기에 \파일명 .확장자 까지 연결해서 실제 파일 경로 준비
		System.out.println("DP path"+path);//확인용 .경로
		
		
		
		//삭제
		int check = dao.deleteMember(id,pw);
		
		System.out.println("DP check"+check);
		
		if(check == 1){
			//+이미지 파일도 삭제 해주어야함
			File f = new File(path);
			f.delete();
		
			//로그아웃처리
			session.invalidate();
			//쿠키있으면 쿠키삭제
		}
		//view에서 페이징 처리 위해 check 보내주기
		request.setAttribute("check", check);
		
		return"/WEB-INF/member_views/deletePro.jsp";
	}

}
