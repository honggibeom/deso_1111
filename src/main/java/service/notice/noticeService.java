package service.notice;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.List;

import dao.notice.noticeDAO;
import dto.notice.Notice;

public class noticeService {
	public List<Notice> noticeList() {
		noticeDAO dao = noticeDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
				
		List<Notice> list = dao.noticeList();
		
		close(con);
		
		return list;
	}

	public Notice getNotice(int no) {
		noticeDAO dao = noticeDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
				
		Notice dto = dao.getNotice(no);
		dao.countUp(no);
		
		commit(con); close(con);
		return dto;
	}
	

}
