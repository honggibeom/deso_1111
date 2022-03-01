package dao.member;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.member.Member;

public class memberDAO {
	private static memberDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static memberDAO getInstance(){
		if(dao == null){
			dao = new memberDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	//로그인
	public Member memberLogin(String id, String pw) {
		Member dto = null;
		
		String sql = "select * from member where m_id=? and m_pw=? and m_delFl = 0";
		
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new Member();
				dto.setM_no(rs.getLong("m_no"));;
				dto.setM_id(rs.getString("m_id"));
				dto.setM_name(rs.getString("m_name"));
				dto.setM_age(rs.getInt("m_age"));
				dto.setM_phone(rs.getString("m_phone"));
				dto.setM_email(rs.getString("m_email"));
				dto.setM_school(rs.getString("m_school"));
				dto.setM_study(rs.getString("m_study"));
				dto.setM_birth(rs.getString("m_birth"));
				dto.setM_img1(rs.getString("m_img1"));
				dto.setM_img2(rs.getString("m_img2"));
				dto.setM_img3(rs.getString("m_img3"));
				dto.setM_img4(rs.getString("m_img4"));
				dto.setM_zipcode(rs.getString("m_zipcode"));
				dto.setM_address(rs.getString("m_address"));
				dto.setM_address_sub(rs.getString("m_address_sub"));
				dto.setM_locationX(rs.getString("m_locationX"));
				dto.setM_locationY(rs.getString("m_locationY"));
				dto.setM_about_me(rs.getString("m_about_me"));
				dto.setM_state(rs.getBoolean("m_state"));
				dto.setM_studentFl(rs.getBoolean("m_studentFl"));
				dto.setM_joinFl(rs.getBoolean("m_joinFl"));
				dto.setM_delFl(rs.getBoolean("m_delFl"));
				dto.setM_allimFl(rs.getBoolean("m_allimFl"));
				dto.setM_r_count(rs.getInt("m_r_count"));
				dto.setRegDt(rs.getTimestamp("regDt"));
				dto.setModDt(rs.getTimestamp("modDt"));
				dto.setDelDt(rs.getTimestamp("delDt"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return dto;
	}
	
	//아이디 중복확인
	public String checkId(String id) {
		String idCheck = null;
		
		String sql = "select m_id from member where m_id = ?";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			
			if(rs.next()) {
				idCheck = rs.getString(1);
			}
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}	
	
		return idCheck;
	}
	
	public String checkTel(String tel) {
		String chk = null;
		
		String sql = "select m_phone from member where m_phone = ?";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, tel);
			rs=pstmt.executeQuery();
					
			if(rs.next()) {
				chk = rs.getString(1);
			}
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}	
	
		return chk;
	}
	
	//회원가입
	public int memberJoin(String id, String pw, String name,
			String school, String study, String birth, String phone) {
		String sql = "insert into member"
				+ "(m_id, m_pw, m_name, m_school, m_study, m_birth, m_phone)"
				+ " values(?, ?, ?, ?, ?, ?, ?);";
				int join = 0;

				try {
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, pw);
					pstmt.setString(3, name);
					pstmt.setString(4, school);
					pstmt.setString(5, study);
					pstmt.setString(6, birth);
					pstmt.setString(7, phone);
									
					join = pstmt.executeUpdate();						
				}catch(SQLException se){
					se.printStackTrace();
				}finally {
					close(pstmt);
				}	
					
		return join;
	}

	//회원 학교인증 완료
	public int memberStudentConfirm(String id, String mail) {
		String sql = "update member set"
				+ " m_email = ?, m_studentFl = 1, modDt = now()"
				+ " where m_id = ?";
				int insert = 0;

				try {
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1,mail);
					pstmt.setString(2, id);		
					insert = pstmt.executeUpdate();						
				}catch(SQLException se){
					se.printStackTrace();
				}finally {
					close(pstmt);
				}	
					
