package service.admin;

import static db.JdbcUtil.close;
import static db.JdbcUtil.*;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.admin.adminDAO;
import dto.admin.Admin;

public class adminService {

	//로그인
	public Admin login(String id, String pw) {
		
		adminDAO dao = adminDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Admin dto = dao.adminLogin(id, pw);
		
		close(con);
		
		return dto;
	}
	
	//수정
	public int adminModify(Admin admin, String newPw) {
		adminDAO dao = adminDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);		
		
		int mod = dao.adminModify(admin,newPw);
		
		if(mod > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return mod;
	}
	
	//다중삭제
	public int mutlDel(String mode, int no) {
		adminDAO dao = adminDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);		
		
		String key = "";
		
		if(mode.equals("member")) {
			key = "m_no";
		}else if(mode.equals("board")) {
			key = "b_no";
		}else if(mode.equals("notice")) {
			key = "n_no";
		}else if(mode.equals("report")) {
			key = "r_no";
		}
		
		int del = dao.mutldel(mode,no,key);
		
		if(del > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return del;
	}
	

}
