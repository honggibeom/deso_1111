package service.friend;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.friend.friendDAO;

public class friendService {

	public int del(Long no) {
		friendDAO dao = friendDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);		
		
		int del = dao.del(no);
		
		if(del > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return del;
	}
	
	//친구 조회
	public Long selectFriend(Long m_no, Long no) {
		friendDAO dao = friendDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);	
		
		Long fno = dao.selectFriend(m_no,no);
		
		close(con);
		
		return fno;
	}
	
	//친구 추가
	public int insert(Long fno, String name, String img, Long m_no) {
		friendDAO dao = friendDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);		
		
		int process = dao.insert(fno,name,img,m_no);
		
		if(process > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		return process;
	}

}
