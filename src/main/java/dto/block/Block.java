package dto.block;

public class Block {
	private Long no;
	private Long m_no;
	private Long f_no;
	private Long b_no;
	private String img;
	private String title;
	private String b_kind;
	
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
	public Long getF_no() {
		return f_no;
	}
	public void setF_no(Long f_no) {
		this.f_no = f_no;
	}
	public Long getB_no() {
		return b_no;
	}
	public void setB_no(Long b_no) {
		this.b_no = b_no;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getB_kind() {
		return b_kind;
	}
	public void setB_kind(String b_kind) {
		this.b_kind = b_kind;
	}
	@Override
	public String toString() {
		return "Block [no=" + no + ", m_no=" + m_no + ", f_no=" + f_no + ", b_no=" + b_no + ", img=" + img + ", title="
				+ title + ", b_kind=" + b_kind + "]";
	}
	
	
	
	
}
