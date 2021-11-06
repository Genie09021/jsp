package web.jsp10.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class UploadDAO {

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds =(DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//upLoad 업로드 파일정보 저장
	public void uploadImg(String writer, String imgName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		
		try {
			conn= getConnection();
			String sql = "insert into uploadTable values(?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setString(2, imgName);
			
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		
	}
	
	
	
	
	//imgResult 이미지 가져오기 메서드
	public List getImg(String writer) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		//String imgName = null;
		ResultSet rs = null;
		List imgs = null;
		
		try {
			conn= getConnection();
			String sql ="select img from uploadTable where writer = ?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			rs =pstmt.executeQuery();// 있는만큼 뽑아옴
			if(rs.next()) {
				//imgName = rs.getString("img");//컬럼명으로 결과에서 데이터 추출하는것.뽑아오는결과가 String이니까 getString 해주는것 .애가 뽑고자하는데이터 타입
				imgs = new ArrayList();
				do {
						
					//String imgName = rs.getString("imgs");
					imgs.add(rs.getString("img"));
				}while(rs.next());
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e){e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e){e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e){e.printStackTrace();}
		}
		return imgs;
	}
	
	
}
