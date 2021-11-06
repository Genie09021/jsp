<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="web.jsp12.model.BoardDTO"%>
<%@page import="web.jsp12.model.BoardDAO"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	// ** 게시글 페이지 관련 정보 세팅 ** 
	// 한페이지에 보여줄 게시글의 수(변수로 지정할것이다.나중에 다시 바꿀수도 있으니) 
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
	//DB에서 정렬했을때 가져오는 번호범위이다 첫번째부터 열개까지 가져와라 ~같은 
	
	//2sd
	// 게시판 글 가져오기  ->db가야됨
	BoardDAO dao = BoardDAO.getInstance(); //싱글턴 만들어서 가져다 쓰는것.new로 객체생성 이제 할 수 없다
	//사용자마다 고유한 데이터를 저장할 필요가 없는객체이고 메모리 점유를 최소화 하기 위해서 싱글톤이 사용되었다.
	//무분별하게 객체 생성해서 메모리만 쓸데없이 많이 차지하는것을 막기 위해서 ex 정수기
	
	//++밑에서 검색어 작성해서 list요청했다면 , 아래 sel/search 변수에 파라미터가 들어갈 것 임.
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	//밖에서 사용가능하세 if문 시작전에 미리 선언
	List articleList = null; // 밖에서 사용가능하게 if문 시작 전에 미리 선언 //전체(검색된)게시글 담아줄 변수
	int count = 0;//전체 검색된 글의 개수
	int number =0;//브라우저 화면에 뿌려줄 가상 글 번호
	
	//++
	if(sel != null && search != null){//검색을한 경우
		count = dao.getSearchArticleCount(sel,search);//검색된 글의 총 개수 가져오는것
	System.out.println("검색 count " +count);//확인용
		//검색한 글이 하나라도 있으면 검색한 글 가져오기
		
		if(count >0){
			articleList = dao.getSearchArticles(startRow, endRow, sel, search);
		}
		
	}else{//검색안함. 전체 게시판 요청
		
		// 전체 글의 개수 가져오기 
		count = dao.getArticleCount();   //던져줄 변수 없어도됨 DB에 저장되어있는 일반 전체 글의 개수를 가져와 담기
		System.out.println("count : " + count);
		// 글이 하나라도 있으면 글들을 다시 가져오기 
		
		if(count > 0){
			articleList = dao.getArticles(startRow, endRow); //글을 싹다가져오는것이아니고 startRow 부터 end까지 가져오기
		}
		
	}
	number = count - (currentPage-1)*pageSize; 	// 게시판 목록에 뿌려줄 가상의 글 번호  .db에는 글의 고유번호가 저장되기때문에 글이삭제되거나 해도 번호가바뀌지않음으로
	//페이지에서는 순서대로 바뀌게 .
	
	
	// 날짜 출력 형태 패턴 생성 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
