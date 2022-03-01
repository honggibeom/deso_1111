package dao.friend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class friendDAO {
	private static friendDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static friendDAO getInstance(){
		if(dao == null){
			dao = new friendDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}

	public int del(Long no) {
		int del = 0;
		
		String sql = "delete from friend where f_no = ?";
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			
			del = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}

		return del;
	}
	
	//친구조회
	public Long selectFriend(Long m_no, Long no) {
		Long fno = 0L;
		String sql = "select f_no from friend where m_no = ? and f_m_no = ?";
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, m_no);
			pstmt.setLong(2, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				fno = rs.getLong("f_no");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return fno;
	}
	
	//친구추가
	public int insert(Long fno, String name, String img, Long m_no) {
		int process = 0;
		String sql = "insert into friend (m_no, f_m_no, f_name, f_img)"
				+ " values(?,?,?,?)";
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, m_no);
			pstmt.setLong(2, fno);
			pstmt.setString(3, name);
			pstmt.setString(4, img);
			
			process = pstmt.executeUpdate();
						
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return process;
	}
}
