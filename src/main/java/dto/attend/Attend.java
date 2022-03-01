package dto.attend;

import java.sql.Timestamp;

public class Attend {
	private Long no;
	private Long b_no;
	private Long m_no;
	private String m_name;
	private String m_img;
	private Boolean kind;
	private Timestamp regDt;
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public Long getB_no() {
		return b_no;
	}
	public void setB_no(Long b_no) {
		this.b_no = b_no;
	}
	public Long getM_no() {
		return m_no;
	}
	public void setM_no(Long m_no) {
		this.m_no = m_no;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_img() {
		return m_img;
	}
	public void setM_img(String m_img) {
		this.m_img = m_img;
	}
	public Boolean getKind() {
		return kind;
	}
	public void setKind(Boolean kind) {
		this.kind = kind;
	}
	public Timestamp getRegDt() {
		return regDt;
	}
	public void setRegDt(Timestamp regDt) {
		this.regDt = regDt;
	}
	@Override
	public String toString() {
		return "Attend [no=" + no + ", b_no=" + b_no + ", m_no=" + m_no + ", m_name=" + m_name + ", m_img=" + m_img
				+ ", kind=" + kind + ", regDt=" + regDt + "]";
	}
	
	
}
