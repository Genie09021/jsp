package web.jsp12.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	//+싱글턴
	private static BoardDAO instance = new BoardDAO();
	private BoardDAO() {}
	public static BoardDAO getInstance() { return instance;}
	
	
	
	//커넥션
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env =(Context)ctx.lookup("java:comp/env");
		DataSource ds =(DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	//list. 게시글 전체 가져오는 메서드
	public int getArticleCount() {
		int count = 0;//전체 글의 개수 담아줄 변수 미리 선언 .안에서생성시 안에서만 쓸수있음으로 리턴이 불가하기 때문에 .
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {//쿼리문실행은 무조건 try catch안에서만
			conn= getConnection();//db에 연결할 커넥션 얻어오는것.
			String sql = "select count(*) from board";
			pstmt= conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);//count(*) 은 결과를 숫자로 가져오며,컬럼명 대신에 컬럼번호1로 꺼내기 	
			}
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e ) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
		}
		return count;
	}
	
	
	//2sd
	//list 게시글 범위만큼 가져오는 메서드
	public List getArticles(int start, int end) {//1~10까지 가져온다고 치고
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		
		try {
			conn = getConnection();
			/*String sql ="select num, writer, subject, email, content, pw,reg,readcount,ref,re_step,re_level,r "
			+" from (select num, writer, subject, email, content, pw,reg,readcount,ref,re_step,re_level,rownum r " 
			+"from (select num, writer, subject, email, content, pw,reg,readcount,ref,re_step,re_level " 
			+"from board order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r <= ?";//길어서 문자열 나눠서 나눠서썼다
			*/
			String sql = "select B.*, r "
		               + "from (select A.*, rownum r from "
		               + "(select * from board order by ref desc, re_step asc) A "
		               + "order by ref desc, re_step asc) B "
		               + "where r >= ? and r <= ?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
		
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articleList = new ArrayList();//결과가 있으면 list 객체 생성해서 준비
				do {//if문에서 rs.next() 실행되어서 커서가 내려가 버렸으니 do-while로 먼저 데이터 꺼내게 하기
					BoardDTO article = new BoardDTO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setEmail(rs.getString("email"));
					article.setContent(rs.getString("content"));
					article.setPw(rs.getString("pw"));
					article.setReg(rs.getTimestamp("reg"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setReadcount(rs.getInt("readcount"));
					articleList.add(article);//리스트에 추가
					
				}while(rs.next());	
			}
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally{
			if(rs != null)try {rs.close();}catch(Exception e ) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
		}
		return articleList;
	}
	
	//4sd
	//writePro 글 저장 메서드 
	public void insertArticle(BoardDTO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//조정 , 확인이 필요한 값들을 미리 꺼내놓기
		int num = article.getNum(); 		//글 번호 (새글 0, 댓글 1 이상=원본글의 고유번호 오게됨)
		//-새글은 고유번호가 ref 댓글단글의 원글의 ref가 그댓글의 ref가 된다.는것
		int ref = article.getRef(); 		//글 그룹 (새글이면 1)
		int re_step = article.getRe_step(); //정렬순서 0
		int re_level = article.getRe_level();//답글 레벨 0
		int forRef =0;						//DB에 저장할 글 고유번호 (ref)활용변수
		
		
		try {
			conn = getConnection();
			//글 고유번호중 가장 큰 수 가져오기
			String sql = "select max(num) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//게시글이 존재하면 가져온 가장 큰 고유번호숫자에 +1 담기 -> ref한테 사용 
			if(rs.next()) {forRef = rs.getInt(1) + 1;}
			else forRef = 1; //게시글이 하나밖에 없으면 ref 1로 지정
			
			//+6.14 5sd 답글일때
			if(num != 0) {
				//DB에 기존에 달린 답글 (re_step이 0보다 큰)이 있다면, 새 답글이 1이 되기 위해
				//기존에 저장된 답글의 step 을  +1 해서 업데이트 해주기(최근 답글이 위로 올라오게)
				
				sql ="update board set re_step=re_step+1 where ref = ? and re_step > ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_step);
			pstmt.executeUpdate();
			//지금 내가 쓰는 답글은 DB에 저장하기전에 , 받아온 초기값 0 에서 1이 되게 더해줌
			re_step += 1 ;
			re_level += 1;
			
			}else {
			//새글 기본값
			ref = forRef;
			re_step =0;//생략가능
			re_level=0;//생략가능
			}
			//6.11 5sd
			sql = "insert into board(num, writer, subject, email,content, pw,reg,readcount, ref,re_step,re_level) values(board_seq.nextVal,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getEmail());
			pstmt.setString(4, article.getContent());
			pstmt.setString(5, article.getPw());
			pstmt.setTimestamp(6, article.getReg());
			pstmt.setInt(7, article.getReadcount());
			pstmt.setInt(8, ref);
			pstmt.setInt(9, re_step);
			pstmt.setInt(10, re_level);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e ) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
		}
	}
	
	//6.14  1sd content
	//글 고유번호 받아 해당 글 한개 가져오는 메서드
	public BoardDTO getArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		BoardDTO article = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			//해당글의 조회수를 먼저 올리기
			String sql = "update board set readcount = readcount+1 where num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			
			// 해당 글 가져오기
			sql = "select * from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardDTO();
				article.setNum(num);
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setEmail(rs.getString("email"));
				article.setContent(rs.getString("content"));
				article.setPw(rs.getString("pw"));
				article.setReg(rs.getTimestamp("reg"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
			}
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally{
			if(rs != null)try {rs.close();}catch(Exception e ) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
		}
		return article;
	}
	
	
	//2sd modifyForm
	//게시글 수정 폼위해 해당 글 가져오기
	
	public BoardDTO getUpdateAritlcle(int num) {
		BoardDTO article = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			conn = getConnection();
			String sql = "select * from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new BoardDTO();
				article.setNum(num);
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setEmail(rs.getString("email"));
				article.setContent(rs.getString("content"));
				article.setPw(rs.getString("pw"));
				article.setReg(rs.getTimestamp("reg"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				
			}
		
		}catch(Exception e ) {
			e.printStackTrace();
		}finally{
			if(rs != null)try {rs.close();}catch(Exception e ) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
		}
		
		return article;
	}
		
	
	//modify
	//게시글 수정 처리 메서드
	public int updateArticle(BoardDTO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			conn = getConnection();
			//비밀번호가 맞는지 확인 ->비밀번호 오류/수정안됨 = 0, 비밀번호 맞아서 수정되면 =1(executeUpdate 리턴값으로 대치)
			String sql = "select pw from board where num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String dbpw = rs.getString("pw");
				System.out.println(dbpw);
				if(dbpw.equals(article.getPw())) {
					//DB상 비번과 일치하면 업데이트
					sql ="update board set writer=?, subject=? ,email=?, content =? where num = ? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getSubject());
					pstmt.setString(3, article.getEmail());
					pstmt.setString(4, article.getContent());
					pstmt.setInt(5, article.getNum());
					result = pstmt.executeUpdate();//하나의 레코드 업데이트 되면 1 리턴
					
				}else {
					result = 0;
				}
			}
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e ) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
		}
		return result;
	}
	
	
	
	//3sd deletePro
	public int deleteArticle(int num , String pw) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			//비밀번호 확인
			String sql = "select pw from board where num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs =pstmt.executeQuery();
			
			if(rs.next()) {
				String dbpw = rs.getString("pw");
				if(dbpw.equals(pw)) {
					//비밀번호 맞으면 데이터 삭제
					sql = "delete from board where num =?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					result = pstmt.executeUpdate();//삭제 잘 되었으면 1 리턴
				}
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e ) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
		}
		return result;
	}
	
	
	//+++
	//list 검색된 글의 개수 가져오기
	public int getSearchArticleCount(String sel, String search) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn= getConnection();
			String sql = "select count(*) from board where "+sel +" like '%" + search + "%'";
			//select count (*) from board where writer like '%abc%';
			pstmt= conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);//count(*) 은 결과를 숫자로 가져오며,컬럼명 대신에 컬럼번호1로 꺼내기 	
			}
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e ) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
		}
		return count;
	}
	
	
	
	//list 검색한 글들 가져오기 메서드
	public List getSearchArticles(int start, int end, String sel, String search) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		
		try {
			conn = getConnection();
			/*String sql ="select num, writer, subject, email, content, pw,reg,readcount,ref,re_step,re_level,r "
			+" from (select num, writer, subject, email, content, pw,reg,readcount,ref,re_step,re_level,rownum r " 
			+"from (select num, writer, subject, email, content, pw,reg,readcount,ref,re_step,re_level " 
			+"from board order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r <= ?";//길어서 문자열 나눠서 나눠서썼다
			*/
			String sql = "select B.*, r "
		               + "from (select A.*, rownum r from "
		               + "(select * from board where " +sel+" like '%"+search+"%' order by ref desc, re_step asc) A "
		               + "order by ref desc, re_step asc) B "
		               + "where r >= ? and r <= ?";
			//select * from board where writer like '%el%' order by ...;
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
		
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articleList = new ArrayList();//결과가 있으면 list 객체 생성해서 준비
				do {//if문에서 rs.next() 실행되어서 커서가 내려가 버렸으니 do-while로 먼저 데이터 꺼내게 하기
					BoardDTO article = new BoardDTO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setEmail(rs.getString("email"));
					article.setContent(rs.getString("content"));
					article.setPw(rs.getString("pw"));
					article.setReg(rs.getTimestamp("reg"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setReadcount(rs.getInt("readcount"));
					articleList.add(article);//리스트에 추가
					
				}while(rs.next());	
			}//if
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally{
			if(rs != null)try {rs.close();}catch(Exception e ) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
		}
		return articleList;
	}
	
	
	
	
}
		

