package service.admin;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.List;

import dao.admin.reportDAO;
import dto.report.Report;

public class reportService {

	public List<Report> list(String sort, String kind, String keyword, int startRow, int endRow) {
		reportDAO dao = reportDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
				
		List<Report> list = dao.list(sort,kind,keyword,startRow,endRow);
		
		close(con);
		
		return list;
	}

	public int listCount(String sort, String kind, String keyword, int startRow, int endRow) {
		reportDAO dao = reportDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
				
		int count = dao.listCount(sort,kind,keyword,startRow,endRow);
		
		close(con);
		
		return count;
	}
	
	public Report getReport(Long no) {
		reportDAO dao = reportDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
				
		Report dto = dao.getReport(no);
		
		close(con);
		
		return dto;
	}

	public int del(Long no) {
		reportDAO dao = reportDAO.getInstance();
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
	
	//정지
	public int report(Long id_no, Long board_no, int count) {
		reportDAO dao = reportDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int update = dao.report(id_no,board_no);
		
		if(count == 2) {
			dao.state(id_no,board_no);
		}
			
		if(update > 0){
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return update;
	}

	public void process(Long no) {
		reportDAO dao = reportDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		dao.process(no); 				
	}

	public int insert(Report r) {
		reportDAO dao = reportDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int insert = 0;
		
		if(r.getR_kind().equals("회원")) {
			insert = dao.memberReportAdd(r);
		}else {
			insert = dao.boardReportAdd(r);
		}
		
		if(insert > 0){
			commit(con);
		}else {
			rollback(con);
		}
		
		return insert;
	}



}
