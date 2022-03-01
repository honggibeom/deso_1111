package service.board.attend;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;
import java.util.List;

import dao.board.attend.attendDAO;
import dto.attend.Attend;

public class attendService {
	
	private void dbConn(int process, Connection con) {
		if(process > 0) {commit(con);}else {rollback(con);}	
	}
	
	//참석
	public int attend(Long no, Long m_no, String name, String img, String kind) {
		attendDAO dao = attendDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);		
		
		int process = 0;
		if(kind.equals("모임")) {			
			process = dao.attend(no, m_no, name, img);
		}else {
			process = dao.eventAttend(no, m_no, name, img);
		}
				
		dbConn(process,con);
		
		close(con);
		
		return process;
	}
	
	//참석취소
	public int unAttend(Long no, Long m_no) {
		attendDAO dao = attendDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int process = dao.unAttend(no,m_no);

		dbConn(process,con);
		
		close(con);
		
		return process;
	}
	
	public List<Attend> list(Long no, int state) {
		attendDAO dao = attendDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		List<Attend> list = dao.list(no,state);
		
		close(con);
		
		return list;
	}
	
	//대기자 수락
	public int state(Long no) {
		attendDAO dao = attendDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int process = dao.state(no);

		dbConn(process,con);
		
		close(con);
		
		return process;
	}
	
	//대기자 삭제
	public int unState(Long no) {
		attendDAO dao = attendDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int process = dao.unState(no);

		dbConn(process,con);
		
		close(con);
		
		return process;
	}


}
