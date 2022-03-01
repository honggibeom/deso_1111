package dao.notice;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.notice.Notice;


public class noticeDAO {
	private static noticeDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static noticeDAO getInstance(){
		if(dao == null){
			dao = new noticeDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	//list
	public List<Notice> noticeList() {
		List<Notice> list = new ArrayList<>();
		Notice dto = null;
		String sql = "select * from notice order by regDt desc";
		try{			
			pstmt = con.prepareStatement(sql);						
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				dto = new Notice();
				dto.setN_no(rs.getLong("n_no"));
				dto.setN_id(rs.getString("n_id"));
				dto.setN_title(rs.getString("n_title"));
				dto.setN_content(rs.getString("n_content"));
				dto.setN_state(rs.getBoolean("n_state"));
				dto.setN_hit(rs.getLong("n_hit"));
				dto.setRegDt(rs.getTimestamp("regDt"));
				dto.setModDt(rs.getTimestamp("modDt"));
				
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

	public Notice getNotice(int no) {
		Notice dto = new Notice();
		String sql = "select * from notice where n_no = ?";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto.setN_no(rs.getLong("n_no"));
				dto.setN_id(rs.getString("n_id"));
				dto.setN_title(rs.getString("n_title"));
				dto.setN_content(rs.getString("n_content"));
				dto.setN_state(rs.getBoolean("n_state"));
				dto.setN_hit(rs.getLong("n_hit"));
				dto.setRegDt(rs.getTimestamp("regDt"));
				dto.setModDt(rs.getTimestamp("modDt"));		
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		
		return dto;
	}

	public void countUp(int no) {
		String sql = "update notice set n_hit = n_hit + 1 where n_no="+no;
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
	}
}
