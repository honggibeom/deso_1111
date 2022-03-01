package dao.allim;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.allim.Allim;

public class allimDAO {
	private static allimDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static allimDAO getInstance(){
		if(dao == null){
			dao = new allimDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}

	public List<Allim> list(Long no) {
		List<Allim> list = new ArrayList<>();

		String sql = "select * from allim where m_no = ? order by regDt desc";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Allim dto = new Allim();
				dto.setNo(rs.getLong("no"));
				dto.setM_no(rs.getLong("m_no"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setHref(rs.getString("href"));
				dto.setRead(rs.getBoolean("read"));
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
	
	//알림설정
	public void process(Long m_no, int val) {
		String sql = "update member set m_allimFl = ? where m_no=?";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, val);
			pstmt.setLong(2, m_no);
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			commit(con);
		}
	}
}
