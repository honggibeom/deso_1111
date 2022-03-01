package dto.allim;

import java.sql.Timestamp;

public class Allim {
	private Long no;
	private Long m_no;
	private String title;
	private String content;
	private String href;
	private Boolean read;
	private Timestamp regDt;
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public Long getM_no() {
		return m_no;
	}
	public void setM_no(Long m_no) {
		this.m_no = m_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	public Boolean getRead() {
		return read;
	}
	public void setRead(Boolean read) {
		this.read = read;
	}
	public Timestamp getRegDt() {
		return regDt;
	}
	public void setRegDt(Timestamp regDt) {
		this.regDt = regDt;
	}
	@Override
	public String toString() {
		return "Allim [no=" + no + ", m_no=" + m_no + ", title=" + title + ", content=" + content + ", href=" + href
				+ ", read=" + read + ", regDt=" + regDt + "]";
	}
	
	
}
