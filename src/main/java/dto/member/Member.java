package dto.member;

import java.sql.Timestamp;

public class Member {
	private Long m_no;
	private String m_id;
	private String m_pw;
	private String m_name;
	private int m_age;
	private String m_phone;
	private String m_email;
	private String m_school;
	private String m_study;
	private String m_birth;
	private String m_img1;
	private String m_img2;
	private String m_img3;
	private String m_img4;
	private String m_zipcode;
	private String m_address;
	private String m_address_sub;
	private String m_locationX;
	private String m_locationY;
	private String m_about_me;
	private Boolean m_state;
	private Boolean m_studentFl;
	private Boolean m_joinFl;
	private Boolean m_delFl;
	private Boolean m_allimFl;
	private int m_r_count;
	private String del_reason;
	private Timestamp regDt;
	private Timestamp modDt;
	private Timestamp delDt;
	public Long getM_no() {
		return m_no;
	}
	public void setM_no(Long m_no) {
		this.m_no = m_no;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_pw() {
		return m_pw;
	}
	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public int getM_age() {
		return m_age;
	}
	public void setM_age(int m_age) {
		this.m_age = m_age;
	}
	public String getM_phone() {
		return m_phone;
	}
	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}
	public String getM_email() {
		return m_email;
	}
	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
	public String getM_school() {
		return m_school;
	}
	public void setM_school(String m_school) {
		this.m_school = m_school;
	}
	public String getM_study() {
		return m_study;
	}
	public void setM_study(String m_study) {
		this.m_study = m_study;
	}
	public String getM_birth() {
		return m_birth;
	}
	public void setM_birth(String m_birth) {
		this.m_birth = m_birth;
	}
	public String getM_img1() {
		return m_img1;
	}
	public void setM_img1(String m_img1) {
		this.m_img1 = m_img1;
	}
	public String getM_img2() {
		return m_img2;
	}
	public void setM_img2(String m_img2) {
		this.m_img2 = m_img2;
	}
	public String getM_img3() {
		return m_img3;
	}
	public void setM_img3(String m_img3) {
		this.m_img3 = m_img3;
	}
	public String getM_img4() {
		return m_img4;
	}
	public void setM_img4(String m_img4) {
		this.m_img4 = m_img4;
	}
	public String getM_zipcode() {
		return m_zipcode;
	}
	public void setM_zipcode(String m_zipcode) {
		this.m_zipcode = m_zipcode;
	}
	public String getM_address() {
		return m_address;
	}
	public void setM_address(String m_address) {
		this.m_address = m_address;
	}
	public String getM_address_sub() {
		return m_address_sub;
	}
	public void setM_address_sub(String m_address_sub) {
		this.m_address_sub = m_address_sub;
	}
	public String getM_locationX() {
		return m_locationX;
	}
	public void setM_locationX(String m_locationX) {
		this.m_locationX = m_locationX;
	}
	public String getM_locationY() {
		return m_locationY;
	}
	public void setM_locationY(String m_locationY) {
		this.m_locationY = m_locationY;
	}
	public String getM_about_me() {
		return m_about_me;
	}
	public void setM_about_me(String m_about_me) {
		this.m_about_me = m_about_me;
	}
	public Boolean getM_state() {
		return m_state;
	}
	public void setM_state(Boolean m_state) {
		this.m_state = m_state;
	}
	public Boolean getM_studentFl() {
		return m_studentFl;
	}
	public void setM_studentFl(Boolean m_studentFl) {
		this.m_studentFl = m_studentFl;
	}
	public Boolean getM_joinFl() {
		return m_joinFl;
	}
	public void setM_joinFl(Boolean m_joinFl) {
		this.m_joinFl = m_joinFl;
	}
	public Boolean getM_delFl() {
		return m_delFl;
	}
	public void setM_delFl(Boolean m_delFl) {
		this.m_delFl = m_delFl;
	}
	public Boolean getM_allimFl() {
		return m_allimFl;
	}
	public void setM_allimFl(Boolean m_allimFl) {
		this.m_allimFl = m_allimFl;
	}
	public int getM_r_count() {
		return m_r_count;
	}
	public void setM_r_count(int m_r_count) {
		this.m_r_count = m_r_count;
	}
	public String getDel_reason() {
		return del_reason;
	}
	public void setDel_reason(String del_reason) {
		this.del_reason = del_reason;
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
	public Timestamp getDelDt() {
		return delDt;
	}
	public void setDelDt(Timestamp delDt) {
		this.delDt = delDt;
	}
	@Override
	public String toString() {
		return "Member [m_no=" + m_no + ", m_id=" + m_id + ", m_pw=" + m_pw + ", m_name=" + m_name + ", m_age=" + m_age
				+ ", m_phone=" + m_phone + ", m_email=" + m_email + ", m_school=" + m_school + ", m_study=" + m_study
				+ ", m_birth=" + m_birth + ", m_img1=" + m_img1 + ", m_img2=" + m_img2 + ", m_img3=" + m_img3
				+ ", m_img4=" + m_img4 + ", m_zipcode=" + m_zipcode + ", m_address=" + m_address + ", m_address_sub="
				+ m_address_sub + ", m_locationX=" + m_locationX + ", m_locationY=" + m_locationY + ", m_about_me="
				+ m_about_me + ", m_state=" + m_state + ", m_studentFl=" + m_studentFl + ", m_joinFl=" + m_joinFl
				+ ", m_delFl=" + m_delFl + ", m_allimFl=" + m_allimFl + ", m_r_count=" + m_r_count + ", del_reason="
				+ del_reason + ", regDt=" + regDt + ", modDt=" + modDt + ", delDt=" + delDt + "]";
	}
	
	

	
	
}
