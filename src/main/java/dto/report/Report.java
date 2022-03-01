package dto.report;

import java.sql.Timestamp;

public class Report {
	private Long r_no;
	private String r_kind;
	private String r_id;
	private Long rd_id_no;
	private String rd_id;
	private Long rd_board_no;
	private String rd_board_title;
	private String r_title;
	private String r_content;
	private Boolean r_process;
	private Timestamp regDt;
	private Timestamp modDt;
	public Long getR_no() {
		return r_no;
	}
	public void setR_no(Long r_no) {
		this.r_no = r_no;
	}
	public String getR_kind() {
		return r_kind;
	}
	public void setR_kind(String r_kind) {
		this.r_kind = r_kind;
	}
	public String getR_id() {
		return r_id;
	}
	public void setR_id(String r_id) {
		this.r_id = r_id;
	}
	public Long getRd_id_no() {
		return rd_id_no;
	}
	public void setRd_id_no(Long rd_id_no) {
		this.rd_id_no = rd_id_no;
	}
	public String getRd_id() {
		return rd_id;
	}
	public void setRd_id(String rd_id) {
		this.rd_id = rd_id;
	}
	public Long getRd_board_no() {
		return rd_board_no;
	}
	public void setRd_board_no(Long rd_board_no) {
		this.rd_board_no = rd_board_no;
	}
	public String getRd_board_title() {
		return rd_board_title;
	}
	public void setRd_board_title(String rd_board_title) {
		this.rd_board_title = rd_board_title;
	}
	public String getR_title() {
		return r_title;
	}
	public void setR_title(String r_title) {
		this.r_title = r_title;
	}
	public String getR_content() {
		return r_content;
	}
	public void setR_content(String r_content) {
		this.r_content = r_content;
	}
	public Boolean getR_process() {
		return r_process;
	}
	public void setR_process(Boolean r_process) {
		this.r_process = r_process;
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
		return "Report [r_no=" + r_no + ", r_kind=" + r_kind + ", r_id=" + r_id + ", rd_id_no=" + rd_id_no + ", rd_id="
				+ rd_id + ", rd_board_no=" + rd_board_no + ", rd_board_title=" + rd_board_title + ", r_title=" + r_title
				+ ", r_content=" + r_content + ", r_process=" + r_process + ", regDt=" + regDt + ", modDt=" + modDt
				+ "]";
	}
	
	
	
	
	
}
