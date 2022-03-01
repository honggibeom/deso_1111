package dto.board;

import java.sql.Timestamp;

public class Board {
	private Long b_no;
	private String b_kind;
	private Long b_m_no;
	private String b_m_id;
	private String b_img1;
	private String b_img2;
	private String b_img3;
	private String b_img4;
	private String b_zipcode;
	private String b_address;
	private String b_address_sub;
	private String b_address_X;
	private String b_address_Y;
	private String b_open_chatting_url;
	private String b_category;
	private String b_p_limit;
	private int b_p_count;
	private int b_p_w_count;
	private Timestamp b_time;
	private String b_title;
	private String b_content;
	private String b_rule;
	private Boolean b_deadline_fl;
	private Boolean b_del_fl;
	private Boolean b_state;
	private int b_r_count;
	private Timestamp regDt;
	private Timestamp modDt;
	public Long getB_no() {
		return b_no;
	}
	public void setB_no(Long b_no) {
		this.b_no = b_no;
	}
	public String getB_kind() {
		return b_kind;
	}
	public void setB_kind(String b_kind) {
		this.b_kind = b_kind;
	}
	public Long getB_m_no() {
		return b_m_no;
	}
	public void setB_m_no(Long b_m_no) {
		this.b_m_no = b_m_no;
	}
	public String getB_m_id() {
		return b_m_id;
	}
	public void setB_m_id(String b_m_id) {
		this.b_m_id = b_m_id;
	}
	public String getB_img1() {
		return b_img1;
	}
	public void setB_img1(String b_img1) {
		this.b_img1 = b_img1;
	}
	public String getB_img2() {
		return b_img2;
	}
	public void setB_img2(String b_img2) {
		this.b_img2 = b_img2;
	}
	public String getB_img3() {
		return b_img3;
	}
	public void setB_img3(String b_img3) {
		this.b_img3 = b_img3;
	}
	public String getB_img4() {
		return b_img4;
	}
	public void setB_img4(String b_img4) {
		this.b_img4 = b_img4;
	}
	public String getB_zipcode() {
		return b_zipcode;
	}
	public void setB_zipcode(String b_zipcode) {
		this.b_zipcode = b_zipcode;
	}
	public String getB_address() {
		return b_address;
	}
	public void setB_address(String b_address) {
		this.b_address = b_address;
	}
	public String getB_address_sub() {
		return b_address_sub;
	}
	public void setB_address_sub(String b_address_sub) {
		this.b_address_sub = b_address_sub;
	}
	public String getB_address_X() {
		return b_address_X;
	}
	public void setB_address_X(String b_address_X) {
		this.b_address_X = b_address_X;
	}
	public String getB_address_Y() {
		return b_address_Y;
	}
	public void setB_address_Y(String b_address_Y) {
		this.b_address_Y = b_address_Y;
	}
	public String getB_open_chatting_url() {
		return b_open_chatting_url;
	}
	public void setB_open_chatting_url(String b_open_chatting_url) {
		this.b_open_chatting_url = b_open_chatting_url;
	}
	public String getB_category() {
		return b_category;
	}
	public void setB_category(String b_category) {
		this.b_category = b_category;
	}
	public String getB_p_limit() {
		return b_p_limit;
	}
	public void setB_p_limit(String b_p_limit) {
		this.b_p_limit = b_p_limit;
	}
	public int getB_p_count() {
		return b_p_count;
	}
	public void setB_p_count(int b_p_count) {
		this.b_p_count = b_p_count;
	}
	public int getB_p_w_count() {
		return b_p_w_count;
	}
	public void setB_p_w_count(int b_p_w_count) {
		this.b_p_w_count = b_p_w_count;
	}
	public Timestamp getB_time() {
		return b_time;
	}
	public void setB_time(Timestamp b_time) {
		this.b_time = b_time;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_rule() {
		return b_rule;
	}
	public void setB_rule(String b_rule) {
		this.b_rule = b_rule;
	}
	public Boolean getB_deadline_fl() {
		return b_deadline_fl;
	}
	public void setB_deadline_fl(Boolean b_deadline_fl) {
		this.b_deadline_fl = b_deadline_fl;
	}
	public Boolean getB_del_fl() {
		return b_del_fl;
	}
	public void setB_del_fl(Boolean b_del_fl) {
		this.b_del_fl = b_del_fl;
	}
	public Boolean getB_state() {
		return b_state;
	}
	public void setB_state(Boolean b_state) {
		this.b_state = b_state;
	}
	public int getB_r_count() {
		return b_r_count;
	}
	public void setB_r_count(int b_r_count) {
		this.b_r_count = b_r_count;
	}
	public Timestamp getRegDt() {
		return regDt;
	}
	public void setRegDt(Timestamp regDt) {
		this.regDt = regDt;
	}
	public Timestamp getModDt() {
		return modDt;
	}
	public void setModDt(Timestamp modDt) {
		this.modDt = modDt;
	}
	@Override
	public String toString() {
		return "Board [b_no=" + b_no + ", b_kind=" + b_kind + ", b_m_no=" + b_m_no + ", b_m_id=" + b_m_id + ", b_img1="
				+ b_img1 + ", b_img2=" + b_img2 + ", b_img3=" + b_img3 + ", b_img4=" + b_img4 + ", b_zipcode="
				+ b_zipcode + ", b_address=" + b_address + ", b_address_sub=" + b_address_sub + ", b_address_X="
				+ b_address_X + ", b_address_Y=" + b_address_Y + ", b_open_chatting_url=" + b_open_chatting_url
				+ ", b_category=" + b_category + ", b_p_limit=" + b_p_limit + ", b_p_count=" + b_p_count
				+ ", b_p_w_count=" + b_p_w_count + ", b_time=" + b_time + ", b_title=" + b_title + ", b_content="
				+ b_content + ", b_rule=" + b_rule + ", b_deadline_fl=" + b_deadline_fl + ", b_del_fl=" + b_del_fl
				+ ", b_state=" + b_state + ", b_r_count=" + b_r_count + ", regDt=" + regDt + ", modDt=" + modDt + "]";
	}
	
	
}
