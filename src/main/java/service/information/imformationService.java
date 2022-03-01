package service.information;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.List;

import dao.information.informationDAO;
import dto.information.Information;

public class imformationService {

	public List<Information> list() {
		informationDAO dao = informationDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		List<Information> list = dao.list();
		
		close(con);
		
		return list;
	}

	public Information getInformation(Long no) {
		informationDAO dao = informationDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Information dto = dao.getInformation(no);
		
		close(con);
		
		return dto;
	}

	public void process(Information info, String mode) {
		informationDAO dao = informationDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int process = 0;
		if(mode.equals("insert")) {
			process = dao.insert(info);
		}else {			
			process = dao.update(info.getI_no(),info.getI_content());
		}
		
		if(process > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
	}

	public void del(Long no) {
		informationDAO dao = informationDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		dao.del(no);
	}


}
