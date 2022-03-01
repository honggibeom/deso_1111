package dto.notice;

import java.sql.Timestamp;

public class Notice {
	private Long n_no;
	private String n_id;
	private String n_title;
	private String n_content;
	private Boolean n_state;
	private Long n_hit;
	private Timestamp regDt;
	private Timestamp modDt;
	public Long getN_no() {
		return n_no;
	}
	public void setN_no(Long n_no) {
		this.n_no = n_no;
	}
	public String getN_id() {
		return n_id;
	}
	public void setN_id(String n_id) {
		this.n_id = n_id;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	public Boolean getN_state() {
		return n_state;
	}
	public void setN_state(Boolean n_state) {
		this.n_state = n_state;
	}
	public Long getN_hit() {
		return n_hit;
	}
	public void setN_hit(Long n_hit) {
		this.n_hit = n_hit;
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
		return "Notice [n_no=" + n_no + ", n_id=" + n_id + ", n_title=" + n_title + ", n_content=" + n_content
				+ ", n_state=" + n_state + ", n_hit=" + n_hit + ", regDt=" + regDt + ", modDt=" + modDt + "]";
	}
	
	
	
	
	
}
