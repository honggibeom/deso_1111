package dao.board;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.attend.Attend;
import dto.board.Board;
import dto.comment.Comment;
import dto.friend.Friend;


public class boardDAO {
	private static boardDAO dao;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public static boardDAO getInstance(){
		if(dao == null){
			dao = new boardDAO();
		}
		return dao;
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	private Board boardDTO(Board dto) throws SQLException {
		dto.setB_no(rs.getLong("b_no"));
		dto.setB_kind(rs.getString("b_kind"));
		dto.setB_m_no(rs.getLong("b_m_no"));
		dto.setB_m_id(rs.getString("b_m_id"));
		dto.setB_img1(rs.getString("b_img1"));
		dto.setB_img2(rs.getString("b_img2"));
		dto.setB_img3(rs.getString("b_img3"));
		dto.setB_img4(rs.getString("b_img4"));
		dto.setB_zipcode(rs.getString("b_zipcode"));
		dto.setB_address(rs.getString("b_address"));
		dto.setB_address_sub(rs.getString("b_address_sub"));
		dto.setB_address_X(rs.getString("b_address_X"));
		dto.setB_address_Y(rs.getString("b_address_Y"));
		dto.setB_open_chatting_url(rs.getString("b_open_chatting_url"));
		dto.setB_category(rs.getString("b_category"));
		dto.setB_p_limit(rs.getString("b_p_limit"));
		dto.setB_p_count(rs.getInt("b_p_count"));
		dto.setB_p_w_count(rs.getInt("b_p_w_count"));
		dto.setB_time(rs.getTimestamp("b_time"));
		dto.setB_title(rs.getString("b_title"));
		dto.setB_content(rs.getString("b_content"));
		dto.setB_rule(rs.getString("b_rule"));
		dto.setB_deadline_fl(rs.getBoolean("b_deadline_fl"));
		dto.setB_del_fl(rs.getBoolean("b_del_fl"));
		dto.setB_state(rs.getBoolean("b_state"));
		dto.setB_r_count(rs.getInt("b_r_count"));
		dto.setRegDt(rs.getTimestamp("regDt"));
		dto.setModDt(rs.getTimestamp("modDt"));
		return dto;
	}
	
	private Attend AttendDTO(Attend dto) throws SQLException {
		dto.setNo(rs.getLong("no"));
		dto.setB_no(rs.getLong("b_no"));
		dto.setM_no(rs.getLong("m_no"));
		dto.setM_name(rs.getString("m_name"));
		dto.setM_img(rs.getString("m_img"));
		dto.setKind(rs.getBoolean("kind"));
		dto.setRegDt(rs.getTimestamp("regDt"));
		return dto;
	}
	
	private Friend Friend(Friend dto) throws SQLException {
		dto.setF_no(rs.getLong("f_no"));
		dto.setM_no(rs.getLong("m_no"));
		dto.setF_m_no(rs.getLong("f_m_no"));
		dto.setF_name(rs.getString("f_name"));
		dto.setF_img(rs.getString("f_img"));
		dto.setF_fl(rs.getBoolean("f_fl"));
		dto.setRegDt(rs.getTimestamp("regDt"));
		return dto;
	}
	
	private Comment CommentDTO(Comment dto) throws SQLException {
		dto.setC_no(rs.getLong("c_no"));
		dto.setC_b_no(rs.getLong("c_b_no"));
		dto.setC_m_no(rs.getLong("c_m_no"));
		dto.setC_name(rs.getString("c_name"));
		dto.setC_img(rs.getString("c_img"));
		dto.setC_content(rs.getString("c_content"));
		dto.setC_parentFl(rs.getBoolean("c_parentFl"));
		dto.setC_group(rs.getLong("c_group"));
		dto.setC_del_fl(rs.getBoolean("c_del_fl"));
		dto.setRegDt(rs.getTimestamp("regDt"));
		return dto;
	}

	public List<Board> list(String mode, String cate, String date1, String date2) {
		List<Board> list = new ArrayList<>();
		String sql = filter(mode,cate,date1,date2);

		try{			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Board dto = new Board();
				dto = boardDTO(dto);
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
	
	
	private String filter(String mode,  String cate, String date1, String date2) {
		String sql = "select * from board where b_del_fl = 0 and b_state = 0 and b_kind = '"+mode+"'";
		String con = "";
						
		if(cate != null && !cate.equals("")) {
			con += " and b_category = '"+cate+"'";
		}
		
		if((date1 != null && !date1.equals("")) && (date2 != null && !date2.equals(""))) {
			con += " and b_time >= '"+date1+"' and b_time <= '"+date2+"'";
		}
		
			
		sql += con + " order by regDt desc";
		
		return sql;
	}

	public Board getBoard(Long board_no) {
		Board dto = new Board();
		
		String sql = "select * from board where b_no = ?";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, board_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = boardDTO(dto);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return dto;
	}

	public List<Board> myBoard(Long m_no) {
		List<Board> list = new ArrayList<>();

		String sql = "select * from board where b_m_no = ? order by regDt desc";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, m_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Board dto = new Board();
				dto = boardDTO(dto);
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
	
	//내가 참여중인 게시판
	public List<Attend> joinboard(Long m_no) {
		List<Attend> list = new ArrayList<>();

		String sql = "select * from attend where m_no = ?";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, m_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Attend dto = new Attend();
				dto = AttendDTO(dto);
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
	
	//attendList
	public List<Attend> attnedList(Long no) {
		List<Attend> list = new ArrayList<>();

		String sql = "select * from attend where b_no = ?";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Attend dto = new Attend();
				dto = AttendDTO(dto);
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
	
	public List<Comment> commentList(Long no) {
		List<Comment> list = new ArrayList<>();

		String sql = "select * from comment where c_b_no = ?";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Comment dto = new Comment();
				dto = CommentDTO(dto);
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

	public List<Friend> myFriend(Long m_no) {
		List<Friend> list = new ArrayList<>();

		String sql = "select * from friend where m_no = ?";
		try{			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, m_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Friend dto = new Friend();
				dto = Friend(dto);
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

	public Long insert(Board dto) {
		String sql = "insert into board (b_kind, b_m_no, b_m_id , b_img1, b_img2,"
				+ " b_img3, b_img4, b_address, b_address_sub, b_address_X,"
				+ " b_address_Y, b_open_chatting_url,"
				+ " b_category, b_p_limit, b_time, b_title, b_content, b_rule)"
				+ " value(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
		Long id = 0L;
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, dto.getB_kind());
			pstmt.setLong(2, dto.getB_m_no());
			pstmt.setString(3, dto.getB_m_id());
			pstmt.setString(4, dto.getB_img1());
			pstmt.setString(5, dto.getB_img2());
			pstmt.setString(6, dto.getB_img3());
			pstmt.setString(7, dto.getB_img4());
			pstmt.setString(8, dto.getB_address());
			pstmt.setString(9, dto.getB_address_sub());
			pstmt.setString(10, dto.getB_address_X());
			pstmt.setString(11, dto.getB_address_Y());
			pstmt.setString(12, dto.getB_open_chatting_url());
			pstmt.setString(13, dto.getB_category());
			pstmt.setString(14, dto.getB_p_limit());
			pstmt.setTimestamp(15, dto.getB_time());
			pstmt.setString(16, dto.getB_title());
			pstmt.setString(17, dto.getB_content());
			pstmt.setString(18, dto.getB_rule());
							
			pstmt.executeUpdate();	
			rs = pstmt.executeQuery("SELECT last_insert_id()");

			if (rs.next()){
				id = rs.getLong(1);
			}
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
		return id;
	}

	public int update(Board dto) {
		int update = 0;
		String sql = modifyProcess(dto);

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
	
	private String modifyProcess(Board dto) {
		String con = "";
								
		if(dto.getB_img1() != null && !dto.getB_img1().equals("")) {
			con += " b_img1 = '"+dto.getB_img1()+"',";
		}else {
			con += " b_img1 = '',";
		}
		
		if(dto.getB_img2() != null && !dto.getB_img2().equals("")) {
			con += " b_img2 = '"+dto.getB_img2()+"',";
		}else {
			con += " b_img2 = '',";
		}
		
		if(dto.getB_img3() != null && !dto.getB_img3().equals("")) {
			con += " b_img3 = '"+dto.getB_img3()+"',";
		}else {
			con += " b_img3 = '',";
		}
		
		if(dto.getB_img4() != null && !dto.getB_img4().equals("")) {
			con += " b_img4 = '"+dto.getB_img4()+"',";
		}else {
			con += " b_img4 = '',";
		}
		
		if(dto.getB_address() != null && !dto.getB_address().equals("")) {
			con += " b_address = '"+dto.getB_address()+"',";
		}
		
		if(dto.getB_address_sub() != null && !dto.getB_address_sub().equals("")) {
			con += " b_address_sub = '"+dto.getB_address_sub()+"',";
		}
		
		if(dto.getB_address_X() != null && !dto.getB_address_X().equals("")) {
			con += " b_address_X = '"+dto.getB_address_X()+"',";
		}
		
		if(dto.getB_address_Y() != null && !dto.getB_address_Y().equals("")) {
			con += " b_address_Y = '"+dto.getB_address_Y()+"',";
		}
		
		if(dto.getB_open_chatting_url() != null && !dto.getB_open_chatting_url().equals("")) {
			con += " b_open_chatting_url = '"+dto.getB_open_chatting_url()+"',";
		}
		
		if(dto.getB_category() != null && !dto.getB_category().equals("")) {
			con += " b_category = '"+dto.getB_category()+"',";
		}
		
		
		if(dto.getB_p_limit() != null && !dto.getB_p_limit().equals("")) {
			con += " b_p_limit = '"+dto.getB_p_limit()+"',";
		}
				
		if(dto.getB_time() != null) {
			con += " b_time = '"+dto.getB_time()+"',";
		}
		
		if(dto.getB_title() != null && !dto.getB_title().equals("")) {
			con += " b_title = '"+dto.getB_title()+"',";
		}
		
		if(dto.getB_content() != null && !dto.getB_content().equals("")) {
			con += " b_content = '"+dto.getB_content()+"',";
		}
		
		if(dto.getB_rule() != null && !dto.getB_rule().equals("")) {
			con += " b_rule = '"+dto.getB_rule()+"',";
		}
		
		if(dto.getB_deadline_fl() != null) {
			con += " b_deadline_fl = "+dto.getB_deadline_fl()+",";
		}
		
		
		if(dto.getB_del_fl() != null) {
			con += " b_del_fl = "+dto.getB_del_fl()+",";
		}
		
		if(dto.getB_state() != null) {
			con += " b_state = "+dto.getB_state()+",";
		}
		
		if(dto.getB_r_count() > -1) {
			con += " b_r_count = "+dto.getB_r_count()+",";
		}
		
		String sql = "update board set "+con+" modDt = now() where b_no = "+dto.getB_no();
				
		return sql;
	}
	
	//대기자 감소 및 증가
	public int count(int i, Long no) {
		int process = 0;
		String sql = "update board set b_p_w_count= b_p_w_count + ? where b_no = ?";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, i);
			pstmt.setLong(2, no);
				
			process = pstmt.executeUpdate();				
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return process;
	}

	public int pCount(int i, Long b_no) {
		int process = 0;
		String sql = "update board set b_p_count= b_p_count + ? where b_no = ?";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, i);
			pstmt.setLong(2, b_no);
				
			process = pstmt.executeUpdate();				
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return process;
	}

	public int del(Long no) {
		int process = 0;
		String sql = "update board set b_del_fl = 1 where b_no = ?";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, no);
				
			process = pstmt.executeUpdate();				
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return process;
	}

	public int deadline(Long no) {
		int process = 0;
		String sql = "update board set b_deadline_fl = 1 where b_no = ?";

		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setLong(1, no);
				
			process = pstmt.executeUpdate();				
		}catch(SQLException se){
			se.printStackTrace();
		}finally {
			close(pstmt);
		}	
					
		return process;
	}

	public int block(Long m_no, Long no) {
		String sql = "insert into block (m_no,b_no) values(?,?)";
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
