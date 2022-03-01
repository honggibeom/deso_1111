package dao.board.comment;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.comment.Comment;

public class commentDAO {
	private static commentDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static commentDAO getInstance(){
		if(dao == null){
			dao = new commentDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	private Comment CommentDTO(Comment dto) throws SQLException {
		dto.setC_no(rs.getLong("c_no"));
		dto.setC_b_no(rs.getLong("c_b_no"));
		dto.setC_m_no(rs.getLong("c_m_no"));
		dto.setC_name(rs.getString("c_name"));
		dto.setC_img(rs.getString("c_img"));
		dto.setC_content(rs.getString("c_content"));
		dto.setC_group(rs.getLong("c_group"));
		dto.setC_parentFl(rs.getBoolean("c_parentFl"));
		dto.setC_del_fl(rs.getBoolean("c_del_fl"));
		dto.setRegDt(rs.getTimestamp("regDt"));
		return dto;
	}
	
	
	public List<Comment> commentList(Long no) {
		List<Comment> list = new ArrayList<>();

		String sql = "select * from comment where c_b_no = ? and c_parentFl = 0 and c_del_fl = 0";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Comment dto = new Comment();
				dto = CommentDTO(dto);
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
	
	public Comment getComment(Long no) {
		Comment dto = new Comment();
		String sql = "select * from comment where c_no = ? and c_del_fl = 0";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = CommentDTO(dto);		
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return dto;
	}
	
	//대댓글가져오기
	public List<Long> childComment(Long c_group) {
		List<Long> nos = new ArrayList<>();

		String sql = "SELECT c_no FROM comment WHERE c_parentFl = 1 and c_group = ?;";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, c_group);
			rs = pstmt.executeQuery();
			
			int i = 0;
			while(rs.next()){
				Long no = 0L;
				no = rs.getLong("c_no");
				nos.add(i,no);
				i++;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return nos;
	}
	
	//댓글작성
	public Long insert(Comment dto) {
		String sql = "insert into comment (c_b_no, c_m_no, c_name, "
				+ "c_img, c_content, c_parentFl) values(?,?,?,?,?,?)";
		Long id = 0L;
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, dto.getC_b_no());
			pstmt.setLong(2, dto.getC_m_no());
			pstmt.setString(3, dto.getC_name());
			pstmt.setString(4, dto.getC_img());
			pstmt.setString(5, dto.getC_content());
			pstmt.setBoolean(6, dto.getC_parentFl());
							
			pstmt.executeUpdate();	
			rs = pstmt.executeQuery("SELECT last_insert_id()");

			if (rs.next()){
				id = rs.getLong(1);
			}
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}	
		return id;
		
	}
	
	//생성된 댓글 group번호주기
	public int groupUpdate(Long cno) {
		String sql = "update comment set c_group = ? where c_no = ?";
		int process = 0;
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, cno);
			pstmt.setLong(2, cno);
							
			process = pstmt.executeUpdate();	
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		return process;
	}

	public int insertChild(Comment dto) {
		String sql = "insert into comment (c_b_no, c_m_no, c_name, "
				+ "c_img, c_content, c_group, c_parentFl) values(?,?,?,?,?,?,?)";
		int process = 0;
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, dto.getC_b_no());
			pstmt.setLong(2, dto.getC_m_no());
			pstmt.setString(3, dto.getC_name());
			pstmt.setString(4, dto.getC_img());
			pstmt.setString(5, dto.getC_content());
			pstmt.setLong(6, dto.getC_group());
			pstmt.setBoolean(7, dto.getC_parentFl());
							
			process = pstmt.executeUpdate();	
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		return process;
	}

	public int del(Long no) {
		String sql = "delete from comment where c_no = ?";
		
		int process = 0;
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, no);
			
			process = pstmt.executeUpdate();	
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	

		return process;
	}



}
