package dao.admin;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.member.Member;

public class userDAO {	
	private static userDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static userDAO getInstance(){
		if(dao == null){
			dao = new userDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	
	//리스트
	public List<Member> list(String kind, String keyword, String table, int startRow, int endRow) {
		String mode = "리스트";
		String sql = memberSearch(kind,keyword,table,startRow,endRow,mode);

		List<Member> list = new ArrayList<>();
		
		try{
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Member dto = new Member();
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
				list.add(dto);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return list;
	}
	
	
	//회원 총 수
	public int listCount(String kind, String keyword, String table, int startRow, int endRow) {
		String mode = "카운트";
		String sql = memberSearch(kind,keyword,table,startRow,endRow,mode);

		int count = 0;

		try {
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
			}	
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}	
		return count;
	}
	
	//member검색필터
	private String memberSearch(String kind, String keyword, String table, int startRow, int endRow, String mode) {
		String sql = (mode == "리스트") ? "select * from member where m_no > 0" : "select count(*) from member where m_no > 0";
		String con = "";
		
		if(!keyword.equals("")){
			if(kind.equals("회원번호")) {
				con += " and m_no like '%"+keyword+"%'";
			}else if(kind.equals("아이디")) {				
				con += " and m_id like '%"+keyword+"%'";
			}else if(kind.equals("닉네임")) {				
				con += " and m_name like '%"+keyword+"%'";
			}else if(kind.equals("학교")) {				
				con += " and m_school like '%"+keyword+"%'";
			}else if(kind.equals("지역")) {				
				con += " and m_address like '%"+keyword+"%' or m_address_sub like '%"+keyword+"%'";
			}else if(kind.equals("휴대폰번호")) {				
				con += " and m_phone like '%"+keyword+"%'";
			}else if(kind.equals("학교이메일")) {				
				con += " and m_email like '%"+keyword+"%'";
			}else if(kind.equals("상태")) {
				keyword = (keyword.equals("비활성"))?"1":"0";			
				con += " and m_state = "+keyword;
			}else if(kind.equals("요청")) {			
				keyword = (keyword.equals("가입요청"))?"0":"1";
				con += " and m_joinFl = "+keyword;
			}else if(kind.equals("경고횟수")) {		
				con += " and m_r_count = "+keyword;
			}
		}
		
		if(table.equals("탈퇴회원")) {
			con += " and m_delFl = 1";
		}else {
			con += " and m_delFl = 0";
		}
		
		if(mode == "리스트") {
			sql += con + " "+" limit "+startRow+" , "+endRow+"";
		}else if(mode == "카운트"){
			sql += con;			
		}
		
		return sql;
	}
	
	//수정
	public int mod(String val, int no, String mode) {
		int mod = 0;
		
		String sql = "update member set "+mode+"= ?,  modDt = now() where m_no =?";
				
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, val);
			pstmt.setInt(2, no);
			
			mod = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		return mod;
	}
	
	public void state(int no, String mode) {
		String sql = "";
		if(mode.equals("정지")) {			
			sql ="update member set m_state = 1 where m_no = "+no;
		}else if(mode.equals("활성")){
			sql ="update member set m_state = 0 where m_no = "+no;
		}
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.executeUpdate();		
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			commit(con);
		}	
		
	}
	
	//카운트 초기화
	public void countReset(int no) {
		String sql ="update member set m_r_count = 0 where m_no = "+no;
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.executeUpdate();				
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
			commit(con);
		}	
		
	}
	
	
	//삭제
	public int del(int no) {
		int del = 0;
		
		String sql = "delete from member where m_no = ?";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, no);

			del = pstmt.executeUpdate();						
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		
		return del;
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
	
	//등록
	public int insert(Member dto) {
		int chk = 0;

		String sql = "insert into member (m_id, m_pw, m_name, "
				+ "m_phone, m_school, m_study, m_birth, "
				+ "m_studentFl, m_joinFl) values (?,?,?,?,?,?,?,0,1);";
		
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getM_id());
			pstmt.setString(2, dto.getM_pw());
			pstmt.setString(3, dto.getM_name());
			pstmt.setString(4, dto.getM_phone());
			pstmt.setString(5, dto.getM_school());
			pstmt.setString(6, dto.getM_study());
			pstmt.setString(7, dto.getM_birth());
			chk = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return chk;
	}
	

}
