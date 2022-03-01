package dto.information;

import java.sql.Timestamp;

public class Information {
	private Long i_no;
	private String i_id;
	private String i_title;
	private String i_content;
	private Timestamp regDt;
	private Timestamp modDt;
	public Long getI_no() {
		return i_no;
	}
	public void setI_no(Long i_no) {
		this.i_no = i_no;
	}
	public String getI_id() {
		return i_id;
	}
	public void setI_id(String i_id) {
		this.i_id = i_id;
	}
	public String getI_title() {
		return i_title;
	}
	public void setI_title(String i_title) {
		this.i_title = i_title;
	}
	public String getI_content() {
		return i_content;
	}
	public void setI_content(String i_content) {
		this.i_content = i_content;
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
		return "Information [i_no=" + i_no + ", i_id=" + i_id + ", i_title=" + i_title + ", i_content=" + i_content
				+ ", regDt=" + regDt + ", modDt=" + modDt + "]";
	}
	
	
}
