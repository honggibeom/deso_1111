package dto.comment;


import java.sql.Timestamp;
import java.util.*;

public class Comment {
	private Long c_no;
	private Long c_b_no;
	private Long c_m_no;
	private String c_name;
	private String c_img;
	private String c_content;
	private Long c_group;
	private Boolean c_parentFl;
	private List<Comment> comment = new ArrayList<>();
	private Boolean c_del_fl;
	private Timestamp regDt;
	private Timestamp modDt;
	public Long getC_no() {
		return c_no;
	}
	public void setC_no(Long c_no) {
		this.c_no = c_no;
	}
	public Long getC_b_no() {
		return c_b_no;
	}
	public void setC_b_no(Long c_b_no) {
		this.c_b_no = c_b_no;
	}
	public Long getC_m_no() {
		return c_m_no;
	}
	public void setC_m_no(Long c_m_no) {
		this.c_m_no = c_m_no;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getC_img() {
		return c_img;
	}
	public void setC_img(String c_img) {
		this.c_img = c_img;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public Long getC_group() {
		return c_group;
	}
	public void setC_group(Long c_group) {
		this.c_group = c_group;
	}
	public Boolean getC_parentFl() {
		return c_parentFl;
	}
	public void setC_parentFl(Boolean c_parentFl) {
		this.c_parentFl = c_parentFl;
	}
	public List<Comment> getComment() {
		return comment;
	}
	public void setComment(List<Comment> comment) {
		this.comment = comment;
	}
	public Boolean getC_del_fl() {
		return c_del_fl;
	}
	public void setC_del_fl(Boolean c_del_fl) {
		this.c_del_fl = c_del_fl;
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
		return "Comment [c_no=" + c_no + ", c_b_no=" + c_b_no + ", c_m_no=" + c_m_no + ", c_name=" + c_name + ", c_img="
				+ c_img + ", c_content=" + c_content + ", c_group=" + c_group + ", c_parentFl=" + c_parentFl
				+ ", comment=" + comment + ", c_del_fl=" + c_del_fl + ", regDt=" + regDt + ", modDt=" + modDt + "]";
	}
	
	
	
	
}
