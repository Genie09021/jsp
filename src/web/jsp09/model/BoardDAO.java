package web.jsp09.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	//** 커넥션,db와 java 작성문을 연결해주는것 
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env =(Context)ctx.lookup("java:comp/env");
		DataSource ds =(DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	//1sd list.
	//게시글 전체 가져오는 메서드
	//**메서드의 어떤것은 매개변수없고 어떤것은 매개변수있고??
	public int getArticleCount() {
		int count = 0;
		Connection conn = null;//Connection 타입의 conn변수 선언 -try catch 안에서 쓰이나 안에서 생성시 밖에서 사용불가 미리밖에서선언
		PreparedStatement pstmt = null;
		ResultSet rs = null;//sql문 실행 결과를 받아올 ResultSet타입의 rs변수 미리선언
		
		try {
			conn= getConnection();
			String sql = "select count(*) from board";//총 board게시글이 몇개인기 계산해서 가져올것인 쿼리문
			pstmt= conn.prepareStatement(sql);//쿼리문 db커넥션 연결
			rs = pstmt.executeQuery();//대입시켜줄 값없다. 바로실행
			
			if(rs.next()) {//몇개인지 가져온 rs에 next가 true-count해온 값이 있다면
				count = rs.getInt(1);//count(*) 은 결과를 숫자로 가져오며,컬럼명 대신에 컬럼번호1로 꺼내기 	
			//1번컬럼의값을꺼내와서 미리선언한 int타입의 count변수에 대입시킨다->총 글의 개수를 담는다는것
			}
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e ) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
		}
		return count;//총 구한 게시판 글의 개수를 리턴해준다.왜?총 글이 몇개가 있는지에따라 
					//보여줄 페이지의 형태를 다르게 셋팅해주기 위해서. 0개로 없으면 없는페이지 따로 작성
	}
	

	//2sd
	//list 게시글 범위만큼 가져오는 메서드
	public List getArticles(int start, int end) {//1~10까지 가져온다고 치고
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;//List형식의 articleList 변수 생성
		
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
			pstmt.setInt(1, start);//rownum으로 정렬해서 1부터
			pstmt.setInt(2, end);//10까지의 게시글을 가져온다
		
			rs = pstmt.executeQuery();//범위에 해당하는 글들 가져옴
			if(rs.next()) {
				articleList = new ArrayList();//결과가 있으면 list 객체 생성해서 준비
				do {//if문에서 rs.next() 실행되어서 커서가 내려가 버렸으니 do-while로 먼저 데이터 꺼내게 하기
					BoardDTO article = new BoardDTO();//rs에 담긴 결과값들을 article에 넣어주는것
					
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					//**	실행결과 rs에서 String타입의 Writer 컬럼의 값을 가져와서 셋팅해 준다?ㅇㅇ
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
		
		ResultSet rs = null;//실행된 결과를 받아줄 변수를 ResultSet 타입의 rs로 선언해준것
		//조정 , 확인이 필요한 값들을 미리 꺼내놓기
		int num = article.getNum(); 		//글 번호 (새글 0, 댓글 1 이상=원본글의 고유번호 오게됨),
		//-새글은 고유번호가 ref 댓글단글의 원글의 ref가 그댓글의 ref가 된다.는것
		int ref = article.getRef(); 		//글 그룹 (새글이면 1)
		int re_step = article.getRe_step(); //정렬순서 0
		int re_level = article.getRe_level();//답글 레벨 0
		int forRef =0;						//DB에 저장할 글 고유번호 (ref)활용변수,
		//ref는 새글인지 답글인지에따라 지정해줘야하는값이 다름으로 다른 메서드 적용해서 값대입 시켜줄것임으로?
		
		
		try {
			conn = getConnection();
			//글 고유번호중 가장 큰 수 가져오기
			String sql = "select max(num) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//게시글이 존재하면 가져온 가장 큰 고유번호숫자에 +1 담기
			if(rs.next()) {forRef = rs.getInt(1) + 1;}//num을 왜 ref에 대입하는지??? num에 대입하면 안되나?Num은 시퀀스로 자동생성
			else forRef = 1; //게시글이 하나밖에 없으면 ref 1로 지정
			
			//+6.14 5sd 답글일때
			if(num != 0) {
				//DB에 기존에 달린 답글 (re_step이 0보다 큰)이 있다면, 새 답글이 1이 되기 위해
				//기존에 저장된 답글의 step 을  +1 해서 업데이트 해주기(최근 답글이 위로 올라오게)
			
				sql ="update board set re_step=re_step+1 where ref = ? and re_step > ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);//현재 넘어온 값을 셋팅
			pstmt.setInt(2, re_step);
			pstmt.executeUpdate();//기존의 값들업데이트 실행시켜주고
			//지금 내가 쓰는 답글은 DB에 저장하기전에 , 받아온 초기값 0 에서 1이 되게 더해줌
			re_step += 1 ;//
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
	public BoardDTO getArticle(int num) {//int타입의 글의 num-고유번호를 받아서 그 고유번호에 해당하는 글을 select해서 뿌려줄것
		//num 은 primaryKey 임으로 .그 한번호에는 한 값content만 존재함으로 가능한것이다
		Connection conn = null;
		PreparedStatement pstmt = null;
		BoardDTO article = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			//해당글의 조회수를 먼저 올리기->조회수컬럼 readcount를 update 수정해 주는것임으로 sql문 작성
			//num으로 해당하는 글만 조건에 맞게 고른다음에 글 불러오면/열면.readcount 수 1증가시키기
			String sql = "update board set readcount = readcount+1 where num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);//?1 번째자리에 매개변수로 입력받은 num 대입시킨다
			pstmt.executeUpdate();//sql문 업데이트 실행하고 결과는 따로 받지 않는다.
			
			
			// 
			// 해당 글 가져오기
			sql = "select * from board where num = ?";//조건문 작성
			pstmt = conn.prepareStatement(sql);//커넥션 연결
			pstmt.setInt(1, num);//값셋팅
			
			rs = pstmt.executeQuery();//실행
			
			if(rs.next()) {
				article = new BoardDTO();
				article.setNum(num);//입력받은 num값
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
	//게시글 수정 폼위에 해당 글 가져오기
	
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
	
	
	
}
		

