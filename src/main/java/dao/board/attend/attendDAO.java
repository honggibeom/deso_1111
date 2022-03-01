package dao.board.attend;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.attend.Attend;

public class attendDAO {
	private static attendDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static attendDAO getInstance(){
		if(dao == null){
			dao = new attendDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	private Attend AttendDTO(Attend dto) throws SQLException {
		dto.setNo(rs.getLong("no"));
		dto.setB_no(rs.getLong("b_no"));
		dto.setM_no(rs.getLong("m_no"));
		dto.setM_name(rs.getString("m_name"));
		dto.setM_img(rs.getString("m_img"));
		dto.setKind(rs.getBoolean("kind"));
		dto.setRegDt(rs.getTimestamp("regDt"));
		return dto;
	}
	
	//참석
	public int attend(Long no, Long m_no, String name, String img) {
		int insert = 0;
		String sql = "insert into attend (b_no, m_no, m_name, m_img) "
				+ "values(?,?,?,?)";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, no);
			pstmt.setLong(2, m_no);
			pstmt.setString(3, name);
			pstmt.setString(4, img);
			
			insert = pstmt.executeUpdate();	
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return insert;
	}
	
	//행사참석
	public int eventAttend(Long no, Long m_no, String name, String img) {
		int insert = 0;
		String sql = "insert into attend (b_no, m_no, m_name, m_img, kind) "
				+ "values(?,?,?,?,1)";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, no);
			pstmt.setLong(2, m_no);
			pstmt.setString(3, name);
			pstmt.setString(4, img);
			
			insert = pstmt.executeUpdate();	
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return insert;
	}

	public int unAttend(Long no, Long m_no) {
		int del = 0;
		String sql = "delete from attend where b_no = ? and m_no = ?";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, no);
			pstmt.setLong(2, m_no);
			
			del = pstmt.executeUpdate();	
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return del;
	}

	public List<Attend> list(Long no, int state) {
		List<Attend> list = new ArrayList<>();

		String sql = "select * from attend where b_no = ? and kind = ?";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			pstmt.setInt(2, state);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Attend dto = new Attend();
				dto = AttendDTO(dto);
				list.add(dto);				
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return list;
	}

	public int state(Long no) {
		int update = 0;
		String sql = "update attend set kind = 1 where no = ?";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, no);			
			update = pstmt.executeUpdate();
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return update;
	}

	public int unState(Long no) {
		int del = 0;
		String sql = "delete from attend where no = ?";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, no);			
			del = pstmt.executeUpdate();				
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return del;
	}


}
