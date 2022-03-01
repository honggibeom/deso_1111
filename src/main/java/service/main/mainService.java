package service.main;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.List;

import dao.main.mainDAO;
import dto.banner.Banner;
import dto.board.Board;

public class mainService {
	public List<Board> meetList() {
		mainDAO dao = mainDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		String kind = "모임";
		List<Board> list = dao.boardlist(kind);
		
		close(con);
		
		return list;
	}
	
	public List<Board> eventList() {
		mainDAO dao = mainDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		String kind = "행사";
		List<Board> list = dao.boardlist(kind);

		close(con);
		
		return list;
	}
	
	public Banner bannerList() {
		mainDAO dao = mainDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Banner dto = dao.bannerlist();
		
		close(con);
		
		return dto;
	}
}
