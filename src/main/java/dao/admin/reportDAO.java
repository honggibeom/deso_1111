package dao.admin;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.report.Report;

public class reportDAO {
	private static reportDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static reportDAO getInstance(){
		if(dao == null){
			dao = new reportDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}

	public List<Report> list(String sort, String kind, String keyword, int startRow, int endRow) {
		
		String mode = "리스트";
		String sql = search(sort,kind,keyword,startRow,endRow,mode);
		
		List<Report> list = new ArrayList<>();
		
		try{
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Report dto = new Report();
				dto.setR_no(rs.getLong("r_no"));;
				dto.setR_kind(rs.getString("r_kind"));
				dto.setR_id(rs.getString("r_id"));
				dto.setRd_id_no(rs.getLong("rd_id_no"));
				dto.setRd_id(rs.getString("rd_id"));
				dto.setRd_board_no(rs.getLong("rd_board_no"));
				dto.setRd_board_title(rs.getString("rd_board_title"));
				dto.setR_content(rs.getString("r_content"));
				dto.setR_process(rs.getBoolean("r_process"));
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

	public int listCount(String sort, String kind, String keyword, int startRow, int endRow) {
		String mode = "카운트";
		String sql = search(sort,kind,keyword,startRow,endRow,mode);

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
	
	
	private String search(String sort, String kind, String keyword, int startRow, int endRow, String mode) {
		String sql = (mode == "리스트") ? "select * from report where r_kind = '"+sort+"'" : "select count(*) from report where r_kind = '"+sort+"'";
		String con = "";
		
		if(!keyword.equals("")){
			if(kind.equals("번호")) {
				con += " and r_no="+keyword;
			}else if(kind.equals("신고한아이디")) {				
				con += " and r_id like '%"+keyword+"%'";
			}else if(kind.equals("신고받은아이디")) {				
				con += " and rd_id like '%"+keyword+"%'";
			}else if(kind.equals("보낸날짜")) {				
				con += " and regDt like '%"+keyword+"%'"; 
			}
		}
				
		if(mode == "리스트") {
			sql += con + " "+" limit "+startRow+" , "+endRow+"";
		}else if(mode == "카운트"){
			sql += con;			
		}
		
		return sql;
	}
	
	public Report getReport(Long no) {
		String sql = "select * from report where r_no = ?";

		Report dto = new Report();
		
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				dto.setR_no(rs.getLong("r_no"));;
				dto.setR_kind(rs.getString("r_kind"));
				dto.setR_id(rs.getString("r_id"));
				dto.setRd_id_no(rs.getLong("rd_id_no"));
				dto.setRd_id(rs.getString("rd_id"));
				dto.setRd_board_no(rs.getLong("rd_board_no"));
				dto.setRd_board_title(rs.getString("rd_board_title"));
				dto.setR_content(rs.getString("r_content"));
				dto.setR_process(rs.getBoolean("r_process"));
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
	
	public int del(Long no) {
		int del = 0;
		
		String sql = "delete from report where r_no = ?";
		
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
	
	//경고횟수+
	public int report(Long id_no, Long board_no) {
		int update = 0;
		
		String sql = "";
		if(id_no > 0) {			
			sql ="update member set m_r_count = m_r_count + 1 where m_no = "+id_no;
		}else if(board_no > 0) {
			sql ="update board set b_r_count = b_r_count + 1 where b_no = "+board_no;
		}
		
		try {
			pstmt=con.prepareStatement(sql);
			update = pstmt.executeUpdate();						
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		
		return update;
	}
	
	//회원 정지, 게시판 정지
	public void state(Long id_no, Long board_no) {
		String sql = "";
	
		if(id_no > 0) {			
			sql ="update member set m_state = 1 where m_no = "+id_no;
		}else if(board_no > 0) {
			sql ="update board set b_state = 1 where b_no = "+board_no;
		}
		
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
	
	//신고게시판 처리
	public void process(Long no) {
		int update = 0;
		String sql = "update report set r_process = 1 where r_no = "+no;
		try {
			pstmt=con.prepareStatement(sql);
			update = pstmt.executeUpdate();						
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		if(update > 0){
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
	}

	public int memberReportAdd(Report r) {
		int process = 0;
		String sql = "insert into report (r_kind, r_id, rd_id_no, rd_id, r_title, r_content) values(?,?,?,?,?,?)";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, r.getR_kind());
			pstmt.setString(2, r.getR_id());
			pstmt.setLong(3, r.getRd_id_no());
			pstmt.setString(4, r.getRd_id());
			pstmt.setString(5, r.getR_title());
			pstmt.setString(6, r.getR_content());
			
			process = pstmt.executeUpdate();						
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}
		return process;
	}

	public int boardReportAdd(Report r) {
		int process = 0;
		String sql = "insert into report (r_kind, r_id, rd_board_no, rd_board_title, r_title, r_content) values(?,?,?,?,?,?)";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, r.getR_kind());
			pstmt.setString(2, r.getR_id());
			pstmt.setLong(3, r.getRd_board_no());
			pstmt.setString(4, r.getRd_board_title());
			pstmt.setString(5, r.getR_title());
			pstmt.setString(6, r.getR_content());
			process = pstmt.executeUpdate();						
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}
		return process;
	}



}
