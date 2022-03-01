package dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dto.admin.Admin;


public class adminDAO {
	private static adminDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static adminDAO getInstance(){
		if(dao == null){
			dao = new adminDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	//로그인
	public Admin adminLogin(String id, String pw) {
		Admin dto = null;
		
		String sql = "select * from admin where admin_id=? and admin_pw=?";
		
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new Admin();
				dto.setAdmin_no(rs.getLong("admin_no"));
				dto.setAdmin_id(rs.getString("admin_id"));
				dto.setAdmin_pw(rs.getString("admin_pw"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return dto;
	}
	
	
	//수정
	public int adminModify(Admin admin, String newPw) {
		int mod = 0;
		
		String sql = "update admin set admin_pw=?, modDt = now() where admin_no=?";
		
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, newPw);
			pstmt.setLong(2, admin.getAdmin_no());
			
			mod = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}

		return mod;
	}
	
	//다중삭제
	public int mutldel(String mode, int no, String key) {
		int del = 0;
				
		String sql = "delete from "+mode+" where "+key+" = ?";

		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			del = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}

		return del;
	}
	

}
