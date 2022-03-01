package dao.information;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.information.Information;

public class informationDAO {
	private static informationDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static informationDAO getInstance(){
		if(dao == null){
			dao = new informationDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	public List<Information> list() {
		List<Information> list = new ArrayList<>();
		String sql = "select * from information";
		try{
			pstmt = con.prepareStatement(sql);			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Information dto = new Information();
				dto.setI_no(rs.getLong("i_no"));
				dto.setI_id(rs.getString("i_id"));
				dto.setI_title(rs.getString("i_title"));
				dto.setI_content(rs.getString("i_content"));
				dto.setRegDt(rs.getTimestamp("regDt"));
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

	public Information getInformation(Long no) {
		Information dto = new Information();
		String sql = "select * from information where i_no = ?";
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1,no);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dto.setI_no(rs.getLong("i_no"));
				dto.setI_id(rs.getString("i_id"));
				dto.setI_title(rs.getString("i_title"));
				dto.setI_content(rs.getString("i_content"));
				dto.setRegDt(rs.getTimestamp("regDt"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		return dto;
	}
	
	
	public int update(Long no, String content) {
		int update = 0;
		String sql ="update information set i_content = ?"
				+ "  where i_no = ?";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setLong(2, no);
			update = pstmt.executeUpdate();	

		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		
		return update;
	}
	
	public int insert(Information info) {
		int insert = 0;
		String sql ="insert into information (i_id, i_title, i_content)"
				+ "  values(?,?,?)";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, info.getI_id());
			pstmt.setString(2, info.getI_title());
			pstmt.setString(3, info.getI_content());
			insert = pstmt.executeUpdate();	

		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		
		return insert;
	}
	
	
	//삭제
	public void del(Long no) {
		String sql = "delete from information where i_no="+no;
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.executeUpdate();	

		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			commit(con);
		}	

	}

}
