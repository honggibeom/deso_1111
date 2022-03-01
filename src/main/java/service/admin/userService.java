package service.admin;

import static db.JdbcUtil.*;


import java.sql.Connection;
import java.util.List;

import dao.admin.userDAO;
import dao.member.memberDAO;
import dto.member.Member;


public class userService {

	public List<Member> list(String kind, String keyword, String table, int startRow, int endRow) {
		userDAO dao = userDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
				
		List<Member> list = dao.list(kind,keyword,table,startRow,endRow);
		
		close(con);
		
		return list;
	}

	public int listCount(String kind, String keyword, String table, int startRow, int endRow) {
		userDAO dao = userDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int count = dao.listCount(kind,keyword,table,startRow,endRow);
		
		close(con);
		
		return count;
	}
	
	
	//수정
	public int mod(String val, int no, String mode) {
		userDAO dao = userDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		if(mode.equals("상태")) {
			mode = "m_state";
		}else if(mode.equals("요청")) {
			mode = "m_joinFl";
		}else if(mode.equals("경고횟수")) {
			mode = "m_r_count";
		}

		int mod = dao.mod(val,no,mode);
				
		if(mod > 0) {
			
			if(mode.equals("m_state") && val.equals("0")) {
				//회원정지 해제
				dao.countReset(no);
			}else if(mode.equals("m_r_count") && val.equals("3")) {
				//회원정지
				dao.state(no,"정지");
			}else if(mode.equals("m_r_count") && !val.equals("3")){
				dao.state(no,"활성");
			}
			
			
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return mod;
	}
	

	//멤버삭제
	public int del(int no) {
		userDAO dao = userDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int del = dao.del(no); 
		
		if(del > 0){
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return del;
		
	}
		
	//맴버수정	
	public int modify(Member member) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int del = dao.modify(member); 
		
		if(del > 0){
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return del;
	}
	
	//맴버등록
	public int memberInsert(Member dto) {
		userDAO dao = userDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		String id = dao.checkId(dto.getM_id());
		String phone = dao.checkTel(dto.getM_phone());
		
		int msg = 0;
		if(id != null) {			
			msg = 1; 
		}else if(phone != null){
			msg = 2;
		}else {
			int insert = dao.insert(dto);
			if(insert > 0){
				msg = 3;
				commit(con);
			}else {
				rollback(con);
			}
		}
		
		
		close(con);
		
		return msg;
	}

			

}
