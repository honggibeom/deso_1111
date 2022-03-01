package dao.banner;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import dto.banner.Banner;

public class bannerDAO {
	private static bannerDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static bannerDAO getInstance(){
		if(dao == null){
			dao = new bannerDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	public Banner getBanner() {
		Banner dto = null;
		
		String sql = "select * from banner where no = 1";
		try{			
			pstmt = con.prepareStatement(sql);						
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new Banner();
				dto.setImg1(rs.getString("img1"));
				dto.setImg2(rs.getString("img2"));
				dto.setImg3(rs.getString("img3"));
				dto.setLink1(rs.getString("link1"));
				dto.setLink2(rs.getString("link2"));
				dto.setLink3(rs.getString("link3"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return dto;
	}

	public int update(Banner dto) {
		int update = 0;
		String sql ="update banner set img1 = ?, img2 = ?, img3 = ?"
				+ "  where no = 1";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, dto.getImg1());
			pstmt.setString(2, dto.getImg2());
			pstmt.setString(3, dto.getImg3());
			update = pstmt.executeUpdate();	

		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		
		return update;
	}

	public int insert(Banner dto) {
		int insert = 0;
		String sql ="insert into banner (img1, img2, img3)"
				+ "  values(?,?,?)";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, dto.getImg1());
			pstmt.setString(2, dto.getImg2());
			pstmt.setString(3, dto.getImg3());
			insert = pstmt.executeUpdate();	

		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		
		return insert;
	}

}
