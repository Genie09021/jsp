package web.jsp05.test;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.sql.DataSource;
import javax.naming.InitialContext;

public class TestDAO {

		//커넥션 메서드 따로 분리
		private Connection getConnection() throws Exception{
				//DB연결
			Context ctx = new InitialContext() ;//컨텍스트 객체 생성( Context 정보 가져오려면)
			Context env = (Context)ctx.lookup("java:comp/env");//자바 컴포넌트로 만들어진 환경설정 가져오기
			DataSource ds = (DataSource)env.lookup("jdbc/orcl");//그중 .jdbc/orcl인 정보 다시 찾아오기
			Connection	conn = ds.getConnection();//커넥션 연결
			return conn;
		}
		
	//---------------------------------------------------------------------------------//	
		
		//test 테이블에 존재하는 전체 목록을 가져오는 메서드 dbcp02.jsp 
		public List selectAll() {
			List list = null;
			Connection conn = null;
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			
			
		
		try{//DB연결
			/*		Context ctx = new InitialContext() ;//컨텍스트 객체 생성( Context 정보 가져오려면)
			Context env = (Context)ctx.lookup("java:comp/env");//자바 컴포넌트로 만들어진 환경설정 가져오기
			DataSource ds = (DataSource)env.lookup("jdbc/orcl");//그중 .jdbc/orcl인 정보 다시 찾아오기
			Connection	conn = ds.getConnection();//커넥션 연결
			*/
			
			
			//4줄의 코드를 메서드로 따로 분리해줌 .
			conn = getConnection();
			//분리한 getConnection()메서드 호출해서 커넥션만 리턴받아와 변수에 담아주면 끝
			
			//쿼리문 작성 ,pstmt 객체 
			pstmt = conn.prepareStatement("select * from test");
		
			//쿼리실행
			rs = pstmt.executeQuery();
			//rs에 있는 레코드에 수만큼 반복해서
			
			 list = new ArrayList();// 리스트에 담을 준비
			//rs에 있는 레코드에 수만큼 반복해서 
			 while(rs.next()) {
				//한번 반복할때, 하나의 레코드에서 각각 값을 꺼내서 dto생성해 각각 에 담고
					
				 TestDTO dto = new TestDTO();
				 
				 dto.setId(rs.getString("id"));
				 dto.setPw(rs.getString("pw"));
				 dto.setAge(rs.getInt("age"));
				 dto.setReg(rs.getTimestamp("reg"));
				//dto 에 하나의 레코드정보를 담았으면, list 에 추가하기
				 list.add(dto);
			 }
			}catch(Exception e) {
				e.printStackTrace();
		}finally {
			if(rs != null )try {rs.close();}catch (Exception e ) {e.printStackTrace();}
			if(pstmt != null )try {pstmt.close();}catch (Exception e ) {e.printStackTrace();}
			if(conn != null )try {conn.close();}catch (Exception e ) {e.printStackTrace();}
		}
		return list;
		
	}
		
		
	//회원가입 : jsp에서 던져준 id,pw,age 데이터를 받기위한 매개변수 작성
	public void insert (String id, String pw, int age) {
		//finally 구문에서 변수 close()해주기 위해서 try 전에 미리 변수 = null 로 선언만
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		try{
			conn=getConnection();
			String sql = "insert into test values(?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  id);
			pstmt.setString(2,  pw);
			pstmt.setInt(3,  age);
		
		int result = pstmt.executeUpdate();
		System.out.println(result);
		
		}catch(Exception e ) {
			e.printStackTrace();
		}
		finally {
			if(pstmt !=null) try {pstmt.close();} catch(Exception e ) {e.printStackTrace();}
			if(conn !=null) try {conn.close();} catch(Exception e ) {e.printStackTrace();}
		}
		
	}
		
	
	//pro.jsp
	public void insert2(TestDTO dto) {
		//finally 구문에서 변수 close)(해주기 위해서 try 전에 미리 변수 = null 로 선언만
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		try{
			conn=getConnection();
			String sql = "insert into test values(?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  dto.getId());
			pstmt.setString(2,  dto.getPw());
			pstmt.setInt(3,  dto.getAge());
			
			int result = pstmt.executeUpdate();
			System.out.println(result);
		
		}catch(Exception e ) {
			e.printStackTrace();
		}
		finally {
			if(pstmt !=null) try {pstmt.close();} catch(Exception e ) {e.printStackTrace();}
			if(conn !=null) try {conn.close();} catch(Exception e ) {e.printStackTrace();}
		}
	
	}
	
}
