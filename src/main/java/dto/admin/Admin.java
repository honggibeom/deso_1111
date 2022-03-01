package dto.admin;

import java.sql.Timestamp;

public class Admin {
	private Long admin_no;
	private String admin_id;
	private String admin_pw;
	private Timestamp regDt;
	private Timestamp modDt;
	public Long getAdmin_no() {
		return admin_no;
	}
	public void setAdmin_no(Long admin_no) {
		this.admin_no = admin_no;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getAdmin_pw() {
		return admin_pw;
	}
	public void setAdmin_pw(String admin_pw) {
		this.admin_pw = admin_pw;
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
		return "Admin [admin_no=" + admin_no + ", admin_id=" + admin_id + ", admin_pw=" + admin_pw + ", regDt=" + regDt
				+ ", modDt=" + modDt + "]";
	}
	
	
	
}
