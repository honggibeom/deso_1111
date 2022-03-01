package service.board.comment;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.List;

import dao.board.comment.commentDAO;
import dto.comment.Comment;

public class commentService {

	public List<Comment> list(Long no) {
		commentDAO dao = commentDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		List<Comment> comment = dao.commentList(no);
		
		close(con);
		
		return comment;
	}

	public Comment getComment(Long no) {
		commentDAO dao = commentDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Comment comment = dao.getComment(no);

		close(con);
		
		return comment;
	}

	public List<Long> childComment(Long c_group) {
		commentDAO dao = commentDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		List<Long> nos = dao.childComment(c_group);
		
		close(con);
		
		return nos;
	}
	
	//댓글
	public int insert(Comment dto) {
		commentDAO dao = commentDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int process = 0;
		
		Long cno = dao.insert(dto);
		process = dao.groupUpdate(cno);
		
		if(process > 0) {commit(con);}else {rollback(con);}
		close(con);
		
		return process;
	}
	
	//대댓글
	public int insertChild(Comment dto) {
		commentDAO dao = commentDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int process = dao.insertChild(dto);
				
		if(process > 0) {commit(con);}else {rollback(con);}
		close(con);
		
		return process;
	}

	public int del(Long no) {
		commentDAO dao = commentDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int process = dao.del(no);
		
		
		if(process > 0) {commit(con);}else {rollback(con);}
		close(con);
		
		return process;
	}

}
