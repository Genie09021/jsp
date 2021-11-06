package web.jsp17.model;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListBean implements SuperBean{

	@Override
	public String actionBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		// ** 게시글 페이지 관련 정보 세팅 ** 
		// 한페이지에 보여줄 게시글의 수 
		int pageSize = 5; 

		// 현재 페이지 번호  
		String pageNum = request.getParameter("pageNum"); // 요청시 페이지번호가 넘어왔으면 꺼내서 담기. 
		if(pageNum == null){ // list.jsp 라고만 요청했을때, 즉 pageNum 파라미터 안넘어왔을때.
			pageNum = "1";
		}
		
		// 현재 페이지에 보여줄 게시글 시작과 끝 등등 정보 세팅 
		int currentPage = Integer.parseInt(pageNum); // 계산을 위해 현재페이지 숫자로 변환하여 저장 
		int startRow = (currentPage - 1) * pageSize + 1; // 페이지 시작글 번호 
		int endRow = currentPage * pageSize; // 페이지 마지막 글번호
		
		// 게시판 글 가져오기 
		BoardDAO dao = BoardDAO.getInstance();
		
		// 밑에서 검색어 작성해서 list 요청했다면, 아래 sel/search 변수에 파라미터가 들어갈것임. 
		String sel = request.getParameter("sel");
		String search = request.getParameter("search");

		// 밖에서 사용가능하게 if문 시작 전에 미리 선언
		List articleList = null;  	// 전체(검색된) 게시글들 담아줄 변수
		int count = 0; 				// 전체(검색된) 글의 개수 
		int number = 0; 			// 브라우저 화면에 뿌려줄 가상 글 번호  
		
		if(sel != null && search != null) { // 검색 한 경우 
			count = dao.getSearchArticleCount(sel, search); // 검색된 글의 총 개수 가져오기 
			System.out.println("검색 count : " + count);
			// 검색한 글이 하나라도 있으면 검색한 글 가져오기 
			if(count > 0){
				articleList = dao.getSearchArticles(startRow, endRow, sel, search); 
			}
			
		}else{ //검색 안함. 전체 게시판 요청 
			// 전체 글의 개수 가져오기 
			count = dao.getArticleCount();   // DB에 저장되어있는 전체 글의 개수를 가져와 담기
			System.out.println("count : " + count);
			// 글이 하나라도 있으면 글들을 다시 가져오기 
			if(count > 0){
				articleList = dao.getArticles(startRow, endRow); 
			}
		}
		
		number = count - (currentPage-1)*pageSize; 	// 게시판 목록에 뿌려줄 가상의 글 번호  

		// 날짜 출력 형태 패턴 생성 
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm"); fmt 써서 해보기
		
		// view에게 위에 데이터 전부 보내기
			request.setAttribute("pageSize", pageSize);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startRow", startRow);
			request.setAttribute("endRow", endRow);
			request.setAttribute("sel", sel);
			request.setAttribute("search", search);
			request.setAttribute("articleList", articleList);
			request.setAttribute("count", count);
			request.setAttribute("number", number);
			
		
		
		
		
		
		return "/WEB-INF/board_views/list.jsp";
	}
}
