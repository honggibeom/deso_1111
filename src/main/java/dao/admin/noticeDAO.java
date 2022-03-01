package dao.admin;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

	public List<Notice> list(String kind, String keyword, int startRow, int endRow) {
		String mode = "리스트";
		String sql = search(kind,keyword,startRow,endRow,mode);
		
		List<Notice> list = new ArrayList<>();
		
		try{
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Notice dto = new Notice();
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

	public int listCount(String kind, String keyword, int startRow, int endRow) {
		String mode = "카운트";
		String sql = search(kind,keyword,startRow,endRow,mode);

		int count = 0;

		try {
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
			}	
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}	
		return count;
	}
	
	private String search(String kind, String keyword, int startRow, int endRow, String mode) {
		String sql = (mode == "리스트") ? "select * from notice where n_no > 0" : "select count(*) from notice where n_no > 0";
		String con = "";
		
		if(!keyword.equals("")){
			if(kind.equals("번호")) {
				con += " and n_no="+keyword;
			}else if(kind.equals("제목")) {				
				con += " and n_title like '%"+keyword+"%'";
			}else if(kind.equals("작성일")) {				
				con += " and regDt like '%"+keyword+"%'";
			}
		}
				
		if(mode == "리스트") {
			sql += con + " "+" order by regDt desc limit "+startRow+" , "+endRow+"";
		}else if(mode == "카운트"){
			sql += con;			
		}
		
		return sql;
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

	public int insert(String id, String title, String content, int sort) {
		int insert = 0;
		String sql ="insert into notice (n_id, n_title, n_content, n_state) values(?,?,?,?)";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setInt(4, sort);
			insert = pstmt.executeUpdate();						
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		
		return insert;
	}

	public int update(int no, String title, String content, int sort) {
		int update = 0;
		String sql ="update notice set n_title = ?, n_content = ?"
				+ ", n_state = ? where n_no = ?";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, sort);
			pstmt.setInt(4, no);
			update = pstmt.executeUpdate();	

		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		
		return update;
	}

}