%>
<body>
	<br />
		<%if(session.getAttribute("memId") == null){ %>
	<div align="right">
		<button onclick="window.location='/web/jsp12/member/loginForm.jsp'">로그인</button>
		<% }else{%>
			<button onclick="window.location='/web/jsp12/member/logout.jsp'">로그아웃</button>
		<%}%>
	</div>
	
	
	<h1 align="center"> 게시판 </h1>
	<% if(count == 0){ %>
	<table>
		<tr>
			<td><button onclick="window.location='writeForm.jsp'"> 글쓰기 </button></td>
		</tr>
		<tr>
			<td align="center">게시글이 없습니다.</td>
		</tr>
	</table>
	<%}else{ %>
	<table>
		<tr>
			<td colspan="5" align="right"><button onclick="window.location='writeForm.jsp'"> 글쓰기 </button></td>
		</tr>
		<tr>
			<td>No.</td>
			<td>제  목</td>
			<td> num / ref / re_step / re_level </td>
			<td>작성자</td>
			<td>시  간</td>
			<td>조회수</td>
		</tr>
		
		<%for(int i = 0; i < articleList.size(); i++){
			BoardDTO article = (BoardDTO)articleList.get(i); 
			%>
			<tr>
				<td><%= number-- %></td>
				<td align="left">
					<% // 답글 제목 들여쓰기 + > 화살표 이미지 추가 
						int wid = 0; 
						if(article.getRe_level() > 0) { // 답글이다 
							wid = 10 * (article.getRe_level()); %>
							
							<img src="img/tabImg.PNG" width="<%=wid%>" />
							<img src="img/replyImg.png" width="11" /> 
					<%	}// if
					%>
					<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>"> <%= article.getSubject() %> </a>
				</td>
				<td> <%=article.getNum()%> / <%=article.getRef()%> / <%=article.getRe_step()%> / <%=article.getRe_level()%> </td>
				<td><a href="mailto:<%=article.getEmail()%>"> <%= article.getWriter() %> </a></td>
				<td><%= sdf.format(article.getReg()) %></td>
				<td><%= article.getReadcount() %></td>
			</tr>
		<% }// for%>
	</table>
	<%}//else%>
	
	

	<br /> <br /> 
	<%-- 페이지 번호 --%>
	<div align="center">
	<% if(count > 0) {
		// 페이지 번호를 몇개까지 보여줄것인지 지정
		int pageBlock = 3; 
		// 총 몇페이지가 나오는지 계산 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		
		// 현재 페이지에서 보여줄 첫번째 페이지번호
		int startPage = (int)((currentPage-1)/pageBlock) * pageBlock + 1; 
		// 현재 페이지에서 보여줄 마지막 페이지번호 ( ~10, ~20, ~30...)
		int endPage = startPage + pageBlock - 1; 
		// 마지막에 보여줄 페이지번호는, 전체 페이지 수에 따라 달라질 수 있다. 
		// 전체 페이지수(pageCount)가 위에서 계산한 endPage(10단위씩)보다 작으면 
		// 전체 페이지수가 endPage가 된다. 
		if(endPage > pageCount) endPage = pageCount; 
		
		
		//++검색시, 페이지 번호 처리
		if(sel != null &&search !=null){
		
			
			// 왼쪽 꺽쇄 : startPage 가 pageBlock(3)보다 크면 
			if(startPage > pageBlock) { %>
				<a href="list.jsp?pageNum=<%=startPage-pageBlock %>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &lt; &nbsp;</a>
		<%	}
			
			// 페이지 번호 뿌리기 
			for(int i = startPage; i <= endPage; i++){ %>
				<a href="list.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &nbsp; <%= i %> &nbsp; </a>
		<%	}
			
			// 오른쪽 꺽쇄 : 전체 페이지 개수(pageCount)가 endPage(현재보는페이지에서의 마지막번호) 보다 크면 
			if(endPage < pageCount) { %>
				&nbsp; <a href="list.jsp?pageNum=<%=startPage+pageBlock%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &gt; </a>
		<%	}
		
		}else{//if검색 안 했을때
		// 왼쪽 꺽쇄 : startPage 가 pageBlock(3)보다 크면 
				if(startPage > pageBlock) { %>
					<a href="list.jsp?pageNum=<%=startPage-pageBlock %>" class="pageNums"> &lt; &nbsp;</a>
			<%	}
				
				// 페이지 번호 뿌리기 
				for(int i = startPage; i <= endPage; i++){ %>
					<a href="list.jsp?pageNum=<%=i%>" class="pageNums"> &nbsp; <%= i %> &nbsp; </a>
			<%	}
				
				// 오른쪽 꺽쇄 : 전체 페이지 개수(pageCount)가 endPage(현재보는페이지에서의 마지막번호) 보다 크면 
				if(endPage < pageCount) { %>
					&nbsp; <a href="list.jsp?pageNum=<%=startPage+pageBlock%>" class="pageNums"> &gt; </a>
			<%	}
		}//else 검색 안했을때 
	
	
	}//if(count > 0)%>
	
	<br/><br/>
	<%-- ++작성자 또는 내용으로 검색하는것 추가 --%>
	<form action ="list.jsp">
		<select name="sel">
			<option value="writer">작성자</option>
			<option value="content">내용</option>
		</select>
		<input type="text" name="search"/>
		<input type="submit" value="검색"/>
	</form>
	<br/>
	<br/>
	
	<h3 style="color:black"> 현재페이지 : <%= pageNum %></h3>
	<br/>
	<% if(sel != null && search != null){ %>
      <button onclick="window.location='list.jsp'"> 전체 게시글 보기 </button> <br />
   <%} %>
		<button onclick="window.location='/web/jsp12/member/main.jsp'">메인으로</button>
	</div>
	
	
	
</body>
</html>


