package service.banner;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.banner.bannerDAO;
import dto.banner.Banner;

public class bannerService {
	public Banner getBanner() {
		bannerDAO dao = bannerDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Banner dto = dao.getBanner();
		
		close(con);
		
		return dto;
	}

	public int process(Banner dto, String mode) {
		bannerDAO dao = bannerDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int process = 0;
		if(mode.equals("update")) {
			process = dao.update(dto);
		}else {
			process = dao.insert(dto);
		}
		
		if(process > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		return process;
	}

}
