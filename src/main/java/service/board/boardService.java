package service.board;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.board.boardDAO;
import dto.attend.Attend;
import dto.board.Board;
import dto.comment.Comment;
import dto.friend.Friend;

public class boardService {
	public List<Board> boardList(String mode, String cate, String date1, String date2) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);

		List<Board> list = dao.list(mode,cate,date1,date2);
		
		close(con);
		
		return list;
	}

	public Board getBoard(Long board_no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Board dto = dao.getBoard(board_no);
		
		close(con);
		
		return dto;
	}
	
	//내가만든 모임
	public List<Board> myboard(Long m_no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		List<Board> list = dao.myBoard(m_no);
		
		close(con);
		
		return list;
	}


	public List<Board> joinboard(Long m_no, String kind) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		List<Attend> attend = dao.joinboard(m_no);
		
		List<Board> list = new ArrayList<>();
		if(attend != null) {
			for(int i=0; i<attend.size(); i++) {
				Board dto = dao.getBoard(attend.get(i).getB_no());
				if(dto.getB_kind().equals(kind)) {					
					list.add(dto);
				}
			}
		}
		close(con);
		
		return list;	
	}

	public List<Friend> myFriend(Long m_no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		List<Friend> list = dao.myFriend(m_no);
		
		close(con);
		
		return list;
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
	
	//참가자 리스트
	public List<Attend> getAttned(Long no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		List<Attend> attend = dao.attnedList(no);
		
		close(con);
		
		return attend;
	}
	
	//댓글 리스트
	public List<Comment> getComment(Long no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		List<Comment> comment = dao.commentList(no);
		
		close(con);
		
		return comment;
	}
	
	//대기수 증가 및 감소
	public void count(int i, Long no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);	
		
		int process = dao.count(i,no);

		if(process > 0) {commit(con);}else{rollback(con);}
		
		close(con);
	}
	
	//참석한 사람 수 증가 및 감소
	public void pCount(int i, Long b_no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);	
		
		int process = dao.pCount(i,b_no);

		if(process > 0) {commit(con);}else{rollback(con);}
		
		close(con);	
	}

	public int del(Long no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);	
		
		int process = dao.del(no);
		if(process > 0) {commit(con);}else{rollback(con);}
		close(con);	
		return process;
	}
	
	//모임완료
	public int deadline(Long no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);	
		
		int process = dao.deadline(no);
		if(process > 0) {commit(con);}else{rollback(con);}
		close(con);	
		return process;
	}

	public int block(Long m_no, Long no) {
		boardDAO dao = boardDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);	
		
		int process = dao.block(m_no,no);
		if(process > 0) {commit(con);}else{rollback(con);}
		close(con);	
		return process;
	}


}
