package service.admin;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.List;

import dao.admin.noticeDAO;
import dto.notice.Notice;

public class noticeService {

	public List<Notice> list(String kind, String keyword, int startRow, int endRow) {
		noticeDAO dao = noticeDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
				
		List<Notice> list = dao.list(kind,keyword,startRow,endRow);
		
		close(con);
		
		return list;
	}

	public int listCount(String kind, String keyword, int startRow, int endRow) {
		noticeDAO dao = noticeDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
				
		int count = dao.listCount(kind,keyword,startRow,endRow);
		
		close(con);
		
		return count;
	}
	
	public Notice getNotice(int no) {
		noticeDAO dao = noticeDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
				
		Notice dto = dao.getNotice(no);
		
		close(con);
		
		return dto;
	}

	public int process(int no, String id, String title, String content, int sort, String action) {
		noticeDAO dao = noticeDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int process = (action.equals("작성")? dao.insert(id,title,content,sort) : dao.update(no,title,content,sort));
		
		if(process > 0){
			commit(con);
		}else {
			rollback(con);
		}
		
		return process;
	}
}
