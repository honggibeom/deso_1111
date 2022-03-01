package service.member;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.member.memberDAO;
import dto.member.Member;

public class memberService {

	public Member memberLogin(String id, String pw) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Member m = dao.memberLogin(id,pw);
		
		close(con);
		
		
		return m;
	}
	
	//아이디 중복확인
	public int checkId(String id) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int msg = 1;
		String checkId = dao.checkId(id);		
		
		if(checkId == null) {
			msg = 0;
		} else {
			msg = 1;
		}
		
		close(con);
		
		return msg;
	}
	
	//휴대폰 중복확인
	public int checkTel(String tel) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int msg = 1;
		String checkTel = dao.checkTel(tel);		
		
		if(checkTel == null) {
			msg = 0;
		} else {
			msg = 1;
		}
		
		close(con);
		
		return msg;
	}
	
	//회원가입
	public int memberJoin(String id, String pw, String name, 
			String school, String study, String birth, String phone) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int insert = dao.memberJoin(id,pw,name,school,study,birth,phone); 
		
		if(insert > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return insert;
	}
	
	
	//학교 인증 완료
	public int studentConfirm(String id, String mail) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int insert = dao.memberStudentConfirm(id,mail);
		
		if(insert > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return insert;
	}

	public String findId(String tel) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		String id = dao.findId(tel);
		
		close(con);
		
		return id;
	}
	
	public String getPw(Long no, String pw) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		String chk = dao.getPw(no,pw);
		
		close(con);
		
		return chk;
	}

	public Long findPw(String tel, String id) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Long no = dao.findPw(tel,id);
		
		close(con);
		
		return no;
	}

	public int chenagePw(Long no, String pw) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int update = dao.chenagePw(no,pw);
		
		if(update > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return update;
	}
	
	public Member cookidLogin(String cookieId) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Member cookieVal = dao.getMember2(cookieId); 
		
		close(con);
		
		return cookieVal;
	}
	
	//맴버
	public Member getMember(Long no) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Member dto = dao.getMember(no); 
		
		close(con);
		
		return dto;
	}
	
	public Member getMember2(String id) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		Member dto = dao.getMember2(id); 
		
		close(con);
		
		return dto;
	}
		
	//맴버수정	
	public int modify(Member member) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int update = dao.modify(member); 
		
			
		if(update > 0){
			commit(con);
			dao.attendUpdate(member.getM_no());
			dao.commentUpdate(member.getM_no());
			dao.friendUpdate(member.getM_no());
		}else {
			rollback(con);
		}
		
		close(con);
		
		return update;
	}
	
	
	public int del(Long no, String content) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int del = dao.del(no,content); 
		
		if(del > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return del;
	}

	public int block(Long m_no, Long no) {
		memberDAO dao = memberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int process = dao.block(m_no,no); 
		
		if(process > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return process;
	}

	
}
