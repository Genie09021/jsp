package web.jsp11.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	//싱글톤
	
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() {}
	public static MemberDAO getInstance() {return instance;}
	
	
	//커넥션
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds =(DataSource)env.lookup("jdbc/orcl");
		 return ds.getConnection();
	}
	
	
	
	//signup 회원 가입 메서드
	public void insertMember(MemberDTO member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn= getConnection();
			String sql = "insert into imgMember values(?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getBirth());
			pstmt.setString(6, member.getPhoto());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
	}
	
	
	
	
	//loginPro id pw확인 메서드
	public int idPwCheck(String id, String pw) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			//-1 : id 존재 x
			//0 : id ok,비번 틀림
			//1 : id.pw일치한다
			conn=getConnection();
			String sql = "select id from imgMember where id =?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {//id가 있으면
				//그다음 pw도 일치하는지 검사 ,쿼리문 작성
				sql = "select * from imgMember where id = ? and pw = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {//pw일치한다
					result = 1;
				}else {
					result = 0;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		
		return result;
	}
	
	
	
	//mypage
	//id로 photo 가져오는 메서드
	public String getPhoto(String id) {
		String photo = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			conn = getConnection();
			String sql = "select photo from imgMember where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				photo = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return photo;
	}
	//ㄴ-----6.16
	
	
	
	//6.17modify 1sd
	//id받아서 해당 회원정보 전체 가져오는메서드
	public MemberDTO getMember(String id) {
		MemberDTO member = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from imgMember where id=?";
			pstmt = conn.prepareStatement(sql);//쿼리문
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();//쿼리날리고 변수 rs에 결과담기
			
			if(rs.next()) {//rs.next() 다음으로 커서를내리고 값이있으면 true , 없으면 false
				member = new MemberDTO();//DTO는 싱글톤으로 안됨.모든 사람이 본인의 데이터를 들고 왔다갔다해야함으로 ..사람마다다 다른영역의메모리가있어야함으로
				member.setId(id);
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setBirth(rs.getString("birth"));
				member.setPhoto(rs.getString("photo"));
				member.setReg(rs.getTimestamp("reg"));
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return member;
	}
	
	//modifyPro 2sd
	///회원정보수정
	public int updateMember(MemberDTO member) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn=getConnection();
			String sql = "select pw from imgMember where id=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String dbpw = rs.getString("pw");//=getString(1);
					if(dbpw.equals(member.getPw())) {
						sql = "update imgMember set birth=?, email=?, photo=? where id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, member.getBirth());
						pstmt.setString(2, member.getEmail());
						pstmt.setString(3, member.getPhoto());
						pstmt.setString(4, member.getId());
						
						result = pstmt.executeUpdate();
							System.out.println(member.getPw());
					}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	
	//3sd
	//deletePro 에서 회원탈퇴 pw확인하고 삭제시키고 결과는 int 로 리턴 하겟다
	public int deleteMember(String id, String pw) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn= getConnection();
			String sql = "select pw from imgMember where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);//pw하나 긁어오기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String dbpw = rs.getString("pw");
					if(dbpw.equals(pw)) {//id와일치하는 db상의 pw와 사용자 입력 pw와같은지 
						sql ="delete from imgMember where id=?";
						pstmt =conn.prepareStatement(sql);
						pstmt.setString(1, id);
						result = pstmt.executeUpdate();
					}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
}
