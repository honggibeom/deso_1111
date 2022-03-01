package service.admin;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.List;

import dao.admin.boardDAO;
import dto.board.Board;

public class boardService {

	public List<Board> list(String mode, String kind, String keyword, int startRow, int endRow) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		List<Board> list = dao.list(mode,kind,keyword,startRow,endRow);
		
		close(con);
		
		return list;
	}

	public int count(String mode, String kind, String keyword, int startRow, int endRow) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int count = dao.count(mode,kind,keyword,startRow,endRow);
		
		close(con);
		
		return count;
	}
	
	public Long process(Board dto, String mode) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);

		Long process = 0L;
		if(mode.equals("new")) {
			process = dao.insert(dto);
		}else {
			process = Long.valueOf(dao.update(dto));
		}

		if(process > 0) {commit(con);}else{rollback(con);}
		
		close(con);
		
		return process;
	}

	public int del(Long no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int del = dao.del(no);
		
		if(del > 0) {commit(con);} else { rollback(con); }
		
		close(con);
		
		return del;
	}


}
