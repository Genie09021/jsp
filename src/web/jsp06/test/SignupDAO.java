package web.jsp06.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SignupDAO {

		//커넥션 가져오는 메서드 따로 하나 만들어 주기
		private Connection getConnection() throws Exception {
			Context ctx = new InitialContext();
			Context env =(Context)ctx.lookup("java:comp/env");
			DataSource ds =(DataSource)env.lookup("jdbc/orcl");
			return ds.getConnection();
		}
		
		//---------------------------------------------------
		//signupForm
		//회원가입 처리해주는 메서드
	public void insertForm(SignupVO vo) {
		Connection conn =null;
		PreparedStatement pstmt = null;
		
		try {
			
			conn= getConnection();
			String sql = "insert into signup values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getId());//디비버의 테이블 순서대로 채워주기.vo가 값을 다 가지고있기때문에 vo값을 슴
			pstmt.setString(2, vo.getPw());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getEmail());
			pstmt.setString(5, vo.getGender());
			pstmt.setString(6, vo.getMusic());
			pstmt.setString(7, vo.getSports());
			pstmt.setString(8, vo.getTravel());
			pstmt.setString(9, vo.getMovies());
			pstmt.setString(10, vo.getBirthYY());
			pstmt.setString(11, vo.getBirthMM());
			pstmt.setString(12, vo.getBirthDD());
			pstmt.setString(13, vo.getJob());
			pstmt.setString(14, vo.getBio());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
		}
	
	//------------------------------------------------
	
	//회원 전체정보 가져오는 메서드 membersList
	//리턴은 데이터 하나밖에 못 보내기 때문에 하나로 묶어서 보낼 수 밖에 없음.포장을 잘해서 보내기
		public  List selectAll() {
			List list = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select * from signup");
				rs = pstmt.executeQuery();
				
				list = new ArrayList();
				while(rs.next()) {
					SignupVO vo = new SignupVO();//signupvo에 정리한다음 꺼낼거다. vo객체생성
					vo.setId(rs.getString("id"));//해당 컬럼꺼내서
					vo.setPw(rs.getString("pw"));
					vo.setName(rs.getString("name"));
					vo.setEmail(rs.getString("Email"));
					vo.setGender(rs.getString("gender"));
					vo.setMusic(rs.getString("music"));
					vo.setSports(rs.getString("sports"));
					vo.setTravel(rs.getString("travel"));
					vo.setMovies(rs.getString("movies"));
					vo.setBirthYY(rs.getString("birthYY"));
					vo.setBirthMM(rs.getString("birthMM"));
					vo.setBirthDD(rs.getString("birthDD"));
					vo.setJob(rs.getString("job"));
					vo.setBio(rs.getString("bio"));
					vo.setReg(rs.getTimestamp("reg"));
							list.add(vo);
							
				}
				
			}catch(Exception e) {
				e.printStackTrace();
				
			}finally{
				if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return list;
		}
		
		//----------------------------------
		
		//modifyForm
		//이메일 수정 메서드 
		public int updateEmail(String id, String email) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			int result = -1;//try 안에있으니까 리턴시 빨간줄나옴,try 밖에다가 변수선언해줬다
			
			try {
				
				conn = getConnection();
				String sql = "update signup set email = ? where id =? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, email);
				pstmt.setString(2, id);
				
				result =pstmt.executeUpdate();//int result 에서 int뺴고 값대입만 해줌
				System.out.println("Update Result : " + result);
				
				
			}catch(Exception e ) {
				e.printStackTrace();
			}finally {
				if(pstmt !=null)try {pstmt.close();}catch(Exception e ) {e.printStackTrace();}
				if(conn !=null)try {conn.close();}catch(Exception e ) {e.printStackTrace();}
			}
			return result;
		}
		
		
		
		
		
		
	}
	
