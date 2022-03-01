package dao.main;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.banner.Banner;
import dto.board.Board;


public class mainDAO {
	private static mainDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static mainDAO getInstance(){
		if(dao == null){
			dao = new mainDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	
	public List<Board> boardlist(String kind) {
		List<Board> list = new ArrayList<>();
		Board dto = null;
		String sql = "";
		if(kind.equals("모임")) {
			sql = "select * from board where b_kind=? and b_del_fl = 0 and b_state = 0 order by regDt desc limit 0,4";
		}else if(kind.equals("행사")) {
			sql = "select * from board where b_kind=? and b_del_fl = 0 and b_state = 0 order by regDt desc";
		}
	
		try{			
			pstmt = con.prepareStatement(sql);	
			pstmt.setString(1,kind);
			rs = pstmt.executeQuery();
			while(rs.next()){
				dto = new Board();
				dto.setB_no(rs.getLong("b_no"));
				dto.setB_kind(rs.getString("b_kind"));
				dto.setB_m_no(rs.getLong("b_m_no"));
				dto.setB_img1(rs.getString("b_img1"));
				dto.setB_img2(rs.getString("b_img2"));
				dto.setB_img3(rs.getString("b_img3"));
				dto.setB_img4(rs.getString("b_img4"));
				dto.setB_zipcode(rs.getString("b_zipcode"));
				dto.setB_address(rs.getString("b_address"));
				dto.setB_address_sub(rs.getString("b_address_sub"));
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
	
	
	public Banner bannerlist() {
		Banner dto = new Banner();
		
		String sql = "select * from banner where no = 1";
		try{			
			pstmt = con.prepareStatement(sql);						
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto.setImg1(rs.getString("img1"));
				dto.setLink1(rs.getString("link1"));
				dto.setImg2(rs.getString("img2"));
				dto.setLink2(rs.getString("link2"));
				dto.setImg3(rs.getString("img3"));
				dto.setLink3(rs.getString("link3"));				
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return dto;
	}
}