		return insert;
	}
	
	public String findId(String tel) {
		String id = null;

		String sql = "select m_id from member where m_phone = ?";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, tel);
			rs=pstmt.executeQuery();
						
			if(rs.next()) {
				id = rs.getString(1);
			}
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}	
	
		return id;
	}
	
	public String getPw(Long no, String pw) {
		
		String chk = "";
		String sql = "select m_pw from member where m_no = ? and m_pw = ?";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, no);
			pstmt.setString(2, pw);
			rs=pstmt.executeQuery();
						
			if(rs.next()) {
				chk = "o";
			}
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}	
	
		return chk;
	}

	public Long findPw(String tel, String id) {
		Long no = 0L;

		String sql = "select m_no from member where m_id = ? and m_phone = ?";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, tel);
			rs=pstmt.executeQuery();
						
			if(rs.next()) {
				no = rs.getLong(1);
			}
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}	
	
		return no;
	}

	public int chenagePw(Long no, String pw) {
		String sql = "update member set"
				+ " m_pw = ?, modDt = now()"
				+ " where m_no = ?";
				int update = 0;

				try {
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, pw);
					pstmt.setLong(2, no);
					update = pstmt.executeUpdate();						
				}catch(SQLException se){
					se.printStackTrace();
				}finally {
					close(pstmt);
				}	
					
		return update;
	}
		
	//멤버
	public Member getMember(Long no) {
		Member dto = null;
		
		String sql = "select * from member where m_no=?";
		
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new Member();
				dto.setM_no(rs.getLong("m_no"));;
				dto.setM_id(rs.getString("m_id"));
				dto.setM_name(rs.getString("m_name"));
				dto.setM_age(rs.getInt("m_age"));
				dto.setM_phone(rs.getString("m_phone"));
				dto.setM_email(rs.getString("m_email"));
				dto.setM_school(rs.getString("m_school"));
				dto.setM_study(rs.getString("m_study"));
				dto.setM_birth(rs.getString("m_birth"));
				dto.setM_img1(rs.getString("m_img1"));
				dto.setM_img2(rs.getString("m_img2"));
				dto.setM_img3(rs.getString("m_img3"));
				dto.setM_img4(rs.getString("m_img4"));
				dto.setM_zipcode(rs.getString("m_zipcode"));
				dto.setM_address(rs.getString("m_address"));
				dto.setM_locationX(rs.getString("m_locationX"));
				dto.setM_locationY(rs.getString("m_locationY"));
				dto.setM_address_sub(rs.getString("m_address_sub"));
				dto.setM_about_me(rs.getString("m_about_me"));
				dto.setM_state(rs.getBoolean("m_state"));
				dto.setM_studentFl(rs.getBoolean("m_studentFl"));
				dto.setM_joinFl(rs.getBoolean("m_joinFl"));
				dto.setM_delFl(rs.getBoolean("m_delFl"));
				dto.setM_allimFl(rs.getBoolean("m_allimFl"));
				dto.setM_r_count(rs.getInt("m_r_count"));
				dto.setRegDt(rs.getTimestamp("regDt"));
				dto.setModDt(rs.getTimestamp("modDt"));
				dto.setDelDt(rs.getTimestamp("delDt"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return dto;
	}
	
	public Member getMember2(String id) {
		Member dto = null;
		
		String sql = "select * from member where m_id=?";
		
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new Member();
				dto.setM_no(rs.getLong("m_no"));;
				dto.setM_id(rs.getString("m_id"));
				dto.setM_name(rs.getString("m_name"));
				dto.setM_age(rs.getInt("m_age"));
				dto.setM_phone(rs.getString("m_phone"));
				dto.setM_email(rs.getString("m_email"));
				dto.setM_school(rs.getString("m_school"));
				dto.setM_study(rs.getString("m_study"));
				dto.setM_birth(rs.getString("m_birth"));
				dto.setM_img1(rs.getString("m_img1"));
				dto.setM_img2(rs.getString("m_img2"));
				dto.setM_img3(rs.getString("m_img3"));
				dto.setM_img4(rs.getString("m_img4"));
				dto.setM_zipcode(rs.getString("m_zipcode"));
				dto.setM_address(rs.getString("m_address"));
				dto.setM_address_sub(rs.getString("m_address_sub"));
				dto.setM_locationX(rs.getString("m_locationX"));
				dto.setM_locationY(rs.getString("m_locationY"));
				dto.setM_about_me(rs.getString("m_about_me"));
				dto.setM_state(rs.getBoolean("m_state"));
				dto.setM_studentFl(rs.getBoolean("m_studentFl"));
				dto.setM_joinFl(rs.getBoolean("m_joinFl"));
				dto.setM_delFl(rs.getBoolean("m_delFl"));
				dto.setM_allimFl(rs.getBoolean("m_allimFl"));
				dto.setM_r_count(rs.getInt("m_r_count"));
				dto.setRegDt(rs.getTimestamp("regDt"));
				dto.setModDt(rs.getTimestamp("modDt"));
				dto.setDelDt(rs.getTimestamp("delDt"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return dto;
	}
	
	
	//수정
	public int modify(Member member) {
		String sql = modifyProcess(member);
		
		int update = 0;

		try {
			pstmt=con.prepareStatement(sql);
			update = pstmt.executeUpdate();	
			
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return update;
	}

	private String modifyProcess(Member member) {
		String con = "";
		
		
		if(member.getM_id() != null && !member.getM_id().equals("")) {
			con += " m_id = '"+member.getM_id()+"',";
		}
		
		if(member.getM_pw() != null && !member.getM_pw().equals("")) {
			con += " m_pw = '"+member.getM_pw()+"',";
		}
		
		if(member.getM_name() != null && !member.getM_name().equals("")) {
			con += " m_name = '"+member.getM_name()+"',";
		}
		
		if(member.getM_age() != 0 && member.getM_age() > 0) {
			con += " m_age = "+member.getM_age()+",";
		}
		
		if(member.getM_phone() != null && !member.getM_phone().equals("")) {
			con += " m_phone = '"+member.getM_phone()+"',";
		}
		
		if(member.getM_email() != null && !member.getM_email().equals("")) {
			con += " m_email = '"+member.getM_email()+"',";
		}
		
		if(member.getM_school() != null && !member.getM_school().equals("")) {
			con += " m_school = '"+member.getM_school()+"',";
		}
		
		if(member.getM_study() != null && !member.getM_study().equals("")) {
			con += " m_study = '"+member.getM_study()+"',";
		}
		
		
		if(member.getM_birth() != null && !member.getM_birth().equals("")) {
			con += " m_birth = '"+member.getM_birth()+"',";
		}
		
		if(member.getM_img1() != null && !member.getM_img1().equals("")) {
			con += " m_img1 = '"+member.getM_img1()+"',";
		}else {
			con += " m_img1 = null,";
		}
		
		if(member.getM_img2() != null && !member.getM_img2().equals("")) {
			con += " m_img2 = '"+member.getM_img2()+"',";
		}else {
			con += " m_img2 = null,";
		}
		
		if(member.getM_img3() != null && !member.getM_img3().equals("")) {
			con += " m_img3 = '"+member.getM_img3()+"',";
		}else {
			con += " m_img3 = null,";
		}
		
		if(member.getM_img4() != null && !member.getM_img4().equals("")) {
			con += " m_img4 = '"+member.getM_img4()+"',";
		}else {
			con += " m_img4 = null,";
		}
		
		if(member.getM_zipcode() != null && !member.getM_zipcode().equals("")) {
			con += " m_zipcode = '"+member.getM_zipcode()+"',";
		}
		
		if(member.getM_address() != null && !member.getM_address().equals("")) {
			con += " m_address = '"+member.getM_address()+"',";
		}
		
		if(member.getM_address_sub() != null && !member.getM_address_sub().equals("")) {
			con += " m_address_sub = '"+member.getM_address_sub()+"',";
		}
		
		if(member.getM_locationX() != null && !member.getM_locationX().equals("")) {
			con += " m_locationX = '"+member.getM_locationX()+"',";
		}
		
		if(member.getM_locationY() != null && !member.getM_locationY().equals("")) {
			con += " m_locationY = '"+member.getM_locationY()+"',";
		}
		
		if(member.getM_about_me() != null && !member.getM_about_me().equals("")) {
			con += " m_about_me = '"+member.getM_about_me()+"',";
		}
							
		String sql = "update member set "+con+" modDt = now() where m_no = "+member.getM_no();
				
		return sql;
	}

	public int del(Long no, String content) {
		String sql = "update member set"
				+ " m_delFl = 1, del_reason = ?, modDt = now(), delDt = now()"
				+ " where m_no = ?";
		int update = 0;

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setLong(2, no);
			update = pstmt.executeUpdate();		

		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return update;
	}
	
	//회원업데이트 진행되면 해당 회원 정보 전체 업데이트
	public void attendUpdate(Long m_no) {
		String sql = "update attend as a, (select m_img1,m_name,m_no from member where m_no=?) AS m"
				   + " set a.m_img = m.m_img1, a.m_name = m.m_name where a.m_no = m.m_no";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, m_no);
			pstmt.executeUpdate();	
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			commit(con);
		}	
	
	}
	
	public void commentUpdate(Long m_no) {
		String sql = "update comment as c, (select m_img1,m_name,m_no from member where m_no=?) AS m"
				   + " set c.c_img = m.m_img1, c.c_name = m.m_name where c.c_m_no = m.m_no";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, m_no);
			pstmt.executeUpdate();	
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			commit(con);
		}	
					
		
	}
	
	public void friendUpdate(Long m_no) {
		String sql = "update friend as f, (select m_img1,m_name,m_no from member where m_no=?) AS m"
				   + " set f.f_img = m.m_img1, f.f_name = m.m_name where f.f_m_no = m.m_no";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, m_no);
			pstmt.executeUpdate();	
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			commit(con);
		}	
					
		
	}

	public int block(Long m_no, Long no) {
		String sql = "insert into block (m_no,f_no) values(?,?)";
		int process = 0;
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, m_no);
			pstmt.setLong(2, no);
			process = pstmt.executeUpdate();	
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		return process;
	}

}
