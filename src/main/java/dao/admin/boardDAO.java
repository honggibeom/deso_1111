package dao.admin;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import dto.board.Board;


public class boardDAO {
	private static boardDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static boardDAO getInstance(){
		if(dao == null){
			dao = new boardDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	private Board boardDTO(Board dto) throws SQLException {
		dto.setB_no(rs.getLong("b_no"));
		dto.setB_kind(rs.getString("b_kind"));
		dto.setB_m_no(rs.getLong("b_m_no"));
		dto.setB_m_id(rs.getString("b_m_id"));
		dto.setB_img1(rs.getString("b_img1"));
		dto.setB_img2(rs.getString("b_img2"));
		dto.setB_img3(rs.getString("b_img3"));
		dto.setB_img4(rs.getString("b_img4"));
		dto.setB_zipcode(rs.getString("b_zipcode"));
		dto.setB_address(rs.getString("b_address"));
		dto.setB_address_sub(rs.getString("b_address_sub"));
		dto.setB_address_X(rs.getString("b_address_X"));
		dto.setB_address_Y(rs.getString("b_address_Y"));
		dto.setB_open_chatting_url(rs.getString("b_open_chatting_url"));
		dto.setB_category(rs.getString("b_category"));
		dto.setB_p_limit(rs.getString("b_p_limit"));
		dto.setB_p_count(rs.getInt("b_p_count"));
		dto.setB_p_w_count(rs.getInt("b_p_w_count"));
		dto.setB_time(rs.getTimestamp("b_time"));
		dto.setB_title(rs.getString("b_title"));
		dto.setB_content(rs.getString("b_content"));
		dto.setB_rule(rs.getString("b_rule"));
		dto.setB_deadline_fl(rs.getBoolean("b_deadline_fl"));
		dto.setB_del_fl(rs.getBoolean("b_del_fl"));
		dto.setB_state(rs.getBoolean("b_state"));
		dto.setB_r_count(rs.getInt("b_r_count"));
		dto.setRegDt(rs.getTimestamp("regDt"));
		dto.setModDt(rs.getTimestamp("modDt"));
		return dto;
	}
	
	
	public List<Board> list(String mode, String kind, String keyword, int startRow, int endRow) {
		List<Board> list = new ArrayList<Board>();
		String sql = filter(mode,kind,keyword,startRow,endRow,"list");
		
		try{			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Board dto = new Board();
				dto = boardDTO(dto);			
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
	
	public int count(String mode, String kind, String keyword, int startRow, int endRow) {
		int count = 0;
		String sql = filter(mode,kind,keyword,startRow,endRow,"count");
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
	

	private String filter(String mode, String kind, String keyword, int startRow, int endRow, String string) {
		String sql = (string.equals("list"))?"select * from board where b_kind = '"+mode+"'":"select count(*) from board where b_kind = '"+mode+"'";
		String con = "";
		
		if(!keyword.equals("")){
			if(kind.equals("주최자아이디")) {
				con += " and b_m_id like '%"+keyword+"%'";
			}else if(kind.equals("카테고리")) {				
				con += " and b_category = '"+keyword+"'";
			}else if(kind.equals("위치")) {				
				con += " and b_address like '%"+keyword+"%'";
			}else if(kind.equals("시간/날짜")) {				
				con += " and b_time like '%"+keyword+"%'";
			}else if(kind.equals("인원")) {				
				con += " and b_p_limit ="+keyword;
			}else if(kind.equals(mode+"명")) {				
				con += " and b_title like '%"+keyword+"%'";
			}
		}
		if(string.equals("list")){			
			sql += con + " order by regDt desc "+" limit "+startRow+" , "+endRow+"";
		}else {
			sql += con;
		}
			
		return sql;
	}
	
	public Long insert(Board dto) {
		String sql = "insert into board (b_kind, b_m_id , b_img1, b_img2,"
				+ " b_img3, b_img4, b_address, b_address_sub, b_address_X,"
				+ " b_address_Y, b_open_chatting_url,"
				+ " b_category, b_p_limit, b_time, b_title, b_content, b_rule)"
				+ " value(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
		Long id = 0L;
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, dto.getB_kind());
			pstmt.setString(2, dto.getB_m_id());
			pstmt.setString(3, dto.getB_img1());
			pstmt.setString(4, dto.getB_img2());
			pstmt.setString(5, dto.getB_img3());
			pstmt.setString(6, dto.getB_img4());
			pstmt.setString(7, dto.getB_address());
			pstmt.setString(8, dto.getB_address_sub());
			pstmt.setString(9, dto.getB_address_X());
			pstmt.setString(10, dto.getB_address_Y());
			pstmt.setString(11, dto.getB_open_chatting_url());
			pstmt.setString(12, dto.getB_category());
			pstmt.setString(13, dto.getB_p_limit());
			pstmt.setTimestamp(14, dto.getB_time());
			pstmt.setString(15, dto.getB_title());
			pstmt.setString(16, dto.getB_content());
			pstmt.setString(17, dto.getB_rule());
							
			pstmt.executeUpdate();	
			rs = pstmt.executeQuery("SELECT last_insert_id()");

			if (rs.next()){
				id = rs.getLong(1);
			}
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		return id;
	}

	public int update(Board dto) {
		int update = 0;
		String sql = modifyProcess(dto);

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
	
	private String modifyProcess(Board dto) {
		String con = "";
								
		if(dto.getB_img1() != null && !dto.getB_img1().equals("")) {
			con += " b_img1 = '"+dto.getB_img1()+"',";
		}else {
			con += " b_img1 = '',";
		}
		
		if(dto.getB_img2() != null && !dto.getB_img2().equals("")) {
			con += " b_img2 = '"+dto.getB_img2()+"',";
		}else {
			con += " b_img2 = '',";
		}
		
		if(dto.getB_img3() != null && !dto.getB_img3().equals("")) {
			con += " b_img3 = '"+dto.getB_img3()+"',";
		}else {
			con += " b_img3 = '',";
		}
		
		if(dto.getB_img4() != null && !dto.getB_img4().equals("")) {
			con += " b_img4 = '"+dto.getB_img4()+"',";
		}else {
			con += " b_img4 = '',";
		}
		
		if(dto.getB_address() != null && !dto.getB_address().equals("")) {
			con += " b_address = '"+dto.getB_address()+"',";
		}
		
		if(dto.getB_address_sub() != null && !dto.getB_address_sub().equals("")) {
			con += " b_address_sub = '"+dto.getB_address_sub()+"',";
		}
		
		if(dto.getB_address_X() != null && !dto.getB_address_X().equals("")) {
			con += " b_address_X = '"+dto.getB_address_X()+"',";
		}
		
		if(dto.getB_address_Y() != null && !dto.getB_address_Y().equals("")) {
			con += " b_address_Y = '"+dto.getB_address_Y()+"',";
		}
		
		if(dto.getB_open_chatting_url() != null && !dto.getB_open_chatting_url().equals("")) {
			con += " b_open_chatting_url = '"+dto.getB_open_chatting_url()+"',";
		}
		
		if(dto.getB_category() != null && !dto.getB_category().equals("")) {
			con += " b_category = '"+dto.getB_category()+"',";
		}
		
		
		if(dto.getB_p_limit() != null && !dto.getB_p_limit().equals("")) {
			con += " b_p_limit = '"+dto.getB_p_limit()+"',";
		}
				
		if(dto.getB_time() != null) {
			con += " b_time = '"+dto.getB_time()+"',";
		}
		
		if(dto.getB_title() != null && !dto.getB_title().equals("")) {
			con += " b_title = '"+dto.getB_title()+"',";
		}
		
		if(dto.getB_content() != null && !dto.getB_content().equals("")) {
			con += " b_content = '"+dto.getB_content()+"',";
		}
		
		if(dto.getB_rule() != null && !dto.getB_rule().equals("")) {
			con += " b_rule = '"+dto.getB_rule()+"',";
		}
		
		if(dto.getB_deadline_fl() != null) {
			con += " b_deadline_fl = "+dto.getB_deadline_fl()+",";
		}
		
		
		if(dto.getB_del_fl() != null) {
			con += " b_del_fl = "+dto.getB_del_fl()+",";
		}
		
		if(dto.getB_state() != null) {
			con += " b_state = "+dto.getB_state()+",";
		}
		
		if(dto.getB_r_count() > -1) {
			con += " b_r_count = "+dto.getB_r_count()+",";
		}
		
		String sql = "update board set "+con+" modDt = now() where b_no = "+dto.getB_no();
				
		return sql;
	}


	public int del(Long no) {
		int del = 0;
		String sql = "delete from board where b_no = ?";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			
			del = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return del;
	}
	
}
