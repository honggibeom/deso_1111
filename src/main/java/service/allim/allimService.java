package service.allim;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.List;

import dao.allim.allimDAO;
import dto.allim.Allim;

public class allimService {

	public List<Allim> list(Long no) {
		allimDAO dao = allimDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		List<Allim> list = dao.list(no);
		
		close(con);
		
		return list;
	}
	
	//알림설정
	public void process(Long m_no, int val) {
		allimDAO dao = allimDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		dao.process(m_no,val);
	}

}
