package web.jsp12.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	//싱글턴
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() {}
	public static MemberDAO getInstance() {return instance;}
	
	
	
	
	//커넥션 가져오는 메서드 :내부에서만 사용할거라 private접근 제어자 붙임.
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env =(Context)ctx.lookup("java:comp/env");
		DataSource ds =(DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//매개변수 Memberdto , 회원 가입메서드
	public void insertMember(MemberDTO dto) {
		Connection conn= null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn = getConnection();
			String sql = "insert into users values(?,?,?,?,?,sysdate)";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getBirth());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
	}
	
	
	//id pq일치 하는지 메서드
	public boolean idPwCheck(String id, String pw) {
		boolean result = false;
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = getConnection();
			String sql = "select * from users where id = ? and pw =?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs= pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
				
		}catch(Exception e) {
			e.printStackTrace();}
		finally {
			if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	
	//회원 1명의 전체 정보 가져오기
	public MemberDTO getUser(String id) {
		Connection conn =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select * from users where id =?";
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs =pstmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setBirth(rs.getString("birth"));
				dto.setReg(rs.getTimestamp("reg"));
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return dto;
	}
	
	
	
	
	//modify pro
	///회원정보 수정(birth , email 수정)
	public int updateUser(MemberDTO dto) {
		Connection conn =null;
		PreparedStatement pstmt = null;
		int result = -1;
		try {
		
			conn=getConnection();
			String sql = "update users set birth=? , email = ? where  id= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBirth());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getId());
			
			result =pstmt.executeUpdate();
			
			System.out.println("dao update result : " +result );
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	//delete Pro
	public int deleteUser(String id, String pw) {
		int result = -1;
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try {
			conn = getConnection();
			//id pw 확인처리
			String sql = "select pw from users where id=? ";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				String dbpw = rs.getString("pw");//db에서 해당 id의 pw꺼내서 변수에 저장
				if(dbpw.equals(pw)) {//db상의 pw와 사용자가 입력한 pw가 동일하면
					//회원탈퇴로직
					sql = "delete from users where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					result =pstmt.executeUpdate();//삭제 잘되면 1, 안되면 0
				
				}else {//비번 안맞으면 0
				result =0;
				
				}
			}
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally{
			if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		System.out.println("dao delete result :" + result );
		return result;
	}
	
	
	//+아이디 중복 여부 확인 메서드
	public boolean confirmId(String id) {
		Connection conn =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			conn= getConnection();
			String sql = "select id from users where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result=true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	

}
