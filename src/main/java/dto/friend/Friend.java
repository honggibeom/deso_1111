package dto.friend;

import java.sql.Timestamp;

public class Friend {
	private Long f_no;
	private Long m_no;
	private Long f_m_no;
	private String f_name;
	private String f_img;
	private Boolean f_fl;
	private Timestamp regDt;
	public Long getF_no() {
		return f_no;
	}
	public void setF_no(Long f_no) {
		this.f_no = f_no;
	}
	public Long getM_no() {
		return m_no;
	}
	public void setM_no(Long m_no) {
		this.m_no = m_no;
	}
	public Long getF_m_no() {
		return f_m_no;
	}
	public void setF_m_no(Long f_m_no) {
		this.f_m_no = f_m_no;
	}
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	public String getF_img() {
		return f_img;
	}
	public void setF_img(String f_img) {
		this.f_img = f_img;
	}
	public Boolean getF_fl() {
		return f_fl;
	}
	public void setF_fl(Boolean f_fl) {
		this.f_fl = f_fl;
	}
	public Timestamp getRegDt() {
		return regDt;
	}
	public void setRegDt(Timestamp regDt) {
		this.regDt = regDt;
	}
	@Override
	public String toString() {
		return "Friend [f_no=" + f_no + ", m_no=" + m_no + ", f_m_no=" + f_m_no + ", f_name=" + f_name + ", f_img="
				+ f_img + ", f_fl=" + f_fl + ", regDt=" + regDt + "]";
	}
	
	
}
